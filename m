Return-Path: <netdev+bounces-254334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDo2ONU9emlB4wEAu9opvQ
	(envelope-from <netdev+bounces-254334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:48:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 534B0A6226
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF6A73147D3D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28B630C635;
	Wed, 28 Jan 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmFTn0QD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62B030BF7D;
	Wed, 28 Jan 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616637; cv=none; b=GR2wafogdSgfzZWiJlHRnzMO82AIgjrCWXVCziO4TVTuMAPOICzGgb294zaTp0uou9SeDnJE/5VgBpVQI5WVz9GWLNGEhIKX2lKalxjNl4zx2n5bKxpv/zazffRN8+QGb/E01BqJ0MwO7F32a/4TngC3IXXi3JloPG1WhXO5bXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616637; c=relaxed/simple;
	bh=/TSbgLkOttYTU5dCzEgWW/zjDEa0pxwVG9ja2wTemaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HTOp9r2DR1ZfIGZRh+LGBK82N+Cz0cxelm8zTocr+++qsPvawmsY6EOxOa6Wv/T8lgxJo9GcwzdcbyTiiE4csqC0vdgRSqAizMLrQcrwp9aWi38yVcSM1Zvi78CcuQ5FKq1gpi8IB1k2xpIlxqlMqdYcAmMOlwW74RvdEYEVaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmFTn0QD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4053C4CEF1;
	Wed, 28 Jan 2026 16:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769616637;
	bh=/TSbgLkOttYTU5dCzEgWW/zjDEa0pxwVG9ja2wTemaU=;
	h=From:To:Cc:Subject:Date:From;
	b=HmFTn0QD2XagFXnkSzoK7j1sJOZt+R/0cz2rm16V2mUcqraO8aIYigNADaOVy0Jll
	 assaFrN1NdVgvSYcvtzQD/zNQOBFpLhKJJXcdBfHQ89oSfHPsYNMTYFvjfJGngHmgc
	 Bgo4O5bNs9Xbxz1UsybqZ475TQu6edM0EfsCLzL8GRWz0UGehMgyFdUJ3yYg0kjbp3
	 ZnrLPXqdL8MSTcamgpvVMYKiW9uINtlaBlZSYt2nHBjBXdGuuOWsJFY4/rhRW6yBQY
	 3NsohmgX9P4wQQ5cBI+8OoQhvQI6fYBQlDbzpjowyrKVLNIZisQJ6wSKLTB7NxcZ9S
	 CqicarcAk7H4w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	dsahern@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH net] net: don't touch dev->stats in BPF redirect paths
Date: Wed, 28 Jan 2026 08:10:30 -0800
Message-ID: <20260128161030.39870-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-254334-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email,fomichev.me:email,nvidia.com:email,linux.dev:email]
X-Rspamd-Queue-Id: 534B0A6226
X-Rspamd-Action: no action

Gal reports that BPF redirect increments dev->stats.tx_errors
on failure. This is not correct, most modern drivers completely
ignore dev->stats so these drops will be invisible to the user.
Core code should use the dedicated core stats which are folded
into device stats in dev_get_stats().

Reported-by: Gal Pressman <gal@nvidia.com>
Link: https://lore.kernel.org/c5df3b60-246a-4030-9c9a-0a35cd1ca924@nvidia.com
Fixes: b4ab31414970 ("bpf: Add redirect_neigh helper as redirect drop-in")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: andrii@kernel.org
CC: martin.lau@linux.dev
CC: eddyz87@gmail.com
CC: song@kernel.org
CC: yonghong.song@linux.dev
CC: john.fastabend@gmail.com
CC: kpsingh@kernel.org
CC: sdf@fomichev.me
CC: haoluo@google.com
CC: jolsa@kernel.org
CC: dsahern@gmail.com
CC: bpf@vger.kernel.org
---
 net/core/filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 616e0520a0bb..2c21735798a5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2289,12 +2289,12 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 
 	err = bpf_out_neigh_v6(net, skb, dev, nh);
 	if (unlikely(net_xmit_eval(err)))
-		DEV_STATS_INC(dev, tx_errors);
+		dev_core_stats_tx_dropped_inc(dev);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out_xmit;
 out_drop:
-	DEV_STATS_INC(dev, tx_errors);
+	dev_core_stats_tx_dropped_inc(dev);
 	kfree_skb(skb);
 out_xmit:
 	return ret;
@@ -2396,12 +2396,12 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 
 	err = bpf_out_neigh_v4(net, skb, dev, nh);
 	if (unlikely(net_xmit_eval(err)))
-		DEV_STATS_INC(dev, tx_errors);
+		dev_core_stats_tx_dropped_inc(dev);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out_xmit;
 out_drop:
-	DEV_STATS_INC(dev, tx_errors);
+	dev_core_stats_tx_dropped_inc(dev);
 	kfree_skb(skb);
 out_xmit:
 	return ret;
-- 
2.52.0


