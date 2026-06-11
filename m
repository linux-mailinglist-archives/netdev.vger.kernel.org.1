Return-Path: <netdev+bounces-298092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vUdvJ6GZKmpZtQMAu9opvQ
	(envelope-from <netdev+bounces-298092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:18:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E09B36713EA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:18:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=JzS1JlYq;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="hPbH/0rw";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298092-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298092-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86B91301AB72
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286A53DF019;
	Thu, 11 Jun 2026 11:17:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2E23DEAEC
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:17:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176661; cv=none; b=rSy8QItRrgfMQJjqlCuc4kzq72sgJu1xshinFJiTqqZ0tQ85KqwXsgYGe02cAf3iIEDQNaJ+sfvc8YMRotNqquzwnukmaSTflQbRwMOeSUsFug8ELaQGefLLMZ7TEVa3WMIOjbDDGfid9EVnStEFXtEiVcJjyUjWxw4NvsB1b34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176661; c=relaxed/simple;
	bh=1pifwWWb17dbidWTWH+BgP3O4ayaax1Q8L+I/6p3Y+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgyK1rTkcVXds3PyTy5QPoApwtrUBWL5laAnREFuEMqd4KVW97S52VNkxet2lulZUXFxldW0mET5GjpqKsOwpDnyTJX066YKsMyhgi0Qc67GEBMxxER3gm5w7OCVh7xxDbdYM/SfD60TI5ZVOLyUtn60hLbWGl3wOJyo/FUiYNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JzS1JlYq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hPbH/0rw; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BA0uTf304010
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Br+nxqdNrndGB7+BxtsLhbcmDeid+9MpBuzSC8ZBMIQ=; b=JzS1JlYqcRhhO2rJ
	fvo8A/c8gBMc/GjNMGoCnwTztoDs5nAYtpWxfIPcK2VsT6nMuBvDx18OSDxlQWNo
	YUBtn7ePDnprqmQehabv6Qp5I37OhZiaIXp8Js+IDvPTw5+e4qBIWv783k+QSwZE
	HdLZ5yX9luMygNeiHgcPQnJV0049HF2/8uv3vaWvJmP55ce45DoSvUHL+a29CFH8
	cWrSMSqBShw1netZbTbVszk5pfgSubO5aj9zMBKpXcnT4dFXYv+NdIDfRUmLfXDe
	fUTAIVaG9Dpu2IMjXFk2SM0ohdGNLBchK/LCc27OfW/38eaaF4g2ObEM24XKgiTo
	/ioFyA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqtb5gdkb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:17:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-517647fbff1so25897921cf.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 04:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781176658; x=1781781458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Br+nxqdNrndGB7+BxtsLhbcmDeid+9MpBuzSC8ZBMIQ=;
        b=hPbH/0rwVG7w6OkHWF+7IEnaS7HxLVNJsZ3CHhSZAvup4HOjMTt5rGL7GTfT52mAHd
         8nVBEJzjvvH4rnTyjuMCZR/pPXneD0+EW3OeHH4QEbJ1jTXqjYBBFxXWifx5HViirOVL
         PEfBgk/9qyBGiqcWsXQb5m8bNa8EO2M/Qo+5kCtzbaXji1Ajqbw8wDDqFWJMpfIl1aEN
         pMZJKcOQetsGAPVuYFH0DHzKa7C1sqBnSWssXnmNCSEu6A3WT4XoI5cfJwf5VUayxbDp
         w+Q67cBtHKzGpDFEVJBavEae0Xkf1WyKr9pG+/l7hWPxmdIQ5ZklmwKZ8hjJLI0OoXSC
         2aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781176658; x=1781781458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Br+nxqdNrndGB7+BxtsLhbcmDeid+9MpBuzSC8ZBMIQ=;
        b=NIl2qs8P/BVs3VGpouJSqG/lLs6Hrxpvxsse+kOopz5S3aKk0wN2HtK1GL+wVLijJX
         VLY+QlDz7/njrFX6GQPVj+RCeIAJg9A1ktPVQ5NISQQg/lzDg0tJYDfIDJm0QYoI44kd
         O5PPjS8ggZaxm1KQ9d5H9dBj6sbL0bk8waXjblnwywovBHTU7IOpUs81QMDlcG2pdCRZ
         2u4FQDSEpqke+Myd2OlERCaFNnMMplWyAWX/w2wFcytFV7JkGrxVUWnjcwrlt9jGwCtj
         Y3BvV7zYvVN2s+VNnqsRIsot/CznHz7ZmmhpIxA12vOsdTcwnx0P+Ha1qe8ah5JpE3JA
         4a7w==
X-Gm-Message-State: AOJu0Yxu9i7UpdoyT6R7Bj6NWvT2hsszC3NAniy86RbtGnJb2eagxEqe
	5Tj6lln3VPuhPjfdg89XinNuBg2ijtz4046t7wEU874Ru2asM9DLU2yc9mlnRcHUSAK2inTQ0wu
	mz08sR9zD/cLu4s/KJI89Xah836ElfBTs9xqnk0XKrifQoT90yJpYEk3pZ+o=
X-Gm-Gg: Acq92OGqg+G7mJXjmtEs/M49QB1wfelfozD+DQmIaKJz/cs8mbYCIQnjBGHahs+q6lQ
	GauoGdDcBSEsFC2oqGYqLSgS4r50PKA9vuXAvoTvCnmDk3n7nk+2Mfew02QV17QR5tQg0XLlcr+
	B3kf8EcaZ8wTOm/s9cZySpswuEO1giX7gGzgHi3gFJeUiW/0vX9nOLY5pEfBCFhV2VT1DMQp6l3
	qZATVa37d4FwAHscjiCwpf11uW2QBbLIh5vfnIenqVVG9f9qExUz6mT44wBrBNXSTVS/E1teYDe
	+7oBWjzZCBU3kgGu5KRdZIqbZ0O2dxpw1jvdS04y272S84GIdKZOofcnAjQjKLnlnBuE6wjpCsV
	AVTXFnLc3WXvdXQdq+6QyMMJIzzxYTjYx+FjgXVL7o1WyNLq/Xyf3rgwq
X-Received: by 2002:a05:622a:4813:b0:517:62f4:e3d1 with SMTP id d75a77b69052e-517edcd7197mr22659321cf.2.1781176658066;
        Thu, 11 Jun 2026 04:17:38 -0700 (PDT)
X-Received: by 2002:a05:622a:4813:b0:517:62f4:e3d1 with SMTP id d75a77b69052e-517edcd7197mr22658951cf.2.1781176657518;
        Thu, 11 Jun 2026 04:17:37 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfcb688410csm50029866b.61.2026.06.11.04.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 04:17:36 -0700 (PDT)
Message-ID: <f919e897-c465-493a-a1df-01921e9e273a@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 13:17:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm64: qcom: ipq5018: Add GEPHY RX and TX clocks
To: Paolo Abeni <pabeni@redhat.com>, george.moussalem@outlook.com,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260605-ipq5018-gephy-clocks-v3-0-f232d9ca0966@outlook.com>
 <20260605-ipq5018-gephy-clocks-v3-3-f232d9ca0966@outlook.com>
 <850ba1ab-78fd-45b3-9411-97d50bb02ed9@redhat.com>
 <3d0f0b12-9bec-42b2-b8e8-264c6da0fbae@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <3d0f0b12-9bec-42b2-b8e8-264c6da0fbae@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExMyBTYWx0ZWRfX9n4+0/a/f0dj
 8G5kG0w5VcUWiLSq8QApEc2nI4EcVm+hs6XSFxod7g5v6JLRmnqZ3IEJjLikPWREH6rMnbAxdEc
 4xzce/dNmDG08msT/uypAB+ZrkzufTX1Oschij43ujoNuMnpjYSvvRMSV6SybchuFleyNKwOrRg
 1Q3IyVhgEx2dtxf85tyTxaajZ+b9ZOFRDQ63PsmGWhsiqkAq2jCV7geRnv2Ig3Y8x3Scv4/cQnu
 teBOb15fLGMg+XpkSuGkgxdiytW/8v49Xn+1wt8WCdb9tWMEuEGXM4l41jIBbNi8oNF+eB/VB66
 m/KYdL+dg5mSv4uexoiGohpWaOFO2rcNFIr79C+tePVdq4qfbK2qXLC9SGTKUsdxbVUMbarwprx
 WhcxJGPL/MEY+sGQ5y4Wi9ICvmNReRCzZeFZme8w2k5ZL+SfgSIxglywnBI6HpdTQysfHuieVcm
 cDNJdtTlshMivgvwWsA==
X-Proofpoint-ORIG-GUID: ErWuzoDa-D79fTuqfHbUtjiaPlkeedoq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExMyBTYWx0ZWRfX4V++LYObUGkQ
 z8HrIme2xvH8y2p1auUjZkMsJg/D3snAMgLkZSHuBZPsBdODXPlVsDSYSOalTMGeynk7HY8POBT
 nBPdcWEZrURT6GqVvdeMkxlB97Y/o20=
X-Authority-Analysis: v=2.4 cv=e6g2j6p/ c=1 sm=1 tr=0 ts=6a2a9952 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=qu9RNVSyyiXgUSAWbcIA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: ErWuzoDa-D79fTuqfHbUtjiaPlkeedoq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110113
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298092-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,outlook.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:george.moussalem@outlook.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:f.fainelli@gmail.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,outlook.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E09B36713EA

On 6/11/26 1:17 PM, Konrad Dybcio wrote:
> On 6/11/26 11:28 AM, Paolo Abeni wrote:
>> On 6/5/26 2:41 PM, George Moussalem via B4 Relay wrote:
>>> From: George Moussalem <george.moussalem@outlook.com>
>>>
>>> Add RX and TX clocks for the IPQ5018 GEPHY to enable the datapath.
>>>
>>> Fixes: f5f2b835e316 ("arm64: dts: qcom: ipq5018: Add GE PHY to internal mdio bus")
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>
>> I think here we need an explicit ack from arm people to take this patch
>> (and the whole series).
> 
> This one should go through the qcom tree

this one = this single dts patch

Konrad

