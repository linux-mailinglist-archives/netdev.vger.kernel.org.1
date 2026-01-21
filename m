Return-Path: <netdev+bounces-251907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHPqJarocGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:54:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0A958CDE
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1C7970744D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED442478E3B;
	Wed, 21 Jan 2026 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W8TPfTAy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vzp7OrxA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006C546AF08
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005009; cv=pass; b=DK7WbvWvikfQJUN82FPfC1WrNKhr65+LFqLqqEJJL9ps8S1bOc4nHH3yxepHdKUvX0pUvvsay9OuOsV/ewUPjse1/mlbyVJ/V2S3/VFZGcNEyp1U+ruq+kysCGfvGAbQo6wVdSGUVfZI10M1Z++C99dqEqDZ1UxJmPkx34q95uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005009; c=relaxed/simple;
	bh=HDMLMX6v92ElO6EtAKPZeOznHAgC5K9lm0OxQ6VLAe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHPkxZfhyK8CHAZ6FgdnxeKuGlPu/yS9gqZ6G6xmEG9O7MuDA0/h+arLeBlnOPkJRfq+C8WZ94zl14quwdrxeAjWuUGDriRsl7rNCL14xZ6SHmhyDqiN0ZjSPFbsKQvLoELE3WzALtK/SQmftB8iC3gNCG9eSD29m1jxOfHK/Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W8TPfTAy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vzp7OrxA; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LAeTrX2817204
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 14:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AEyB4/I7HH78+h+bRGj3JH5n3rmPrdJEct8M18UT92Q=; b=W8TPfTAy3fQ1r11d
	M35N/Lm4P4g1B/w62Xk9wemPeGUs78KdN9vAuOLnONXm4dKJkPJf7KcU7bM7HuLH
	Kxay9ZJ3DuhgsLxknCzKDYzUWC+uodbuTSDuSKiHJVsU2mgcNnI7mJoC7yl4PV+j
	FpzNUipwp/IMe2Zf3k5zOBH2DetMsA/PSPaPZ3qLfJY2Ila1Y+dBuCVXvftNqBJ2
	P1Hwqkp5PpJaQ7+quxObZNtXgxv33fEJz/D9QeDZpbtOFBIHK9A+B8lRZIPjDMDC
	5/6mnaKzTr73z7upqZljSmgWNnpt0Drb8IDPaw6m2YcG4l1aPT2UEd19i0hQPaI0
	rWFznw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btw8kgnj0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 14:16:47 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88a39993e5fso154032346d6.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 06:16:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769005006; cv=none;
        d=google.com; s=arc-20240605;
        b=MRjIqq+5dEhz4QRVcQIZmzNwYt3G7qqbYEM9p57Pgi2F+QTAhpipiB/ksYT8s09skh
         0/QMUKWxmLJhQYHqiqsYyX+07ev5vyLhCzvUAnv3u4VG6HGmxJa8sc6gO/XiVQoex8Mg
         /9gRWfWZsGF7M9Rn7Z0JpkmdoMmVSNHSJ4c7B3nuSQIVM1OCXUQ+mipOJNGl0gQuPG+H
         nWdd816TO/NA0E25eAh4UIzocs3Jl/zFsiKCokHsVA1S8mmPn7PrO6oM4wy4ebSW1bJX
         ciFmo14nJxqQfEQjg8sSLti2bI05CsottgQoVDtUl2PjWkuS84hPHCHJNnXbXNi2FV3Y
         X9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AEyB4/I7HH78+h+bRGj3JH5n3rmPrdJEct8M18UT92Q=;
        fh=eL4S3AazyHr4c+RNTp3gSjAA7kmbMKu/l3fJR8cyG8Q=;
        b=SeQOTNxSinj4F/Nvs71o0gY+2A1Se1ph2KFHRAl3Z0VwehULDab0fig7MYNOwSYoeC
         KJYfWwCaj1RRnYhpYt3zgmB4l8yvVocYqj0x7NgWt/R/jTZPVNOOxCiMLTwYZL7xix5u
         O9R2Q6MihS05Eaq/0JEVFTmgzDsFsxn+0pEiOsFUdA/pAgpzLXkS1ozlMHBE1JvTaDlT
         SBdOAVt3YyHZl479ArIK/fk7OSrO9NEJTi6VZYMOWZTXx+3vUYJVeGZXCXSkRHsqN0FE
         0aIVx1VX591yC43IHMYAAvmPKs2UuaW90ztIPDTJE/KtPG82gcLvX5Y9cXUKw13y9lHB
         PzTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769005006; x=1769609806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEyB4/I7HH78+h+bRGj3JH5n3rmPrdJEct8M18UT92Q=;
        b=Vzp7OrxAIrjtbQWRxS4iz6y4okJyi6NEGOsBfj539WNdkgpdv0qBqaxyY84H+dTs+z
         a3xIObMZzyRnFHEgLeZzCtkbM0URyq8UsT7MR8SKgG7NHKweqAe1qWkDEtI3Ymdu+sQ3
         fUMz2rVch0GR5XgsumPP2PYantBHqwbYeVm1izhZxGSGvvpnfqCyGG9fiFuvhmiE+B9g
         CmKlyE/chnCx9Sl/+/8pUaG8kfrjHhsaYTUGeRINZnu9NCgxgyPOObBtEh4uxAXRO9E5
         Pcgpc+6ncU7DsdG0gEcBS59/HuA6mBfA/OYAHsmYA9JwS1kV/X7yf8J0emW9RYzJkaZ7
         5vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769005006; x=1769609806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AEyB4/I7HH78+h+bRGj3JH5n3rmPrdJEct8M18UT92Q=;
        b=w0p2ibvmbkDK7h6PfNrAgiUU+sDdYPSfBXSkgXQ8kD9AHCfY4eGmkbxaPBJlyMbBK4
         Rb1WYiXTJ/LI9y0dGXCQXEFBtBDfaK4z/Tr5GJZr14bDhNEaTAR1MG/syiSv0KXn9b7A
         ZGAZt8AlIftFL6KyHKCHB8OgZIHEBt+cKD6GARH5/2N3RRlYQkaVOrT90tWDd7xeGZeZ
         E9m9FG07UCCuZ9RuLjmEnbzksxriHW+hnrWoM/qGEuIxeKRpx5TyHJCGd2J0Selgx/JN
         ri9o+g8XLm/2DWi0A7fUXebAWRkH2z1uaUFSHGTZqdfjdiK58HyEu6n7BUJ7Eq/CbWfN
         Gvag==
