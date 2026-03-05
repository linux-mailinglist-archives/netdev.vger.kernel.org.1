Return-Path: <netdev+bounces-264524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKDQHuLeqWm4GgEAu9opvQ
	(envelope-from <netdev+bounces-264524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 20:52:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD781217CD4
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 20:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E9AD305184B
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 19:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE65637AA95;
	Thu,  5 Mar 2026 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HWRqKTXJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kp1gEQtb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F942877DA
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740117; cv=none; b=Gfs9ChpFrhimFiHyzAsoUb1BH4iHk05TxWneBtM7yC/a4QVySHgEpe2AlpgZFseStjOjsdNG+HFVYFaulCMM5exyLcbHIPWC2A/5oSGYzC6ZSwdrLyvmQ/ZRlyeF7JqVKb0UABFy8EcNePnG/2CVFlyQg/AuNUihMW4Kdfhk0mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740117; c=relaxed/simple;
	bh=dmLrtFAAtyuGaXYoY+v78OgY9Wdehxq7Jj44ExPzdfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRRhKelJwlg6FuFlA2aMjRcI/QPcAo46vaUTrPZ2xiEduMR5FiDtOauxiU3OMI2Cmi0o5VWcGp+5ue68FDAAEYQrZfGrT0xvjWIli32mqD7T61FsxjjyDN9AKf0dghk8HdOBTkTAypNZtnGqXMxySYzV8DtaYjd3DdcY284i/ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HWRqKTXJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kp1gEQtb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625H2BNF2986298
	for <netdev@vger.kernel.org>; Thu, 5 Mar 2026 19:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=brQJvLzGSg1FNHbunEnKNL87
	CiKohImsgvm9vmEVnZc=; b=HWRqKTXJDv9CRYuHW6AkxIrJUi7AT0CwdvxIMPMZ
	yAhmVgLfj0z5w+OFNPRT0xQisHx8Yt3UK/+vQxGxX5KP0P7CzKR7LFaCi/rUII9E
	9pgY+Av8R1//h3p6JXQZj+ry8vPl946OxRAVDnma8KigEffmCR1PpKOuMqu1T28p
	PDg1SVQxMnlvDrEdfw3p/0bXfrH9+XV18D9NCZnVbdDjMqzfBfx0JOOtMfYUYNd+
	as/StFXtjiEoONus6618GPgkciGX4LRf1N72Ec4j5X62GOxVZeGIPef4w3N1Vffs
	I0UYBAAOnW8v1wuRjJhwoVBQnLipRjXuOisw+AGegYL+hg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqdvkrkwq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 19:48:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae50463c39so49019965ad.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 11:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772740114; x=1773344914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=brQJvLzGSg1FNHbunEnKNL87CiKohImsgvm9vmEVnZc=;
        b=Kp1gEQtbNfoE4exkw/RlCDH1bgc+0+oerboBGEADE+Sa2ckqURB9r6bo4KkFKNwGQu
         nb7exj9XKWhPy5ztwf2oglwR4/aVFu/9FGw1llJYBfHCShNiAcdAdYp040QdM3EfaWFU
         QE7PwL5Zo6rmLJgUaLjbZWrBaVCo80YuQ4kDBh8Xa1b4nz+xy+psFw+AvX1ks6rBJOQM
         REEWCYFfuFargXyDQQL8OgFySQEQxvgV/hMYU2EUPtiSs12Y0mVKZLQ6WkqP8VPLLwoO
         T2y/kc1LtTuYO8fwza66Mxpqar8NkjFALRwrfsh9P46CfbMz3aG6aOPlVGrS3mZYQlba
         hyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772740114; x=1773344914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brQJvLzGSg1FNHbunEnKNL87CiKohImsgvm9vmEVnZc=;
        b=mFX57WpH3zUsx5z4xC1C3xOgoPP0S6NWdsyK/e3xffSOvMbsrWI9XoDxBbutcbsRi6
         urz/FzPWRQlQe9rmQRTQWKma4zviEKk4W86c9BGcsEesSMJLcvKGvTOb3pgYAjkwsozN
         0pR7sj9PC+S3KPu64/bYOE28ByLcMqS/I2RJYJKcMMrtcYmD0q2cQd7YGuL4Wd+QgrN3
         D/Yx7n4x2So0YVV2THsPxrwFJinY0La/zuX8TCAmxPRGP0+g2C8vUnFQq0JsUFpXXrRk
         63zM5n9o95wux0Ety8DCyBbh0sgIbmb3xrWOocDbHyThmt0tI15+95ZQQaz0A/0/LE4a
         Q8Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXNOzLL/j2PdKddxIqxdjhryMydEZI1YNltHB358PHfBy324XJs0SLwS9g5S68pHjbWfnj1Ye0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNERGpsC4tM1fX1UaXlXvq6SXkELvHqUo9fgl0o4eWzcjOy42o
	ewBSldqOdfeBuTqegx8LwV1AOfmZJUhSKuzeaSlKbXN3fQtIR4qKLlySytJJEkaz0mLQaMMHVEd
	5D/u0kUPrrJASH44Fyq1rRTNZhp8Hfw9eO3Idd8xaUe5QDAiOHglD+FnmdLg=
X-Gm-Gg: ATEYQzyRN64Efw0TBVOsYUlsxNqLe+wGT6s5Uq+nAajlaCGWQqhsZkKsLbKlr4nwUN6
	OCXXlUcTPAw4fN8oprPuV9ddLC0Wutgt3y393Ay486obTy09XTIDleYGNdkOwlKvy8QOThaU+CF
	RpGmIjQJpho2lUhUQLqAYG8zaFFIY71rq9TSn2shUS1zU31nl7kifSDuo9aJn8PiG6jJXtf+YnW
	nFNOntEw4PzM/qdQIWL0O75PyFVR6dC7Wa2ksFv7w/U/q4x9mD/ngHT5sy5ZJSWXA32N0FlCz1g
	zwsxeOe9GoMYXh2OdzKCjg2nquU0Q1mubedkTy6qEygeRlPIK5EQ8S5HO5/I5aQnSYYVL4AIlih
	GV5tJb+DmsWQiIvqt2PBtfiK6NDmThxNhuL0=
X-Received: by 2002:a17:903:2c03:b0:2ad:ad0f:bbc3 with SMTP id d9443c01a7336-2ae6aab2710mr80733035ad.33.1772740114019;
        Thu, 05 Mar 2026 11:48:34 -0800 (PST)
X-Received: by 2002:a17:903:2c03:b0:2ad:ad0f:bbc3 with SMTP id d9443c01a7336-2ae6aab2710mr80732835ad.33.1772740113587;
        Thu, 05 Mar 2026 11:48:33 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4dcf80f2sm127371555ad.90.2026.03.05.11.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:48:33 -0800 (PST)
Date: Fri, 6 Mar 2026 01:18:26 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next v2 2/7] net: stmmac: qcom-ethqos: convert to use
 phy_set_mode_ext()
