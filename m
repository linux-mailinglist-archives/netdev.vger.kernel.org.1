Return-Path: <netdev+bounces-206490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73868B03477
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 04:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EAFC3B9F97
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 02:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F4F1D9A70;
	Mon, 14 Jul 2025 02:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wz6YCxqk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DDF1D5146
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 02:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752460091; cv=none; b=epsZt3fekn5bH1NHbPl+VHR0R4OopqZI3nQPbt28hyo/fTCxQzuco+rsWOmrrtEikPOFNUANyT3BzYYLo1n+6xw/KMXeTMB2qrqeg5c++de41u20j1YMCnfaUJthW7PzASVtTSrrgFaFZ0NNJgxr1CwZHa8fF5YvVFD9qIs2nlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752460091; c=relaxed/simple;
	bh=3nJgZl9vP4SdfX+E5yML/xW+OYiWq6C5glcWeET+8VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKJINivDLnp7nEBP/j3k6PunibennbAMzYPwu4IODaoDTazHQ6VZmF8c12LkYRtce4mXz1++INjMExmtJKFaxSyM0Fhppu8JqvPmiln+67PSpgUW7KjZpXZKCgnk+T2qrePHKYSxZ9oBK+zA1OvyCvSTnpFkjh46hl/6YiXHOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wz6YCxqk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DNNxFM030447
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 02:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F8OpwaFzraWMloUlXGdAgiuapqHg/Vvr2jLfpvwdlYE=; b=Wz6YCxqkz1Ookwwo
	mwfv8M+KivyoXwwzHCHRR4PEuzJM4R/fuR1WjLum6Q7rwbARYOUeUHzA0x1wXleU
	JNESETe6FMEKAR3SoaAkf2lqHQ1FNQCUihgy2BaZ+zIsg1SoAnVqdcicUzbOZxiS
	zkCa5FP0Lrgz47fDh8KtRMuiu9AOHX1Go8/8QblPasIMYtcJob88q8z2sxlXyIyj
	BjTMhCaW+sD5E94aLdjRFdhuYh4Z+Gij4OLulq+Km+L/R8uy6PoDHdFBkRnAkBfQ
	DuwwyVrUxLriYtggCs1m1uk/lIru/aV26n0nIDIrSo+4M1SZiMTNF6smTYZ0q4G3
	QzjWNA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu82wrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 02:28:08 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b115fb801bcso4209174a12.3
        for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 19:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752460087; x=1753064887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8OpwaFzraWMloUlXGdAgiuapqHg/Vvr2jLfpvwdlYE=;
        b=trt73I+t2IEApnFftmVjb/tqDEqbFI8nOAby76L2so7Wgir1DRBfRMwaazyx6nq2Lz
         AcSX/ILSGg0CLqdAG9tg2e/JvfwMbzysUx97PVuSVBaLzCUXnnpHwhWZkTUCzuMeqonF
         FUtOEVovTR8znx7DFJELxyA4J3HTEJEW2ocZCflBueeS8F+q4EU2t/4tkayyo15MRbNi
         HstAbOrgma9UwgLkSZnsFATrkMxUHObyNjBZ0w/XtsQsuPPlSWk0XqZZ9/PkmwPew8Jw
         pQKTla8TsskX/+y4wAYUfv/g+1Kk8r8j9qfFshayGf9oiMLV9fXOVdoX1F8vcSG2fgbW
         Kvzg==
X-Gm-Message-State: AOJu0YyA0EpDtlXrFdYtQZRqyHC9I1vDxqUp2ueB1tC+9y9eI5J3P+cs
	8LkuZC7Q0k98rGwrmoq/4cJfmM6TuZtBLzoypeBFvm9htHLcYQCTCtnBGjhgu3FwviXdQGvmfd8
	ZrpYtbemvmCVdBKjamBO+mzR9bR3I/pNZceBphVojHXgBPRCAGT1aDfsfJIs=
X-Gm-Gg: ASbGncuKCA2Z646Dh+SpqTmR365E97K/+0Vka8u7Mk13c9vfkCcrYulS7xQXq4SAa7u
	mwK8FkIKZJPiOwwlEtlO3jVMPb81AH9dWAp7JjeP4sEuAvwhuK1uYabWazImLgWXtWfw7CCe0Wf
	E9SNXLrwXwxb0ckStadW4QBJcI7eXSlXjJeMyL77rCWyuin+WeBAar6d1a4YUisOvxOq5q/cBjX
	UP+mZXhi+Fr1XSlKGatbNAjkOsS9Ov1mKScUwFsFTVEAwr48Gx7t+OeCRvquu4b2x9pq5IqtLNV
	ER/pH8v3tdVI9eBB/IuQO+kw7T/JPNxsppARqj88ptLuZu05UQHDU5HLsJKsSMiK/LnHMaj1iJE
	jT7ervjE8Pce4KaKOetqPrK8274mc
X-Received: by 2002:a05:6a20:7491:b0:21f:7430:148a with SMTP id adf61e73a8af0-231201fa1f9mr17819859637.28.1752460087273;
        Sun, 13 Jul 2025 19:28:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERlTzQAbGBtic0xw9HUW209GmM3H8UeFAoNwCUVrD0zAm95+xPpoXxs/SybzhJTxECUBR7vQ==
X-Received: by 2002:a05:6a20:7491:b0:21f:7430:148a with SMTP id adf61e73a8af0-231201fa1f9mr17819826637.28.1752460086833;
        Sun, 13 Jul 2025 19:28:06 -0700 (PDT)
Received: from [10.133.33.227] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd598csm10053918b3a.17.2025.07.13.19.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 19:28:06 -0700 (PDT)
Message-ID: <465b60e7-fe68-407c-add4-856178f4cb7c@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 10:28:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Enable ethernet on qcs615
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
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <20250121-dts_qcs615-v3-0-fa4496950d8a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAxMSBTYWx0ZWRfX74N9EOvD5JPY
 4qZ6d5aHmOudlhKEZK62aLcYgnqAtbXhppSgbsYbHBAixprHT43sHekkw97Y1VMN+kUjLGYDHoJ
 OSBkchtzBZ7GbWCjjrZp4dXFIxQoCDgYuC/8abERzD8+WginPo0hmipcxeFLvU8Y55IJqnm/Iwv
 4o2S9VRs+t+R2AuhcE4m8lnYAO4EvSG7jXyBfLavbdqlQebvg3fzKSKpz0wrf18yWx73EQfsgfn
 Vo5F9Vf1hrUmmNkpudoluFpbuVxdpzKUekVvFcOBR9ah++a5LHs/O08f3rXI132cV8mRfwFQdA5
 8+0QxgQ7L072c+21ZZ9zFOGrC8P26P8k43zsdQm31jFMz/L3GQn7gQ+ebCCaWUEi0wz4wqczutf
 vmOMkvyOEGisr6Smph/4GWXrxwSW5HuUK/A0DJUOKvPACi5D85KiOlCxQe+BwDZLRhhRQAHM
X-Proofpoint-ORIG-GUID: doZdrRNuASN9abSQvZUDddA_skOvALIR
X-Proofpoint-GUID: doZdrRNuASN9abSQvZUDddA_skOvALIR
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=68746b38 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=mTSKI_wBhsZyk7PTtHgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140011



On 2025-01-21 15:54, Yijie Yang wrote:
> Correct the definition and usage of phy-mode in both the DT binding and
> driver code.
> Add dts nodes and EMAC driver data to enable ethernet interface on
> qcs615-ride platform.
> The EMAC version currently in use on this platform is the same as that in
> qcs404. The EPHY model is Micrel KSZ9031.
> 
> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
> ---
> Changes in v3:
> - Correct the definition of 'rgmii' in ethernet-controller.yaml.
> - Remove the redundant max-speed limit in the dts file.
> - Update the definition of 'rgmii' to prevent any further misunderstandings.
> - Update the phy-mode in the dts file from rgmii to rgmii-id.
> - Mask the PHY mode passed to the driver to allow the MAC to add the delay.
> - Update the low power mode exit interrupt from 662 to 661.
> - Update the compatible string to fallback to qcs404 since they share the same hardware.
> - Update base commit to next-20250120.
> - Link to v2: https://lore.kernel.org/r/20241118-dts_qcs615-v2-0-e62b924a3cbd@quicinc.com
> 
> ---
> Yijie Yang (4):
>        dt-bindings: net: ethernet-controller: Correct the definition of phy-mode
>        net: stmmac: dwmac-qcom-ethqos: Mask PHY mode if configured with rgmii-id
>        arm64: dts: qcom: qcs615: add ethernet node
>        arm64: dts: qcom: qcs615-ride: Enable ethernet node
> 
>   .../bindings/net/ethernet-controller.yaml          |   2 +-
>   arch/arm64/boot/dts/qcom/qcs615-ride.dts           | 104 +++++++++++++++++++++
>   arch/arm64/boot/dts/qcom/qcs615.dtsi               |  34 +++++++
>   .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |  18 +++-
>   4 files changed, 152 insertions(+), 6 deletions(-)
> ---
> base-commit: 9424d9acada6461344c71ac02f2f3fbcdd775498
> change-id: 20241224-dts_qcs615-9612efea02cb
> prerequisite-message-id: <20250120-schema_qcs615-v4-1-d9d122f89e64@quicinc.com>
> prerequisite-patch-id: b97f36116c87036abe66e061db82588eb1bbaa9a
> 
> Best regards,


Since my last submission, I’ve been working on an updated version of the 
patch that incorporates the feedback received and improves the overall 
implementation. I plan to submit the revised version shortly.

Please let me know if there are any additional concerns or changes in 
direction I should be aware of. I’d really appreciate any guidance to 
ensure the patch aligns well with the current goals of the subsystem.


-- 
Best Regards,
Yijie


