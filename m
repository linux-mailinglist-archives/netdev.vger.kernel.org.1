Return-Path: <netdev+bounces-71380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB66853222
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF771F21FD9
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C4157301;
	Tue, 13 Feb 2024 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STj3DJm0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CDA56770
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831754; cv=none; b=cBC1M6tOJUAAGK9cV7tYX1sgepgnXffYzlL14LGsO80Qfd1GddOHrE922r6X75Lmxlcyn1wMPZ6Dp84O+aBftFgAtFYYOCpxRRhNN1jWzdwv8m0IVBg5X0AaIRIu95BsvNfm+9PDN7em/L0jvih84mWJmnAx0P0p2rc8PsDIT+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831754; c=relaxed/simple;
	bh=lNpztHeIhP+vU/AniXahwg6keOcyHVunVsd8/2UgXGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P/w3kOdKk6KC31rJLB3kWAox7yYrAkR3cwwUxm/EvjDU5uLiGktXOFX8gT0ZyWc23iZHXpWzxt/aeWBVM5lw7jA2XnIf6bfv8S0fpm8jZX7fh8uc1wLMB0eNdmI2mKR1dwznlw6KLqFCa4H/trt0hjdaYGWDNvlBK1xKXcl7SiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STj3DJm0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e0ac91e1e9so1776745b3a.3
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 05:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707831753; x=1708436553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZayGKMf3TQ9OEvyTjyQA0cAKI964OfzpOO+MSIxTKs8=;
        b=STj3DJm07SwpgOrVYz1r6ft0cnV25/MfN+XItVyiusJwdKv2bn5IGDPwfuq7O3HVlI
         L18vWIghDwzSDtLopFQDiulT7NKnunUbiWf7dsu+4BAxNygaRfggExC4ndw5XmZ+RyoQ
         IJzwTtF85zQ095uC2AIeOGzE+iYJCU+DiAK4G00CWR6kA6aVqHYXVuoiK40s/3zWcOGr
         IdfGutNsENVGlqeQIG3oxbBgQWfndrRhbdG0cftrYA/JWqmzUfvwH6C5+Py+xqBNRCoN
         Txp7YxRZwXaNqOhCdLlV54BY7xnnb+3YTQlLBLxzdJKBzl9g8tvXoDZq/Dgizflx5qvX
         p2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707831753; x=1708436553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZayGKMf3TQ9OEvyTjyQA0cAKI964OfzpOO+MSIxTKs8=;
        b=SCHu9cwNgl0FJC1kWJFkAuX1hzB7MdOZcHLD3aRtOGk+UaJaODODejYrFW5KTI8QuN
         V3XSk+XWYRXOj23VCy/pbrXQcv6FOpDHtG+vC5mTcG3y8FzFdXiJ/iz7v8SA3evNDAmd
         q5xq+Z/fuvpR/1CedG4RJW7okQ8z0RnjqoBGB5oi4akSyLkeOpykujL4LrYUldK0JzyH
         TTyshJM7+s4fe3kaV2/FScRnhUVINHqHxmwj6FeLiovAsFQyLg315Zs4Sm4lk47FGZpv
         D9lYf220VCgd8L76mqOUqpMGzZ2um/2Ub1xK8nEmR8tQ38WNhrXCgnTchJmOhJcrrCqR
         yy6Q==
X-Gm-Message-State: AOJu0YzabLVW5ZbnBvJt7B8Ao8XzNrewjKFjNT3kxPdPHBdtQzey3qUZ
	ekZqQFr5wPZ8UUr2iE3p57D9lnhkPb2AOdjDG2BBfxi6favQU7o1wZ7EiGb36rE=
X-Google-Smtp-Source: AGHT+IGc5uCa1qtjQlxhgyP2/Cw6OZmlZW5RnBS3ZXEGjNLlO2OsrEUHa5NKA1PBsQvLv+okSpkIJg==
X-Received: by 2002:a05:6a21:8ccc:b0:19e:9af8:40e3 with SMTP id ta12-20020a056a218ccc00b0019e9af840e3mr8857973pzb.16.1707831752620;
        Tue, 13 Feb 2024 05:42:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXSqB1Nca69wbVoQp1t48Cer29iDLwXPLwLuZT4HQ9hCijLRCqQLgJjoeHFK9H1zICe3u9VzqdwK2hTQoNFOXkA5f6Sy6Z2VtCLiYrOaOsfMS/a5niqsGgHKsSAiDjQ4XcMOaOB+U0L0KmIN7t5+kf/AA11L0RnxyImg1sLwfQu1oUTe35Ruq2gF22ZWRj2ZYf+QZCnZ4sjLr0SWQ5VBxAl9JpSLT45qLwv3zx6cKraWHYIxuRElyrD6+fwqh5xp/we
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id fa3-20020a056a002d0300b006e042e15589sm7323041pfb.133.2024.02.13.05.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:42:32 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 1/5] tcp: add dropreasons definitions and prepare for cookie check
Date: Tue, 13 Feb 2024 21:42:01 +0800
Message-Id: <20240213134205.8705-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240213134205.8705-1-kerneljasonxing@gmail.com>
References: <20240213134205.8705-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Only add five drop reasons to detect the condition of skb dropped
in cookie check for later use.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
v2
Link: https://lore.kernel.org/netdev/20240212172302.3f95e454@kernel.org/
1. fix misspelled name in kdoc as Jakub said
---
 include/net/dropreason-core.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 6d3a20163260..065caba42b0b 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -6,6 +6,7 @@
 #define DEFINE_DROP_REASON(FN, FNe)	\
 	FN(NOT_SPECIFIED)		\
 	FN(NO_SOCKET)			\
