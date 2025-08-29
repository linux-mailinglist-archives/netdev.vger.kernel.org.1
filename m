Return-Path: <netdev+bounces-218140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F96B3B442
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9DB189729A
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CFA26B0BE;
	Fri, 29 Aug 2025 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="KPN/TzPz"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1292A267386
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756452585; cv=none; b=CglVeIs+NT3LMtMBRXNFUnflrAS/0JCPIlKnANlb3cKiSMvqHAmZ50pc/b3mWA+XjKyDfLrY2KNsZmTXKGbaJzBgn0I3QG+6cpcDMFRLxkLYXCu4sqpN8S+8Da5CuhWB9pNGHnWawRKyWz22rgbJzPQVtsyMEJ24nZtBmaTgQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756452585; c=relaxed/simple;
	bh=nqm2mNWBnXXWoDR0Rsq/sK4OQtpfcO08a9j/j8hbWnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SIqmNeMAolMVYisdMywBBMOhaGu4SQt5+KyTj0ss/rF4GkFqwJPVa/zPGpXcY6BoVoztKMktUB8DOp9eLj4hWjoNI3VaAy0tx7Md+P5pWJkBl+fEOJ8CPiKAOrV2n2vqxcJBB/GZSv3FNvQO08tO4wGz9P9kZbvmbWiiuyTL0/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=KPN/TzPz; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756452574;
	bh=yrP1ASU2TYfJpLPjwb2tjMxaDErp06fjsjgq206x56Q=;
	h=From:Date:Subject:To:Cc;
	b=KPN/TzPzhgsz2elu0e/u28Srn/xIsYon51wQC/JcEkakWrSyXATDW2IuEox1YAIBD
	 caajMpYVgebQd4nCtQ4m6c32F6EZ8GbjkiyPlJ89hfELSgnHgStJqi3hDKQgT3ExSQ
	 CAmVRjYcSDfp3FnJ5nxPwKpeXR3elwYYkmtBk9rVY/g37pex9xxxEXCKziAE37uSzq
	 EXOp0mDrErdRd2mFz8GUcIthpXPR1ZgRrlRv8jKQB+cBjRRuwYVYw+bieDDaQUfZLn
	 9uMbIdTiJn6uleP3v7+RqMhPpsNRJCV2g/bXjc2hvpMIabfnWZXHQmqnpZHVmva0KJ
	 dAkL0UcjKulQA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id CAD766F563; Fri, 29 Aug 2025 15:29:34 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 29 Aug 2025 15:28:26 +0800
Subject: [PATCH net] net: mctp: mctp_fraq_queue should take ownership of
 passed skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-mctp-skb-unshare-v1-1-1c28fe10235a@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAJpWsWgC/x3MTQ5AMBBA4avIrE1SbfxeRSyqBhNR0kEk4u4ay
 2/x3gNCgUmgSR4IdLHw5iOyNAE3Wz8R8hANWulcVbrG1R07ytLj6WW2gbAwyhbG1aM1JcRsDzT
 y/S9b8HRA974fj/K86mcAAAA=
X-Change-ID: 20250829-mctp-skb-unshare-630a63c9fa37
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

As of commit f5d83cf0eeb9 ("net: mctp: unshare packets when
reassembling"), we skb_unshare() in mctp_frag_queue(). The unshare may
invalidate the original skb pointer, so we need to treat the skb as
entirely owned by the fraq queue, even on failure.

Fixes: f5d83cf0eeb9 ("net: mctp: unshare packets when reassembling")
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/route.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 2b2b958ef6a37525cc4d3f6a5758bd3880c98e6c..4d314e062ba9c4137f196482880660be67a71b11 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -378,6 +378,7 @@ static void mctp_skb_set_flow(struct sk_buff *skb, struct mctp_sk_key *key) {}
 static void mctp_flow_prepare_output(struct sk_buff *skb, struct mctp_dev *dev) {}
 #endif
 
+/* takes ownership of skb, both in success and failure cases */
 static int mctp_frag_queue(struct mctp_sk_key *key, struct sk_buff *skb)
 {
 	struct mctp_hdr *hdr = mctp_hdr(skb);
@@ -387,8 +388,10 @@ static int mctp_frag_queue(struct mctp_sk_key *key, struct sk_buff *skb)
 		& MCTP_HDR_SEQ_MASK;
 
 	if (!key->reasm_head) {
-		/* Since we're manipulating the shared frag_list, ensure it isn't
-		 * shared with any other SKBs.
+		/* Since we're manipulating the shared frag_list, ensure it
+		 * isn't shared with any other SKBs. In the cloned case,
+		 * this will free the skb; callers can no longer access it
+		 * safely.
 		 */
 		key->reasm_head = skb_unshare(skb, GFP_ATOMIC);
 		if (!key->reasm_head)
@@ -402,10 +405,10 @@ static int mctp_frag_queue(struct mctp_sk_key *key, struct sk_buff *skb)
 	exp_seq = (key->last_seq + 1) & MCTP_HDR_SEQ_MASK;
 
 	if (this_seq != exp_seq)
-		return -EINVAL;
+		goto err_free;
 
 	if (key->reasm_head->len + skb->len > mctp_message_maxlen)
-		return -EINVAL;
+		goto err_free;
 
 	skb->next = NULL;
 	skb->sk = NULL;
@@ -419,6 +422,10 @@ static int mctp_frag_queue(struct mctp_sk_key *key, struct sk_buff *skb)
 	key->reasm_head->truesize += skb->truesize;
 
 	return 0;
+
+err_free:
+	kfree_skb(skb);
+	return -EINVAL;
 }
 
 static int mctp_dst_input(struct mctp_dst *dst, struct sk_buff *skb)
@@ -532,18 +539,16 @@ static int mctp_dst_input(struct mctp_dst *dst, struct sk_buff *skb)
 			 * key isn't observable yet
 			 */
 			mctp_frag_queue(key, skb);
+			skb = NULL;
 
 			/* if the key_add fails, we've raced with another
 			 * SOM packet with the same src, dest and tag. There's
 			 * no way to distinguish future packets, so all we
-			 * can do is drop; we'll free the skb on exit from
-			 * this function.
+			 * can do is drop.
 			 */
 			rc = mctp_key_add(key, msk);
-			if (!rc) {
+			if (!rc)
 				trace_mctp_key_acquire(key);
-				skb = NULL;
-			}
 
 			/* we don't need to release key->lock on exit, so
 			 * clean up here and suppress the unlock via
@@ -561,8 +566,7 @@ static int mctp_dst_input(struct mctp_dst *dst, struct sk_buff *skb)
 				key = NULL;
 			} else {
 				rc = mctp_frag_queue(key, skb);
-				if (!rc)
-					skb = NULL;
+				skb = NULL;
 			}
 		}
 
@@ -572,17 +576,16 @@ static int mctp_dst_input(struct mctp_dst *dst, struct sk_buff *skb)
 		 */
 
 		/* we need to be continuing an existing reassembly... */
-		if (!key->reasm_head)
+		if (!key->reasm_head) {
 			rc = -EINVAL;
-		else
+		} else {
 			rc = mctp_frag_queue(key, skb);
+			skb = NULL;
+		}
 
 		if (rc)
 			goto out_unlock;
 
-		/* we've queued; the queue owns the skb now */
-		skb = NULL;
-
 		/* end of message? deliver to socket, and we're done with
 		 * the reassembly/response key
 		 */

---
base-commit: 007a5ffadc4fd51739527f1503b7cf048f31c413
change-id: 20250829-mctp-skb-unshare-630a63c9fa37

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


