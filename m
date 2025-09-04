Return-Path: <netdev+bounces-220027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFF0B44379
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1945817940C
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B1B30EF80;
	Thu,  4 Sep 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OodcnVPr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31238309DC4
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004214; cv=none; b=HkYUW1voL3Ysa9fFGhh5Ntq2pSnVGe2TmkFHt3eCCPRaICToJ+HZIYIQX0Chd8yVLTUFsIjQT6szzhnjno6L9X7NJvJzkvVWpJUrrR8dgjcsaiZXE4luyZvK1ZgwFzouROqlX6Kd3AI5MII6Eop/KQdouRuDf03N7ujrhcCLHR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004214; c=relaxed/simple;
	bh=w2dejdkgkOfnR6ZZTToOeg39YeTLEfhrSvr2kuE6Luk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4SLhyPBO2Ol9YsYJz8uuEPkcau2ZOn2vDOr5uPkRydWPaAH2hb0eS5nU0QpMfLYCgsLogX/7VtdSEjInUBHcP6GLH3m+2lIqjfCrd7iyxZW9V8GWJ0HPFjoTEIb11mB2i/b5FJZ0X9jShK69AB3OG5qS0kEguOab0Qp3xW4TVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OodcnVPr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584GFv9v028221
	for <netdev@vger.kernel.org>; Thu, 4 Sep 2025 16:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=194cO1GmvVxOIcn8RfAnyM1k
	UF1gEHExRQSWfZpXVr8=; b=OodcnVPrmCsLxy2Ifo65URS3b/n7rJGtjCtQrPr5
	W0/TwIJsPKYuipsemCHLWxwqDYvck4Q65+3QQ3Nu59kBnc+YuocNLB7DqX54Z7k7
	5PPbczjGmEifemYZq/NRv2bV7ySZG/bNC79Ftn13pmGDQCzolsfjT9CFjFFnmMqe
	b6Va5R3e1WqqbePZYivyGv728YorPdGIWJQOxfuTezpM0gO6ZWtdUJL6eTL527T0
	A8wC9B6xhzsxwnJDnb4cuVC+b7FeKUyz8LuKD3LK1vXkcka4grf9Mae0Doo+UtmK
	4z1dnxQfgzGfHWIBRhWArTqtx1X1rnQoEedB1BbWcpHk6g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0erbb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 16:43:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b30d6ed3a4so25105351cf.3
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 09:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004211; x=1757609011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=194cO1GmvVxOIcn8RfAnyM1kUF1gEHExRQSWfZpXVr8=;
        b=IHgqlkDOgN8qlFY9vyq4tP7jiW2Fm4o/MV/Myzgygh6bi0cln6m5VFVagDF7NrdaHz
         02w4jk5nq5gEmTxKzUyG8cXoPrIt8mLIzZk2K4FkpfV24+zJy2P2n4cnAF7FexO+pLqW
         egRsYj0ijt96b8tdT9mwn5JSX2SZIpW9DgQP/llgqmnL3lZPuTgiYRkc6buY/yGJ7EcE
         OUzqjV8vKWWfKGs1JjeMbDjI5UC68GQxH2fNdfxKqM/2PWsalKw8xZKJsD6NZigLb9XA
         v5Ud1rxZ6rYl469wgXduezqARjWar7NyJqsM6PuAklb3rFAn9unac2snNVKwrmv3hs5O
         hxAg==
X-Forwarded-Encrypted: i=1; AJvYcCVBrDle+vq+GHkBuAK0JbImVdN1fdnhw+kCA3mHa/E4ChPKdjs24OPiibyUMiAjlpkSapjeWgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYTMXxGn8AkP+euGUvXF6bfm2+t3jzJ4hdt0IwiWunR31s1qje
	23FDNlIC72kERXPXtgdmtu3dNDioSHTOOdmxAZr7z7B3gd+st6P/5Q50ohmGZZzKAceIetQFMP3
	+6T/BMgvPHw3BFGpN2QBDmmsCxgN4LryXfQTsgliJBA7kRt6QXXcPZSNDWPg=
