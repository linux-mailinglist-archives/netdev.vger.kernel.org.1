Return-Path: <netdev+bounces-248894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A200D10B99
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 07:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFD8B307F03C
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 06:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1604F311C36;
	Mon, 12 Jan 2026 06:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T6ThGJ9F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1DD31195D
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768199942; cv=none; b=GtQk1xAsaIr98V9cTxSLGQmG8+ldKGzcvWUjfA0eqXdgcMOeyBzxkl9nPLYhb8higlTqHUfOKwzJHdNiAM9fajTh1jPnt0Hk6zcsykSibLwZIyiO+D885mCTQINar7iqFHMEyCW6DQUskF0D8NB8SbvAW577vK381030yOKiGoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768199942; c=relaxed/simple;
	bh=XjmEkDhy70C9BPaUIKs8e1nglyFuMhkb7Yn1iqBTdVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZNBb6GKjTI1E1ppIfoFPIrDERxDDEMj/eQP5wgp4TdsQ/ctEr2QSTLlLgo+bB4RfqltN8mnEfAvPQAji5yN6TdcQYbftvLeh9L7T26mY3N0mq2peTXWfYgIki1hcOkfM/UwKjghwjiEVNK8hw2bsmN4B7rNaSVFGSxbBCxvw54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T6ThGJ9F; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-81f38d974e0so39083b3a.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 22:39:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768199940; x=1768804740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/toLEsajSo6fO5hRJUdPGrIZ19DquBDTOLbcgJFlJU=;
        b=Bm/3DixAGVpIeRC5qYnu5NNPGMqIBN8eJzL4li6vBLgOU4t+1/f9b72y+3A4tTkv5Q
         OGLFhw0dXc/3lYiNfjhcCk6/Koky6TQo8TNfDWvkK+MyweJuoCR1ayIkJKMOufpW7cD3
         uB6n8muw9unFjXFxPLSM6DZakcgtk0h7dwmWkds/IN0ylGrki74qoflP8ccHfvV+2amA
         KJdeNzAHq/zkjLLRpxr7bwa/ggOKMDn1HPqJUpv+hG/oOt0mp+YWW2YyU3N6WY0M5tgZ
         DxXLTR/JaFI/TSRtk6EZi9QSr+Qf0rAu2iR++kPJm1FK7VsnR5sJVtvyYH67rqaYAZVR
         b7lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHuezlLfGl2huO9vgjehm6lLD+pwLB98WJoEs8fMD0V6nwWB8wK1DPS08AsISZe+P6lYtvuJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1VooSHtUJwGov0vdIsePzGk3AH+BGVrI1Xvc1TMNb6z5OxqHn
	bbAe7IOdy2BTDYE4L9E0oUREOzhuiwFlXxVmZUqjiPpifVRo1lbCgTMZyjmpNEjZgzw2dJ5Qus1
	DN/OyejcAimPP79pcODGofAcslvXjAQEU9WLBoE3DX675xJs6MOFPbX07dabwAeMu0IGgsKd9Xi
	zBffv3LYxFoyf9w/UxD8nTKuohusM2EUX26IK5iBnESwbmkVfk4OHuda/EyDmd9m8m+8QNSN5dR
	traInX3fFsozGqvMIAqK6YdaYJM2ug=
X-Gm-Gg: AY/fxX6GNMlsids3VZPYlfxJKGsq67vwxISp0FjTt5yeZ7MEEj3CWU7oJJLHoNxzS1g
	QFidtyHkfbuzW9/7MSz0fTHyiMtPlsWy8x1ymIk7nHt5XrqVIJJc4i7QgUlguIId0F9BArPUStt
	AkQWp1eubUgEMRUrBgTwTeOM9rsnli+hv5/X8nqhq5pNNDda7UVSOcnUsu0ChjLR9avIDGdXMvW
	ISgeigZC4H3CKDAz/ssRX8vvFIpTU0G85xQv436YkbzHPcI9rnoJ4CHeeiURvGVGVc6XBwbuuGz
	7dGWZlgBtPivmE/Zj0+QFpCEz1IYtpHpaUrdr6f6qyAM5ApM+KfjvSVomTI9pzbe1+Q0uq+AL+J
	+1TArW8V7JbUxaYaGJDXvXgT0rnwmxfqW39Srj3yIO2YYPSToHVXGhlpnHFhf6ekPO3gvhM0Nnw
	QZP4TBxProdpzgxUWb8ffpkbMMapldfvaSehqUu02+2jAohMgG12rFnJpK2A2rm7mR
X-Google-Smtp-Source: AGHT+IGyWMAQ29cRVClGPV4J3r3v+0TNclh03Zo920T0aKfrEfHwCWExeV3znsYb+2fffalt5LYXtxa6nKf2
X-Received: by 2002:a05:6a00:a245:b0:81e:86d7:b57a with SMTP id d2e1a72fcca58-81e86d7b6e3mr5550214b3a.1.1768199939937;
        Sun, 11 Jan 2026 22:38:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-81f3ef51051sm693622b3a.3.2026.01.11.22.38.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:38:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ede0bd2154so19135791cf.1
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 22:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768199938; x=1768804738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/toLEsajSo6fO5hRJUdPGrIZ19DquBDTOLbcgJFlJU=;
        b=T6ThGJ9FNIC6rMU07ILVmsrUuHVwUkSiQ2lPUMoR+OPEv1PV94ggUYzce+ft5+IO+o
         Krwe3l543dqa6cfVGaLTs/DI4NsFjmrGdverjfdZa94qmiQA1gfXIj4fCpHZhMD8kMJM
         H9CzfCEuj9pY6D3IRtrdJwYK/Ged64JSoL1yY=
X-Forwarded-Encrypted: i=1; AJvYcCWjUYXY9qS1l4hhiSdBgSCfpYC6zE/0iAYqSfmVTradkDq5XnQFdytlAYxYUK1sFjQLAlmKHms=@vger.kernel.org
X-Received: by 2002:a05:622a:408:b0:4f1:d267:dd2b with SMTP id d75a77b69052e-4ffb47d22b1mr178117491cf.1.1768199938529;
        Sun, 11 Jan 2026 22:38:58 -0800 (PST)
X-Received: by 2002:a05:622a:408:b0:4f1:d267:dd2b with SMTP id d75a77b69052e-4ffb47d22b1mr178117401cf.1.1768199938113;
        Sun, 11 Jan 2026 22:38:58 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e2833sm126594216d6.18.2026.01.11.22.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:38:57 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.15-v6.1 2/2] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
Date: Mon, 12 Jan 2026 06:35:46 +0000
Message-ID: <20260112063546.2969089-3-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260112063546.2969089-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260112063546.2969089-1-keerthana.kalyanasundaram@broadcom.com>
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
[ Keerthana: Backport to v5.15-v6.1 ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/tls/tls_device.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index c51377a15..e79bce6db 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -125,17 +125,19 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
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


