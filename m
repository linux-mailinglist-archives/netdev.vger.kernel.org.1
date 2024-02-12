Return-Path: <netdev+bounces-70859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9849D850D5F
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 06:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18BD6B22E64
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 05:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B13A566A;
	Mon, 12 Feb 2024 05:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtP+vZAE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177FD6FA7
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 05:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707715540; cv=none; b=EfDiqu1mUyuNeBkVM3lAmdk/yUWzxy6iDuxKf2O81/9d2Z+G67Fcd7CulvK5kPmRDzDVoHewOAyeW4Sq7AyF+iT1wlAKEHU4LI+0KgiMmHZeVXC4eBVaALhbNfLCBJMH5gDb2dEBBYhYpjof7ZtLzg8U/2bPo5JbRP0Y9cbGrOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707715540; c=relaxed/simple;
	bh=JW/5J2iAOjTAEBaHinRWRnzJW3QPBLMKfqS+lcKAHsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vBtAf10+XNqpY/g9BsfdNtuzzwAFLwnNr0xrhQmpyVHtWNuUUAoHA6r2CRASX2WSmbaVD7Eu220nfugT6IJmN5Q0xZOM5+y+QSRTU/dQn4gG0wZVZsE6KlezVChPde0OqCQumP6QHcLKEakmBxjmsM8yRsPUOBqilszk7a6Tyl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtP+vZAE; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d3907ff128so2328117a12.3
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 21:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707715538; x=1708320338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ic0yF8IFXpCCRvKYAPqREiXbogel5udRXcjEQOQT0fE=;
        b=mtP+vZAE9ub7oajLko3TbSn9EJXm/YoyXB2xLHI+P1i44/kyWCtl6v7RVPRdeQF6Mo
         7fijou79WrxCBPV3ZZsVKfM+Ji2vXhxCDd3tt8pWKsCPjeNedCA6apgWL2DQxgMekX5U
         RCl5yOjVHqlYgShB+d5mNyojxnwJPaKiSJtAxiyYn86tTHUX2bKTAawh5VTxPiXbB0iX
         U/gsmlDtNayov+5UqYTigiZ4Syav6YywBtILd/DVPqq8ZnscD4ICrKARNuNMO24GDSdX
         +iQbhpN7zzJdbLFuCXX5XNjY+j7lLCjAQ5CfhMTbhk90Apzync2g4kRZjRlOdQ1Bod7M
         2CKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707715538; x=1708320338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ic0yF8IFXpCCRvKYAPqREiXbogel5udRXcjEQOQT0fE=;
        b=WWiwQ/B7hl7Q0sMCKnsadqDy1cwrgCWD8z0xtjF5Zn4MgMpn42xC2iNk3hb66XQ2NQ
         L6trr3D3qwfvTMHJu4SG9xgStmeaCGKDhBum7Uqqd0Wm0lqdXQqrmYx/iHDbsSnqNJqg
         TGEZoBMn/caALO9ZhYzKXZufp0v2a9oFxtp0JsjLVbOlfu/Y2PX+mC/JlWxwjDfNJm1g
         s72Nhm8vu9kq0znGM+3F9ga5Kh5u6O1Ebo/Iigieit/hcsiOz0Fs303FoqW8L87g8aHD
         4IPNwBT7fpiqlEbCcUpBPtbNwhNQfmRI5umqEj6LQCSgt0q8X/GPRp8YbGT0kbkpVZM5
         eZxg==
X-Gm-Message-State: AOJu0YwbK5PGjTTVtQkKsA4XwjGgGeiA8W8TKDSGMFY4w82A3RSBvFkR
	LkBuoRhW27V9sU3SPimzX4fWDnK8OlP/wq2OcSomeAdYzwZwWYew
X-Google-Smtp-Source: AGHT+IFiUXdhOpgZBcSVdC41/rJ3q3xARC5/xD5/EKilxb+oWleGQJgJAJCM0vn7f0nUei6RL/xzvA==
X-Received: by 2002:a05:6a21:3115:b0:19e:aaa5:7b52 with SMTP id yz21-20020a056a21311500b0019eaaa57b52mr8594551pzb.0.1707715538324;
        Sun, 11 Feb 2024 21:25:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWckaKR7mfO56bho5FO8+xZSdpYixWfIbTUxbTkT7Hk3LYKJzeDLSvQZojTRwodV3BjxpgTZsN8egoEIj837PkSsBElm433x8e2fHArn58DJStbS2T0wlI62l1gGit9EYtLIALy4rioRH1cW9tKT8FJM57gVqvzm+Ly6qqp/WPAlzAn0HCtJIp4hRDBBjSeMXDKlLPnM613ehO7JJzF8VcIuZH7HyQkZR1cF0ECyOY=
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id f10-20020a056a001aca00b006da2aad58adsm4725291pfv.176.2024.02.11.21.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 21:25:37 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 1/5] tcp: add dropreasons definitions and prepare for cookie check
Date: Mon, 12 Feb 2024 13:25:09 +0800
Message-Id: <20240212052513.37914-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240212052513.37914-1-kerneljasonxing@gmail.com>
References: <20240212052513.37914-1-kerneljasonxing@gmail.com>
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
---
 include/net/dropreason-core.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 6d3a20163260..7cedece5dbbb 100644
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
+	/** @SKB_DROP_REASON_INVALIDDST: look-up dst entry error */
+	SKB_DROP_REASON_INVALID_DST,
 	/**
 	 * @SKB_DROP_REASON_IP_INADDRERRORS: host unreachable, corresponding to
 	 * IPSTATS_MIB_INADDRERRORS
-- 
2.37.3


