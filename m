Return-Path: <netdev+bounces-226595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60166BA270B
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 07:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704071C03C8F
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 05:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF06F278E5D;
	Fri, 26 Sep 2025 05:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="GRQ7JVUm"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2D121C9EA
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758864646; cv=none; b=ZYe942w15fO3dIMHeVU8Z7LSnLCtMmx+8CyqyjveD9xLAjR6NNHKoVnCTl0BsHI5T0+FipHazGNlXxgx6Iona8l+Cju+Gwj2eMGaxIQKbhRNCloyWjerm06IqWZQzF5YbMUFw+EWnKnfKuc3Td7n7dp8KQBgncEsKFqEGN/U0uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758864646; c=relaxed/simple;
	bh=v1+46vy/5bTQXF1JLi3RYjUId+NFzwhKxg7SxH1m5gA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBTtsLHBV1bPGpHmQXSi8oCzuyW/vr8Jc7HY+bJOSDRaaX+I3+fN27jp2uVckc9ZxoKQmG9epvq+lFZKxo4o/3SkRRokNE8kbI6aAwc7c1WhuHYiajx/F5TMvMN2NM7AD2bCYJH3qc9LMerjxnsdpZmAT75P57xl2T1vPkxz+x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=GRQ7JVUm; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5EE5E208BA;
	Fri, 26 Sep 2025 07:30:36 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XIekwHkEX5RO; Fri, 26 Sep 2025 07:30:35 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 53E88208A2;
	Fri, 26 Sep 2025 07:30:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 53E88208A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1758864635;
	bh=cxcALqtzNzps0CxGQXUEXC+3d/O29jk6shSAojiHGgY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=GRQ7JVUm4sUz1D3hX3/FsJcoDlAQCQfSGvQFctJhAVEpiF/UdTutdDdPxfBHAnSie
	 j6a1V5p7mjPylGtnmgmdEKU9ZBLLKoxKKpVkNGlN/GNgQpDHkCaWud+rySo2MrRSp3
	 wzgEFvPCqdNL/ghnVGEQsRvjI7lgUds0o+zqV5Djn7E4YhzY33lgkcUImr5Z/+Ngmk
	 M+RMuFTvDiZ8oGVtt5h5pBJTxyoter3+lNF6/jmnT2jsepcMD1ljaIs8LoCVKn3tkh
	 0NDI4phL8rbcQx7ihfxasGiRSTFwv+HQSCqMB36ZNzvGDxDvXUKc03lOw7ihnod9dW
	 4XV98g9NwQJDg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 07:30:34 +0200
Received: (nullmailer pid 2242261 invoked by uid 1000);
	Fri, 26 Sep 2025 05:30:33 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/2] net: ipv6: fix field-spanning memcpy warning in AH output
Date: Fri, 26 Sep 2025 07:30:09 +0200
Message-ID: <20250926053025.2242061-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926053025.2242061-1-steffen.klassert@secunet.com>
References: <20250926053025.2242061-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

From: Charalampos Mitrodimas <charmitro@posteo.net>

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
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv6/ah6.c | 50 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index eb474f0987ae..95372e0f1d21 100644
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
-- 
2.43.0


