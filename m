Return-Path: <netdev+bounces-259131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIvVODK2lGlMHQIAu9opvQ
	(envelope-from <netdev+bounces-259131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:40:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE5314F44E
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1EDC300463B
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04B7372B2B;
	Tue, 17 Feb 2026 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Icz67uQZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YIA2EciH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3BE29B8DB
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353648; cv=none; b=qtE5e2Uea6Fxdh5zcg9pNorQzk7sBrNEZgkNNfqL4gH+AkAUSXAqqXGhXQTeY0mmjGcO5VqPrxz5UNW4ll/tgQUppzGsmbjn8SmdUYQ3u4hmq7oV/ZASCCL4GYqzaOx9ZBVtCzr3qkjwtfwYWqTtIoWjh2U61rrVkaZhbDTcJg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353648; c=relaxed/simple;
	bh=UvUFl9FDfuFUB4napow20tV4rDiY5o+TzrXHGXuIR6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/AAutvefsAcNnYKClL76UDHcelb8+F319ympa+GoPQNM91FvmGH3O5UhKNRdTyuL4MvQbzfzG28ArE4DgYd+5eHFg5KnEH5YCjsFXLYhrlDNSgzpKJ2+vK9q3he/l2wAjBrxa/Bd4BVjU7xH9ZFEYNv3pnHtiGOn/4Dij3w+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Icz67uQZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YIA2EciH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HGJmux048833
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4QQfKD8GVBA2aksYDATKy5SS
	tCQ8N0yPkSM4M0vZP0w=; b=Icz67uQZ1w168zYFAvuoeuarGF2Bn3D6hMvtUWNg
	zmTKVF3NpQStoRjg8WUb7wjYfAQI5z2BZMpvLmLpEHs1E/Q20DbCNoBEhR0sPTax
	ze9EMQknHWmfvSyf1zda+OpzVx3KY6WCHtjl3l49nAeUzR3SgiMQoLZ576nPQ7EM
	t8kwiF7RCCl7lVzF4qpCXw+Amz+clkZmYoyLKpnbDKt1g37NcoQZX3LHu1jSk2Wz
	vk6jCWqZOgYLKWYjC6TS6Pyd8lITbPGK+9Sx6zJ21h+l0ZHxpWH2CZI9CwcXIDez
	ETlIK2eD9FTSwSqfXkJxZtqsXnZHIrX1cxmgGtH9aarCjg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6d83jck-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:40:46 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-824b461dc9dso10366272b3a.1
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 10:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771353646; x=1771958446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4QQfKD8GVBA2aksYDATKy5SStCQ8N0yPkSM4M0vZP0w=;
        b=YIA2EciH8tp+5eh1G04JQC6qQ9ltlaSRQawu6vdxDcf00S2RKzQsW5paGG8zyLiPCi
         G5aajD16Lhrbi4RmWg2xlFH6lCKIMutts5AogLvFfSb/xXdPlAIXWVQjOro3ZkKW79v/
         1aeb8n8CIlgAuOsSsHSPqqrvzgstquMB+tQ70Uvo25ZdZagUsSh1kiZqq/jMwVhGd6Ey
         Y7XHeCy2svE1Zo6THjXv4tOaNqrdDMBeFQqGpYpQbHzfWwN3QKdY/iUD0KidDEXaL0tR
         7ghBDUYKMvt4qkbA4f+4UunCdvCW/GE3GQffZa/s7xeNU8GUTzle5v+khdLB00kirPFt
         NU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771353646; x=1771958446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QQfKD8GVBA2aksYDATKy5SStCQ8N0yPkSM4M0vZP0w=;
        b=sHGwPfQiAg4tAPeCGARHHpsueITwp5g5ztRX+1SlUCLSvYv6ziqrVxXJFisJPMdk13
         +8gUQjGN+fhrR5sO86GE1u8GXGPIXOBFL3WNN++kJrwUtGtGhGFoeuwqoayZVIuZSDEr
         A1DrvqNUOQ2tFehgMMbhTyCxc7FJ6+lNQY9z59dBRu+zJp3im3rePG81Htse11q0GzQ/
         p5iuuXdTbhzt+P4627kNqNY1exbtwNdhgoFCZKKNgRP2BmMACTLgFmje3T96g+4pVrsT
         PJvszTpSN75mRti6b8gkM+yM4q9/+PQgEwxiC1jK/DiSXMXg1D6abdM/Am1vwoF/NwRa
         LGzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEi9/Lx/sOXyqpUsIwK3StWU13JzO15xRppYtA3MkwUsJIaxRbnYwryW1GE3ltbjaL8BNsCo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTuK7/grveUZuwdtvx+tgMYD+WuX8UniC5/hLzl3jWmNYm8RWt
	VL4VMu8/1Yuk4k+PvR5mMrWa0Grq9jz6Io0VV/C4jvRTiojlczJ57t5qGvzdkSYHxzTrOKBkEh/
	XNfSsqFwiF4N+GfWYAb3TtPq1LE5vra+MMr1N/C0UnHf/ViEuioLGIItbIJc=
X-Gm-Gg: AZuq6aIMrRJ3asFOp3u5850rCBauXte8fJ2wWkpPVLHYDor7kw+S696MseDcJaW/Z7S
	ESunQ4l53kH4+al5jBr9QSVcCTV6mlk+zgFAvX6HHch5G8PfqdnZTl5dClBhlDbeKhdSfSfIEPy
	bgkawtRCvCyj1JkkP182ktB1zxE/cdwx0ftqsh8F7Rhtmqq7AB8mXOKnYRhjOFGqJfI+UeKIJn3
	tyIWOcmUzqg9YmdcA6zTZ6qnIouHM0wL2EAOgV3MzO//zpIJASs0TFskqrHtnmSIUUBiMafltm4
	OKeQo8D8aMS6y1HU3zPPXzoD8SnDCYYi2yGsivkK5Bn6Gn5s4yyRf6Sj9S/CCDMy2+db4nYdLd8
	MnFs/pITXs44FrEX9EeOEFXpj6d4jk9YbBNc=
X-Received: by 2002:a05:6a00:2395:b0:823:998:95b0 with SMTP id d2e1a72fcca58-824c6102044mr12985347b3a.35.1771353646324;
        Tue, 17 Feb 2026 10:40:46 -0800 (PST)
X-Received: by 2002:a05:6a00:2395:b0:823:998:95b0 with SMTP id d2e1a72fcca58-824c6102044mr12985319b3a.35.1771353645747;
        Tue, 17 Feb 2026 10:40:45 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b9a0c3sm14187532b3a.51.2026.02.17.10.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 10:40:45 -0800 (PST)
Date: Wed, 18 Feb 2026 00:10:38 +0530
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
Subject: Re: [PATCH RFC net-next 9/9] net: stmmac: qcom-ethqos: move SerDes
 speed configuration
Message-ID: <aZS2JpQAO8z2xej1@oss.qualcomm.com>
References: <aY0aJppQWUC52OUq@shell.armlinux.org.uk>
 <E1vqKPb-000000093mx-00Jj@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vqKPb-000000093mx-00Jj@rmk-PC.armlinux.org.uk>
X-Authority-Analysis: v=2.4 cv=bqVBxUai c=1 sm=1 tr=0 ts=6994b62f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=PHq6YzTAAAAA:8 a=EUspDBNiAAAA:8 a=K0zUmU2yKo6XzqUEZrMA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE1MiBTYWx0ZWRfX166CZe/0gx61
 GYgv7PWi28uYPuhI8Xl0sv55e8N07u2HXHNfxehCQbEq8nbxGmMwxP6SIE6tRS4GXYwlLuQmcC3
 F5HYM8SyzVwPAHLQh0d2VUNc38mBIRO0jWIoz+KOJGz827U0qbEl6zjybVvoXphk88LI0f9Dp73
 B/SaxVZBFXanqkhxYHJt0ZBIgC5uT4M+1lq5MAFpy+C6U3NpCw0gpxUeRUgPySpAx04UQCmeaaI
 gq2dtmttv6C+mnOctsD158taqykHwHVX2/AJe37tiFROmNE9/iY673dTPduEYkwYwY7OLRH2LRN
 31UJnf/CSuc7hI77SihlKnaUi+CHLuU85NTsJ6Ia9xHCpIGi6POQ8L51wrvk2ELyrH9zi80qanT
 d10EC1BCQzQlk1Z4lDZ0aCm0ys50kN6NW8uoMuBAuw+5xMxKtPZuM4xkNiPC/MB+7ywcjMrpApT
 jx2WqYY0wXFSeeis6yw==
X-Proofpoint-GUID: Yp5s4a1Pp9fH332dId-vAIv_6UdjzDxc
X-Proofpoint-ORIG-GUID: Yp5s4a1Pp9fH332dId-vAIv_6UdjzDxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170152
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259131-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 7FE5314F44E
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 12:18:27AM +0000, Russell King (Oracle) wrote:
> Move the SerDes speed configuration to phylink's .mac_finish() stage
> so that the SerDes is appropriately configured for the interface mode
> prior to the link coming up.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan

