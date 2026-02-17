Return-Path: <netdev+bounces-259122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJLkAemzlGlbGgIAu9opvQ
	(envelope-from <netdev+bounces-259122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:31:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E9A14F284
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06E103013DC3
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB3F372B4D;
	Tue, 17 Feb 2026 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ikqywinT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RXElvxmx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC48372B3C
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353061; cv=none; b=O1t9FoF8KYWNpwrsEwzxSCJDreF1qb/dwRHSe13tj27a7ihQ5C+N0dzgrs37+tJzVnEf+8QeDaY6np46ZHYgt8CxApwRC8B0xARHxAiImrdVSSA3+87W19V53sco7zfmAWaK5TyD8WCA7qkKM3Tb6B4qzUNKfNGrsYn5PhYKaq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353061; c=relaxed/simple;
	bh=x7VepQbv4zE0qSIXnc719tjSDUvFwelQPfuLaSK8vFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcy+fDMlHD/GA3qpDNsDRwboCTdnc7L/Gh6xg99rxGhRBLH78HpB8FUklM4TnhEN2EPzzktKy2nGE9zEdHQb15PSe48M3D0TVAiMX6XiMromragCAVi0JxhLynO0UPdVl/zM8kob4fEfkmI9FVfQB7BBjF5czhRHAiwPaeRntbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ikqywinT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RXElvxmx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HB3haL1942880
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iOD+nAdpJf1uzrUdiNFRB8KZ
	FSJpSBc7+kYwsye2bH4=; b=ikqywinTuKS2fa7esxmRwIAfZa+/VkzXtkVep2ZE
	n3W0IiiKCI09Rb62+jl4GeMZ26ELYqCT0N0tftBYfFXFY6+QDOChej3a3Mas2yqG
	RCWvYwNHtKP8wqMmjnMwuqhJ0jx07dd6QsxLYoJ0uu2odhj0s7dAhZSEwpzVp7If
	Gm2HYurPUjh+dI5jivTFtRpVCSHO7NVSVLi+M70EWGHqBLmnoIAjJv1eGt4MOfwW
	12tPNDU1QGg17uQH/6nQvRUUxrzVABxih+o2KKiXgPz9ZpuQgiGGaQfqGiYxBL6k
	JWhHk2noSB+Emfs3YUqPqzrTHWBo+7C0zuoERW3bxCBhRg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ccq4g1ee9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:30:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a8c273332cso256244875ad.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 10:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771353058; x=1771957858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOD+nAdpJf1uzrUdiNFRB8KZFSJpSBc7+kYwsye2bH4=;
        b=RXElvxmxpxYJMnzumRUhsXw39QXGAIUH4EXKtvTlbjcZ4RckzsPH8XPyur13bWHovs
         V5Wd17i+yopFbzmfORHTP3p448TEkL7kG3eTqwYW620vK7FEUIj96u1dV8aRd3h0+X4Q
         cGR0Wooo0AiKd5EQ56aSQQ2tidQ/B6mwLK+XWKNy5g2VcbyhDEhXLCfSLzED9vkZDcc7
         PTvE4W8i/3/L5+746mPY/W1C2A+6SsOBQx1cGXlc/0L4u5FbrjFoRqwE93Z9KGeFTPgD
         q8Piijmuu+n6XjOOS/b/Ty3+K8DcrwCzKPn3oZ3ODDrPalYaUjb07c/v/SC3ClKjvc/x
         5yMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771353058; x=1771957858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOD+nAdpJf1uzrUdiNFRB8KZFSJpSBc7+kYwsye2bH4=;
        b=QmXB9xTlIeUyFkjJhRVazL4hIiackp5VYuHD4ix3QR5rBVKCA9eIINuhonS23ORjAt
         06vQUHybUbnY79oe4F3X4525DkE4zFjJfaxQO8oNFBfQfOg5k1atM5tKkQu/LanlSBiS
         fNc+UggvroKDj//MHI49URtdRPp6+9V53Y1dCK36iBx8c9RyfLSaV3Hr96PmBnxRY/8y
         yTRPW59mkS92GnJnNHVFPxfjGZM06wOMlPCSkZ/6csOyn9rN9oykQPrDNpa95HR0sD2L
         X/9C8oW+ZnvXsNiYzjXjuGBZwlQJ67zEiDMf1LoSIxhqLCoLt77nYWcDX6Q97bpaJP6W
         /vVA==
X-Forwarded-Encrypted: i=1; AJvYcCWm+lhI9DmtpEZ3UiobGF6zQT8K5OGMjD0zU59SYmq9/egsj42Ou98Xzto0yDPpROX+7oLFBaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3FLRcGpRKa2WmOzVeQMjeu7vC61p+qP5uZ6nGZ1WplwJOJ5JO
	AF8LOi98kRwPIG02ZZzbS+yWW2ua+ToV7bKhStnKm4qRPA6mcOs/z2S1aa0e9W1vnArKpOdA9KJ
	HFrq5hsGqbPlZaolf+DPJmXK26xrtBGrqLrbHC+2TTkCRbw7bU3VqWorJMok=
X-Gm-Gg: AZuq6aIFKd9csBn5w8xifMLixA86y/H2/Voa2dlz7tGA4Nz5dHAVQZC+0NUU/7AZip3
	RCYCOodXzCEUoajDcJeODYSx5HY2tAFv79g1zFsDH0+jd5aPUVO0GS5aqfp6Vzw4bLkaotGvBiM
	j2igap/XFhUaoY5OU3WKR+prq7fQzBG15IGJ5rd8tm2eL97kKNs/srz1YYQ+OA5NoR9bDjAs9Gh
	xv3h0jldxmYsGjImJOnzSdX6Q3fGdmYgqVK+ZW920KDytHPqfOIubPZxxU1nWdBzmmmspsAR/85
	0U9ACTVSrTgiEQxPEfXPFEW7jcUuQgwxHEq0mjWw3fCzx2oQMKEX4mDf5HfXvXMKIyXMne4XOkR
	SX397coB//ZRkQpB1TCpMFi54BTLNqEt2VBM=
X-Received: by 2002:a17:902:ef45:b0:29f:1bf:642a with SMTP id d9443c01a7336-2ad17433468mr128152075ad.12.1771353057871;
        Tue, 17 Feb 2026 10:30:57 -0800 (PST)
X-Received: by 2002:a17:902:ef45:b0:29f:1bf:642a with SMTP id d9443c01a7336-2ad17433468mr128151555ad.12.1771353057241;
        Tue, 17 Feb 2026 10:30:57 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a72e444sm115401545ad.34.2026.02.17.10.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 10:30:56 -0800 (PST)
Date: Wed, 18 Feb 2026 00:00:49 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Frank Li <Frank.Li@nxp.com>,
        imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC net-next 0/9] net: stmmac: qcom-ethqos: cleanups and
 re-organise SerDes handling
