Return-Path: <netdev+bounces-235015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736C6C2B489
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 12:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384A73AE006
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 11:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D1C2FF66D;
	Mon,  3 Nov 2025 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gfau043S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y0W0Uf0C"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350872EB87A
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168815; cv=none; b=hmAGQ2r4iGvGX9/Uc+mnFpKAp+11ps94HxHbjMY9FRuZWmHSM8wPah6Y7jbXSuwao9OkTCcmH+KjbOYM8gUUsDYQetSjlnmp1IG79Ws4uExuhdURYZcIwfCDvTJpgaitRwHW0Vr4pj4CMJzTSambe4BGa3SwUzRlg45A9CIM84w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168815; c=relaxed/simple;
	bh=3gNej9n4PI8xVpJeSNF61xug7D11sUzqiJjbVYZTuIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKWpXol/OS7F+/9PLu7mt/u9P07RhB6l9OWBN4cWj9Pz7O8TybeOtOqckan7644x2mTMkl1wFo9io2OtYAfWTHvu1UAEibbhctgXm3ey2llFgCkTSNLjauS0u5qxrhYUHkdoTDTrh6AVW2bu0wmUCSgSssF0OGXMzQQN8MNsOMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gfau043S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y0W0Uf0C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3AIkiJ2756306
	for <netdev@vger.kernel.org>; Mon, 3 Nov 2025 11:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dHVugL8aSPKzCU8GFFCuHSlg
	nb9t3MlUUbbP82kGwiM=; b=gfau043SgNLJpPKFQ/8FjvY/pqkLoAJsDXMQW3ve
	q9oTkE3DMJFi60QprWcGOGUztiHmNFlmTN5eC8oTItSmEAKjlDVLEssPwrrRT+7N
	yP+IAsydN42JOqHOMNx/gkqwyjm+Rz3d+uq+ltsuSYwrNG2WM8/1+ho0aOWzzMK5
	jI5lafmYJOpjKngVhqZNUtdVfovmDWvrI1s36Ih/zJ4xq8I667SABsu9E3dMvlwJ
	NTHT8ZhdZ4bFWWYIpR4cxyGNTtte/6jA9yxc45OISrjSYUM3pRWtbwh1Nhwo0XAT
	9Awx9Nosw4uJ/iO8wxbrZm69yxhB6KzC69qXvbvXV5oNNA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6th9r4ry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 11:20:13 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-295592eb5dbso20181005ad.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 03:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762168812; x=1762773612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dHVugL8aSPKzCU8GFFCuHSlgnb9t3MlUUbbP82kGwiM=;
        b=Y0W0Uf0C+NaNBc1MQko0O+iOCQ3Q/q5J6kq4Uq3LWD0BcCc9EYgA25ZiC1O/rlyf44
         JM9Rqb3sSaWmOgDPFf+CgeG0X8t+Th7OnjPsORUQPJcbVCPEj80B7Vv0CXBdG0/mY7Fg
         VVZ9r8jtjIPgtcQIIP12B1DF5yF7i25do8+Q9TcQEF6ybsdJPagL5u8Ge7T4eNcmmDw3
         EyXAqEeykKNXwmHdVNZVi/k7MPfJUD9/yfYhcrIpa/2hKm4Bljs+hQzlHBcDzWcqS6X2
         u+MAdrgXX3KQFt3fkblMK8zG+T4WGgkg88DtCw+4rPwjRCHyFtMp+aMvwABh51a7u1Tg
         180Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762168812; x=1762773612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHVugL8aSPKzCU8GFFCuHSlgnb9t3MlUUbbP82kGwiM=;
        b=sRJm7iUQcRxQFPO5AEOYptpwfstAEjOjUQczCEZn56kmIE+bK5Xb5cQzITMpC7PY0f
         44RUESAL3hOZPmoPV+j1GjFKtrD3O1P4r61C5IHRJOzjIc69B2u87yH0mlJDBKBake/s
         f/Q+tHt1egi6IAxf4XAK0TYjfN4vqHZtbQFBBV9hhp6bEnfnB9Zi3au9+O2sk10PL9IK
         niDaH4cAFV/fUrwtRm41Uk5KjTxmzNvAoGL4HTZn0gaI/wea1YYlqsc0e/ArQ5/ztGY5
         fpryW8FBHqAIAdD/29QCqnvwYkY4wIIXk3d/C0n8xMNJNPU4GSnDaAUzGEkN574nbxTB
         9bfA==
