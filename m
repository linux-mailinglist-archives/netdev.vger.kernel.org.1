Return-Path: <netdev+bounces-239944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 151BCC6E407
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84FC13A3292
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A45B3538AB;
	Wed, 19 Nov 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AWHf2y5r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bkG+MSjz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9351432ABF6
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551674; cv=none; b=BkpGhlicHItF7imiZGZc9lv8AYk4k79aMq++IUBZvVxteesqPS9pjtrH6bS9983/3DxXp2Rj5pVSSmFFw78GWubRd0pzSi8u7SlEIwpsY0NeTtcuWrpgc/+pcxvZH6gRU05AmHaUNUi8oEDuEu1SCPBQo8n3XZt3Ra1buwoU0Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551674; c=relaxed/simple;
	bh=eRPVVHGIz3DHYU1O7ZOYH/eQeyBRv9Sfhbel71R8gsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STSVsC9UwbXbn3HqC1JIw21soG1VyC/ZnSCUE78f/kdJEbRAIxT4tIp9K0iqaGHbEGitoyPnRtRrvLKXxb5k9+9jzmTikcWngDc8JmbCu2pJ/sJs7p+qMwTBJnwLo0TWT7KcLXCqc/nQLGwo7EH9jOSHpZHkIpUNlxpacltiy+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AWHf2y5r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bkG+MSjz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ5FITs2802575
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 11:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=htjqet1z8r5meoFg6hkg4pYc
	+osGI5Z3qXMT5iYRGBw=; b=AWHf2y5rVWlQhegBtAH96wfWD7vy1ku4Now4oTx6
	vOD5hF8mqIude6iQzXH3prNU8uewBtuOqEnuAdtzq1PVaHVRqO3kU9Dhsw3lVODv
	eGdNSbmaEF2P7Xs3gJiUx9YIyOOaVeG9SIijl7FaCoONfUZhgKVi5J+vYvMAqzgr
	CDWA3HYZP184KnWX1tvvMTm+bGyeINh4fIpG7Km1HwusPKGskNkEPUbH7cZW9Bn/
	3ojbNqT9ipm+y2uoGWJ6ml0twpPEBrd6RkzEDG4YVSjbqXLf9erZfrRCyRrzDPGl
	F9iz1AuDT1dIaAbvbQ0bSdWtiAOWvgDJGT2i5j/OlPsjjg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agrk23s43-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 11:27:51 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8823f71756dso85515616d6.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 03:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763551670; x=1764156470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htjqet1z8r5meoFg6hkg4pYc+osGI5Z3qXMT5iYRGBw=;
        b=bkG+MSjzg4HY7mALWB/Iq+Mz9OZBe6wg3a3uqitD4LNNtLNE24FYxjMR9LPx0AwOTu
         GIbzgosx7FaFykdnFognEcU1a7oGisLHW6wlG8hGZbNbbNvE9WM/d7ZDeV+T/bKxztp/
         rOrN2APRge6uTy5sf/kuSLCnyq+NNvcQr8ZsldH+++7Mtf/wDHn7Ktq3toXVPNw9X+/F
         ezzSXmX8jUMyH2Z1RloUlCcmNwhvAB5fhew/aQLvQ3ujTNsjmNIMtObtrMNNpTh8hkDX
         ctLVc7v/Z8w0jmAzdAUA/xK1YrPZ41w9IEBVFq0YdYG4qv2p139kTKhAmdZsfnpMtnbn
         qyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763551670; x=1764156470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htjqet1z8r5meoFg6hkg4pYc+osGI5Z3qXMT5iYRGBw=;
        b=gZe0adFC8T8EwaYKNE8i+ZDseJhUJW7xnAF/zd5LUHfsRigPbZVC4P2/GtLWcX9i3X
         tRW4UL+eiEvANNmtav2Tg4Lf9pkdNubEzV6uGwvYbbK+TI4b1to4XRofFwE4vi3HVMmP
         n/mBIgeTl9ibmJhW48Y7H7bsmDgf9XRY41KOU2UNUaNrubjBHpmsB8fgLV1zQ7Iu746H
         W5hGO2Yw/3vZ/6LGBe+7CoQnSD7hvVQjOjegPVZhSuNAB1U+zgEOrYBFZ8u6FjxJizKn
         muAyeN5joqy2ifxrYd4IC+9OUMO9vVWZv4A+zHhz3FeMBdeDz4enpRi4pORq2xirzYli
         85xQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9HqxkXjnDqR8cm62J3lAH/CnWiBJlYjepMpd6Lg1uBYbxtUROrJH1ggEJRqRnIRwowAaWRQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFm9vtyMx2Od1Gv9EoIc8EZHqhijb8gFCc79rTroJwf8Jwws/p
	Wvm59IMnclxic2TJ8D3+DOoanReiVH/OdEbWAPfT126FKFETbDGaW0pGcW4RCki6L5N+STvz9+R
	uKdoe1SC2mOT6hjfICwiIWVswmjl7QqacH6uOQW5mMZCxXxeKnrB9L0bNwmo=
X-Gm-Gg: ASbGncvOtCDLNHigNiFQm5C6LO16uwhNLJlxy89ivbd5WqGDPmTYWeeFJ/4mkDgPj6z
	YMsRF/wcURp/VNdF9p4fZZgU1oBqgl3Z5MyqpsdTjl56LKH4pR+5HAFOmi8iUq1dYWfzcO2C9XY
	FmvhJ36zcbU9KmjYJlawM1yWxdGJ3oCITq/+RMufDAzZ5CVGKScPDVAIlNxmMnPHLlO1b6G2hVf
	xxE8iuGlSy2G8zSb0L/X/nrZZY9OqRV84yzu9zYaruYgJAEfmFTnE1xJAL6EOYNQC0oMb5pr9Xg
	ER+h0ZMpBPPmm5MRzK3LBQm1CYyZPbTkoPhf3n3IGMVUKj1ZjYdU0Dk4FheTIMAvsvQejE4QXAN
	WVPLZmrXHvf/NgC3ghtkXrsr0NAFQFP1/XSKGeAHaiK8VQ92IouVHKqkepsQKvRUmtl5rAewX4q
	9Z02GbnMW9F4ystQNl/bTvy/U=
X-Received: by 2002:a05:6214:f6a:b0:87c:1f7c:76ea with SMTP id 6a1803df08f44-88292686aabmr245308176d6.44.1763551670474;
        Wed, 19 Nov 2025 03:27:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyHMkVncCkfQ9fLK6iwiE5NtdrxN7grXBPy/3NfpN7Bs+jSnMQrPk3t4w17vy04KZ0+hrZiQ==
X-Received: by 2002:a05:6214:f6a:b0:87c:1f7c:76ea with SMTP id 6a1803df08f44-88292686aabmr245307846d6.44.1763551669969;
        Wed, 19 Nov 2025 03:27:49 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37b9ce1509fsm39043511fa.13.2025.11.19.03.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 03:27:49 -0800 (PST)
Date: Wed, 19 Nov 2025 13:27:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Slark Xiao <slark_xiao@163.com>
Cc: mani@kernel.org, loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
        johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] net: wwan: mhi: Add network support for Foxconn
 T99W760
Message-ID: <rrqgur5quuejtny576fzr65rtjhvhnprr746kuhgyn6a46jhct@dqstglnjwevx>
References: <20251119105615.48295-1-slark_xiao@163.com>
 <20251119105615.48295-3-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119105615.48295-3-slark_xiao@163.com>
X-Authority-Analysis: v=2.4 cv=a6Q9NESF c=1 sm=1 tr=0 ts=691da9b7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Byx-y9mGAAAA:8 a=yYy6iFiXQZVf29SkKJEA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: PH01wy3uoZGtgyDPnKYkJsqIUc9-Yggz
X-Proofpoint-ORIG-GUID: PH01wy3uoZGtgyDPnKYkJsqIUc9-Yggz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA5MCBTYWx0ZWRfX01r4SKrr7sMk
 ir3RxkD4Mj9TH0Un/2+uWsnZ53lCyDV447a7HYjhHTNYzZ5ar75O5Mv9ouZcka3FjQCk8cL/9VF
 O0Sus9KD51yWAsqtbs6YVJEJIlAaxyznziOKQ6ahXH+lSf51p2LZsMSKnQtcK7Sx4S/BUSJWhEs
 UICh3RfTHBRFKU91omJiTQqh80pUaJ6QMcv6MhptREijoXuEopHkuQrlkb1NpUSXoEwSit6tIhM
 WMPhagF2AIS9lOcaoakIqyq7vBT15T7JYORyQ1AHKPrhJVMgJbwcklsSB7XiOat3Uck1MSFEu9Y
 fEZORfPgUmI4FuLQxDSh0kzJSI77ErE5JMFcXBcfAWIzW8pGq4KhDhRCk+HvUMbFfZ/P7p21xtu
 ZAsZi7oRzVSAwjodA8p0Td/ZdT3ZTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190090

On Wed, Nov 19, 2025 at 06:56:15PM +0800, Slark Xiao wrote:
> T99W760 is designed based on Qualcomm SDX35 chip. It use similar
> architechture with SDX72/SDX75 chip. So we need to assign initial
> link id for this device to make sure network available.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/net/wwan/mhi_wwan_mbim.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
> index c814fbd756a1..a142af59a91f 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -98,7 +98,8 @@ static struct mhi_mbim_link *mhi_mbim_get_link_rcu(struct mhi_mbim_context *mbim
>  static int mhi_mbim_get_link_mux_id(struct mhi_controller *cntrl)
>  {
>  	if (strcmp(cntrl->name, "foxconn-dw5934e") == 0 ||
> -	    strcmp(cntrl->name, "foxconn-t99w515") == 0)
> +	    strcmp(cntrl->name, "foxconn-t99w515") == 0 ||
> +	    strcmp(cntrl->name, "foxconn-t99w760") == 0)

Can we replace this list of strinc comparisons with some kind of device
data, being set in the mhi-pci-generic driver?

>  		return WDS_BIND_MUX_DATA_PORT_MUX_ID;
>  
>  	return 0;
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

