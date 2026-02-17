Return-Path: <netdev+bounces-259130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHdXEhq2lGlbGgIAu9opvQ
	(envelope-from <netdev+bounces-259130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:40:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E9E14F430
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53F17300D46E
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23DA32B9BE;
	Tue, 17 Feb 2026 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JOqpjRYu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U/2n1GjM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F6A2673A5
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353623; cv=none; b=DalxgvlKrt4hnv8tgNOtlStFK8iG5L7s273f4DMiCslSvYlKXyTUX5+BkUI25EqwT+QKybdhDaGlx8VB0CgZb94Ra7Nr3naPsqNJoCjDtsNfeg34ta/PjE3s5lc4JDba+EPqRXTpeAIgka6EgKDsTjCJtlbgp6kP7HrmZg3bJv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353623; c=relaxed/simple;
	bh=gL7vi8XaDsR6AJUOsYywCadvZLRWfiPCMGRL+niCQ0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBiygTuWStJ/s7zWuDhm6S0WvosT3Zcydke/Y5Di4nNwnLkAgszAJbvEwz7LfgTJtE7mlgL/AG8R9kztp5Y8C8k0Gs8+jIwNp4dGvwq7uG+C+5Ry1c1ThRv5M2+LxykbxSwKTiGYjLS4tZuYBksWWP6ie9XAuP5my9Djl1jo/hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JOqpjRYu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U/2n1GjM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HGl8a3297136
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4eqYZw+qW466/zd9o0hZO+Wr
	bSIyZjH1x8DDDr0yC84=; b=JOqpjRYupn9Fjgx6aUFYuSq+vqZrEJFB2W4Spezz
	aaDKrAUMKpj14T1ZnKXaGfIOTd50gSSYLFNaayjCIu8h+Io4msOmYBioT6cth/PS
	+IA8j2gt+eG1CVUxqloETCK6/njQZ6CEraP4BXqF+vjbp2kCm5thAOSuOTz68j5R
	ZFgTam9zOQR6DhCgOp/GruFXMeVTGG7NzsA+XtMmrfvM+/Qnwlv572y2zyEhNZst
	H8B8N9SGwgLLH14/wzcjVK4g52PIEc7SZWX1l8m7NrfqSN6VKftAGXkP23pmqy1e
	4e9vR0BdxdkhL5ZB12damwFeE4YLYzUePkKd13oH2Cn7MQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6a9uhsd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:40:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a79164b686so59413465ad.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 10:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771353621; x=1771958421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4eqYZw+qW466/zd9o0hZO+WrbSIyZjH1x8DDDr0yC84=;
        b=U/2n1GjMshM0LEh/yyiJlEQ2+ub375lthLxCdIuDc7bBxr+29IHDvZtT6/SKVrX2pU
         p4fvz2IYUL9d3wZ31A7Dqw7JAf3t5LLoUut+n8WFw+mz0gl8DhVZJGMZFmhEsvzBQuqJ
         MPtPVnsH0I69JqiazmcsaZtnxoUgYmg4v27ABEzxpRwFknrWghOINRCjEe6RUoxsDmxm
         b8/88/oQfTqUIRO2XMqpRHTcE36ZP6WlkGsTaxjLGcGDPNQmrTqwrTKvUn1CP6MiA1he
         hdHF1X8J2TzOY1yY82CvKsJ+q5S5Pdo16tGcXR32+IZRYMuuVtx02KF+KNwyOQc7LYQO
         mYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771353621; x=1771958421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eqYZw+qW466/zd9o0hZO+WrbSIyZjH1x8DDDr0yC84=;
        b=NaiDgWXmLusUbncdScdn5569bA6cz6L0j3U42pRv6oXZFbCOq9zW0iWRgsghKuUUtC
         OLZ6H7e6NZErl1SG7GSHZsVjbWBIOWGabyJBH22WIC0mIH/+Ojy9VHkPeQZkhvKsEYlQ
         TJqQW6B8xoYlDH/cNKVavGbaxg2psmvq4bTZM5lHJbbxPJRCSQrHDz2hAw+Uln8O5fIM
         hTmEp/x7fEzzVYzhwvHM6UuovCKi88aSDCPP6XWATgc9QF5hZx8WHe74qQJPVJsavujZ
         q+KSZI+e6xqzs2BmkX1TdNyU5AMzI9QFJv4REVV6ha3HCxNw8k5Nsl7sUdl/pGfvOhBS
         We3A==
X-Forwarded-Encrypted: i=1; AJvYcCVenBS9OSA/hOhXP5l7mpopPCK7MJC6ZwIFA3GAhMnpha9UoVrbhUaZ3vi/xXzoaVNwC8LFiN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEa0cLGn9gwG71SNKjTpwDeNzifv39f8xdb7+26L55xBy1B8mi
	awAKGr35YcHPSiQtJo9hGeYFQ5ewQ7IuKQey2GYxArNR+eXnE8mReNoXk6sWiT8w0UejGuRtRQg
	ONufWXMtJN9uHBe06HB+I9Hu4HtGKCQGEt/Q6gPryyKsdG3QQdzm3zn9y0Oc=
X-Gm-Gg: AZuq6aK0IFOlfxR8c+Q06vLf2gdZGRv6mtVOBd6eSbRekS86zoXxauoZeFAE14yLemd
	y2obB3c0R5KCWebtMHpALeu+blTIIS6BkWNzRYCupMiPkCkQsGFs/qCLe/Rx6/+89Nb/z/JN/AM
	HgzZS7fBP2MkIcdTj5DRyi3b3+iiH7Ug46haK07ET4LxFVAaCIQzlBCd+3wruS82gRSMfdSXfDj
	C0Fq15lZu/pxdspaChYgkovVOvVYEpA4jTeC7TBnqDIlpEfmmB2MKrbsPhePoroDHqmE3GOwDb0
	xPYXSQaeETglv19Cdup0kW0BUbD5gF2zUbuTOnsnVUo56r8wPRqGlcEZD+ZcAMf7EjDEZTC+IUW
	l8akFeX6wgUaeHfKLGKhZpORVoE8pJXkxwqc=
X-Received: by 2002:a17:902:c947:b0:29e:bf76:2d91 with SMTP id d9443c01a7336-2ab505a365cmr131982415ad.42.1771353620407;
        Tue, 17 Feb 2026 10:40:20 -0800 (PST)
X-Received: by 2002:a17:902:c947:b0:29e:bf76:2d91 with SMTP id d9443c01a7336-2ab505a365cmr131982185ad.42.1771353619915;
        Tue, 17 Feb 2026 10:40:19 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad416ee045sm30863535ad.90.2026.02.17.10.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 10:40:19 -0800 (PST)
Date: Wed, 18 Feb 2026 00:10:12 +0530
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
Subject: Re: [PATCH RFC net-next 8/9] net: stmmac: qcom-ethqos: use phy
 interface mode for inband
Message-ID: <aZS2DAd9KQYHML+U@oss.qualcomm.com>
References: <aY0aJppQWUC52OUq@shell.armlinux.org.uk>
 <E1vqKPV-000000093mr-3iT0@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vqKPV-000000093mr-3iT0@rmk-PC.armlinux.org.uk>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE1MiBTYWx0ZWRfX7W8hLh5lTO/c
 ngbAsyzUI/pBSy9IqTY/+QCUzRz62jS75cK34k34WUTvsD4mfKAXAPxfX5CGHSOye0SOsJkQPjk
 7Wo7ngDDky/YF2+LUpLN2EvK2gQBgus79S4/KudpwONSz056t4LlvT/6O5fdIdkbkCgL8TvMjRY
 EDF1wwgJEr00Z2oMGy2ekQvDmZW4d5CysTxlslrT9YjezcTIVX8SrFt9ShOurjjMgkc2rZ966EG
 nzMP/dZvRD1CktfhzKgCmuFZkXOWCd5gPQ6aJBMqNOTYo/O6ONDfwisMOqwcua1tY4wr+C6L94l
 w1CCTvm0ET+x3lrVc6yBB2MqPqxSKxQJx+IFqJ1gtwlYysE5vDqghW+JcMDpc3Kq+NpxcwyXLrL
 WfQXfeH4LjOuPqiIGfB4tM1Ljhm0cmvF9xcjD2HXw2jF+3YP21YvLiaM3c76Zzl4UElLGVyCbQa
 LRq7ugZmfa3xJ0aIBKg==
X-Proofpoint-GUID: QHbYAsh453GFQDt4xr80Vj0-GcxPKdUy
X-Proofpoint-ORIG-GUID: QHbYAsh453GFQDt4xr80Vj0-GcxPKdUy
X-Authority-Analysis: v=2.4 cv=TPNIilla c=1 sm=1 tr=0 ts=6994b615 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=PHq6YzTAAAAA:8 a=EUspDBNiAAAA:8 a=z4Hhns87Kg07ZqANAhsA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170152
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259130-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: A1E9E14F430
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 12:18:21AM +0000, Russell King (Oracle) wrote:
> qcom-ethqos currently forces inband to be enabled for the Cisco SGMII
> speeds (1G, 100M and 10M) but not for 2500BASE-X (2.5G).
> 
> Rather than using the speed to determine the forced inband state, use
> phylink's PHY interface mode which will switch between SGMII for the
> 10M, 100M and 1G speeds, and 2500BASE-X for 2.5G.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan

