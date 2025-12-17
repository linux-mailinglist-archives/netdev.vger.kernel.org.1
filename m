Return-Path: <netdev+bounces-245228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B30A1CC945E
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 19:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 964DC30319B8
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 18:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160F629D29D;
	Wed, 17 Dec 2025 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XX0FTlGh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dnHvZqcR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526A82C21FC
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995529; cv=none; b=m3X7B2zYmKmXKc4qjpObVz8Qy7yVHNFKn8L3PNhV+os1bPTnLZpPB0x9mpdmu8Mp9orxfJWV1A8FVO/sojWY5GJRbyKJ2rCPIp2kmkBAb7YHenc/Up0i7aIW6LwJP+g1YjAS04ddpvR9OsM/rt6RYl13D9obNMn5dtl2YcW72Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995529; c=relaxed/simple;
	bh=KPCoPks2Y2/j+fWOc0DjbN2flfAgVDX5MiFdzCmlPxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Goi8jO9gpPhojCM4xXLkO2nQDrUtlBO8ZJNHx3qhWjHIzZLE2lTAMxhcwP460AuPX6OhAvQlMeBVJk+DGf5zsvUINRr4n0lE5zNc9HtrV1jEAc0vOCwMQbkYOuHcfcTheQzbDihcxjQpj02bRlHFXWicJdNhkB+vCTWPLrgaL48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XX0FTlGh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dnHvZqcR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCKrOK2683556
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 18:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wBmu9AzZ9xdbtIOjudSzxPBr2BE5g0gg/z6YBjxDbIE=; b=XX0FTlGhGcl0GgQl
	ByTU7cTPlDPk/BXambHGMBBrAFNZaJfIcs6xA6ew4ZJ9tR7UJQS+gqePcy3CuHsP
	vAotqv37mohmAfVk+eAvIYj7rZG2V0YacO0NNdP0m9w3yE0WWFoEoPEvo6maf4xs
	6DWw+J4IIVBayH2jAWjYTnjijGyHuVPMpR0JkPMA9P0/h03K2SoFh/RKObvRsWpV
	eE00BccsGUxbyFdW7MIQrXSXW3cfy70VmIAoj7vErrMdAHU142riKXQR00XrVdgA
	bnC0PryPEaCZPZzqHVwAwn49yCO1jVtKSjP0r7hhODK19mvYysQxYak3xA0We1cb
	FKeYhQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3kketx4u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 18:18:37 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-bc0de474d4eso12689720a12.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 10:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765995517; x=1766600317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBmu9AzZ9xdbtIOjudSzxPBr2BE5g0gg/z6YBjxDbIE=;
        b=dnHvZqcRtWDUre1eSfogviBxCN1JzyHdKmapu2M1qOVC3dThbDQ2E46ZVgFM8YO8co
         cnHlKpe30HIkVhPSD9wk/hsMp7B1QkWxRU19JFcDyyIEzwYb/ZIAijsxKCuCW7fxxnqf
         H9TdxfWDcUZ21KsJEqIsUeHy3o7IW9H17uzg8Zet2kh9fuOoeTaHjx7WngyiYzksfqyy
         vco0eLOEwX2L3/1Nph1uWmmQ/tK47ynkdnS9Orq8mVDCZK/eaQpSg8H5Um57U23qJsua
         uWPp/Zo9/eMIL7nV83cZ87zQ+ybvd9sjX+wf1Kh/XvKANbAXYDIRumejZZVbL7vshHdZ
         T0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765995517; x=1766600317;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBmu9AzZ9xdbtIOjudSzxPBr2BE5g0gg/z6YBjxDbIE=;
        b=SLWt5s6WS9NqgdFselipXE13iSXxMx3kE4gHluK8tphoFrW/T4pmW2QpGHVxsNm1XO
         jZPRDErbWVHpr+v8/TZG2HNvCHd/c4dX3gHiCNrf8C/AJ1Jl4LpXmSslQ+jxGz+WBHKj
         gdUQKiUMIjNaLjqHeF7bAozWg0AiqNzLdTq3sqWcZm04WPN/8Rt1qP52ipFcvsen4MxE
         wrEfrQT8inHdN9h3iNtp5XCgngR3fawOZ6bCz8yJSZEavUVMhe+IYyC0u8UWBZW2ZKuQ
         SidwW8efGVdCRgxf0fQ4uIg9jbpFknHptfPSCAGFnOnFR8cAQaeYPwoYZF3lYHDk97Bk
         QpXw==
X-Forwarded-Encrypted: i=1; AJvYcCWJqB2TQB/Sdhloz1S3VdHmfRD03KdVveRx1Z/13duK2bfy3TBEDUZWgjzEkpOO5OPsgolzgbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGqjGiEqJ+0tvJSIvYzCzG83RwN3rNs3UdkE99mD/72CvzoToV
	YB/v58xyqIRhQZQCrCOQkSHMeAU1ZKxPUKfvQFYl3+SCMgYzxMZ1vU3jWt7QawGCwa5+ANytUnI
	Hj9R6tPtbIRNBA85V1jg6Eiymnhjpp0EQUWvQu/8wyjZLKEpt1wZ5DJOYgPY=
X-Gm-Gg: AY/fxX6niqzodxTGjmFPoDP86EJOEhimfTBPufg+HbZI8Sm5podG2mCuuYdApXXjXLN
	VDpm9VVjg/6wSArpq+3IDovYvpbo5EaPvVMbY+1gEeA7k6t5XiR0qXA12yN1wB2LPb5wueBNIS0
	0dVn2kedDv4F5HdRZNx+TSgk+D0bpsAREYId01LwZx3RerWUTvHQYQkMcPwyvJfpWEw1DBQNzvs
	k534EhkHlrMqwZRG6izTb6pqLaMXdBDaBzsSsfGLs4RsQPVzjcOixg4BInYrMubfZq3bAS6PEGp
	8yIQy6bK89pdRrexxdDbwlCMMzH92l2zEMEBsuPe4C5b7zUsetX3c0gmI3R2HzOEyMj/lb2hnAR
	s4d/QZv7mIBm8ppbl8QlCBBeyQldGmDKHLmgbgpuJTr6S9XdK+Uz2j08McVZgXVkAlw1QjA==
X-Received: by 2002:a05:7301:182:b0:2a4:3592:cf83 with SMTP id 5a478bee46e88-2ac303958camr10594078eec.39.1765995517142;
        Wed, 17 Dec 2025 10:18:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6ScF6p2dbGaIAlfPTuofAf2/eZTtk6ONOKBGl/Qm27pAQp9ttnZa9kTtvsKTJrPW0AuH8SQ==
X-Received: by 2002:a05:7301:182:b0:2a4:3592:cf83 with SMTP id 5a478bee46e88-2ac303958camr10594041eec.39.1765995516561;
        Wed, 17 Dec 2025 10:18:36 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12061a93616sm517453c88.14.2025.12.17.10.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 10:18:36 -0800 (PST)
Message-ID: <5e568034-20a3-4ed5-a8e0-c010e5aa7b82@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 10:18:34 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: qrtr: Drop the MHI auto_queue feature for IPCR
 DL channels
To: manivannan.sadhasivam@oss.qualcomm.com,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Maxim Kochetkov <fido_max@inbox.ru>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, netdev@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>, Chris Lew <quic_clew@quicinc.com>,
        stable@vger.kernel.org
References: <20251217-qrtr-fix-v1-0-f6142a3ec9d8@oss.qualcomm.com>
 <20251217-qrtr-fix-v1-1-f6142a3ec9d8@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251217-qrtr-fix-v1-1-f6142a3ec9d8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE0NSBTYWx0ZWRfXxEui9aeyHQ2Q
 HNlUAFdmuw+MLVIbk9/WdZyGzLExa/RK/i+2bpNsy8Tlq9nhqXyKuPpfLks8ALDL3kjcEP43Xym
 RKU+D7Yk64nBsoXOUrQehwJeS4RT5quwUjmvnFlxQIfxxb/MBhQ7dwTRNvrnBOFzYKTOzQKlXaC
 1zoUMJeU/tsJ7fXhp0oVmUV0BzhP89XUgF6ppVmRlvzwwlrM1Jh+jFmP3XAmhpGVs+eNFI87XVq
 ecN8s6F6WRxmndE4jaxryOxzfl1RFHFOS3BNnKSJWoiBrh0Plf8nPEk+QXT6W/G0jcQu4zQQHbA
 bEhhiJIkRXzbgsYpwGIzI374Sn+Q7ug+EH0mUGyJVOuMh3B4RfXbQ4MdD+ZohWUKVrJ1eVnhKHv
 9msbL+UVioEL5NoHm3UvVkc/TUlXgQ==
X-Proofpoint-GUID: 3p7q_IEwgxxAVtkx2d-dj2elGIJuBZ1b
X-Authority-Analysis: v=2.4 cv=Fcw6BZ+6 c=1 sm=1 tr=0 ts=6942f3fd cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=isMaZ9OHK7bkWVW8W2QA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=xwnAI6pc5liRhupp6brZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 3p7q_IEwgxxAVtkx2d-dj2elGIJuBZ1b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170145

On 12/17/2025 9:16 AM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> MHI stack offers the 'auto_queue' feature, which allows the MHI stack to
> auto queue the buffers for the RX path (DL channel). Though this feature
> simplifies the client driver design, it introduces race between the client
> drivers and the MHI stack. For instance, with auto_queue, the 'dl_callback'
> for the DL channel may get called before the client driver is fully probed.
> This means, by the time the dl_callback gets called, the client driver's
> structures might not be initialized, leading to NULL ptr dereference.
> 
> Currently, the drivers have to workaround this issue by initializing the
> internal structures before calling mhi_prepare_for_transfer_autoqueue().
> But even so, there is a chance that the client driver's internal code path
> may call the MHI queue APIs before mhi_prepare_for_transfer_autoqueue() is
> called, leading to similar NULL ptr dereference. This issue has been
> reported on the Qcom X1E80100 CRD machines affecting boot.
> 
> So to properly fix all these races, drop the MHI 'auto_queue' feature
> altogether and let the client driver (QRTR) manage the RX buffers manually.
> In the QRTR driver, queue the RX buffers based on the ring length during
> probe and recycle the buffers in 'dl_callback' once they are consumed. This
> also warrants removing the setting of 'auto_queue' flag from controller
> drivers.
> 
> Currently, this 'auto_queue' feature is only enabled for IPCR DL channel.
> So only the QRTR client driver requires the modification.
> 
> Cc: stable@vger.kernel.org
> Fixes: 227fee5fc99e ("bus: mhi: core: Add an API for auto queueing buffers for DL channel")
> Fixes: 68a838b84eff ("net: qrtr: start MHI channel after endpoit creation")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/ZyTtVdkCCES0lkl4@hovoldconsulting.com
> Suggested-by: Chris Lew <quic_clew@quicinc.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Acked-by: Jeff Johnson <jjohnson@kernel.org> # drivers/net/wireless/ath/...


