Return-Path: <netdev+bounces-112780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA1F93B2BF
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 16:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6862852CB
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 14:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B9615A86E;
	Wed, 24 Jul 2024 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JLBLDXuU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17C515A858
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831701; cv=none; b=WWg3mEEwYlSxE/XSjKm6TcjR8n8N8orkasVM6v6etRZMOgWuWoxyf6nXXxQdYvsShMOVA+mQ31P4XENlJT996VcdRECJKi1ejOWXzpM+G9CR4eAoix3e/n5+VJMD4jhh9nvQ2otuhznG+SB5K84YPEyRvMfTMekesoNEt8Cx00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831701; c=relaxed/simple;
	bh=HSwQeQKexnGgqVLaYYN251oliUuwb76BW3cdQCAHRbk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DhL6JccGgGqjv347Xc0Wo5P3Hv7utsVUPjYIlfmwOEicXwRCC7B5/JyCs6U+JOhDmbA43mvSUt7g2zFCITXKAnPL3uzYt8ZH5ilbYtmkl2w7niY8uvPyCFtogqIp6lAYmb66+nPMepokmrJtL+ScPRJb/ZfZY9MIPBe0lqPDPas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JLBLDXuU; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e08904584edso7458057276.3
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 07:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721831699; x=1722436499; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JeMGXcX1cegB/do4cg9zm1gyDlQ+HaTTsOgplmebNZ0=;
        b=JLBLDXuUW6c2GkB1KRgsoOlbLj9Cwy9HfnCoZsjVmsw2l/FqNC+Sdb0zpd3sp+pAXf
         UMDkM/KUlJ4pxpK2aqo17p+kqTt/cgh1RoUHg50UwVfPp+x569owOjwU+ppJYo8VhDag
         rWkvkaTDdAguncTW4Zyyrv42ojQXAJ70lq7JY4Fr6lNthYCzt/4IqKX5BCuPPTaUZy7M
         vaYOAikyTtsg0ZwA83sdKt2nUm5J+ece8AhGZoRWAds5oYPH9dwLLbY8Uk7ezprBOvBm
         x1le996CQeTS0OfL6xcnIzo9d6fX4ToV8c8gTf+j9GPxO9A8cTkJ4xd78WWOgJJrg94i
         lFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721831699; x=1722436499;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JeMGXcX1cegB/do4cg9zm1gyDlQ+HaTTsOgplmebNZ0=;
        b=C6EL4NYEaDqss6tVSAnHiBP9Mb8RHV6ZcYTmhjxp7qtNBDtisfIob/4DoOruQkTyrf
         6f50bHG+qn+W4JiTrD+xTfEEgEuKk1LEsJqsF2DZQBEyzvKHGbQyYuHrfe1O4AhWqxjy
         VnB/0lPIcTCAMZH3FikICITb7vkJlcM9Kj8HPFM+1Ic/rPR9to1+td5PjPnpl/E2wm8P
         +u9v62BfFxNNh0hawPIaZ8cN2R6JzY+fW0hght2zbd65I5KqrJ37UmktUo3UJWK9+46l
         U4L375VLpJUyAO0aCyKSCIZ5Byx4Ii7+4a0aTea5mR7IyPUSrJJ1l2nbSSpM0PZ26IcR
         DZHQ==
X-Gm-Message-State: AOJu0YwAq8rcSy3ebswNeuvnWZYfTlaylzqnX44yo1f/CIKIawa/aaAt
	/zMBW4+LznQL+AKC00xrC4mf1SM8HOH7ndpsUcIWyyp/492n6uIo7pdORMGJDJs8gDr+sAJbLfC
	F1N+WzZ4Gp/+bHf1Wdz+EoG7uyVQkmsyeYBkx3YxIiL09r1dDd0uLc0zoYhpkMeKbZi7zvYLKt4
	bII82R++gOFp/lN/k+03z+MiKTIvu7Hp3/UfsnSE1h/Aimh1W7safHm6W3j/XHwfLs
X-Google-Smtp-Source: AGHT+IEZuyeGwGKdUoIRK4zF9Zbp4w/oa6ZeROlRlWRSwH9jVrHULIW502Jr9RftRka06FDyoDllerEv4wcOmgjiUTI=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:8273:a55:a06b:2955])
 (user=pkaligineedi job=sendgmr) by 2002:a25:820d:0:b0:e05:f2fc:9a37 with SMTP
 id 3f1490d57ef6-e0b0e3b90aemr3769276.6.1721831698504; Wed, 24 Jul 2024
 07:34:58 -0700 (PDT)
Date: Wed, 24 Jul 2024 07:34:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240724143431.3343722-1-pkaligineedi@google.com>
Subject: [PATCH net v2] gve: Fix an edge case for TSO skb validity check
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemb@google.com, shailend@google.com, 
	hramamurthy@google.com, csully@google.com, jfraker@google.com, 
	stable@vger.kernel.org, Bailey Forrest <bcf@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Bailey Forrest <bcf@google.com>

The NIC requires each TSO segment to not span more than 10
descriptors. NIC further requires each descriptor to not exceed
16KB - 1 (GVE_TX_MAX_BUF_SIZE_DQO).

The descriptors for an skb are generated by
gve_tx_add_skb_no_copy_dqo() for DQO RDA queue format.
gve_tx_add_skb_no_copy_dqo() loops through each skb frag and
generates a descriptor for the entire frag if the frag size is
not greater than GVE_TX_MAX_BUF_SIZE_DQO. If the frag size is
greater than GVE_TX_MAX_BUF_SIZE_DQO, it is split into descriptor(s)
of size GVE_TX_MAX_BUF_SIZE_DQO and a descriptor is generated for
the remainder (frag size % GVE_TX_MAX_BUF_SIZE_DQO).

gve_can_send_tso() checks if the descriptors thus generated for an
skb would meet the requirement that each TSO-segment not span more
than 10 descriptors. However, the current code misses an edge case
when a TSO segment spans multiple descriptors within a large frag.
This change fixes the edge case.

gve_can_send_tso() relies on the assumption that max gso size (9728)
is less than GVE_TX_MAX_BUF_SIZE_DQO and therefore within an skb
fragment a TSO segment can never span more than 2 descriptors.

Fixes: a57e5de476be ("gve: DQO: Add TX path")
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Bailey Forrest <bcf@google.com>
Reviewed-by: Jeroen de Borst <jeroendb@google.com>
Cc: stable@vger.kernel.org
---
Changes from v1:
 - Added 'stable tag'
 - Added more explanation in the commit message
 - Modified comments to clarify the changes made
 - Changed variable names 'last_frag_size' to 'prev_frag_size' and
   'last_frag_remain' to 'prev_frag_remain'
 - Removed parentheses around single line statement

 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 22 +++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 0b3cca3fc792..f879426cb552 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -866,22 +866,42 @@ static bool gve_can_send_tso(const struct sk_buff *skb)
 	const int header_len = skb_tcp_all_headers(skb);
 	const int gso_size = shinfo->gso_size;
 	int cur_seg_num_bufs;
+	int prev_frag_size;
 	int cur_seg_size;
 	int i;
 
 	cur_seg_size = skb_headlen(skb) - header_len;
+	prev_frag_size = skb_headlen(skb);
 	cur_seg_num_bufs = cur_seg_size > 0;
 
 	for (i = 0; i < shinfo->nr_frags; i++) {
 		if (cur_seg_size >= gso_size) {
 			cur_seg_size %= gso_size;
 			cur_seg_num_bufs = cur_seg_size > 0;
+
+			if (prev_frag_size > GVE_TX_MAX_BUF_SIZE_DQO) {
+				int prev_frag_remain = prev_frag_size %
+					GVE_TX_MAX_BUF_SIZE_DQO;
+
+				/* If the last descriptor of the previous frag
+				 * is less than cur_seg_size, the segment will
+				 * span two descriptors in the previous frag.
+				 * Since max gso size (9728) is less than
+				 * GVE_TX_MAX_BUF_SIZE_DQO, it is impossible
+				 * for the segment to span more than two
+				 * descriptors.
+				 */
+				if (prev_frag_remain &&
+				    cur_seg_size > prev_frag_remain)
+					cur_seg_num_bufs++;
+			}
 		}
 
 		if (unlikely(++cur_seg_num_bufs > max_bufs_per_seg))
 			return false;
 
-		cur_seg_size += skb_frag_size(&shinfo->frags[i]);
+		prev_frag_size = skb_frag_size(&shinfo->frags[i]);
+		cur_seg_size += prev_frag_size;
 	}
 
 	return true;
-- 
2.45.2.1089.g2a221341d9-goog


