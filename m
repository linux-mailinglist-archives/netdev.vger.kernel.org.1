Return-Path: <netdev+bounces-223477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A3FB5948D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BE4481FFB
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482062C0F90;
	Tue, 16 Sep 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cxxFqk+s"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF729DB8F
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020431; cv=none; b=NwUuc4FjovMeHsZ+Q2ZinuxsMSU5o32OXaTxM1BXDjDKzgEeh+8VRrG43F6envs4hK/Je0g/1qm/ZBhz+PAGm7ka23m2H3FeVGXSOSPDZoa20PgY6vVh6oZdF8ZMZac3fk2XGhfOTCtTYi+ltlLOdtpCmGcKalM09UC64jTi728=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020431; c=relaxed/simple;
	bh=M6Zqo8Ymcxu6eRx/7fcnIg/xojiXutzI75zXFiJxqNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gV3UMI2Kmya0Kxhs9ymxasf/IN/Rql1huxqMSaKu3XUACrihnR23eJhwSIRWeVZX139w+dAbAve1iGq3o2Yvd/sLjRmrYUbfCsFIeYSQRsTmQE3tqmyCHJgEZjhKpc9LKzbx59WpplmFYasu8jjhMuqWeEd1fHedndWBkg5bKbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cxxFqk+s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAW1OX020358
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vH/Rjq1TuanzbCVidX6mw4sX
	aElF2T/40jPPuQxAJJ8=; b=cxxFqk+s3TclutWcPBPpzYKxUvMqL8f+BX1NlLvw
	ABaC7fj13xTysRPsNiqHutQuPgUXUfajjvhnPcgnpF3yFjWIDJC8tU0AofVVaW8q
	b+A2/WlC8ytZpKXSJSWwCR9IUSv56vUbt5zYFwbxV8qRkdMEIqNaNVnek+qeUd3R
	aOyLlZ0T9sbcnTkZsSV126/F7ICaKJFIN8DwiTUrfEiT+ksKZDUAgIKXUmLOzCSG
	tpiEucz+MK2winOlvCc7US0oDuiJqYqr+hC81zk5kAIZkcezCUHAzvC4kZqAtD9j
	aW/LUY5E9540RHna9YvXk3SxcXqqWJMQtGOJL3t1alw8/w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951chghhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:00:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5fb1f057fso76463231cf.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 04:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020427; x=1758625227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vH/Rjq1TuanzbCVidX6mw4sXaElF2T/40jPPuQxAJJ8=;
        b=dmW1hJ0EYlwTFv8DeE8FIxO8/KesYcbWvMj2NYpGNoEgKNm667VxwZOuYgyGw902HB
         khUV/YmnLeKZUkS6hfYvbVDUr8pv78EP+PmKvtIQ+cq1dr97TmC9IJVQZW12BP5Tuqt7
         z2rKftwaKitX3wNmkh1TELUJHuhdjsJ3CFpu0qG7A2o+GGmmtzFWO1d64lZxMl76XYoh
         vV4hBETGcv4c4B2Tep8AsiAWZpv9UaFRAQPiVC5HSCTIeIB5dwzqwqDz5ed/QNVB71Vr
         HVVKRhDfonVKCij/X6/ZWcT315Lop6Uz0b1+4yls3Ne86iPKLDSfIcvIy40yOFEpSUHJ
         e+hw==
X-Forwarded-Encrypted: i=1; AJvYcCX/TwzIT7dvCMNPgK8EXaqZLxmretrzJnTo0Z/5RYUJhqa32iQegwULZ0z/lUuzEGwInxvwNVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSXfMGzkQ0Qo4NPWCRPl+e24Kx1ge7aG4ZrpZzvGqK76gzDA/C
	EF2bevCDWpLxjmsz/b4XjFerWwVycCY5KdpKyxjy/73OirjEhGejBwD890JqlmYljIsOu/FVWar
	QyuD4MXd1R+6i/J3A/9hLDv9IYjHf8PjmUkGTzW4W2rjqLr7IeHWtqzDoZkk=
X-Gm-Gg: ASbGncudMN+5vb/w/7P7hqX463TGCRiDt2zWShnFmGTVp0WY0La6qPN758UCCqRe7a/
	WADTTJZ3KzuZ8Q6exwH0t5k4mkF40Ua7UsGWhue1AT0RJLKiBGaOpnjoLdE8qNgy/KL+e3hDW4c
	Q3bBKbw+OVupLGxC+guMtK27lItfCEzq5313B/j5VBls6ezWz6DWws67WLKOl3NXqt3ImYn0dhm
	zX7Bfi0/Li6DkReEg/b11zksrdqgzJtY0QVSAnx+wTPzGZKn/3+RIiDPl2duUjDd1DNxaFakITE
	3/1s8wN2GEh/mdV1Bl7LIVBdHlGmTit0n0iya323NOtHHUulNQIxVf9Xf9e1cXkcRm25L6VdXUC
	/B/fQ5bYlPOKeYdY+6WebzMXxB6rE5Pu2SJb1ly/L8j2BECDxD6/8
X-Received: by 2002:ac8:5d04:0:b0:4b5:e12b:9e1 with SMTP id d75a77b69052e-4b77d0aff86mr159715091cf.60.1758020426798;
        Tue, 16 Sep 2025 04:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEqyqBzvf06O0P8M/2FvHMvziCp9UQog00iNc315yVML3/M3tQIwWCuaULaNoan+pHArDzpA==
X-Received: by 2002:ac8:5d04:0:b0:4b5:e12b:9e1 with SMTP id d75a77b69052e-4b77d0aff86mr159712941cf.60.1758020424897;
        Tue, 16 Sep 2025 04:00:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63d9esm4235593e87.70.2025.09.16.04.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:00:24 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:00:22 +0300
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
Subject: Re: [PATCH v5 06/10] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
Message-ID: <kq7dqqjaw5rgdx7nubycj3wuwqor63e37vploqw3efo6qa4oir@faorattts2vs>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-6-53d7d206669d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-lemans-evk-bu-v5-6-53d7d206669d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=eeo9f6EH c=1 sm=1 tr=0 ts=68c9434c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=woMd_khH0HIeFH28_EQA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: et0uwY4cL_sHrW7T4MwYfJVjaHjL4T3r
X-Proofpoint-GUID: et0uwY4cL_sHrW7T4MwYfJVjaHjL4T3r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzNiBTYWx0ZWRfX/82jRXsaNvt+
 l3xw6PnJGwwVhrFkd5Xae/RaRZF8BFvme+ZRkny22U/utcB4SM8xg4BDjZQPVzHGKOCWLGRYHnr
 3B/aKEZJm/dt/0qQ6BypiveCj7EiNnLHzRWCfk2FtDQSRLyvkqn1QYrhRgUJRINgf8mJjdUP84h
 a7JjrQAEWrMncYQOlap6lI+35UWSIjAZGznaLWuOiInL7AHkxPEb1hXihwao+lpeA/Fcx2Txqeb
 +22Jp3BdJfHv0iTG8lVI3V4tW4tcbkTXUXXTi94pHrPM2+zE8KrL2x1GLKdaBAlULdFnznfLFHP
 cToDDGo8kt55yMO4WzSNT0u+lTmoeAFe55jHYvDBrI3H1nResEycLOUhZCQYY853KblkyA/4QFD
 I8sGYdPp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130036

On Tue, Sep 16, 2025 at 04:16:54PM +0530, Wasim Nazir wrote:
> Enable remoteproc subsystems for supported DSPs such as Audio DSP,
> Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
> firmware.
> 
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

