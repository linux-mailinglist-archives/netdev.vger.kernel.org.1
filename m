Return-Path: <netdev+bounces-223479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AE3B59499
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 329607A38C4
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6138E29B237;
	Tue, 16 Sep 2025 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mZ6riIwC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3E127B50F
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020523; cv=none; b=GpNfv9iM24Cj04QExHg1hPJMD6pVJUMR4fPd+2kaaMD/vKnQJBRJ1n4An957TquYNDZcF3aMsOHRoRzQJeZEckpgFVse7wGDlckvH1W/g47mXusTssUtK1VgNNWAxBZdkICP1KbVuGOqN9NV+uMLE5s0NWJ79csGI6yeE58lEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020523; c=relaxed/simple;
	bh=JecI4baRKbxg9mlRZPX14WKgBFLLGnH9ACj7lbwRX78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjCkaUrkGO7WKjXkfdK82TsCFQTzom3Lf0TRv9twK14FP9Mk3+Pr0e7vJk3288wSEpYST2Dn21ZFkW0oPmYtuM6gYeh/7CRX5nDO8i+VqcZbf2U7v5M1wWEGowYQyHWPPaWbrrb7KrnasZX2ZPTFtADMJQGN1D+UzkxYE3bmAVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mZ6riIwC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAA2Iv005298
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OWBe468scwOzFXQ4FxY74VVg
	9u9BX5oCReSyR7Jc2vg=; b=mZ6riIwCeVoyP9biCabTnNSPvQyOeOZmDSXFkNgu
	c9HT8QqkzJYfxPZiSKYzkQEG+ALrKKM1nwYKwXlyRZi9cJtIQ7pvWFhS9MqC6WRh
	4YG7jHroAaC6ZMkUlcwInkZ3CNTllvyQLbvJrjMtD/Vg9GAfMc81ddILUn+FjERc
	4M+Yyxp7Hzg2Hl+th7HmfrShx/7DaUh3h02xfMf7LN/HNtlpRT/xiMc41fRfnSA2
	Bys3yD6jE0iplgnAfucmVWEw5pIk65V+b+revqmyYX8n684cgD8/lEUM2COjifd4
	6d/xEsT/Oh2dBvrCMEjm2ZQcCO5NN513W2mGCwMqnKx8Xg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g5n49e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:02:01 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-544c4d72ee2so6250349e0c.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 04:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020520; x=1758625320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWBe468scwOzFXQ4FxY74VVg9u9BX5oCReSyR7Jc2vg=;
        b=qgsVWPQOBQvUWZNtvaIsdAR4YwbzgZMMUXKAVSrSMkDxyJxW9ruCSLMmEeEbLB3QWR
         5m914HPfL6NSYnrZsrhQCD9HF75ZWuErvwMZx4vwNVew5BnzHXfVZH3oAGvGJxfJFQqh
         WkE0oJGRGEqyRCJ3gjiWXBFx1ccUbN8qmOEkIdmP8Slxa047ceNol/A+6hhlKUYz9vF3
         456wczBr6R3dKUfi6FUjXFcVgDKarxMXuLIF7HFdGn9d8ubZR3c568UYrERpiuLsSLlF
         TQ8j1vNFW5yyl8okVcCWhKjTkOANqnvIeo2FT4xnfDrkeahN5Tb3VmkFBmoOoeTdlgbS
         8qQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkPvcCCComjGSd5jlTFTd0etpjaxihynJSl40Jj8cbSBGhAQpHEH9wk0U/JlMgnZ6zNbiANfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzUT+fz+o3MPDQNGtVjHnYzOy+TcGAkNXQt3HAX2wsZ6pH2O0i
	RG1alXRbreS49btbOB85Imih8fcHJUBVrUgPyoDj8Okm7jcc30/WdXeh8/nmGeMaaxmbos6nwmq
	/P8bQTjSa/oE9OdgmN1h2oMk5csWWvLcRFbApzyDfy8fVr5Gsn7djuuRUQyY=
X-Gm-Gg: ASbGncsrxMvBfn44sRRaEfzLhbsVkeoiaP3ik+1keCLUko5UlGLizftahSkubUcCnWc
	+EomDFAkP5CsFKkmOhu3JHUnQMaO5gRN5LqRpbKS0qsqpnlPGfYVvsX1Q8MgGGqKcTAQH6b1yB0
	W/ZFbNpNB/4z0U2wbg+lyvOkHVqD3kN3Z6s8OTNRB5iTIn6I2POlEfevWPaDsRtRQsAnMaDTZ0A
	fbLyrinajz3e2uwenFqhv15tg5j+62y/covHhNWhbh6ppJpgrGCdhf5piHFVAebBXJTFKx80gPw
	AZhNyG1UDo9YkKrKhkBTAwBunfY7UjNd3oeuDnmvzvvX/6gh/id9Ix2ISEgkdalUtdZOB3V8IrB
	rn5Ts/ubUrVg1oUt6BrwAmoNs9jMWtIl2e+YnyK1ZLsof2UzfLD5f
X-Received: by 2002:a05:6122:250b:b0:537:3e5b:9f66 with SMTP id 71dfb90a1353d-54a16cb4b3emr5739173e0c.12.1758020519578;
        Tue, 16 Sep 2025 04:01:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIhQ74kakQxgpRzO0ONsKwulv83qkPHfKj7TAFJZhqWDBg4A4PoFyYmOJehH1fow8stkNEhQ==
X-Received: by 2002:a05:6122:250b:b0:537:3e5b:9f66 with SMTP id 71dfb90a1353d-54a16cb4b3emr5739122e0c.12.1758020519115;
        Tue, 16 Sep 2025 04:01:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-353725e1bc6sm26001481fa.27.2025.09.16.04.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:01:58 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:01:56 +0300
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
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 08/10] arm64: dts: qcom: lemans-evk: Enable first USB
 controller in device mode
Message-ID: <nz2dsvc6qyz47dxfbj4deo5xttnegv2qmueo4k5mhrvnkqh3oo@ddakv5hphfw3>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-8-53d7d206669d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-lemans-evk-bu-v5-8-53d7d206669d@oss.qualcomm.com>
X-Proofpoint-GUID: Ir7Ydhtd4NpPU4_pIxYbJq0z3lwmH5FZ
X-Proofpoint-ORIG-GUID: Ir7Ydhtd4NpPU4_pIxYbJq0z3lwmH5FZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NyBTYWx0ZWRfXwD/d8PvqiYl+
 KrWBRa9dBow26IWTanFZY9nBiTfV+vuE+wDB7uvtJ8pq3KEcoaVRr1tjF77XkIAyrG73EVGsOCD
 o3EguUnDfkSZy3LT2WJ2cp6/5J7SrgL8fxijg1vb48HB0AA1xt6m3tN0Jm1g/aW20LVR8fzM75d
 9+2GO9RJdo2nrnTjn+EXEh+OFs4w/OmDsCdznpR6fxZ4VqjoP2wUEp4QhDbO4RcYhfq6C7M7FQl
 wyvTmMV2xZxPaBMLB7t2I+PKUu1NKsod831pbVrsEUpBBBmOuHPPeylnnixyeR+PbPPh6zuUtf3
 rfq+jijUmYZSZ4J9splp9KEAsDMx4lcVUFL3TO0pRV/nCeKysxZ7qvn0rwoSM7XMMsc6xMLD8wj
 n7G3A062
X-Authority-Analysis: v=2.4 cv=SaD3duRu c=1 sm=1 tr=0 ts=68c943a9 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=B3P4ua6ZyXwAq7e7NPAA:9 a=CjuIK1q_8ugA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150087

On Tue, Sep 16, 2025 at 04:16:56PM +0530, Wasim Nazir wrote:
> From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> 
> Enable the first USB controller in device mode on the Lemans EVK
> board and configure the associated LDO regulators to power
> the PHYs accordingly.
> 
> The USB port is a Type-C port controlled by HD3SS3320 port controller.
> The role switch notifications would need to be routed to glue driver by
> adding an appropriate usb-c-connector node in DT. However in the design,
> the vbus supply that is to be provided to connected peripherals when
> port is configured as an DFP, is controlled by a GPIO.
> 
> There is also one ID line going from Port controller chip to GPIO-50 of
> the SoC. As per the datasheet of HD3SS3320:
> 
> "Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
> not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID
> pin low. This is done to enforce Type-C requirement that VBUS must be
> at VSafe0V before re-enabling VBUS."
> 
> The current HD3SS3220 driver doesn't have this functionality present. So,
> putting the first USB controller in device mode for now. Once the vbus
> control based on ID pin is implemented in hd3ss3220.c, the
> usb-c-connector will be implemented and dr mode would be made OTG.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

