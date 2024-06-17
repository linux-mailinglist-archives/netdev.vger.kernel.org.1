Return-Path: <netdev+bounces-104216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C511C90B923
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AC81F22240
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AB0198E88;
	Mon, 17 Jun 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bvZ7840m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AAA198A2C
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647756; cv=none; b=FLgueIK+ACIy+Kv4kv3QMmPOp0J0fRB5ctXdWAbvqxjDOZl5j5rkXCYsVmrYEDXWUUhkQICcpSZoEUmhGiNDrJQD08zZbtAzrDU6hCuwR7kEsjREHCYT9V9W5uXVZxiGN5CmduDI4alFSolCAW2AZBogHLXdI1oAF5XU2N39B3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647756; c=relaxed/simple;
	bh=Gs30pldD4IYhwgM9Z2RPF0lE51iD4CooDjoR4sEXvh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ealAmFK1WLG29O1gspZD97IzVHhush8+EPI4PwJ6OBt7LvFlgJ4P51JvmEeQm4XtXICw+8xny/HIOWnzYLvIl9EsC+2JDKkHrtvz1ee1/nluabD2xfOq2QYJmLH30QIzOfR2FZlwFMR0ejiYqT+nihLd7MbjZnSLz4+Ujt/ZCDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bvZ7840m; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7955dc86cacso267855685a.0
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718647753; x=1719252553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z9GdxrPO2MLCd8f731wHDlufWSwkyCPNseSHb6h3wQ=;
        b=bvZ7840mQ/paBsmPRPxSVBd9fItARG5pJWifKSD0AgfNJs3ckdtYnNpM4aL618vE+e
         SRVXuAxZwGkRu6jYBjciGkORF0fX2B2Kd6uF+AeiBeQcJOeMcEmLaw9smV7F9MK3CStQ
         9IjFii9cZR1xR66PpdVPKayIA/vNIjUMZZdy7/yl9y8JpTs8mus3BXhVoG3dGDgb8pZh
         Ozfu9i3Vvt4rzIKFld+/0kO8r4H7Lo5sH+MpB6RyLd0Bkk25epI0cpOxfCvcCakeRYkw
         XIUAyU82Rkjzkl/rwS+1UkIpupms83PAczB++SFgTjO3R3tlEuswuUIBBXbfgP6yf5iv
         B92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647753; x=1719252553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z9GdxrPO2MLCd8f731wHDlufWSwkyCPNseSHb6h3wQ=;
        b=iEvRCPpPhPnWquUnwUKHnXFOrxJirJIUBHWy62954CIdSaEiUfK5jh0ibbRXdS1IoJ
         7Er10YXOljDDp/5lN9Qx1g1656ybAytyp/Wx/IlR7nrVs6iHAgZ2CUwCwfaJ1j4015JT
         MIR177ao+WO58SUY441vXojX3oXvcwgBIbMI2PCuJjx4T5P3flLD5nXzdgIBCYzEz5gf
         jzMaZpTJKS2MqPGQIVsRG4UC3yLrr/PVNF7xY/ds8L8zjUEpiF8tATiTqew7TfTwaNw7
         6r8JnLwgBZCm6hvUFZiQoQBsdPU1OQSSHfrZj29FS9RgV375Y6eGiiwUe9jOV/X7H0V4
         YQRw==
X-Gm-Message-State: AOJu0YxJkDb3maicq2tGXlSMokRvyQbyGTlxanCm0JzkjJZSWv4JaeRB
	BXWcTcqK24PBhtTwZObTkD8MhTHBh5WV9RK2H7rKalYLvne9ks0ym4kxa1E7+TJHFztGcXdV/r0
	auoE=
X-Google-Smtp-Source: AGHT+IHroIevk21hjLcbft/c8w4BD7iUbwtag7vsyVE2cExFTsXyvzn4MvDWzC/0dInP64m8SG8xzg==
X-Received: by 2002:a05:620a:4410:b0:795:8e7f:8995 with SMTP id af79cd13be357-798d26aa973mr1058999785a.74.1718647752904;
        Mon, 17 Jun 2024 11:09:12 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe4b45esm448173885a.120.2024.06.17.11.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:09:12 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:09:09 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Mina Almasry <almasrymina@google.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	linux-trace-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net-next v5 2/7] net: introduce sk_skb_reason_drop function
