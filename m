Return-Path: <netdev+bounces-248900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA14D10C35
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 07:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C32B63015ADA
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 06:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2EB31A7F2;
	Mon, 12 Jan 2026 06:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PTEjG4FG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FD23101BD
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200772; cv=none; b=uZf9H8Zv1pzl/1ZZXvwYUtB4DZGFb2lanK8WHk0XmDmHPmJw+cWqluvoRRIvOYHQDdnBWEkZc6pIUhM68hUCYSNTj81nooaqbF8+pcTUX9PHG/euIamF8D6nGUTUUXfwUZLmW72ziB3qrvGun40bIUCZiCwnZt9XbGx3uGH5BTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200772; c=relaxed/simple;
	bh=pvMCEzJj4SGW1oTw7LLKdutJEZeqLk/uCFRUpyapQq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OapxA3P6vlEOOZDamlGxVZmqCQO5OkZrfG7Tc1StiYcLMPJf/mnKKQFYVN5N3BFNYRBmpEQFEcF/+3Vzd1IfzCJ7oy55oNHnuzZCcCdM9nON882jYC75JKu796qGQ02FGtPG5fvDeTx4htaMHQrpVIn8jTgdQZfMB+Mou79L2k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PTEjG4FG; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-88a2ad3a456so3929196d6.1
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 22:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768200769; x=1768805569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLfXk/1BlceWtah76vfkztbqcGBEs/TIQ6b4f9GZ4FY=;
        b=PQsfs7yuRKNuAInnYHDZa0UPyK3HuW9FkIynTLi1KD3z0hbEfRH7ASaBow+0hthGyG
         PjZ2TnMtoBe5zLfoaYzimECNjeoehzjUZb7+dsyAqqUm5Mz+Wn3J8+CaLGg4AJHHi8nf
         of5Fq1xmZJGQRHrAvSjE1hqPqNadtqO/KBpPpIpn7LjTiK4GtpR75Zt5Lb+XsYn4wpS6
         IMbBwqgepJIdY5c6e0KcwuEWysvFoyfNUOKh9wqfDA7rTM3HrM2EESwrvrkppYW5s/Bb
         Djh/gU4rkW1OHkF3XOe+8KuFrV0pcGJ/drTm048XjuZ244tz6qYQghaI2rEMcr/B+CjD
         wi6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlUB9KrIXzU4z2ww2vp8QrIwnFPG3t0VvF9EtvSkY7qWRSh3S2cSuW9bROV3avD93LaHdxXPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtPJmW7ECzms25lH878Iol+zAlTjHsreOb1RzadaYi9bdnYBBT
	ckJsqKnkJpwy/oEVuKGq8bGYfTW7jl9XYlzRZ5NIUT1+NyqZxJFXamSjESuREq2EgTg5KCEibmG
	Zuzn4OXOI5jqS19LGtQMQaIm483J6BRFem5pqd71xgyiVs8pBwLCFEreyVb8n4FxsIh6tAvq//m
	xti+93n47M12UElnI82n0fLzbyXGnf+MVHoq5diO+e3sTCiNOKsXkUd9Tf9di8i9/hbx7ndWBcP
	2dGpScXRtMRLeXxlukFpwDm3biP6mM=
X-Gm-Gg: AY/fxX5CxEvNfNijHyYgLJdiL7/8b8K8YLYUfY2ub+Eid307nrCzC+a067GiZh3FYYb
	6K5LPXfejfxbC3xmg/aLNAxr6dYP8AbKY0H6tHeetbh2FAiJqipxvil6GtF8pHiVWc/IwGzD+iP
	4vXLeIGMPUk78gC8gReOt20xEBydX3wImaPjKDllrPjudcJ3+FXb4ytqfJSW2oSGsnkHvF8PgiZ
	KVVAwyRIg2B40Ls+n4XU0nYOB9utjKXNqGJJB3WYkQEZe0Lxk5VIZlAARW3q8v4cUtEUhF0RMXC
	x5gKYW2BwSCsdnTDSvnkL95Y6Epxe0/aWlM57H86h8AISwDvPVkbUDkeFfGIS8gqDEcl4LzvINb
	KLFDFzI0DdIkex+EKaybmPRe+eE1oSXNNziJpE1YYUW46OAHzdrRJPNteA4iboy3B3Q/f5qxZku
	qQlUrv4qPXCNRXd2hLDkqlS7SWgw6AehZ8E5KRt09m4YCsoK+h+4JqUtDq8TY=
