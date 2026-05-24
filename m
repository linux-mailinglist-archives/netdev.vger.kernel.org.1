Return-Path: <netdev+bounces-291183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAhNB2r7Empj5wYAu9opvQ
	(envelope-from <netdev+bounces-291183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 15:21:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7757C5C28B6
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 15:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5240300A746
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 13:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B6839732C;
	Sun, 24 May 2026 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZT7Uli7R"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC2D3955C2;
	Sun, 24 May 2026 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779628880; cv=none; b=f95S/iNGoOUJEHwBMZlxLdYjs/zonAEh1D4o1vmR58Ddlew4Tu7pyKlDehr+rczuOeJJQdchoiF1dtm//mVSa5Ilo9hUpNf0ESjtloyfrTBuUME3f+c4Uzbf0LmPusMCgZEHI6ig+CTRcdwqk8uPj98rgJC9k5R772sXnvl2e8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779628880; c=relaxed/simple;
	bh=U6Uf8gD7jpIRXQOX34jo0SNl+xvkQ6aC8EQr/68qdQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8DsdJRbLu7Cr0hsGIQM+1awOk7mjUn25HFxcWUdWNbd4Z5VIAMg+ltT20RZJ7Blsu3fssMKbLMQJJCzjUX3WJSBNLMKcLSrWmp6uN3n6nYUUxXb6AapWLkuEa3ukGh6Mxk5jvqludFDEDd1CkRvYcVXaKipeI2ViIMmYIuY5o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZT7Uli7R; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=E2
	bTdkxwgCOhmO5j4fNkWYF5jL+DpS/ehtig1jwq3Mc=; b=ZT7Uli7RhFX+B7Mu9N
	iReEt/IZP0NqTC77fXCRNOodJuYlNB14wGLf2lzyCjgmjcVXQlqyapV4+ce6//Kt
	oXK3sEe7Dr+rg1iFptyc6c1gDqfgb6u61haVA7yrYeZVV2jLcnyRfNzd3FMqPLM7
	mj9jcRSGqRfKrFFqrnTv5aSu0=
Received: from computer (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wA372Ax+xJqDI6KDA--.707S4;
	Sun, 24 May 2026 21:20:49 +0800 (CST)
From: Wei Qisen <weixiansen574@163.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	avinash.duduskar@gmail.com,
	linux-kernel@vger.kernel.org,
	Wei Qisen <weixiansen574@163.com>
Subject: [PATCH v2] net: sfp: add quirk for OEM 2.5G optical modules
Date: Sun, 24 May 2026 21:20:27 +0800
Message-ID: <20260524132027.1550-1-weixiansen574@163.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260520151629.905-1-weixiansen574@163.com>
References: <20260520151629.905-1-weixiansen574@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA372Ax+xJqDI6KDA--.707S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1UWw45tF1fCw1xJr4ruFg_yoW8Xr43pF
	W5Cwna9F93JF1Sya18AwsFkFyrWa42yFy0grWak3yruw45ua48Za4jqFyrtr1qvrs7Ga95
	KrsxGFyfArn0kF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRvD7sUUUUU=
X-CM-SenderInfo: xzhl5xpdqvv0qvxuqiywtou0bp/xtbC3BIq8WoS+zJLrQAA3C
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TAGGED_FROM(0.00)[bounces-291183-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,163.com];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	FROM_NEQ_ENVFROM(0.00)[weixiansen574@163.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7757C5C28B6
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