X-Gm-Gg: ASbGncsK4OPf167aoqHFBi6JadHTgtoy4HTDO8LwztJZhh3TWzLqrzJTircNL7VZEfz
	QUVmN+Eo6M3kbiBVlBGCSHKJNHQcqaHVHKvBI/nsL6aZ/Nt9vKkr7fE2Jcsok8O3rSljQmg773C
	eojvkjWYr+fhyr4aVr5Vv/Lz7I8UqpaI+/UPd7NHiJe1ZQMDitCS7oqBQwP3a+KTJY8ZjsOzG9x
	WcHvHb2QtrP/ZQAWEuq1wjI4ijhzCmAQxEc+mrbNClZWaZmk3VxOWdDFbKf8KPIFj8PN3n+5Jmc
	4ErdllHM8lehfIejCdbmP8cmlfAKgT+5g5LODoW16n9gHvV7SYPlOL7byx2k+kH14Sf5nZtXc5p
	EmoEgROWmpGJK5K3LuXrSpNMSlmkOIaoM089ameFeAgThTDLsfGnn
X-Received: by 2002:a05:622a:1350:b0:4b5:8c8:11a3 with SMTP id d75a77b69052e-4b508c814f3mr64211191cf.50.1757004210856;
        Thu, 04 Sep 2025 09:43:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoXhcaDoqYlrzIzgBJXwbTTQZl4p3OH3mRMEaeJAudeMwawR3Sn0KzCcUZMEdXKJuLkxKt0g==
X-Received: by 2002:a05:622a:1350:b0:4b5:8c8:11a3 with SMTP id d75a77b69052e-4b508c814f3mr64210331cf.50.1757004209938;
        Thu, 04 Sep 2025 09:43:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab5e28csm1307921e87.17.2025.09.04.09.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:43:29 -0700 (PDT)
Date: Thu, 4 Sep 2025 19:43:27 +0300
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
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v3 05/14] dt-bindings: eeprom: at24: Add compatible for
 Giantec GT24C256C
Message-ID: <qya226icirpzue4k2nh6rwcdoalipdtvrxw6esdz4wdyzwhcur@c2bmdwnekmlv>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-5-8bbaac1f25e8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-lemans-evk-bu-v3-5-8bbaac1f25e8@oss.qualcomm.com>
X-Proofpoint-GUID: _CXjfUx4w9qkO4oUimrSYMeTpqrRJaUQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX47SqF5kXrBX1
 IqoV2PZyARXRh0OdZocWVYPvcSS+wkxUVE8VyHDHCR33oBHqVmIFUZsmmHbg2vP/iGQ7zUrI8Ui
 decBv2n7U0EKeLazsUiLlwdaSKaqaACSxUBli0nCF7l1jnBvliVl+T+ldyk3bmECpNW2/JAVQhu
 FCPJnqCHKzFkppKq0UUFu9mSMtDDnzVRwyj9FRQtjTEhbNSuHEMP+joP6FIglKGQDyzGLjAX/Ca
 SUvjwdwHCcD9mN+Ckf2QzBte3AjtXSzv9NF3EYka8M5Oeq3nVsB7r/PycYauz9rTeeYydviRjoz
 kIFFAA6hejBY+3lhxoB9PJ9YS1mhBeP1sds2TXsvG+WpNyiCHQjd9AKBSU45PQfsGoeNpf+4F+l
 iLrVEELU
X-Proofpoint-ORIG-GUID: _CXjfUx4w9qkO4oUimrSYMeTpqrRJaUQ
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b9c1b4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=E0jHSIb16-xZ11K09xUA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

On Thu, Sep 04, 2025 at 10:09:01PM +0530, Wasim Nazir wrote:
> Add the compatible for 256Kb EEPROM from Giantec.

Why? Don't describe the change, describe the reason for the change.

> 
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
> index 0ac68646c077..50af7ccf6e21 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.yaml
> +++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
> @@ -143,6 +143,7 @@ properties:
>            - const: atmel,24c128
>        - items:
>            - enum:
> +              - giantec,gt24c256c
>                - puya,p24c256c
>            - const: atmel,24c256
>        - items:
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