Message-ID: <aaneCvwkgMOLFsVl@oss.qualcomm.com>
References: <aacD3osfaZkLsGxm@shell.armlinux.org.uk>
 <E1vxS44-0000000BQXU-38lG@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vxS44-0000000BQXU-38lG@rmk-PC.armlinux.org.uk>
X-Authority-Analysis: v=2.4 cv=M7xA6iws c=1 sm=1 tr=0 ts=69a9de12 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=PHq6YzTAAAAA:8 a=a1qNmnCxCMJs4MpL8WAA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE2NSBTYWx0ZWRfXwENw5FxKsb8N
 DLvLLQKpfJ3O8wktgeuwQb7uzC29w9Wkkv2gsIno7j65wdphCjgOv1aQmKETIAfj+KxSh5G+wCO
 Vwi69vS3USH1dYtzmabTWHSaPFFxFuKw/ragazmSZ86XiLUfr1LThPAKNbxsQFXFKImoObDFPdw
 CvquJG0NB/zPjSF8ypELpsdcWIKEWWQKptgvnvINMzil4wxm4wjwXqZkx/g+aNazNKhWpzX0o8m
 FXrCnASIk9oVj6cyrBSEB49h6/KAU11DVoagFqrioKMc+52iY64LMbtojnEc+ITJjwgzhHaO+en
 XYcHFe0TsEt4zAv1I6JKrtnEpY1ClDVaCvQHCGapWNlUv//Fdk0Z10XykeWBBMysaXOmF+H5As7
 49B1FfqB2YJsRtKDD3bAMx/6EGFmTnZxfulYYIg+YsMX4wVPX6dY+TLHtnaRehbTvPlI+N8wEg8
 xcM4ZX2xrm5AI3ZOsjg==
X-Proofpoint-GUID: Xm2SXsfI4KsUjDodMDUFbr6DoIYt0lXP
X-Proofpoint-ORIG-GUID: Xm2SXsfI4KsUjDodMDUFbr6DoIYt0lXP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_05,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050165
X-Rspamd-Queue-Id: CD781217CD4
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
	TAGGED_FROM(0.00)[bounces-264524-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,armlinux.org.uk:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 03:53:40PM +0000, Russell King (Oracle) wrote:
> qcom-sgmii-eth now accepts the phy_set_mode*() calls to configure the
> SerDes, taking a PHY interface mode rather than a speed. This allows
> the elimination of the interface mode to speed conversion in
> ethqos_mac_finish_serdes().
> 
> Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan

