Return-Path: <netdev+bounces-275406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGGGFL990WmrKQcAu9opvQ
	(envelope-from <netdev+bounces-275406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 23:08:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AAF39C8C9
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 23:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C49E9301FA6C
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 21:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3BA346FC0;
	Sat,  4 Apr 2026 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iVN9E8hO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ctDqQa76"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6993446AF
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775336709; cv=none; b=k1qwNc+NLq0ywGLmdX1YjQGeb1UdkyyhYHcCTTtWpA33/F1D4d8DvRO3lFEDyN6bv3oXzsZbuAuxgxDiFFzlnQoMOit9nUyPDC8lPldzHciZncSV3zcrA6+xXplN22zAwFy1JzYsfm2ZuZMufAgGc5opQkza37U++ZENpNViRbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775336709; c=relaxed/simple;
	bh=43aB3Yxbi0z90zDEUpqs9121Cxv4GK2culeC3+AvvS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lA9PTwVaBoml9igjnaMehCYHEBcudI/4E14KoP9igECZ6sPRHf2SeyUgS+n2yXPhSpOglteBx1oE4CYFddLEu65JtLFtPVQ8u7gjqRQUZ6HscZCgBBeG4lndngq7vSoKo5YhJZkYqBli5XGkZU1qMrGuDiDqeJVY8kSuntFdBUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iVN9E8hO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ctDqQa76; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6344dnIb2971843
	for <netdev@vger.kernel.org>; Sat, 4 Apr 2026 21:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NMHRND1WF2PTszeMkEbK4Rv7
	Is+/ycLti+5TAZCpHVk=; b=iVN9E8hOZa1RpoD7WTkr9/Jv2ORtanHvGTjhxD8F
	tPX57WsNdzxs7dfX1UN8+X1zaDOmNRe0cYihUBRnXEkIcWASaDCx3XbqdxTYkzID
	yvzJMb2c57ipLNLdPxOMuWjt04GmtM2i5zglJNBkdfodKt9Fp0+5ReuhCZoqUnPF
	d7E7JvFXQvPSOBzyt+UOu8cS6TBEnVYqyhwzMK+LUyoue8ylf3W4TgLEN+MwsV3F
	Rf2/4Ey3cHmU5NXClg/n108G9/kIrcVeSaYE/S2HLtvtQ+GbANadnN1ZPWQA+xcR
	Bnl/ded3OHT8neY3MaLHhEtHD+qLh1t6kjqXzNEINS+7Gg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dauth9dd7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 21:05:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8d432f1b84dso412792085a.1
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775336706; x=1775941506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NMHRND1WF2PTszeMkEbK4Rv7Is+/ycLti+5TAZCpHVk=;
        b=ctDqQa76lC5JfoGAvQkmgje+gikqBdzyvtAkMTESH4Abdmw6BJ7tcqwqvAiF7cDRt0
         rjJPG6nFz3we+CpjxGuB9HDRe1GsiffmYgK7RbLKuGHC029vrENkhmDv4MtGUsCCxpDr
         Dro8Hjl5xKt/w9mVkKqgxaaC2xWsxU8nIFCnT4K7oB5BNR5U9ufopkkgWA1xXWZfSSzs
         UF/EU27/Nc2EDfgq04DtpIYfSXAQn/bx47fbthEqgAxHXvQSw9UV92yIxJv53ab/VqP3
         z3ms6OYx0mJtXLLwmY4kyu/udzUu46mf8VrvmEIF4CnkL9MxTaND4nmDuon6SJ8+fhT8
         z/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775336706; x=1775941506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMHRND1WF2PTszeMkEbK4Rv7Is+/ycLti+5TAZCpHVk=;
        b=ZglzJvDUMGOAoiBwltrkAbzDjo4cVh6zs29ZKHwIk2lpToirMwBP531E12enhh+0wM
         p+v/HI6CUFHxEJC1uMcXn8i4kwvB0Bx2E4aVjObdPfFlvrfjgE6xLTg2GYNnknRoZTZs
         1ogS6WY2RYoP55Ik+Nt6rLNnoJ4gx3l3MzFZGDljISx90lfZlmCDtzFOljHRLFBRMHjS
         xCVU+MjEAmpy5R0LHJ5IHkDg4eNwZeo1QeTMGFhqT8D2gF4h8bocSMFJ2yVUlg7EqvI0
         sPrFZ+JuCU0C3SUBMGYeonRlrsNgIxmVrGL+hOS4F+0mKWBiY6+285NJyiN3vCqZw7n+
         fXIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVfILspLwtrXDohMc+TWwm/VUe2tJnV0lKPyV8sMV1ElggJvP7aXCXEnPWbCudqYKeSiJdHso=@vger.kernel.org
X-Gm-Message-State: AOJu0YykE0fMwmHDKBv3/TNw+4M6pV9GY67Z0IcbpXsmkl1BnVPrVfTC
	0zumhBmXUYG+KZCEv/WfyoNDDMDnpLhoq6JUuL2iR09gFG2LiqMTDi9shBi1XuhpoBL23kmDJog
	vkKaPYKRohkLNoT1rm2DRXa6ixsgq09Kimn++LwALLqBwiDOzhDgQ5cHS70o=
X-Gm-Gg: AeBDieu8pzzjF1UOouITs54p85hIqujtjmAFBOo3Voxu/wQp35YQBMTaBCk32bEBDGL
	sQxI6Qu8nYYzE4wHdu9OaIPyM3ActtQmr8WKWTYyw6iJlNmYGMa8Vv+bNqaa1CbyCtJ1+Ez1NXB
	OfeB2/8pLvxc48vsz3cMrOL3TAvLuULF5R/CABWIrsDMLphsHuJQH1cXlONIuIWQlO6eM4SRrUv
	xXpiATaBZzfH6/EPfm+Xepdqnd+9AZj9hKIHa06EJZZ3t7epqM5zL3Pc3qhdCFigB1PoWeHle+n
	1L/U9JDSIq007keloFPb4kAcI0yQgyO6WPz1rDen7rkXVBF6YNyJGcC7EWLh3pXjTP2N4Qoo3Gx
	4kNSycnzULTVZpouPbC+ut5I2s4nlDuwmxB8e88TtAwslcTy5ICnxP3jxx4VnzuoVw+oTjBOhBC
	PQ5H22ynMJC4xatrl3nzKrs4ASv5xdCCIM6Z8=
X-Received: by 2002:a05:622a:6852:20b0:50b:8689:bd4b with SMTP id d75a77b69052e-50d62c327d0mr91009491cf.39.1775336706534;
        Sat, 04 Apr 2026 14:05:06 -0700 (PDT)
X-Received: by 2002:a05:622a:6852:20b0:50b:8689:bd4b with SMTP id d75a77b69052e-50d62c327d0mr91009181cf.39.1775336706180;
        Sat, 04 Apr 2026 14:05:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c9810044sm2030981e87.26.2026.04.04.14.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 14:05:03 -0700 (PDT)
Date: Sun, 5 Apr 2026 00:05:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Martinz <amartinz@shift.eco>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Casey Connolly <casey.connolly@linaro.org>,
        Alexander Martinz <amartinz@shiftphones.com>,
        Petr Hodina <petr.hodina@protonmail.com>,
        biemster <l.j.beemster@gmail.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, oe-linux-nfc@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 2/5] arm64: dts: qcom: sdm845-oneplus: Enable NFC
