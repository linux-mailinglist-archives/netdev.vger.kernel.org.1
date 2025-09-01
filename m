Return-Path: <netdev+bounces-218722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22667B3E165
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BAC37ABDEC
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD142FB630;
	Mon,  1 Sep 2025 11:23:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4D235355;
	Mon,  1 Sep 2025 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756725789; cv=none; b=ofFHKIxqtD4CxBcWMt0m3oU9ibBMrmJx3Y1vh5XNabrf8mDz63ZMsGd5/ArvIEwaobOnLz2hiI/V5Mv3Pxj6q1j1P496H98gvJ1g+XeSTRtTEUoqKnjsKyCCEK52vLJN/omnIAJ+WzF1koLzWZfMVqOK39dazvdTtPqDfXDQ0pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756725789; c=relaxed/simple;
	bh=BbWnut3fpMCcERqKPzPskf113jloBIZbJ6KonBPomwg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SOnzvPN7knoalbQRPapVj0RSKQyR70yJmmawnY3d4PZuq4JcBFV7IuoBP4lfdoSMEcMgO7ECYIMXHCs1VbY9EEe4TBbYmcMG3Ns5cGc+vX9g/x5no8wev7d/3xAxAD0GZNQGGZZTWckYJzvfHCw2BcDJzVu0TH6gNzFfVr5hcqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201610.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202509011922541034;
        Mon, 01 Sep 2025 19:22:54 +0800
Received: from localhost.localdomain.com (10.94.9.187) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.57; Mon, 1 Sep 2025 19:22:54 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Antonio Quartulli <antonio@openvpn.net>, Sabrina Dubroca
	<sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: [PATCH 1/1] ovpn: use kmalloc_array() for array space allocation
Date: Mon, 1 Sep 2025 19:21:36 +0800
Message-ID: <20250901112136.2919-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20259011922547e835180fafd4e7d2cb5da0108075dec
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Replace kmalloc(size * sizeof) with kmalloc_array() for safer memory
allocation and overflow prevention.

Signed-off-by: chuguangqing <chuguangqing@inspur.com>
---
 drivers/net/ovpn/crypto_aead.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 2cca759feffa..8274c3ae8d0b 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -72,8 +72,8 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		return -ENOSPC;
 
 	/* sg may be required by async crypto */
-	ovpn_skb_cb(skb)->sg = kmalloc(sizeof(*ovpn_skb_cb(skb)->sg) *
-				       (nfrags + 2), GFP_ATOMIC);
+	ovpn_skb_cb(skb)->sg = kmalloc_array((nfrags + 2), sizeof(*ovpn_skb_cb(skb)->sg),
+					     GFP_ATOMIC);
 	if (unlikely(!ovpn_skb_cb(skb)->sg))
 		return -ENOMEM;
 
@@ -185,8 +185,8 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		return -ENOSPC;
 
 	/* sg may be required by async crypto */
-	ovpn_skb_cb(skb)->sg = kmalloc(sizeof(*ovpn_skb_cb(skb)->sg) *
-				       (nfrags + 2), GFP_ATOMIC);
+	ovpn_skb_cb(skb)->sg = kmalloc_array((nfrags + 2), sizeof(*ovpn_skb_cb(skb)->sg),
+					     GFP_ATOMIC);
 	if (unlikely(!ovpn_skb_cb(skb)->sg))
 		return -ENOMEM;
 
-- 
2.43.5


