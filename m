Return-Path: <netdev+bounces-135275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9307B99D525
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 19:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08B5DB23002
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8290231C83;
	Mon, 14 Oct 2024 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JpwuTJm5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D0E231C92
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925294; cv=none; b=A/83lQ718ZCuoUphugyU1hvppZVVhZ+jrphMSZyAbNzec3gmc18CBjWsQBh3qTN2n162/w1tDFmPVgs1+2jK3ALWI8xHh+y8q59rYQ8i7p8nYEmcJeC3BAngx7suFCH47D3NAj+KYfTTiBgWvHEfcQ48PEGsE0MnlnzGz4zXT4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925294; c=relaxed/simple;
	bh=7JLVR3LdT6SMGaO6gyBKHiukuggyL5tvwVvmU2vHu5M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fucM6TMel50DFmKLede363QZxfedH8SFib71sh7dj8WogriJeXJZsw6gaEKIkqe3+71Xk1OQbJZHBr/jXdeo6moFhradZZouKB4v6XHWHV5ZIWwrTFvDWC5maO1mmRnaq+uKtxJEAql0v7WK2gTjcKXa5Slir73btgm8r6cE7Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JpwuTJm5; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EFpqRW000415;
	Mon, 14 Oct 2024 10:01:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=XMeuA0sFUqr8Rm90GI
	MZE4bvx4jKbxV6uS+xC5p/heU=; b=JpwuTJm5Vq1z40Moucw1xr19/XFimweiPR
	sm0hBYt58vGdFpF7DknnchN9YNxGDLXSOoKmHKU/fneTuNHoOKOZ/V5p+6DpaWdV
	qS5x1w7Drq/CQDPEajbN+KSaNa2qfVJcoZqr76xVa/1+Xe0shAFXzkYDyJdd+5KK
	vAludCN7/qRx3s9ynw8KcLbGkx+lj39jyAHBW/73u7uZl+RUSDVoAwsw+puu9GCK
	Ep9aS/vpigFYTcO4iK6XN+GxOHeaYMZreB0+bSeZhxpXmC+pJx43tt+h7SaRNvAF
	K5p+Ns4rX7hICsFjkD9fA7tdBydB5Bi637wXfto9zBloYjX8nVzw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4291rjagc8-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 14 Oct 2024 10:01:22 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Mon, 14 Oct 2024 17:01:19 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>,
        Jakub Kicinski <kuba@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, <netdev@vger.kernel.org>,
        "Vadim
 Fedorenko" <vadfed@meta.com>
Subject: [PATCH net-next] mlx5_en: use read sequence for gettimex64
Date: Mon, 14 Oct 2024 10:01:03 -0700
Message-ID: <20241014170103.2473580-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: iEVPXkxz0pNBPcBAwkSPLvPV-ZLHmEoq
X-Proofpoint-ORIG-GUID: iEVPXkxz0pNBPcBAwkSPLvPV-ZLHmEoq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

The gettimex64() doesn't modify values in timecounter, that's why there
is no need to update sequence counter. Reduce the contention on sequence
lock for multi-thread PHC reading use-case.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index b306ae79bf97..4822d01123b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -402,9 +402,7 @@ static int mlx5_ptp_gettimex(struct ptp_clock_info *ptp, struct timespec64 *ts,
 			     struct ptp_system_timestamp *sts)
 {
 	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
-	struct mlx5_timer *timer = &clock->timer;
 	struct mlx5_core_dev *mdev;
-	unsigned long flags;
 	u64 cycles, ns;
 
 	mdev = container_of(clock, struct mlx5_core_dev, clock);
@@ -413,10 +411,8 @@ static int mlx5_ptp_gettimex(struct ptp_clock_info *ptp, struct timespec64 *ts,
 		goto out;
 	}
 
-	write_seqlock_irqsave(&clock->lock, flags);
 	cycles = mlx5_read_time(mdev, sts, false);
-	ns = timecounter_cyc2time(&timer->tc, cycles);
-	write_sequnlock_irqrestore(&clock->lock, flags);
+	ns = mlx5_timecounter_cyc2time(clock, cycles);
 	*ts = ns_to_timespec64(ns);
 out:
 	return 0;
-- 
2.43.5