Message-ID: <44qdi3uvm6qcsjnhgepuuxbxukcqu6if2dxeyyar2rqewksgzq@lwha2jpvpic6>
References: <20260403-oneplus-nfc-v3-0-fbdce57d63c1@ixit.cz>
 <20260403-oneplus-nfc-v3-2-fbdce57d63c1@ixit.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-oneplus-nfc-v3-2-fbdce57d63c1@ixit.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDIwMCBTYWx0ZWRfX5WRUhX3QPug4
 GX9i8nOFDVQrrcSTbeet0SiSLSe/+mVKExX72SVnYKajhFlBYwfQTFsKsACRjXwYp3yYDcKj4hJ
 zsobbWmzpCBQ+J7vNerCDLeL7nGFDkpZhaVCZq5HdChFmqBpKbBMSqX+5RmvA/BoitbGZg0CuBi
 xX/3MFu50ZxRl7VRG8NKOB0uxAsQjJLASMizAZTLMhhG1tkkLAwystsHYV6M4MU9IyAL24AHO3P
 3Nxw05oUwHaeT79dJWGMErV1KCch4BFJU1s8eQR+uKmwHFnXqE6qxJH3ool9/9qoHNswq8j16vF
 qehE8jtAYwe7qSsp0gIKTsjH9Y9CEoKTFjpJqdzw6YOqpD86B0d13q0PIAqMKTC05Gd+p7kCvNj
 o8uTqO80CFeDrqC8H7I7nOltYr6QCv5VmbbQ5p6T0jIWMPYJU3+TMLP5O96SuQWqRipzIyDBazJ
 ZBh0uUYHiE3ESuziLzQ==
X-Proofpoint-GUID: U41ajtTGASWKEYz8v14STAfYccJ-MpBx
X-Authority-Analysis: v=2.4 cv=MIptWcZl c=1 sm=1 tr=0 ts=69d17d03 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=wuwE3jySQvoYGrhSQ40A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: U41ajtTGASWKEYz8v14STAfYccJ-MpBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040200
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275406-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,shift.eco,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,shiftphones.com,protonmail.com,gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ixit.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 96AAF39C8C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 03:58:47PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Enable NFC controller NXP PN553, which is part of the package NXP NQ330
> (NFC + eSE).
> 
> Based on work of biemster <l.j.beemster@gmail.com>.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

