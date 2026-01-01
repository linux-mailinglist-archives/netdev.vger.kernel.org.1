Return-Path: <netdev+bounces-246496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C70CED452
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 19:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E0E43008E9C
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 18:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242C6224891;
	Thu,  1 Jan 2026 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E4JOakQb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fyR7APuz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC49207DF7
	for <netdev@vger.kernel.org>; Thu,  1 Jan 2026 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767293594; cv=none; b=twhhBVIuANpRpEPz2BDEhKGckD2hRSxGOGJpYxFU/19ONzdXIOr1WtC00hy3NsmJSc4NbPE+vogXFgCs3V6IPA670RrGiYAMGTx+sjgrNJ3bpIty2jZ4g9LfG3fXJiIVozs4yl9zQyxHDD2A76R5o5bP/UXbGsAikbghTnVqHLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767293594; c=relaxed/simple;
	bh=o2JI36SbLL1QX+AoiSt/Ze/Gyqi1QoSKvIbZmPR4/5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bObHc98uZgWkzOsxgc6Umz2xeqYUEbljeCIUMAsRYGv11TD9YHf+zFxv4ys3oN3sdGqeDP8gYJEg2iMTASI4tdoIH+UydRR9J5/gY1aEigtn34IcW+Z2d43K7C4b97LmRTkT7Vxqf0QKah1RSdycoP+hDEfvb665p/RZG+a5LDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E4JOakQb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fyR7APuz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 601EMVdt2257973
	for <netdev@vger.kernel.org>; Thu, 1 Jan 2026 18:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ik6hlVXeTmBKrAB0aF6mx5+u
	5ON4Nq+bNmY4Sp4BCBg=; b=E4JOakQbeHUd6cX0TJKs3SQDrGS3pN2GXE+/B77s
	INRK2xConOMgsCZKtMw8/fZXSNHbErDJWHW4Kbo60eBISTJCQ9lIDk28sOEZTRDy
	XVzeWLOybrD5nIZ4g2HAnzlujiKgLff4gMQgcQ6w56CooqFQXgPybL7gxO8s1m1h
	1VO/+c37m4ObAWcnTpVT/gg9QgA611Lr4ebrGOxbU3MdR+NLv5Ve2mkXK5OCjB+2
	W3d3/b8NaEx7oRJzXPxramL2NbhUk/m2bJ0vEAMTCHM3UF6gjX/SaQC5qCVPLjjR
	k2juBGo8D3SaarlLyE6ASbPvMHRwcBjhUHoCA5US8AI4pQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcy6ajtpt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Jan 2026 18:53:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1b39d7ed2so253637761cf.2
        for <netdev@vger.kernel.org>; Thu, 01 Jan 2026 10:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767293590; x=1767898390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ik6hlVXeTmBKrAB0aF6mx5+u5ON4Nq+bNmY4Sp4BCBg=;
        b=fyR7APuz8BImezbf15bqpUARVdmhTHJMmBmO11+cmAkQTcEBlnU/A5i1ZybOkwEUK3
         x2CRi2QMJ+bSt6hGZAagGUyb/6cT8pXSypCPYaeAVQvaHLulC6odKy0edr8ahr8yB675
         jjpBReIsK9NCfqCuCR+k3XqLHlS0hGFjroLGN09fkXXqiLxnwROwQiJV+RkVNOhhuvuO
         2iLKATnulYBVJI1YSRBKX+/cenV+pElKoffxi/7rJ+ewMYC/X/CcOA/H2QsqnQCuWgBQ
         hn7hrhcunGSvWI/6u/1pZn71tjNHK128c/wOTGAZ2EYpE/SdECUNRwjnGmMkUGYFSkQT
         vMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767293590; x=1767898390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik6hlVXeTmBKrAB0aF6mx5+u5ON4Nq+bNmY4Sp4BCBg=;
        b=CWN4MXaAXqzyOnumPHioRaVR5+/+tnmw4o5jQ/8DdcoVxd1qPuFtbk/Dmk+MQtQM/x
         sgPRqmBJnHvf5ILOB/oE7X2vyWFvveOB12U3x3036N7PRbKtEjHBzPE7ZJgZ8VIQMf0U
         ui9Q6Wzdt73deNbLH/Tg8YepBqhRFeBmJMqQAfu34fImT7sUmAxcNcm3WB62j4U813Tp
         1f4puXKC7yEUUPyKufNMjza/xuo2L2kYJAYbyOVu5H95lBDVBiYz9P3xk+6o375FSPq9
         0FMRYhlutpcpTozZrFrVf1/xt8fdN8ud2wwjzio05qs82L3hoZJtc5lf4rz7r3HWOGhm
         udOA==