Message-ID: <aZSz2Z5Ps47XrcHf@oss.qualcomm.com>
References: <aY0aJppQWUC52OUq@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY0aJppQWUC52OUq@shell.armlinux.org.uk>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE1MCBTYWx0ZWRfX8y12TyHfhsMg
 IVc1CBZ3c0sh3/tD8wLZijo7N+GF3y7D0A2qWY5qdDugC2pG3SKifzPfGCXnWvDk6u9FSYcCUd2
 mEY5leJ9lM03zDPNh5dTPU2qJHNt03G1njy6Dl8jyieOCB2KPLUw3v9aKS904N0zzOQnPp4AL/k
 7BgN7nB7fJeIQybfPUqW6GXxOspd180/VjcF0w1MlMuNVCRX8l7KFpI0vks2KAzU2PFegzr41jY
 iqg3VO3eb2c5Vv0amEPt46CUy9c+GV+wQ6ELIyETSSK/bqeyfPLFWMt1uxlF3yzVrSEmudZuuah
 bv6l0Xa0492rgzUScL0MD8wGDvZLIXTaheAN0ZRmi6U6q+v8EoJn2D5ISxev874Iqlifs9Cf0Xb
 1fE04ISVCeh8GKNDpECWUVPqjImmjUSRcYf42/+rekbbBfBd0RNExeBRbBe1Peh+emFLvmZtr2x
 TyjQD/dYrBqpOc/39Tg==
X-Proofpoint-ORIG-GUID: wKb2bm0wn-cCPT--B6zuzgHyCCdPTkZK
X-Proofpoint-GUID: wKb2bm0wn-cCPT--B6zuzgHyCCdPTkZK
X-Authority-Analysis: v=2.4 cv=YdiwJgRf c=1 sm=1 tr=0 ts=6994b3e2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5Q1s3vWhG7-J6-f9QwIA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170150
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259122-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 99E9A14F284
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 12:09:10AM +0000, Russell King (Oracle) wrote:
> Hi,
> 
> As the last series had issues with stability, I've changed the approach
> in this series to concentrate on keeping much of the SerDes related
> code within the qcom-ethqos driver rather than trying to move it out at
> this stage. This means it should be possible to bisect these patches and
> pinpoint exactly the code movement that causes any instability.
> 
> This series starts with various cleanups to qcom-ethqos (the first four
> patches) before beginning to move code, passing phylink's phy interface
> (which will change) to the fix_mac_speed() method, and then using that
> to configure the serdes and inband setting before moving the SerDes
> code.
> 
> Please test this patch set, and let me know whether this works, or
> where it breaks.
> 
> Thanks.
> 
>  .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |   3 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |  11 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |   3 +-
>  .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 114 ++++++++++++---------
>  .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   3 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    |  11 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   3 +-
>  include/linux/stmmac.h                             |   3 +-
>  8 files changed, 90 insertions(+), 61 deletions(-)
> 

Tested without issues on:
  - QCS9100 Ride R3 (AQR115C PHY, 2500BASE-X) - 2.5G/1G/100M
  - IQ9 EVK (QCA8081 PHY, 2500BASE-X) - 2.5G
  - QCS615 Ride (KSZ9031 PHY, RGMII) [0][1] - 1G/100M

Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan
---
[0] https://lore.kernel.org/netdev/20250819-qcs615_eth-v4-6-5050ed3402cb@oss.qualcomm.com/t/#ma85cac924488d580b971e6477e7df30dc7e48045
[1] Ethernet is not yet enabled for this board in the upstream kernel.
    The changes from [0] were applied locally to test this series. I am
    trying to figure out how the board deals with RGMII delays so that I
    can revive the series.


