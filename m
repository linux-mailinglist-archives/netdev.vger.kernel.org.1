Return-Path: <netdev+bounces-212995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480E9B22C38
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17DF67B6DD6
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17C223D7C0;
	Tue, 12 Aug 2025 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="Bp4m9wYF"
X-Original-To: netdev@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2D82F8BFF
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013895; cv=none; b=KdS+PP75O870kp4jJcr4h4UP62n2uocJ9+TyEwQbcIl9Tjr56TgSJs0zcnh/NvPk+GKDLRGkE1RVMFFSfqKKBby1VeCzFvrpKEj3BJ8JBSVY8LnBHHwknYRX7/Lbq/75gxNZkwQ+DdN1Nw9Ls325NSdEuPS4MwfeDwx2agrz5gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013895; c=relaxed/simple;
	bh=+j0zzxhPVwlgjTlb804TTONizmrPgm3FQOsvT7djAMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Fab8upKd9lwh/TjNH4QrP2JqqynM/m1Lu5imtuk21DCQe8rNEIuP1eKg3z2rQ2QBWMbG20G7iY8rzyik5B43egjzhEeYGgjp6KpdnEXctwtdrkDP85+D4AkBkeHVHmJfshPuSzJWyr0XLeUsVTK+W5MQw2KJNfS5NHRvto5AJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=Bp4m9wYF; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 18795240027
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:51:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.ea087b; t=1755013886;
	bh=104jti+MUtL7+UbfGQ8sAg6tEB2ED0oBZBAHpg3YO30=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=Bp4m9wYFXrIcIwHZORm3jiwbSUZmAxGdyqc/8tgGWvydCfz3/9rqUeyH0OQXfUmxy
	 F4Rm8Ca+/xv1j5yXPmKcq/P3v/66EY3B+h7CkdjHBhy2iuQovXcmI3kuZZnK2bEvHe
	 qyZu1ELrhMg4O2IzAldARLLJVEeyK6h7hdZ+jE/na0wsSM7NezXfAqVIk5JTjHU1nh
	 hrjk2k1TwDRQt4aWt1ouwQ2H0ZDJ3ggwFgFJfOlFxaUnowVgh5hDQPNEvGtYkKh1Z8
	 yjEh6le0x6KGizQUyzBRkpOblwuoa3iGmYTga+7PG/rciYSpUjkWTgeOy1m6CgdB0F
	 Wm7phD8+/F7Tv2yn21qCDCQ77Mku4/JoEvauu3JSDOhF8161d/FrLvLRxNW7wP5e8E
	 x/o/j8/+QAOC+YTMSeiskv4EMii3NPgHnC+14LK93cnO8hRjnU/g63w3vfsYWpIGrE
	 9S4cyQ17X1R8ZOyrYb6An4POTvKS7jloZ68dPGAcNAkiyn4zhn6
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4c1bZz5CqBz9rxM;
	Tue, 12 Aug 2025 17:51:23 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
Date: Tue, 12 Aug 2025 15:51:25 +0000
Subject: [PATCH ipsec-next v3] net: ipv6: fix field-spanning memcpy warning
 in AH output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-ah6-buffer-overflow-v3-1-446d4340c86f@posteo.net>
X-B4-Tracking: v=1; b=H4sIAPFim2gC/43NwQ6CMAyA4VchPTvDhmPAyfcwHhi0ssQwsuHUE
 N7dws2LMT39Tfp1gYjBYYQmWyBgctH5kaM4ZNAN7XhD4XpuULnSuVFGtEMp7IMIg/AJA939UxC
 ZWtvKFHXVA19OAcm9dvVy5R5cnH1470+S3La/vSQFDxUoJbVs2vPk44z+OOIMG5jUH4hipDNWU
 15XJ13qL2Rd1w9knWG4/AAAAA==
X-Change-ID: 20250727-ah6-buffer-overflow-ff795b87398d
To: Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com, 
 Charalampos Mitrodimas <charmitro@posteo.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755013883; l=4422;
 i=charmitro@posteo.net; s=20250727; h=from:subject:message-id;
 bh=+j0zzxhPVwlgjTlb804TTONizmrPgm3FQOsvT7djAMA=;
 b=LlxlKEAg52bMp+olBDuDK25xsn337t/l0d2b8aNtZmu7Clh66SuXvgwiC7unTRhsgyZ2STQ25
 nKdSBNokX1fDkh9AJT/mpZecIM7BsYwfqO4CJVzNG143xOIkcCR16Eo
X-Developer-Key: i=charmitro@posteo.net; a=ed25519;
 pk=/tpM70o3uGkbo2oePEdVimUYLyVTgpnPq4nwoG0pFsM=

Fix field-spanning memcpy warnings in ah6_output() and
ah6_output_done() where extension headers are copied to/from IPv6
address fields, triggering fortify-string warnings about writes beyond
the 16-byte address fields.

  memcpy: detected field-spanning write (size 40) of single field "&top_iph->saddr" at net/ipv6/ah6.c:439 (size 16)
  WARNING: CPU: 0 PID: 8838 at net/ipv6/ah6.c:439 ah6_output+0xe7e/0x14e0 net/ipv6/ah6.c:439

