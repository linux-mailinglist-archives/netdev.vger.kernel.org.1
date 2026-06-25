Return-Path: <netdev+bounces-302075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3KU3OdihPWq64wgAu9opvQ
	(envelope-from <netdev+bounces-302075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 23:47:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 598276C8C7E
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 23:47:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=E5ZImCgi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302075-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302075-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6481C303EDAD
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 21:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7062A362130;
	Thu, 25 Jun 2026 21:47:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1930C30D3ED
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 21:47:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424022; cv=none; b=G0q5Y194gQdQ4is8ByDs6wQcjnscC0O+4utiYyXPYhspDJB6uVsL4cHuP+nVEZ85rc76+l9qcMPKkpu6eREaBIunFYT4w2PG1mrn20Mf4lU+pjTQobF+AnwIOo4TGzNVx027dI5xm9Q02fd79DsezdD55TxtctoNdTRyoRi0XDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424022; c=relaxed/simple;
	bh=c1MC181yZIzXA4ZUsLaxd9Gq6FhcOsFP0Ajkdy90Qhc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tQmAZJVfKjPHuVzfV1io8nIKcxWWkN9hMh7O6VEmAb3PFaa7m6DChWcdxgpRidPD/uK03kZ7KqmtzLT2UjBRIbdROl0hGdau4zsagUyaj4nvdW5AgOcwhJU9zp+B8zOT8MRHZMjZ2p4hwyZ/n7ewvaipviB4ENZDHFddve/vV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E5ZImCgi; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84534f17866so156615b3a.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 14:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782424020; x=1783028820; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8V8sc1LmQm4BcogFj5Lnpd5H/dBgiB5XaIP9R5SNrgI=;
        b=E5ZImCgiydbeb7vE6PKk+0LpCxOJY36gxjtQ5YdNMzF7mJBSYK7WY2wYk5fBvdNDi3
         oTPeo5ulVezMfL+IB5t6KBv+7MLWku9JMx1c2l4/f/JUnEa+VtWeStOOgs5cLZfwIeI8
         DR36t7clz6GAKBKeGOg3sznlJmeHnRq3628qAVJ0Jc3xeBJo4AzdUUsgYhq4lOL9p9Kd
         LjlH+K27+KYLmJGWdb8L7mjMAp02nZP4sX3DfK13OpiSh2bnMDtFmoEYq94LfrOmpfSy
         cwoXsMvybK9PqrzAHrt4Rl4Z46++H7O5/wRN3zX32JlSiKPvMkWZiAkL4+PqBBzeahcK
         pHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782424020; x=1783028820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8V8sc1LmQm4BcogFj5Lnpd5H/dBgiB5XaIP9R5SNrgI=;
        b=WsmArGw9RX5KYm7WFvH/7u2V2CUvnqV1M1vLBMXNg0cG6JHLKEYhhUGRHYRJDnhuHZ
         qGdqdOwieD1OWLUr2f0RkQGOcXyv4x2GJmcZskbAtBKpPWGxf+wyO0sHoFnveBhaYOiY
         WMMVUO5D3ElpYEc85ZvnjEnQKerYmJFRTwvcK5VbRL9hN2mNUfI66330AQKzeLBHImYa
         Dmdq8k4Yvvno8vZG8Q7cxWDoE4rrh+NWvcwRRhGGVmwDKNybqBEl3VaROlL9mbh2UG7W
         7YbgKXqIMMM5pdgtxg1rpBBcq6xolaCNMEzExPmMJ8iMKfVM5fIGPARlEMK88Mu8FFTD
         2tIw==
X-Forwarded-Encrypted: i=1; AHgh+RpgDfX6YPjpf4GKpAMHzLq3SnszXLR1JZmVv3D4AKIxTcoLxX+eNDkk8eEzg7XCDSjrrab21ns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8dDrej2JixXct7iazlntrujmEQtC92XCzawO/6n52cPTYX8pj
	G6HrfPtsltud6LwkmWOHlTM70t1ndwFTqtdbYwsv7Y3vg2stHTkW91z/0ilOuu9BSkmUAmpjYTw
	cPlmnvQ==
X-Received: from pfbcb7.prod.google.com ([2002:a05:6a00:4307:b0:842:2f38:1f3c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1415:b0:836:3f6a:3e7a
 with SMTP id d2e1a72fcca58-845b3aaf048mr4662847b3a.26.1782424019962; Thu, 25
 Jun 2026 14:46:59 -0700 (PDT)
Date: Thu, 25 Jun 2026 21:45:30 +0000
In-Reply-To: <20260625102020.92814-1-vimal.agrawal@sophos.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625102020.92814-1-vimal.agrawal@sophos.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625214659.1115819-1-kuniyu@google.com>
Subject: Re: [PATCH net-next] net: neigh: avoid calling neigh_forced_gc on
 every alloc when table is full
From: Kuniyuki Iwashima <kuniyu@google.com>
To: avimalin@gmail.com
Cc: edumazet@google.com, kuniyu@google.com, netdev@vger.kernel.org, 
	vimal.agrawal@sophos.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302075-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:avimalin@gmail.com,m:edumazet@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:vimal.agrawal@sophos.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,sophos.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 598276C8C7E

From: Vimal Agrawal <avimalin@gmail.com>
Date: Thu, 25 Jun 2026 10:20:20 +0000
> Once the neighbour table exceeds gc_thresh3, neigh_forced_gc() is called
> on every allocation attempt with no rate limiting. In workloads with mostly
> active/reachable entries, the GC walk traverses a large portion of the
> neighbour table without reclaiming entries, holding tbl->lock for an
> extended period. This causes severe lock contention and allocation
> latencies exceeding 16ms under sustained neighbour creation.
> 
> Add a pre-lock check in neigh_forced_gc() to skip the GC run if one was
> performed within the last second, avoiding repeated full table scans and
> lock acquisitions on the hot allocation path.
> 
> Profiling of neigh_create() shows ~3 orders of magnitude latency
> improvement with this change.
> 
> Link:https://lore.kernel.org/netdev/CALkUMdSCpx_ywYCx_ePLdm6yioO1nQWx7sSM=AEgsq0kywHxTw@mail.gmail.com/

From the thread, these look misconfigured.

---8<---
net.ipv6.neigh.default.gc_thresh2 = 32768
net.ipv6.neigh.default.gc_thresh3 = 32768
---8<---

If gc_thresh3 is larger enough, gc_thresh2 will give you 5s
rate limiting.

If the number of active neigh entries constantly exceeds
gc_thresh3, it will be the correct gc_thresh2 for you.

Also, I guess you want a new kernel param for the first
neigh_hash_alloc(), which is currently fixed for 3, which
is too small for some hosts.

50000 entries require neigh_hash_grow() 13 times.

Can you test this on your real workload, starting from
neigh_hash_shift=16 and appropriate gc_thresh2/3 ?

---8<---
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1349c0eedb64..a75b3750eec9 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1817,6 +1817,22 @@ EXPORT_SYMBOL(neigh_parms_release);
 static struct lock_class_key neigh_table_proxy_queue_class;
 
 static struct neigh_table __rcu *neigh_tables[NEIGH_NR_TABLES] __read_mostly;
+static __initdata unsigned long neigh_hash_shift = 3;
+
+static int __init neigh_set_hash_shift(char *str)
+{
+	ssize_t ret;
+
+	if (!str)
+		return 0;
+
+	ret = kstrtoul(str, 0, &neigh_hash_shift);
+	if (ret)
+		return 0;
+
+	return 1;
+}
+__setup("neigh_hash_shift=", neigh_set_hash_shift);
 
 void neigh_table_init(int index, struct neigh_table *tbl)
 {
@@ -1843,7 +1859,7 @@ void neigh_table_init(int index, struct neigh_table *tbl)
 		panic("cannot create neighbour proc dir entry");
 #endif
 
-	RCU_INIT_POINTER(tbl->nht, neigh_hash_alloc(3));
+	RCU_INIT_POINTER(tbl->nht, neigh_hash_alloc(neigh_hash_shift));
 
 	phsize = (PNEIGH_HASHMASK + 1) * sizeof(struct pneigh_entry *);
 	tbl->phash_buckets = kzalloc(phsize, GFP_KERNEL);
---8<---



> Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
> ---
>  net/core/neighbour.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 1349c0eedb64..078842db3c5f 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -260,6 +260,9 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>  	int shrunk = 0;
>  	int loop = 0;
>  
> +	if (!time_after(jiffies, READ_ONCE(tbl->last_flush) + HZ))
> +		return 0;
> +
>  	NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
>  
>  	spin_lock_bh(&tbl->lock);
> -- 
> 2.17.1
> v