Message-ID: <5610bfe554a02f92dd279fad839e65503902f710.1718642328.git.yan@cloudflare.com>
References: <cover.1718642328.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718642328.git.yan@cloudflare.com>

Long used destructors kfree_skb and kfree_skb_reason do not pass
receiving socket to packet drop tracepoints trace_kfree_skb.
This makes it hard to track packet drops of a certain netns (container)
or a socket (user application).

The naming of these destructors are also not consistent with most sk/skb
operating functions, i.e. functions named "sk_xxx" or "skb_xxx".
Introduce a new functions sk_skb_reason_drop as drop-in replacement for
kfree_skb_reason on local receiving path. Callers can now pass receiving
sockets to the tracepoints.

kfree_skb and kfree_skb_reason are still usable but they are now just
inline helpers that call sk_skb_reason_drop.

Note it is not feasible to do the same to consume_skb. Packets not
dropped can flow through multiple receive handlers, and have multiple
receiving sockets. Leave it untouched for now.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v1->v2: changes function names to be more consistent with common sk/skb
operations
---
 include/linux/skbuff.h | 10 ++++++++--
 net/core/skbuff.c      | 22 ++++++++++++----------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index fe7d8dbef77e..c479a2515a62 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1251,8 +1251,14 @@ static inline bool skb_data_unref(const struct sk_buff *skb,
 	return true;
 }
 
-void __fix_address
-kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason);
+void __fix_address sk_skb_reason_drop(struct sock *sk, struct sk_buff *skb,
+				      enum skb_drop_reason reason);
+
+static inline void
+kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
+{
+	sk_skb_reason_drop(NULL, skb, reason);
+}
 
 /**
  *	kfree_skb - free an sk_buff with 'NOT_SPECIFIED' reason
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2854afdd713f..9def11fe42c4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1190,7 +1190,8 @@ void __kfree_skb(struct sk_buff *skb)
 EXPORT_SYMBOL(__kfree_skb);
 
 static __always_inline
-bool __kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
+bool __sk_skb_reason_drop(struct sock *sk, struct sk_buff *skb,
+			  enum skb_drop_reason reason)
 {
 	if (unlikely(!skb_unref(skb)))
 		return false;
@@ -1203,26 +1204,27 @@ bool __kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
 	if (reason == SKB_CONSUMED)
 		trace_consume_skb(skb, __builtin_return_address(0));
 	else
-		trace_kfree_skb(skb, __builtin_return_address(0), reason, NULL);
+		trace_kfree_skb(skb, __builtin_return_address(0), reason, sk);
 	return true;
 }
 
 /**
- *	kfree_skb_reason - free an sk_buff with special reason
+ *	sk_skb_reason_drop - free an sk_buff with special reason
+ *	@sk: the socket to receive @skb, or NULL if not applicable
  *	@skb: buffer to free
  *	@reason: reason why this skb is dropped
  *
- *	Drop a reference to the buffer and free it if the usage count has
- *	hit zero. Meanwhile, pass the drop reason to 'kfree_skb'
- *	tracepoint.
+ *	Drop a reference to the buffer and free it if the usage count has hit
+ *	zero. Meanwhile, pass the receiving socket and drop reason to
+ *	'kfree_skb' tracepoint.
  */
 void __fix_address
-kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
+sk_skb_reason_drop(struct sock *sk, struct sk_buff *skb, enum skb_drop_reason reason)
 {
-	if (__kfree_skb_reason(skb, reason))
+	if (__sk_skb_reason_drop(sk, skb, reason))
 		__kfree_skb(skb);
 }
-EXPORT_SYMBOL(kfree_skb_reason);
+EXPORT_SYMBOL(sk_skb_reason_drop);
 
 #define KFREE_SKB_BULK_SIZE	16
 
@@ -1261,7 +1263,7 @@ kfree_skb_list_reason(struct sk_buff *segs, enum skb_drop_reason reason)
 	while (segs) {
 		struct sk_buff *next = segs->next;
 
-		if (__kfree_skb_reason(segs, reason)) {
+		if (__sk_skb_reason_drop(NULL, segs, reason)) {
 			skb_poison_list(segs);
 			kfree_skb_add_bulk(segs, &sa, reason);
 		}
-- 
2.30.2



