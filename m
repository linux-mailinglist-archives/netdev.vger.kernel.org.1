Return-Path: <netdev+bounces-248891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D9D10B51
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 07:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCC2D301A621
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 06:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F78B30F807;
	Mon, 12 Jan 2026 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ThAgV2pu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863D23081C2
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768199645; cv=none; b=qkzKh65q9Sf5O3JtH/Wgn69OyadnBuc+UDC9XMm6NE4JhnFiZilqk3fvwEU/6w2kAkq2GEY3DEHcxWqjBLHT23lASZ+8yH4pGP3bYQyrWFexAvGT+pnv752Jf2D6lxlHl5uiinzqO5tjN+SLxf/bpIpFLyuGC8srgiDcsdLj638=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768199645; c=relaxed/simple;
	bh=QgXU/7yNwhrctzlcitKYbDUmDIC7I+TCoOtStmFwLvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eD6pF2jVY7wDI/eFXhVfrqQ1Fgw2mqalV74Fr46fK9nho8Ic/P2ob4HnLfLaULqeDetlQuE/KfdMAWEiUeHUi/7ISf43D6kwbj37584slVNalfJEeyqQozmHE+cOjOhgasy9nB4epe7JQjJRwAlOuCjkYhBLAq5n4PLeXkIi72g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ThAgV2pu; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-8c0b24cc4ddso52679985a.3
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 22:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768199640; x=1768804440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fj8sUP59dWob41aCsZ9BHl56sg70okF+kqjbtKr6YBw=;
        b=JS7KxMC8ynExrzRztyHI3VlCcL6qaK4WOGpK3b+TM2gLF8Zns9FPl9BA01KEGo98DA
         VqGIKm3LR92MeePMsY0VCd+yal/Dk5LPfrDz8mjUneEJ3kqMTPFHjEhBo49/yAkhjWyN
         k8dT6WMbODkgVIr6KPUgLLNZwYFD62EXtKloBOZOCEGCCfsdhD7U+J6llM8/+wpqF35g
         SItfHLZdrZkePfg5hDmbsgvMjfALd30UfJf/3AirUGEm1ic/eJEbvwwYx9VN+7jdqWk0
         10mzTfP8xb2+Y/RCIM9F0wqb4OThv9lTXynqC79kaKJIVR24Pa5DzRzuQ+mU0yzJ92Jq
         mxxg==
X-Forwarded-Encrypted: i=1; AJvYcCU44Vm+FmeDfkqWtStBzZnbpjztVyOlaM0vLqG2u0f6jmgEbwLr3F+Y8ROppPirbMdCDGghAF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGocnYRptE5IEdf8+axv7V431q9XWGKHUbCx5yMfmMrSqoZmVu
	g5Op/Tz1/b80O4xng6FBWtO0Ml1h0AAwmQPzOo3Y9CiyKlTVSare2vxTucfWqswxBXDztIbP3sX
	Hw9KnwPA5C1SlUIIExU4YhF+4zCmyl4L8Q8WieDJHdsTj5xVn5/Kbmsfs0xHblz3nN4ulSJxewS
	TUbaukEQoOer9HKBKtmpGbTK7DaHaXBB64sB/tLnm35t3L58jOqHFGYr5XO7Rqm1TjvoDjYMoJ+
	1iMCtlz6YRw1Ae7dqWyc4t4gFo9014=
X-Gm-Gg: AY/fxX6PtHNXLeOX36EKuvuOBJVv8tc+4HkxKdF99nx/PHGBSHNkfACPvY2ThYu4Iwu
	xe0bs+9NFwX/ApGG72pshknSCrLMgvDpnHZbhsyergDgq+dM3cKLueoayU/bZRzmZfW0CvgPxf6
	E8lQjefqeQgMYACNuba/b67nadq8NZVd7Sexydktv3AcL+mQvIgsOOZPJT9LfHOOc2hH3rzFDTz
	cTcFFVdGKzK4pNwbmBdNDNxfHmh/gXnwIyr1lXQxyKf2cDy5q+ZqknLnmTfbb6mnORqLUVifwVt
	UxEguxQvdrgLa5nOTgonRNxhbGLfCuyL57MiFyGMCP9T9qMnohEcHh0+4+wb8A0ieAAUexafhir
	X+mdXotxqJGaB7Ti9ixpwF8Xls3L12CXdjqRoyH/1v51JFMoDNCU48cs68zEe5RhGiGw7LdT7sm
	tHHcGp7DEwpwhElT5iwMEolk2RG4/BHr2nu11cJuTM9NT9FB/k2oIKpy9fF3ngmXSe
X-Google-Smtp-Source: AGHT+IH+uqtPgsYAdyaQJsyxlwQ+eePPLaNgeXYcvrGQvFqYGz9uUqDs5DLmICvVIeHIVzQPrBAHEc2moWYU
X-Received: by 2002:a05:6214:27ec:b0:88f:ca7a:6c3a with SMTP id 6a1803df08f44-890840b7d83mr180402016d6.0.1768199640520;
        Sun, 11 Jan 2026 22:34:00 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8907710ebafsm21899306d6.18.2026.01.11.22.34.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:34:00 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b25c5dc2c3so135550585a.3
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 22:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768199640; x=1768804440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj8sUP59dWob41aCsZ9BHl56sg70okF+kqjbtKr6YBw=;
        b=ThAgV2pubm4Q7pp3q9FJDD2nM3KMDZhJFl7CqmIgihg7TH+444o1HybUOpKBLqZD3+
         nL4uRVC4EoCVe1XcLuoRra1iGqciBAevz393+GAUWs9RYsK9Ssik64JOSGZmwHv1o8nU
         VeV83qVSIoBKyUDZfMlbbWO+AF0+L9W9fKRuE=
X-Forwarded-Encrypted: i=1; AJvYcCWsW7UtiH67jpkxSzizUaNomb0xqrvvmoh/p1aPZTNlHcnY2sBvORtoWiiC3A5hKvs99+6athc=@vger.kernel.org
X-Received: by 2002:ad4:5c48:0:b0:880:52f6:775e with SMTP id 6a1803df08f44-89084275c91mr188503686d6.6.1768199639724;
        Sun, 11 Jan 2026 22:33:59 -0800 (PST)
X-Received: by 2002:ad4:5c48:0:b0:880:52f6:775e with SMTP id 6a1803df08f44-89084275c91mr188503536d6.6.1768199639235;
        Sun, 11 Jan 2026 22:33:59 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a794bsm1472324885a.9.2026.01.11.22.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:33:58 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	sashal@kernel.org,
	leitao@debian.org,
	kuniyu@amazon.com,
	willemb@google.com,
	jramaseu@redhat.com,
	aviadye@mellanox.com,
	ilyal@mellanox.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10.y 3/3] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
Date: Mon, 12 Jan 2026 06:30:39 +0000
Message-ID: <20260112063039.2968980-4-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260112063039.2968980-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260112063039.2968980-1-keerthana.kalyanasundaram@broadcom.com>
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
[ Keerthana: Backported the patch to v5.10.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/tls/tls_device.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 8e89ff403073..8cf4e1651b0c 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -113,17 +113,19 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 /* We assume that the socket is already connected */
 static struct net_device *get_netdev_for_sock(struct sock *sk)
 {
-	struct dst_entry *dst = sk_dst_get(sk);
-	struct net_device *netdev = NULL;
+	struct net_device *dev, *lowest_dev = NULL;
+	struct dst_entry *dst;
 
-	if (likely(dst)) {
-		netdev = dst->dev;
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


