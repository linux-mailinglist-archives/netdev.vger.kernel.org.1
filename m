Return-Path: <netdev+bounces-223480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A44FB594B0
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3FF179DA5
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91482C3242;
	Tue, 16 Sep 2025 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CpKidFal"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546142C0F83
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020587; cv=none; b=uj8r14we9yZ01wZl+qEVM5QW3yf4LBeI4XbwBuHpFBko91JMkAlYoqhpSk7lF6S194jfv0s37P0BpdkP1PUg+OVnFa602aHVm++ZMcbIaALVqp/B0X3juAcqhGq1Nn0S0Ij0lQ/Lsu3y/vsX8+Ynnh6mzgY1TZeIWpy8ujcocB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020587; c=relaxed/simple;
	bh=jCWoiLmYKgtosl3zfnsSg6IJaEKb9HxfTKRf3FW2tfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM6iyZNiS+LceYsHnTduzWBz0/2uZO0tNkk4IZV86GGgcfesRxvyY9PmCJcT9xe15wWRUR5YvSLxoVxJ943z66nKbn/pjJdEpHZXMFwjFlVrIfCk3Djsp72wjHeQlBs6PKiqQe7nlkaqsImg6KLpfZVr3gs0WYSTBXGsAs1zkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CpKidFal; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA470j020643
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aGWDhUBbPiv5SXm2JrRwK9rd
	9d5oa/pXGFvpbeXT4NQ=; b=CpKidFal8r8YMEiczKohQ78k+JXRhS+yUuEIbXS1
	g6MGu9diITl0kVe1nGEnCZSzRwAuokwfR5z4b0zj31Q0ofgXf948B4wKaX9ai/FX
	pkK8DL1A0hCfXSdRGahYBnsgBAF09ooRnAYUuV6ewg6imY9qn2aIVtn05jeanzMi
	wRJ8zmGPXMbJ9CdK4hr76v0Mo4Zxx1j2TSsZmL+MIFPI0wL/btDt0lGGIl0rlVf3
	khiY+vyNb9Pd4VLsqUBherw2zb9usklcJYxRONlTBs7zSROcQ2CI6EO4J03+fq28
	L39NP8ukiqo1PCmCImYkLxj0Ii6ZlfjixaZt7+lJRlBa+A==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951chghvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:03:05 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-54a1ab16fe1so5101497e0c.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 04:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020583; x=1758625383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGWDhUBbPiv5SXm2JrRwK9rd9d5oa/pXGFvpbeXT4NQ=;
        b=HO/tVBt7JFMeeyS66Wt9EF7csbBjwqARM7sGGRXMgtquz8USujjXOm22Ux/aVgTurv
         ntvKe+L5MZFiKYWc86IKy+bibed3IuO0LXjxtPpSh95N/LPHfuwEXClLLD6JZZ75xN+v
         4i7L8eoVHb7bAEFfm1g0LZR5QNnEtsSaeOqWkWVoacayWhibLwy/54ssRzP4BhtIlfs/
         633t/gtP5+cNmbpoBHMFFWXh6382D2y69c0kbuOw0LHjP2ZYg2lXVpuVhND6i4NeHeUd
         X/zeTrTpUNhoEQr3BuncDHuSbjl3ZdaGoYISpsmUjE85sUuqyjt4jDJ6b4djM9UQuiJa
         datg==
X-Forwarded-Encrypted: i=1; AJvYcCU2DOZ8U5pr7ItkaqIWk5uicMSKzeow8sSo/XhVsWof630AslRWlE58Unw3ysBxXV2RothoYS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPJubIQpwHy4vupXIpNcKOCDP0KEJKuBbx+cQM8G/t29Z9eGyj
	7SjZK7eSzi+wCS9g6YI4laqK0jfm60t6Ru/Q91M0N9DaB5NVxZj/pAhvGtUQgWX/LRPuh4ngORE
	mIu8vO2hI8afn0Z5SE+9oKTpA1GMtS6X6yUxVShVlk6hzCkiWMv5XpCLKZ1mCcBlP0Ts=
