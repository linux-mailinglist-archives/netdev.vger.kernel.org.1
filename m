Return-Path: <netdev+bounces-210406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36500B13206
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 23:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52AE03A4C53
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 21:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8501124679F;
	Sun, 27 Jul 2025 21:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="gL1iJhyE"
X-Original-To: netdev@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3362A217F34
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753653105; cv=none; b=K8TYbLHjbhxz9L87ExhLzVs/me0AGBrdh3JleIy+7pcLZLXkSADeW8VoC5R8N9fjpXhdrVcHlWMCyf/YfPW5XFnXYoZHX2yG1l2JBHm38iyniMuFNgyeyzQjKmKCEi3o8EHg0F9L3TU0OfGFLSSAf1PCBnHUdrxAR9WPA4EwDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753653105; c=relaxed/simple;
	bh=Z+7M3dHUUYqhuhN82CQks401UX1vkdxI7Mq7JQeJuHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gT08dI/qzPwTOHoqmNi2c3v4w0EhYzFba6a5c/miPWg64KMsNZRLvo1HTe4GE/cLwzrm6wNKs2jBtnIfBPvMkhGj21z6NBJnx25fAP/PeZ56xnuVQCbYrnIuZuJ6zcBYuYkzGIVZqEOnMNRB0EjQqdRJ4ZyIr6nrPchLvUM4sWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=gL1iJhyE; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 8A6FB240027
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 23:51:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.ea087b; t=1753653101;
	bh=l4D4Bh+YmUuggbXuJRHB8wMKe3auffo6UFPEjkwE9v8=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=gL1iJhyEz3BCszUs9rEfcOGLo96LOmnXWMbFEJTJgr4X4nbFQ7FGSz9QxBBXRoUa+
	 7LZGYtp6YfE/gNkPQs0EFg7vzQi1VZ5ngidJY5JMGLRfVBl6AnguUQZSA7euuDW4Pv
	 QPbk4bH7OunkUxs6Ld7XYZ4ZJ7lTifsUqdto3mxPgmvyswS51yrCMTxYnC+DibwTtH
	 MYT8CAatI5uWXX5D+hErp6cQs2n++/eddSV37AOoE/zT+ALkF79e/BkRpnIhii5qct
	 zELdPMI177rJJoysPgl9D8zUiNv5i2Jo8ZLAh1+xLszettsRfbPe5AH4mqmhP++mT3
	 sMLpZO7b+M6MKs4Ox/GSi0yFLGHYK21cf7wyoXJm9ZEo+MgGzeb+P5AxQiSDTgHZoF
	 M4yIjTsuL/3RoaJhSn0SWP9lbbaZjuvw1uFLrbBeq+MAZxSG8aXkCTCeJUM9glHPqJ
	 Hz1iJrvPS6FPjcqi/G1qBiyXNipsMW178Sh1vv4arWUOTOJI9zN
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bqwL42mnnz6v10;
	Sun, 27 Jul 2025 23:51:40 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
Date: Sun, 27 Jul 2025 21:51:40 +0000
Subject: [PATCH net v2] net: ipv6: fix buffer overflow in AH output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-ah6-buffer-overflow-v2-1-c7b5f0984565@posteo.net>
X-B4-Tracking: v=1; b=H4sIAFyfhmgC/32NQQ7CIBBFr9LM2jGFptK68h6mC7AzQmJKA4iah
 ruLPYD5q/eT//4GkYKjCOdmg0DZReeXCvLQwM3q5U7o5sogW9m3SirU9oTmyUwBfabAD/9CZjX
 2ZlDdOMxQl2sgdu/dep0qWxeTD5/9JItf+9+XBdZwR0Kwrk5zWX1M5I8LJZhKKV/3reRgtwAAA
 A==
X-Change-ID: 20250727-ah6-buffer-overflow-ff795b87398d
To: Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com, 
 Charalampos Mitrodimas <charmitro@posteo.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753653100; l=2871;
 i=charmitro@posteo.net; s=20250727; h=from:subject:message-id;
 bh=Z+7M3dHUUYqhuhN82CQks401UX1vkdxI7Mq7JQeJuHo=;
 b=Rp1FTXTDgVtjNTXyak24zpZA1Sn+gI8Zs1/rfUXYxPw4vCJsV5EH2mlWu8GLcCYt2RtmX90ha
 J7iHX7c6mPoCnG7Z1LrBcusYz8kDh49gZzgn4PxDgpH4LA83SAYzI/t
X-Developer-Key: i=charmitro@posteo.net; a=ed25519;
 pk=/tpM70o3uGkbo2oePEdVimUYLyVTgpnPq4nwoG0pFsM=

Fix a buffer overflow where extension headers are incorrectly copied
to the IPv6 address fields, resulting in a field-spanning write of up
to 40 bytes into a 16-byte field (IPv6 address).

  memcpy: detected field-spanning write (size 40) of single field "&top_iph->saddr" at net/ipv6/ah6.c:439 (size 16)
  WARNING: CPU: 0 PID: 8838 at net/ipv6/ah6.c:439 ah6_output+0xe7e/0x14e0 net/ipv6/ah6.c:439

The issue occurs in ah6_output() and ah6_output_done() where the code
attempts to save/restore extension headers by copying them to/from the
IPv6 source/destination address fields based on the CONFIG_IPV6_MIP6
setting.

Reported-by: syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=01b0667934cdceb4451c
Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
Changes in v2:
- Link correct syzbot dashboard link in patch tags
- Link to v1: https://lore.kernel.org/r/20250727-ah6-buffer-overflow-v1-1-1f3e11fa98db@posteo.net
---
 net/ipv6/ah6.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index eb474f0987ae016b9d800e9f83d70d73171b21d2..0fa3ed3c64c4ed1a1907d73fb3477e11ef0bd5b8 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -301,13 +301,8 @@ static void ah6_output_done(void *data, int err)
 	memcpy(ah->auth_data, icv, ahp->icv_trunc_len);
 	memcpy(top_iph, iph_base, IPV6HDR_BASELEN);
 
-	if (extlen) {
-#if IS_ENABLED(CONFIG_IPV6_MIP6)
-		memcpy(&top_iph->saddr, iph_ext, extlen);
-#else
-		memcpy(&top_iph->daddr, iph_ext, extlen);
-#endif
-	}
+	if (extlen)
+		memcpy((u8 *)(top_iph + 1), iph_ext, extlen);
 
 	kfree(AH_SKB_CB(skb)->tmp);
 	xfrm_output_resume(skb->sk, skb, err);
@@ -379,11 +374,7 @@ static int ah6_output(struct xfrm_state *x, struct sk_buff *skb)
 	memcpy(iph_base, top_iph, IPV6HDR_BASELEN);
 
 	if (extlen) {
-#if IS_ENABLED(CONFIG_IPV6_MIP6)
-		memcpy(iph_ext, &top_iph->saddr, extlen);
-#else
-		memcpy(iph_ext, &top_iph->daddr, extlen);
-#endif
+		memcpy(iph_ext, (u8 *)(top_iph + 1), extlen);
 		err = ipv6_clear_mutable_options(top_iph,
 						 extlen - sizeof(*iph_ext) +
 						 sizeof(*top_iph),
@@ -434,13 +425,8 @@ static int ah6_output(struct xfrm_state *x, struct sk_buff *skb)
 	memcpy(ah->auth_data, icv, ahp->icv_trunc_len);
 	memcpy(top_iph, iph_base, IPV6HDR_BASELEN);
 
-	if (extlen) {
-#if IS_ENABLED(CONFIG_IPV6_MIP6)
-		memcpy(&top_iph->saddr, iph_ext, extlen);
-#else
-		memcpy(&top_iph->daddr, iph_ext, extlen);
-#endif
-	}
+	if (extlen)
+		memcpy((u8 *)(top_iph + 1), iph_ext, extlen);
 
 out_free:
 	kfree(iph_base);

---
base-commit: b711733e89a3f84c8e1e56e2328f9a0fa5facc7c
change-id: 20250727-ah6-buffer-overflow-ff795b87398d

Best regards,
-- 
Charalampos Mitrodimas <charmitro@posteo.net>


