Return-Path: <netdev+bounces-223505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0CBB5961F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6DD1C00560
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EB030CD8B;
	Tue, 16 Sep 2025 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iTr63tg6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DA930E828
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025521; cv=none; b=L/Y8Gxv6hE3oHDqO8mJbomP3D5o1bktAFSY/ZMtqD0m2esEwWTWleHh4Q+5VfeIu4y1OS+T3QUeby3v8nd7AQ7y+y6EEVrJGOd4+1C9e39cmxwuMPBBl3fRq+DrIQCwkmDPDl6p10w0QXH3F6txRbtN2orYztcYrIn/bqU6xoZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025521; c=relaxed/simple;
	bh=pYVRyG3Ofnpb0L1Y2+cXoG7kxZMxzvU+i1cFXSKD3ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtSUHg2rnTCYgf7QdWE2A9XfHthdBSfLIvoKgCDaQZNOAJtzR2e6/UHK4ZDGYY2uQjb1n8D5bWmYXQkMEBCLHmk2OwCZRDgQynKJtdgRGbzAcFYskJj/e9VqX/97xIdDzUR9NfDPKfYdf5jr2DFOcGdM/bAEEIn2K3um3YS9te0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iTr63tg6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAdHRp018476
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rUHJ99Nhm6wc+crxDOeKRLBG
	ZdaCl2Lm6idkXPgbi40=; b=iTr63tg6bMh/8ofkmItHfBDoTgbgkxSsxeqAobW8
	RqPWU8Y+xuPemF9vlVaLLIJ480fs1yz1skKfhGckN0oN2LwYZXNizIaGotZJeLXM
	GV6E/+zuLBGKqjalpqqNanWrZDMWqz6pcjwzQVZpCIyvPyTWree1pcH8gPVrnbTL
	zspHCchPYTwaX/N/8OC9gfZGJXbhELE8htESKG1DEDJBWYNEyxcp+WgEirNU8N71
	ogIHxk9eHPC4QwDPhslpzqhBY914vcrJYiCuLjlLn83DnZsArXtkpS5D6nwZ0E4I
	whX++uOYCNM0LpldlBfCXLHAWrJXwzjuhT2tCt4tc4y0cw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496da9d6sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:25:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-244582bc5e4so66335555ad.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 05:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758025512; x=1758630312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUHJ99Nhm6wc+crxDOeKRLBGZdaCl2Lm6idkXPgbi40=;
        b=hCre4PR1GN8ZhVklHvz4uveIQZibrpVnxZluUNIG6m7o0YPKdvKu1I+k8xgGSrgusk
         de9Y2JQM4pum/nZWoxRJ9KJzIeQor8KV/8dPee8X2j/P74Xw5pWnQ/YVycwgTQIPBqW4
         Sy8aEYYx5pnHdJxYExPnX3HghunAI9MP16HOZAs4TK2lS2ANwnPaP47cbHX+G1xvPcdH
         aXOp4IwjLy+4edkgD8xFH+NBNm/0oY5XhlPWAOLYtiYN+NeVpbBzFldOcR4kB23WfNM4
         O3TjV08kq/1vBkHlmm75Bl1YcTP7lpgiVbUq05d4pApYFN+5jxDLhQT79X6UcNftxmBG
         nYkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGmcP3hxext+PtPYZx/Vny1mdvMuaOlUZt05sEakP0OWSDdwWECCTo4bbF+f7vJO0ixftXXg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzuIib9Sjanal2x+GAK6fdUTltS8PfgQotu2EOANUZvWMmgJp2
	UlYkduuYz1YGqZVtNFylOJW5ZL9FBFj9Z4rJ/xNhAH7BDU3tL4T+4jW+f/k1738t1+wbvYFaAZS
	eF9Gu58XN3PoA+XAGzrxOsvGdi6ORlRuiDMD0cLxovks5BVRTS0XjbNTJxiA=
X-Gm-Gg: ASbGnctPxG4+ZRg9rSsFKP/hFtGSP6guj6Y4cSkhA61Bj1VBsNF6bAJIJQLRYWns2ZP
	CIGelg3SEz1kqa0DslYWSFrOcEC1KInuCqgBJ+sh8bFXEITbVn1lXChsVhjX/dKbkwivUoV1M/x
	plh4G+Xb37jJvxVGOvharDhnBLqHf88mKyqv7pYROZADAYt66CoiUYdVoYbmRZPe1oZdlmdn3oC
	kPdBUJzyS6Mk2hr1dFqpX/N80ekH8D9jzsV62PHa+T+xJxyqI/Xc9tdWHihiYbRqltZMi/USnJB
	IEvScQ9x0xCgahKfbATv0iKHYt6kMuNaHDfGzPX4CYeGoezLxDX2APdADVOlE2sQwgHt
X-Received: by 2002:a17:903:b0b:b0:249:1156:31f3 with SMTP id d9443c01a7336-25d243e7fd8mr146599015ad.8.1758025512281;
        Tue, 16 Sep 2025 05:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfC+HYU/Gm0Yu1cZZREqssXTo+RveyP0dKwPWuRl4HJg2G55Yk2LtJ6nUVxaGFtw1OspyhKw==
X-Received: by 2002:a17:903:b0b:b0:249:1156:31f3 with SMTP id d9443c01a7336-25d243e7fd8mr146598795ad.8.1758025511851;
        Tue, 16 Sep 2025 05:25:11 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2676a14c514sm51154825ad.103.2025.09.16.05.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 05:25:11 -0700 (PDT)
Date: Tue, 16 Sep 2025 17:55:05 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: Re: [PATCH v5 02/10] arm64: dts: qcom: lemans-evk: Enable GPI DMA
 and QUPv3 controllers
Message-ID: <aMlXIdgavXT6Ndt9@hu-wasimn-hyd.qualcomm.com>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-2-53d7d206669d@oss.qualcomm.com>
 <n4p4www37qz4hw75l6z2opeqks4g3u26brceyxi6golam7f5aw@raandspcihi6>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n4p4www37qz4hw75l6z2opeqks4g3u26brceyxi6golam7f5aw@raandspcihi6>
X-Authority-Analysis: v=2.4 cv=M+5NKzws c=1 sm=1 tr=0 ts=68c9572e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=jsWzJFLPBp6GKZhRWDUA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: r2FP5H2btmnGxno8-4pad7dH0UE1-ttY
X-Proofpoint-ORIG-GUID: r2FP5H2btmnGxno8-4pad7dH0UE1-ttY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA1NiBTYWx0ZWRfX9GvGrRrqwyxa
 ssdaZhFc7sjLp5/6CGDGGtPgn//frKU+7BQQ8jyahdytAybaLoIYQ+ppOQr/0CoDqtp2+C4uM8i
 rQUDpfRjUPaiyYhWzjxiINlKNa6vx4CV8/R2r/TBOFGXtO+D59L92q/d+THc+okFl4DcXAHV0cM
 H+4hmpwlB+0BfyYWdOsVApcGTWHF3lQHNx6ZGjSyhwQYqnDNbtGKmROqVd2SVOjovlQS8WbWmsD
 I/3NYcLzU69b9rhwtoJCfdWQlGuI+ExAzFF4y86qnTYTy9KbyuRCiS5hbwT40DqvtuaDGQhzj0L
 +qO6bFI/hojoNhBQFJ8Dji3ql81+D6i3hMMXPGl6akYXu5nFUvlDXsgx9lnSJjnNHtJ5Z0wyg//
 MmhwUHBB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509150056

On Tue, Sep 16, 2025 at 01:59:20PM +0300, Dmitry Baryshkov wrote:
> On Tue, Sep 16, 2025 at 04:16:50PM +0530, Wasim Nazir wrote:
> > From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > 
> > Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
> > interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
> > DMA and peripheral communication on the Lemans EVK platform.
> > 
> > qupv3_id_0 provides access to I2C/SPI/UART instances 0-5.
> 
> Nit: used for foo, bar, baz and slot ZYX.

Ack.

I will change it to:

qupv3_id_0 is used for I2C, SPI, UART, and slots 0 to 5.

> 
> > qupv3_id_2 provides access to I2C/SPI/UART instances 14-20.
> 
> Ditto

qupv3_id_2 is used for I2C, SPI, UART, and slots 14 to 20.


-- 
Regards,
Wasim

