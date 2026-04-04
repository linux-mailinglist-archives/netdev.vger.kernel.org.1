Return-Path: <netdev+bounces-275405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF39NY590WmHKQcAu9opvQ
	(envelope-from <netdev+bounces-275405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 23:07:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3537539C895
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 23:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3811E300DE2D
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 21:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909BE345CAB;
	Sat,  4 Apr 2026 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R8kwAuDX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YwK6Gh4T"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95DE34028B
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775336695; cv=none; b=QprVD2YgSdT9VfBOTQ06vCSSLA2BmkBG58OiKLJjqnPIICK36bARrNwYD4WtROe7ToMum2JP36e7vrwAb/uKsySda+ie3la+myVD7j5SEX4Cs/oLdwpVr3RDXXI0gI26PjbHofdbvhD2qUo7KcC5drWtZbAGnXd1HI23vfL79NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775336695; c=relaxed/simple;
	bh=gQkxawafjezVKnoesLe0QjCR4a1/sdvaYUZkwHBxPPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4CYjD80Re6y0etvKpkHZqDMkt9+0Gz+KcFhovjgREt5yY3W3AY0GblJyMkoQ4pHrStDf1j0Njzzz6x8OTvAhf2rr6NfS4SoSvg2DPT5oXBzElFJOYKA/z5pUv/qRxH7HT+uhO5rp8AVYoC/jG+zRwMILBx7YfegpmL8eyy45Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R8kwAuDX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YwK6Gh4T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6344lWcu919168
	for <netdev@vger.kernel.org>; Sat, 4 Apr 2026 21:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ssFVauwzazEx25EztfIJnA/7
	6jufTDwP8FuA3yJN8zE=; b=R8kwAuDXYXTUTL5cYv89+XnMMAdOJv+IbOAcWaiN
	gYffeAXc/CWjh5kYizRDTW7Lt8HhemkZWue8llOYkeFTTjwRuEVIz5v9DJRQZ8vZ
	53HKZ8pL4Ara+xjexUD7lI1XExLZXer8Ka9oYKTlsGYsmbpkmUcXVQOKKwYn8WZs
	Xh4YIWftpWZw3F46kWvgYQ6O/0Bet2UcYWdm99VJqduWUa2HHUyX1g4FiMwowup9
	uePYuqCzRjbLEWZDoA/moU7Cvo+4U2LWoPq8ju5Uo+yoDKW1+FH43CFfY1BrLZai
	PdG1mXGkE0hbQF9Idf9f3vkIpNs3eo7WyGz/XBP6Td2pVw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4daux89d1d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 21:04:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5090e08dcfcso8405811cf.0
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775336692; x=1775941492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ssFVauwzazEx25EztfIJnA/76jufTDwP8FuA3yJN8zE=;
        b=YwK6Gh4TL3wWhvIguI4uShRnv6NaI7JkYhPfcAF7tOKI3KBqLR9PwbXDFy2/rcygjy
         2h+gVeb9v99UMBLla5VlcIWzUmC/rBvRJyxfV7IdoF/Nh56atZk0hMYa9mK+NBjzerR3
         f3DkA/rZ149s5/0Ey1W/9cuKMZsnMdbRot6uF07B2jE6248dmh7kioJzg9mOJFBrSSR7
         VOd2izolViIUTcEvDZS25XZt4AO48o56bh75rOFVRqBRB5L/LLUDEgZ5OfmuF4laGpVw
         gv3uShg/LlBGe3Suscj+ER6qH3Jf8Vs2PD3aOK8Dp+c1dE4wjjoSh8nEDrTkwkpGhm6r
         dp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775336692; x=1775941492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssFVauwzazEx25EztfIJnA/76jufTDwP8FuA3yJN8zE=;
        b=k3rlm7D6JCqJPdmwdTygBy2M1TX9Usxlx8Yb7/k8DC/mGTOqpXOHoucD8PCZkZYEBj
         sMMItkLG9Yuy1AoODxdhFalSzfRHd6Re8EHPCzJ/BZqWMcK/zeaeYKj4QlPEf/e43ySt
         T/OLYsByfar6OjPhy5qM97OcV2Psl1+j5FhflRexG1sGp7S1vAzOSL0UoqtKqAnv3JQS
         PnCbhe+bdKOIrwRJAarWl3GEezE1Bmr4nRwdsOSqQ1jBll8ibXgUj09PaVJz0lOaVBbs
         s1k9jL7DJFNbJFbbeOaz1DJyS3PF6JJwdXag8UkpnXFwtAwqclZcHozZPnSlp4BX1sQ4
         mv2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgtDCMTMfjJl7A0Twu1sTc3L6bC5vq5PCl4/+dOebHiSINSWjPxj05LFF5d4Tq5S8dN/6PcLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/gFnrZ4RA47vbTwcyZfA3NaMtg4ddJ9ZhmSkYjfexcp2X3vyZ
	vFXk5fNtot4fBhVGlCy/JVmN7pMCVh3ua9KLyZUgGH1sberZeISrWNeKXKr91sPjHVYfUAWgrJ9
	AsvL0rm6hpu5aQmM2B00YoTVkDlNNl8NaxnVfjxpyZcBLjt/ZmyBW7XGGibM=
X-Gm-Gg: AeBDiet3qIA4fqOkBrMqFUqKm1erfGLHALsqPS8m8VD090rjfp0OlOW+nGvelbYZoNp
	qCVqtxgQDsKJh6qV1X1yD1BRX0PnBChuZiNtYCBHbLKv3Qjc2poDabHt3i8Q3mTLr/TSc0JrHdz
	1FFkXRbuXV5/+7NBhzJqSXiABq08GEPkyhIib7a91dRsIzExRNu4l7rZ2dE1yyYc30czLdG0ixb
	CV65E/r8ajR1r9FKxMdfJAqgXKb3HR0mExxW8F8h01nozBtOwtuRY7vADrwJARuKaFCr3xi/YBN
	lAW49cvprWBX+Jf6Uf3n1x2F3bdVZfy5chIdGi3aJYJYZEqOOEjXZeuHqQ+PngJxp2kzYKzEZgV
	/53e7P8G5eGLxwuEMyMPwGqfhpTHWhpzHfS8m5W2Lv99A1kZCRtt2FmePVqUIJV5q5UYibvycY7
	ow7PNooApvuwakYRtCBD94fWvM85HkwXKTeWs=
X-Received: by 2002:ac8:7d15:0:b0:50b:4d3d:496e with SMTP id d75a77b69052e-50d62cf7c6amr116122341cf.46.1775336692291;
        Sat, 04 Apr 2026 14:04:52 -0700 (PDT)
X-Received: by 2002:ac8:7d15:0:b0:50b:4d3d:496e with SMTP id d75a77b69052e-50d62cf7c6amr116121971cf.46.1775336691875;
        Sat, 04 Apr 2026 14:04:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6cd8491sm2317998e87.83.2026.04.04.14.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 14:04:50 -0700 (PDT)
Date: Sun, 5 Apr 2026 00:04:47 +0300
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
Subject: Re: [PATCH v3 4/5] arm64: dts: qcom: sdm845-shift-axolotl: Enable NFC
Message-ID: <mall6aengyapawa5gpkel4wuswhq3c32wf2v3sdp7m2msh3zxt@2tpezkny3my2>
References: <20260403-oneplus-nfc-v3-0-fbdce57d63c1@ixit.cz>
 <20260403-oneplus-nfc-v3-4-fbdce57d63c1@ixit.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-oneplus-nfc-v3-4-fbdce57d63c1@ixit.cz>
X-Proofpoint-ORIG-GUID: NuOMMCgifZpD1oZoWJfaBtrA55zddE1z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDIwMCBTYWx0ZWRfX90B5ZSar2bxR
 22NYWD9DN6ygFaUjcAai7fmWnHHi9mQkfZ9ALF9G6YCTUrq5hW1UaRQ4+PQ6Bd3m23p4TKyohtW
 XTa2vxMgwOQuq/tI2UWKHe0azO/IIALl9HFRFL325Z252ZJjcnvs5rK9XEuuPW+6BKsQ9wmhcAh
 /SLlARTgRz1BnbEWzNtUqinGA/OMRADCJLxFcCQ15DA9ihe8HM7kM0M7BB83qVLdqiAKRMZ5toI
 R2gtXQfCulfX7C+UG2ij0t4Sm/9bxhVhHGD0vmeeqn1gnTYobFb12Az/p1YTMD5UyyHDZQmyRjf
 spMfSAMakw3p9oXtvZwZf7xhc2ko8WyUTX5j3PXiDxhFgzpfRK2rxRoA2Cma9QLQ0dCWXkhi6+5
 K+cygz/fiTzoNO1hnUMJ+eQnbHqDCEXa3qqq5etrPUJd7YOb26vJ/Q52E1b5eNIEeFxjrnZTRLm
 db/nPBMdhFybsXgs4eg==
X-Proofpoint-GUID: NuOMMCgifZpD1oZoWJfaBtrA55zddE1z
X-Authority-Analysis: v=2.4 cv=AuzjHe9P c=1 sm=1 tr=0 ts=69d17cf5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=jzbMb8GUTuS7xUAGJTsA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040200
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275405-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3537539C895
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 03:58:49PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Enable NFC controller NXP PN553.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 52 +++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

