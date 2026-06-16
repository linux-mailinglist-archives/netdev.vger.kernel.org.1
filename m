Return-Path: <netdev+bounces-299919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SlbYA2R8MWpakgUAu9opvQ
	(envelope-from <netdev+bounces-299919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:40:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE20B69251E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:40:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ghlKm+wz;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=i4yI9DLZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299919-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299919-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E81930D843B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726FC4779A7;
	Tue, 16 Jun 2026 16:32:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC645349C
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 16:32:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627575; cv=none; b=GOG26OLDR7xSzDQvCH7dmeLPYwqJkfNqqbhG+TZFvlBYBI6pBokQgRQZ2/uwI29aaLbsMm2D4z+1PorNLTPzCl4QeCid7dNxzs77MdiMtcazIWKRaFOW8LkqiGowbk+sxmi46+lGRZ2O95PBzm1sz8uReH8s2AXo8VMokykkFHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627575; c=relaxed/simple;
	bh=lWWZPYEQrsIsGdAAXnMw9QstRgjLolTF7cGTMEF4YXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLLodpkfmNWecPAK5u79aoI+TC7TxThLOaMNtB/D4/2tk0HYKTc16CYGRidaYpREm1oT+D1X6wxGbAPuvfK1WjjPSXHJGS8vSdWvw0asJy/OvQkElbVSy1HWAxetjmrhzSQcfdYJ28HmywrjaFV/8yg7JSaomMaW0XBtO9zCRkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ghlKm+wz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i4yI9DLZ; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GFeaU1013999
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 16:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HTLmtc9ksI3Eco4GNG31SXnN
	US7oWeItGbDEBkSUCOQ=; b=ghlKm+wzr3rwcCYPHJJPPl2IabGV0RObc7v3ufHv
	Af5mdpjw84AwRh4yDrZg3SpfLgkcHAeWBh0FHD0z0HbXdz1N5fNC9k/MBSGSJxYJ
	Z2iJ5D8JR2YlecMzmtQ7caUkP0MhxI56qJVTW5YrCMK59E0NRjz8QaTEKSJuo29z
	Qf5GaL89jZK59uwBwfBZHjYlGG8E/O5iy+LogQu4td2ds3oc7q7m9Pg5nhPEtYd1
	vmdpqekjL90bSW64cEE2Ax7UZGoodtiIkytS55m+XsyGlzKR/ojDXDN6HjvOQLlZ
	WJPlWseHn3+joMGIsr5VZocLhjov4eRdEowpDtqduzflgw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu4dkht2j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 16:32:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0b1bb53a8so256395ad.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 09:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781627572; x=1782232372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HTLmtc9ksI3Eco4GNG31SXnNUS7oWeItGbDEBkSUCOQ=;
        b=i4yI9DLZigSd6Rh3PyiPOd2ptzLWHYvadcMSJE1uXY/yUawfFtSvwSiK1JwGA6P/Ww
         aP3SmXssyWl3kMW++5/yaCDix9U/YBQM2Uu2wT/6MTQLEv/Cjfs6H4RxuorGEg5rThO5
         6FrBR3wUKZaseWeX87+1jyr6u+Us5uD2/drACPYboipxnPaf2IuIrgdbbS/LkqtbtC0Q
         G/RrC07v+ZQhgsCE9Y0xXPLMXzMfDAabeO3CAr1zW7SnFW/GdCJTgfUjsXZvN76LvVCw
         A7r1Z0xm9Vme+rxx6a0fQg1irGzl6DHXZp45hsaMceF+0E2CA/JA4Pr3y64zVqB1fdSz
         UQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781627572; x=1782232372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTLmtc9ksI3Eco4GNG31SXnNUS7oWeItGbDEBkSUCOQ=;
        b=WzmE3s3A1ACz9vRsHb+bVrKOO968QsJyTthhsTHLvwoOHASpSe9wUufLnnNtH23u7f
         iErnbZT/MZdyqn9/PM3wmT/w7yZrYXL0Isd+mN+pOQhxt/GKH8nyWZjGLS7JQLgjAQRL
         AtOGVlAU5c82pDPj+tm4AIAgL9XwvvowFR2sddy/mE2r3b339GFTt+83IATiozT2AcXb
         QxBKSbWjZ7z8NyvOJF8ou25jMJLxzxQ5S7ATRijhggnmPOU9I6cDWh7+m6Li17AIdTz+
         BcKZNRkW745GEKanICefpx/uAKSOYqISK35X50uIaN4m7bZ1gcN36VfLFDAdO7Hmw32g
         8bEg==
X-Forwarded-Encrypted: i=1; AFNElJ/5c75Lhn4sIrRJEoGaFUTjkF8CKC1RpItqAEPo5iE+aFw1HCO7q5VuFjU6PU1NC1m0bmQE66E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6NA6GJ6jtw2ysPXtJlZAcrPrCXRbXq1X4z7S3UqW2ezKq7pI8
	vMmoQO6EV94qyZGeOaWmAcgc7ef6V5PbO29vAMgBdCBOkbJtlbAEpqCTbvlErZfI+0PN0Vkpd5b
	iNpMdkRb5GwsEJt7RDLahkWjxS6rNbqpxqJ+qRT22K/GH00Ms7jCbHxhb++k=
X-Gm-Gg: Acq92OFCUw+Kri/ObJ3gUNa277/LK8YoiGEmG8EVNXkx4N/aV9U1Vb64JEq7oiXN9A+
	4BNBpTdc8VMnOW3HAVth5kf1m+F4d3m89IMWBbjofIg7Bkz9HljdrxALb+sZYIaHFq3v11nYxzK
	uSUtACoxyydMXPCb0+IKBtlY040G0AJ1FGnHkwC0xKDR1xL798RhhGuN+/isLD/oIdCMmYaWFGl
	VpvaROct3nnHVLH+oPN0jEI6lGuOPXDJ1+pm0d8DRAuTL+b9hHjqg1/BX48Uaq7PRxH/45M0KIC
	8CcFJgxHBZepvcDZIpuZhjt5RYkZRDevXFqmQ9/KcUpUJwBL6H2Yp7uUDPb4db4Wn1e0XQfMA05
	wqa5Rpw7I0pmL8bfaQB+GjjIlvqRrpveAWx8=
X-Received: by 2002:a17:902:8a93:b0:2c6:6425:b343 with SMTP id d9443c01a7336-2c6b877e63amr1906405ad.6.1781627572066;
        Tue, 16 Jun 2026 09:32:52 -0700 (PDT)
X-Received: by 2002:a17:902:8a93:b0:2c6:6425:b343 with SMTP id d9443c01a7336-2c6b877e63amr1906225ad.6.1781627571526;
        Tue, 16 Jun 2026 09:32:51 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm145948035ad.38.2026.06.16.09.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:32:51 -0700 (PDT)
Date: Tue, 16 Jun 2026 22:02:43 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 3/9] net: stmmac: qcom-ethqos: fix RGMII_ID mode to
 use DLL bypass
Message-ID: <ajF6q5eKz92ddqVl@oss.qualcomm.com>
References: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
 <20260612-shikra_ethernet-v1-3-f0f4a1d19929@oss.qualcomm.com>
 <42355330-c22a-4fce-98ab-dc22b321ff16@lunn.ch>
 <ai93X/cNWHtEQsDt@oss.qualcomm.com>
 <82705420-771d-41bf-a4d9-ed94dff86ff0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82705420-771d-41bf-a4d9-ed94dff86ff0@lunn.ch>
X-Proofpoint-GUID: TrNdgyz52FMUCzU9F-ptDLilDEFZqzcG
X-Proofpoint-ORIG-GUID: TrNdgyz52FMUCzU9F-ptDLilDEFZqzcG
X-Authority-Analysis: v=2.4 cv=Ibi3n2qa c=1 sm=1 tr=0 ts=6a317ab5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=1fSEK5Xs-BiMaI_fvDcA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE2OSBTYWx0ZWRfX9BmPtmUbYQFB
 pwGMWc+V8Ly5/iKMQV4zUF4wyhY0l+ViwNnWUWvoTAE8AuYUuNAFen41nPUzLui1iwsFujkZ5Tx
 WR6lr6qoqJGDiELgTQ5YkqASYWb7IFrsdAfWgWlw75uuBlzieHo0dChLqVgohyJH6p8DA1GUPdK
 MACD4dEewg5OTSK3zhXj0p/TKcCzaz8aB0du7pvb2fv1YLRSa2v7QFfRI9H6Iyvco1mubT2LFi/
 506AJdbRJvSBgkASYiz1E7HWnXKy0b0kKNbJ/bgcSdV5ZO8LAoogav3akDfDqnuwTmApeAp9yyA
 adylllasHzXA5Gkt7Ixd0X7smknHZc5iJrcFxMFJjp9pi59YXbu8kESFdqgrv+7gu9zCq3RNEvF
 /DuAw0bbXvUC4zv4r7U1UED2K+5Hvg3lvEI4OJ50sJcOmravnmkp8v/k/W+Mb0OdE7l6EC6bJmB
 WsDFWslPqOKA4+e/xqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE2OSBTYWx0ZWRfXzv85QFc6ByxB
 AXd1mVDiLznrfvUDg4mruLiQYES/aWsc+xm738zU2+ksYrwaaUIe71c1584SKBctfHEQq2sjsNI
 CUinAoScWQu+v0mI+kX2IUJUxVzNWAU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160169
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-299919-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux@armlinux.org.uk,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE20B69251E

On Mon, Jun 15, 2026 at 06:48:55PM +0200, Andrew Lunn wrote:
> > > I'm curious how this works at the moment? Do no boards make use of
> > > RGMII ID? Are all current boards broken?
> > 
> > Searching through the DTS, I found that we have two boards using "rgmii"
> > (qcs404-evb-4000.dts and sa8155-adp.dts) and another board using
> > "rgmii-txid" (sa8540p-ride.dts). No board which uses RGMII ID.
> 
> So this causes problems. We cannot break existing boards, yet it would
> be good to fix the current broken behaviour.

I am trying to track down the sa8155-adp and sa8540p-ride boards. The
EMAC on QCS404 is extremely similar to QCS615 Ride [0], and I got that
board to work with this series (with RGMII ID mode). So I am fairly
confident that QCS404 would not break (if its even booting up with the
upstream kernel currently). Also, I think we could change the phy-mode
for QCS404 to "rgmii-id" from "rgmii" if these fixes go in.

> It could be the best way forward is that you issue a warning when
> "rgmii" is found and pass rgmii-id to the PHY. And you also change the
> two boards to use rgmii-id. Lets think about the rgmii-txid case once
> we better understand it.
> 

As Konrad mentioned, it would be great to know if we can test out these
boards. Looking at the different versions of the ETHQOS programming
guide, stopping MAC side delay should be as simple as what we are doing
in this commit. But whether the two boards work directly with the
default PHY delays is unknown.

	Ayaan

[0] The proposed RGMII fixes would help enable ethernet on QCS615 Ride
as well. I see that the original series had a lot of issues:
https://lore.kernel.org/all/20250121-dts_qcs615-v3-0-fa4496950d8a@quicinc.com/

