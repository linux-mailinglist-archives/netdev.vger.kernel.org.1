Return-Path: <netdev+bounces-253834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICvTBFCqeGl9rwEAu9opvQ
	(envelope-from <netdev+bounces-253834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:06:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9329F9402C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF4CA301AA85
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121A731062C;
	Tue, 27 Jan 2026 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SFCOd1M4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EiRfrtl5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1152BDC0C
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769515583; cv=none; b=gU8aFE1d5wB37+ty5uDZxKexidoB6l7GLEwe9A9amjProNnDwm8WhurB7CqqORjcq+BxFBI/8K22mW6WvBzSo7EsaYfp+YB53UJNYQ8F/UbPkEJZq7TLFu0YIjR/+b7d6x3ekzHOO/btqSGscmaTF2WXp5hM4cJvCd1vWo6SvfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769515583; c=relaxed/simple;
	bh=HcPqe8fhDNEKoQCDbQZQovvUA+6ZWNZxYiaDEP1JdGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oul1wIwKM/wNVw3sP0W1k9Cq/WfbsdjpbGbgXP3qHtDdgu1z6ejYIIxAcTeaug+Sw1eUWg1jNhz4AQt6rGhd7vsqtFkbBfNP0zQr4Pqvfn5ML0BDjVi3Pu40QhpaM64UfL/Rn0YcZftavyH9I9I7+D6cEVorLv0i21uIJrmXdWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SFCOd1M4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EiRfrtl5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R87A06621762
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 12:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oJmDDECkW3iXsL3g4I3qEOxh
	a59jVBDs+hiTdIwu23k=; b=SFCOd1M44pt3IzqJIWZy8H8I/QoiF7NXN0rgT0ia
	B19mlTG+dl4OUrVUz+NXmZkqvKzSH2Fy3/oQD+kZqHrZnwT/VkWrDinTkbzmE9N4
	YN/6CH3qZXc7sLY6wDnxZMMpwUbpoQOXpE0OJJ0mQIgoYkVavb9Ro6QrJhqTa8/f
	BtArQZVv9m3PyvBX9f7eu7HNoyjTIkDkjvxpexz8b61aHAmo2eufC1MIrq9/1mDB
	+fR1BvhXvb/Q2Q6Sa1IKodpPpKIjNik88CcAuBXTSBkKa+zINxdheG7EgkxMWIGo
	Yvlttka2K2gQdZXxgdXi/wn6Lf75pJ+xV3BjyoVHuJNj4Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxsjegr2h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 12:06:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-352e1a8603bso5769936a91.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 04:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769515579; x=1770120379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oJmDDECkW3iXsL3g4I3qEOxha59jVBDs+hiTdIwu23k=;
        b=EiRfrtl5Ml6gcLACJdshtgLW1MLG8jQ1apBosL3LgX6RF/aP2dbqh1khyxktz8Gmfa
         M0qXTUYl5JPoO4iOrQ+owa++e+YLm9OVmBgqMWXmxI8CouH7bE1PYgExcek0WCGWNNJ2
         VWUULeyB9eRQKJ8kD70yNIVen6XFdB/h1fssjshAOfGp1vjne4bkQc2he+//hl2oRJsm
         xOKHaQi2AMkdEpcMiZTSzZDpBYuMH6xoNlJGYN2nIi0vmtxibeyDAvY0EgYc/mmeIPOT
         ea43QmXFLpFcC4BhSp1W4j0RNgOPP1SJoZmmesK1E1psJaJJHDES/bjzlVX+T1UeG509
         IZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769515579; x=1770120379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJmDDECkW3iXsL3g4I3qEOxha59jVBDs+hiTdIwu23k=;
        b=BCUDDTlXp6jVdOHqDfU5pRE8qocL/77E95oxVZAY7nc5gJBNSI1N1h9z9TKoaeUPjo
         hNdEvDLCSewNi+grJPuKO25J2l8+BuSmj7L0yWZwSFPsUiR7+LlpKpXYaG9B6xIyhSnO
         DCY6G0q9mz+udWN/v0Dd7LvTNuA9+wlXBnLbRbgFCGXrhmJnB8dBORLCeTmb13PR3j2Z
         QtQRhDIdyDP0lK1m8H6N3IOFnCmVAlZ1CVpxLZc9vRYS2c8UuNwN0ALGHYvTMSi5ky8u
         B6RvXvaXlh6/drI/7GO5dWazjGZ444ygl7PKJOSV/R9PG/OfokTJXZoVmu/HaO05Zjgh
         PKfA==
X-Forwarded-Encrypted: i=1; AJvYcCU1jZAZKc9Jx/Cf2Xdwnlfmm12g3i74Zn7zGoyikE3n9gTB0IrFNHWVkiqpzeyMGItx2TLQV/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE27/tJf00jCxZLS+uUfsEJ5448K1Mr0UQhU5xWdvixmcjZo1m
	jRUZlWbIt8PLbFJgMse5wd8inK6y3DZSmPxs23npLv/9pt4g9DIvSXTCMYflnP3hkuTExxUq8tf
	aQsktkMBl2cRdFeWkjq2osAEqvc/0gH270IHdYw7AvZdZNn6jsWapruxZSGY=
X-Gm-Gg: AZuq6aK0uVaqPvYFk1Jm9aXCdl/i5smo78asUJHprf/h3hs/MVRrFXHuKv8GEQD1CIO
	nverF5DlwarHIXXlZdufs3eLZxBswEsHikjAyyVtpoLs+qabZRSJ8DHhXYtkJiB9v/HatDRqu+N
	O4w8GMH7yswC3o19abJ5oP7BBBJtzQSgENhKGWKMLHmmo+A7M0lKcONB8dH1GtqBO5yBDLtXrRg
	Z7i2VjaZtZMSN+loRdb2U4bbn5VG98ga3cDbeANkWTwphoqEqbwPHUYxxZ8r+n3xx8jSrpfFr0l
	/mwLk7hY+7b9vgAoXG7h3Om5oWU+2eHhYpUKBz3PX2ncrNbXGho6K8MXavWlvTkMPHqrZu4rGHa
	fYaY4INEexjMTdoLnrjm4LK4=
X-Received: by 2002:a17:90b:2dc9:b0:341:6164:c27d with SMTP id 98e67ed59e1d1-353fecc66admr1463650a91.3.1769515578703;
        Tue, 27 Jan 2026 04:06:18 -0800 (PST)
X-Received: by 2002:a17:90b:2dc9:b0:341:6164:c27d with SMTP id 98e67ed59e1d1-353fecc66admr1463627a91.3.1769515578192;
        Tue, 27 Jan 2026 04:06:18 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61292bdsm2411832a91.6.2026.01.27.04.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 04:06:17 -0800 (PST)
Date: Tue, 27 Jan 2026 17:36:11 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next v2 01/14] net: stmmac: qcom-ethqos: remove
 mac_base
