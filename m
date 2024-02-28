Return-Path: <netdev+bounces-75749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD0286B0F4
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CC21C21915
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFFF153512;
	Wed, 28 Feb 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTG7r0u3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F11586E4
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128499; cv=none; b=dcqqscKx7jvD62/b6JKJapuUbpLb2jewwOljh/qpLpiiWqsEGfOyRPpnVLmIYqkBcFBvHMATG7mFAgj2k8qlCXpCX6yKUnKO2J1s2iCckZEyfK1+B0IMqLNcbb/V1BPa2Yg3A5KY++P1PXgFX8UPH9rCRbkiRW7e6NY6Hnu0Rzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128499; c=relaxed/simple;
	bh=7zwgaBOw2eLC2MLjKew1aryKHo37TVGSNJYtAe9Zf5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WpZSS41jIizcYjCgXefJnUHhhImysE/c6de9D9nUYn3/lwp5hqtRLln7F/k9WsqtmBOkWF7xxWT7/zPphrz9i5n8fZhpacOpv2OlLrmS9o7Fv6j9Dn4j96RExuJsSsP9SNItSBkgKM+L6pYAa7SGgA7CAZRPFaHwMvCzJwcDCpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTG7r0u3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60938c2dbbaso15160547b3.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709128497; x=1709733297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WTrsKUxf/0GG0WXUlx8/nW/+9j3jmatd2lZxXX3kf2A=;
        b=dTG7r0u336qJyRRv5TDDUxMikrd9lQ7S00w7HvTIZfyX8tidkKYjkI2N3U7ziMGBxL
         yUNTsO+OumgA9UxDKZIXc+tDz/u2OWXvH4NDQivHW4Lt0FBL4igBYok3xdlKBmxXan4N
         jX5M9p/CD3ER4HpAIMLFJv6QEOhtGS2D+Mx/ypWGPlH+eRPaaeLhV3nEeuhwelDol5jm
         w5uSpbkNf/wc+yzeC/Tz8fD4156EK+C2+uxqWGwOcoN3xSgvavsmjN/qsRJep+RKyd/V
         j6y62dTEUutAcCL0aGDPf0mOrFkgVXVIoBaLPFvjJ5ZfEoFnMszzGg4S8dhxMPeEKxbR
         Z57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128497; x=1709733297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTrsKUxf/0GG0WXUlx8/nW/+9j3jmatd2lZxXX3kf2A=;
        b=KBo1Tq0xkw4tL32X+JYNKsRfnB2vECvNmcc2apjRaYsnU5765KIU7xAWQ2lWJN5QNX
         8OEGzmDzibJvvwgyXqSYjzSLG9jo2ijMXBsTh+Q0t9B6t61VIemUKLBrQFZbEkqFUJgi
         qvp6G6SvLxZzE9zlNMhcyHViX4i7lT/NcPAxDlqvFNEB/wCeU8g9MzA1JCU6hjPVXcVq
         fwIHyc29bajXl8ZfGSOE5VCjZOHneH+zJcaa30Q7m1WC2jeIU01bpVZL6VK9MjJb9CND
         07hbi0O2s3mhf5Grj9xQGZX1Pvr5UQF+cHWFadCcKZorACoAbgo/ZPtuCeOO5dwcCP12
         yt1A==
X-Gm-Message-State: AOJu0YyrWWYT0muf6jovYjdVlj3jCYobJa/odyYB67CvVBwMyfNiAxyx
	XBlf4e+5Z+PR09s0DTIVXpfT1ALE/N2xFh1gpp84pmTR8gPcMzQnxXPLnF8Ufd2wZ75bJyegNeM
	cppVEAbIlwQ==
X-Google-Smtp-Source: AGHT+IGlTXPfG8jYFIz5corzlFVJlct+4YECdQTv7lm8y/xJqePS84z09Duq1p0dm+QsXKbeN8X1hAcO5jX2gw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:fc8:b0:607:9e9a:cba6 with SMTP
 id dg8-20020a05690c0fc800b006079e9acba6mr948375ywb.8.1709128497255; Wed, 28
 Feb 2024 05:54:57 -0800 (PST)
Date: Wed, 28 Feb 2024 13:54:33 +0000
In-Reply-To: <20240228135439.863861-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228135439.863861-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228135439.863861-10-edumazet@google.com>
Subject: [PATCH v3 net-next 09/15] ipv6: annotate data-races in rt6_probe()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use READ_ONCE() while reading idev->cnf.rtr_probe_interval
while its value could be changed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 net/ipv6/route.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 6a2b53de48182525a923e62ba3fbd13cba60a48a..1b897c57c55fe22eff71a22b51ad25269db622f5 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -645,14 +645,15 @@ static void rt6_probe(struct fib6_nh *fib6_nh)
 		write_lock_bh(&neigh->lock);
 		if (!(neigh->nud_state & NUD_VALID) &&
 		    time_after(jiffies,
-			       neigh->updated + idev->cnf.rtr_probe_interval)) {
+			       neigh->updated +
+			       READ_ONCE(idev->cnf.rtr_probe_interval))) {
 			work = kmalloc(sizeof(*work), GFP_ATOMIC);
 			if (work)
 				__neigh_set_probe_once(neigh);
 		}
 		write_unlock_bh(&neigh->lock);
 	} else if (time_after(jiffies, last_probe +
-				       idev->cnf.rtr_probe_interval)) {
+				       READ_ONCE(idev->cnf.rtr_probe_interval))) {
 		work = kmalloc(sizeof(*work), GFP_ATOMIC);
 	}
 
-- 
2.44.0.rc1.240.g4c46232300-goog


