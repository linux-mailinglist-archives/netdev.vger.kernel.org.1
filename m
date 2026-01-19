Return-Path: <netdev+bounces-251032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F83BD3A31C
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FAAB303BA93
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E7235580C;
	Mon, 19 Jan 2026 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LSBP/iXd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f97.google.com (mail-dl1-f97.google.com [74.125.82.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD90835581C
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814991; cv=none; b=crbKGGC2OY1PHime+FFd1ruzw2Nou3F4FCsqwlVQ6a6EKngRLffasfkW0fDdT6CYRienIhme/HUqbSsGeKU10H4x1lwOggfbNYDWxiaGeEWqBgG5pNx2LY3i9WIoUDw85z5B+UwP3FqHA/vemfo+hBaGQmiz/95DH7lIsp6W4RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814991; c=relaxed/simple;
	bh=QgXU/7yNwhrctzlcitKYbDUmDIC7I+TCoOtStmFwLvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2f9h0VLIG7lukNZYk+FQoKE01fJZB7NQlfPWV/Mh2GJuecC15VD57QbChucimhM1c5ZtquX8agho/hB0R/iYFQNRo0/YawWWVGo5mvfyT9K4WVE/R+2cjlgz4V2WITc6Gj2wiqy1iAQOGsAdyypUiQeiRynr36TJCWeigjJIq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LSBP/iXd; arc=none smtp.client-ip=74.125.82.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f97.google.com with SMTP id a92af1059eb24-1244bce2c17so277397c88.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814987; x=1769419787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fj8sUP59dWob41aCsZ9BHl56sg70okF+kqjbtKr6YBw=;
        b=Q/txPcjGYYHv4WqQPaSszxjqr5a9xQeBn8eoBtDnfukdBtN9FeJ7MDkCCvYbAj3fuv
         c9z27dy1+2++YtAxS4tFBWOK3x0q8Ob8P9w3XB15N8P/eG2fiz2Vz48OKQ+MAdQ80x8q
         6wwOHvL/mugqXPJ6EBXUmpg9k1oNZ7xKciOzZd4hJWdMbLTZU4qqN/MFETLp9zHwNdH3
         KQomkvRPhpKIx4XB6FDrgcnxFP+NT618NKgSPBxW3e2137IZPZsuerJfZMr1BsQIc8Kw
         s4uOC2crBaf085RhU3FMgVuhrJpDkehGElfWcI7DySEcRphYN7hYG6mhQ35uf/fBeBBw
         EkgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrSdCtZ2U5tSPjXPruecjT0tUgrA8rK81G2yb7MG1YdaBZ+8BE0iR4cacLoizbQi/MKvKUVFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVzsyhEaTRfxEp3BbaPq3L7fTW11RbGpZPXOnS4aB3CErZqMSI
	IO+FWSk8JxX3/9tNFyzCSH/tfLg2hS9IF9b0W8bpgdbrBijZ1QLWDnxH3P1MK+pLnP/zjSVmKHe
	7G3N3EOY3XO8UnMdBX/PPojtjzo0DqlFHefm2NeSOdMAE0vZY2BwBKfbx0KDfvRtz5TkpOgx4JX
	8pEdv6emi47wCWTxkuwYhtZ8kpyWTJRuRTJsIdleWOJp8hv3MmzynH3Bt8b4NkCAp8lVEPQ6dWS
	Ax4lTdqVtZZFkcJTEWxznlbK/vl5Co=
X-Gm-Gg: AY/fxX6IsJkpcS5d8ms4SOLNN5HrGO+nvzTqhxT0W7gZG1EYfNAOhi/OzBIoERiMWQP
	xQ/vdp3txMnd1fY051tLB+F4xvS+m69LMdmkcxTtXyi48CmcikWO54ULqiXHfacCq5aHbMzNR4c
	bEKPXIZsOFj0SGkbqgINWIXJ9GKMfP9/n618ATRXEpVwOMbyJfLdv5JIHwb1fthTXMRwPwJoDfp
	uTGPGUnaSc/1M0YMARBpXJULkxVO2FyGht5wKkkaNPFqQG4p1UaZg1Vp7UZkDJawGH/D/cI0X+3
	NQ+z7cn0SJ5FPStsgQsiwysXWZ6/1r4GX2Hi8a3CkpthnJJDYmLbpA4shC0z79oSd6x2YuiPdc9
	vgB47GRbC7x+k80uSVh1rc4UXLUv3E8HzLxhaQUzrBb7y++1SQwJYwL79LzaDQ4u4nJHMGNyVTb
	H69npYarxXV0yYBog+7e6/0yUrYlrbU84OiHlur2R97p3A4bM2WqgUsJXLi8PUniK4
X-Received: by 2002:a05:693c:3282:b0:2ae:5dc2:3b14 with SMTP id 5a478bee46e88-2b6b3ee74edmr4910004eec.2.1768814986774;
        Mon, 19 Jan 2026 01:29:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2b6b3522644sm1234481eec.4.2026.01.19.01.29.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 01:29:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c532029e50so147234185a.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768814985; x=1769419785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj8sUP59dWob41aCsZ9BHl56sg70okF+kqjbtKr6YBw=;
        b=LSBP/iXdpJoroRaEFGxsqT0CrGJnGllNkU8VK2QsJtUFQYmadKFQIr2/x4GlFQc0X8
         LkG23hlzNPCesnNvplFu9S898ebRNxOjw9fuxz4o4lhIb2Q6/lBKe3wAZcQ69r/0vfyH
         STRDadUcWobJeHpzSls/zx6qDbS3aMgf9osPE=
X-Forwarded-Encrypted: i=1; AJvYcCXzlczcctAqMOx0dMdbxUuIMTN7rKexsXvK4YRAfV2PCCc1RjJmFvF+bXmpFHII6d8+7cawG2I=@vger.kernel.org
X-Received: by 2002:a05:620a:700d:b0:8c5:305e:ea16 with SMTP id af79cd13be357-8c6a67ab9d5mr1074238685a.8.1768814985345;
        Mon, 19 Jan 2026 01:29:45 -0800 (PST)
X-Received: by 2002:a05:620a:700d:b0:8c5:305e:ea16 with SMTP id af79cd13be357-8c6a67ab9d5mr1074233885a.8.1768814984815;
        Mon, 19 Jan 2026 01:29:44 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad6f3sm76917516d6.36.2026.01.19.01.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:29:44 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: j.vosburgh@gmail.com,
	vfalico@gmail.com,
	andy@greyhouse.net,
	davem@davemloft.net,
	kuba@kernel.org,
	kuznet@ms2.inr.ac.ru,
	yoshfuji@linux-ipv6.org,
	borisp@nvidia.com,
	aviadye@nvidia.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	kpsingh@kernel.org,
	carlos.soto@broadcom.com,
	simon.horman@corigine.com,
	luca.czesla@mail.schwarzv,
	felix.huettner@mail.schwarz,
	ilyal@mellanox.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v5.10.y 5/5] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
Date: Mon, 19 Jan 2026 09:26:02 +0000
Message-ID: <20260119092602.1414468-6-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
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


