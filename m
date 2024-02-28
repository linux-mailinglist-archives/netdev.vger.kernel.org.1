Return-Path: <netdev+bounces-75741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29BA86B0EC
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67D41C25BEF
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABF4155A45;
	Wed, 28 Feb 2024 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MpH5h61r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A695A36132
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128485; cv=none; b=V3bIc/21su6RS34owEBe9vEwYvOdvMBHx6MJJhLHl4KFLAV34k3wYTsCP2WNzH8RId34QEv0WxMSXRscOWP2r9kP4xz48dxZ4CTx45By2Ty4t6CrNVQxYOyoTuAjTAyLAKbFKZIZehYm58v3Ikdg57h2jl81qGGqC8xtUOrMqw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128485; c=relaxed/simple;
	bh=LAj1gOQrVPYZ8gqf75q3u1GU6lwBEtEOHkfujLQDOwA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SmvG4VZ+KzsIbBr1IWLArUqKjqUuH8ylVCmWFuqBaEv/MXsjt+9SLBIvnt8MQi1UKLFNy5QOskdJpP1P9CbU1WDp3dkWUwiwaC+I8652X4tbE7mHhDGmzDPzUTCnQ4oLN5017d6szl74uDdOVg/nhPe4z56Sr0/YqOGM4/tGCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MpH5h61r; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608cf88048eso76824787b3.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709128482; x=1709733282; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EtXCLfpS6OZMuKCZ/f5A+kqjwZnwBBWN5rfeZmgSot4=;
        b=MpH5h61rYtyqMsOmGVOOIPvPCnWVAGqjISEZm2MYF0syaRH88IpS6D+Ttb1CocTnEa
         ogwXBIgdlyYNiHIfzfPgEKL0aXL2j9N4kk/mRq+sDbqfwr5y5K+6tEAG8b3SYgVYPwnl
         bTSUTQTWwYtA8RPIXzj464Kl9S18YIpBP7CvBBcHKfbmvobsQrmGO3CrG7gwWSskvt0P
         S2ErVjINUkBYzdVDvELM6MyMawEYFJOLBhRHTfe82kxp75POCb7A66GhRRQ1d3e0gRSI
         NY0+0B2VuKuTcf5sj9neosVXSm8AFkMk7xZPpFC9w7BUI3sF6DcDVORcqOwHuAijqUC8
         cQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128482; x=1709733282;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EtXCLfpS6OZMuKCZ/f5A+kqjwZnwBBWN5rfeZmgSot4=;
        b=Iyrl2D9zda8c7jr2b27RpDeed3rf9zvbXT5zMBu/l8JTEqsCn0RJqIYPdfkp0b3yfR
         y4eOtRvbvi1uEv1Y2UWUpeISPDIOT4VB/MhxUXhsFGJdcIFUrpZgcW+EAAbIqgEl0S/G
         VVUpD1Bt21RYm3VaYUlSmtGksWgn5AHu/nB9cYA7zkICUB8ckLi2tVZU244GxTZmKNYm
         VCviuWiq5ogbeHO3rjfsYc1kDsA+7NTzfD/L5LBbArWeSdQrBmo2irm9D1Qe1Mn/Ol95
         5pSQi8YIO7jmNaXmAQx4xNfYU4O9bs4naBuujaCElMp4XshN9gEaDD1cyHAtx7eVvyWK
         zvpg==
X-Gm-Message-State: AOJu0YzLCStuA15AkJPuM5bBIj7NpSSLGGb5Rw1g+tXubm1pgWjKlacQ
	ceG2rJKEMGdeqANSGgVJLhIGj+OBrmmcOUIqJLgJLIzUBPGfqMpqlSgwDD27spPLktApPr9iMN+
	vkTmAYOI/9A==
X-Google-Smtp-Source: AGHT+IEWPolryLRbNjuX4vlQButnAeflXpzbBkjByOXThz8G8SMk5AqNplm02wrW3PiVq0hVvtaBOvMg/ZQrZg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:d511:0:b0:609:2031:1e09 with SMTP id
 x17-20020a0dd511000000b0060920311e09mr1172510ywd.6.1709128482686; Wed, 28 Feb
 2024 05:54:42 -0800 (PST)
Date: Wed, 28 Feb 2024 13:54:25 +0000
In-Reply-To: <20240228135439.863861-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228135439.863861-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228135439.863861-2-edumazet@google.com>
Subject: [PATCH v3 net-next 01/15] ipv6: add ipv6_devconf_read_txrx cacheline_group
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
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
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
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


