Return-Path: <netdev+bounces-267047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNDaG/CzsmmYOwAAu9opvQ
	(envelope-from <netdev+bounces-267047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:39:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D390271EA6
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8C92300C55A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6198E39BFE7;
	Thu, 12 Mar 2026 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qa+INA0V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LB5mbZpp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCBD21883E
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319145; cv=none; b=MzMdjQVVY7gmc8Cyf4G1i3NXqKlky/6HGNB1aL3+7UR6g1JtYyFxJT05yaPvOlToFkInXVndAM14iFGS9ig+VW8sMiE83QEWew/aVJXh8yZgT8vHxrSu+a9r8xPLmx0oaP1ioT+6vrKTGyYRmQIACPGZtUyioNOGWJ34cH2NXLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319145; c=relaxed/simple;
	bh=zACpLgsif1HX3UIVhszs+cVidIvE8f2Jr6Vp8AT0tCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0TaLvLNQ07jdJ7w9Fgx+Y/rRohTZ1+dp9etLcWN4EQYGd9XpcaLf5X8xu9q8ZJbTNwmIvezkVkj9PfEmIwMdtvIXSzEB/GzXHVAdRhVavfWyb45acsuGutiEALPlV6FI/ddvf+5i76LG8JPKT1ud0ET7RGB5k9JcW1edzGdVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qa+INA0V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LB5mbZpp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CAM8sb1756601
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VpQ4SEdwxBmvueD5t0DDAjzG
	WQB6ZzRRo52i7ZTd6CE=; b=Qa+INA0V1nSQNFKgzWp/vuwZ3Ke0fgaJkZta+ruN
	cSnIUPzWg+09Uc4eBE3c9gTEJhZe3W2CLbcT/96KSbOPrHJbjztasJ6OnDa3VVog
	4LxCAv/x4Oqm8Bv3JkhjSKksBtLG93n1I2tpcS3LcBLad2NVb3Nt0gUh/oyTeQD9
	+5puo7aj4F2SNQPnjH4muKL0kzICV3AmvOuxQLaV9nxRoluLotyJQJyuUmJEyIah
	Yi+8IbFVQiYYbOtiSCf9sFgVDqoMpQ+UMfLXzGtv+MDL9HzaXZeQk6ulgg6sPFP5
	YAQQrMCY4T54z2XjaNCqES/jrbvdtfFqNE62Oabg2Wy0Lw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh53j2sj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:38:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd84943c76so1444603585a.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773319124; x=1773923924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VpQ4SEdwxBmvueD5t0DDAjzGWQB6ZzRRo52i7ZTd6CE=;
        b=LB5mbZppLlA/ylE5vu1a3gDUXvD+4/qrKA/6MZvDlcZSQ3vLdZ461vVoT51GvMtoFV
         i00Y83JAAktqNUqNpSHA7V3P2FUOnGlkc48hzpn37g15zSVkZi60qKrjMzNda4cJUFGg
         /KvI83/rqAvChbAOo68XvIDYBAk/dVTTSZdct5pZITOJiQyxrkQY9fXBxxfAlIbDMoea
         5eRUhYiI+d4PRxB4dtN4Li8y6p7zhZWa2GTHWZQwwtRjVjWql+zETWFEbd3Zerz3lICx
         3Ia6gnTGfxte9vVLUPOe+ms/8nSQDVx/RNDkdD4iaVY0mgogMN4uX6RxxVC/mRemTVKx
         ePEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773319124; x=1773923924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpQ4SEdwxBmvueD5t0DDAjzGWQB6ZzRRo52i7ZTd6CE=;
        b=InaeLKU3nUrVad2WVZ5XqfAi/FO51ql9OjcHg3US4n+VYQX9RR4983Pn75J8cI/Tl3
         kBu9MGSMZ+m1ogkkO9gSjwNyggYMQSh9jDSMNNocHK4SMOF76eNHIYJFzaHQ9uEm42ST
         r7Se90+U+wLnGaManH7lwbAgpmuCGrk7tPU4pHrLny5Y3RKrLVdDmblS679nhR2/CNwV
         oiJFl4HVXsw+1jyqAsvYVlMIq5z0XLB4mXN0B7lsGqPZP5kthk3PjfIEUNQGjwJKElmo
         JH9AE0b6yBd27SvFQZar5oMSPySNXzCV0lgUA7vU/tPulx8UE6Ag1teeJX6OIGHTweIo
         YyEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9jzUGIat8ZGMEnoIKYIs8UKYbVKv3CqpAEN++vyMaw5QV3QBnt1n4I7IJz/gOXCksS+9ZFjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb3Ajs4H0so0SSsMawCU14Khuf9TvwyTeSwWoY/sl+o+um9evk
	zkD7Tuiuva7zPdjuZSEDnQ3liarUSLezUMMGtLpftRNxyyUCSjtN+/kf5WpVk8MbribYklwKexH
	QsdhL0Oc3tsE4mr6bDdUVBoxFok0Pnq3FHwMf1anKO4U76+pbayQqy0OqceE=
X-Gm-Gg: ATEYQzy62LXdFZOj8fAzGX3aLmVYfeIwI7UDN3vQkGmtghJ7mT/s+YWj6zjr1KOanTN
	bCywbQAcyrSfqugCRE+y/WjUyWEz0x3uDzaPReq+3SLUptAfhxUD8kvEtt3KFdV8KaBDDy3FNSY
	ybUAcQdJ6n7AqMg5KUWXmoxwoL8OWtbywO33zaYo3v4oFuG2JAuLkJoLXt7w/VElpio16UapFV3
	rum2may/GYQikwPZGtyvwRm1FVylZM3UJ4D0Qki4d0Oujmd9SMpGm20CrRLZ3d6omldQf6uxcEa
	jkz9Iz58zNEAhJmU1zB5LSXAcrbSs1ohlycm4Jw1BCI4ZRMaNhFQiAgjda/5hRL2WZ/lV9JwgOs
	KLCmiAxTinTipkoh9VAJxXpoJAwXsKeybptADKK4wZ2Yk2Vsa7eO1YHwmWwCG6k5lNmguV+H+AM
	KDMVPXWE+/oxUtzGqxH45Y7PsaAKzcRPEt7ds=
X-Received: by 2002:a05:620a:7114:b0:8cd:9405:9662 with SMTP id af79cd13be357-8cdaa88ceb9mr441488385a.36.1773319123631;
        Thu, 12 Mar 2026 05:38:43 -0700 (PDT)
X-Received: by 2002:a05:620a:7114:b0:8cd:9405:9662 with SMTP id af79cd13be357-8cdaa88ceb9mr441484485a.36.1773319123193;
        Thu, 12 Mar 2026 05:38:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a15636675csm956770e87.74.2026.03.12.05.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:38:42 -0700 (PDT)
Date: Thu, 12 Mar 2026 14:38:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wojciech Slenska <wojciech.slenska@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: agatti: Add IPA nodes
Message-ID: <bt4tv6weylpofod7j4ft7ugzupzjqqxx2eupaxexyoildmtzns@kphfbbizssp6>
References: <20260310112309.79261-1-wojciech.slenska@gmail.com>
 <20260310112309.79261-3-wojciech.slenska@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310112309.79261-3-wojciech.slenska@gmail.com>
X-Authority-Analysis: v=2.4 cv=ZN/aWH7b c=1 sm=1 tr=0 ts=69b2b3d4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=XksiSQqrTY_tai9pqxgA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDEwMCBTYWx0ZWRfXxEBmGr0j2P0C
 o4QA9CXf4IVKx1lgEn6/c/6WLfPQYoQT5hgfpOib4hz9ixaw71obyuOWrVwp4PhcvcvJJOFW4gC
 mV/cnnStBhabLkUykukF2nVSDE2Om+qktqszTTZ3rKst92Sl6k89V76CaTBc77+bOfHXAlgCqU/
 NwT5xvyx8WHYquf9da3Loxp+7GyiSt56avyFwaUqT/FAgGsM5Dgd+E4t+2GTAylK5E6VXdgnbbh
 bkIfqoTpT/4SMZywI9Ds3Oehj5EoGph9M0OT7xIJeJMHtc9nR884+40JH9etcqMzLw2KQAG/77u
 ZtPihzXWRn6o5cZBj6G3YbZvgdbZtSj6F1dJgE3ycn+5E5jSGFmlFQHLJ6/tad0j7gjEs2IpBBj
 WIbSjZyhcn1PHxjD3s209yOfZmjj38tI2i7EvaJ4UzKuo4w4DxuTScsMajSvqZPhiUjimxRJuz6
 QPQaVJ4SdFwwRAu5INw==
X-Proofpoint-GUID: eUixq54idCEqpWWwaScuRPEueaBFMmsy
X-Proofpoint-ORIG-GUID: eUixq54idCEqpWWwaScuRPEueaBFMmsy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120100
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267047-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7D390271EA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 12:22:31PM +0100, Wojciech Slenska wrote:
> Added IPA nodes and definitions.
> 
> Signed-off-by: Wojciech Slenska <wojciech.slenska@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/agatti.dtsi | 53 ++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry

