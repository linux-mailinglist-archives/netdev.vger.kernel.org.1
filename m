Return-Path: <netdev+bounces-102705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C237190458D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FBFCB252CD
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 20:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA332152DF7;
	Tue, 11 Jun 2024 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XeXz8YVw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0BA152789
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 20:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136690; cv=none; b=L3+bJtrf9dxziHsNXVrBypEgt6lhU9zYv7Rwo6X/bIQxGNj5Hg994buhJgAVbyTcSr+N537KvLVxT70nEUXUfroTP+QD/QP5GNO36qIwJ/6YubicXbE8Ck+yTzN1eN8hnh4SXixpYnh3fuyUM3yFig23X1NaqNY7WvxpsdyOPZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136690; c=relaxed/simple;
	bh=hhH8GnZMFKtdtvPLm83V032mx4PN8otdUOGCLKtSSSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwEexqVdycXCx/zAZTOimEpfdz7BT99AS/MG7vvzbwOtmXzlT7NMad4Th8VfSLYUEG+RAaxySZ0pgFsdxW1+N4OiJ1ZOIZU9pFKm9Yvo3GT9oHnEJRGiS09yyIv927ySTSRGJPPxNsP7/29hVaU67ruPkCae2CvSg8k5FqvGOys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XeXz8YVw; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-797f0c49a11so35888285a.0
        for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 13:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718136688; x=1718741488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NI1bBF93UkH74xgerslgPDj8Tvu8cKRQYZFS9ZEoK6U=;
        b=XeXz8YVwwNsm4V9N2OydCvUdaTUWhiv+1HCm8ewAW8N5uPnZCOcNTgzLBCqWrccEN6
         lV1TAKct/USCsYd0VIY6q/h+Dl6wZ7yCOZNXN/KC8Y1549cbKiThQWimsVssXxdEWFDO
         6fvy77lAm7mkhoF8bTNSkVUw9LCV3hkccy+0tuSOybL3dLEJAuPcQygfbr+YaMezSbZl
         uxeUku5Ub8kcNq8s2DbIsSY71IuxcjtS0rkqI86uNJ5DO04OfTRa+mO3sPJgR4lSkTPo
         6O+OKJ8xtKCs+RxZ/5YDsVSxDdfs8ZQL5crNdVX/9Q077OLf3oZOzrjKisKoFzLs6Nae
         EDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136688; x=1718741488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NI1bBF93UkH74xgerslgPDj8Tvu8cKRQYZFS9ZEoK6U=;
        b=DBdnXPS6kmXUTsbOx37rZzsIlp6LAKtNI5BfM+Rwj61291721hNY/jC8mKg6JoRlmB
         Mn+ocQuru7cqbVsQN3612+SqMvfs0kMcCVXaS/mrufrtlrNiX0qIp6/nmTnqnkkchLWZ
         DCJw0HUSm7H1ElRuhiEodXd/CuB5d6RnionxXnUbVj68RURjqAkiohmPURaQ3kDjKPeE
         Obg50o11nPqa12Iu4pm5aRrZ/zGm8vsTre1VZV7KN2Jme4Nd+5sxTC6QSYOkyMP49yYG
         MAGKo2xa2vwAgMn51ir/KuLV0ZtKLoWhKDFIjs9P3GwUBVzNKAw2xeZg+xbDFUehc4u/
         +3rQ==
X-Gm-Message-State: AOJu0YzUwUrhaYQGG2upeMNbdJRDb3MSoxCqUJ59wndqlXhryaPYRI8n
	soLIK/mpYxFjitBIw2S8zVKiKTDpiRTBE8CqT+3Nyx3ep4CdYZTi7SnBoFbgPEPaOZ2VHQ3H/vX
	ctxM=
X-Google-Smtp-Source: AGHT+IHiCzXvs8wyuKiOi6CTgYFKRuCBKiteO6ebBtGe09HeJsKeBaIOxV5PinkxLBs8LosS3k2Uhw==
X-Received: by 2002:a05:620a:2685:b0:796:a392:a2c5 with SMTP id af79cd13be357-796a392a48fmr691845885a.53.1718136687680;
        Tue, 11 Jun 2024 13:11:27 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7955de5594dsm268565785a.54.2024.06.11.13.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 13:11:26 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:11:24 -0700
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
Subject: [PATCH v4 net-next 1/7] net: add rx_sk to trace_kfree_skb
Message-ID: <dcfa5db9be2d29b68fe7c87b3f017e98e5ec83b4.1718136376.git.yan@cloudflare.com>
References: <cover.1718136376.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718136376.git.yan@cloudflare.com>