X-Forwarded-Encrypted: i=1; AJvYcCVv8PKX/mf2EC9p4sFGwft6ppSAyVbleaCgsWuAOSX8HwqHZKJT5hingCOWVL+GgLMV1i6n0DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYrOQBmxrQUk4mUxhqMtcxc3AQHoje02Pe6xXPUxpHxRk12IhA
	dEpx+Fh1o4EHLciJMRaZWkaoRNEXa9Q9xVUrkR1yeA+5DNzufByBBGf0p8LZOsQ/Tde3x5c+lw/
	PetHgtGTox3aeSIyG2Cb669LWtUwG0uqZ5cdPLmiUE9ZINED76hyJzAuR0UF5CSDHacSK2ccQIb
	0ODGWU2RKFIIVkPpqlesZ5Ec+hdwe032dp8ulZ+VMNjZLW
X-Gm-Gg: AZuq6aLTgND0JOLWXNuEEixgpXvY3yxBT/+rhYjUzHoYhCtSlhdo3e0T62YJISpKpcR
	nF8W4VcSVN8PO1/34raD38Xgr592NXu0Fjjt6thsN2qhF8bT4W6kfGYq1BaLTkLPyb16SeqvbKo
	Y9wYRS9DxyTEzel84LW3Taucy0pXuocinG1elZfGMME0qiMuhGCfuyTAwpzbxvt8Yy+4SbgBCDb
	VQ+zjoCD03qg+rAsvxd0NN9s3RS
X-Received: by 2002:a05:6214:401a:b0:890:587b:207c with SMTP id 6a1803df08f44-8942dbed751mr232206346d6.12.1769005006072;
        Wed, 21 Jan 2026 06:16:46 -0800 (PST)
