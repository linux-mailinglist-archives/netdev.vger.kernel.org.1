Return-Path: <netdev+bounces-192948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4A9AC1CA1
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 07:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03563A27647
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 05:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D41E2236F7;
	Fri, 23 May 2025 05:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YEh1cDc5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8561547F2
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 05:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747979382; cv=none; b=Eqb9G1UpQsVNbfcrm7EoUiPKHyN8AxK5GtAyw7C/bqwNfgd7bs2pTY9v1Q4x/7xDDMPNrHIAxbEqysguzt3EJQ84jXGjagBsqtQolOeWwfoQydtytXRk1+CqH0g/bvojfFSRb4fWMVb3THZRkKnSndt1uE3gIt9Gbe9kjFDfA/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747979382; c=relaxed/simple;
	bh=nplSLQmz/ppJRQtW5aFIEsesjnSk93/F8zhY86zPftU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cECaja+jvBm35CBmRpoGCALVChAxhSFTYsTo9MyiqnXLcRCJdcD+wSWJ4KGWJUF+sSdBccv9gz+UdnQglvNqnChLKVzehCZwzxVAs/knNZ/2STxrCivgXbSl8ZcIreaJdP5Jp8lY0EeSbIlHbY87Jew+y1zugbZ9XMrpZTbEY2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YEh1cDc5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N36Ejq029063
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 05:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7SfGjSBw5GAu4E99myfFk4Hd
	Ng8QxEWTCMYdPfNypkY=; b=YEh1cDc5WzJiOCJ4QTIV03KG3J/qu/exi19e5nCs
	LD/U4O4Jx59Ol8+Ny2GkDLQM5qrI3o2MEyMMNQWeseHn3NdDetTMrzQIosF0N17G
	fj3j6RnyUDf45LHulkpqhOYl+M79sTfMOKUHg3xtvzkP1f/TcuEhcdNR54NMXmIl
	OvvzzWFqdH/3ViRwKH3UPYVmAQ4br+vCoXKz1yxxgBe6lGm7kpg0a/6HniGn4QLd
	oK+dx7hFtIiLLWgfMicewDmcLlc8zURPZ5HQHWAu2sDiOqjWF77RcWNPNITAD3CS
	ScQtRzuKpHJC2G/PMr0QJ5nFYxUqD2a+c421iy03efoWiw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf48uey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 05:49:39 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6f0e2d30ab4so143548086d6.1
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 22:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747979378; x=1748584178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SfGjSBw5GAu4E99myfFk4HdNg8QxEWTCMYdPfNypkY=;
        b=R4i2NH7QXDtkuP+H6c8vyh8Dn0Uw90UcOQ4soMfblWuoh1KhRH8vj5bDWJcA0rVwEJ
         +B7FS6pjaTH9Z+z1lp1yC0gfDKwnrvdNlFf5azhiyT636N7IY0SlW55CSNwpLpej+40V
         KiU1EZRjjoq3d3SdZpgAtMgA3XtIfkBP/NgDBrweAID1x15hFaodDJhd5S0w18mJB8Qu
         g4cw5UUSqJK+NKExLW+So9Va4pMAYg9ErlBrgDs3BJW5+Mgh5gyYZRW9WDUoJ/etiiey
         QRn04CFHafnOT8iZpCUIEcrv+n19J+NMiYYmtRmQVJQZ7Fv5gCo7BoWgTjmqJ2LBeEF0
         Jmpg==
X-Forwarded-Encrypted: i=1; AJvYcCXO7icR4wFHGwXXzyD7l9lhOaWqsX+Hd8Q9eRWTNEAg81bUfjJrRn03JMyCcdBmkWgK64feMTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyygUkPvEfCFKXqNHqelE5XQSdJPlWet08xUmhlhSiMoelnqxSe
	/4k40Do+bRlCkArE75cCwxu5e54JeliY4N27s9yz1aMrqueT+zn3rl+YrhDm6WGqS7Z4c6QoLo9
	NnfnNB636HnEsShDE1cc1S7AGfZM3PDnsowvw+B62Uhimj0kTDFE0HLAscCs=
