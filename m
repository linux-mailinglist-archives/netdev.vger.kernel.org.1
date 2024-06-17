Return-Path: <netdev+bounces-104215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA9190B920
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3214E28BCAF
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F43197A95;
	Mon, 17 Jun 2024 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JmZlHoby"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466FB197A7F
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647752; cv=none; b=UggWeHiCHcff1n6V3tBRczFEx+g1pCbpU7S2GBXkV9AqMeI2pyXEXVgAwU8xID++paJIKKpeglApt5y2RWWVtYHIxD1Et2dL2n+ZVUdOY9W19b6j5A+RTScvIuNrO2uMONeYPt5UsqHg2c9A4Lq5sYa2CsQe77wFHRDhcEpsJLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647752; c=relaxed/simple;
	bh=vSfiyKkiX4bwsedqVMUi+UNKfQCtnxdJsfNl5zihRVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hq33SsTUeYUEliYIjw9voO1zLJBYOQDWK6bvCEscv6YPIGUZYK7OcmiibufOZh0XqrVNbpmPdzJ6glHISSZFSWP2cv8+dHGFeDGyU6Xvafj2NX+vRnFfVxWHxGSrWXlajKJ3wTsCj3zFQc6IZ+EQn8eOtppbB3EgXAgvr8LJ6aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JmZlHoby; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b9a35a0901so1576611eaf.0
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 11:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718647750; x=1719252550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZfIVT4YSXuJxMsX8GTw0JN3/tH12LSkX+JqfTs4Sf8=;
        b=JmZlHobyVAPEdakgq7N+mNr3CWS6boyxLXSvHkap/Joz2r5e6MJNwf375UZKEYE/Kn
         n+oNbGvZ4tp7iHB6uugMCyNkSItmtDaf1HKiiYp6He9bQlmm0X28u1PpTzpu8+le08wr
         0uS4CpLIaI+YlhnGc/yIWwiHiE7eEMEu71QgjxEypxS133vB/qIVh4f2t+xEXdGdB4HE
         1JoATHyXCwH8QXuFZjOwPo0pqID3dVSHO3fyNPsL67VGIp9UtGNV447UHbAKBzP32k/z
         B6zAvYxSHddTLGTlqS4UIokBFFIjm2yo8XxcKfKGMIypiGESOXgalHRUogB9tzYpF+zm
         m4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647750; x=1719252550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZfIVT4YSXuJxMsX8GTw0JN3/tH12LSkX+JqfTs4Sf8=;
        b=HzuVGdbC7hHD3GaiTfG8JS5SmFGlktUokvqzqghT3h0/IRKPQclj9CWriU1I6ajWoV
         sEUR/sEtMPoy6BhtQf0PA7jzfIrQcdOA9CNsBwxTBOIPM4VJr1VnRXYjXsXG/eBPjwsJ
         nJzULbXld+VW30zDLqGfvRG3qvuSWE44zxZFvUuupNBS2/9RuswfmzKGrK5WpiQbDH2E
         xAcTinxVD9G3cxq9BMQVsNbYiEFB64lnNuFu2qxJUAB1Fzgn+biAxna5A4SKNsqphnG2
         oEtymW9Y1SNrvyp1WzhcV7DGrrwRo28R5QXuTQvjVP3N/sd6Z92w/OI4mlmRWrsWdw7a
         MNkQ==
X-Gm-Message-State: AOJu0Yw220+v/1HlX5vhRboJIvkYl8+JJiwZKE8ag1rhtPioBtJ+9fTw
	LtUYx7hpJc7cymNYUwPrtCrBhNmT5+3j2ZKQJJP0LgF6jeXHLwGBQHZvcP71ZzHlMDRLZQ8goCe
	ekBg=
X-Google-Smtp-Source: AGHT+IE9jF56bGHkxuy4EDvf8MTN7hIIaWkCmKCKEdckhdpm3H4A8L3DbSTHe/yoY2O1z/znNYnaDQ==
X-Received: by 2002:a05:6820:1624:b0:5b9:89d9:c601 with SMTP id 006d021491bc7-5bdadc6e276mr10356825eaf.5.1718647747624;
        Mon, 17 Jun 2024 11:09:07 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c118a7sm58015446d6.38.2024.06.17.11.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:09:06 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:09:04 -0700
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
Subject: [PATCH net-next v5 1/7] net: add rx_sk to trace_kfree_skb
Message-ID: <1c6af55f8c51e60df39122406248eddd1afee995.1718642328.git.yan@cloudflare.com>
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

skb does not include enough information to find out receiving
sockets/services and netns/containers on packet drops. In theory
skb->dev tells about netns, but it can get cleared/reused, e.g. by TCP
stack for OOO packet lookup. Similarly, skb->sk often identifies a local
sender, and tells nothing about a receiver.

Allow passing an extra receiving socket to the tracepoint to improve
the visibility on receiving drops.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v4->v5: rename rx_skaddr -> rx_sk as Jesper Dangaard Brouer suggested
v3->v4: adjusted the TP_STRUCT field order to be consistent
v2->v3: fixed drop_monitor function prototype
---
 include/trace/events/skb.h | 11 +++++++----
 net/core/dev.c             |  2 +-
 net/core/drop_monitor.c    |  9 ++++++---
 net/core/skbuff.c          |  2 +-
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
index 07e0715628ec..b877133cd93a 100644
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
+		__field(void *,		rx_sk)
 		__field(unsigned short,	protocol)
 		__field(enum skb_drop_reason,	reason)
 	),
@@ -38,12 +39,14 @@ TRACE_EVENT(kfree_skb,
 	TP_fast_assign(
 		__entry->skbaddr = skb;
 		__entry->location = location;
+		__entry->rx_sk = rx_sk;
 		__entry->protocol = ntohs(skb->protocol);
 		__entry->reason = reason;
 	),
 
-	TP_printk("skbaddr=%p protocol=%u location=%pS reason: %s",
-		  __entry->skbaddr, __entry->protocol, __entry->location,
+	TP_printk("skbaddr=%p rx_sk=%p protocol=%u location=%pS reason: %s",
+		  __entry->skbaddr, __entry->rx_sk, __entry->protocol,
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