X-Google-Smtp-Source: AGHT+IEe/eHyhwZBs5TMROvGBXBNrZ7xnuV+yGJu+8I1LH6mtUeFUQk4W4L39D+rMFp5/SCZqLpfBZuVqC49
X-Received: by 2002:ad4:576e:0:b0:880:55fc:c984 with SMTP id 6a1803df08f44-8908429cff1mr186944096d6.5.1768200768833;
        Sun, 11 Jan 2026 22:52:48 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8907710edd9sm20697116d6.21.2026.01.11.22.52.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:52:48 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b196719e0fso204506485a.2
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 22:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768200768; x=1768805568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FLfXk/1BlceWtah76vfkztbqcGBEs/TIQ6b4f9GZ4FY=;
        b=PTEjG4FGTFl9K/FTiSEh+uQk/LOyR7P3c2UCg09bzWy50kHT26bMkYHqupAWbRTY2s
         Q9sERmZl+3vO5RmtBnfT/Kxv7mVWzftvlDKuvRTFQHBuA1jJW/euaQr9U5xHFbG6HPho
         e6R3k2nXZhMEw5VxHOdxYy8cc2YP2Vf4uNLto=
X-Forwarded-Encrypted: i=1; AJvYcCVlZJ2tVMXmi1DojaTUptraznSWnQCnndexN0jJAoTAPPd7Ov/zpFBV4kYTdFL52jIqyCTUODo=@vger.kernel.org
X-Received: by 2002:a05:620a:2804:b0:8b2:f090:b165 with SMTP id af79cd13be357-8c389388a4emr1707613485a.4.1768200768182;
        Sun, 11 Jan 2026 22:52:48 -0800 (PST)
X-Received: by 2002:a05:620a:2804:b0:8b2:f090:b165 with SMTP id af79cd13be357-8c389388a4emr1707611785a.4.1768200767714;
        Sun, 11 Jan 2026 22:52:47 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a6b4fsm1442738085a.2.2026.01.11.22.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:52:47 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v6.12.y] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
Date: Mon, 12 Jan 2026 06:49:44 +0000
Message-ID: <20260112064944.2969750-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit c65f27b9c3be2269918e1cbad6d8884741f835c5 ]

get_netdev_for_sock() is called during setsockopt(),
so not under RCU.

Using sk_dst_get(sk)->dev could trigger UAF.

Let's use __sk_dst_get() and dst_dev_rcu().

Note that the only ->ndo_sk_get_lower_dev() user is
bond_sk_get_lower_dev(), which uses RCU.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/20250916214758.650211-6-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Keerthana: Backport to v6.12.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/tls/tls_device.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 0af7b3c52..99d503e03 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -123,17 +123,19 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 /* We assume that the socket is already connected */
 static struct net_device *get_netdev_for_sock(struct sock *sk)
 {
-	struct dst_entry *dst = sk_dst_get(sk);
-	struct net_device *netdev = NULL;
+	struct net_device *dev, *lowest_dev = NULL;
+	struct dst_entry *dst;
 
-	if (likely(dst)) {
-		netdev = netdev_sk_get_lowest_dev(dst->dev, sk);
-		dev_hold(netdev);
+	rcu_read_lock();
+	dst = __sk_dst_get(sk);
+	dev = dst ? dst_dev_rcu(dst) : NULL;
+	if (likely(dev)) {
+		lowest_dev = netdev_sk_get_lowest_dev(dev, sk);
+		dev_hold(lowest_dev);
 	}
+	rcu_read_unlock();
 
-	dst_release(dst);
-
-	return netdev;
+	return lowest_dev;
 }
 
 static void destroy_record(struct tls_record_info *record)
-- 
2.43.7