X-Gm-Gg: ASbGncuGP1ux60N8uPS2ZAf9LlnZOPqPr3+NmqYJqIzhDqRCIPYgGlekKsubfvHjGFh
	tb5tGK76+koKpG3NAPsWAsdAdSmOFUVOdgZmHLxCOejwbQXZs17LYm+EH6cGdjsw45YRAdx+89+
	PVPu4KN4ni8wKxQ7lkJ+/4dPHUbTfWeqC8cJFG98XJxygITcJyum9Ycpjq+xqir6H8j4h6f8OSi
	PV6TLo8qtlhEdtEHOzYingB2XVmqH9rzzGK4fVUoG3ZpaaxDjuat/5n4HN6rEg1HCb06WsO5EjU
	mRnCesM++nxXoyUBqTEAIOWgiVc+0JJLKfZWWQGz+cBGcUJbamHuRsZ+oFgImYzlIp+gI/QUyUd
	kuK2ju5rgruHHlx/iOOE4EUyMJP1YKD4gcssxRs6vyqeQhaR+G2Mt
X-Received: by 2002:a05:6122:896:b0:53c:6d68:1d31 with SMTP id 71dfb90a1353d-54a16d07e94mr6109263e0c.15.1758020583435;
        Tue, 16 Sep 2025 04:03:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8pmwdL5aKOwSmINEgbn2GiMkviQ7ZG666F4+/PsdQLZAgj5aiT/QrcYUMkStouRwCE6p+sQ==
X-Received: by 2002:a05:6122:896:b0:53c:6d68:1d31 with SMTP id 71dfb90a1353d-54a16d07e94mr6109209e0c.15.1758020582881;
        Tue, 16 Sep 2025 04:03:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b6167sm4429373e87.25.2025.09.16.04.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:03:01 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:03:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 09/10] arm64: dts: qcom: lemans-evk: Enable SDHCI for
 SD Card
Message-ID: <zw3efwluvdru4dyf5ijwmsewemlth3dj5oo6gcpkve254myrpw@bfuziw3jfber>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-9-53d7d206669d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-lemans-evk-bu-v5-9-53d7d206669d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=eeo9f6EH c=1 sm=1 tr=0 ts=68c943e9 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=3hZAb_iNorm4NPqi49MA:9
 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10 a=XD7yVLdPMpWraOa8Un9W:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 69sXLEBaHxMtVNNVFUiHO22KQon6ONNQ
X-Proofpoint-GUID: 69sXLEBaHxMtVNNVFUiHO22KQon6ONNQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzNiBTYWx0ZWRfX/gg0+Einx+oO
 xhnJSo43MxTXEfjnRSZ+ONfuqw2c8WDWLpAfl4BycXaw1nCaYya8Z2JUFGT4qcywzK8z4wnsvdm
 6c8pHc1pBU7Vg7aFfIH3kxXNd5X4PV3LDz87BFa3QD5lrNdqwCTdf5knWJ41D6cofXxh11kXTg2
 rl1qswyb4efO9j+pHi7lJk2CsgRymndWnZcWWIWgYQPAUvlk27Xlr1FEfX5HyUF1F7XKjXFKlzj
 mJm5KQyfDnRgM/37zPUf2hq3sPU2xk1G2dA/1/onffcmbkYOn7V3zDT0k/GJs6q+gme+4hQz/kg
 fFkrcAMHKFBfA/zcXVi5Zm+AhbH2OsrVpbEBQXRMoKR8OCZyuHO0D0kRx0uXfedVpMmzUcA5xua
 qJHoddhZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130036

On Tue, Sep 16, 2025 at 04:16:57PM +0530, Wasim Nazir wrote:
> From: Monish Chunara <quic_mchunara@quicinc.com>
> 
> Enable the SD Host Controller Interface (SDHCI) on the lemans EVK board
> to support SD card for storage. Also add the corresponding regulators.
> 
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 45 +++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

