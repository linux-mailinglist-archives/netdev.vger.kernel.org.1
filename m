Return-Path: <netdev+bounces-201906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BE2AEB641
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315E1189CA95
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044582BD022;
	Fri, 27 Jun 2025 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSfskGQS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FCD29E0EA
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023544; cv=none; b=b+WECHe4bwe2eXO/LSn+mssHzK7mSkucWKy2BCWt3X86C2RGyqjThDKAaXeKBYsavQtYO5dEMwXnUuWHFqhRvOIoITU1Jezi9RtzrQwkty08U1g9MVmrvDwZvF3B6avNMH612cpEdYNJ/28STdDH2Wgv127rffpMC9zFx9DqAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023544; c=relaxed/simple;
	bh=C8QrJmEQD6oz+4iAbyjw1kSamPLSOEIQzKkLNRQXS2g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AzgH/2j65Llo4dMxZwHdOw95vH7BGbC1rvPTOcMHXchAXNI/YwUeD+QqnIXUWxbcwi1cmthBT1dHK4+Goby/u9kWCBrkLDt1Wiqfrqy+smCHnvZ7vdDol0jYiQbtdZ6lcQNQ9G+57PLmm7oAagiJm6VdO69KTVxkeVvoetuyMn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hSfskGQS; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a58f455cdbso25655671cf.3
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751023542; x=1751628342; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJIiWsnELBzrZIXL2kTZ6lw2YM9yf9e2e3alIoXdXtU=;
        b=hSfskGQSZEUsz9RfKON54V8hMpy29Kx0H8UTTrX8FqGPqPe0ZP35M/M/42DmUCwyi9
         IDiI9vxQ2c2tTUQwQW8XwsI1oUuiYQ4P4WKuxp3MfukeTG8e8Ji16qHWsNcDukafQ6oi
         e9QsfoQlJ6TKZpu/WfvuX8f8+tOAJ2wKj9Jk7kNi7+zi+4n/UYWmD0IvdPARAfvUoHs0
         UbIUN7VPcYtBoIFnXYJRqmlpIqis4cEob36I+BjtFOoWcarMgDhkYd42dQz+MeIVrP58
         ihT57kA8fxe1FqT2etL30KDo567JnC6DaSg90vZ5F8XwpQRCr5faPePBvCKLBeHyKcwn
         SxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751023542; x=1751628342;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJIiWsnELBzrZIXL2kTZ6lw2YM9yf9e2e3alIoXdXtU=;
        b=dJZ6Ep13aEyfG6W05EhmfNtYyjOxeiFmiJcmI1bNmkIVRfs/U8DQEdR+DxbJ1YwDfI
         EV6ArDF74xagnihTtVph9vM4pVmO7149dBl4agtQGhhFYl2QDmM4oqpajlvaU8FGyVRi
         7ovZEVkTHdYEMeojPXkszREepOaktVMcNlcHCl6vculhJv6KivxSdf0MheWmGPuqvLSb
         o8+r9YcjU70zlCNIX/Dluy9aHulFm/7oBMB/wP3LyGG2wuTKKCLUyzvctcfkGVkO1ABq
         YCtvhalMrzVRntUwZrfKs9wgP+bbYapPrDoVfgOKaGQD3iTd0vjS4qVnYpn/3/E2T+RA
         HYLw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ26fycDZkJdhsypakZD+hE73fLC0PJHJbFfJNAtktUFDrOCShRiDSGLdr1Myj5fQt+qu7ywg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt5WI3Lh1Tp9Q819XheAfXKZ8WnzMdph8RRFeU8UDfsgxlOeeu
	bIB90vwFXj8z4c+h1K2DNzKKXQ3yRCv/ZDD8JXTNBjb9008mn96wqYUT/GCwQIOXGwQLGMp3uLR
	8AIXSDphFSSNHXw==
X-Google-Smtp-Source: AGHT+IEQ3iurlRI7ifX3DaiVd5hkDU6hIfMfW2uX8ECkC0zkCr2ecJpF97hF1atA9YnVLYEstl1Kwvii/os1WA==
X-Received: from qtbbz22.prod.google.com ([2002:a05:622a:1e96:b0:4a4:eac7:c1a0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1808:b0:4a4:3766:3180 with SMTP id d75a77b69052e-4a7fcbe5b6fmr44707371cf.47.1751023542117;
 Fri, 27 Jun 2025 04:25:42 -0700 (PDT)
Date: Fri, 27 Jun 2025 11:25:19 +0000
In-Reply-To: <20250627112526.3615031-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627112526.3615031-4-edumazet@google.com>
Subject: [PATCH net-next 03/10] net: dst: annotate data-races around dst->lastuse
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

(dst_entry)->lastuse is read and written locklessly,
add corresponding annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/dst.h    | 4 ++--
 net/core/rtnetlink.c | 4 +++-
 net/ipv6/route.c     | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 1efe1e5d51a904a0fe907687835b8e07f32afaec..bef2f41c7220437b3cb177ea8c85b81b3f89e8f8 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -240,9 +240,9 @@ static inline void dst_hold(struct dst_entry *dst)
 
 static inline void dst_use_noref(struct dst_entry *dst, unsigned long time)
 {
-	if (unlikely(time != dst->lastuse)) {
+	if (unlikely(time != READ_ONCE(dst->lastuse))) {
 		dst->__use++;
-		dst->lastuse = time;
+		WRITE_ONCE(dst->lastuse, time);
 	}
 }
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index c57692eb8da9d47c3b0943bf7b8d8b7f7d347836..a9555bfc372f5709a3b846343986dce1edf935be 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1026,9 +1026,11 @@ int rtnl_put_cacheinfo(struct sk_buff *skb, struct dst_entry *dst, u32 id,
 		.rta_error = error,
 		.rta_id =  id,
 	};
+	unsigned long delta;
 
 	if (dst) {
-		ci.rta_lastuse = jiffies_delta_to_clock_t(jiffies - dst->lastuse);
+		delta = jiffies - READ_ONCE(dst->lastuse);
+		ci.rta_lastuse = jiffies_delta_to_clock_t(delta);
 		ci.rta_used = dst->__use;
 		ci.rta_clntref = rcuref_read(&dst->__rcuref);
 	}
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 1014dcea1200cb4d4fc63f7b335fd2663c4844a3..375112a59492ea3654d180c504946d96ed1592cd 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2133,7 +2133,8 @@ static void rt6_age_examine_exception(struct rt6_exception_bucket *bucket,
 	 * expired, independently from their aging, as per RFC 8201 section 4
 	 */
 	if (!(rt->rt6i_flags & RTF_EXPIRES)) {
-		if (time_after_eq(now, rt->dst.lastuse + gc_args->timeout)) {
+		if (time_after_eq(now, READ_ONCE(rt->dst.lastuse) +
+				       gc_args->timeout)) {
 			pr_debug("aging clone %p\n", rt);
 			rt6_remove_exception(bucket, rt6_ex);
 			return;
-- 
2.50.0.727.gbf7dc18ff4-goog


