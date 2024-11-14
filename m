Return-Path: <netdev+bounces-144854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FEA9C88F8
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE86280E90
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46291F8F1A;
	Thu, 14 Nov 2024 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGCZdRWR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A7A1D9A40
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731583868; cv=none; b=bXV1QWJsxn+V9B2+XZcpZBwdpqsrPnlPq0HMzIGzn0VyjMzailXUfaAUNuzkMXAsd4PvvkZunExYXU0BDl9Gr0LhsOWGhNg4TAl/c0Fv1xvhMi8f/Yh1j4coWN2+PLL/NQvwb9l66VLb6j9Oox5UMYbG9v5u5LEg4CL8wH1Qlbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731583868; c=relaxed/simple;
	bh=0tGnOkLkuCVaicPehNHxrDGVKILBsbC1h/fro6Aq3+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bL/ne/eg1grVkgqWUKB0Jd6z9wiajs8F9UHaZs3LINYapE0njHOumk2pzOLLo7gLr1Lbhf+mT92HSZEKDaaaJh38BCd5N/PZLNmNAuBeoAq7tqRPQY08VXc6jxd7G5WeDbLAI5l8+gBl9qtvPs8NmRXXh0S79xvnADjJPLb6FhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGCZdRWR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731583865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2pKA3GTpOh9/f3NnK5qEkZdAnNwcLEwZm2dnKgbtTVc=;
	b=ZGCZdRWRBQhlN/LNap/CzZlAm6tOEmjOgM4z2l4JIJIoiX1pozIW+J2M2lFVU5l10OQLEF
	eQ2gB9TJoQAIvW5zKgHF501dwVpO1EKBint878bn/UlarWZt8TFVel9OlMFbL8cI8p0zzU
	PTjW/i1f9nsptUP+0udqhHtsLS5m5I4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-tRFImoO-PBmhXVUweUQzAw-1; Thu,
 14 Nov 2024 06:31:01 -0500
X-MC-Unique: tRFImoO-PBmhXVUweUQzAw-1
X-Mimecast-MFC-AGG-ID: tRFImoO-PBmhXVUweUQzAw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB7FE1955EE9;
	Thu, 14 Nov 2024 11:30:58 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.45.226.57])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A4151955F3C;
	Thu, 14 Nov 2024 11:30:52 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: bpf@vger.kernel.org
Cc: bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	yoong.siang.song@intel.com,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>
Subject: [PATCH bpf] xsk: Free skb when TX metadata options are invalid
Date: Thu, 14 Nov 2024 12:30:05 +0100
Message-ID: <edb9b00fb19e680dff5a3350cd7581c5927975a8.1731581697.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

When a new skb is allocated for transmitting an xsk descriptor, i.e., for
every non-multibuf descriptor or the first frag of a multibuf descriptor,
but the descriptor is later found to have invalid options set for the TX
metadata, the new skb is never freed. This can leak skbs until the send
buffer is full which makes sending more packets impossible.

Fix this by freeing the skb in the error path if we are currently dealing
with the first frag, i.e., an skb allocated in this iteration of
xsk_build_skb.

Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
Reported-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 net/xdp/xsk.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 1140b2a120ca..b57d5d2904eb 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -675,6 +675,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		len = desc->len;
 
 		if (!skb) {
+			first_frag = true;
+
 			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
 			tr = dev->needed_tailroom;
 			skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
@@ -685,12 +687,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			skb_put(skb, len);
 
 			err = skb_store_bits(skb, 0, buffer, len);
-			if (unlikely(err)) {
-				kfree_skb(skb);
+			if (unlikely(err))
 				goto free_err;
-			}
-
-			first_frag = true;
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
 			struct page *page;
@@ -758,6 +756,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return skb;
 
 free_err:
+	if (first_frag && skb)
+		kfree_skb(skb);
+
 	if (err == -EOVERFLOW) {
 		/* Drop the packet */
 		xsk_set_destructor_arg(xs->skb);
-- 
2.47.0


