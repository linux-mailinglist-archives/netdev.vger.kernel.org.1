Return-Path: <netdev+bounces-219616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D433B425CE
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F03B4E4F40
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B6B28541F;
	Wed,  3 Sep 2025 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MoqhkWoK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5131E51EE
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914470; cv=none; b=eh/8UuMRiIE5AUXLBhi9M63WlmSFJryOWHt7Zhi+ueXW8Mcxog54Dg7bqAzzQq3WNz+esyNVjSVeXxEJlxymr3O8zznbgfTmhUjaRczhxNIMflzaiitLkCAB863oQmGXirEqP9lDnwiqCqTItlyUX0tWYj4ZQwLWH0HJxYprSc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914470; c=relaxed/simple;
	bh=XInwh7iVomsQx5qogF3hzih+Y3WyM16GQrfW14cftWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUdgr5jvjbtERNwenyoKvufJEeMK3FqhRCeCiBMy1Mj9Qj3COdzbPTMg/qIPbLu15mW2P1bYacE6If4tAfhRQZvZcgQ7wQCcgrFsiELoie4YLxZacmE0pDOwX2dXdcDNCQ2Pn8HpOegA2IKhh9nmd100fnSBGJkjat54SQlClF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MoqhkWoK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dx7F4008689
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 15:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oU9zNSZ+JNQecUFr9QN7ywvBOG1sjWRxRq01g9yamiI=; b=MoqhkWoKRseuQIXB
	zhRJ6euWY97pDSUuhd3mKCZpuIgDFvV/gqKtF8qamruclyNzXc6uR+s/w1GXm5wl
	mOHlceyHakYFsQU2zLvvRoZF1urhyT0xldpqnRx/iZnPzn4thFCjDJ80HDATBZ80
	+Bkg9dZmYVh8WKf7PenuHvVjizd43iSjFLxK9Cqp/M3+EsOMA6jz1w2DLotpCoS5
	uCqGKy1LarQoximJsUB9CeBPnzw2viL3VacWZA0IUK7veCA2hDogndrU+gagpO+c
	3BTzR43Th+S5McMANst+BNgapNJBsojjIsnK2OpJazJ+vxAxm/PUsgKqYWuHZ1Iy
	AJd+lA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv4ck2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 15:47:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244581953b8so650725ad.2
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 08:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756914465; x=1757519265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oU9zNSZ+JNQecUFr9QN7ywvBOG1sjWRxRq01g9yamiI=;
        b=rWWHdxCK0fxF6YG7tDWktr3WCwn5E+dZeAo77aMK+TxxRaMg5cqayDs8Ax05eBqPye
         Wn8RoQ3mDWxa+wM7bp7Vt8EnQjedx84KBL5OPEQWj4szFygyuTHJOJTdcEK2ZalPURKQ
         wktymJgMDKDPRZEzCwCyTy4vxondsJ3awrx80LOsVRVdD1jHcX8aafzRlDYmX9yaGFYd
         BKhVhaVNkrEMNgSIU2OF/qRZ0uV5DazOK1OLOZ8tOBIAaobSiTj3KEC9KtmXIb+Tekr0
         LdGcPz536BsCb7a9yCc7cVq2C7FVDr1ZNnCeJ5guHPzxz0zeuOMtaJlllAYtrxvwKO23
         5wpg==
X-Forwarded-Encrypted: i=1; AJvYcCXgEsEO3A8vuswu7bwxYC9q+LQLrd/3BTQL1HUYyWQ5AYjYg4HYryCqIdAweOzN4ded5Fk5ljM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/T/cFwy+rYBOOTJ147HTAKceXRtv/grUiif/2efFq2mWom839
	XBRhEjZUEGZzNUCWOgysrpVbdO+/rqBHm4Y6fJfcdBQrc4Vo0s3xjpwQ2hhWDt7ggVr0LdLotsQ
	XYvXbdiYl/3zpn8RGSobtDyHZjjUXlGn23hxBSC2pEMaUX8qIKysxN8bnVPI=
X-Gm-Gg: ASbGncsV+DjDPT9jvquRTk+BNBIq2g5+4lniy3VJ3tImpp5EBWrdM4/HMigMo5ItDPe
	gb7yj+qOgbKsIsDJycES4MpEzGQbrct0Uan0Jk4qb1CHDVptqfvxmR3AmG/SkW9cL4+Kmmq5K4W
	CDek+Nl8aWriGrka77Gtz7hv92+8PA1rrtuu49qg6Pn62ygJvp29fAegN1CkzNuklZDuANmfXBH
	AjrYKcTg0OTDJTU2WBz8X4WDb2JtJ0cAtXUWYEpxUJOYwj/YVTZyBjAUvyiFuxgft0RJmu/yx7F
	xIpTO/R55NDOVzR5m0OTpkLTzFtYF5H2U35LXZRMpqRBxxfGUM4OvDXVP36nfhEIbzHk
