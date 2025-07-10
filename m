Return-Path: <netdev+bounces-205649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0A5AFF774
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 05:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4104156556E
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 03:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0796D283130;
	Thu, 10 Jul 2025 03:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SjDub+yO"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822328136B
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 03:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752117798; cv=none; b=u4HUYdnAPbGLasr6y/882k/XytG3lUcZdFSZ2wIpm3SqFrMWA9mUkmGPUEkl9Jw1Fk52OUlvdp3mUtOyzZWVsdiwA35BLj+DJ31qVmheiqdEZrj8jmlCZ89y/uiK5CW/MK/cgcKriJs8NcJveL2iQqYvinprbJFrIn8uWCZ2IlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752117798; c=relaxed/simple;
	bh=K40JiKMEM5JVQbO08FpthAfv5P9HZPaho2S73xkTR08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXf6AGG9bevrZNFReQlYWKh71dVDd4tYeBrnkFvxwna57Fm8faPgHsq9BT7OVLfGTyZvBaxjNJCjFfSxCBtz9j+nKdfAiP2TVvFZwjqAgCaEC8mC+HLgakRyf+I710AwOwhgLIiLVC4cajJdTcBL0nxsgB5APdFhNwEUlm2AUTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SjDub+yO; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752117793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSsty5Psi3jvX4zJfFavFS2YXUbWro8hN5jZSdRxRfU=;
	b=SjDub+yO0wKbnFLeYEn2/FUD7Yln1lBU0MiBNKalJaPExiIGI+w86BTfLMFwcfXOLiGdcX
	1NHqswnHpMnUZLXTh/mc7AzF27ZRYha3HWMAjFIBdkVL5ajtZhuTB3lG+JrqO3CNya0uIs
	7LN39LJgycgRtmhj4UdxijUNTLJi8Ko=
From: Tao Chen <chen.dylane@linux.dev>
To: daniel@iogearbox.net,
	razor@blackwall.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
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
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	horms@kernel.org,
	willemb@google.com,
	jakub@cloudflare.com,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	hawk@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v4 4/7] bpf: Remove location field in tcx_link
Date: Thu, 10 Jul 2025 11:20:35 +0800
Message-ID: <20250710032038.888700-5-chen.dylane@linux.dev>
In-Reply-To: <20250710032038.888700-1-chen.dylane@linux.dev>
References: <20250710032038.888700-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use attach_type in bpf_link to replace the location filed, and
remove location field in tcx_link.

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/net/tcx.h |  1 -
 kernel/bpf/tcx.c  | 13 ++++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/net/tcx.h b/include/net/tcx.h
index 5ce0ce9e0c0..23a61af1354 100644
--- a/include/net/tcx.h
+++ b/include/net/tcx.h
@@ -20,7 +20,6 @@ struct tcx_entry {
 struct tcx_link {
 	struct bpf_link link;
 	struct net_device *dev;
-	u32 location;
 };
 
 static inline void tcx_set_ingress(struct sk_buff *skb, bool ingress)
diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
index e6a14f408d9..efd987ea687 100644
--- a/kernel/bpf/tcx.c
+++ b/kernel/bpf/tcx.c
@@ -142,7 +142,7 @@ static int tcx_link_prog_attach(struct bpf_link *link, u32 flags, u32 id_or_fd,
 				u64 revision)
 {
 	struct tcx_link *tcx = tcx_link(link);
-	bool created, ingress = tcx->location == BPF_TCX_INGRESS;
+	bool created, ingress = link->attach_type == BPF_TCX_INGRESS;
 	struct bpf_mprog_entry *entry, *entry_new;
 	struct net_device *dev = tcx->dev;
 	int ret;
@@ -169,7 +169,7 @@ static int tcx_link_prog_attach(struct bpf_link *link, u32 flags, u32 id_or_fd,
 static void tcx_link_release(struct bpf_link *link)
 {
 	struct tcx_link *tcx = tcx_link(link);
-	bool ingress = tcx->location == BPF_TCX_INGRESS;
+	bool ingress = link->attach_type == BPF_TCX_INGRESS;
 	struct bpf_mprog_entry *entry, *entry_new;
 	struct net_device *dev;
 	int ret = 0;
@@ -204,7 +204,7 @@ static int tcx_link_update(struct bpf_link *link, struct bpf_prog *nprog,
 			   struct bpf_prog *oprog)
 {
 	struct tcx_link *tcx = tcx_link(link);
-	bool ingress = tcx->location == BPF_TCX_INGRESS;
+	bool ingress = link->attach_type == BPF_TCX_INGRESS;
 	struct bpf_mprog_entry *entry, *entry_new;
 	struct net_device *dev;
 	int ret = 0;
@@ -260,8 +260,8 @@ static void tcx_link_fdinfo(const struct bpf_link *link, struct seq_file *seq)
 
 	seq_printf(seq, "ifindex:\t%u\n", ifindex);
 	seq_printf(seq, "attach_type:\t%u (%s)\n",
-		   tcx->location,
-		   tcx->location == BPF_TCX_INGRESS ? "ingress" : "egress");
+		   link->attach_type,
+		   link->attach_type == BPF_TCX_INGRESS ? "ingress" : "egress");
 }
 
 static int tcx_link_fill_info(const struct bpf_link *link,
@@ -276,7 +276,7 @@ static int tcx_link_fill_info(const struct bpf_link *link,
 	rtnl_unlock();
 
 	info->tcx.ifindex = ifindex;
-	info->tcx.attach_type = tcx->location;
+	info->tcx.attach_type = link->attach_type;
 	return 0;
 }
 
@@ -303,7 +303,6 @@ static int tcx_link_init(struct tcx_link *tcx,
 {
 	bpf_link_init(&tcx->link, BPF_LINK_TYPE_TCX, &tcx_link_lops, prog,
 		      attr->link_create.attach_type);
-	tcx->location = attr->link_create.attach_type;
 	tcx->dev = dev;
 	return bpf_link_prime(&tcx->link, link_primer);
 }
-- 
2.48.1