X-Forwarded-Encrypted: i=1; AJvYcCUGn9hncUR778cJ/2Z9HK6HBeMDdXCnDICH6BiYHcLpxpHbSF07p2kPXUf0DbQMI9sr6CtUjRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKVek/p2Z8i80+7IxpiA4d+I3/prokAhzClTjVV18c54g/8LC+
	0pNGaEtVB/Xlfdo9iZHtqAhnHUpC+U81gpigob+T+b0PSROqi436abLpeouZai5TD8izCDi7X59
	iTA2Ze6b/q7ngFyn3Y+m5NAVkpJzTm6Yy0HW7uQQZiK8WUFn3dboUfguNDrs=
X-Gm-Gg: ASbGncvVsfj15D0lfG2x5A7nIH0gfWBr/CxGQIIEAoComjEZObcdxqd/6t1rAEDG/9o
	3vJapAaE4iQIeOTzYa7DFU2joDjRUunZNG/fetXMpmZ5ETqqsRBijps+S3zjTohjOO8imf+KTD0
	mgCYATtwc8dPADsK6MjK5uGHcs9hfTCuT5pKrCIHUn9kclwjVZ/nGslAFZ32vgQczKNXzLj7vfA
	UO/0Onb//9mDoyDPdcrz+IS/8wvAqNOPeUZrlMlGiqtg0n/hDvQL+i62khX4NSczGPERvElIHsa
	ZUBv2XP80/iEK2TFJrPN+WJAkGOLPtjBsPaV0CKFrCjwfMByQAWjoif2CUgGGIgA6tJ6g8cWHHm
	blPei8LC/Er+0
X-Received: by 2002:a17:903:185:b0:290:9a31:26da with SMTP id d9443c01a7336-2951a37a3d6mr173856415ad.16.1762168812247;
        Mon, 03 Nov 2025 03:20:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGe/vgQq95tfGXYSn5QnZdARvafr4txtYxIUyWM1lnugCZTq324N2F2wV30wl4f3X69FiCxcA==
X-Received: by 2002:a17:903:185:b0:290:9a31:26da with SMTP id d9443c01a7336-2951a37a3d6mr173855855ad.16.1762168811492;
        Mon, 03 Nov 2025 03:20:11 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29526871023sm115581605ad.13.2025.11.03.03.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:20:11 -0800 (PST)
Date: Mon, 3 Nov 2025 16:50:03 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Boon Khai Ng <boon.khai.ng@altera.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Furong Xu <0x1207@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH net-next 0/3] net: stmmac: phylink PCS conversion part 3
 (dodgy stuff)
Message-ID: <aQiP46tKUHGwmiTo@oss.qualcomm.com>
References: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
 <aQExx0zXT5SvFxAk@oss.qualcomm.com>
 <aQHc6SowbWsIA1A5@shell.armlinux.org.uk>
 <aQNmM5+cptKllTS8@oss.qualcomm.com>
 <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
 <aQOCpG_gjJlnm0A1@shell.armlinux.org.uk>
 <aQhusPX0Hw9ZuLNR@oss.qualcomm.com>
 <aQh7Zj10C7QcDoqn@shell.armlinux.org.uk>
 <aQiBjYNtJks2/mrw@oss.qualcomm.com>
 <20251103104820.3fcksk27j34zu6cg@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103104820.3fcksk27j34zu6cg@skbuf>
