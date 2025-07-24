Return-Path: <netdev+bounces-209863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F5BB11162
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 21:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B7D27B40EE
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 19:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07002ED15E;
	Thu, 24 Jul 2025 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AxghhJcd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA552ED14E
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753384074; cv=none; b=X03pHy/VhcZxrUCVjDJ8mtF8KLHeINPuQPA51tLanbdBmm7F+gB3xb1m/hXg2Ne1cTKFRRy7Y/IKU6O1WkgH1jIXioJ2n9RfuZFU7NwIcvO6ZL2gOA1MwOvpQZiMFNo1OigzUX6FjmMGONU8Qrb2CMoWs66MQumTUOfIdsnngzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753384074; c=relaxed/simple;
	bh=26XDVP5566GAnWIYeOLHW+dlq96NO4/Osy8Txa6q1gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGRZxvrTOf/3Xk9P6vZpYvOaGXJXqIux6DdzjZ4QS1QQn6+Y+svuRsuqtvj3AH/WFer/5MVhYRPrTYTEjjB6+UR0bf7j03+8kbPAiN9QnZ1TnPXsO6CGViidl/hpGjyNYPa/L07KwxaPEZe+QOpwDOgs4guvfu+oszB9R6a0UVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AxghhJcd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9lsqM022030
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 19:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7gLTH/iPfyYd7ztc/IvTC63q
	u18XmYjP9dX1gtpz5vw=; b=AxghhJcdmkVlV8A/LFkqNi4x3192Kt+rBYmEFZaS
	IF7YKhOFYHTyTug3dzCfg2+4qN3KYpuGaXyxbXCUheRyYPklVK/MPsIhEDJ4RJFP
	TPKy9ekePpdtgXKz4jpf/0rHQlySHIOWR0RHkY5ViBo7wIeLNxHn5TrKBMAER/9q
	g8tvXBFkD7/RjEil2nODxKfNoo36W/+dNRCJ+Bd2YPL07QY6MJXu0xRadVSOzGnl
	jXtQ8vpEyIfhZvlKYDnsZ1w0v80Mim1ES1Z90l7Ju2t7zWv/Olfx0JYmukfLw3xk
	yv8TvWPe1t0RYRZxOiXZro4NPxURKkkWK22cTg+D+sNfEw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dskyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 19:07:46 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fabd295d12so26164486d6.1
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 12:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753384065; x=1753988865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gLTH/iPfyYd7ztc/IvTC63qu18XmYjP9dX1gtpz5vw=;
        b=d6oM48yBe24uS1qjxHdz96Oqjq7eO2VXVh+f2ragqnSgNcPZG4q6VS8VZThI7zResZ
         t5U0W8KoU4kNXvCj0+7fTmRDbgn4PFKE/JtY7VWVgqrxaXhPcasOf3Zly5jKIp7B6qmM
         4L3NZBpq/E/3QwE4oUxQMfwnx9cVeudVb/o6W6Tey8W1bSTtEGSLW1eESpR3n2r8a+PP
         wyckO3M0rRlCiVqC1xTu4bqlTTZ/oYA6TTMjqt7lAwJ0DuDN0lfIft4M8XW8Gm7aMF0X
         IGv8jW17C8XPr49jii1Q+Z3kVcKogqr6qqe9t1K8n9kNndPSXlz44U1SPqsJRae1n5NB
         53DA==
X-Forwarded-Encrypted: i=1; AJvYcCVOdQHwZifqlpzoWjH69WLETydpAtcUmHvhVi8y8nt10WtD1+cz7w6e/oNg/z3J1XNjTkpdsXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0hn6FqZDovUVe1XcQ9d1XgawlNAiWiNqfdHaT9kfSmX5Jbkqe
	32TBNZWXoyN86Rj8e3moP9TSAQdTGnS2t0mEAwsmDFb7MTALhD9dUlaMilPLKJanksGjQMWemGY
	IQO01cso2lrqwqmDyI3Rab8bUr0UQHHB7SJMpxJvAAN4XCE3sTQxNOobZU54=
X-Gm-Gg: ASbGncv2aT7PJPiscrNmo5SIhi7EsU1lNKJ0PJXICPVaNa/dblml+BLTaj8hqIHMo9n
	/qPP501AuS6fQPxT/4Oi5qdHNnF9cuS78b5ysTlA9gVWrCba0KVTsre8ztTChR6QiVXAzI+IyCf
	33mcuh4I8DIPwf5UyP5GXyryNU3mpWd0gSU3f58xbixnYBKWxhqKeQQ6o5hn0bbIuIZwdBdKG7T
	2B3oTmUWZNj3Bo8+J4CpAJweWbeKdC+31nE9qILrZe/y4vORSWuMPIDydqrh8uAoboEirwSyUgv
	85d3HlVlKAbYyG88MPkvnJ5rE0zeXqcYQ29zblYXAw0MxN5aRZIoL+L/aqLZ+wRI75GCMirp9pt
	Q4yQqZURYv6/oFOKkTYldbbRQGPRgCTkJldRgLiWeuJxbY+J2bNfQ
X-Received: by 2002:a05:6214:509c:b0:704:8e3c:7b4d with SMTP id 6a1803df08f44-707004b3635mr101404216d6.4.1753384065295;
        Thu, 24 Jul 2025 12:07:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3ezANv2YxvlF9vrpMbyVqY3MqWwG4tyluV4xdmyQRehKExXlS4PDANRKq0ZCM55RnwD9Y+Q==
X-Received: by 2002:a05:6214:509c:b0:704:8e3c:7b4d with SMTP id 6a1803df08f44-707004b3635mr101403786d6.4.1753384064736;
        Thu, 24 Jul 2025 12:07:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53b35dd1sm480953e87.65.2025.07.24.12.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 12:07:43 -0700 (PDT)
Date: Thu, 24 Jul 2025 22:07:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel@oss.qualcomm.com
Subject: Re: [PATCH 1/7] arm64: dts: qcom: Rename sa8775p SoC to "lemans"
Message-ID: <blexn4zno3azgfbh4vzh7daizy3lbh5s26z6sivtyqgb36phnw@neorhsyqrgz4>
References: <20250722144926.995064-1-wasim.nazir@oss.qualcomm.com>
 <20250722144926.995064-2-wasim.nazir@oss.qualcomm.com>
 <20250723-swinging-chirpy-hornet-eed2f2@kuoka>
 <159eb27b-fca8-4f7e-b604-ba19d6f9ada7@oss.qualcomm.com>
 <e718d0d8-87e7-435f-9174-7b376bf6fa2f@kernel.org>
 <fd1a9f2f-3314-4aef-a183-9f6439b7db26@oss.qualcomm.com>
 <3cbbace5-eff9-470e-a530-36895d562556@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cbbace5-eff9-470e-a530-36895d562556@kernel.org>
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=68828482 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=PDmsC6A1k5bsBzTUqyEA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: 3CJMbUuYsiT8ekbam5OfzSX24SymxhHg
X-Proofpoint-ORIG-GUID: 3CJMbUuYsiT8ekbam5OfzSX24SymxhHg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDE0OCBTYWx0ZWRfX3UFB+hF++J1M
 7Vc/MlCBq+/HLEcqFE0hXVuShd23I7SUZKgkUgJpzMeXI/sKo9ARj5NUwRhTePmMcHhcRk6XGgP
 WmwsbCnov2Fho3FHNvHoep4QoMQHz5qZL7wdIItZItTwXmbAvvgmfq9VDnG52Q3ifLdgAv3NPD8
 MFw6JWjOAgiSqJpcw4IxeQT7GbamCupQntvD0w+L8m/F2pEMxSPTOSW77wyOALxbFDZ4f9fJ7x/
 zMWMzp49WxR9D+OJj63/9uiYoYSwygK7lJcdORFXD2ZPntICD20jeI5HG6SIu+oiZCg63Qwkw3o
 5QOJTLo6QwcuvaBHA4czp3zi7qyuI2RjIprCE6hZmhakeqHkgA3+IZJNaySjpUui5gW7DNGZzqe
 WxS4RNx+Vh1c+wqMhcIdUQUrJVAR1CkR9tBQU7CPUIjd/2pfGHjVw40xAbEn8+fpS2MGLMwy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240148

On Thu, Jul 24, 2025 at 03:20:29PM +0200, Krzysztof Kozlowski wrote:
> On 24/07/2025 15:11, Konrad Dybcio wrote:
> > On 7/24/25 2:51 PM, Krzysztof Kozlowski wrote:
> >> On 24/07/2025 14:47, Konrad Dybcio wrote:
> >>> On 7/23/25 10:29 AM, 'Krzysztof Kozlowski' via kernel wrote:
> >>>> On Tue, Jul 22, 2025 at 08:19:20PM +0530, Wasim Nazir wrote:
> >>>>> SA8775P, QCS9100 and QCS9075 are all variants of the same die,
> >>>>> collectively referred to as lemans. Most notably, the last of them
> >>>>> has the SAIL (Safety Island) fused off, but remains identical
> >>>>> otherwise.
> >>>>>
> >>>>> In an effort to streamline the codebase, rename the SoC DTSI, moving
> >>>>> away from less meaningful numerical model identifiers.
> >>>>>
> >>>>> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> >>>>> ---
> >>>>>  arch/arm64/boot/dts/qcom/{sa8775p.dtsi => lemans.dtsi} | 0
> >>>>>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi             | 2 +-
> >>>>
> >>>> No, stop with this rename.
> >>>>
> >>>> There is no policy of renaming existing files.
> >>>
> >>> There's no policy against renaming existing files either.
> >>
> >> There is, because you break all the users. All the distros, bootloaders
> >> using this DTS, people's scripts.
> > 
> > Renames happen every now and then, when new variants are added or
> > discovered (-oled/lcd, -rev-xyz etc.) and they break things as well.
> 
> There is a reason to add new variant. Also it does not break existing
> users, so not a good example.

Sometimes this also causes a rename, so yes, it breaks the users. It not
frequent, but it's not something unseen.

> 
> > Same way as (non-uapi) headers move around and break compilation for
> > external projects as well.
> 
> Maybe they should not...
> 
> > 
> >>
> >>>
> >>>> It's ridicilous. Just
> >>>> because you introduced a new naming model for NEW SOC, does not mean you
> >>>> now going to rename all boards which you already upstreamed.
> >>>
> >>> This is a genuine improvement, trying to untangle the mess that you
> >>> expressed vast discontent about..
> >>>
> >>> There will be new boards based on this family of SoCs submitted either
> >>> way, so I really think it makes sense to solve it once and for all,
> >>> instead of bikeshedding over it again and again each time you get a new
> >>> dt-bindings change in your inbox.
> >>>
> >>> I understand you're unhappy about patch 6, but the others are
> >>> basically code janitoring.
> >>
> >> Renaming already accepted DTS is not improvement and not untangling
> >> anything. These names were discussed (for very long time) and agreed on.
> > 
> > We did not have clearance to use the real name of the silicon back then,
> > so this wasn't an option.
> > 
> >> What is the point of spending DT maintainers time to discuss the sa8775p
> >> earlier when year later you come and start reversing things (like in
> >> patch 6).
> > 
> > It's quite obviously a huge mess.. but we have a choice between sitting on
> > it and complaining, or moving on.
> > 
> > I don't really see the need for patch 6, but I think the filename changes
> > are truly required for sanity going forward.
> > We don't want to spawn meaningless .dts files NUM_SKUS * NUM_BOARDS times.
> 
> Renaming will not change that. You will have still that amount of boards.

It's still that amount of boards, but it's much easier to follow what is
going on with those boards. You might say that I'm biased, but I think
this is much better than all previous attempts.

> 
> > 
> > So far these are basically Qualcomm-internal boards, or at the very least
> > there was zero interest shown from people that weren't contracted to work
> > on them.
> 
> They committed them to upstream for a reason. This comes with
> obligations and responsibility, especially for big vendor like Qualcomm.
> Qualcomm does not want to commit? No problem, don't upstream...
> 
> 
> Best regards,
> Krzysztof

-- 
With best wishes
Dmitry

