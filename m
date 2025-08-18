Return-Path: <netdev+bounces-214456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B43B29A4C
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 08:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052725E3DCA
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 06:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C30279DAD;
	Mon, 18 Aug 2025 06:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MSKi8QGc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F371279DCE
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755500178; cv=none; b=FhsBnC2TYVcYoMd/mCISjH/tv4BHWccgUrukxrqVVColDBBri15NdJlKp5gM2N4oeItXHGdwMlcuNPjpkUb9AtngvnatBaQg1eBlzMe2feF2/bVeS5pZNqYLYHkyWc/7mqaCAmheg5zxe7wrbQipQitXNZ0TQCulqN0g8sSoWu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755500178; c=relaxed/simple;
	bh=ZF2cvc7qh7L2/sR1ZvsVm+7I8RgsKwMQgdHA40RqXP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sdIN0vUiR9MP/LP4CD0ciBAfiqDt5XU+mfR5Ti/vAk+o+qSUSzMyLDeH3st+QMA5K6niPjiEvWEJFwiNG50CZv9+C3jv9wvYvu8OM6Qw4UyxSlgzoFhyBkQa7KKxWTJs3QthclVfIj4iabZEm2Xue9HNHh+tFMfocZtFIgl8ZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MSKi8QGc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HLkl8r027691
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 06:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W6Xp9EvQZXpa7Yolr9M4+PLDhTLkej4mqann/Lijna8=; b=MSKi8QGcYjreq89V
	q5sGg8RLZoxaM32koVnYn9Fge76mhGFM94ddd54w5whrVqzjyjP/Cs5uqctqATaB
	Lz18geb2/iKvXIoH1Zv70PoZSc+UF17+NEkZfJIQ8LAkI5B1x7p0q1FSnAUd1af8
	u6A+RHBqjUPIda35CrWlVKjl6VghfA/MUeNhMIVUkF7dED9QxF+GZlRoZwCnkAHt
	5CYUBmJCxKqsuvCSG9Vl8Pu8/zpIaxjsGweivieDiSNbmVHlTu37jx5498QiTJ9X
	6twq6a/FU+/4jP/mac7k/UrodINSEyKfMGMs7RnCGhyZyKBWyhbsJSFBWaBS1gUK
	V4QRiQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk5mbg4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 06:56:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-244582bc5e4so44686425ad.2
        for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 23:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755500175; x=1756104975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6Xp9EvQZXpa7Yolr9M4+PLDhTLkej4mqann/Lijna8=;
        b=jXxKuReCe+HL0+mqUvf53X4hfRCGcqVbUleOCWYMKxDxI3lxziTYBIRsXM5gl7pB1R
         d+u8wjli+bK7fLbezZImDzYirmryDqvzOT1nXB+0MyJQ0YH/p9Z+0a/p8V9XyKoB0Agw
         ZE7f+5SoYHAzZ4Efu7DZyB1w8uMwkXNyBv9vmXCVybBgWysmpAjWyr66dS9QL6usECj0
         Q/D2iShn9U8UTLipXrYHtJzbM5raqqe/Iu5QQrFo1U9DzkklWaPoSocG1Oj8Xd2KI+4p
         WVMMbtqQH/gwMh49hDh38hcV1iYNLGnty2USPZIQdEgmXusnAO6fDe5XcYLpx6n6Qoed
         qYlA==
X-Forwarded-Encrypted: i=1; AJvYcCW82uyrENv3nONeklenIpnuzsgUCNff36LTPDKOxgKKHJAezbqFbPMoUEax73gmm4K4d/1PcAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqjdZom8cwEpxx4iltrA+FL0YKz22t627XCGjysN6VHBA2skG1
	41Mt8HVotSaXZNHXDO8kvd8DKvcreRoVnzMrHCxjrfMl1plpbvTU9a5sQqkAWNRSFsDhN++SNIg
	4opRysmxHGz9wbUyhnk+GnY6AP1orN0wYupwRLn6o4dVvY2wW0jDzo02+n8Y=
X-Gm-Gg: ASbGnctUFxN7bkyiKKQ1A60XrQ5VMgFKnaYyWx+C8G915w7cL5uNxgph0tewzJW/RUl
	tX3QBSkkNwUgc9vVOQec5EE9yA4ctzhjNzjeH2JNdGdeMs99wFg+xazpcGbV3z3MLOYeBZa6Hwv
	0Xd9dRJOXbf2wJjfcwU6abKAmwc7tu7+F+bX9XmPTe8MzuI7iXPHAL9w2zfbhm2VgF1KhvIqlyV
	3j2puIe7q0oGiSJXSN2VCu4tz3elLxJ6lQVsdch0g9o6srG0ZPpSVkapCcc6Gw4j1xfUJHVPpd2
	Y0CTShF9DphnrEgmYXwYDwPqd+jzrELWB/UgrW9OkLd5gUkq468zL3d+VEsEcMXofn/2KSWZBMc
	=
X-Received: by 2002:a17:902:d58f:b0:240:6fc0:342c with SMTP id d9443c01a7336-24478e148eemr109517015ad.11.1755500174394;
        Sun, 17 Aug 2025 23:56:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeNxUTAjVRXiTV5guQNaXys88HDgIcyosKxt6j2gNU+n+P2aDPEAfHL/PdO10n3dblXUp8AQ==
