Return-Path: <netdev+bounces-305534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /jwCKlstTWrJwAEAu9opvQ
	(envelope-from <netdev+bounces-305534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 18:46:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 426F271DFD1
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 18:46:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=inV6jako;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=jIfFd7Ke;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305534-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305534-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA3B0301831E
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 16:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D004436BE6;
	Tue,  7 Jul 2026 16:46:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E1434E40
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 16:46:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442763; cv=none; b=OemPod1+Y1OGCGBg/B5QHRowBzCw9+htXlTUvT9f8KTwpGNHSs/TL8mx/xB5UtvhiA080Xd5ZzkUskdzUFFZ81hekwafEhEoHWleK+g7DM0yaD9zvSKod+6VBiWfGcCilmQxsNdrBdTGvpkPKrymEJ3gXKMIv92wifKh9Zxs1pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442763; c=relaxed/simple;
	bh=Q4ubu0LoZOVjTnMIFREBOyr3zA3F/vFWUl5oOcKA4d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQ6WkQEGTdtUIjFh2/hKf1FkwvTW4YnFbwJR4BTOYs0ilQUW2IaQYKsRLrZdESDemyVJVn7wXeqkN8kHtbeGNqEz3o3QdPHKol2B8WwDi/8IHamsGsKyrfJy4xdyFzphxwS3CS/2hiO1JdrlAGSeTuRThPtWQ7YC5CB6gafhmlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=inV6jako; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jIfFd7Ke; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667FT7P44045084
	for <netdev@vger.kernel.org>; Tue, 7 Jul 2026 16:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=li0pG6/934G8KYeHkJPSyW/N
	lEpOX2i7l0YxZTpF5vA=; b=inV6jako9JYZ8EFjKbuloptedCjrnSnPruF+dgAQ
	VgHrpNwQaKOATc1se5S2oJy7pOyJAjFC+ClHzRnY1aplgAhAffRIt64wYJLNR8di
	crSe2WeYD1mQ+dhrrHvmMkKv7xq8mhqP/B2ocvAdvxHO4/kqlai8Ab6QZ3nyVitG
	viTSf3RKrv8kGAoq1QeLoG7y9XtQyA8Q9ILm09coOJWpc26I2fpsMiaIGKLRv49v
	Huul7FbPtEHnG9GYmixxaxwoyYd1gqRKD7foDk0sTW8z02Zc+nBwG7VRRfTxWT/q
	pjBt53ScX2JninJNiffyfpone+MxZm7AHkF7gZi8p6Qedw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2uaavv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 16:46:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c33f48ee4so49276021cf.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 09:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783442760; x=1784047560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=li0pG6/934G8KYeHkJPSyW/NlEpOX2i7l0YxZTpF5vA=;
        b=jIfFd7KeTbSWv3l4BHyFBIgiKXdD23zVDE3HYnoECayQQAAL2v2z9xf4tc/ECKj0s5
         pnmuhyM8quyzHRU3kL6dqJCUbixYzFkLhrvm0rfyzRWkVP0akPtuV1zbwk3vsLgGt09G
         QjlQca4OqjH4e+Z1Y5pttA4FYrMCW1DwWVHNa9zNyOfcT3DThihnFbVkhuCG2UyudwST
         qLztEgo4OuSxgeNqZ5+Y10QtPw3Kilp77zX9dtVnWbKufgPu/VMLJ3Htr60a/gIhmv7T
         fbbmp6fsZR5AVIH3nBntEZ6nhMUjZRdpvZsCu1HAA1C1Izb+h6zI3L41GPMM6xUZHaWh
         NVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783442760; x=1784047560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=li0pG6/934G8KYeHkJPSyW/NlEpOX2i7l0YxZTpF5vA=;
        b=BTgCL6Xgr0GMnXxkiCjpHLuU9m1cMdcp/gDsnUEd+33FLDSHAmWXkTzb780DVeDO27
         mcry6J7pSQ75X06nI2878RsQeRmqjWE8J6QrHZmyFiHxm3lgshnXVGrnEyC73hVVcyu4
         3LPYiXqr3Wb+/f1XyU7CqwXzp563auIbulMUWtEAJRl2T4R9C+W4FJ47oxrffEZjKSAI
         FcNKYfLEVq87bwVx6O4cpn6YUAa5ND3ro4nuzA0zO99UrxT4inwo6Et4NVI9rj2h4WXq
         L5s03Y9SMTS0JhX1EwXAHK245xswpTvdtXvmblI5SLyUHjLkWCeK0/x8OLiKl3mPpNfE
         dvIA==
X-Forwarded-Encrypted: i=1; AHgh+RohDbaLQSsJY4zv06XgisrZfaUgiKHgqC/JAE3QdmOt+9gkWgPmvSkRQLcssmL8rrTGhQj6vgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypboz0FyUSXSJ9ErOIM+oYFNgsl6uWn3ob3NGQaV7P8BG6YVUw
	IGOiq0Z1rW4W8+UA+t2ycAwQ3U6t41PA8sHMoE2b72osSX+GBFQJ54P23EqWXlJdyy+nfar7QGs
	r8AxPe4Mraaq3lfGq2/mR3uQASdtKtWrprpZgWnLtZw2L9hGzgsqLuXfd8Fs=
X-Gm-Gg: AfdE7cmA6wCXnIz8JI9/h0Fn+9wglWyrOdvvzztiYmT9AkVZKf8jpCAPH8NrMsI4nOM
	71bNGdiqdazjzZq+h7zEOE3PDmhOSYFvClwzu4qXO6i5iVd2Nd/c1ksAjp64RLSt2quhlZJ5iu0
	pnVPCNib5JIlBlyFtlyb50IlEWqBabZQx1IQGQqwkx7KX/2694BUIdhOAe+fV08W+a1bStyVnkO
	q4H+aFenMaT9yuccNcaKQI2LHaqg50xJv4wM/r/VFm3d7HzcpYEje1JKJbs5oVzkNhwhzDh3TZP
	yq2qY7RTmYmaJwjH6nINbM4yTXvmjZhkU+cUPqpfjbEAIxVKqGmBFnEcniVHawInFiL1JFS3QDe
	88xIPi0tO9X8VqSJrjyGUxK0wmk6scLzNLSmPkjoc80M95wlwwAYnBAngnh7A30r9xI3EcnNCWF
	3Tl2AgbHJVsWGKz03shuypnVTr
X-Received: by 2002:ac8:6f10:0:b0:517:6550:2a0 with SMTP id d75a77b69052e-51c747e7017mr67957251cf.19.1783442759062;
        Tue, 07 Jul 2026 09:45:59 -0700 (PDT)
X-Received: by 2002:ac8:6f10:0:b0:517:6550:2a0 with SMTP id d75a77b69052e-51c747e7017mr67956291cf.19.1783442757448;
        Tue, 07 Jul 2026 09:45:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13c3a0asm3798176e87.71.2026.07.07.09.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:45:56 -0700 (PDT)
Date: Tue, 7 Jul 2026 19:45:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: esteuwu@proton.me
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] SM8450 IPA support
Message-ID: <udhpg625pgm2zoeohuvlg5ndr6ivnjkrwxzy5vklno2ktcnro3@ryigk22l64ji>
References: <20260622-sm8450-ipa-v1-0-532f0299f96e@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-sm8450-ipa-v1-0-532f0299f96e@proton.me>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2NCBTYWx0ZWRfX0HfJ0Of31qdA
 Jr8w3bpw8+5kxS29ZPeFGE+QsNhX30MTTtCQj6g8LCSfMBc2Qat5UjEUpj5LdRUTAzDtvyP6AfA
 dkL8Xq+c/rLGCX7cCSh8Oxnn7Purpt4=