The warnings are false positives as the extension headers are
intentionally placed after the IPv6 header in memory. Fix by properly
copying addresses and extension headers separately, and introduce
helper functions to avoid code duplication.

Reported-by: syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=01b0667934cdceb4451c
Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
Changes in v3:
- Properly separate address and extension header copying
- Add helper functions ah6_save_hdrs() and ah6_restore_hdrs() to avoid code duplication
- Update commit message to clarify this fixes a false positive warning, not a buffer overflow
- Target ipsec-next instead of net as this is a cleanup
- Remove unnecessary cast from memcpy() call
- Link to v2: https://lore.kernel.org/r/20250727-ah6-buffer-overflow-v2-1-c7b5f0984565@posteo.net

Changes in v2:
- Link correct syzbot dashboard link in patch tags
- Link to v1: https://lore.kernel.org/r/20250727-ah6-buffer-overflow-v1-1-1f3e11fa98db@posteo.net
---
 net/ipv6/ah6.c | 50 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index eb474f0987ae016b9d800e9f83d70d73171b21d2..95372e0f1d216b2408313229f94a1b572afcabd4 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -46,6 +46,34 @@ struct ah_skb_cb {
 
 #define AH_SKB_CB(__skb) ((struct ah_skb_cb *)&((__skb)->cb[0]))
 
+/* Helper to save IPv6 addresses and extension headers to temporary storage */
+static inline void ah6_save_hdrs(struct tmp_ext *iph_ext,
+				 struct ipv6hdr *top_iph, int extlen)
+{
+	if (!extlen)
+		return;
+
+#if IS_ENABLED(CONFIG_IPV6_MIP6)
+	iph_ext->saddr = top_iph->saddr;
+#endif
+	iph_ext->daddr = top_iph->daddr;
+	memcpy(&iph_ext->hdrs, top_iph + 1, extlen - sizeof(*iph_ext));
+}
+
+/* Helper to restore IPv6 addresses and extension headers from temporary storage */
+static inline void ah6_restore_hdrs(struct ipv6hdr *top_iph,
+				    struct tmp_ext *iph_ext, int extlen)
+{
+	if (!extlen)
+		return;
+
+#if IS_ENABLED(CONFIG_IPV6_MIP6)
+	top_iph->saddr = iph_ext->saddr;
+#endif
+	top_iph->daddr = iph_ext->daddr;
+	memcpy(top_iph + 1, &iph_ext->hdrs, extlen - sizeof(*iph_ext));
+}
+
 static void *ah_alloc_tmp(struct crypto_ahash *ahash, int nfrags,
 			  unsigned int size)
 {
@@ -301,13 +329,7 @@ static void ah6_output_done(void *data, int err)
 	memcpy(ah->auth_data, icv, ahp->icv_trunc_len);
 	memcpy(top_iph, iph_base, IPV6HDR_BASELEN);
 
-	if (extlen) {
-#if IS_ENABLED(CONFIG_IPV6_MIP6)
-		memcpy(&top_iph->saddr, iph_ext, extlen);
-#else
-		memcpy(&top_iph->daddr, iph_ext, extlen);
-#endif
-	}
+	ah6_restore_hdrs(top_iph, iph_ext, extlen);
 
 	kfree(AH_SKB_CB(skb)->tmp);
 	xfrm_output_resume(skb->sk, skb, err);
@@ -378,12 +400,8 @@ static int ah6_output(struct xfrm_state *x, struct sk_buff *skb)
 	 */
 	memcpy(iph_base, top_iph, IPV6HDR_BASELEN);
 
+	ah6_save_hdrs(iph_ext, top_iph, extlen);
 	if (extlen) {
-#if IS_ENABLED(CONFIG_IPV6_MIP6)
-		memcpy(iph_ext, &top_iph->saddr, extlen);
-#else
-		memcpy(iph_ext, &top_iph->daddr, extlen);
-#endif
 		err = ipv6_clear_mutable_options(top_iph,
 						 extlen - sizeof(*iph_ext) +
 						 sizeof(*top_iph),
@@ -434,13 +452,7 @@ static int ah6_output(struct xfrm_state *x, struct sk_buff *skb)
 	memcpy(ah->auth_data, icv, ahp->icv_trunc_len);
 	memcpy(top_iph, iph_base, IPV6HDR_BASELEN);
 
-	if (extlen) {
-#if IS_ENABLED(CONFIG_IPV6_MIP6)
-		memcpy(&top_iph->saddr, iph_ext, extlen);
-#else
-		memcpy(&top_iph->daddr, iph_ext, extlen);
-#endif
-	}
+	ah6_restore_hdrs(top_iph, iph_ext, extlen);
 
 out_free:
 	kfree(iph_base);

---
base-commit: b711733e89a3f84c8e1e56e2328f9a0fa5facc7c
change-id: 20250727-ah6-buffer-overflow-ff795b87398d

Best regards,
-- 
Charalampos Mitrodimas <charmitro@posteo.net>


