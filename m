Return-Path: <netdev+bounces-210405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98FBB13203
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 23:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34E51733B1
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 21:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13558635D;
	Sun, 27 Jul 2025 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="kFFP/7as"
X-Original-To: netdev@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7358B374C4
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 21:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753652920; cv=none; b=QCexmqF2BJKdgo16mBJi8O4dXUCZqGvpRvCA8YnxGJ1H/IgNKMy1gcxy/94P/2Wb95bb8nVmAfwBKupT3LWaDslmZV6xquqT/+WyvcGZBYtIe4mybZEuX4ytSJBzVIJX0bFomECjqH+zRrVYCXhk0gfpRR8HZjXfcAydGXgYx9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753652920; c=relaxed/simple;
	bh=X7NNiCkMo0t/qj0n4SYQ4dobviICYRXgR8gv1Qf8+2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dcn7kzVJBeGBL65ZOUOUpgHNbsIpVjbB1a3RVnEd4nD6eek/8AKomfy3xwEAkW3or320HxT9faVpcEXMrxwYjXZejzmnMTu1VB8q7J5sskpMsQLS432j3rcms73isYDstDRcOavll2/2I/fs9xsXUGhl+K2C2v3H067jm1vWKmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=kFFP/7as; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 8A82F240105
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 23:48:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.ea087b; t=1753652916;
	bh=dYyr5MXYpC7S0d8VICgIlmAgVK9AKOLRW8fx+iRx75A=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=kFFP/7as8ZWVA26gpERRceEGMhCf4GKtoV6jNFu7EFy0+GTLEfUVVSzY7sIcRZOle
	 Bp1ZQ7oiaHILlz5OhbPa2VUkzwrGat93nLNTpSEENYYSdL417EgEybjJjbuGy8zczl
	 5BfWsqw56SXNjMdIoNP1tbKJTHUOnXqb5ZdqFKq39/PQoepJqVTO1A4CH++neqCpzP
	 Mg1HNq9Gyopq7s4KSJOofR/lLQcoaGMQrfkwZ5c3RMMSzJemLyW+4HLC1vOC/8qsrr
	 sRXVIf58lyS8HFBTiU0heRdB4CBXzFHM+49I39wljVssAaZDKhozQlIul8EZAGvkIr
	 xqokx+2GCKjoCUFWIeGzlfWSCb07sPWhe2MlljsEAJCSqKZIgqSYhgwjhqj1w6FKba
	 CwdqvbxJ90f7p8m3ojk40BeGd/gmMSuxA/PR+tVxJMQ9mmlBpsrHGUttuA5nDNNGYu
	 gGN+tiNcGvjWpsJPKlyH6NRBG+MPzXMeFv5OIyQyumaMfQ03DHK
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bqwGV2gr4z6tvq;
	Sun, 27 Jul 2025 23:48:34 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
Date: Sun, 27 Jul 2025 21:48:35 +0000
Subject: [PATCH net] net: ipv6: fix buffer overflow in AH output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-ah6-buffer-overflow-v1-1-1f3e11fa98db@posteo.net>
X-B4-Tracking: v=1; b=H4sIAGSehmgC/x3M3QpAQBBA4VfRXJtixeJV5MLPDFOyms1S8u42l
 9/FOQ94UiEPbfKAUhAvbo/I0wSmddgXQpmjwWSmzKyxOKwVjiczKbpAypu7kNk25VjboqlniOW
 hxHL/165/3w99zDMpZQAAAA==
X-Change-ID: 20250727-ah6-buffer-overflow-ff795b87398d
To: Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com, 
 Charalampos Mitrodimas <charmitro@posteo.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753652914; l=2699;
 i=charmitro@posteo.net; s=20250727; h=from:subject:message-id;
 bh=X7NNiCkMo0t/qj0n4SYQ4dobviICYRXgR8gv1Qf8+2I=;
 b=vDMo15oGewMWDoeNA+4eSqQISLRp+TUwqHO8juX2+DyeMXs/Ez4eumJKiiPaEDZsGNV4/4E2B
 KQg4+WwD3FtA9NYu2LoWPdAT5dPq80w7W/jzC/g93HOvmA/PspRQjeW
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
Closes: https://syzkaller.appspot.com/bug?extid=b4169a1cfb945d2ed0ec
Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
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


