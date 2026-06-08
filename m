Return-Path: <netdev+bounces-296694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +IJCCJ4LJ2r1qgIAu9opvQ
	(envelope-from <netdev+bounces-296694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:36:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B70E2659C85
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 20:36:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="Z/MZx9wx";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=WMN8KRtC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296694-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296694-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10BE830059A5
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8444E3E1CEF;
	Mon,  8 Jun 2026 18:36:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A063E0C7E
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 18:36:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943771; cv=none; b=OLilkK2QrDySYFm+s0djDwPDzi05vsJtBeh9eQDvaAA9FsZ/l7wlFl+K2UYzFS/D+kgNXPvIoBYLYJNS66zRQI2BEeWzWZac1RlS46fj/6TYVKs5qwjb1BR1+ouhJ5Yc3jTtz8fcCUfHKpejxSlIR4n2prQtNf/ntSjMTB9yd60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943771; c=relaxed/simple;
	bh=+X4pezE2922d596Af5ASfQnVu1TRws/IydngxFVvotI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YE9hzCnLfe/gabrrCCteRSHVr0vkVjnFs2NJRlyYVqFzUxNLTBn+5rSoJUgfad5SQFWONICEYdAxWurcDAYt3S/RxyG+DL91xiDIShNtgzroiLBJO8tYLIkt025HdNpU8k7KF+ml/F44uzboiXAdomucte8t5BHHEuWN0xezgBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z/MZx9wx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WMN8KRtC; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FKY7t4045927
	for <netdev@vger.kernel.org>; Mon, 8 Jun 2026 18:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wxwTllO3Xeua002xBaThYp49
	lPGhAz0Nblos69p+78w=; b=Z/MZx9wxfzFDrntwSanVF38O3t2EX9uPwECseMfW
	Ahi9H2LtV/Z0fBwxAmmwTcavWbBkTNnBu0nvTm/778OT/8lrDfH+nkpVrL+ybERl
	Z24corn04QuL2vAttWEG3cNngAdbtuo0OyN0x/p79VZAdbEVs58128Av+PrW7M9u
	zjwD4V1WhFWGyCSJjCv9r5hJCBazsPeikKIgsEznKRvjrCdYoTWWY8YJHnrLz898
	JCxiJi6c/Ss8RWGF/ectf+d/dXY72LID53/pRnLhr0XcEHYqAE+A0RInLf1tGBc8
	1bJG5TGEdKxJkNXY+d2sk2X7zJeoYxkPitCb4oqTW/kmKg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enxee1mq3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 18:36:09 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6cfd2a26ab0so1958607137.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780943769; x=1781548569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxwTllO3Xeua002xBaThYp49lPGhAz0Nblos69p+78w=;
        b=WMN8KRtCc2LSPoUQ0kYAPVjcLCUq5yz2d2qXOPs7s/fS7+HsojawuC5LzUBA9gZbhq
         9LgtKSovtiiRnpOwWSx/Xi1F63wvqBRZWeodBSGpav3ocPiHaJFYauEstLwC1i+V75s5
         jxq4OZBQ584dzl3163D1HYyvnNiyzz2/LAP9/NmZqWdKk4ZQTyFfvZNshl17SrB5Lxft
         q45Z7gsxzUwhVoy7ZJMU6UhmC2rWOLoCSwc/BwNAjB38TB0ORhVl5Tu1UXW4dPwLgKS2
         EEpeqLggAwGJO/o388wwRnZkHYYUMMznyUo4oE12NWqf7GyzXoHZaQobOq/UF1q4oh1R
         hB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780943769; x=1781548569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxwTllO3Xeua002xBaThYp49lPGhAz0Nblos69p+78w=;
        b=YDjAUPKT6++1BQmXHavV9gV8fdEo/+naeAyJ3ehV5XQ+7eokqGuRZfZ1uSMKHj19RW
         zzpAzRo3S7YqGIDBPzl6GWggTkVQSgzxaaf8xMt3ktb6cOrjBR4021fn0EY28FhaA8Hx
         doACKIJV1HTf8CrCdNJUxUlvIeeU9qBeTuak5n1hsduwVWOeyVCa5Ug5kjTBtDWhjIM3
         2JLyyngfLWpbZNDaZgrCmp1VmQ1xD54c6k48XrkpAYTaHjv7eXhgBx1CCv29fcO2UGLb
         vBh9+SwApq/I7YeN/yLCemsSqXmDb+iAFRi3u88+Pxq5DUBpg8GSq1qNeuVamnIbvYec
         IlGw==
X-Forwarded-Encrypted: i=1; AFNElJ/uK7zJeFXbgliwSlJHQF3k0X6Tj2eCn9/nlzPI2JwFQT7Bh1Wmf5z9DV1u/55U13GSlzhgB90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0TG6vDCiz+yt/05cLl3lFewINEZCFw1FHE4Q9l4PlFQ/woSFQ
	t+gFm647l6ymbp7JPrzVa9y8OXjpGaNaIQdik/nPhHkifR0Q8lYoU0iUTGWBUWxGB+PTi3Z7hIv
	ljSTdig7pu26byhzkJ+I+re42DftSQFgguO9zEwy7144QotPETvw6wbcHGTg=
X-Gm-Gg: Acq92OH1GScxFZ6/GiElu8DAut6E4T7FofBD2ssybQJ4GuaNSieKFT4KIO9cUjrmqVN
	gKyjeu1bxEb4ETZdWuU7wyvoS5hGkQaJTZdd2V63oVkZFllDCTJbi7hbpOXViPiMQVj1NBTwgQ7
	ShdO6828cWegF1W3VgW9/9wfsBEc9V7/JP2W1YZmjJNtRss864YLoNGTNlxmmKjcT3adQZ1vaMm
	qbeKvGhTZW3Gt/7TLHczbunGsNJIJIR6Dy4Xj81o+NAywb3B+FipyxVcyWxrubOLpuHP6ARQZC3
	W4QAiSzCyB10lw9kTjAaN1H6d8lBDBBwWO2127a1k/9+yfQE3MXo8xratD3clRAyHFTXhK8Y73I
	P7m2HgqAwEK/8QzQ5kcn3/+fQAJDUefmXK2gbgi/G9yUS93GW/EehytztSjWqcxwRqwUQqhqNTL
	Lt3d5M53UEol5indMfBPQx+UCyTzCR6xbdOuoF6pOmQPipCg==
X-Received: by 2002:a05:6102:3749:b0:5ff:c5c8:2734 with SMTP id ada2fe7eead31-6ff0610cd27mr7976938137.25.1780943768616;
        Mon, 08 Jun 2026 11:36:08 -0700 (PDT)
X-Received: by 2002:a05:6102:3749:b0:5ff:c5c8:2734 with SMTP id ada2fe7eead31-6ff0610cd27mr7976915137.25.1780943768168;
        Mon, 08 Jun 2026 11:36:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396abf66e37sm51078631fa.5.2026.06.08.11.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 11:36:05 -0700 (PDT)
Date: Mon, 8 Jun 2026 21:36:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Imran Shaik <imran.shaik@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Brian Masney <bmasney@redhat.com>,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 3/4] clk: qcom: smd-rpm: Add missing RF_CLK1/RF_CLK2
 clocks support on Agatti