X-Received: by 2002:a17:902:c950:b0:24b:1585:6363 with SMTP id d9443c01a7336-24b158565c2mr73678215ad.8.1756914465247;
        Wed, 03 Sep 2025 08:47:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4YwLQKquajxMk71cIseTHOUFmzvVFh27auBfgVNaa4odZqX0nZOQA82oA2Q+AJfG8X0fGzA==
X-Received: by 2002:a17:902:c950:b0:24b:1585:6363 with SMTP id d9443c01a7336-24b158565c2mr73677845ad.8.1756914464769;
        Wed, 03 Sep 2025 08:47:44 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903705b91sm166483095ad.12.2025.09.03.08.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:47:44 -0700 (PDT)
Date: Wed, 3 Sep 2025 21:17:38 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
Subject: Re: [PATCH v2 04/13] arm64: dts: qcom: lemans-evk: Add nvmem-layout
 for EEPROM
Message-ID: <aLhjGuaAybp2CeIg@hu-wasimn-hyd.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-4-bfa381bf8ba2@oss.qualcomm.com>
 <39c258b4-cd1f-4fc7-a871-7d2298389bf8@oss.qualcomm.com>
 <aLhMkp+QRIKlgYMx@hu-wasimn-hyd.qualcomm.com>
 <aLhZ8VpI4/fzo9h8@hu-wasimn-hyd.qualcomm.com>
 <c7b87a26-2529-4306-86b3-0b62805f0a2a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7b87a26-2529-4306-86b3-0b62805f0a2a@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfXxGzA4+TP3TNC
 2fgsqAgp5KavLtgSdyT2YAfs7k9cF0e9MZaqGZ/1hBQxt9LARHFN8oMQ4So/ZLWOKhtjAmbj8iy
 nhj/jDYymEpoa0i2TzJIbAL4N6tbEWhElzsfwmuyZRoLj9dmP373RA0dwFJUpNoIVUiAbzF10oa
 fMi48N+Y6D8rXGDQAJP35bMRyUDom6pojpDfwKuO9jLArIcsytkrKJAvzKCDqXNp8YoprHgJUmO
 /0h/uAfsa+pqnCGRTKC95SaVDhu/63knFYeydW9ogmkBMv7iasIUEVey0tRjnCYkuE9zb0NMjqn
 +UhH1EOUFY6ISFjdzIFAfV1//VdKc4q6ICPb+b+gPe18jQ5LMLYEVR5Z5uPHv2ra/CxsA7bFlO2
 4f0oPDCQ
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b86322 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=QqZMUp9YY9ei_m5RKlQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: rEq5dt3aJCxYURMYTK7S72xcjIkYzrfE
X-Proofpoint-GUID: rEq5dt3aJCxYURMYTK7S72xcjIkYzrfE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

On Wed, Sep 03, 2025 at 05:12:44PM +0200, Konrad Dybcio wrote:
> On 9/3/25 5:08 PM, Wasim Nazir wrote:
> > On Wed, Sep 03, 2025 at 07:41:30PM +0530, Wasim Nazir wrote:
> >> On Wed, Sep 03, 2025 at 02:29:11PM +0200, Konrad Dybcio wrote:
> >>> On 9/3/25 1:47 PM, Wasim Nazir wrote:
> >>>> From: Monish Chunara <quic_mchunara@quicinc.com>
> >>>>
> >>>> Define the nvmem layout on the EEPROM connected via I2C to enable
> >>>> structured storage and access to board-specific configuration data,
> >>>> such as MAC addresses for Ethernet.
> >>>
> >>> The commit subject should emphasize the introduction of the EEPROM
> >>> itself, with the layout being a minor detail, yet the description of
> >>> its use which you provided is important and welcome
> >>>
> >>
> >> Thanks, Konrad, for pointing this out. I’ll update it in the next
> >> series.
> > 
> > Moreover, I notice that compatible definition is missing for this
> > EEPROM. I will add it in next series.
> 
> I think the pattern match in at24.yaml should catch it
> 

The EEPROM used on this platform is from Giantec, which requires a
dedicated compatible string.
While the generic "atmel,24c256" compatible is already supported in
at24.yaml.

-- 
Regards,
Wasim

