Return-Path: <netdev+bounces-230212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E50BBBE55CD
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D41D84E3F87
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C342DC34D;
	Thu, 16 Oct 2025 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EQ1Ca7B5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0348D469D
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646139; cv=none; b=qvN5LuzcsPC7bSfxEoybxmjFWzX1QlCmJ47b39IjfNY2YXwYY39NxnJIcmdXqrgqk5Gcup/uPKlxOgLMJPpfn1Ynu14Ug+OSgCD0c/kWWnH6IL/ey23WyGHWkAFAmPJI1MH09sfBSfo1DnnyQIyS463iRnd0B27z4hkhxrGZq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646139; c=relaxed/simple;
	bh=/BnkzLG7iF5vjjsEuhMhpnk3gLf1GEWGWf5wGNVMGhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2o81rGJEMtEktVn4ODhqEHmO0/dh1XxZxCn8uE71LAgQ93j7xo/t6SC2WkhSp0X7mA03GAXC2vSVLeTztjvmIdc8frIQm/3Hjt78551Hqltiy/JCMPvjKdcOF143As94rpBWdqtSnQpyJEsRi06lywKHeu8nLPHp3FFxoVIxZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EQ1Ca7B5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLQNQ006612
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=t4XeRTtk1HhmwuJqivoNSUwm
	vc5y3nht6ULpzG7FoOU=; b=EQ1Ca7B5u3ErYhxM5XM/jZbhsVuk/QMCZSm4CVyc
	xvzCG8WsO7+QXMbVhlvWscHFpQepb6mr97s+9iKjaEEr+/0t/HXRNd9xEXXftf22
	tD71PbW0BQKQSzSycxYvagZ6q4t+B037vCE+8K8NL4YqIyQH3CIoPDWgd67c/ZRZ
	IGt754YNOSQsPQCLqSa/pw23WZcU0QrosaE/67i1AuFLUUz44/Jw0e50DW5TQ8eu
	v0nZJShbWqeG3lgcvLkPEXQxenDkMw90Vhe8fgx3hCKfcM8rYFLFp9YWGPSf9nxH
	iuOFoYwooRrICLVHlfLzpQ6axkIXcIyRUPvj0vSfZEDRIg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff11nqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:22:17 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c1f435bd6so20782726d6.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 13:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760646136; x=1761250936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4XeRTtk1HhmwuJqivoNSUwmvc5y3nht6ULpzG7FoOU=;
        b=adbLPFpaubetoBWVEEDByPYid6QwnXclPEDuPI+kI0rsXTN7Iyliz4eQ1xU2X0zU8h
         jc0VSy+LKFyhZaqY4oWcrpIFP4UHV1pFh9nkfMyxFInRvYBs48D1dkyq7JqNKlQqDnyY
         KOratbePgL1NaV6J1fOPndwaqXUX3ly+hqrkY5PrXjSDevR0xjLVGj2OJiqXADpP2tTR
         a2zmnE2CkuAXihi+Q6JvAoF8u8YSyXbM6HR5fbTeu2mXgGltd2oA49YiszPH1dcodvDX
         C204+WrQwvVg2yTQ9qVG54fMurjcQSjAGEGgPDuke5/gN7ivko0obVk24GcpWPuiqa7i
         h1vA==
X-Forwarded-Encrypted: i=1; AJvYcCXYZlvgKXupql7stXL3L72ZuZqlPVMaXD35vn2HBwB0dQkPoihPfApG0YOckQNocqWpSxxhkpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEyfPbve5SmYxAwQRuIT5BdYO1CzvlTQgAIjwpRCToEhHASmRM
	O5fHRDQMMzKftbGJTw3kf+/5PP/ZrweWAkaMGUzvQTaJZpKYEG0dKzAdRJUNlRfFFKs9alOxPHg
	XtkadxTEILUbhfdiL8VAVMXhgl/6ur25SawnmEprDoZld4yjF/RCT+MdLMVg=
X-Gm-Gg: ASbGnctgaGHZMuMZTYowldBSwlFTJj04hw8TNEk0Ivlr1gtrXweqiGTJOZxKOkq123G
	CBSd6A4Rm4bH614UiRmweO3e6gkizLQJy4kX7FhT9SIwmxtM2d++0ZOTZ71lWN+PVemyb56Yrjp
	bGDRpanVAWSwihsXi2y4nhOvqVkHhnptH4+mJ81fqqeuFfnGXBH5IvUo03uTjmZBKFML3WZw6Sf
	H+9I6biSW3klP6bbzDhYMqF4x5WmCYySK5JMRcZzNbJUOjqNiHlPkdBbbsRZ1iVFcno9vT0fxMr
	EShZ0EpViDOLJ+ySgnll6Zi0tRoepMI5js9Z7pSfaaEEy0frm+kIvIxHzzCObzLIXeIY4xQa5CJ
	+NT+uSurXGiXQklInihISiQmdu0Q9lUIKr0HpkfvO/evj473x8dW6lMx9giCXKASMd0wfcwYH3y
	mVTKT0UL1WIxY=
X-Received: by 2002:a05:622a:1101:b0:4e8:9601:37f5 with SMTP id d75a77b69052e-4e89d05bcd6mr20995671cf.0.1760646136041;
        Thu, 16 Oct 2025 13:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrcAdKJUHa7P+g75kVAeMcu1GBVw0vLJXNi7Bmcd+TwVbNriITJu0bKiz1xjIXDkX2pPHaqg==
X-Received: by 2002:a05:622a:1101:b0:4e8:9601:37f5 with SMTP id d75a77b69052e-4e89d05bcd6mr20995271cf.0.1760646135519;
        Thu, 16 Oct 2025 13:22:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881f9148sm7376487e87.44.2025.10.16.13.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:22:13 -0700 (PDT)
Date: Thu, 16 Oct 2025 23:22:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
        quic_pavir@quicinc.com, quic_suruchia@quicinc.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v7 04/10] clk: qcom: gcc-ipq5424: Enable NSS NoC clocks
 to use icc-clk
Message-ID: <yegaz22k6jpn657tyuiavbchgc2unaoqgvsjn54dzdhnb6rr4s@twg5yrmxx7ot>
References: <20251014-qcom_ipq5424_nsscc-v7-0-081f4956be02@quicinc.com>
 <20251014-qcom_ipq5424_nsscc-v7-4-081f4956be02@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-qcom_ipq5424_nsscc-v7-4-081f4956be02@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX/ugLCwrck5wi
 4jDR3DNjGWY60dE83geuwZupb4yaxH2/vEf04oPczefnGzm8XClRXeNA/KJBkoPieDPAj7pfsuS
 Ry025IjLNZEeKASLONg+vZzHAzqRyhoompuPzYCprDQkDe4r4oEP6gTiBoQbCRnNkgKac1Jx6pP
 tbG3cqGJNNkoFKXwLSwcxV2aXBGID24d81ALB76NBx/gHlaBcOfeKql6MmNvoxK04wWXz86Kw6C
 16brIA1qrUZVbI4W9VDx5prX0rCkYLur4n8MeKfmXD28L3JlbYSBRmRzkmnB02y/SRr6RjWwB4y
 ryUgXmpYIqqhdJJyDnlCw0Axj9KAIlG3qRat1omOA==
X-Proofpoint-GUID: oSaNLuIfmrZCuO0SHid48QJLoKyCm0A6
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68f153f9 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=DdE-_dUAR9VioeaCo_UA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: oSaNLuIfmrZCuO0SHid48QJLoKyCm0A6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Tue, Oct 14, 2025 at 10:35:29PM +0800, Luo Jie wrote:
> Add NSS NoC clocks using the icc-clk framework to create interconnect
> paths. The network subsystem (NSS) can be connected to these NoCs.
> 
> Additionally, add the LPASS CNOC and SNOC nodes to establish the complete
> interconnect path.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  drivers/clk/qcom/gcc-ipq5424.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

