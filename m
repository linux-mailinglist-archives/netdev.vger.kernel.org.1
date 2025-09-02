Return-Path: <netdev+bounces-219062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE749B3F982
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793D84E196D
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5BA2EA49D;
	Tue,  2 Sep 2025 09:02:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B419B2EA15B;
	Tue,  2 Sep 2025 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803748; cv=none; b=AQoBYycr31m95JUiVH+lQohOdJiXMVarzzv1mOQcnqLQLxQ4uQfyCjdifNG9I15eVbfOdrpBaxTSBl2ZLT/QDGXls8ZVrOz2bVpC0sJcLG2MVSshSW5nxQt/XQD51RLoCKJ21m1NF/BAtKWZ7Lri3hQA9JHMYuCwlGw1ncuW39E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803748; c=relaxed/simple;
	bh=nqXYIcCLVEvwlm470tHgTXgM1l86YTqL6LD6ikaFPh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2CehhHbumyC97c8NDdC+DTVKPxiNrBgox7oToqif50m9lpdMG5Irs543m3dPN7GKYRPoQmvM2z0WXhEruvT0e7vOgN7QbPkCC4KAxuJXi82/KsSuDrCNPZl63KEphB3AY9cO8p+sGdPFJxucLRtnXIt9PkYMKgsofqI1av1Wpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201610.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202509021702111607;
        Tue, 02 Sep 2025 17:02:11 +0800
Received: from localhost.localdomain.com (10.94.12.93) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.57; Tue, 2 Sep 2025 17:02:10 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: <horms@kernel.org>, Antonio Quartulli <antonio@openvpn.net>, Sabrina
 Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, chuguangqing
	<chuguangqing@inspur.com>
Subject: [PATCH v2 1/1] ovpn: use kmalloc_array() for array space allocation
Date: Tue, 2 Sep 2025 17:00:51 +0800
Message-ID: <20250902090051.1451-2-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250902090051.1451-1-chuguangqing@inspur.com>
References: <20250901112136.2919-1-chuguangqing@inspur.com>
 <20250902090051.1451-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025902170211c59a6c2fcb8a334e1ed1cddd8932d453
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Replace kmalloc(size * sizeof) with kmalloc_array() for safer memory
allocation and overflow prevention.

Signed-off-by: chuguangqing <chuguangqing@inspur.com>
---
 drivers/net/ovpn/crypto_aead.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 2cca759feffa..da0ce4f348e6 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -72,8 +72,9 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		return -ENOSPC;
 
 	/* sg may be required by async crypto */
-	ovpn_skb_cb(skb)->sg = kmalloc(sizeof(*ovpn_skb_cb(skb)->sg) *
-				       (nfrags + 2), GFP_ATOMIC);
+	ovpn_skb_cb(skb)->sg = kmalloc_array(nfrags + 2,
+					     sizeof(*ovpn_skb_cb(skb)->sg),
+					     GFP_ATOMIC);
 	if (unlikely(!ovpn_skb_cb(skb)->sg))
 		return -ENOMEM;
 
@@ -185,8 +186,9 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 		return -ENOSPC;
 
 	/* sg may be required by async crypto */
-	ovpn_skb_cb(skb)->sg = kmalloc(sizeof(*ovpn_skb_cb(skb)->sg) *
-				       (nfrags + 2), GFP_ATOMIC);
+	ovpn_skb_cb(skb)->sg = kmalloc_array(nfrags + 2,
+					     sizeof(*ovpn_skb_cb(skb)->sg),
+					     GFP_ATOMIC);
 	if (unlikely(!ovpn_skb_cb(skb)->sg))
 		return -ENOMEM;
 
-- 
2.43.5


