Return-Path: <netdev+bounces-296374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XEgvLCpRJmoWUwIAu9opvQ
	(envelope-from <netdev+bounces-296374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 07:20:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4948C652C97
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 07:20:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=JnEC44Mm;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=LJrJ5BAf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296374-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296374-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B417F3025D21
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 05:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654C4318EDF;
	Mon,  8 Jun 2026 05:17:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10FD324B20
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 05:17:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895862; cv=none; b=GgcEuSj09fK1QbjWy13O3zrs27Eik2t5pjsxV9jmHBaK83eyJlaF3rPrssyq+V1ri9jcTENl9odrnE5WYx7AT3+NiXEDNQmvu+5HuLWstNqvaQe3vCTV90yv5VG/lFTUT0A8WMLJIawineZtPbUMV4/hOEGwv3fdKDIcgqIzluY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895862; c=relaxed/simple;
	bh=ECCQW3xO5T10iM5U19E+0qZYiXxmAtMlR1/dkEEP5jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXW08Dp0HAkmykAlJIv1u1uvBtXo6eKswZ+mhga5LOnpfS7w6JvawvG2FVHH44neIJ5jHAOxi8kJN1NE7v58ObbSJWqz+4gdj9Td5Y8VhWbT9TqDDliFCkhHHLLt2To4YfZx2DNwUY7QJmf7+uId+/qsSJwaza2jvUVuPfe2W4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JnEC44Mm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LJrJ5BAf; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580FpuC2023775
	for <netdev@vger.kernel.org>; Mon, 8 Jun 2026 05:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jHDv+l1yJPatDEFQEt3C8+YE
	NnInljrnoEQC+ZtHEAo=; b=JnEC44MmkE34jRXFAcP5fjofJOckK7SAsjHw/smZ
	v2iIudu/0FYOM4IVzFVJqii0MWFrktGFow2+e5NRhBk88YbumNtQJjJkxyKjWSjL
	QguzgEr5DaKfq/rMbJSFdX77PjWNOzpC1uikgygzKbUKpxjJJOFFwW0FAWznlTMv
	LDYGSQBuFrKZKE6/hAJwztE71NzRxkQGKuVcLaBQFi6GKmb1Z3Cr+8y5Mp/Ve0JK
	iUbk3IwwE8CYK4VB+au/YsHTcnv0fB7/zvgmyGG9uVNH8HImqwpYV2rZNoCNeuiL
	czrowGotVNsRLF3ULKVv57X/7JoxNOefsrYd1s9dUsV9wg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embmre038-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 05:17:39 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-59ebf602dbcso2453264e0c.2
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 22:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780895859; x=1781500659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jHDv+l1yJPatDEFQEt3C8+YENnInljrnoEQC+ZtHEAo=;
        b=LJrJ5BAfBzHc3FoBFtQAr8UApGRtYH5FMPkZllea1H+SgtcifAD0vikY5IXjcijNuq
         GXa7fjLnrk6nw3PBVODt7MWqvhtKMHsk4nSbemwgloY6YlCzEj+2Eh6ZxUzx7yTNK0SI
         Wlu7YWJLox6tkc3fzicULaGl60VD6HH8a8D6xN5NZu16iNeoOFxmh4CJEz9UWK5eF7bT
         bgdx/TIsAlCSU9UDwrSnmygJENoFSgcwMyeZgov/RyUHYPdOHERjcwfmkWgf4fJtoV9x
         jhvjhg22wXQGwXWT2nRnAjutGgZOqMXTpooek9CBCPkI0K2a/q82PMuGQFEwCA1h9kAw
         sO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780895859; x=1781500659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHDv+l1yJPatDEFQEt3C8+YENnInljrnoEQC+ZtHEAo=;
        b=jxpD962A0xlBxa3/RCDajTHODvvYj7hOLjeV2qmK8l2hTnoZOxILMeR0Hz+K9LBC1B
         hmag8Oy01HVPauA66Dq8W7uQBWVAzbVFo/J398phulySWx9mTped9N3u7aAJPalUBLHo
         gR1s/vDoWluCF3ZceE7MoM7MWwWQjDm8epjBQefF3EaIjsWr/AAHssQMuDXflKoZg7J/
         86cDZ+bJtEraUzRpY9rW5LLDHvnMZqXFy/g8e9sen92v+BabMyGgjDcgVrDscZQmTPAf
         /t3owtTuPaMBLyuSvlFjPZv6OrXYjFaDR4BBb57ZIR1fCKnK7kGBtebWVECXx2Mhroj9
         lbzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6DquuTEiW4AxEa+EITCLgtEKWO+m4jMoB2bOrV3aeEx51Q/YvSoUXek2/m/VzpPzsm3JyP28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3P/a0nurbs7cfhmvZgh67rwfFc0m987MWmrttQLsNa5ncM8Sb
	H0ctgTN31H3jWaWVLJ0duN47puGZwb/bQeDrb+R5qkuVOFEDf66x4dbGRYN5gYVExkDHHWfv4pz
	7uMFNe9xA5r4QEvf0zf60GWJh2YzalMrQ3axP9R90kHftG2w6ux1EbJ1CYG0=
X-Gm-Gg: Acq92OGpzeMK+b5Ze8aXuO3R5zUFlzhmLUYrNjNvcW6UiaSVyaeyuu4zpBTC45uIs3h
	UIcVsc3lfPbKCACVzOLO86U0HlzuKX2JNXiXhYoOwPbnZvVYiy52rX6EvcqzejQfnnT628jcP6J
	AgX41WSvneb0BgLHHKRZL5ne94RSZkqF4dsHt7JdpKYBMKNXPwBJmo0ThX8z4wVPjwQDeqW9okF
	zoVpCwg6y3pWvkww2WCcg2CgJ+cCazm7iY7aWCHIka6NHzc3Aasab9f9lWrFn5cDSX6kHhE4ywB
	5gKfzFwmlOJhQtAbSDdIvRWZybpkjEGbFCZkIClD8CSKnMo8ihvkpTOrgfQYqivbkG8Mfyrq5lR
	hWjq7VGIb9kW0n9V/NwbSaKz/adYDl51LfbCt1QGK/YX3oyrgXi7BLeBY0VgQ0vHO5bq8fV/o5M
	PvxtrP/2gI9iJ7hSzsquZoEzz3qpHTEXkCZzQmFZVFtzpbNw==
X-Received: by 2002:a05:6102:370f:b0:611:61d3:819c with SMTP id ada2fe7eead31-6fef194a11fmr5732456137.10.1780895859224;
        Sun, 07 Jun 2026 22:17:39 -0700 (PDT)
X-Received: by 2002:a05:6102:370f:b0:611:61d3:819c with SMTP id ada2fe7eead31-6fef194a11fmr5732436137.10.1780895858823;
        Sun, 07 Jun 2026 22:17:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b9082b7sm3529811e87.36.2026.06.07.22.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 22:17:37 -0700 (PDT)
Date: Mon, 8 Jun 2026 08:17:35 +0300
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
Subject: Re: [PATCH v4 4/4] clk: qcom: Add Global clock controller support on
 Qualcomm Shikra SoC
Message-ID: <h5wyyse47cceezyjxxzjbq4rjvghfgei32rog75mhe2cifwv2k@ouhgbhcshmvg>
References: <20260605-shikra-gcc-rpmcc-clks-v4-0-a0a7bfb44455@oss.qualcomm.com>
 <20260605-shikra-gcc-rpmcc-clks-v4-4-a0a7bfb44455@oss.qualcomm.com>
 <gvqubjzscwvq4nmerwptrnojrui26ymigzs3mo5yqordyfsnx5@zxtjhsntbrcw>
 <0a7f8ee4-2bd4-4ae6-ba6c-72b37d6ef92d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a7f8ee4-2bd4-4ae6-ba6c-72b37d6ef92d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0NSBTYWx0ZWRfX5idDmU3Ph/EA
 CFnkm7b6vqsUYGvbqkGb2UpZnWmFeH/lxnJAFFX//Sx34vUdC1xi+MdT2M4GCj/TSIEhTJhJRyR
 M+unCUhAYAvIod53CMLqRTC9kSrvWeLJb2cr5o4Hie7zOzQbM6eCGgfUZTSK/R38Kg7VSqmS2eK
 fZU03NZcrLTfUJ25R6c7GQQ5gqRO/nQUmm56FJtXtFTKjkT0IKEk8DvBz8weyXTwldY7VbIUnAR
 RB3N9lqKmTDkhwRUyh079ToO3MMD3toGT5sNcw/4DgEsX6pa5+APANo/0u8VU1WYuTPcpnahhma
 H2HkXPESEFMA+xzC2X3ioJOCz50dvIsdLBm0L6/zMqkZsI8FxCd6Nr/jS7V2Xn6MmvEI7HqRuqC
 io+2Zsg1KJs3G7LXYInNZx0cn4I/h105chn2uR6gdBPwrlzPYz4QslBrramJO0SToyNVAQuRuPD
 zjyMoCT1cyBBIHkIHGg==
X-Authority-Analysis: v=2.4 cv=B5eJFutM c=1 sm=1 tr=0 ts=6a265073 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=cM4Jl2COizv8PBbNEBcA:9 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: RYgj4TE1Uh9stNSojlV7GFLVRowBurjH
X-Proofpoint-ORIG-GUID: RYgj4TE1Uh9stNSojlV7GFLVRowBurjH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080045
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296374-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:imran.shaik@oss.qualcomm.com,m:andersson@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:bmasney@redhat.com,m:ajit.pandey@oss.qualcomm.com,m:taniya.das@oss.qualcomm.com,m:jagadeesh.kona@oss.qualcomm.com,m:krzk@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,gmail.com,redhat.com,oss.qualcomm.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ouhgbhcshmvg:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4948C652C97

On Mon, Jun 08, 2026 at 10:16:39AM +0530, Imran Shaik wrote:
> 
> 
> On 06-06-2026 05:12 pm, Dmitry Baryshkov wrote:
> > On Fri, Jun 05, 2026 at 04:49:14PM +0530, Imran Shaik wrote:
> > > Add support for Global clock controller (GCC) on Qualcomm Shikra SoC.
> > > 
> > > Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > 
> > I know that I've r-b'd the patch. But then I also compared GCC on Shikra
> > and Agatti. Is there a chance we can merge those?
> > 
> 
> The Shikra GCC has new addition of EMAC, PCIe, TSC, USB20, QUP subsystem
> clocks. Along with this, several Agatti clock/reset register offsets, as
> well as votable clock register offsets and enable BITs are updated on
> Shikra, and a few GPLL changes are also present.
> 
> I agree that few clocks duplication will be there, but it will be a clean
> and better approach to keep the separate driver and bindings for Shikra due
> to these new clock additions/changes.

Ok.

> 
> Thanks,
> Imran
> 
> > > Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> > > ---
> > >   drivers/clk/qcom/Kconfig      |   10 +
> > >   drivers/clk/qcom/Makefile     |    1 +
> > >   drivers/clk/qcom/gcc-shikra.c | 4431 +++++++++++++++++++++++++++++++++++++++++
> > >   3 files changed, 4442 insertions(+)
> > > 
> > 
> 

-- 
With best wishes
Dmitry