Message-ID: <aXiqM+rYK/QCy6DW@oss.qualcomm.com>
References: <aXNEwBW3OA1xLEUj@shell.armlinux.org.uk>
 <E1vjDr1-00000005fQ3-2rcn@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vjDr1-00000005fQ3-2rcn@rmk-PC.armlinux.org.uk>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA5OCBTYWx0ZWRfX+Wu6ZekypTCm
 KqdU2Pob5DIe/G17iIUOmbSFzoI9lV44isna5d9uvrVntRUBqGvcqjN9QOCp+Rh70BRKlQxq98R
 XGqGmM8YnHaTRbDdDzTKtvd6f1Bw7q5kz3l2ZI7v+LrXM8FMQAwu/1WHZRCMqvvr4jt5ZXjspzr
 I3McTFvKDxwHfSdoFgh6AW5cyAaBlfcIkX9/xXcEmJSqDCFHnJzYj/he6+P5qZfNNfCi/mIY6mr
 zMn/LwfF1L/WI3OZCzBLlNxizwmhNxNVqxcTuAccL+PaRFAi2T5xVwqtHA3VIYE900hIA0BdfTB
 J3IzELjb7wXgA1irrnPy1X36lqmbeQoZptCCxOip18CTqE0mMOjqg2BVlrG52wXbdt6XBpIbe2Z
 F/BDkln1A4GM9AoSa8FdqDIAQEk2yR3zkulDUSBwoVDyAiKtLmBOV31ClRLF2GAdN+N5/hkL05U
 kwKyNu5xK7z6x+mtG1Q==
X-Authority-Analysis: v=2.4 cv=Qelrf8bv c=1 sm=1 tr=0 ts=6978aa3b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=PHq6YzTAAAAA:8 a=EUspDBNiAAAA:8
 a=2f8CEio2oMm2juszzV8A:9 a=CjuIK1q_8ugA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-ORIG-GUID: GiaMp2nUR5cUqV4r_eG7R2Xd9xadGghf
X-Proofpoint-GUID: GiaMp2nUR5cUqV4r_eG7R2Xd9xadGghf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270098
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,foss.st.com,davemloft.net,google.com,kernel.org,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,bootlin.com,linaro.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-253834-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9329F9402C
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 09:53:23AM +0000, Russell King (Oracle) wrote:
> In commit 9b443e58a896 ("net: stmmac: qcom-ethqos: remove MAC_CTRL_REG
> modification"), ethqos->mac_base is only written, never read. Let's
> remove it.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 0826a7bd32ff..869f924f3cde 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -100,7 +100,6 @@ struct ethqos_emac_driver_data {
>  struct qcom_ethqos {
>  	struct platform_device *pdev;
>  	void __iomem *rgmii_base;
> -	void __iomem *mac_base;
>  	int (*configure_func)(struct qcom_ethqos *ethqos, int speed);
>  
>  	unsigned int link_clk_rate;
> @@ -772,8 +771,6 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(ethqos->rgmii_base),
>  				     "Failed to map rgmii resource\n");
>  
> -	ethqos->mac_base = stmmac_res.addr;
> -
>  	data = of_device_get_match_data(dev);
>  	ethqos->por = data->por;
>  	ethqos->num_por = data->num_por;
> -- 
> 2.47.3
> 

Validated this patch on the QCS9100 Ride R3 board, so:

Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

