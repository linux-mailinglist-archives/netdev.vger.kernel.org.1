Return-Path: <netdev+bounces-74994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7397E867ABE
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284B01F2B272
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23E212BF26;
	Mon, 26 Feb 2024 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z6+jdeDb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE212B153
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962668; cv=none; b=JEwAbWaFqFXL2a8jC9xI+i5s5kabj2JkD2A9+MKCzZqlZ0UFu/oHu2DNliOtSifT8dsNP2tG9ro2y5qaQloJR13x93UC/W1NohBMbfmG9z6cZc316BTPvNQsVoQBneGjysUo/S3cmUFWnhJw2GFSdMUktGi5QBhRYIgYh3b0Oow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962668; c=relaxed/simple;
	bh=i8XZnKq7CEvtdxno2TiJNwE4AVDucR6+uLav2Z0NyLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M931Iz59DQfaY+LEy00/KCZ4YSQpQFPtjB8ZjV3aCWQibWc6b+pY/5pi+AU/GRCR7hqhb8xqV0LK4vJu7PmyGCbzc6e0vtLiGRxtsn6MrBvkCiKRXCaJs4rys0K8slUvRgbULNVEx7bAzGus9dutYyIPXnxYGeEZakiaenz4+aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z6+jdeDb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so4400033276.2
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 07:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708962666; x=1709567466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SdBZXBk2gv6UW277qt+gkbQY2W35kI58cJkB4PnWA1I=;
        b=z6+jdeDbOgcFwqOPoyezhVHndbG4OZXC605vpDIoQNT4jeYYVuBRJzds/Knu3MsS8l
         JI60fweBC1P8Js9u1HcN0vebV9aUi8V9v6PeP2Li6wvfZcWX26LDQLuvcihcS3hdO0TJ
         Ldd9oiKTKewnZyEb135+5vnIyBEcEoiV1OJquzb7Q0KFCqfPDjU8ZJzYTw2CnCaS5z/6
         S1azV2U7Jo0WxMRANEpYp1EBaw5oLLYBFyXyPXtzI8zyrZAk6caTGLNlM3crV3GUXwWk
         klGCtTw2y7i0ff2XvWL6eb0AMU61xdPI8f376RIGfwZ5hQ7AaGhLSxpfKdE1sClw+lRl
         u2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962666; x=1709567466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdBZXBk2gv6UW277qt+gkbQY2W35kI58cJkB4PnWA1I=;
        b=IBlDJ9PLWEj0+wu0qLkXMsM9geSF6f44a0nxkfZNPiR0aa4L6yhrNPdlsP5vn87x/l
         /KzOxE7wyLHUoJlBb9tNSOvOB7l6C42XRQwulqPsVVsme/fAF0l+/oqJCY+yO+fCxcgZ
         i81I+reFSV/wg4ep1peIDaasYXOy5AP8mbECpPQECqlm9NIy5SPs839a2b2QUTJvi1Lr
         kHfHCiJFrfzgQRpPT/BWDjfIftFNhwxvribnskOReprBKj9C/7W/hYodaxHU+41AYaQI
         SGV9L/tBBmRqZX4BQJcmhdE8a9Jg80+wOE7xc0f8OgV+tMBFjUoVYMgK0nfDg14O4ERJ
         cWgA==
X-Forwarded-Encrypted: i=1; AJvYcCUt/yecmir3VmNzuOTM8GNtLrlvhTr4NLdDtcwTPdSH22R0ZpNgzKThkvN15IxNKLO88p7u+J/lOJYCH2C5u0t4reVIHvc5
X-Gm-Message-State: AOJu0Yy6RSGizPN4DDOvsuY180AHip23GhszRBxlmKdLWg0dNj+EMGbp
	OfFp3B88onEvKVAgxLuK8NqHQFRN5GU2cLvbteeO+sAGmgnmMTiW/8qCbRmrkBI91O53kQR4FKs
	kSjqfZn1Nsg==
X-Google-Smtp-Source: AGHT+IH1vIscSmrZQR4rf53Il9+JBJuujNV5MTlyyfEiKzHmzz+JwcE/MZqiFxxKRfFG61FFuvqc7FY7kREoew==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:726:b0:dcd:b593:6503 with SMTP
 id l6-20020a056902072600b00dcdb5936503mr282895ybt.2.1708962666306; Mon, 26
 Feb 2024 07:51:06 -0800 (PST)
Date: Mon, 26 Feb 2024 15:50:43 +0000
In-Reply-To: <20240226155055.1141336-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226155055.1141336-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240226155055.1141336-2-edumazet@google.com>
Subject: [PATCH net-next 01/13] ipv6: add ipv6_devconf_read_txrx cacheline_group
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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


