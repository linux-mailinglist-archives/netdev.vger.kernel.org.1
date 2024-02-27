Return-Path: <netdev+bounces-75354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 071688699BF
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E90293CDC
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A864146E7C;
	Tue, 27 Feb 2024 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QblMSDTb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959D51420D2
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046127; cv=none; b=riSoy/dGtCymLzv8gKenaJ/67xl79RlVRD3goCQkzwNtM4jFVYBQi29XIUreXsHTk+V9Xq0bxuvCm12tgy6gKbdSLJ7FwxpDI1Tum/GRtpWB3Oi3D+UUetq6rhL/ZWTuEUofYV26KKUOuZg3/sfPUrT8in/NJzEi9duqc01KObw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046127; c=relaxed/simple;
	bh=i8XZnKq7CEvtdxno2TiJNwE4AVDucR6+uLav2Z0NyLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MCNPEtFEVG2RgjNVICkc4p9SzSAYRZ9xoIaEFMmA0zHLmXK5JLqUfqAiMD/slkTTEf9zHl9VcVyD1bv+xvL0/E3m1ZS4LXnylGAfJ/4L1Y859xZgBIBIaagtWe0BBry9XhKXFroKCyNYc9swYLFB5e9mwLZJnterKozVHzIOV2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QblMSDTb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so6375132276.2
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709046124; x=1709650924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SdBZXBk2gv6UW277qt+gkbQY2W35kI58cJkB4PnWA1I=;
        b=QblMSDTbDZ+DaeJQZhj0MsFqNnyZew0yoSaTeR8HoHRfle2rLJftMcghSaS79ovQZc
         pwW54tTW9Cdk5IaPnOYel1JncNUxXmDAPS1GBB/cDSpHNYgfiC4wFrYZTj40KaZdkHAz
         IeoJ3DE2VNcfIfAiPwvo5zr7+jcSIRnfh49oKCt2j/HQWYIrkXpF6OHi3vn1RPeKM7It
         KqRpNE7vQT2akxOcZy3IeWeqSbA3/ucoJ1/pIhtprWNE9l1uhZayKqijhVcll+9QTK6u
         5EPFn9MQ1lBXnvDVatM9z46wi+HJTQ76AJXw+A8pdbpJdzRCQKvioJrB7XjZtv6OlmPW
         Kvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046124; x=1709650924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdBZXBk2gv6UW277qt+gkbQY2W35kI58cJkB4PnWA1I=;
        b=ZfcKiSHsYinlbpJBycJLMvj6SBmi+5cLJHV9xV/mrstdqKAX7u6LaVif9MVMyAzU69
         ojd5uWTfFt2tXsXM0NdhjDjIyNUZo0F2xeI57jvyRg6967aTA34GekHflbi6mLtjEZUa
         Oz+jEpEmI34tqz2jrrL8YC9up/+1lflISLnW5Gh8kCMUe5YhSrSPYQzQk38cgwpr7HIM
         Y2NoOJ7mzx9FFtWBkemFlsXzvp+fneN74uL/kQihe7ufU1p1W9KMdYrXfK2iD0wInbsn
         6D/MDTjf7aA3QRq+Qk38r4zWXsqIqx/wwyRY0C8WOS7vhUTvMuYVktPQ4HGZsfLNrBEk
         ARYw==
X-Forwarded-Encrypted: i=1; AJvYcCWHo4ha3sXchUUkWQ4XsWeMdMlT4iKgK6gfCU1AmfnczBYzUXhcH4b0WfldG8DUhGWMicDCe28I2JCeDHLeAJ7eokruXqeq
X-Gm-Message-State: AOJu0YzKJAKQHZ7RLykbWyKo8Iv8djEzvDx3y7xNsuWZ7IhtdX5quXC9
	BuMmn7kW8omKFgz67nEl0A6cjLadmCbtVRaSUoNsCNshY0oxq/n3VDXolux4eYPEGxM+SujGu+T
	RWkN5Vc8eog==
X-Google-Smtp-Source: AGHT+IEDgBKXAH32+I1he6Ws5gTYeT7c02Ohd4UH1DMbc6JI+mGLek5Iyn5+uHi0IQPS6cr6qiwKP7koXSpGKA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:72a:b0:dc6:dfd9:d423 with SMTP
 id l10-20020a056902072a00b00dc6dfd9d423mr96259ybt.3.1709046124549; Tue, 27
 Feb 2024 07:02:04 -0800 (PST)
Date: Tue, 27 Feb 2024 15:01:46 +0000
In-Reply-To: <20240227150200.2814664-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227150200.2814664-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227150200.2814664-2-edumazet@google.com>
Subject: [PATCH v2 net-next 01/15] ipv6: add ipv6_devconf_read_txrx cacheline_group
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

IPv6 TX and RX fast path use the following fields:

- disable_ipv6
- hop_limit
- mtu6
- forwarding
- disable_policy
- proxy_ndp

Place them in a group to increase data locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index ef3aa060a289ea4eecf4d6e8c1dc614101f37c3f..383a0ea2ab9131e685822e5df506582802642e84 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -3,6 +3,7 @@
 #define _IPV6_H
 
 #include <uapi/linux/ipv6.h>
+#include <linux/cache.h>
 
 #define ipv6_optlen(p)  (((p)->hdrlen+1) << 3)
 #define ipv6_authlen(p) (((p)->hdrlen+2) << 2)
@@ -10,9 +11,16 @@
  * This structure contains configuration options per IPv6 link.
  */
 struct ipv6_devconf {
-	__s32		forwarding;
+	/* RX & TX fastpath fields. */
+	__cacheline_group_begin(ipv6_devconf_read_txrx);
+	__s32		disable_ipv6;
 	__s32		hop_limit;
 	__s32		mtu6;
+	__s32		forwarding;
+	__s32		disable_policy;
+	__s32		proxy_ndp;
+	__cacheline_group_end(ipv6_devconf_read_txrx);
+
 	__s32		accept_ra;
 	__s32		accept_redirects;
 	__s32		autoconf;
@@ -45,7 +53,6 @@ struct ipv6_devconf {
 	__s32		accept_ra_rt_info_max_plen;
 #endif
 #endif
-	__s32		proxy_ndp;
 	__s32		accept_source_route;
 	__s32		accept_ra_from_local;
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
@@ -55,7 +62,6 @@ struct ipv6_devconf {
 #ifdef CONFIG_IPV6_MROUTE
 	atomic_t	mc_forwarding;
 #endif
-	__s32		disable_ipv6;
 	__s32		drop_unicast_in_l2_multicast;
 	__s32		accept_dad;
 	__s32		force_tllao;
@@ -76,7 +82,6 @@ struct ipv6_devconf {
 #endif
 	__u32		enhanced_dad;
 	__u32		addr_gen_mode;
-	__s32		disable_policy;
 	__s32           ndisc_tclass;
 	__s32		rpl_seg_enabled;
 	__u32		ioam6_id;
-- 
2.44.0.rc1.240.g4c46232300-goog


