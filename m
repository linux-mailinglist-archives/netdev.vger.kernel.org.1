Return-Path: <netdev+bounces-259128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GtXCLm1lGlbGgIAu9opvQ
	(envelope-from <netdev+bounces-259128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:38:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7816E14F3D9
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74563300D46E
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293B8372B5F;
	Tue, 17 Feb 2026 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PiBXBHMS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="etOSi1Wg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B5F37417B
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353499; cv=none; b=E32HxpJ6pm3yszhhnQzMveZZAozub/MwDJw8vh9C9fnuv8TkM/RPJcG6sBP3UzQd8eIiBvarSJk+eNlWqm1nCWWTAycKjDVucfxFyddZ19LVIDQCzgEbumyuHU715iE8Kzi5s3uP3PVek6dkO5zrbsn7s2JUU1d0C9vd0RGGbJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353499; c=relaxed/simple;
	bh=qq2b2UMHOMaxSGt6ntKxefg6mDqRsZciJsCkvSTWNIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9LEDGhoR1CcAd+zdVwVwT0o1fJF1QXWP2MYYD7j1mTQgKUUikiVT9AD2+GuB0O345Ej3xWxV/w54dPEbvT8LWWZVaMNvj3HFskN3+IKwVBBJC5gxEYnEZ9peDCrXVNBpCOmRPkiUGEjvwYQc333UFSDt/qczMJ8Cf86ls/wlwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PiBXBHMS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=etOSi1Wg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HB3l931943250
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9Khu6RsTg2hdw2N3mhPZSZ9W
	t5OAieYqZleD6YS06YA=; b=PiBXBHMSNCqQwgLRnydrG3YVTrHMg3v9Dt5jPg4T
	HIN+9sJM3DnR7cIZR8VrhYuaZDNqANZcm9Wkw6R+ko33mqs8RgzahmSeZSYLkc8s
	ZPIM1oalh1dcL5dKZNPSeArk7U3iDcfgjswXPl82oe4WI8GEJS3NzVt74ct7D4mT
	923Agy7keBPoncdbs0sMwNdbBsYnu7P9gtZykcMeTNVc3BdBp8fF7ERrApkjklms
	egYhRZRZ1zTJqcBhqHbnm1YXMd7R13I6l/VxnUwVr2eVcIkA5pQzq/lYE01rZx0z
	V8moE+VUhnCub9TvxjO2xLAmebp6FpY5dvUkcZ77wUC4lA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ccq4g1f62-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:38:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a944e6336eso261339095ad.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 10:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771353496; x=1771958296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Khu6RsTg2hdw2N3mhPZSZ9Wt5OAieYqZleD6YS06YA=;
        b=etOSi1WgyjBiV9M9nFh5VQUFQ06pYfDojsI2pLGFHPNNu8t17VjRiRITdHWHTgOufS
         8GpCIV/52ah09QOxOsH0ijNYuQYEmIDSKeSWXUxWb2nu/d5uZ5PCTCtiyTO7S1kVeAVZ
         QSZavkUirYmQ8P7miaxbltBGnoKdWOvv8l6RXtvFMJDeGmkNr+vut/U121llUOwmIMHP
         z2n7Ko+SeGwzcIxEWshJiMnOz6LU05PImr8uB9CMRIWgBqUhJMVP6DY8hfIKvg3z8xVw
         N7vp4o7BP88qHzSGedQW0rVkOjbenCZDB98bsivl1pJavat1WI4i2DEfrw+S6Q3o0Wv+
         oCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771353496; x=1771958296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Khu6RsTg2hdw2N3mhPZSZ9Wt5OAieYqZleD6YS06YA=;
        b=FW7XIBSAoPO/mdsPBbn8g2XNXyQErAvhyAYrQ/UYVOZlwigY4OHJ5sKMyFJwLsHGqt
         XdmuQ+GYKbak1XgQzVJFStyXadkgWN3Tk+o1yAEB8E1Z/uUWG1e26weZ+nBhuw5pnXbp
         +PlGUN1sMnkZae3TTofsEAkAW12tebrdMc+EbQsq0AG23WXUpFrDEvnBNdlsRa8GlUyR
         0/Zr1TAmDP9j79imD80lfKEbsYcE5Mh48OoubRj22d7AWVatiyOeL4DRnj1NXskZs7ro
         SfQ4fKqrPyECGxsoN60I5rxr6PVipljG68Bp1O7kKWDxSLan2dj/XcBAA9DgLfFqPrrW
         BvhA==
X-Forwarded-Encrypted: i=1; AJvYcCVjaIkVdKVPEYjCufz5e/RM6ikYCAv32+mzbXI0CSgkVlYRSo9SEwZOcz5AtmCFfwX4pc5vGTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa3JKnODp27fsdOz8TIkI0kKV3+n7AwB2Y5th8u7XLKKDOT+No
	LQ0jy/2s6Guupw5eBYKj3o/WGydYhYZG2x/nrG838m1EXgrqdPZuDczOjWI3Fmz6IXpIdhMIy9Q
	JVTBCCBdO10OWWXk9kZrdhbz6LQw/2r0TTXm1QnBdwHi2OcsRxC16ri5KPC0=
X-Gm-Gg: AZuq6aKnVEfEtja6GcrtrnQwNgq3ssfg3XoDTgSepIrGHdNlEBBqXuou1d/hXEWRlEd
	O/wntGG9pTCI86zf3vSAfGU7YpI1JY+PFUuvdxbqPFPLEZ/AkuHF918IxjZTLswAWtQV63Vq78d
	+SnqeLPAQ+dCZ4Lh1Pu06Rd0Lb9jLXzdNO63ECtKlCbfrU8jPflEsdRZOAjCNg7yvnN+SVYMiIq
	twds86myy8MmM9Jqb+5jE4RVFlddRezTmHvfRqT8rA8w5F6ZJ00NDl7rTmUWUQXAw4U6jxWh1Lu
	zXEemgfy0Vl2epKP6cLym+tBLX/0lTkf2Tsq7ZXGZcS2HZcQrZlanl69llPqk2Uqp7L6zhbiAVB
	YsluDde8bZOp4W/5waBSKlxN7AUukJXjREmA=
X-Received: by 2002:a17:902:cf05:b0:295:565b:c691 with SMTP id d9443c01a7336-2ab505173b2mr154968005ad.17.1771353495765;
        Tue, 17 Feb 2026 10:38:15 -0800 (PST)
X-Received: by 2002:a17:902:cf05:b0:295:565b:c691 with SMTP id d9443c01a7336-2ab505173b2mr154967765ad.17.1771353495260;
        Tue, 17 Feb 2026 10:38:15 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aaf4b31sm100667375ad.86.2026.02.17.10.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 10:38:14 -0800 (PST)
Date: Wed, 18 Feb 2026 00:08:08 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
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
Subject: Re: [PATCH RFC net-next 5/9] net: stmmac: qcom-ethqos: move loopback
 disable to .mac_finish()
Message-ID: <aZS1kIrwBFdwH8Zw@oss.qualcomm.com>
References: <aY0aJppQWUC52OUq@shell.armlinux.org.uk>
 <E1vqKPG-000000093mZ-2CL3@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vqKPG-000000093mZ-2CL3@rmk-PC.armlinux.org.uk>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE1MiBTYWx0ZWRfX2B7vJKdlvXmG
 7pKZSXXwMZUH+s1LcDoZKLseAvfXqnCQo2xkc8DJh5vAKz27hlXCpHYH7OefY5AUHmHbTk98nQd
 7XJG+I/7rvniHRyKPWedKtx4mboMrOPaCYTioCs/xWt7GJkC+Exw/cAn5aXRucVGFORzLef3ZFi
 YUpMPwSrhUoRqDoMpYqrfMTM8z8aVk+59dpPFvOeRAjmWX2R0wPPb6dK6ubiPkoAuLLnl5f7ET6
 mTWejGUEs5Q0ggyzpMDYTZOVrAjZwONDq8PQcluRpysZ3YCHhrEoBg/O+Xtr+dIJ/3I5qTvseII
 PNyvjEjv/GvsaX8Y3PHAgdV3rwcxjy/cQ1KWkpABJsZNwN+gSZ9jK9FkXR1cm0B56xBoNuFYvvu
 +M3e9ZxfMBPFounOiBmjMHAkp69o2KOJkY1KFq1Y7sXklVrZbqkROsN5FKECzyht51H0JiQEJ17
 Qkx0BrZmDalfenF87VQ==
X-Proofpoint-ORIG-GUID: woriJlAXX4AHe7rTSxEpOJX-W1oBPTSM
X-Proofpoint-GUID: woriJlAXX4AHe7rTSxEpOJX-W1oBPTSM
X-Authority-Analysis: v=2.4 cv=YdiwJgRf c=1 sm=1 tr=0 ts=6994b598 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=PHq6YzTAAAAA:8 a=EUspDBNiAAAA:8 a=wi4T-LJhgm9Wf8MEqCEA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170152
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259128-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7816E14F3D9
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 12:18:06AM +0000, Russell King (Oracle) wrote:
> Loopback is enabled to allow the dwmac soft reset to succeed. This
> is enabled when clocks are enabled in ethqos_clks_config(), which
> happens at driver probe and runtime PM resume - e.g. when the
> network device is administratively brought up.
> 
> Currently, the loopback is disabled when the link comes up (via
> .mac_link_up() calling this driver's .fix_mac_speed().)
> 
> Move the qcom_ethqos_set_sgmii_loopback() call which disables
> loopback from ethqos_fix_mac_speed() into ethqos' SerDes specific
> .mac_finish() method so that loopback is disabled a little earlier
> after reset has completed, and dwmac setup has completed.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan

