Return-Path: <netdev+bounces-275231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLV8DmA10Gnm4gYAu9opvQ
	(envelope-from <netdev+bounces-275231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:47:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 38895398891
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 446733004D3A
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 21:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C022D592F;
	Fri,  3 Apr 2026 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IW5W80Mg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PvAfl5CO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A12505B2
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775252825; cv=none; b=eYKoERplR6z+ie+kYjimyeOj+F7BJ2cV+vMCVhCB5Dvlfk9rjRHlzO3QTiKmlrN4K/zRhoaJxZnJx8HhZmFv0J4T3TGcRHJzHeaU1zUqFw56kAuJ50FjBOeliDtR4lZndzAiLBxce8AwiQ6iHKxbtc/+4pRz21iKTnPNNm0Ij1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775252825; c=relaxed/simple;
	bh=I5ist+EvO2mxP0rGH61vvoYKEdW2l3eY87onfBP+vsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQvuIT4Qt9qv7KjjuifTUT1TddzGC++WMKkoJNszwmMo3twG7rYr7itc/N2Qw9UCJaheDTQE260Pheww1up+SxlE4LdptxFvSZjNtF2avB+abMrp6uzoMfY41O7MisY7gq7wxCKaS8FU+NBoaFjBsaLU+RkeiDLx8mEc0KU40dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IW5W80Mg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PvAfl5CO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633Kvxwg3803708
	for <netdev@vger.kernel.org>; Fri, 3 Apr 2026 21:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oRO36lu8/Mjs8ncmcB1jMrb0
	3PSx4SM4zMiBDXsvdj4=; b=IW5W80Mgcmews0sCJM32E2lQahlihqrIBGR2s+Yc
	jChNL/iiB9zg9y9qf/70PKUCQc3xcY18V0RTy2YdOoG1PhaT1/eKmMSOa6HhUnlK
	1BS0eL2tkrgm8MC6tBQs668o56VHuVHXYmEKUN9KsCq2cJwZdFI6xXvBn6vVQ1cW
	BHV/tzyFeIE0HAHDBhbbXzgR05hL7Y0N1MxJoWtLpC7Mulw3BXtxbJ7wgDp+SYZp
	Uzk3rAyCoUMIQ6zKU2Fkej6AkvbAL1/UWk8BoRrNYr5ysPSjNiIWIJEl+qcGOLn2
	e+4OIpsXL+SwFmHw/WYe3N4kqhNuC/NdT0tHiQGTibX0ng==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dac9f9px4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 21:47:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5093025ffecso41396661cf.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 14:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775252822; x=1775857622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oRO36lu8/Mjs8ncmcB1jMrb03PSx4SM4zMiBDXsvdj4=;
        b=PvAfl5COi0WbrykjXFxMo+suchfzO6ryGsurK/pNXbXZeljmOa1Jghh4ypDN+ovkKx
         q+uCsCCkY6j5XdrL9BI5Jv+oxt/xOF59V3GkgSbGRQc4U9hpHWC+/5VHRaRqh6k7suWE
         UFQgEaZGMmT7rTrIHiL1ervcyv8mVnnMzTElWmGEPr4aCf86ZCVfM2cE1M2iFDr3VDko
         g55vXO/h3aGxx/J94iiM7/twWcNNGmrd+2/CEp60csfwbtoXYmXzoOKY+SllubGAOgNb
         wCNNEBhgFz0cZspmi65JWN1IzErYPzumtnwjjHeSRitM/thkpw8RSDSI60c2vdRhUIFF
         SioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775252822; x=1775857622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRO36lu8/Mjs8ncmcB1jMrb03PSx4SM4zMiBDXsvdj4=;
        b=n2q9ghiva46Eu5strrayNzPlL00001qRwkn7jzgBuaipArURnI7SB0pDX+sOn08QuT
         hVE6431wxPFituPnAs1ZSQxQHp+bDbvEmZXHJpF1EeGZHor7YFmMquYxSPj8GEVjDQwa
         B1dEZmsIBYQ929UptlHxT9owJYGILbE7Xzvn2t+RSujht92z+6mXGn++o5pOptuLUAwN
         aQ9lPh6DzQFmEPgnBIUhbDn/v8zVYWMmL2iBWFF5qzCTfdmg564VcfMLcL1QZBToDbc6
         BgHBViVsGxeTerYOxwfH7R64Re156k7vQpphkqzXU27qkt7mSp9fBrP5B7yb7ZT+Lu4i
         CFLg==
X-Forwarded-Encrypted: i=1; AJvYcCXAD1Wre91mIZ9X4w7UOJTH7HNz/ZYKeq/PIshYpV92LB+drWDn7vGF02i+nufF1DW3bPmd2ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hPdW/G/khl5jxNQzE8ttpH2pwis2U7bNPzI4NL+61ucLlByN
	ho0zN7rPdRdP2hgbFYDzasDibbFMANsvLorSja3qwe2SMANaG/qVXAcQZYGvqQl+Yj9I+ZYqf2k
	L0GMbl+j0xhQYKbLXGgYcLiSmvW5ES20GWngoWQJgI4AkwZlAN0sM/Mo3Eq4=
X-Gm-Gg: ATEYQzzt7zvovx/bs7jjwcng2lxnbLUW6Vw5aO4LiblUnPDYx9G1x59rRR+KJO7BtGd
	kPD2CwnIYXLAmyVW+od6dNbARJIHfGTN5AV02O8F7AskgWnt/YIgdHQlltOPRVzeZniNS3pE55O
	wncZqIz1O+535H/QCoPf7EVCWHDXcXVyfwW6n1WlLFE3FXqpx0xVoe/DFle8WHAVjtw3coDPQKp
	8sm4gU6fdmyyhJo4xLTXITGzJrrpAekh47ZAl/0at7naee26WTkCjLJicG+SbRdyE4G1pEmZWGx
	fdh3glAYyL+dpKV3yfr9HUEhdE+2RPMXJZUzGdwehkMEb0z2xLEEAYsFhpqHwurnJFWU1rmr/0e
	s0Ykoos3AF9UgKsBcJZlSXv4Nr1mnuBtxjAWCfLbTCkBbR/lF923mNyTbV6gIdO/iIT5bxmWd6/
	ASstREneowgtZEP7Ip4A7O/JuzN/CYlWdDChM=
X-Received: by 2002:a05:622a:6695:b0:50b:2763:2bc7 with SMTP id d75a77b69052e-50d62a8f465mr45207551cf.31.1775252822594;
        Fri, 03 Apr 2026 14:47:02 -0700 (PDT)
X-Received: by 2002:a05:622a:6695:b0:50b:2763:2bc7 with SMTP id d75a77b69052e-50d62a8f465mr45207241cf.31.1775252822119;
        Fri, 03 Apr 2026 14:47:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6cccbecsm1672808e87.62.2026.04.03.14.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 14:46:59 -0700 (PDT)
Date: Sat, 4 Apr 2026 00:46:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 6/7] clk: qcom: gcc: Add multiple global clock controller
 driver for Nord SoC
