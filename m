Return-Path: <netdev+bounces-269201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJRmGUwju2lofgIAu9opvQ
	(envelope-from <netdev+bounces-269201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:12:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 942D42C348F
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7668B3008084
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9B4359A97;
	Wed, 18 Mar 2026 22:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pN0BTH95";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CZ/8DQDs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B728535B62D
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871937; cv=none; b=aQ+hL3w4iQIjYFRrbHg7dPHOPlY7N2gIm51UwxtxMG1n4xG1vL2tDhUEN57dHMIEN/LhSeDJWtrrZm0BW/modjqDPL+21d8ox4hFY1LlPwqI3I/Anweuu1/YMXAK974TcNFXMBPl7BIXXvowC9Q4xDSP2xGd34Un+ZAaLNUPd/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871937; c=relaxed/simple;
	bh=WOVGW2z53slTRWk+CQA/w4RaDvMtyz0el+IgcgNAdRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbGAyx5lq664GBW2B8So7SvVVBphabrkXu0MMxPc6CmY54hJDfuxPjVQ2wMoD7pYxl30HPRqzWf3s2Fvb0E8zymiGGT7QH7MybJZZDlED5BVu8pkWpLtQF+tqg1hGivK7nKgAOd9WzNUJewl95oKRs+Ry24C7nwcM79Pbbb4gm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pN0BTH95; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CZ/8DQDs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IFgjNY004008
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wfPdTTKFeIrqOaOP9gRV4ZVq
	TsDeuSzuEH83cPJoqOo=; b=pN0BTH956IbNpzhiCfIyryXAETBTLYRK+va1QblI
	uPVPzHuAsZdidVMzHb0ZlRq1C+WVLohRCpKyFHQZNC7bX0n0jGatOA8qdiO9I3Kz
	EDoDokM+grH0gdgqY2yYXlX9/SlZqNhNBFGkB0saihVCLau/8+DqhcDPwrpL0GXX
	o46hkX6hKKMBOt+VVSNbu00VH7o6GtahG3S6WhTFXYP/YIk6s0AO4NoJ1lHRvmJ+
	galis3GPPV1yljFPLpBaMtvRcgnkG77WhuFyJUm/Qym5LNb2zFV515z7/4FVUIM4
	lDf7RL083RJN4R0deOPbyCLJr5NlTnKFkXMOBg5hOstiig==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyscb2q3f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:12:14 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82a6906e35fso1539565b3a.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 15:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773871934; x=1774476734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wfPdTTKFeIrqOaOP9gRV4ZVqTsDeuSzuEH83cPJoqOo=;
        b=CZ/8DQDs3FxnNlbgscjanR60IoN1tgeeQFa1YGnbJlm6HFB++6ICivBC3K+oR5PoXw
         NGvaRISgtR+bHjoZJ1jjujK3i8RQsXrAVyHOiGIWHL0f7ZE91aUUP19IEx9fkYC4FOFr
         6sSqg1kaytYwBVER/XznYMr3tFJn5WVdXGUKi21xKMGkIPk977Ptpv9/oYxDKmLTstKo
         EQG+5TdIgPu35etIuefqXtfFZaaPAy6d49yGtVLx40Ulo/jp474v+2zfhmRHO1FEdIBw
         9AikfE8plBEValkVjCr9MwFKfLQ3qs2BQT1KRVdC1VNSa5UXzYft+4b+LhEqxImgkPh6
         slmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773871934; x=1774476734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfPdTTKFeIrqOaOP9gRV4ZVqTsDeuSzuEH83cPJoqOo=;
        b=jBhiiW+5LtVOnsKsk93X98jl8LHRu3SHbg9VLgdx4eO6F3VKWZiVhCmtKQsy8NpQ44
         hDHl4GQN+/TlOYfgg0k3JcRLTxtDpBY3YVVcNGPPD9ikbAKpLmOQDCQiKJMr7DVdqpFA
         ToTCA0bIN6QiFMYGNZrVOu2ltORn5EYdC+Bfo9D3K8Yq6o2m+856bpGhlu5sla55lh7L
         +OEleeAszhi8jjXVfgsFTpOsphAHHa8GptjANKpsu2N4HSTWOu5aVnDZN2c77+BpRR/s
         BnKJHgbAxRjQKj3y190NN/WaAps/xcFkkdrZ0W95PgMUUXdCr8Wb1WDjZroGsi9ujpe8
         IqRg==
X-Forwarded-Encrypted: i=1; AJvYcCX7BC104tNiSRJbuKDdZVGUX/AoCa0sDTP+fGJ7RPERO0GFyGOnxyKNpEsukuvYHJXAZGH943M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+i2x1vtV+ftucs1gq8A3v7s63XrH84mM/Nq8sn5b1sK6cyNQH
	dEnugCbciqwrC2Qv3ElKeldLuaHFn0a6bKeLuhju2IF3Zs+Yn2DaMD5Cq1fAvw0PimFV4cT2uf4
	SeFC9JhUAsB+Eonu/8cadTxkKKb7I+cd9rt2gq2tsNrzlfH+4FqZqqvjxd8w=
X-Gm-Gg: ATEYQzywLCX7e30DtkQoJ4DfxWH0Ga1t/JQ1DPZAlCU0cYaPAZ1VmdtMroxdaL6tCdp
	v1DXBt56X9VIV3/l6FXKCvPUEBmESsQ4kvAem3meGhK7p4Yb2TKQDqWc23TFsVEoX5xXQPRtyxw
	6JPuIdjLgtco1ZZoe6WL3mYGFLpHLQmQM9EKnntNZPNeWynYGhhHqLIvqWTPKDalKSL8FdVvoi/
	m9LpbhHCTHYBES8r24KuN0wyYZdoInvyyg3kiDV+cyrGgTd9WBJYRCaBiQPCYWofJ3Vo2bpnj3K
	x8YgYldEHMzZtjAgKyUuiCG4JHdB3KONhaxFsnPUHXPSfX/YNPcnOViP3c0/4YTjvIn+WvOchSJ
	Ehh6LIE5FDaB1iCiwpnLtwbTRsm7b8rsKpGQ=
X-Received: by 2002:a05:6a21:6b02:b0:398:a41a:371f with SMTP id adf61e73a8af0-39bb2498f6fmr944717637.20.1773871933402;
        Wed, 18 Mar 2026 15:12:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b02:b0:398:a41a:371f with SMTP id adf61e73a8af0-39bb2498f6fmr944692637.20.1773871932733;
        Wed, 18 Mar 2026 15:12:12 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b56ac50sm4778552b3a.16.2026.03.18.15.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:12:11 -0700 (PDT)
Date: Thu, 19 Mar 2026 03:42:05 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next 0/8] net: stmmac: improve PCS support
Message-ID: <absjNQ2s3Z5N2Zwo@oss.qualcomm.com>
References: <abQC7r38QLhSeadl@shell.armlinux.org.uk>
 <abdEscs44fU4kRag@oss.qualcomm.com>
 <abdYu864OmNWiWIW@shell.armlinux.org.uk>
 <ablpxwGks9m38fhM@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ablpxwGks9m38fhM@shell.armlinux.org.uk>