X-Gm-Gg: ASbGncszmt4mP29Oa9BFCvzo6dck7k184DIlxMDjXCZHLZKTHBNFC7ZFpdDOoZTfu8U
	6sN6I7nY/iVP6rc+gP9ttdgT3MWkjxZMWzf9XhHGQYoFz7q4F7DgCgBzndjPfOmPpAq1fLw4MTa
	u64JaDsUbi3n1aoH4nVcfw2Pk2XBunadIJR6L6UN1qKDVhYppKvYf95tdsfTnT0qbH3bzrcDADr
	ZVS6RYiM7DHNKGKwxuerlrlZZxkeOTZTqGGBm8ExpCSdKsCvHTyrcddm4Oiq2+otUWa7+44VLcp
	ulJxm0tjRuBdkI6etSRknsenEsfrFxHrMZGS6ZmVoKWcGYhF0iKoRsmIdED7Ti0+haaO+iwUs6Q
	=
X-Received: by 2002:a05:6214:20ab:b0:6e6:591b:fa62 with SMTP id 6a1803df08f44-6f8b080f716mr430806376d6.5.1747979378369;
        Thu, 22 May 2025 22:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFheDJVlbefAnPn31NTy3OIuOBaiLApvyN7B8S1z3Qk02zHaxCAQYIRo2JyE3+NGM5OzGYdZA==
X-Received: by 2002:a05:6214:20ab:b0:6e6:591b:fa62 with SMTP id 6a1803df08f44-6f8b080f716mr430806236d6.5.1747979377959;
        Thu, 22 May 2025 22:49:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e6f2fbf4sm3722164e87.70.2025.05.22.22.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 22:49:35 -0700 (PDT)
Date: Fri, 23 May 2025 08:49:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] net: ipa: Grab IMEM slice base/size from DTS
Message-ID: <pkimizoecvqzzioqyd333lrchjkjo6to5fnjezbgbazjsowg5h@5mzjthmzeijb>
References: <20250523-topic-ipa_imem-v1-0-b5d536291c7f@oss.qualcomm.com>
 <20250523-topic-ipa_imem-v1-3-b5d536291c7f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523-topic-ipa_imem-v1-3-b5d536291c7f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA1MSBTYWx0ZWRfX8JtOIWugSAew
 BeYDJJQhskRywq2v1KSbgasBJeq+yFeGv3ZiX/7tU9c3ym8ZdPF63QrSO9BG+re3K0CpLSfs2nU
 PPTEqu6DS3z9SnU7iCLfSYbHc4A1ImQStId+A8NrgBgNIvzXR7UX5guyeZxylvY2zjN5evP++Py
 AqLqDC+WP5ws+NaNF6T9sMhQZ/iIAnDHjz0K0MFenxUc4EUbV4SNp7HJLCldAmZjVc8jN2+Bbdu
 86RDCje8fHKjxtXszq9RHcl1sVBwcPD0yuBVRFuGwreWlXD3+FFLuYAYZ5I0ivd0sb/EsMzbyLl
 aRYtr1yFRTCKx9/nTpASYB/tjV6x/03R/L+M3SUJGbAtWHaRUSJ5ki7uOM8ULGe0+HVD0QZN8nI
 j67oSIb0+B+uWhcIRggCY/4gyHId7nJAwTVixCdvyU0HNYeQT/3CNyH0Dfh5ucFeiDavJZro
X-Proofpoint-GUID: H9_r_bj_R-rV_Yo_MJn8V1wK31LVm28k
X-Authority-Analysis: v=2.4 cv=Ws8rMcfv c=1 sm=1 tr=0 ts=68300c73 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=EkgrmPCljZciWarWCYgA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: H9_r_bj_R-rV_Yo_MJn8V1wK31LVm28k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=712 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505230051

On Fri, May 23, 2025 at 01:08:34AM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> This is a detail that differ per chip, and not per IPA version (and
> there are cases of the same IPA versions being implemented across very
> very very different SoCs).
> 
> This region isn't actually used by the driver, but we most definitely
> want to iommu-map it, so that IPA can poke at the data within.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/net/ipa/ipa_data.h |  3 +++
>  drivers/net/ipa/ipa_mem.c  | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