Message-ID: <qnlojbjjo3agzoscf5edwglxe2oto3gnnaj7c24itd7dn664pn@uryse2ulsvsz>
References: <20260403-nord-clks-v1-0-018af14979fd@oss.qualcomm.com>
 <20260403-nord-clks-v1-6-018af14979fd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-nord-clks-v1-6-018af14979fd@oss.qualcomm.com>
X-Proofpoint-GUID: uJliGgf6D25Fue_mmvY5Es1f5RBrmCkJ
X-Proofpoint-ORIG-GUID: uJliGgf6D25Fue_mmvY5Es1f5RBrmCkJ
X-Authority-Analysis: v=2.4 cv=BO++bVQG c=1 sm=1 tr=0 ts=69d03557 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=UazbwbvKEZ1Oz8zh9_IA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE5NSBTYWx0ZWRfX/nngLucqxRnR
 kqyrCBH9BVomCvu3EPqyErzVEKj30ZGWrjNBHQJn5jM+7PnEUzkHci19vk+Z7uKjHJbOeWNY/xg
 AOHhJKhUu7O4ubkLJSOs1MmjSwomu2XG+0a9y3g9+XCzO7Fn3FAWfxJvM/upJfnI5SbuSMj19X8
 yOKmlKlXcBW0VJlEClavT2TamnfcPZthlveOmeri99jrN7xZZD8oWvVGHT1EL6WsTbe/3nG9ObN
 HhDBwLRM1mH2x4PMvSSmVBpZz3iXqcdJzwBna6mvnrOXRtHPaZH6zOnMLtizwlY0983ZE73nxHF
 Hjeygct255cqSddnoDoBNbS8m1i50TFKMDiBMFwIqFczGqOm+Y3q73ALbod1Jl95rgE4ba7yFrA
 kAWUZpDRpKkCOQxLCP67Gy4qPDxBZPUPdVuXz52RlTHgORHxrRZiAmKf1lS4ITDvsfsXmvxZjGC
 52Vx275aHB0tLVE4PsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_06,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604030195
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275231-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,oss.qualcomm.com,quicinc.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 38895398891
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 04:10:54PM +0200, Bartosz Golaszewski wrote:
> From: Taniya Das <taniya.das@oss.qualcomm.com>
> 
> The global clock controller on the Nord SoC is partitioned into
> GCC, SE_GCC, NE_GCC, and NW_GCC. Introduce driver support for each
> of these controllers.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> [Shawn: Drop include of <linux/of.h> as the driver doesn't use any OF APIs]
> Co-developed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/Kconfig      |   10 +
>  drivers/clk/qcom/Makefile     |    1 +
>  drivers/clk/qcom/gcc-nord.c   | 1901 +++++++++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/negcc-nord.c | 1987 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/nwgcc-nord.c |  688 ++++++++++++++
>  drivers/clk/qcom/segcc-nord.c | 1609 +++++++++++++++++++++++++++++++++
>  6 files changed, 6196 insertions(+)
> 
> +
> +static const struct qcom_cc_desc se_gcc_nord_desc = {
> +	.config = &se_gcc_nord_regmap_config,
> +	.clks = se_gcc_nord_clocks,
> +	.num_clks = ARRAY_SIZE(se_gcc_nord_clocks),
> +	.resets = se_gcc_nord_resets,
> +	.num_resets = ARRAY_SIZE(se_gcc_nord_resets),
> +	.gdscs = se_gcc_nord_gdscs,
> +	.num_gdscs = ARRAY_SIZE(se_gcc_nord_gdscs),
> +	.driver_data = &se_gcc_nord_driver_data,

use_rpm = true?

(here and in other drivers)

> +};
> +
> +static const struct of_device_id se_gcc_nord_match_table[] = {
> +	{ .compatible = "qcom,nord-segcc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, se_gcc_nord_match_table);
> +
> +static int se_gcc_nord_probe(struct platform_device *pdev)
> +{
> +	return qcom_cc_probe(pdev, &se_gcc_nord_desc);
> +}
> +
> +static struct platform_driver se_gcc_nord_driver = {
> +	.probe = se_gcc_nord_probe,
> +	.driver = {
> +		.name = "segcc-nord",
> +		.of_match_table = se_gcc_nord_match_table,
> +	},
> +};
> +
> +module_platform_driver(se_gcc_nord_driver);
> +
> +MODULE_DESCRIPTION("QTI SEGCC NORD Driver");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.47.3
> 

-- 
With best wishes
Dmitry

