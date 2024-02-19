Return-Path: <netdev+bounces-72879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0267285A04E
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2F51F22B4C
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C7628E0F;
	Mon, 19 Feb 2024 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="AaIpsNso"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70102869B
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336442; cv=none; b=p3Vz9YXAlodL9dKYHC/ehztcXn5I4NeQcprplmEPwPH/zJsapMulzGSoA60KfC6uMBrh+ssxgxj5vzev99dS0NGm4GF9DF7PSXpyt2mGgIjbzT/lEwOAVUJ1lCf4zPnv8VqcB81fXIjh9Nqu5fnQatREvjsOK/uvKoEi86Gx2aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336442; c=relaxed/simple;
	bh=f4fZ5be1Y9cmAUXB4IKAdi5dIt05EQK2EdJ/D3bu1QI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZPjakekHlZrxmDKftO9VM752zqcuEWMBoqCL6jgeXL8mKwQZG7+1tvPW2U00EFqOuwjRBEY29ze2xMsAGb94NSLV6hsCU53CTlH6qR6tnY4rq+IUqO4vmbhLfrFWpeWZY4Zg8sepbCMpuKJF+JlFG94UBKKmi4HM8fsx+JqyLeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=AaIpsNso; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 7B5692048D; Mon, 19 Feb 2024 17:53:56 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708336436;
	bh=yRPIeMH1Dei5wt5RWgupwXk6ImvO/CvBiMDlpJpJPWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AaIpsNsoW2CLVspwrq8iIGpSDBcjrVjNRzwvcYDnMgR13emiUlTtZNmeDT6X7yRG1
	 IgGYBtqzIcX5OcEVoMor0K/2RUkC4ZLqeWN1LMun7omSSLUfQ9wS/+XZpRfK0dpbbB
	 HpJeC5UIORvpCJzln6ikDK893R0rocRkukebh6NVY9C8/aLFO18jqNQ9txaJ++ehzQ
	 wCQ9IpJg1lnSpRcu/cG3OMM3wnV2N4qFd1DNXfnHLDqELj4wKG/SEvBWdsafcu5REe
	 r5Rmtz4KfLu4d4CqmGTy5L3VI7keL+LJ0A4ddjOvfkD/ravFkZ52G3SO6zDBvk46ew
	 ysHGS1kdlraFg==
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: netdev@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net-next v2 09/11] net: mctp: copy skb ext data when fragmenting
Date: Mon, 19 Feb 2024 17:51:54 +0800
Message-Id: <0f2f5684f8e994efa6c9cbce569a5099cbd64f3d.1708335994.git.jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708335994.git.jk@codeconstruct.com.au>
References: <cover.1708335994.git.jk@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we're fragmenting on local output, the original packet may contain
ext data for the MCTP flows. We'll want this in the resulting fragment
skbs too.

So, do a skb_ext_copy() in the fragmentation path, and implement the
MCTP-specific parts of an ext copy operation.

Fixes: 67737c457281 ("mctp: Pass flow data & flow release events to drivers")
Reported-by: Jian Zhang <zhangjian.3032@bytedance.com>
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/core/skbuff.c | 8 ++++++++
 net/mctp/route.c  | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index edbbef563d4d..71dee435d549 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6736,6 +6736,14 @@ static struct skb_ext *skb_ext_maybe_cow(struct skb_ext *old,
 		for (i = 0; i < sp->len; i++)
 			xfrm_state_hold(sp->xvec[i]);
 	}
+#endif
+#ifdef CONFIG_MCTP_FLOWS
+	if (old_active & (1 << SKB_EXT_MCTP)) {
+		struct mctp_flow *flow = skb_ext_get_ptr(old, SKB_EXT_MCTP);
+
+		if (flow->key)
+			refcount_inc(&flow->key->refs);
+	}
 #endif
 	__skb_ext_put(old);
 	return new;
diff --git a/net/mctp/route.c b/net/mctp/route.c
index edfde04a1652..f31ecb5e8aa6 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -905,6 +905,9 @@ static int mctp_do_fragment_route(struct mctp_route *rt, struct sk_buff *skb,
 		/* copy message payload */
 		skb_copy_bits(skb, pos, skb_transport_header(skb2), size);
 
+		/* we need to copy the extensions, for MCTP flow data */
+		skb_ext_copy(skb2, skb);
+
 		/* do route */
 		rc = rt->output(rt, skb2);
 		if (rc)
-- 
2.39.2


