Return-Path: <netdev+bounces-234108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47A9C1CA09
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8007C642B43
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3013E355045;
	Wed, 29 Oct 2025 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xW3zYa60"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD08D350D7D
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759250; cv=none; b=g/yl4fuF2z7Ypif6dJiyme3IYLro7F+pzXEP/dXfhPkPP8Poxuczu3/q6XTMsfLoXehkOt2K/ZUIe2y9RNIVPRhL4Xy89jZlW/Af5tTFyWmeh/BCRjJSmqW4ayIPh6eqVyVNNAweTJ8SVRqRiJwF3PII0PCNnmPjsPbY/GYvk8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759250; c=relaxed/simple;
	bh=u4TVCGTTMyI3ejQmYvA7xGP3/taitfWnRfRWcu2FQ/c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nKmH6JJTcsiN47cpsD2KyJe9/HoqP61R4/yK/ys0J3wwczhEFvk1KogFMJcRpPWji4ex+LTMHXRmX/ppDQLKAZp1vqFLSipTnGB7amxQFvC6WEsItmq/z1uhUtyEr7m0Xj4q5GGjRYNYVYUg2lHkz/gLxf24zWVc1IpTpWQVc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xW3zYa60; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befc08so221433a91.2
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761759247; x=1762364047; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GVrtRCgDT8VT95j71qPCd2wKa4dUGSX+duncU+ImxdY=;
        b=xW3zYa60wiNSruoYY5ZwqsNKWaZ2nyHxwRLwBpOnlofTjeiftzVhrMGddKY0jyTGmX
         Gi8s2cvOjquJIHkcMThIjgJX+YveE8LP4bjnF+GtZW8fdChdLz0xP/JIXqvM7QXamU6p
         v7/y5oemKpShGPlwznt4HchwnKY8VoHMfnsLkLJ5qocFQCX3vQw5Ww3b/30Go3l4xgyY
         QkjFnM20eimqnYDmuQPhZb8937PJfQi3GDbQo16ZYBKJ/71x092s7B/ph3h0gcFQ8hS/
         YoLXOpcGVCdT04bIsx8fkZjziFpA4nDgCmttjmqkMV6a4Pk+yoa2rmiHgaUbAHnnKAB/
         fgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759247; x=1762364047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVrtRCgDT8VT95j71qPCd2wKa4dUGSX+duncU+ImxdY=;
        b=T/3jjiuicZHWa6XZ5KRQCM+mQwKU+0RkaSBT1Dwl1LUOD3SVuhCC2be38T7JK2iFfG
         Mp3yLjE4czIK/0OOD6m5jfFX928V+YOlBar5jSODrThau/RFKmFUyHPwL+HdH100Rgrp
         2IHXqW5NUYcTFvPdWG0tj7aX1GTHAfuQTgjNCkU+IuPjEzsVHj6Ls85dSfs9aESCDIiM
         19CbU49E6/W8YM1el9fdDcTvWEt/xjLg9T3q00H+OApI565UIHhKtg2cJJsk9hS4tZBu
         d+snbPsperCrZd/LR6rwDiCFc7HR9Wnbl1o/5VKagdV8gH3fr4TT3ivdABi9AQ+NoqhL
         B5pw==
X-Forwarded-Encrypted: i=1; AJvYcCWNqdHE2m/zzPHgDb1drcPY1YSojSi80sVaotgN384p+ozBJ4TiEWO/EXDfN2KkjqSS2nN8cD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZMKn78SncktEyFKUex8IkEBKXP8Wuaabn/zOm19ZyaSR7CZtL
	2IG3CF7ISGVVSXrsUIbS3OXF0LqGSNks1ZszPoYabpC7doH66xY8Lfnw9Vv6SEhoWBwHVeWdG1G
	9xr6WPw==
X-Google-Smtp-Source: AGHT+IF45rw50jh5DAdl4yDIikkOouBlcvGgMmT3NrwEwAnVHCIYpFHaKnNukoAYEw45kaXCY+oZN909xNU=
X-Received: from pjbce20.prod.google.com ([2002:a17:90a:ff14:b0:33b:dce0:c8ba])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c08:b0:332:793e:c2d1
 with SMTP id 98e67ed59e1d1-3403a3044e0mr4213045a91.36.1761759246768; Wed, 29
 Oct 2025 10:34:06 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:33:05 +0000
In-Reply-To: <20251029173344.2934622-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029173344.2934622-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029173344.2934622-14-kuniyu@google.com>
Subject: [PATCH v2 net-next 13/13] mpls: Drop RTNL for RTM_NEWROUTE,
 RTM_DELROUTE, and RTM_GETROUTE.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

RTM_NEWROUTE looks up dev under RCU (ip_route_output(),
ipv6_stub->ipv6_dst_lookup_flow(), netdev_get_by_index()),
and each neighbour holds the refcnt of its dev.

Also, net->mpls.platform_label is protected by a dedicated
per-netns mutex.

Now, no MPLS code depends on RTNL.

Let's drop RTNL for RTM_NEWROUTE, RTM_DELROUTE, and RTM_GETROUTE.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mpls/af_mpls.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index d0d047dd2245..580aac112dd2 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2803,10 +2803,12 @@ static struct rtnl_af_ops mpls_af_ops __read_mostly = {
 };
 
 static const struct rtnl_msg_handler mpls_rtnl_msg_handlers[] __initdata_or_module = {
-	{THIS_MODULE, PF_MPLS, RTM_NEWROUTE, mpls_rtm_newroute, NULL, 0},
-	{THIS_MODULE, PF_MPLS, RTM_DELROUTE, mpls_rtm_delroute, NULL, 0},
+	{THIS_MODULE, PF_MPLS, RTM_NEWROUTE, mpls_rtm_newroute, NULL,
+	 RTNL_FLAG_DOIT_UNLOCKED},
+	{THIS_MODULE, PF_MPLS, RTM_DELROUTE, mpls_rtm_delroute, NULL,
+	 RTNL_FLAG_DOIT_UNLOCKED},
 	{THIS_MODULE, PF_MPLS, RTM_GETROUTE, mpls_getroute, mpls_dump_routes,
-	 RTNL_FLAG_DUMP_UNLOCKED},
+	 RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
 	{THIS_MODULE, PF_MPLS, RTM_GETNETCONF,
 	 mpls_netconf_get_devconf, mpls_netconf_dump_devconf,
 	 RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
-- 
2.51.1.851.g4ebd6896fd-goog


