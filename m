Return-Path: <netdev+bounces-291545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mnziIR41FWqwTgcAu9opvQ
	(envelope-from <netdev+bounces-291545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:52:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AB85D0F74
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B8053014C7C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 05:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D6C38E5C5;
	Tue, 26 May 2026 05:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="auzZ2kJG"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4A150997;
	Tue, 26 May 2026 05:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779774744; cv=none; b=Zrwuz12poSUEorkc3QxhcDXQBpZ5+uKkI0JdQcv+I5XGdpfrrjrDLMeotWKtUH8nsGdSG7SdZlwdbqLrq08tTsn4vXZhDv1rFW9IbBeYyGgiDSm81hRTw49spZ9onJ+rfZ7owtfkx/o4dnwXxGaktH3wOF08DvRlf2m7WTfUlJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779774744; c=relaxed/simple;
	bh=U6Uf8gD7jpIRXQOX34jo0SNl+xvkQ6aC8EQr/68qdQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HSEbd7095nGC74kbswmhQLnuOc/odqp5SIoyd8sq0O6tklMIp6S/tJkqAq4K0PWfjyqdhZK2gKl81Hi52KDg5zFIB6e9TjYj+Bk/7bzQD41fY8fZ8FENLOPJN51e7CF1qCkOvhOx47sH5AR+0/wFNERimeCOvXHcTCq1VWWsQBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=auzZ2kJG; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=E2
	bTdkxwgCOhmO5j4fNkWYF5jL+DpS/ehtig1jwq3Mc=; b=auzZ2kJG3zrbWI2fNP
	WvSHy+WnX0d/qJFDAAcCmtM5VBH3OwcUG6wLqc46t4OmWXLeQ96iZHanUXRdkfXP
	8Z1HmQSu+LD2rDzcCFV5T+CIC9U46cfUi05FPFUs7i9uBQNzkN1hEcKjfEG4fwYy
	xS1NgCVPzlGoz9DePetEJVgxI=
Received: from computer (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3_98BNRVqYPr3DA--.41794S4;
	Tue, 26 May 2026 13:52:02 +0800 (CST)
From: Wei Qisen <weixiansen574@163.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	avinash.duduskar@gmail.com,
	linux-kernel@vger.kernel.org,
	Wei Qisen <weixiansen574@163.com>
Subject: [PATCH v2] net: sfp: add quirk for OEM 2.5G optical modules
Date: Tue, 26 May 2026 13:52:06 +0800
Message-ID: <20260526055206.1750-1-weixiansen574@163.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_98BNRVqYPr3DA--.41794S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1UWw45tF1fCw1xJr4ruFg_yoW8Xr43pF
	W5Cwna9F93JF1Sya18AwsFkFyrWa42yFy0grWak3yruw45ua48Za4jqFyrtr1qvrs7Ga95
	KrsxGFyfArn0kF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRvD7sUUUUU=
X-CM-SenderInfo: xzhl5xpdqvv0qvxuqiywtou0bp/xtbC9wIt9GoVNQJ32wAA3I
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291545-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weixiansen574@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,163.com];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E7AB85D0F74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some OEM-branded SFP modules are incorrectly detected as
1000Base-X and fail to establish link on 2.5G-capable ports.

These modules do not properly advertise 2500Base-X capability
in their EEPROM and require forcing the correct SerDes mode.

Add sfp_quirk_2500basex for:

  - OEM SFP-2.5G-LH03-B
  - OEM SFP-2.5G-LH20-A

Both modules report:

  Vendor name: OEM
  Vendor PN: SFP-2.5G-LH03-B / SFP-2.5G-LH20-A

Tested on OpenWrt with successful 2.5G link establishment.

Signed-off-by: Wei Qisen <weixiansen574@163.com>

---

v2:
 - Use a proper real name in Signed-off-by
 - Sort quirk entries alphabetically
---
 drivers/net/phy/sfp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index bd970f753..7a865f69a 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -583,6 +583,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
 	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
+	SFP_QUIRK_S("OEM", "SFP-2.5G-LH03-B", sfp_quirk_2500basex),
+	SFP_QUIRK_S("OEM", "SFP-2.5G-LH20-A", sfp_quirk_2500basex),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
-- 
2.54.0.windows.1