Message-ID: <a5crn75rxxqtf26ke6552b27ar4xrglkrwdgw2sfnkuli53ymd@2gapkkkcx4o4>
References: <20260608-shikra-gcc-rpmcc-clks-v5-0-94cefe092ee3@oss.qualcomm.com>
 <20260608-shikra-gcc-rpmcc-clks-v5-3-94cefe092ee3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-shikra-gcc-rpmcc-clks-v5-3-94cefe092ee3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3NCBTYWx0ZWRfX5Y5SWr7HLiWL
 sR04QltLsXOuVgexBis7v9BY7ktJjPqFc4SYuujCMxesl1Ug8CxjYi9s2MPh0xVsV3Jv2KBLfJU
 WHsCvAURkQH5LmWDZn1cdz/F2ourMb4+zRgaFNqmF2pf1iWa4LYl77ip+8pxP3AjgDUBCxSGowR
 /0MpXEhmMHJ750RXHSwa34qkv+AINautwhAgs3XZ5XlJHmaDWsU92wmMy5Nf5isLDphghCMVp1v
 PXA9ty4/ov/YozLUGhrIOzXOVGW9k8HAHAMjAlyFjMvtBKh2XGghzQYs9gZ4Ztdrfq4FoDxAp6a
 o5cJ0zbtUl4r82MSiyzk8FiFHB4BYqJEy8Xly+wTuJvAME6YkhI8/3icDLwb7WQfBQnl5/xelAX
 kz9WoJiJbGpjI13k2BcpbaBcSDC+vHSNnXnNW7zKIc9+3mN4vaXXYQQmNeP3FhoQ2I8TG6YCqBW
 daVFDgZM9dix8LQgpdg==
X-Authority-Analysis: v=2.4 cv=V6BNF+ni c=1 sm=1 tr=0 ts=6a270b99 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=G-4fGFNKO6kq0i09DNwA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: w9tse-FpaAecU754M7trE40fVEyHA9j2
X-Proofpoint-ORIG-GUID: w9tse-FpaAecU754M7trE40fVEyHA9j2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080174
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296694-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imran.shaik@oss.qualcomm.com,m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:bmasney@redhat.com,m:ajit.pandey@oss.qualcomm.com,m:taniya.das@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:krzk@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,gmail.com,redhat.com,oss.qualcomm.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B70E2659C85

On Mon, Jun 08, 2026 at 05:51:51PM +0530, Imran Shaik wrote:
> Add support for missing RF_CLK1/RF_CLK2 clocks on Qualcomm Agatti (QCM2290)
> SoC.
> 
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/clk-smd-rpm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

