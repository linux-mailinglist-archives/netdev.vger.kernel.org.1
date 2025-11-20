Return-Path: <netdev+bounces-240578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1882AC76677
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 22:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA0254E184E
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 21:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D9C311C39;
	Thu, 20 Nov 2025 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Thg0PgGj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09CE22259F;
	Thu, 20 Nov 2025 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763674976; cv=none; b=IqqqFj5yIRQDfbPX9SvEKCX2dH6rAChvZ/7IisaiBfCYX1B1uaAqkkiBZ04GC+RPxAWLQIwHEOiD7Pc45B3LWeOvCmAHywyygd3wPWClz1CCAtWv+wvObhz4pxOFJr+CmeZnb8npCLn+rrwOjMeNPIOAVhzUxzWre7M1zwjVdQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763674976; c=relaxed/simple;
	bh=v2QU8nHLBZc7DdgFbNM+X9roRdeuesPeUX/gK+xZUkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISd4vuYRxuh9Z5Y545a3TdakY7hBwH+ewQWKDxiqPqKYQaeWR7zWkbwunwWWNXqmwPJ9Aft84ImHHAQz6e0x7Dm5IcYp22dJpSuG9WBn/ZcG9mcuxk9heI0KbdvbHZRY+aubrj0fV+w5pD7mCyEUlkwQBZXcHqcI/tgcZRyFGAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Thg0PgGj; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AKJNbPM2821819;
	Thu, 20 Nov 2025 13:42:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=u2dHfkev4wkIM8Ip2xKtpkKrJScBQYOcd4BvsyKhRgI=; b=Thg0PgGjNBFu
	ZNc0f8SLVd5xd9CwjydMqpjTnJbkuBrM/U0ESHogpM1Xid9k+IDmVhmTEW/58reR
	XKGI8drczGstYdV+IPZwqzaW9PNSf7tAp+RGqgYi/zF484Ia31kCcidYj7Zauq0d
	JZUihRMibA4omDO+pKMPM3LxCFwNjh1czw55Am83gBUduuApxZ7311pFHsa6l6xL
	ErxWErchAIGQncEQdK2z9ieufJfZax9RE+NPTxtpeft58HwGdoO82C7/oRwuSf+1
	Rm3k4ibzStq32U4+3wb/y0XjJMLIH5ymi6GcJ1Uum+aoSRQxKbDsMEgypnKSxAJi
	sL+iTZADqw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4aj93wh8ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 20 Nov 2025 13:42:49 -0800 (PST)
Received: from devvm16459.vll0.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 20 Nov 2025 21:42:47 +0000
From: Danielle Costantino <dcostantino@meta.com>
To: Gal Pressman <gal@nvidia.com>, Paolo Abeni <pabeni@redhat.com>
CC: Tariq Toukan <tariqt@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
        Saeed
 Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 4/5] net/mlx5e: Fix wraparound in rate limiting for values above 255 Gbps
Date: Thu, 20 Nov 2025 13:42:28 -0800
Message-ID: <20251120214228.1594282-1-dcostantino@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1762681073-1084058-5-git-send-email-tariqt@nvidia.com>
References: <1762681073-1084058-5-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=aKT9aL9m c=1 sm=1 tr=0 ts=691f8b59 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8
 a=RTeLCBTnN0hYe8qsFzMA:9
X-Proofpoint-ORIG-GUID: PmZ_-FDrydLKj9suP5VIA-UPXnmBuafr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDE1MiBTYWx0ZWRfXzTh53Jr8WW2U
 d/AcNfTL9nzNB8Kk6JkI2zJ/M9oxHcDKLMlHMWcDkS+Rhy+BGBzu9FS7AFke6zoZAepTa1OnjXv
 WQoQ8DVSlvNg7LSwLfxAuMso60lscq2HTidcFPe1y4Dqx3RBEOgPjZUBTVtr7EV6njaPR6nkpyM
 yBG3iyiMp23K5E+DNj2qz70JjPvkwct2GvqxWr5JltmsuH8/sKpxKEmqaQZ2QL8+8X03JDWD0F0
 8wTnP/FDOqTrf6xLPCx5r074EM/hKUDEymxsrL2ylGma0Njn+hFyb6zRGkMTdCOS7hnB8r6h2/I
 7DzxuhpcvDC8GiXu0mTwNLpy0Eno+lST9XuU02J7lcjVCUigXOOcgBO2Xg2ovrEbi20yT/TDbSV
 NVAdGWqZ2O1yNVorNM0SZjel4B8Uew==
X-Proofpoint-GUID: PmZ_-FDrydLKj9suP5VIA-UPXnmBuafr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_09,2025-11-20_01,2025-10-01_01

On Sun, Nov 9, 2025 at 11:37:52AM +0200, Gal Pressman wrote:
> Add validation to reject rates exceeding 255 Gbps that would overflow
> the 8 bits max bandwidth field.

Hi Gal, Tariq, Paolo,

While reviewing this commit (43b27d1bd88a) for backporting, I believe
I've found a logic error in the validation condition.

The issue is on line 617:

    } else if (max_bw_value[i] <= upper_limit_gbps) {
        max_bw_value[i] = div_u64(maxrate->tc_maxrate[i], MLX5E_1GB);
        max_bw_unit[i]  = MLX5_GBPS_UNIT;

Here, max_bw_value[i] is used in the condition before it's assigned in
this branch. This appears to be a copy-paste error from the previous
commit a7bf4d5063c7 ("net/mlx5e: Fix maxrate wraparound in threshold
between units").

The condition should check the input value maxrate->tc_maxrate[i], not
the output variable max_bw_value[i]:

    } else if (maxrate->tc_maxrate[i] <= upper_limit_gbps) {

This matches the pattern used in the first branch:

    if (maxrate->tc_maxrate[i] <= upper_limit_mbps) {
        max_bw_value[i] = div_u64(maxrate->tc_maxrate[i], MLX5E_100MB);
        ...
    }

Impact:
-------
The current code will compare an uninitialized (or stale from previous
iteration) max_bw_value[i] against upper_limit_gbps, rather than
comparing the actual requested rate. This means:

1. For rates between 25.5 Gbps and 255 Gbps:
   - If max_bw_value[i] happens to be 0 (from memset), the condition
     (0 <= 255000000000) is true, incorrectly allowing the GBPS path
   - The rate gets converted to Gbps units, which may be correct by
     accident

2. The validation in the else clause that rejects rates > 255 Gbps may
   never trigger correctly if max_bw_value[i] from a previous iteration
   is small enough

3. For i > 0, max_bw_value[i] contains the computed value from the
   previous TC, leading to incorrect branching logic

This makes the overflow validation unreliable and could allow rates that
should be rejected, or reject rates that should be accepted.

Suggested fix:
--------------
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index d88a48210fdc..XXXXXXXX 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -614,7 +614,7 @@ static int mlx5e_dcbnl_ieee_setmaxrate(struct net_device *netdev,
 						  MLX5E_100MB);
 			max_bw_value[i] = max_bw_value[i] ? max_bw_value[i] : 1;
 			max_bw_unit[i]  = MLX5_100_MBPS_UNIT;
-		} else if (max_bw_value[i] <= upper_limit_gbps) {
+		} else if (maxrate->tc_maxrate[i] <= upper_limit_gbps) {
 			max_bw_value[i] = div_u64(maxrate->tc_maxrate[i],
 						  MLX5E_1GB);
 			max_bw_unit[i]  = MLX5_GBPS_UNIT;

Let me know if you'd like me to send a formal patch for this.

Thanks,
--
Danielle Costantino
Meta Platforms, Inc.
Flagged by Claude Code with https://github.com/masoncl/review-prompts/


