Return-Path: <netdev+bounces-248897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E254CD10BF7
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 07:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8A633042B74
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 06:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78C731A56B;
	Mon, 12 Jan 2026 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WyhCWN78"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C933191D3
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200547; cv=none; b=ZVk9GeABlL5WvKqOMe5FqeRB/UJv+qSmnNtzZJP+LzqH6/delkzY4qWh3/mJluDjnaUXPeNg/2bLZqsfhXBsDVTo852evSAf0zg7Wt3Wktfg9i1n9/T4t206ZjzFMrFLThhl7fq7vXep01WWER8HfEP4u8Y1T50L/wDknpPfDiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200547; c=relaxed/simple;
	bh=/NupvgywEukBz4QryS1IcnmPfJQHRj4TZPz9BZQSMgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZebZlfZto57hS0UP0bDxvGaDZMtU+v9Wr8gP9cEueM6lNgkwsVgol7H16XlPIwi6KyDyfcDfMVb2qJgsFk4pH5o29GQmXhIJdzn2VDA/KkOoy0oTMMNopn0QCTrIaveP8rfp7Kr9bvGpSe0URkYgghu7wm5BV3DiobzZ4R9p2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WyhCWN78; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a355c8b808so8975475ad.3
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 22:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768200544; x=1768805344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPMqt7OubTukSzfJGmFa7NplH3SyhzWtPIziyN+vzQc=;
        b=of905Ja35JwM429EE+8aOsCybCIiXFB168HRhhAhh/s3yikZ9SSweUaQVyrSv8tdG2
         DuswPOWPEp4ft8RMgWBvCCNC7zP4c8W6SUtdjltfwcmoKx4B7dTKXFVTG92RIe/4iSQa
         18XgojcsM1AuFAgvTZoLEzYCfHNsWsQBvOa5LnN27RrbLOxOdWpSG/VlDtOyTmI0fllT
         pLFa4t66kNTvgwmZhVGp+ZRZgGUlxJ7iXmFTFTBsrWWnFJWMg1iyhGn1JDpFCN90xTx7
         DR5Gc0klPqBUkPF8O3cKx1j+kH7NaNSfnSxdX/rkDnnleL2byY4EEsVX3VkOErlciHax
         jRRg==
X-Forwarded-Encrypted: i=1; AJvYcCVC20j26q4j8dcBzPb5HeKuQA0bFCKWOXrce6Q5R2suij48l3wZUgtIcCgA4pV5K8DUDUyPrSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTwJfdUkWeLxMH4equ5kFMNbV+OwVzNfNUY8cO9zwHn8YzdWA8
	x935lhWBymDdGbd+bP/2J5n7m1JM2DX2T3q/DV8TiTI0Cp3+UdM+j/0ny3L8eW6EA2re/eRTVP9
	nNNblQjMrmu2sLuOvLnjSUJTJIDUmERdXbdma7ZMVauwdCKIADrwsAzMw0z5FAu+56fTydTRIHb
	5Td0GTnZDyh0QFbX6vLHLsdCBbzwmDQXAJcRKJCOdHiKRM37cedUHFrdEMz32lbMr8JgJ1Fdm0h
	UPROjM33MMZZEEbwJ9EmGJSxRA+0Gk=
X-Gm-Gg: AY/fxX4txv1di9hvhF0qikdRnUjTXJy7Syxf0VH0LiD9FeSTIlnRvcJygG0v8W1nunX
	VBNc8EOEOXK98u7A02V13yhj07A0pnL9w3/mm0T/vJWq8JO/pSTUWujtuF/rGcxvC8J7WBt5EUQ
	08AtmAJjIhIM5vD7ItobLSYpGbocv3WZKaBV5WB7ldtBld40dut91C/VtRlEgET9w3+QgSbQ2BA
	kRFFbtF/l4Z/P5vqhtKLTTAcUAm7w3v13A0wjkAm3ZWwnRisQ09Bua09qf8ED7yt0LvvcVFsqrH
	CStA2MwJfFQZxXX/LHfznNCTCfOZQWJy6Oe0A1QdEdQvPlmV5XTX+kkfiL80novONWgIhz6ZK+N
	eCDbz4e+PAQGT2Uppaz15I2UqL37k/WxqGsbllcxBlZ3cxaMP0qm8ttQ2xrmQNZdVOCNq3rpPH3
	Orp/xF2dwykvjAaY4ODu80YD2WhTacq37XkruHkPoTDnJnrQEH1qU4N73u9BY=
X-Google-Smtp-Source: AGHT+IEpXtlOJfxbY/h/Z8oti7PEYue2qcwucKFm4OnOLAEc+gHQjZUGCDMgnqKLiPKrNxAQ04WlMOpMsYVA
X-Received: by 2002:a17:90b:3dcd:b0:338:3156:fc3f with SMTP id 98e67ed59e1d1-34f68c03235mr11424980a91.4.1768200543970;
        Sun, 11 Jan 2026 22:49:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34f5fb501dasm2474323a91.8.2026.01.11.22.49.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:49:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8888ae5976aso22156976d6.2
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 22:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768200542; x=1768805342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPMqt7OubTukSzfJGmFa7NplH3SyhzWtPIziyN+vzQc=;
        b=WyhCWN78gsoIIEjmieLYndCeaZoyVQlAiV0SqsR0RaVZ9sSHrFNO+roo7PnUUkXDf5
         KyklWbunyaUdQcZTf63v7OMQP+R8OS6gYGe7ertuNpQiCpLBb50TJqmhdq7MaMArjTo4
         3MoMYWjL+S2hXghZW8GEN6iHCDrfncKLm9vBk=
X-Forwarded-Encrypted: i=1; AJvYcCXpf7IaV/G9XjUf1u7isyN0qXrbID+8MyBdcboX6ejTZkFmbQbH17Ej8hUzZMzZJ6sG2aPJTfI=@vger.kernel.org
X-Received: by 2002:a05:6214:2481:b0:70d:e7e1:840f with SMTP id 6a1803df08f44-890842cb736mr185047286d6.3.1768200542676;
        Sun, 11 Jan 2026 22:49:02 -0800 (PST)
X-Received: by 2002:a05:6214:2481:b0:70d:e7e1:840f with SMTP id 6a1803df08f44-890842cb736mr185047146d6.3.1768200542333;
        Sun, 11 Jan 2026 22:49:02 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm131125426d6.23.2026.01.11.22.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:49:01 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
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
Subject: [PATCH v6.6.y 2/2] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
Date: Mon, 12 Jan 2026 06:45:54 +0000
Message-ID: <20260112064554.2969656-3-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260112064554.2969656-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260112064554.2969656-1-keerthana.kalyanasundaram@broadcom.com>
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
[ Keerthana: Backport to v6.6.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 net/tls/tls_device.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 4f72fd26a..55b46df65 100644
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


