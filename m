Return-Path: <netdev+bounces-201982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6531FAEBD2A
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 18:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110596413C2
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAF52E9759;
	Fri, 27 Jun 2025 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WSO9h00m"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBCA29992E
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041515; cv=none; b=IgfigjszeSII7uYE49iYZWcomZ/S04WqHqgKPU9TjGQO1/F23P+RCtIld/OYMfAMHnzgdE1Hnm6HfW7hw9xo835Agow1mtKI6rdHvPanlXlU8W6uUBxNcLoLePSd8iTDWP/y05rbivCTBrj/RYZXsyMB+LfUNKdXtp7YiDsEvZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041515; c=relaxed/simple;
	bh=C4i+82VCqawXzba10UfgLVMnLpSjEvh/T1+KBY4EWZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJqibkPl5z++5V5Kocxu5dvX0Aio21DBZUexCWz51IUDARAIqZbLsA1M0Yw6BQMOL0HyYc7+ujIM+CIBdgRN5BvUv00q6Dcj4l64cLEMkAm6V2F5Pq+9NATGBrbexHiDPONExldNyu0VHrYBNvgv7LXX5qnbytHZsHZoE/v4Nk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WSO9h00m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RCdugN009923
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 16:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3K3ulOM8/2gxiv3n1FZOLEDC6VhxDRLLFSUlDuxiVZ0=; b=WSO9h00muASik1PG
	hgjJUhe/Z5R9kzOcFzfY0VkTeXu//fkoP+y+ArJjBq8XqZGBmWanNftm6dETR3WK
	lwsl4p0ShctmgOsBSaRDTYA8yHarihKHhgjcEPLJCnKBirw39trtgV2nq1Kbaf51
	VekktYj86D8jrAcpKE5f+6Nj3sPc87YAR7pzC0Y0t4kQxSbpUXkOILS2WI8ocyQT
	LHWfJC2OxUlSyDUq8kNQHOWPmTMkHlfor2tCPzTO5+OOiT8kk8wFWCiQzwIP/FgX
	4kgAd7OTfUr5gXUH3kUZm2vddnj6PIVdbr/p04B8/LiMWbtl+2hlR6lpfC2Iv64L
	P45v3g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g88fh5a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 16:25:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d0979c176eso47111985a.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 09:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751041512; x=1751646312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3K3ulOM8/2gxiv3n1FZOLEDC6VhxDRLLFSUlDuxiVZ0=;
        b=NrMVUWOoRoKSoDI8g5dRcShCqQz9Uilv7DA3GBM8e8l8IP26M7XTED+r3Y5xyviEHz
         ioscqKbRu+tnijvlyY6mAfh9FkJGdzN8J3H4NTpbRaqDK/ALsssSsaQB3OiPO1b6BWlw
         0S7tQx5a1JV+5eEC+E3yOxOJSs+PiOQd4Ph52AupjK2zNOP34CXA4juZKKDXfqVVf1xY
         xnIzJBkUIkG9KcyG5vmyBk11R2mMJdMoJ88Vsg1MxT8blQhIhAVuTqplbdbsbp3HI89C
         YzOHR4EXPt3qToH1mM758E0eTA5meyIh/40oDhrtmIkogDYLm/82XtzJOUKmoaRP7I/D
         Iitw==
X-Forwarded-Encrypted: i=1; AJvYcCXin5QDtUkAV1h4dsz4zhw7v4WcSvxHlCgsHLvbwoPkVqZ0A04VNwkbn1GRHc4E3UeTAXLJmLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWO0uR0CBHusVJH0kcWJzkc0eh6inao+Z6y/rKI0E8ovzypPr3
	++zCo8QIJzOPh3v4LU1VVS0FKOtVaf2aqaf8MprP1LTvNf50KIpZM/fOQaedPCVgeCdAbpauSlY
	b8/6ENhcjaM3Yeo5aKQKx6XtlS80Sm0IPzwMwoB51nmTM8z8e01Qo3CDIfDk+mwxu0Cw=
X-Gm-Gg: ASbGncvxFr9F5KxdYojmZHqS+ScuZ4gXaXS6XaLmINvD+R9VuM3Z7Gx0wpON9632W7T
	v+SK2uliUTVuIJfxI52DnewOLsrkC/XHQEhMFCPYOtjsnHZhgTMEA/XV9LU21/QiJbx53izAlkW
	xb3b5BOTGO10fSV91yk/J0Fy0V9edWr3IgmsDndR9VfgvwIr4VLn79uzaQxMDzw2eYMjmc0Dcvj
	VBlauhMXjQYJStbIiSOxZqfyv7uW5aBUyCW4CB87zDsaqMkmxqdpc2NTZDvQ9BrxmJPVsA3cjUD
	PiwJ4iDHk9I1xs1aIJyxPP368sXmE2JZeScUXWwwESgzPfOnAGhFD9bMEhq+AlFXT71UlZiBXTF
	QMiw=
X-Received: by 2002:a05:620a:24cf:b0:7c0:b106:94ba with SMTP id af79cd13be357-7d44393cb0emr186174285a.7.1751041512200;
        Fri, 27 Jun 2025 09:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF07xy/DeRmmmedPMJULYDxGN/26ma8lCZYySazHvEfgzdLyxgZdrRzYmMNDCeah7SlE5mBqA==
X-Received: by 2002:a05:620a:24cf:b0:7c0:b106:94ba with SMTP id af79cd13be357-7d44393cb0emr186170585a.7.1751041511671;
        Fri, 27 Jun 2025 09:25:11 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bdafsm148417266b.143.2025.06.27.09.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 09:25:11 -0700 (PDT)
Message-ID: <cee7bd5b-2c7e-4abc-8810-4c650207b4e7@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 18:25:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] clk: qcom: Add NSS clock controller driver for
 IPQ5424
To: Luo Jie <quic_luoj@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
        quic_suruchia@quicinc.com, quic_pavir@quicinc.com
References: <20250627-qcom_ipq5424_nsscc-v2-0-8d392f65102a@quicinc.com>
 <20250627-qcom_ipq5424_nsscc-v2-6-8d392f65102a@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250627-qcom_ipq5424_nsscc-v2-6-8d392f65102a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEzMyBTYWx0ZWRfX4HIraadcLlSM
 JgeIZQ4eKCcsCwpSKBemE3WF1jl5/iBNJqQTb6nnI8IsXWtfZlb/24Niw1L9MsJpOG2NMudVHZp
 89FoMuUZWODwJJqU80oKczysMhN8Z2UEm/tmb3kzRHeAvEZLKsHFxM5Uie2qFe24/JxKbPUcc8f
 6xzVRVHXd1MnQ5Igyb+97nycnHE4LX7erb1mK9lGfpOt8Zicn+QN2Bagne+QcUcZMTt0dtlf8Rh
 td851pwpUaL1LLqUBLH3qMaapWdKK+AGBIRNLHrm1ZrY21HYD++zIDSeBWXsEvwcXpmGdHj6cfT
 4iC1PUThODrlZvwDXnAunBB6LN6WKZdmRbtfNl+vBmwXQfijbmNMtbAEYxuZmBFW9JIpn8BHmo8
 99X55aWfvfmpeommCwFdDWB6Co+yvRJgki1hFEFaPNDS1GEDlCrAmOe2AeTCOZxHW3jSJwys
X-Proofpoint-ORIG-GUID: G2y7qT85EX7zHmd7jVEmF65xcKYSp6mu
X-Proofpoint-GUID: G2y7qT85EX7zHmd7jVEmF65xcKYSp6mu
X-Authority-Analysis: v=2.4 cv=LNNmQIW9 c=1 sm=1 tr=0 ts=685ec5e9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=bcbUkqnWQ8Yi_cfyv-MA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=693
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270133

On 6/27/25 2:09 PM, Luo Jie wrote:
> NSS (Network Subsystem) clock controller provides the clocks and resets
> to the networking hardware blocks of the IPQ5424 SoC.
> 
> The icc-clk framework is used to enable NoC related clocks to create
> paths so that the networking blocks can connect to these NoCs.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

