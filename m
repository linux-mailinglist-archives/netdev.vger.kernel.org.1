Return-Path: <netdev+bounces-76146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D6486C833
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 12:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1AD28AAF4
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 11:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED777CF12;
	Thu, 29 Feb 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iuunyJdO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674AF7C6EE
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206826; cv=none; b=qABxB/fOQ2CmyBwX7MiHS25X+DPu61vbbHOAGEt7KfOmDyHL6DVrLvXSDH4iDYpL6KyGXMYsTw+LSwduCLyT34wAy5TZvIwajU4pJpY7PztJRZDdYJJyGhnVFh/r6JDoeL4hlmu+vq6WwhbLewzfzCveBR/9mC8MhsTW5Rng3ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206826; c=relaxed/simple;
	bh=+gHYWJhj0cAfCmOQkc3zktPP+uYTv3Vnj3ST7p8Yiq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IdWr/ncKQLfIBE/QHAjeKrcPjAufwVRtpNWzFH2ioSJVIk/FHHG1JeX0SnsHPi0RIHuWzv8bXvlCy1GfEbma6ekdJ3OTAZ6gTHF9v02vKvkyFsNDnX5SL1w59uloRVoiLZnE0jY6wZxEBkmv+gRvxuFfiE1k2yb+CIJ5H0SZnVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iuunyJdO; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so1555276276.2
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 03:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709206823; x=1709811623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R23jv+b4v7pcWmxlj/OuBFH2S+pqQwn8TVi6lbSuZ1A=;
        b=iuunyJdOeAMGhw+DMIi+Danr1dfPbtqLdkCCX3s8itc3aGD/ot5zrCTxHTsoIWshoX
         MBriRjA9ZBAyqIvvXjqAPrVO3d1llD37Eoe5BcuaC+wv49ZeUgKZiFxDeOm6tOydloav
         2anOcbttP79hihX7dNX74oA6Rebnxwcbc1uVnikMjR4WRFKxRLX65zlY0JPnO82MUoy/
         XYei2J8psBYYALLDOtGy1O5+ijVngfxCtlV/45uUYyyh+49OxL2MXYR0EYvzBBKdJ1sD
         3lurLBVp2hVwhUuenoX5CGBmfFLKTifdcUpvZMWn4fP6sqo6bVoyqLe56qgGwzli63N9
         kNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709206823; x=1709811623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R23jv+b4v7pcWmxlj/OuBFH2S+pqQwn8TVi6lbSuZ1A=;
        b=McABvbVPOapCLQkY2bDJBOphrq0euRjNRHFfT6SgMZTFbddk/6oFhnW6PIIvMzeO43
         HPCHuQjWq5xTR1JxOoY23Z680loz+Jt9rwqGtgA3eTxHTGQSC7id64TjzV8J9ihlIeEZ
         av8+6Cg2Q13T6+bgwWP6dsk0Mx0TuKJNtiiBA3QUoRNdnqCMDCtAG6B/QrsyGF+hcm+W
         QkAlf2KDuGTRTb3MQQfJkwDhoQppiU9KMnfao76b7Z/1ZB5UQIzAvCATv1h3fCeMI98l
         ETp2S9dsiStFhY7m/IzAVuATbqAXvRLCnhU0RmCBTHR3paWrvcQY1048bJjeyq9iNj5s
         EZzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWupXUDcrljMC/w4Kh/DdxC86zthugK1Bk8t4flyAzJD0OmR5iyFQcF8mRV/kcUx885p7xtdlTTQK9u0iJ6Jns8aYA2JWQv
X-Gm-Message-State: AOJu0YwlnnPijT2c7Jspd0cvSePYQ7MtuS8g7jEKwT9hBQf++HNJE7UL
	F7DagT+jBs7vnzLqPlur1M3Av+dZDOnRA0oDirF/Mo96eVIeTfuLD+CUrKqcGBJfM0DnIA5y26a
	RaP+SbLj5HA==
X-Google-Smtp-Source: AGHT+IEQthekvX7tNV3MwE5K+8LyBEo9tw7AVeEk+4itItQFXrWKswQXtVEg8kb0V3y2LCgoPKnYs+kHu1EaZA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1102:b0:dbd:b165:441 with SMTP
 id o2-20020a056902110200b00dbdb1650441mr524047ybu.0.1709206823470; Thu, 29
 Feb 2024 03:40:23 -0800 (PST)
Date: Thu, 29 Feb 2024 11:40:13 +0000
In-Reply-To: <20240229114016.2995906-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229114016.2995906-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240229114016.2995906-4-edumazet@google.com>
Subject: [PATCH net-next 3/6] inet: annotate data-races around ifa->ifa_preferred_lft
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@nvidia.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ifa->ifa_preferred_lft can be read locklessly.

Add appropriate READ_ONCE()/WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/devinet.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 99f3e7c57d36ff028edadd4efd66d996ddc5d9b4..368fb56e1f1b2e3b7888f611a3f113f3bd5fc2af 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -714,11 +714,13 @@ static void check_lifetime(struct work_struct *work)
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(ifa, &inet_addr_lst[i], hash) {
 			unsigned long age, tstamp;
+			u32 preferred_lft;
 			u32 valid_lft;
 
 			if (ifa->ifa_flags & IFA_F_PERMANENT)
 				continue;
 
+			preferred_lft = READ_ONCE(ifa->ifa_preferred_lft);
 			valid_lft = READ_ONCE(ifa->ifa_valid_lft);
 			tstamp = READ_ONCE(ifa->ifa_tstamp);
 			/* We try to batch several events at once. */
@@ -728,20 +730,18 @@ static void check_lifetime(struct work_struct *work)
 			if (valid_lft != INFINITY_LIFE_TIME &&
 			    age >= valid_lft) {
 				change_needed = true;
-			} else if (ifa->ifa_preferred_lft ==
+			} else if (preferred_lft ==
 				   INFINITY_LIFE_TIME) {
 				continue;
-			} else if (age >= ifa->ifa_preferred_lft) {
+			} else if (age >= preferred_lft) {
 				if (time_before(tstamp + valid_lft * HZ, next))
 					next = tstamp + valid_lft * HZ;
 
 				if (!(ifa->ifa_flags & IFA_F_DEPRECATED))
 					change_needed = true;
-			} else if (time_before(tstamp +
-					       ifa->ifa_preferred_lft * HZ,
+			} else if (time_before(tstamp + preferred_lft * HZ,
 					       next)) {
-				next = tstamp +
-				       ifa->ifa_preferred_lft * HZ;
+				next = tstamp + preferred_lft * HZ;
 			}
 		}
 		rcu_read_unlock();
@@ -818,7 +818,7 @@ static void set_ifa_lifetime(struct in_ifaddr *ifa, __u32 valid_lft,
 	if (addrconf_finite_timeout(timeout)) {
 		if (timeout == 0)
 			ifa->ifa_flags |= IFA_F_DEPRECATED;
-		ifa->ifa_preferred_lft = timeout;
+		WRITE_ONCE(ifa->ifa_preferred_lft, timeout);
 	}
 	WRITE_ONCE(ifa->ifa_tstamp, jiffies);
 	if (!ifa->ifa_cstamp)
@@ -1698,7 +1698,7 @@ static int inet_fill_ifaddr(struct sk_buff *skb, struct in_ifaddr *ifa,
 
 	tstamp = READ_ONCE(ifa->ifa_tstamp);
 	if (!(ifm->ifa_flags & IFA_F_PERMANENT)) {
-		preferred = ifa->ifa_preferred_lft;
+		preferred = READ_ONCE(ifa->ifa_preferred_lft);
 		valid = READ_ONCE(ifa->ifa_valid_lft);
 		if (preferred != INFINITY_LIFE_TIME) {
 			long tval = (jiffies - tstamp) / HZ;
-- 
2.44.0.278.ge034bb2e1d-goog


