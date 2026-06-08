Return-Path: <netdev+bounces-296460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UYFxKoyVJmpxZAIAu9opvQ
	(envelope-from <netdev+bounces-296460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:12:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E33654E56
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:12:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=runbox.com header.s=selector1 header.b="XJEdA+ 6";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296460-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296460-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60483304CE76
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 10:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B633D669C;
	Mon,  8 Jun 2026 09:56:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372703D3332;
	Mon,  8 Jun 2026 09:55:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912560; cv=none; b=BdENdzLwGL4SSLXNSqb6cMg20FEUiBNlauWuAwzdQ61MaTHizsxCK7MEARJEuLUqNpbIWVy5FnlOdf/XpUMWHrlE3CvYLS9xVsJakxECCJHVBWFrQgZcPc5u6Q4mMHD3201mYB10AntfXBMvuegxExcpZ1Q4vDJJDdIGs290Yoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912560; c=relaxed/simple;
	bh=rRMG2vuq12hFBjsTJqEu7ppDeFJeqY/J0McyArkok+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OmnRpvWVJvQdn0bYTquSPkG+nj4xIa9ZwyU3fWz/GY5ZYvYvWOPMEQmkWcglH+O2lx7+ERPWq+BSsDN47MuCARAcvgDXvaVoDxdzHJXaf35pLWmE1anXq+1woX4lecDxeSXfV5nFaobckGg3JxHbkRS+JqFwYMW/9vmaV8mExaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=XJEdA+6B; arc=none smtp.client-ip=185.226.149.37
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWi4-00BS6k-BO; Mon, 08 Jun 2026 11:55:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=OQIEcgVq7NOd4JbQ00khnJw1hkKI1O/HpLwNwh7rtvM=; b=XJEdA+
	6BTl+Rv46D1xxPAR4/IVtdeWdl4DyeOoBiIQPraGm74ifHPlcrt7uCWYbnSG2gi9u0CdMgLLkJan7
	4qSlrtiixwRQo5qUeeIxf7XvcuHojxIBTDzRUnwvGaVwl72bjHjbXKow567NrVs3un5CTXpMP5Jxb
	IYxI+J0F5JxPJOP3zw2Kx09quCIbRZyxufwNW14i8DoSvYH1zNhQbgInd7wkME6yUMcT2kAHeAeKv
	p+Zn1CbvKP7U9A8PdiaqnummDad4aOeyd8vxucZpp1r+/JjawDHixGDvmXuzfaHqZd7CV1Ts3XWDU
	F+i1MBF/n0LvZRCyqdNVkEAHUKNg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWi4-0000L2-1u; Mon, 08 Jun 2026 11:55:56 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhl-00Ag6G-JZ;
	Mon, 08 Jun 2026 11:55:37 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Timur Tabi <timur@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] drivers/net/ethernet/qualcomm/emac: Use strscpy() to copy the ethtool strings
Date: Mon,  8 Jun 2026 10:55:14 +0100
Message-Id: <20260608095523.2606-30-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector1];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296460-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:arnd@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:timur@kernel.org,m:david.laight.linux@gmail.com,m:andrew@lunn.ch,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[runbox.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,runbox.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47E33654E56

From: David Laight <david.laight.linux@gmail.com>

While the string is short it is still best to use strscpy()
with length ETH_GSTRING_LEN.
Should still get optimised to a memcpy().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/net/ethernet/qualcomm/emac/emac-ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c b/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
index f502db9cdea9..ffc300641aac 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-ethtool.c
@@ -95,7 +95,7 @@ static void emac_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_PRIV_FLAGS:
-		strcpy(data, "single-pause-mode");
+		strscpy(data, "single-pause-mode", ETH_GSTRING_LEN);
 		break;
 
 	case ETH_SS_STATS:
-- 
2.39.5


