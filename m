Return-Path: <netdev+bounces-162075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4631A25B72
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE59B160B7F
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933402063F5;
	Mon,  3 Feb 2025 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FrQQsG/i"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136352063E2
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590734; cv=none; b=b29OBygVe7K660ywMgKfebHMpHB0g7fN+JY+bZuXOhjRIg62d/LfWiuH5LFodcves862IM9SG6UaTppfJ2omMJjWoHQ8kDmEw5/AiHCUGWqbmZnlTvmqjKAmhMh25+psRhjnFdvWuTHiwUOFsVwDW8F/mYeeVy0J39KogW2L90o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590734; c=relaxed/simple;
	bh=0DrWhNzMf72SyAS5mlgolmfKR43YKw+/djS366mUj3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rVi44e8IarZABRZrQutI10GQ4a9TEDxyL1ElLiSuC1JoNl9ffGRf9er+2U3OiYyBKxBoR7ctu+lePkO79VJBF7lbQFwJ6vDyk1uT7KcpwKGRRNokFeg7U8WtcJTz8JPkpV9m00pIBgTqn+s8bL4Fih0WbYk2wXzZNX/vVSqIk2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FrQQsG/i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5137GCi6003929
	for <netdev@vger.kernel.org>; Mon, 3 Feb 2025 13:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pkSYbDqaSwny2usVYAuISCwLWlA3g2QgJUmnqeBMSg0=; b=FrQQsG/izShyy9H9
	1UTtnmuTDFZtS8bqaCaxbx3HQPCRNeZ5KMcOAMKF+tpJWNfTyFLTuX/lDRPiqxjo
	iWjdCjXeSi12T9ZrDkHatJznA3miLC8aKRFYF5SRCe6HzRuPAu4wq6dJx+m9kT1F
	OD3ISQ8GWUFwenWUSjZTLI4mTtdbx5yXefbt0dq2qsl5PyeaYMmt1qcvC1xa1GsE
	01c29dcq0uHpPbtu1eC+cTUmuK/K2EyLkLb/uIjC3M6NUKlbFAnaw2whVDxBasOB
	m3aCPRq0pbxrKKeR6ah3xjhXe29PCzj8WIBTb6/Bdw+y6qOLsTBJ/HrSe34TfAo8
	Twgb5A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44js8ts0nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 13:52:12 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e18596ce32so9085766d6.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 05:52:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738590731; x=1739195531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pkSYbDqaSwny2usVYAuISCwLWlA3g2QgJUmnqeBMSg0=;
        b=pKnfScNQttXZC/RjTQLZ1B1OGdBB/3ZlKK6PCZJGcF8M4Xy2PTZ93t9qVwKtvHkWYc
         DkfeI+Vrezzr7wnb0lP/SMP8L529SGR8FgYskfxilkWfYlNy02eJWqMGjjju3yYNVQqr
         IJaKaYE7kK/P6gCqZXdmGlv/gm3PI55ueisq5dyJsFwQB/oQyDv5BhuIpycOJVJi2bAG
         nxCbG8cvdHGOLgMw3fus+QDHZVbq1lNX35ruwzFqb4KLY3cb4dIIOfuYlpcxo7N/iMxz
         Jcf/Gz3izItL2PU2YqW78UyePgNeD29pfkSLQir8QtCbCy412MeyOSSNK9Sh8cKkkLi5
         DTgQ==
X-Gm-Message-State: AOJu0Yx/GgukzaI2qQRE5+G8105fG4CK0nQoN8gvVAbZ3Jtngi4CE7OD
	lTUMYNFWJEnIfri2BOMNZJu7Gc1Lv6kVODRJtzNfEsrMSqRrWhjlzn44Y7OPjMH5uBM0roGNlIQ
	0esNpsblj6ZgFZmDF5xHW6m/wJQmjmWiiL4/igH6PA8I1LSp+ox0dVwE=
X-Gm-Gg: ASbGncs7ZhX/bXbXTyRlqRTUp7ACQGZUpp4ydDBWhEwqdMhJl6KnKbZuBciFG+v8Ihl
	OrY9Wy1evlgAirn+w9ty3CqxaigCN8O6bhyAhhJv7Zzs7CEZ06moVJLodXEP5ucn33aCgQoMrIO
	f8s6Zky0pI65S3DmtDfuYD54KU2Aci8X/XHPyEuN/4xZXzf92I07GlIZcmw9YeGXTj1pRCRsaIe
	GFytdYV/jmlkkwqdO0ERO59o3GQoAWFTXCS5FqYg+o/T6CIGFmFIYpm0rl2C50C2kFzS0hx84cf
	WJNN3ITCk1TSJEk2RW+0cAZ330j4tlr06QLkhfNoYM8eZRUYd0ilPHaf9IQ=
X-Received: by 2002:a05:620a:254b:b0:7b6:e9c0:9c3b with SMTP id af79cd13be357-7bffcd0a31bmr1196150585a.8.1738590730953;
        Mon, 03 Feb 2025 05:52:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHt9A1Ywm1nPEK63UqBS+e6UYwlx6nzIpdhoFy2TYlNeJUUhk8BGO1TQBd333vNW/v3P8zaqw==
X-Received: by 2002:a05:620a:254b:b0:7b6:e9c0:9c3b with SMTP id af79cd13be357-7bffcd0a31bmr1196142185a.8.1738590729156;
        Mon, 03 Feb 2025 05:52:09 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724aa0a8sm7559984a12.55.2025.02.03.05.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 05:52:08 -0800 (PST)
Message-ID: <21b4813e-b5c1-40d7-b536-3fe65a53affe@oss.qualcomm.com>
Date: Mon, 3 Feb 2025 14:52:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: qcs615-ride: Enable ethernet
 node
To: Yijie Yang <quic_yijiyang@quicinc.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20250121-dts_qcs615-v3-0-fa4496950d8a@quicinc.com>
 <20250121-dts_qcs615-v3-4-fa4496950d8a@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250121-dts_qcs615-v3-4-fa4496950d8a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vi_gcKtuqdahMeDPAt9yuE0bp2XxYhUC
X-Proofpoint-ORIG-GUID: vi_gcKtuqdahMeDPAt9yuE0bp2XxYhUC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=709 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502030102

On 21.01.2025 8:54 AM, Yijie Yang wrote:
> Enable the ethernet node, add the phy node and pinctrl for ethernet. This
> change is necessary to support ethernet functionality on this board.
> 
> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

