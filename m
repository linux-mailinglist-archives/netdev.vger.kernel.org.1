Return-Path: <netdev+bounces-219557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97F5B41EF3
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FAF45E0CF1
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E1A2FD7AA;
	Wed,  3 Sep 2025 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ktaQ4/hw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1512E2820A5
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902558; cv=none; b=ChXe4/q0VBl7w1OaZLrG6/uc9zBmmmLWF49kjLmpmj2CsjXMXBWKaDgwwsGHHwkGFl8yrfPksDWK+2IYjoqvH3dv0pSBl03Sr6USyIyncuGyoDFuZDkFU40X7qAO+ZlZ59v+IM8u6dvAK8Ek2BKm9P/XWC34yJNt/AvGefG0EBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902558; c=relaxed/simple;
	bh=A9dV9MzzRS7f7sUmnjGGXBEY4rJvJ9sPSX+m6Kb3Hy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAHFVAExkKYlWQoiMXtn6IP+h+gLDMh2ep+ivBFaw0CHZjoLh5GWA+9bJ/WpMQBfpIgN8iukgNVKLrt8LHgIzbWVa/mCcajKitX52693lF3ubVRdd2IFoJWV/Sh0X3qjpiJ3COpSK7RYOzpx+fh6bkStOhGQstdHgrOfBldeWB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ktaQ4/hw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEvDN001981
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 12:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iJkiE1eASptH+38OuzSM8e8j/YvwckD1P++seiOH/6E=; b=ktaQ4/hw0RXqJQcW
	orKU/NIKtA4oz1uuQ/u9nH7pzROaaeOEWbG+RGzd+5H73sRS7NP9Gqn3I2n8OYnl
	Kb5bq7DQgsB8nihYtM2dfpuRxu1f4O2hcjzBqWkMKin+h6LjZgQQghKP7CuMY3jo
	RUr/HTRWT9TRs2Wu8Jbxl0Oz8ZDiPtFV2nhUEMSYDbgsJMP81Ob4MvNqRWfR63Uu
	CGkyhNi02mDwa12V/cCT93voqHAzt6Asi6Lu3Ss/fwfn3d2b/I/Vyk9rAi8ytaGS
	GWCHOpOnrW4jPCWboawHPqL7rrnxUlIUgRPd4+spMEk7JxFBxAgKPVeheE+2flm+
	zVPlEg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw03nx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 12:29:16 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b48f648249so2810691cf.3
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 05:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756902555; x=1757507355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJkiE1eASptH+38OuzSM8e8j/YvwckD1P++seiOH/6E=;
        b=Y1yCBFvHOh+AxI2o7wAX0HHyvOdfoUSvEFHlQZ1x6DuQmKicZmq5sDFaxmJBhO4HLv
         ELKXFo0nlAQv91C33E0DAqEh27ZRP30rIIHjoK/Kzp0IGS6slldCIsQyn9yTI5IDvKRg
         jETEsXWdGYM5DUvUusH4PjIfJFwpz1KhgPRtla/8deZzFL71p3apRYIaCxbG4MugzVmt
         ZPULpQbtZt9bwawmLl1t46CKkjg3QAjY0Bj37YGEVyOMg7Wo8zrZmwyzwfvxuHh5Upz9
         KTS3nGVXwbbBWpmht01qQtJjq8Um5BsvDqoxLwUzCLWHI/ajo5cM7RkNwQBktGd9MnDP
         i6Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXEESQA1K72ZAQIpZGBOgqj4ssHVcwC16AlQu1C2KNn7MvrZb+CsUMUAq5MZP4n/7to2Pb4CPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUtg6zYLOiSdi+rqTjQ55G7qjg1gRjXE5/g+/LCEpaao+rQJlp
	S4FPWlWsEc/HdIps3PrhQOAHQCASqIiJmCqkLCgKXG+seSQxt2+1BWyyrDN++JqlW05pgEiW80s
	rFagSewYT3+aACZuOw2XhkEp3rZvBFynEyPfJmzl0kTPBigAdWFRYPRd3mJM=
X-Gm-Gg: ASbGncu1kPdqfB6SQ28/o46Z6eZneS7tVaFR2EvV/ApfMyEMK2E43rMA2McK3223zNM
	qaiPpoTaZPoPU0cvjBx78TFEmSj4tjaKjBH/sViV0i2zaUj57aCMDSCCdFdoGe2zCjevGT/sXmk
	3uQxCluhA+1s9aqM1cTnwLIgPbYhykmTBKO1KbA9ufVv9/MYfT9aFvuM8XfOzN2CrC6YlHGhi4t
	YHs46C8dX826sCRlz0tfNEEG8ZMuyjE/SqIk/mPubN1znkHB1FH+FiuiuLSzwPGTM65pkVEWmAk
	RKr3OOYPBn4e9FwbdsJhNFb64ghgexgS8FKSuOs7JOqruPg8qdt4bflwDiWE9sS4nPudy+W+i2U
	ar070VSX6oNL1KaIWfAy/sQ==
X-Received: by 2002:ac8:5d87:0:b0:4ab:5c58:bb25 with SMTP id d75a77b69052e-4b313dd02a0mr130173991cf.1.1756902555224;
        Wed, 03 Sep 2025 05:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ1Zwf24euReXChwxJjl+rksidozMJsPEhiBEXPVc2h9t0ygR1jUfMZwAeRpN+DG+rD3vmEw==
X-Received: by 2002:ac8:5d87:0:b0:4ab:5c58:bb25 with SMTP id d75a77b69052e-4b313dd02a0mr130173701cf.1.1756902554729;
        Wed, 03 Sep 2025 05:29:14 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046cd5c274sm117531466b.98.2025.09.03.05.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 05:29:14 -0700 (PDT)
Message-ID: <39c258b4-cd1f-4fc7-a871-7d2298389bf8@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 14:29:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] arm64: dts: qcom: lemans-evk: Add nvmem-layout
 for EEPROM
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Monish Chunara <quic_mchunara@quicinc.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-4-bfa381bf8ba2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-4-bfa381bf8ba2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JTkz9-KPkJtzstgBurklXCNHbBfNmrnH
X-Proofpoint-ORIG-GUID: JTkz9-KPkJtzstgBurklXCNHbBfNmrnH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX2RkhqDvi4RkE
 bb9a+LqJvFA8E4h1iSR+y2h3N/sDB+mpoKNFr584Z7nhAmpiLeaNMEJnAuAjGv1sT3VV9+tch+K
 jWk49KJWQ29+5sUN5Eiztw/ipcdx6wMPqq3m+6mr/PxX7WIPldpFFxL0L7a9S4mY0S766WDXjib
 sJoYPhiVzg3lTaOBd3c2GuXfsvlURzRrPaqi8g3U1Q7OUMEmrwBt1zjFnR6xQwbfqclsMM35RGS
 lUCTKcw08lrMyYQLsE3KsPhHLgt9KFXm/JR5+gGnYQ2FoGYEduSpEygsd0zWUlZo6pCJ6Pv0K+f
 OxyXGYoPSL0iN/HBq6PKHeFsCPGNFWUM5eE1w3Xr7coHuHXR4MYTmZK8BA309e+M4Rbq6i6tEIv
 /WnV7UdZ
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b8349c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=UjL6BNg2kQWBM-km_-QA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On 9/3/25 1:47 PM, Wasim Nazir wrote:
> From: Monish Chunara <quic_mchunara@quicinc.com>
> 
> Define the nvmem layout on the EEPROM connected via I2C to enable
> structured storage and access to board-specific configuration data,
> such as MAC addresses for Ethernet.

The commit subject should emphasize the introduction of the EEPROM
itself, with the layout being a minor detail, yet the description of
its use which you provided is important and welcome

Konrad