skb does not include enough information to find out receiving
sockets/services and netns/containers on packet drops. In theory
skb->dev tells about netns, but it can get cleared/reused, e.g. by TCP
stack for OOO packet lookup. Similarly, skb->sk often identifies a local
sender, and tells nothing about a receiver.

Allow passing an extra receiving socket to the tracepoint to improve
the visibility on receiving drops.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v3->v4: adjusted the TP_STRUCT field order to be consistent
v2->v3: fixed drop_monitor function prototype
---
 include/trace/events/skb.h | 11 +++++++----
 net/core/dev.c             |  2 +-
 net/core/drop_monitor.c    |  9 ++++++---
 net/core/skbuff.c          |  2 +-
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
index 07e0715628ec..3e9ea1cca6f2 100644
--- a/include/trace/events/skb.h
+++ b/include/trace/events/skb.h
@@ -24,13 +24,14 @@ DEFINE_DROP_REASON(FN, FN)
 TRACE_EVENT(kfree_skb,
 
 	TP_PROTO(struct sk_buff *skb, void *location,
-		 enum skb_drop_reason reason),
+		 enum skb_drop_reason reason, struct sock *rx_sk),
 
-	TP_ARGS(skb, location, reason),
+	TP_ARGS(skb, location, reason, rx_sk),
 
 	TP_STRUCT__entry(
 		__field(void *,		skbaddr)
 		__field(void *,		location)
+		__field(void *,		rx_skaddr)
 		__field(unsigned short,	protocol)
 		__field(enum skb_drop_reason,	reason)
 	),
@@ -38,12 +39,14 @@ TRACE_EVENT(kfree_skb,
 	TP_fast_assign(
 		__entry->skbaddr = skb;
 		__entry->location = location;
+		__entry->rx_skaddr = rx_sk;
 		__entry->protocol = ntohs(skb->protocol);
 		__entry->reason = reason;
 	),
 
-	TP_printk("skbaddr=%p protocol=%u location=%pS reason: %s",
-		  __entry->skbaddr, __entry->protocol, __entry->location,
+	TP_printk("skbaddr=%p rx_skaddr=%p protocol=%u location=%pS reason: %s",
+		  __entry->skbaddr, __entry->rx_skaddr, __entry->protocol,
+		  __entry->location,
 		  __print_symbolic(__entry->reason,
 				   DEFINE_DROP_REASON(FN, FNe)))
 );
diff --git a/net/core/dev.c b/net/core/dev.c
index 85fe8138f3e4..7844227ecbfd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5233,7 +5233,7 @@ static __latent_entropy void net_tx_action(struct softirq_action *h)
 				trace_consume_skb(skb, net_tx_action);
 			else
 				trace_kfree_skb(skb, net_tx_action,
-						get_kfree_skb_cb(skb)->reason);
+						get_kfree_skb_cb(skb)->reason, NULL);
 
 			if (skb->fclone != SKB_FCLONE_UNAVAILABLE)
 				__kfree_skb(skb);
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 430ed18f8584..2e0ae3328232 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -109,7 +109,8 @@ static u32 net_dm_queue_len = 1000;
 struct net_dm_alert_ops {
 	void (*kfree_skb_probe)(void *ignore, struct sk_buff *skb,
 				void *location,
-				enum skb_drop_reason reason);
+				enum skb_drop_reason reason,
+				struct sock *rx_sk);
 	void (*napi_poll_probe)(void *ignore, struct napi_struct *napi,
 				int work, int budget);
 	void (*work_item_func)(struct work_struct *work);
@@ -264,7 +265,8 @@ static void trace_drop_common(struct sk_buff *skb, void *location)
 
 static void trace_kfree_skb_hit(void *ignore, struct sk_buff *skb,
 				void *location,
-				enum skb_drop_reason reason)
+				enum skb_drop_reason reason,
+				struct sock *rx_sk)
 {
 	trace_drop_common(skb, location);
 }
@@ -491,7 +493,8 @@ static const struct net_dm_alert_ops net_dm_alert_summary_ops = {
 static void net_dm_packet_trace_kfree_skb_hit(void *ignore,
 					      struct sk_buff *skb,
 					      void *location,
-					      enum skb_drop_reason reason)
+					      enum skb_drop_reason reason,
+					      struct sock *rx_sk)
 {
 	ktime_t tstamp = ktime_get_real();
 	struct per_cpu_dm_data *data;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 466999a7515e..2854afdd713f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1203,7 +1203,7 @@ bool __kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
 	if (reason == SKB_CONSUMED)
 		trace_consume_skb(skb, __builtin_return_address(0));
 	else
-		trace_kfree_skb(skb, __builtin_return_address(0), reason);
+		trace_kfree_skb(skb, __builtin_return_address(0), reason, NULL);
 	return true;
 }
 
-- 
2.30.2



