Return-Path: <netdev+bounces-284586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBtmNCNn+mnwOgMAu9opvQ
	(envelope-from <netdev+bounces-284586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 23:54:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FDF4D41D3
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 23:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05FCB303CE0A
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 21:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638184968EF;
	Tue,  5 May 2026 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vyj40QMh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D8481ABB
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778017943; cv=none; b=Cr+5UTtX7krus18yQbMpM6qdav1kyxfejPOPgAnTSUq17BnkCFMVqL0sVstCD7tcjk0u9NghsrNDnUyo8F8ZPif3W6npfXp7maDHnUzA9U9ManIRAmxm7Lzi/56TuQHiAbqVrpsSGt9DVrFDfQR/vE23r6YRwpy5ZPRn3XrR2E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778017943; c=relaxed/simple;
	bh=+axkliXrHWut/deJA8EkfHrp0yZLReYtKBFRigbLuKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ptGKvL23BrBjUt2LGe3qPyEQFDfndu53iLU/PUbr6ITOfurp6pLKlI7sdXlajctlQddLbv9pBGQ+9uTTxRLseVcAG/qDu9LpmYklBnPoFHwUNVB1MH3UpKsEPb38eqBV09ITBIjqBEGexQBwEbiK/FIQu0MynIQmx+swRMST0e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vyj40QMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD53C2BCB9;
	Tue,  5 May 2026 21:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778017942;
	bh=+axkliXrHWut/deJA8EkfHrp0yZLReYtKBFRigbLuKw=;
	h=From:Date:Subject:To:Cc:From;
	b=Vyj40QMh9Zj6UxpB7Crvd6DTuGAmwqfoKroMuaN6zb954PdV8sXdlqzFu52JGic6r
	 rUY8uyTQVXvJ6nL+aldUxfiX/b9WDbhAajT+CNvF1m5s36Q61M1RxNY55L0uZz8BPi
	 U50uME9h/LaWDFt+Sb8JZHR/UrwVlNK84SF02wiMuFPTs02WMvoQAyFzw5LI50aVkJ
	 Lyevbal3xAF70nHPJBIzBjNE1R71MnSSjT6veFiYNCwDhzchjqIh3s8ou9HD+gS5XS
	 5YHtddBeA2yULApvppvgNEjH4tGl3ov93cflsCpbUy9rTO0ufvv6lBg/X55I0wF47l
	 wpWrjN5hZ0sDw==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 05 May 2026 23:52:17 +0200
Subject: [PATCH net v2] net: ethernet: cortina: Drop half-assembled SKB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260505-gemini-ethernet-fix-v2-1-997c31d06079@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/31NSw7CIBC9SjNrMXza2rjyHqYLAiOdqGCgIZqmd
 3fkAOat3n+DgpmwwLnbIGOlQiky0YcO3GJjQEGeOWipR2mMFAGfFEngumCOuIobvcUoe6cnNxh
 vFXDzlZHltnoFDsHM4kJlTfnTnqpq1t/RqgRjOk3G9oNXxl7uP/NxTDnAvO/7F0DchXe8AAAA
X-Change-ID: 20260330-gemini-ethernet-fix-604c28c53da1
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Li Xiasong <lixiasong1@huawei.com>
Cc: netdev@vger.kernel.org, 
 Andreas Haarmann-Thiemann <eitschman@nebelreich.de>, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 50FDF4D41D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284586-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[googlemail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,rere.qmqm.pl,huawei.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nebelreich.de:email]

From: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>

In gmac_rx() (drivers/net/ethernet/cortina/gemini.c), when
gmac_get_queue_page() returns NULL for the second page of a multi-page
fragment, the driver logs an error and continues — but does not free the
partially assembled skb that was being assembled via napi_build_skb() /
napi_get_frags().

Free the in-progress partially assembled skb via napi_free_frags()
and increase the number of dropped frames appropriately
and assign the skb pointer NULL to make sure it is not lingering
around, matching the pattern already used elsewhere in the driver.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v2:
- Fix up the commit message so it is clear what the patch is doing.
- Also increase the number of dropped frames as noted by Li Xiasong.
- Link to v1: https://lore.kernel.org/r/20260330-gemini-ethernet-fix-v1-1-18783a45d13a@kernel.org
---
 drivers/net/ethernet/cortina/gemini.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 4824232f4890..065cbbf52686 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1491,6 +1491,11 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 		gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
 		if (!gpage) {
 			dev_err(geth->dev, "could not find mapping\n");
+			if (skb) {
+				napi_free_frags(&port->napi);
+				port->stats.rx_dropped++;
+				skb = NULL;
+			}
 			continue;
 		}
 		page = gpage->page;

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260330-gemini-ethernet-fix-604c28c53da1

Best regards,
--  
Linus Walleij <linusw@kernel.org>