X-Received: by 2002:a05:6214:401a:b0:890:587b:207c with SMTP id
 6a1803df08f44-8942dbed751mr232205756d6.12.1769005005501; Wed, 21 Jan 2026
 06:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115114625.46991-1-slark_xiao@163.com> <20260115114625.46991-6-slark_xiao@163.com>
 <aW91bYu1ueczfGTh@horms.kernel.org> <386ee1ac.1e15.19bde4f5bac.Coremail.slark_xiao@163.com>
In-Reply-To: <386ee1ac.1e15.19bde4f5bac.Coremail.slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 15:16:33 +0100
X-Gm-Features: AZwV_Qje2jquqmear9rIkY6vQ1iP8c0ygPnaWcQ-LDvk-iCMNkDMA9R2dysDO5w
Message-ID: <CAFEp6-1X4=70mCGYQYkvDqeQxgP64=Nu=yZxgBqDAK-hbYN-Mg@mail.gmail.com>
Subject: Re: Re: [net-next v7 5/8] net: wwan: add NMEA port support
To: Slark Xiao <slark_xiao@163.com>
Cc: Simon Horman <horms@kernel.org>, ryazanov.s.a@gmail.com,
        johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mani@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Muhammad Nuzaihan <zaihan@unrealasia.net>,
        Qiang Yu <quic_qianyu@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDEyMCBTYWx0ZWRfX81dakjG1uK72
 sfqvzCgSVhRu5e0K7D5NH8k3e6+pmzcl2c0lb2sTFBGctScwsH8n4N5hyq4bNE2RXQtnZO+40MH
 MAVjgrAp/pmWiMn4Hj+Ht+miwVeoc464WSGrsfaajWwvxS4DGpw1TNtZiOFK9hR6S74Fk+s5744
 xzmyq2NRv6EniU39yLORHZxhcKjl3bimrnGhxJOTsuLTCWOvRIgAqjAOudsyTwUxhbAhjdSV9rW
 cTwogUCtLvOwtNqEM1U89ja08tDm5/DJ5ECbUAlVbLJ7Uf9uXv1KPbiTerR9Uj6eAiIvyK35prG
 /tzp+jSDV0/W+UTsbsiA6Tp+A9GYA1YnXhUxOszdePxGIV6B/UqBkbhtYiVz+03Vsesb4hvN3ak
 I1BbDZb8h4jTpfi4aNndnZsxwNsvm8PFsH9pl3jcNwODz3gAn0YtNL2nK9/yLJerZ97SbzXnYt9
 O8bQdGqIaZ+z1mYsqzg==
X-Proofpoint-GUID: 0r3TvHE6MW3LjYu3GXPMOs6FBVNfxSuR
X-Authority-Analysis: v=2.4 cv=BPW+bVQG c=1 sm=1 tr=0 ts=6970dfcf cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Byx-y9mGAAAA:8 a=VwQbUJbxAAAA:8
 a=5zDEzIuhj-Q3drrMHM8A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: 0r3TvHE6MW3LjYu3GXPMOs6FBVNfxSuR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_02,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601210120
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251907-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,unrealasia.net,quicinc.com,linaro.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid,oss.qualcomm.com:dkim]
X-Rspamd-Queue-Id: DA0A958CDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 3:09=E2=80=AFAM Slark Xiao <slark_xiao@163.com> wro=
te:
>
>
>
> At 2026-01-20 20:30:37, "Simon Horman" <horms@kernel.org> wrote:
> >On Thu, Jan 15, 2026 at 07:46:22PM +0800, Slark Xiao wrote:
> >
> >...
> >
> >> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core=
.c
> >
> >...
> >
> >> +#else
> >> +static inline int wwan_port_register_gnss(struct wwan_port *port)
> >> +{
> >> +    return -EOPNOTSUPP;
> >> +}
> >> +
> >> +static inline void wwan_port_unregister_gnss(struct wwan_port *port)
> >> +{
> >> +    WARN_ON(1);     /* This handler cannot be called */
> >> +}
> >
> >Please don't use the inline keyword in .c files unless there is a
> >demonstrable - usually performance - reason to do so. Rather, let the
> >compiler inline code as it sees fit.
> >
> >Using the inline keyword in .h is of course fine.
> >
> I think this shall be a mistake.
> For a GNSS device, these 2 API shall not be called frequently.
> So there is no necessary to add "inline" to improve performance.

Indeed, it's fine to remove that explicit inlines here.

Regards,
Loic