X-Proofpoint-ORIG-GUID: haTIJxwA0srCrsJxWouHwea4JWqhMTj6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDE5MiBTYWx0ZWRfXwNa/tP4tuDp1
 UqBlmFMflA09HdRs3FQZytnFkU6R05rypYawWVKbdAq7D5hk6+6QOnZW/BvgSK8XBj9/PnxbAiw
 e3DaC57lcUSV7x3j5ilFYzflI8lFwBaB1kCrVZhlHjiWV5DtsxSULIDQ8jCFzjLGX5z40BYWoTX
 JEPAmdHm0HQ3/NiVZJTa7RvwGfGzLIfCyW8J5BuBQ6msArTZAXdVtgcyAWEz1OWfoUIApZ21SK9
 YJ7xLZDa2fJlEmXp9FJihXz/vWzLIZ3MDQ67aVGE1kLZ3wZWFNpIPIyVfgdXFpTxatFqhcRG1kx
 /uZlgeVVtq0FEiGGDcAIzU9GcJ9g4Xd1HuYMShjQwJs1RCbue2clU2x+yB13JZi1QNmzN/m/J2k
 U63ugDJwzaNedhrN1l3aEe/u8eooEsOSaRv1MhMAC5sLu5CUYRS3aXSaXRobGt1Klap0TVF7jFn
 EN5syyTXfR4/Yq8xmQg==