X-Received: by 2002:a17:902:d58f:b0:240:6fc0:342c with SMTP id d9443c01a7336-24478e148eemr109516775ad.11.1755500173976;
        Sun, 17 Aug 2025 23:56:13 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f664sm70240105ad.75.2025.08.17.23.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 23:56:13 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 12:25:47 +0530
Subject: [PATCH 2/5] bus: mhi: host: Add support for 64bit register reads
 and writes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-tsc_time_sync-v1-2-2747710693ba@oss.qualcomm.com>
References: <20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com>
In-Reply-To: <20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        taniya.das@oss.qualcomm.com, imran.shaik@oss.qualcomm.com,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755500162; l=2553;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=ZF2cvc7qh7L2/sR1ZvsVm+7I8RgsKwMQgdHA40RqXP0=;
 b=//ygcJjGeh++VVVRReyWtFMl+NJEym2u4DxCH6/QAYpM4+O7JNkTbeP8slZ5S12aV110cq7hu
 H2ektu2v3Y8A4TqLvBhFy8zLNn/dC7Mor/qxxelKo1qBTDeQbJTWGqJ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Sdn3duRu c=1 sm=1 tr=0 ts=68a2ce8f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=8tVK0NU1EB3xojDYR3gA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: NS8igPG3UaFtDOCvs-5p61tjmaU13907
X-Proofpoint-GUID: NS8igPG3UaFtDOCvs-5p61tjmaU13907
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0MiBTYWx0ZWRfX3qUP0NvDS7/7
 vs3PzydbVH37HbDl5KGeSn5IlqVJwvxTdZOSv5lNpNU0KQWxWUEhXf28CxorODYqK2cVyjG+6u8
 awM1z3dA7JgLZ9dMXhRwzk6jcyYHzwjyXyTiwZw26eUrpHAu72CV1jizDBmGNXVVfYSxDEtMJtz
 O9e79ZGcxPwbuV0P4BAf+GPvINDj5BIaPYsD89n3PUcZNRDOjq+sZSDYv39kVPI0uSZphMKMUTR
 IWQlUcsy6NNDrPi2y0p1fPeN5t+jSbrem8IARMKXgpWT3FVRfAMROgV7+tV5bc95GPxBFIaQV8o
 5rW9vyIe0APMiVxFal/GG3Ar2W+oV735vr47O9Iwvo/ZjG7Fo9MfYsRuGlWxtI3+HDH818dHkAf
 WSKPZdl1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 suspectscore=0 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160042

Some mhi registers are of 64 bit size, instead of reading high value
and low value separately provide a new function op to read & write to
64 bit register.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/host/main.c | 12 ++++++++++++
 include/linux/mhi.h         |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 070b58a5ea75f121d4495d9dfd532f33cace274d..b7ceeb7261b708d46572d1f68dc277b6e1186b6e 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -67,6 +67,18 @@ void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
 	mhi_cntrl->write_reg(mhi_cntrl, base + offset, val);
 }
 
+static int __must_check mhi_read_reg64(struct mhi_controller *mhi_cntrl,
+				       void __iomem *base, u32 offset, u64 *out)
+{
+	return mhi_cntrl->read_reg64(mhi_cntrl, base + offset, out);
+}
+
+static void __maybe_unused mhi_write_reg64(struct mhi_controller *mhi_cntrl, void __iomem *base,
+					   u32 offset, u64 val)
+{
+	mhi_cntrl->write_reg64(mhi_cntrl, base + offset, val);
+}
+
 int __must_check mhi_write_reg_field(struct mhi_controller *mhi_cntrl,
 				     void __iomem *base, u32 offset, u32 mask,
 				     u32 val)
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 770d51e9bfac7434ff4b4013ad045c041c26adeb..540c90d7993ed9dc84d9ee29dd73ea2a81f0cd67 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -378,6 +378,8 @@ struct mhi_timesync_info {
  * @unmap_single: CB function to destroy TRE buffer
  * @read_reg: Read a MHI register via the physical link (required)
  * @write_reg: Write a MHI register via the physical link (required)
+ * @read_reg64: Read a 64 bit MHI register via the physical link (optional)
+ * @write_reg64: Write a 64 bit MHI register via the physical link (optional)
  * @reset: Controller specific reset function (optional)
  * @edl_trigger: CB function to trigger EDL mode (optional)
  * @buffer_len: Bounce buffer length
@@ -464,6 +466,10 @@ struct mhi_controller {
 			u32 *out);
 	void (*write_reg)(struct mhi_controller *mhi_cntrl, void __iomem *addr,
 			  u32 val);
+	int (*read_reg64)(struct mhi_controller *mhi_cntrl, void __iomem *addr,
+			  u64 *out);
+	void (*write_reg64)(struct mhi_controller *mhi_cntrl, void __iomem *addr,
+			    u64 val);
 	void (*reset)(struct mhi_controller *mhi_cntrl);
 	int (*edl_trigger)(struct mhi_controller *mhi_cntrl);
 

-- 
2.34.1