+	FN(NO_REQSK_ALLOC)		\
 	FN(PKT_TOO_SMALL)		\
 	FN(TCP_CSUM)			\
 	FN(SOCKET_FILTER)		\
@@ -43,10 +44,12 @@
 	FN(TCP_FASTOPEN)		\
 	FN(TCP_OLD_ACK)			\
 	FN(TCP_TOO_OLD_ACK)		\
+	FN(COOKIE_NOCHILD)		\
 	FN(TCP_ACK_UNSENT_DATA)		\
 	FN(TCP_OFO_QUEUE_PRUNE)		\
 	FN(TCP_OFO_DROP)		\
 	FN(IP_OUTNOROUTES)		\
+	FN(IP_ROUTEOUTPUTKEY)		\
 	FN(BPF_CGROUP_EGRESS)		\
 	FN(IPV6DISABLED)		\
 	FN(NEIGH_CREATEFAIL)		\
@@ -54,6 +57,7 @@
 	FN(NEIGH_QUEUEFULL)		\
 	FN(NEIGH_DEAD)			\
 	FN(TC_EGRESS)			\
+	FN(SECURITY_HOOK)		\
 	FN(QDISC_DROP)			\
 	FN(CPU_BACKLOG)			\
 	FN(XDP)				\
@@ -71,6 +75,7 @@
 	FN(TAP_TXFILTER)		\
 	FN(ICMP_CSUM)			\
 	FN(INVALID_PROTO)		\
+	FN(INVALID_DST)			\
 	FN(IP_INADDRERRORS)		\
 	FN(IP_INNOROUTES)		\
 	FN(PKT_TOO_BIG)			\
@@ -107,6 +112,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_NOT_SPECIFIED,
 	/** @SKB_DROP_REASON_NO_SOCKET: socket not found */
 	SKB_DROP_REASON_NO_SOCKET,
+	/**
+	 * @SKB_DROP_REASON_NO_REQSK_ALLOC: request socket allocation failed
+	 * probably because of no available memory for now
+	 */
+	SKB_DROP_REASON_NO_REQSK_ALLOC,
 	/** @SKB_DROP_REASON_PKT_TOO_SMALL: packet size is too small */
 	SKB_DROP_REASON_PKT_TOO_SMALL,
 	/** @SKB_DROP_REASON_TCP_CSUM: TCP checksum error */
@@ -243,6 +253,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_TCP_OLD_ACK,
 	/** @SKB_DROP_REASON_TCP_TOO_OLD_ACK: TCP ACK is too old */
 	SKB_DROP_REASON_TCP_TOO_OLD_ACK,
+	/**
+	 * @SKB_DROP_REASON_COOKIE_NOCHILD: no child socket in cookie mode
+	 * reason could be the failure of child socket allocation
+	 */
+	SKB_DROP_REASON_COOKIE_NOCHILD,
 	/**
 	 * @SKB_DROP_REASON_TCP_ACK_UNSENT_DATA: TCP ACK for data we haven't
 	 * sent yet
@@ -254,6 +269,8 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_TCP_OFO_DROP,
 	/** @SKB_DROP_REASON_IP_OUTNOROUTES: route lookup failed */
 	SKB_DROP_REASON_IP_OUTNOROUTES,
+	/** @SKB_DROP_REASON_IP_ROUTEOUTPUTKEY: route output key failed */
+	SKB_DROP_REASON_IP_ROUTEOUTPUTKEY,
 	/**
 	 * @SKB_DROP_REASON_BPF_CGROUP_EGRESS: dropped by BPF_PROG_TYPE_CGROUP_SKB
 	 * eBPF program
@@ -271,6 +288,8 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_NEIGH_DEAD,
 	/** @SKB_DROP_REASON_TC_EGRESS: dropped in TC egress HOOK */
 	SKB_DROP_REASON_TC_EGRESS,
+	/** @SKB_DROP_REASON_SECURITY_HOOK: dropped due to security HOOK */
+	SKB_DROP_REASON_SECURITY_HOOK,
 	/**
 	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc when packet outputting (
 	 * failed to enqueue to current qdisc)
@@ -333,6 +352,8 @@ enum skb_drop_reason {
 	 * such as a broadcasts ICMP_TIMESTAMP
 	 */
 	SKB_DROP_REASON_INVALID_PROTO,
+	/** @SKB_DROP_REASON_INVALID_DST: look-up dst entry error */
+	SKB_DROP_REASON_INVALID_DST,
 	/**
 	 * @SKB_DROP_REASON_IP_INADDRERRORS: host unreachable, corresponding to
 	 * IPSTATS_MIB_INADDRERRORS
-- 
2.37.3


