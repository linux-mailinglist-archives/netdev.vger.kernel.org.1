Return-Path: <netdev+bounces-265803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIZBEXVgr2kDWwIAu9opvQ
	(envelope-from <netdev+bounces-265803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:06:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A19242D6C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CC4330A1852
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F0628DC4;
	Tue, 10 Mar 2026 00:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QfWNIKkC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N5o5tqV6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A0199D8
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101080; cv=none; b=BVkEoP73TQaMx/0AN5scQUR4yJh25ErYD+2FLV68h/2J5j0srIAicWyVt8uQKJsREW7P/zngti1d7BeWufl+52iIxLG67snwPYgNZDfeP9dI2nj5576kSHptllsKWn7yti1k3T8r48/3FJJTAQSMnOFCUxIZ+SeI2JXXg5Bf0ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101080; c=relaxed/simple;
	bh=f7kZUGzjWGj2VYO06vzk356/r5b9I5pX5h0xqGvHbs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLQh+6O0tqsfhNHHNXG9diLn8N/tG9VW98dwjaSXfWkEPPMgab02NHX5DxTz4eyOu9LuTR4XDbQe4HHnFLqcCAj6OwgGhwl/vbkXpQhfpn7vica+DBa12/MLt1ZBWoNKoyoX4vzyHNezLdI7HSObscerhdT5DNwiiliv9b435fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QfWNIKkC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N5o5tqV6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HBh3o1659911
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FiLdFIOl9PlXIMdxcVYmcXmw
	vstc2sRWR+kyhh3rVZM=; b=QfWNIKkC9L6ATOW8Ig/yhvIj62nRnrFOVe6u0i4i
	4SZ32G4q13/XjC6wjoBiX8F1pTq3XNepVaYX0T+oyA2Q9Vm3uK67nIaUFji9Pyf+
	ipBJ4RGGeoO5nDlAEtl1fSE8dMVjD79050LVrVqXE/Wa2IY3y6Bh1B+ZCb33sO3Y
	8XKi0FbmrtdoLFWScHZ6pvb0EVSLgjVdOh2eWTsoDOnWCS26vX8XHk0bTQGDg4l1
	Jjxjac5njC0WUG+OdkzWWBJZN/M7cvotNl1JQ1hBhVteDkljpcTmOXMzFSmrOMNJ
	KZhxmLXuEJU3I/67AV33kt7aK5/Xuy3rGFoZvqswBhG4NQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyr41qft-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:04:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd849cd562so992101485a.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 17:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773101078; x=1773705878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FiLdFIOl9PlXIMdxcVYmcXmwvstc2sRWR+kyhh3rVZM=;
        b=N5o5tqV6C5IVghZGBKed5EksxzKaTeK+S080uamO21KZKNprlrgTNaG48gLOXPw+Ks
         AeCEnoU2O2E0G9OrS8ATlSmwDAi51NMZ8e6+CwZpmjpDp+8EMlggy6upxqfuy7GdoyO0
         3+GPWnt49PbFMaIgiu6rw/9lT3zjAqDdjq3E570ruFrJL4HS8xibBZJEkMNLRWTI3DT5
         eVpODLeRQdOx3YIrhxbLICJ2uECXPmYgXcG0lZcpwVoi4+57ByZxq//qWvaxgALASS5q
         8v/vHKaMpy6OezeVLG1/n3Uc13u7pkxAB3ZUALVqBvzJGwS81EexFbHvsDjn+QmHpC3b
         UfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101078; x=1773705878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiLdFIOl9PlXIMdxcVYmcXmwvstc2sRWR+kyhh3rVZM=;
        b=Xxnp7/fJBMQa/9ScxOMpPX+WNsJVu+/R3ShrNw4dgUyiWL3+E2k2IVDP+vHIYWoBQx
         +1ly/4v10pacy51rcdhYjAtjiLoGvsa7uEoT3ckBnIoyWM4Vkrzd/ZWlft/7FopXEJiP
         Ip2qzWRmHst0X2AaxDMOoW1YkKfo3mddV5l0MGFaVGXG0G5NuQSakCrq6ItoAXUd7WXQ
         WsO+s3YjFAaZxxw2GdjLU3iF4epljGMKvO5yrXp0BkoQk/oyn/OQ47H+OuUWp/EXlTxd
         gMaTianoUYfAYLCWMVnqrjyIKEm/q/pvsPGwFAiVx46g9nbiIz0nV/m3xYHcHK+UQj8Y
         Tu2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXddpuGVLUdZe8f2MZEF7gkziVyTOtNK5jTFks5k22WGVjQf1N9neojIiceZovye2QTs0BAXM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrXgAQ8/wWTQgH138HzHlwa4E8thEu0h9lALs6rPidG/ehu7pg
	0CLB+7+cLCmLPrBTOEGoPsBtMG716WANb+uGe4vZ7Tt/ef0cfBaHJCXBXLG0DFvgfPqngcrimhu
	hVqDGgL5y6nrYLExmeM1VOND7Yf+3C1AnWpXGfXqCEW0c82iYUQyt7Yfpk+0=
X-Gm-Gg: ATEYQzyKPuw+iLaW6/1rcB0FUKl8FOdl23Ci0+Al0Bd8SJ0ZXnmbpANbtBWc6yaCmWj
	aZOeBIWqYnr6gwUfSKZX6xeUxGdSae6eW35HBEI6V6cjZMNKaTUxQwF+ekWOl2ubArLfkzvhNzu
	+mnZ+n0lPuxa8bPHbBAPWAIcZJO5zpQHFT0VboBMO0f/NVu0uGrCMU+2OeC1h3XTp2cpBkNH+3H
	IezcAFPY92V0kyG0+FjCRp6rpZG0QJQU4IF9fw+7D6KeIvH+r03jL8wY4RQKJIn3xzDrp4Wf7QO
	E+ndlPo58DIitYH3RAkSHLLB8xL/wXVOaJWvGApnJWQz+L+FhKPn8v1qI2ExoZv9ciJxpNdIGO7
	tnBJa7TueLmHVaSeQHt5ScBptKIgOsWcgfroQ73jTHIizMhglOd3ZzLi/Um4Ghn/rLwhkFla68H
	5MiSJUb8asOUFH6r5tNWsvO5lybYoS3VarqBc=
X-Received: by 2002:a05:620a:4055:b0:8cd:8938:eff4 with SMTP id af79cd13be357-8cd8938f34amr639762485a.16.1773101077980;
        Mon, 09 Mar 2026 17:04:37 -0700 (PDT)
X-Received: by 2002:a05:620a:4055:b0:8cd:8938:eff4 with SMTP id af79cd13be357-8cd8938f34amr639757885a.16.1773101077459;
        Mon, 09 Mar 2026 17:04:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a5cfa1139sm2074911fa.5.2026.03.09.17.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:04:36 -0700 (PDT)
Date: Tue, 10 Mar 2026 02:04:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: konradybcio@kernel.org, andersson@kernel.org, linux-kernel@vger.kernel.org,
        Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-sound@vger.kernel.org
Subject: Re: [PATCH v1 2/8] net: ipa: Use the unified QMI service ID instead
 of defining it locally
Message-ID: <4py26yy2xkroj26amwxu6q3ynlvla5fmoyju7xu57ncgo7zswb@dvujowt2rxmm>
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
 <20260309230346.3584252-3-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309230346.3584252-3-daniel.lezcano@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIxMSBTYWx0ZWRfX5v00R+Z4ZzuT
 i/d9Ozjq+T4Nwatfzeb/qXvgO01n2lX04WIQBCr9qzzL4iLBs4nlB7iBdbX/HX6CBSILCh6Nu/S
 lSyWOR/gRVuPdSuFLkQKoCWgv3vV50XmWcWeCmMeR5acF2scmwjRHIMMcA0XtnfHyJGozFqPXMY
 B/A/olVxSkv3Vie/Lor3G9I7TxNmNUfiIPX0hxNjBYv2Z/tBfoc+UEJAWGwQN61caxbYcvgWY3P
 lQ2UPOd3iWpdLOhgVoztV4fjamERAHZL+EMVBda3qiPbIuuO2LLqaDAZZdlF6PfXK+vxvo2Q2hc
 nhPXVM2bDg4klZeN+sCy/KfbFy+5GMb4u8Nfs6HQwpDRicMj+PNrxprZcjAL8U/ErA4genWKXJX
 zzJU4ZOEG8UxysE5MHCdEj27nrXszzNT7iTJGUpRb3GRCwgxaTjgt4vH4o6sg+hFDdyumvLNp+W
 MFmixRIl3GBimd/ZyAA==
X-Proofpoint-GUID: CZzJlBcXcFYIJehWQDsRGYSxmea7_mV4
X-Proofpoint-ORIG-GUID: CZzJlBcXcFYIJehWQDsRGYSxmea7_mV4
X-Authority-Analysis: v=2.4 cv=KNRXzVFo c=1 sm=1 tr=0 ts=69af6016 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=R5u7ATk22_IFkQxjSk0A:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090211
X-Rspamd-Queue-Id: A9A19242D6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265803-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:03:31AM +0100, Daniel Lezcano wrote:
> Instead of defining a local macro with a custom name for the QMI
> service identifier, use the one provided in qmi.h and remove the
> locally defined macro.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>  drivers/net/ipa/ipa_qmi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