X-Forwarded-Encrypted: i=1; AJvYcCXlJ2+QoiLmC4+5P3i64SMYI6LaoIM4qKR1kBw0E4NJ8d4FPw1CiAXdALYTl80nJ5FVZSTQ0G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ7Dl+9g7hWGEFcYKN3vMgSZnDYN6PgXc+7BMQZJ+jCee9txcu
	0jzVKV6Bw6bXbMwc2oFt9wXSljAllRHQEdlYUZIixgZJAYAmKe/SflBg8AUfVSL0mkv8YbsOJZF
	1P09iLIrrrWzPYcMbg+k7ZM3fGvstfqFbzuh3IZBtYAEzoyrmjOgixPeBLpg=
X-Gm-Gg: AY/fxX4LZEyeD9ZNo7Dvn34JQXuF/+JmzTww1lQq/yX53ti/HR7BFeJaVmaWvKcxHtC
	ycc00pnQGCSesXtQVJW2W3vUwg0qD/DA2VlGmeKECaz0tNwhDvDuiNE1m2GPX+5d6tfuzanDOem
	+Bworr6m8UnVvn51EeGnlrRu4YxDzOi6w+7OrEuUFaZgRR1L1xb8kJ/Mef4KxdW2JjDrYp0vB/j
	B7CS4MgQgIXm7+S8L6pM9ePGp0gZm/ZkMDqAVEcybWxdU8O6HfSe1Lkuxouw1bufh+CBwbu4BNX
	J+T3wbJsIGIUMw7sxiJCtreQ3yiPHH4cs1BBgDazzVXvzQjPLrxM+4SpPUMUs0QTYQQw9OJHB2k
	KWwbQKfBDQhSK+kIb2xpy
X-Received: by 2002:a05:622a:1f06:b0:4f1:e0c7:7892 with SMTP id d75a77b69052e-4f4abceebbcmr599601241cf.21.1767293589946;
        Thu, 01 Jan 2026 10:53:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqWg0OwJN7WPv/Z6zzoCKj3pxTkw7ICxhLJa4qdOrQj71LJo+OUfAsFJ3QIwlHL9BMYoFVPw==
X-Received: by 2002:a05:622a:1f06:b0:4f1:e0c7:7892 with SMTP id d75a77b69052e-4f4abceebbcmr599600801cf.21.1767293589362;
        Thu, 01 Jan 2026 10:53:09 -0800 (PST)
