Return-Path: <netdev+bounces-232675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB6BC080B0
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075741C244E4
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B4E2F12CD;
	Fri, 24 Oct 2025 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MNXOWZkH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EB42F12CB
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337383; cv=none; b=Zw5Mth1v6iu4whPEUdHWD5iVJV3MHMM+H/6xw1zcodPxo7bHWL7trDy8YrpsHh/Zoh/Dlnbl9/WJ9f1PqmaP9mXVtBtbbMgIMfz7EdwG4S53VPIdEYLm+oa+OONJ6uf4kYfJBNJ3RNBICHIDTjRrTuWO7Nwicyly92/exThua9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337383; c=relaxed/simple;
	bh=1XLciUlHh6S+kYz7uLy3y4YQPc/3a03OtrDAJfhcOXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZt39qAD0v1DnukdzE5/3Qh+S9p0U3rIU9CWGeK7bxq2wqwPuL3Ej9KBvgXRQGLv+mOpOYQDX9ydIbY7a7QJt3p155RNZLZmXTZiwKFyOmHpqjIlnmO703uikCQSQKayhMZleAviSmTIJUICOakSaPTiYPnFTECgPIQIcfn/gvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MNXOWZkH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9EvC009576
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4s7W/XVPsSKkxr5WrJxW2Xw4
	Bw8xDxZi15MzcSKlWvc=; b=MNXOWZkHxfew87KzdGBbhYPJYIi7C6XUeZFoaZfB
	Wesyte6wCdRC1+JJN861xNyBScJHCelVlCSQhdRlx7CUZ2Y4Yb2agVz2I9Rn/KQa
	thu1dlrRi85b1VFoEUZfccfyR16Nm9ZyWQENXwykriaKvRatun7GUtncm7IP2y3V
	L/N/O9GsCeuxB841wgvkHme+sFfH3g57Wn2RrO6X1RPzU6J1dfBx3QlQyvZ+sW9C
	ZGXHUG3r7NLpTeafH9LyRuNFV2/NrMlEHEJDdggNG5EJuaMvT+X+IJJ02zjEYXr/
	M3FSM2ZSBXfAFAcMdMZlH0R6KeheAKDcYWR/3Tl5DOOh2g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27jd3mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:22:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6cf1b799dcso1778665a12.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 13:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761337378; x=1761942178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4s7W/XVPsSKkxr5WrJxW2Xw4Bw8xDxZi15MzcSKlWvc=;
        b=bJ1YY9tq2Tnsw1NOR0C78Fs7WjD0icuwgXtY5HLWyZ6AILLx8nH2GBSqt5mkvkMLpM
         8wzhBpKQrbEeWDv7g4HkZ5LbZNwNoWsgfnR8OK/kWh4cwYbEmsMl/JeErkKO0TH6dx64
         P7YT1DZTD2Y4M5xyduOD5+pzta1mGLmhr/OjLaANaZYTc6aSjtfdH+OmeQg1UwblFspg
         6zcZEO49ZSrxoON81mvxEgo4yBoV2nh67dPzOxY540yLih3SG1mTnC0s+KEp324b6O7u
         Vl39IJmrOFvrz47lVTSBOiFfxP6gaA2RFt5rwWQocwhPfKFfJ/oNwQ0jcMGQ9mLb5PCM
         Er5g==
X-Forwarded-Encrypted: i=1; AJvYcCUFg9GlPHm6VD3++dPirzWYJ3bFI47jXRF1QRa4S6+u2KOYoosIfnxWJXOADEY/dscFLPrbeDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjvAbmnIugI3FP7K8DzDyadeayAqw1RinbhQoHclbBB4e6BvPn
	Vak0vbXHx5c21deTkKi80m0WXnb2tT1y2o4mj72RaLp9nrXBfBC73MvEuYejMSs/Ch6AT3cmUYD
	hT/JhiVNZKoU6ckcT7emGI1Ak1qsDNjntF73MkbPlcTuZc99llWh481LQKQE=
X-Gm-Gg: ASbGncvbbGxK6j6pzLOLlu48WT/mXYwv6Nag/v3mU6ZNY+GU1bSrdIpuUyM55ajIwBj
	kwy4po65B7/AbnRFrbQUHDBTuMHgQJ/lHr3M06DAukF7junZ4PIgi37+tGN1Cma/e7Zcd6FDIK0
	ZESsX9Qida9P2sPGkiOLich+G+2yimi/dmCgaLyEBZ0Edi3S5u44Fc9RH5e2HQY2tHZzPB8CuBH
	EHdAghSBTajl9E4sS004IyhYCzdn3VbBa4qw1JcZ4jIyYbDCCSU9nSEr9I3chLx+Fx08IiaZB2m
	YwvO7JYpa7vty8UgM8x75VR6uKPL6fHjYpZaax3V5ZjvKjr1gvxz/nlKn43Q88U2YmtU3xObEAE
	ECXrx2ReQzbtm
X-Received: by 2002:a17:903:1250:b0:290:dd1f:3d60 with SMTP id d9443c01a7336-290dd1f3fc8mr257610805ad.51.1761337377911;
        Fri, 24 Oct 2025 13:22:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbuyFiJ9PskI3CsAgB4hGF6Xk8h6QS2PPp/bDpzFnWGnwg7UfgJO6gCcviCKkunL4F1CUUrw==
X-Received: by 2002:a17:903:1250:b0:290:dd1f:3d60 with SMTP id d9443c01a7336-290dd1f3fc8mr257610465ad.51.1761337377287;
        Fri, 24 Oct 2025 13:22:57 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d23218sm897285ad.51.2025.10.24.13.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:22:56 -0700 (PDT)
Date: Sat, 25 Oct 2025 01:52:50 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 0/8] net: stmmac: hwif.c cleanups
Message-ID: <aPvgGjHr3eR0088m@oss.qualcomm.com>
References: <aPt1l6ocBCg4YlyS@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPt1l6ocBCg4YlyS@shell.armlinux.org.uk>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfXwoNbhlkseQxt
 27ml8J84bTsRuQ8j5j9sXbrk57iGFxvkstrqbGv9s9cWS+3duZ11vOBJXn5t87ewjA+qQy0Ilpj
 zpVSWg5mIYboIt+1KiysPOsNcfcwZsBANxKw1Bf6DCyZvTp5PUVEri4gBJ2Aqm+8SWrmNASby+j
 1fQfoIvDEanMT6XIeoHp0O2/MM7y2QN4/FzbtXGtDO8EGpc5zG88Wj6hjSUa4Erlz3ObjHOq7mE
 23Sw/bvL3y+aJ1Cogho4BV+Lm1SFOXbf1J/g2WemUloTuJxaYhjSs6wEBnYvioHeesYmExqf38J
 O577p8xUpver7DRlaTm/H+lEdcj7jyjwgaIuEHdJ3cnKF8N+OYOLZr6vNLEkyuDCV3u+uqkvaGd
 U0QGF68bgaGZTq08kvoKQ9ClCZz5hA==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68fbe023 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=t3lSQCkMIvt0bwidl4oA:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: uxO-sAGtO4wDhOYUMY17iltIqtO9lNP3
X-Proofpoint-ORIG-GUID: uxO-sAGtO4wDhOYUMY17iltIqtO9lNP3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

On Fri, Oct 24, 2025 at 01:48:23PM +0100, Russell King (Oracle) wrote:
> Hi,
> 
> This series cleans up hwif.c:
> 
> - move the reading of the version information out of stmmac_hwif_init()
>   into its own function, stmmac_get_version(), storing the result in a
>   new struct.
> 
> - simplify stmmac_get_version().
> 
> - read the version register once, passing it to stmmac_get_id() and
>   stmmac_get_dev_id().
> 
> - move stmmac_get_id() and stmmac_get_dev_id() into
>   stmmac_get_version()
> 
> - define version register fields and use FIELD_GET() to decode
> 
> - start tackling the big loop in stmmac_hwif_init() - provide a
>   function, stmmac_hwif_find(), which looks up the hwif entry, thus
>   making a much smaller loop, which improves readability of this code.
> 
> - change the use of '^' to '!=' when comparing the dev_id, which is
>   what is really meant here.
> 
> - reorganise the test after calling stmmac_hwif_init() so that we
>   handle the error case in the indented code, and the success case
>   with no indent, which is the classical arrangement.
> 
> ---
> v2:
> - fix "verison" typo, impacting patches 2, 3, and 4.
> - added reviewed-by / tested-bys
> 
>  drivers/net/ethernet/stmicro/stmmac/common.h |   3 +
>  drivers/net/ethernet/stmicro/stmmac/hwif.c   | 166 +++++++++++++++------------
>  2 files changed, 98 insertions(+), 71 deletions(-)
>  

Tested v2 on Qualcomm's QCS9100 Ride R3 board (qcom-ethqos driver,
GMAC4), so:

Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan

