Return-Path: <netdev+bounces-265485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM9LJAyurmkSHwIAu9opvQ
	(envelope-from <netdev+bounces-265485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 12:25:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0145E237E39
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 12:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 653943057498
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 11:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC20D39A051;
	Mon,  9 Mar 2026 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IpI6JDD0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iCwej5Uz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA059390997
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773055176; cv=none; b=OIuncTA24kAMljHTxWfA0BAfUHKl6ezYZ+Wl+vHkgMbl7vihCgBgwdM4VDR7+72YRZSm5xRCKeapAg9wPQ0QnYgLgbz1SjhkD0B7oVHVakcs4g/bCj6yBLxv2VORBdiau9rTPLa8VveSaUm5f+uh6UMR5joZf6RufSC43UxzngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773055176; c=relaxed/simple;
	bh=AejVh39OfouTSd2iF1xalh+o1wTJiUiMTTrorUnm0v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDHsAx7PU2pGqgx2YdaaPkuA4+sGrYkri3n7VMivoUwmHilWPuGAexUWTN8MlJ2mVUCbQtxTCzlCJjRM7P94u6MJafanr65uUA+sLg5sK7GacuaOhWqdzZJ+ja0Ch4V1ni+pszvXE+gyML70K4gGbKXJ1KIVDewLeWZl1qAIUc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IpI6JDD0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iCwej5Uz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6296HEZH1888903
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 11:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aBuXrT3z0syHkRjP3iylAVgo
	7EGbnv7gdiOgzGuaCiU=; b=IpI6JDD0HWnBmmlj0OFHN8/gFzwsaR6GGIPaSRWZ
	iFf/DH7u4vd7h1Ql6MNsSNVW9oPR5VFW70oJAOTynQa/kotTy97vXA0zLfU6dzvA
	uNntI343AApVrwilF4Ccnldt+LK7L50ujgLUmwLSHh8Zw6kc69JCAMGvA05QoRPE
	9O4dpQc5tRl5IG1keLHk0u4cwJIhRoOu4w361lkUDa5Q2QOyO9hNNQvNH43cn8he
	7kk5Yw7SulMX0XAPaDCMv1J1DuARQsDGemPZ4pfuNOCdlEnEvGJDhSE+ExzyMWep
	mCjRxW8ZWiSYWgw7VY+HBiZ9DBPabub841Zlzj4UETzIkA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crc83d4nh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 11:19:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2adef9d486bso102877135ad.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 04:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773055174; x=1773659974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aBuXrT3z0syHkRjP3iylAVgo7EGbnv7gdiOgzGuaCiU=;
        b=iCwej5Uzc2W4ofJrtmyHnVECx2FD7lPG6JGRf7wfG0dhkC5dV+Z2Yi5KObS1WaBznz
         TIR0hH1nH86TzI+mtyU6g2MWn25cQDlYrHz5fT0hLcA1e6P3fbPAu0QW9G+D6XE+In9E
         caOr9Zlhv1894g5WJElGyv1rHAKyG06NZrUSIoDgLK9+j4hYpmaZnT3QuKNf7lu9kb/8
         rW8rAD9v9qZ+6ouDQEFLAtinT65oha7X1XIOgMW5Br/rT+G21o3aF1EViUo4Yuu/jF3B
         3wFF0anzf38whn0dWUjsTIWQRv9Bno4xGuZZ2iXUV8TWZTegFWfeJu5y9DcROpV6G5tK
         Fu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773055174; x=1773659974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBuXrT3z0syHkRjP3iylAVgo7EGbnv7gdiOgzGuaCiU=;
        b=fC1WqOqAmEX2HDf4pHqkl4oXIzJWpCF3zht5Vn9b/0XmAwH88enuwpXqpL4hLHNd7w
         Xf2H3GMQFa/rydv4wb/t1DZTD7I+r+DxmLyDqASGh6ly2RWcTX8a6sI+IsEFwdP1Ps5n
         7T+eD5QAoZQhL1oBCMJxeKAuOoNueRCM2u/yOu2dtXjV/AmJZcdtrYrKmNJyC/eiZZVl
         3fG40LHzxdz9IfJPvfSCk3hqo5RJSQj3RAlkMczKJp1Rd3b8Zxu7DD8127NXPl1M9ozT
         ezaby0eRiR5aY/D039WTZrEiWdB2oml9Ec4TtDlyxUxAbl2mH9FJJT8Y4gJUmSf5Zn+x
         H+dg==
X-Forwarded-Encrypted: i=1; AJvYcCXaEA3UbUWAXxLMoGKS//WX3WPHV/7AFdljAo+txGrDCI+h80tW0O5ebioamcSwgLbNmm2VR48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2vgH5NuXUSJI7cjgauafg8sFvJDsgrhxGxzthJh0bK6niyY4k
	d01wSxL9CWWzhTca7HXWWH40KpMmsmNJ3QLFXZ01f/9u6SEYoetXUDtzCWDg77BI0SCPZ3zAuuj
	KX2utkTDD0bw8+jKoXMTuZ+XuKrrihxnlGW7eu9TmqgQ5KNDhX6JZJ0yGvd4=
X-Gm-Gg: ATEYQzxTnYciX44CdqtN2b4JDdtjvmJsSKH6ZFqXVxNMnK9bLq/qyIsNsOKNjizXi0y
	aHbPNB77KTDc5eWybAQSPl7YjUjaNCOLvbwc4qASpQet6dwT/OhGH763iPbxxiclilzH+qd+jiz
	yBHK9mOKptWGpME3PPpTG4TH9wTTwhnB9DZqkV0TQa0DuEDX1jcS0afusS+H/s33O/KOuQTTq6n
	hI2Gmvu4+qbABguwF6+rFlHKEKJXNAPPsUz6c8VysGm6p+DvUHtfY8TxFjE2K80vFVqTGPEoKpj
	8XhYc1G5Ax4un0jmeMOsTesvwFKHzLz/8BC9gZpXpYFRwphsMw1OfgsvBq8cuKBFpafa4mBsB0e
	Azdhq0WPQj/e02PESThmys3yFDzD6sFzvaos=
X-Received: by 2002:a17:902:f64e:b0:2ae:5fc0:308f with SMTP id d9443c01a7336-2ae825056cemr110474465ad.41.1773055174157;
        Mon, 09 Mar 2026 04:19:34 -0700 (PDT)
X-Received: by 2002:a17:902:f64e:b0:2ae:5fc0:308f with SMTP id d9443c01a7336-2ae825056cemr110474115ad.41.1773055173696;
        Mon, 09 Mar 2026 04:19:33 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840b2e9dsm150127135ad.85.2026.03.09.04.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:19:33 -0700 (PDT)
Date: Mon, 9 Mar 2026 16:49:23 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Frank Li <Frank.Li@nxp.com>,
        imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        Jan Petrous <jan.petrous@oss.nxp.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>, s32@nxp.com,
        Samuel Holland <samuel@sholland.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH net-next v2 4/7] net: stmmac: use u8 for ?x_queues_to_use
 and number_?x_queues
Message-ID: <aa6su45ASA4jR2VJ@oss.qualcomm.com>
References: <aa6VEsmBK-S9eNYU@shell.armlinux.org.uk>
 <E1vzX5K-0000000CVsE-0J0Y@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vzX5K-0000000CVsE-0J0Y@rmk-PC.armlinux.org.uk>
X-Authority-Analysis: v=2.4 cv=R9UO2NRX c=1 sm=1 tr=0 ts=69aeacc6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=2l7Dc_Zt4Q8SQ2GGjncA:9 a=CjuIK1q_8ugA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEwNCBTYWx0ZWRfX147Pn6opWMGJ
 gAPuAfoCphkB2S5do2yw4SdsVXP7YvyScOpqKLD8e1vZuZBLsb2xXGB9o/qHDdJHqaZHNk7UlJN
 F8bLJZKfbekeu/Xqwpglh/P9OHOB8E8EnyU7/XIaj4EKmDlGrpSCKgyYETRC6hXfLFNfj5PzZph
 MM+y1ZuW21a/WJHgF917lJS2E3ObJ6b+mn53QgfeVJ16PfLyz+j4bhU7nUnrTVn6NY76oUGIRi4
 G1T8yKKXUq6GrYDPd+Tym7V0+j2nQuEjssMs/pbFYrjDW4a0wfQ/XiaCCiV8o2EiyXGfIVMIFww
 HHTmmfnTa5uta5cVG93GcgkP7z/jb+OM5xkRAFF+KjM9qScA7xwHM9zXHpFbeD5EXZDYgrShh84
 txdBlRAs0FyFVdzsaRQtdiuHDVh9Cvm72GfsR1R+gD5VMZHdwe2OBgzSiKyRFZxTd3h9KAtmBuB
 l7Ihc/kTAdvcGfMTjjA==
X-Proofpoint-ORIG-GUID: a2KTy2Ucam1xlXvKZgvPGdEQWb2MZwzi
X-Proofpoint-GUID: a2KTy2Ucam1xlXvKZgvPGdEQWb2MZwzi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090104
X-Rspamd-Queue-Id: 0145E237E39
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265485-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:39:34AM +0000, Russell King (Oracle) wrote:
> The maximum number of queues is a compile time constant of only eight.
> This makes using a 32-bit quantity wastefulf. Instead, use u8 for
> these and their associated variables.
> 
> When reading the DT properties, saturdate at U8_MAX. Provided the core
Nit: saturate?

	Ayaan