X-Proofpoint-GUID: haTIJxwA0srCrsJxWouHwea4JWqhMTj6
X-Authority-Analysis: v=2.4 cv=PtCergM3 c=1 sm=1 tr=0 ts=69bb233e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=9Hbxq-cn08ijON1ErxsA:9 a=vUQH8iars7gmROI7:21 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180192
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269201-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 942D42C348F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,
On Tue, Mar 17, 2026 at 02:48:39PM +0000, Russell King (Oracle) wrote:
> On Mon, Mar 16, 2026 at 01:11:23AM +0000, Russell King (Oracle) wrote:
> > This will be because we're not attaching any PHYs when phylink is
> > being told to operate in 2500BASE-X with inband, since it thinks
> > that's the media. That, and, because stmmac has a long history, it
> > needed a special phylink_expects_phy() check added in stmmac_init_phy()
> > which his what prevents the PHY being attached.
> 
> Okay, another idea that I hope will work. Please drop the "net: stmmac:
> qcom-ethqos: enable inband mode for SGMII" patch so we go back to using
> outband mode for everything.
> 
> Then, disable the call to ethqos_pcs_set_inband() so inband mode
> doesn't get enabled for SGMII - as phylink will be telling the PHY to
> disable inband mode.
> 
> Does that result in functional 100M, 1G and 2.5G speeds?

Yes, but with an asterisk.

 - 2.5G works fine
 - Shifting between 2.5G, 1G, and 100M are usually fine.
 - Booting up at 1G results in link flapping (it gets resolved if I
   do: ip link set <interface> down and then up on the link partner).
 - Similar link flapping also happens when shifting from 2.5G to 1G,
   though its not always.

Attaching logs of the booting up with a 1G scenario below.

	Ayaan
---
[    8.650471] qcom-ethqos 23040000.ethernet: Using 36/40 bits DMA host/device width
[    8.650486] qcom-ethqos 23040000.ethernet: clk_csr value out of range (0xffffff00 exceeds mask 0x00000f00), truncating
[   11.569262] qcom-ethqos 23040000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-0
[   11.577988] qcom-ethqos 23040000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-1
[   11.586665] qcom-ethqos 23040000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-2
[   11.595357] qcom-ethqos 23040000.ethernet eth1: Register MEM_TYPE_PAGE_POOL RxQ-3
[   11.619882] qcom-ethqos 23040000.ethernet eth1: PHY stmmac-0:08 uses interfaces 4,23,27, validating 23
[   11.629468] qcom-ethqos 23040000.ethernet eth1:  interface 23 (2500base-x) rate match pause supports 0-7,9,13-14,47
[   11.640202] qcom-ethqos 23040000.ethernet eth1: PHY [stmmac-0:08] driver [Aquantia AQR115C] (irq=288)
[   11.649691] qcom-ethqos 23040000.ethernet eth1: phy: 2500base-x setting supported 00000000,00000000,00008000,000062ff advertising 00000000,00000000,00008000,000062ff
[   11.680117] qcom-ethqos 23040000.ethernet eth1: Enabling Safety Features
[   11.688517] qcom-ethqos 23040000.ethernet eth1: IEEE 1588-2008 Advanced Timestamp supported
[   11.698080] qcom-ethqos 23040000.ethernet eth1: registered PTP clock
[   11.704633] qcom-ethqos 23040000.ethernet eth1: configuring for phy/2500base-x link mode
[   11.712966] qcom-ethqos 23040000.ethernet eth1: major config, requested phy/2500base-x
[   11.721115] qcom-ethqos 23040000.ethernet eth1: interface 2500base-x inband modes: pcs=01 phy=00
[   11.730157] qcom-ethqos 23040000.ethernet eth1: major config, active phy/outband/2500base-x
[   11.738748] qcom-ethqos 23040000.ethernet eth1: phylink_mac_config: mode=phy/2500base-x/none adv=00000000,00000000,00000000,00000000 pause=00
[   11.763778] qcom-ethqos 23040000.ethernet eth1: phy link down 2500base-x/1Gbps/Full/none/off/nolpi
[   15.215445] qcom-ethqos 23040000.ethernet eth1: phy link up sgmii/1Gbps/Full/none/rx/tx/nolpi
[   15.226572] qcom-ethqos 23040000.ethernet eth1: major config, requested phy/sgmii
[   15.234297] qcom-ethqos 23040000.ethernet eth1: interface sgmii inband modes: pcs=03 phy=03
[   15.242902] qcom-ethqos 23040000.ethernet eth1: major config, active phy/outband/sgmii
[   15.251044] qcom-ethqos 23040000.ethernet eth1: phylink_mac_config: mode=phy/sgmii/none adv=00000000,00000000,00000000,00000000 pause=03
[   15.276661] qcom-ethqos 23040000.ethernet: PCS Link Up
[   15.278115] qcom-ethqos 23040000.ethernet eth1: Link is Up - 1Gbps/Full - flow control rx/tx
[   15.283364] qcom-ethqos 23040000.ethernet eth1: pcs link up
[   18.317922] qcom-ethqos 23040000.ethernet: PCS Link Down
[   18.323424] qcom-ethqos 23040000.ethernet eth1: pcs link down
[   18.323977] qcom-ethqos 23040000.ethernet eth1: Link is Down
[   18.329375] qcom-ethqos 23040000.ethernet: PCS Link Up
[   18.340467] qcom-ethqos 23040000.ethernet eth1: pcs link up
[   18.356522] qcom-ethqos 23040000.ethernet eth1: Link is Up - 1Gbps/Full - flow control rx/tx
[   21.358679] qcom-ethqos 23040000.ethernet: PCS Link Down
[   21.364183] qcom-ethqos 23040000.ethernet eth1: pcs link down
[   21.364745] qcom-ethqos 23040000.ethernet eth1: Link is Down
[   21.370130] qcom-ethqos 23040000.ethernet: PCS Link Up
[   21.370139] qcom-ethqos 23040000.ethernet eth1: pcs link up
[   21.397194] qcom-ethqos 23040000.ethernet eth1: Link is Up - 1Gbps/Full - flow control rx/tx
[   24.399108] qcom-ethqos 23040000.ethernet: PCS Link Down
[   24.404613] qcom-ethqos 23040000.ethernet eth1: pcs link down
[   24.405168] qcom-ethqos 23040000.ethernet eth1: Link is Down
[   24.410563] qcom-ethqos 23040000.ethernet: PCS Link Up
[   24.421657] qcom-ethqos 23040000.ethernet eth1: pcs link up
[   24.437636] qcom-ethqos 23040000.ethernet eth1: Link is Up - 1Gbps/Full - flow control rx/tx
[   27.439468] qcom-ethqos 23040000.ethernet: PCS Link Down
[   27.444971] qcom-ethqos 23040000.ethernet eth1: pcs link down
[   27.445528] qcom-ethqos 23040000.ethernet eth1: Link is Down
[   27.450920] qcom-ethqos 23040000.ethernet: PCS Link Up
[   27.462016] qcom-ethqos 23040000.ethernet eth1: pcs link up
[   27.477991] qcom-ethqos 23040000.ethernet eth1: Link is Up - 1Gbps/Full - flow control rx/tx
[   28.026087] qcom-ethqos 23040000.ethernet eth1: phy link down sgmii/1Gbps/Full/none/rx/tx/nolpi
[   28.035077] qcom-ethqos 23040000.ethernet eth1: Link is Down
[   33.336433] qcom-ethqos 23040000.ethernet eth1: phy link up sgmii/1Gbps/Full/none/rx/tx/nolpi
[   33.342861] qcom-ethqos 23040000.ethernet: PCS Link Down
[   33.350674] qcom-ethqos 23040000.ethernet eth1: pcs link down
[   33.350724] qcom-ethqos 23040000.ethernet: PCS Link Up
[   33.360912] qcom-ethqos 23040000.ethernet eth1: Link is Up - 1Gbps/Full - flow control rx/tx
[   33.366768] qcom-ethqos 23040000.ethernet eth1: pcs link up
[   33.386487] qcom-ethqos 23040000.ethernet eth1: Link is Down
Note: doing a remote link toggle recovers this.