Received: from oss.qualcomm.com ([86.121.7.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b836b9b08c2sm1537526166b.58.2026.01.01.10.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 10:53:08 -0800 (PST)
Date: Thu, 1 Jan 2026 20:53:06 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Maxim Kochetkov <fido_max@inbox.ru>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        netdev@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>, Chris Lew <quic_clew@quicinc.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: qrtr: Drop the MHI auto_queue feature for
 IPCR DL channels
Message-ID: <bah766ajefvfoiqgbgjwwlbbr4ech4yupo2wjogejxcd5tmq4p@q5powzzdfbbf>
References: <20251218-qrtr-fix-v2-0-c7499bfcfbe0@oss.qualcomm.com>
 <20251218-qrtr-fix-v2-1-c7499bfcfbe0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-qrtr-fix-v2-1-c7499bfcfbe0@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: JNhQWX_6UowfWAFEwd7y0HB_OQa-HCp-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAxMDE3MSBTYWx0ZWRfX6yc1DMVKlw6l
 D85dmciyKAntrqXIGU8cHmyGq/K1MzgStNIQzqLJswRgup05wR1wdssxPvOYUfI8dnJ8IKcPAN9
 xLV9vJgWYl180bzAddxe9Xmar1Rvdwq9ePNs+pyvPyH7kkZTjsTrBS+gWIrdyd+vPy1g6MviRmT
 zJ9Qe1Q6Q8Hhh2zia5atAZaGQRnm2w7KNz5nZHIsgCV+mbc3Fh8nrKXih5e2QstrQA3zTasBw5o
 sMkArl39cQ+f2YfMQ8CABTp55Xb4bZrsYJueoHtTE2myrPTcTmlRMuWMj17/1rSvx1PMt5OdCJh
 AwXRrFQqWuoYKMMrNc8IJsHMOXJeD3qPcMkjE13bmb1NXtMTWwt6Nz8Rcdq6MQiTQYlOBUzn/Vh
 8y7Bw1ZaC/F9aRQhknY9Kr3AATeIpWsxOGqwg76aDif7BEFD6AJ3MkcE5i9HRrVLMfRVTGzhaVc
 4zx8mmTQDGAflNd7gIA==
X-Proofpoint-GUID: JNhQWX_6UowfWAFEwd7y0HB_OQa-HCp-
X-Authority-Analysis: v=2.4 cv=J9GnLQnS c=1 sm=1 tr=0 ts=6956c297 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=hZ5Vz02otkLiOpJ15TJmsQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=isMaZ9OHK7bkWVW8W2QA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=xwnAI6pc5liRhupp6brZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-01_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601010171

On 25-12-18 22:21:44, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> MHI stack offers the 'auto_queue' feature, which allows the MHI stack to
> auto queue the buffers for the RX path (DL channel). Though this feature
> simplifies the client driver design, it introduces race between the client
> drivers and the MHI stack. For instance, with auto_queue, the 'dl_callback'
> for the DL channel may get called before the client driver is fully probed.
> This means, by the time the dl_callback gets called, the client driver's
> structures might not be initialized, leading to NULL ptr dereference.
> 
> Currently, the drivers have to workaround this issue by initializing the
> internal structures before calling mhi_prepare_for_transfer_autoqueue().
> But even so, there is a chance that the client driver's internal code path
> may call the MHI queue APIs before mhi_prepare_for_transfer_autoqueue() is
> called, leading to similar NULL ptr dereference. This issue has been
> reported on the Qcom X1E80100 CRD machines affecting boot.
> 
> So to properly fix all these races, drop the MHI 'auto_queue' feature
> altogether and let the client driver (QRTR) manage the RX buffers manually.
> In the QRTR driver, queue the RX buffers based on the ring length during
> probe and recycle the buffers in 'dl_callback' once they are consumed. This
> also warrants removing the setting of 'auto_queue' flag from controller
> drivers.
> 
> Currently, this 'auto_queue' feature is only enabled for IPCR DL channel.
> So only the QRTR client driver requires the modification.
> 
> Fixes: 227fee5fc99e ("bus: mhi: core: Add an API for auto queueing buffers for DL channel")
> Fixes: 68a838b84eff ("net: qrtr: start MHI channel after endpoit creation")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/ZyTtVdkCCES0lkl4@hovoldconsulting.com
> Suggested-by: Chris Lew <quic_clew@quicinc.com>
> Acked-by: Jeff Johnson <jjohnson@kernel.org> # drivers/net/wireless/ath/...
> Cc: stable@vger.kernel.org
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Tested on Dell XPS13 9345, so:

Tested-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

