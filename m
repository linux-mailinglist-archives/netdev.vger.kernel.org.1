Return-Path: <netdev+bounces-137124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A499A471B
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 21:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A53D1C21D51
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C65C205E16;
	Fri, 18 Oct 2024 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iFOjLaHx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC88205AD1;
	Fri, 18 Oct 2024 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280350; cv=none; b=lMEUd7dL68Ig6c6HeXOy55bRTZhH2HrM6HW3J3wh272n3T7D/KcE2hEEc6o8M5K0TQhOIqPIr8t8tHBV//KqlvB7Ndykk8XzFifqcv0rNrZJgFxOijHFHkpmMp322b7vdbVp0sOSfce6ddF6BiXx+QXiLLC6qEbqCaN97ga0VBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280350; c=relaxed/simple;
	bh=Iwyg+25TIYtgfAEaV6q2T6HEhw+qHxjWTb1ZRIVlhOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YXR/F8cey2U4txq5xplw1BRe2uDXOgHiwzC+2bMoiZrimYmWdG/wy5+SocXJuwVVnIw8RQ2DsrzGFRMY0nQ9v3bc+au2eMQ1aeh/ZxbwI5nTElRgpOfJGVjbwfKmNHuwU63EuJ1tQh/dGmRQ4ip5xBGYAruBF27AELmdic9DzdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iFOjLaHx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IExEVk006854;
	Fri, 18 Oct 2024 19:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FuVO4fMb5MpofPajt/wbYGl7xsfzqelPI7oc0YLKb0g=; b=iFOjLaHxy1+GgJzM
	L5SnqAq1G9C2YFL9cZMePU5/d4Z7xA+CS7OHA39mGv9XGMTwbnrwqJhqzgF/0UbU
	DXMwZcYBvIQiQvp8mkw7RO3sX+o0cT6q/ENWov9XHznSheAomaVAINFIjff+1t5n
	KkmEJiQP5l/gCv2sdrUSPg6CKBLfbw7AOsyYccvzL4nH56/WAUCwQl23Rj5GWCBA
	kNELMuepvYIr6UFtpm/QwgCmSEXIlvnzZ+PdWnb/tbYupRgHFLyaTtEYh513vtzA
	d2CoUzVc3uEEyXZ6UA8nQcimS2mOaX0TkwmUtT+LICJEbIUjf9GQ0nIAGpubyiO4
	TtxM7A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42b5hsvb4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 19:38:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49IJchRS025521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 19:38:43 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 18 Oct
 2024 12:38:41 -0700
Message-ID: <b1b4f049-66e8-5077-c40d-e76a9a73944f@quicinc.com>
Date: Fri, 18 Oct 2024 13:38:41 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH net-next 3/3] accel/qaic: Pass string literal as format
 argument of alloc_workqueue()
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>
CC: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jiawen Wu
	<jiawenwu@trustnetic.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        "Nathan
 Chancellor" <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Carl Vanderlip" <quic_carlv@quicinc.com>,
        Oded Gabbay <ogabbay@kernel.org>, <UNGLinuxDriver@microchip.com>,
        <netdev@vger.kernel.org>, <llvm@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <20241011-string-thing-v1-0-acc506568033@kernel.org>
 <20241011-string-thing-v1-3-acc506568033@kernel.org>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241011-string-thing-v1-3-acc506568033@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kB3xAD1z7POfq5DS0_Xvxp7aKJljz9Rv
X-Proofpoint-ORIG-GUID: kB3xAD1z7POfq5DS0_Xvxp7aKJljz9Rv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180125

On 10/11/2024 3:57 AM, Simon Horman wrote:
> Recently I noticed that both gcc-14 and clang-18 report that passing
> a non-string literal as the format argument of alloc_workqueue()
> is potentially insecure.
> 
> E.g. clang-18 says:
> 
> .../qaic_drv.c:61:23: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
>     61 |         wq = alloc_workqueue(fmt, WQ_UNBOUND, 0);
>        |                              ^~~
> .../qaic_drv.c:61:23: note: treat the string as an argument to avoid this
>     61 |         wq = alloc_workqueue(fmt, WQ_UNBOUND, 0);
>        |                              ^
>        |                              "%s",
> 
> It is always the case where the contents of fmt is safe to pass as the
> format argument. That is, in my understanding, it never contains any
> format escape sequences.
> 
> But, it seems better to be safe than sorry. And, as a bonus, compiler
> output becomes less verbose by addressing this issue as suggested by
> clang-18.
> 
> Also, change the name of the parameter of qaicm_wq_init from
> fmt to name to better reflect it's purpose.
> 
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