X-Proofpoint-GUID: MGWrXA0hDqDZQMIVv1C2R2v1pxEi5ybY
X-Authority-Analysis: v=2.4 cv=ea8wvrEH c=1 sm=1 tr=0 ts=69088fed cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=eNbwivC5fTM5P8bRvx8A:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: MGWrXA0hDqDZQMIVv1C2R2v1pxEi5ybY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwMyBTYWx0ZWRfX5SpjBLBG85Ph
 mkeSs4I9QlxXJ2ftxNdTu+TBNztjZ4P9yBsf//ELA/XQLk9sw59jbHWhVz66jn4e9eCpDSCJPFV
 BJRZUO3DFkL1EQKLhi74MXRDMIgUm73BBoAx85hB23uG6+bbqJOZTY1VcqYf883qOVeAsyXYlAr
 9pZA6N72QB8sVvIYAeceFgTV62bjAaug3dMvm5+s+EVRNYhk4bTx3STwq2cmeWEW4Oy7GtHUPF7
 7bRL+fhquhbSZE0er56UyzjqSMljAA4H1CWas1r1T2NWQHufrw4tJdWGjASk/ZY+FIB49paZ7WZ
 ukYgrTu1bJakpvBD23WIT1hHCF/nIU5HyyPjeiImLSIEHrJVXxQV6Cx6IoVtjIcsrctrz6x/5V4
 +rCw8MyDcBhcoS1MUiCi3uBI5K6lBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030103

On Mon, Nov 03, 2025 at 12:48:20PM +0200, Vladimir Oltean wrote:
> 
> As Russell partially pointed out, there are several assumptions in the
> Aquantia PHY driver and in phylink, three of them being that:
> - rate matching is only supported for PHY_INTERFACE_MODE_10GBASER and
>   PHY_INTERFACE_MODE_2500BASEX (thus not PHY_INTERFACE_MODE_SGMII)
> - if phy_get_rate_matching() returns RATE_MATCH_NONE for an interface,
>   pl->phy_state.rate_matching will also be RATE_MATCH_NONE when using
>   that interface
> - if rate matching is used, the PHY is configured to use it for all
>   media speeds <= phylink_interface_max_speed(link_state.interface)
> 
> Those assumptions are not validated very well against the ground truth
> from the PHY provisioning, so the next step would be for us to see that
> directly.
> 
> Please turn this print from aqr_gen2_read_global_syscfg() into something
> visible in dmesg, i.e. by replacing phydev_dbg() with phydev_info():
> 
> 		phydev_dbg(phydev,
> 			   "Media speed %d uses host interface %s with %s\n",
> 			   syscfg->speed, phy_modes(syscfg->interface),
> 			   syscfg->rate_adapt == AQR_RATE_ADAPT_NONE ? "no rate adaptation" :
> 			   syscfg->rate_adapt == AQR_RATE_ADAPT_PAUSE ? "rate adaptation through flow control" :
> 			   syscfg->rate_adapt == AQR_RATE_ADAPT_USX ? "rate adaptation through symbol replication" :
> 			   "unrecognized rate adaptation type");

Thanks. Looks like rate adaptation is only provisioned for 10M, which
matches my observation where phylink passes the exact speeds for
100/1000/2500 but 1000 for 10M.

[    9.449107] Aquantia AQR115C stmmac-0:08: Media speed 10 uses host interface sgmii with rate adaptation through flow control
[    9.462025] Aquantia AQR115C stmmac-0:08: Media speed 100 uses host interface sgmii with no rate adaptation
[    9.479897] Aquantia AQR115C stmmac-0:08: Media speed 1000 uses host interface sgmii with no rate adaptation
[    9.499634] Aquantia AQR115C stmmac-0:08: Media speed 2500 uses host interface 2500base-x with no rate adaptation
[    9.516342] Aquantia AQR115C stmmac-0:08: Media speed 5000 uses host interface 10gbase-r with rate adaptation through flow control
[    9.534045] Aquantia AQR115C stmmac-0:08: Media speed 10000 uses host interface 10gbase-r with no rate adaptation
[    9.587889] qcom-ethqos 23040000.ethernet eth0: PHY [stmmac-0:08] driver [Aquantia AQR115C] (irq=304)

	Ayaan