X-Proofpoint-GUID: _0XOdIc34XZYKid7S3RL272nCIh5jdcd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2NCBTYWx0ZWRfX9fWdFlSYf+NC
 Iq/42jVwamHFzR/b6Vv6lYXc9hQRJjddc/EvArxal630JoXJ7F5lABYWI7d1voQcS8uSwpqfm8O
 5xvs7uAl2YKknN6HAGI9saXzJ/9/bfTNo1zeB/Nb3XSWH89hbsulc7Q6C9/7FCKl64k+QiFM+m8
 qMiCfqx7hxehJeOQFmFLmWCNXjdyY0iND7RTARR867CkekZHWwmuwdtu9mdZv2wkFNPXwLRqrU/
 61wh2LyzT8mDu8hJOyHKx9ZKzeNYtJAAWX6CgsAt+ftyS4+kObNfxhGoFFg7Nlr5mCNZXPTqMs1
 rLyA2KzxpmkxDqG0cwN5DKS9JICg+uluARQeE4JGv54pS8w+v5D2UgnnHq2cb/jQu97RHE0iAV1
 Dbo2/CDJ3Dc4qDKapUwwd7DHYrX+vZGna3SUAmEecyl4/e8csAOXO96Z8C2benxBwUkxA9pCpNn
 x1YStzrwhzSNRDRVmXw==
X-Proofpoint-ORIG-GUID: _0XOdIc34XZYKid7S3RL272nCIh5jdcd
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4d2d49 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=MRZpAjOZwpHdsA9w-08A:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070164
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305534-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:esteuwu@proton.me,m:andersson@kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:elder@kernel.org,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,proton.me:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 426F271DFD1

On Mon, Jun 22, 2026 at 09:44:16PM -0400, Esteban Urrutia via B4 Relay wrote:
> This series adds support for the IPA subsystem found in the SM8450 SoC.
> While IPA v5.0 is very similar to IPA v5.1 (heck, it even managed to
> properly get the modem up and running), it wasn't perfect, since the
> modem would sometimes hang when rebooting or powering the AP off.
> After a thorough investigation, I managed to create the proper data file
> required for IPA v5.1.
> 
> Regards,
> Esteban
> 
> Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
> ---
> Esteban Urrutia (3):
>       arm64: dts: qcom: sm8450: Add IPA support
>       dt-bindings: net: qcom,ipa: Add SM8450 compatible string
>       net: ipa: Add IPA v5.1 data

Please reoder the patches:
- DT bindings
- driver
- DTS.

It follows the natural way you'd read the patchset.

> 
>  .../devicetree/bindings/net/qcom,ipa.yaml          |   1 +
>  arch/arm64/boot/dts/qcom/sm8450.dtsi               |  55 ++-
>  drivers/net/ipa/Makefile                           |   2 +-
>  drivers/net/ipa/data/ipa_data-v5.1.c               | 477 +++++++++++++++++++++
>  drivers/net/ipa/gsi_reg.c                          |   1 +
>  drivers/net/ipa/ipa_data.h                         |   1 +
>  drivers/net/ipa/ipa_main.c                         |   4 +
>  drivers/net/ipa/ipa_reg.c                          |   1 +
>  8 files changed, 536 insertions(+), 6 deletions(-)
> ---
> base-commit: 948efecf22e49aa4bf55bb73ec79a0ddcfd38571
> change-id: 20260622-sm8450-ipa-5da81f67eb65
> 
> Best regards,
> --  
> Esteban Urrutia <esteuwu@proton.me>
> 
> 

-- 
With best wishes
Dmitry

