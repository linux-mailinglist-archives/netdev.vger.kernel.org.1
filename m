Return-Path: <netdev+bounces-149695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 341409E6DEB
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE142822C5
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988891FF7B4;
	Fri,  6 Dec 2024 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SlRJ2MvL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270BD1FCD02
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487467; cv=none; b=EKv80fL6X6icud3EInq/dRmAS32KV6kfOVYhu1iW1aGMa36ilmUO/qph/+v+QY9GK0+Qm067H/4TsIF7FyCoseYavusrCZ9MGFVSZcxCHo2+B9oCXLkeydBa1WOXTeyFYyE9UT8plztSm0LRgiIjm3cbO023C3j3heelrtmrn6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487467; c=relaxed/simple;
	bh=5wkWfO+hWZHxAXWoCicEQ/+F+PuZSVuy3eYlYUHtBzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOxzTwHvxewXJzeqvKfNM0CG4N344mfhC9Syd3ZnG5Ng38BS7fBBIvZeS6va/WSS9zDznVM7q7GbFUrlmga/6Kz54Hc5tEuydfVrbdeq4NW7qPNKhzq6mEu/ksvOmVrwElBzIcpZNJIcD3N6EyrVw0iqC2gbcQJdzJu+3Ut8i3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SlRJ2MvL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6C7HvL004109
	for <netdev@vger.kernel.org>; Fri, 6 Dec 2024 12:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kIc1Z7YLPTzeUFAcgBGUiX8WBgeyaJlURl7cKhkV0Mk=; b=SlRJ2MvL4q1Ukucx
	79NnJZPYf3AwwiUZtxBtsKv4R79lDrO+981RLsN0/EeDxchjMAkki99q/m9NUTKu
	7DkGHBiWamEjP7g9rGGQTZi0nawZ6Ysyih5WQYRC6YBZoxiHvxiYQyYiL87O9l09
	WzQFlZ125EctI7FuHeLfqT8kuQ668ubQ2oM49CKXnCJxO6SHMWMnLUVRgjsYjW35
	GfjtxMBWXzRtcSl1Ee3PvDy1boJ56zwwwwOv3RXPfXREieE9BhJbDx6KdTHPzi0f
	caHK9N/ZpCSLgwnfj0tsCFUba8Sk8wXLsbOKlDQdLKwqRBGYatXxQMt2/VlrAlwG
	qngQuQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43brgp1g6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 12:17:45 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b67c9624d1so7682585a.3
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 04:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733487464; x=1734092264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIc1Z7YLPTzeUFAcgBGUiX8WBgeyaJlURl7cKhkV0Mk=;
        b=i3MhyrECzzHsgRR9bpqTvbT8OZnrCX3Vsat+rHaLReEuMaCVtFx2Z0dh0MhF34BLKS
         t+QXOtXUOhpPyYljAdIjjinOLznCTBsJcdom1BEKWPE7u6H/XFgPj/AR3FT5dXkVOpsG
         kPHdhqeDUOdDDXVy0pg+UcSkMMf0v1E8zdelFFd1+tuDu0bbRLMijCVd6APVxgXJux9L
         cRJN37U75qxoNlimH7z5rn2uoIxRBD2MDfjoP1+xllSb3m1znbousqlbNa1c/pa5tg9j
         QxVj2uTHUC79TZaYbFX72T7MAfCnyYR4a+/FVTaZFx4ud6KS3r/fD3WTh+pnkWY1U95r
         fLCw==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZKEDqxRbh8G0smKlSCEypH9ihzXvKARvc5XJv8JCv0fz3O0MJiIb93WNNip/FvfbIokf6t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKLEydx3qeMuetjCkb7Fy9cFVpVusvWadEVDwSHcRXdLOlv3mb
	wXHvl9N4IxVn2h6yQUzkulzq0ptVMxrtta52WEYQQH84o2gdUqngFjWBzfhmDDh/yK8aQvcH3Jx
	KmNwG47GRS9jQQNdWrIrFpwUzdNuhUYcpcBSveusrm3FBVeMmcNH7kUE=
X-Gm-Gg: ASbGncs8Wq0oMGpBg2cnDNb1DI7pXu68Onk9/Ivu5PLzITQVvZ5YRmG7X7DvXjn5VpB
	xsw9RL0cm65mCLoXg3FDz3tO6Yzdw0DVQT/Zw3L9/IeS3YWCYK++/3XaUgQgJ0RhaurGVCMheT/
	QJyIJg2ntq8sCSkIY+44HXxTnHZRe73IpbLdPEc3lpSUGrpsq2gtlCmqx7VcLa19YfBXQ22M2bg
	iyfd90aRxSjptbVY6FYj/lXFxq0EMb3MyoTfP8BDPA8HzF5xWDzA7aPAoP7wIYR6xKLm0YDkMGf
	4T4FjTwx3KxW5a8LQfmKe+ctp9Wrucs=
X-Received: by 2002:a05:620a:190d:b0:7b1:1313:cf42 with SMTP id af79cd13be357-7b6bcb5c27cmr209648285a.14.1733487464057;
        Fri, 06 Dec 2024 04:17:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfEbyz/to2eX0ORRsVQ69uE30/rqBFU89xE7K3MXKBCOC+9NJDlOjylc2i3dLlYap3aPAV7Q==
X-Received: by 2002:a05:620a:190d:b0:7b1:1313:cf42 with SMTP id af79cd13be357-7b6bcb5c27cmr209647185a.14.1733487463721;
        Fri, 06 Dec 2024 04:17:43 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e96b0csm231761666b.58.2024.12.06.04.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 04:17:43 -0800 (PST)
Message-ID: <da297f8a-a925-4ae0-9cd0-c4b7f8556c49@oss.qualcomm.com>
Date: Fri, 6 Dec 2024 13:17:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: qcs8300-ride: enable ethernet0
To: Yijie Yang <quic_yijiyang@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20241206-dts_qcs8300-v5-0-422e4fda292d@quicinc.com>
 <20241206-dts_qcs8300-v5-2-422e4fda292d@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241206-dts_qcs8300-v5-2-422e4fda292d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: w8HZgVLDvhARg-Jffcjwla4SWLfw0_J9
X-Proofpoint-ORIG-GUID: w8HZgVLDvhARg-Jffcjwla4SWLfw0_J9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxlogscore=726
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060092

On 6.12.2024 2:35 AM, Yijie Yang wrote:
> Enable the SerDes PHY on qcs8300-ride. Add the MDC and MDIO pin functions
> for ethernet0 on qcs8300-ride. Enable the ethernet port on qcs8300-ride.
> 
> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

