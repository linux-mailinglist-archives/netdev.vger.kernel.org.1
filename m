Return-Path: <netdev+bounces-198357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5862EADBE2A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 02:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F2516B065
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD0A16B3B7;
	Tue, 17 Jun 2025 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AVig9xNP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28E214EC46
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750120203; cv=none; b=luDFdzlXecNSOq13vruL55OoggI6RnFuvjFNptbUKOJqVQx9rEu6S7ihgkiWYngk3a7idkWFuPxY6c3VHgEIxLSa5TTKkwS+ItPN7spqbVVNEd4wHfFRhfvMy7lz2lgZfKjmsaRobC4ryAbgkD/8RDVHZPglvKUPxNixfr3tOb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750120203; c=relaxed/simple;
	bh=/OvAXeXnbc+SV9Vq7CWaLCrhrnHUxMr1vpR5Fbdm0Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEO03mVh5J4eoEhCMblscIc28mYDP1gqDRfJKh59zguI0mZtRx0sDydFfmpRWafjJzLpdH295zLXgk+qc1Ku4DGHxnKagjAKGxU0+A9rpzCS9v7eyR/wbcWHc5ePetW1dVDstrqMFYaprBVRPHJrlaeKb2SqLK29wVnuWdX4fQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AVig9xNP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GH4F4G028015
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 00:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PxBxdB6UbGf0Xh3ZJWJL1VY5sPor29vDeLUN/9Oy33Q=; b=AVig9xNP007KmNUZ
	3ZknusRj4RY7El0ln90ryEoAzzf9DfFJTbVHUdyiNs7d2SrzkQy2wjfQJWNW03du
	44cMGgB4GKEWygqtVe6FamKUKuPfyxHPScMEGqCtm+9oaE/P1L9LfkCHxcEhKX8C
	1F6D7Kk3uGk7LOVxgKPFHuNQcTz7sg8preOmKQl1EhRFXvhLhOnlYYzJ45dLHPDU
	MuLll+5WtgNtvRgPj9K7yQt+OBs/onG1UZOyAar2JVT/vf78np530uVig/dNoNgv
	3bkgFmlqKmXzBdH5zoBqMSo5yVO1FuAQfcl2hTwWer0rMdx0K757G9BTTDIwqJni
	iIDRaA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791f769n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 00:29:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3132e7266d3so5229069a91.2
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 17:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750120194; x=1750724994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxBxdB6UbGf0Xh3ZJWJL1VY5sPor29vDeLUN/9Oy33Q=;
        b=ipdiHzvEUeBRNlbzonEYAfXmrWPDTcSBq85kGeF2f+/BQwwd5dcafl2XG/++fhe8w4
         0nlLct4KsuRqnH/pz10FqpbxEZlBxDEpQPI7XHCvkobolyxvGmKDiP45NNTUkoquZMj+
         1TRU7lzLNhmvEUv2IxMa2bPmkK1rySfgPFns0SeMqCrzzePTu8wHFDB1u9DH9DJHPmv0
         wxWUY//+5fC2TkRuDhexbz0DlnrQSGiaB26UIW20gWeDS0UGuleJN3cxmt6fnNgOcKt5
         cl4Nrf2ESMAa4H8+c1PJiV+Ds9FuurKo5DK7ufk7YaJyroVmslEY7ouqpXvo9AhRAFLU
         F93g==
X-Forwarded-Encrypted: i=1; AJvYcCV/7gNDrc5wi8hyz7EzonI0lBjZ4gmgc+jM2bHTvkZMVorLJCXkIfE3KLwK7B0GevH0q+XV564=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1nhpXm4fKIHKzsIxv+0vRSHFzv8osJQoGPs+qULeT9yT2WIDj
	cBTe6c+/rqr9gt0GDkwzdfAfc1H18Bn39hbusTIrmN8EimlnFKfGHzhCoP1dHS4JbdjeO1xSCjr
	7a2lma0y4Pl/EAIgf1IXVc2OfUJ/V2m9jD9OS5ETjz2o6H98op6+6y54/tllsmgJvnSn8fuNHki
	Gnmzj6Sy81QU6hiEcj4X4EjHYtNQfAyk603w==
X-Gm-Gg: ASbGncvIsDRiCqjdeaIdpcExKteotWVdenX2bOOxhOQ5DWbAZozaWt9HLoEBFTedfH/
	PUZfb/pN5HDu2up56g7L8Iaq/Pxc15K9zd/hWWx80kplUmzbYtJCZw5flDsHOztwg/8wPTLlt8v
	GebJPA
X-Received: by 2002:a17:90b:48ca:b0:312:26d9:d5b4 with SMTP id 98e67ed59e1d1-313f1d4f258mr19603861a91.17.1750120194173;
        Mon, 16 Jun 2025 17:29:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSNC2kTDTNGwuTiWe+hV85H22cRA1JUcvRpOafMzvyazp3L8h7VPy14wOxOhT9JVskFD/RQnNoBw74CrtV0VM=
X-Received: by 2002:a17:90b:48ca:b0:312:26d9:d5b4 with SMTP id
 98e67ed59e1d1-313f1d4f258mr19603817a91.17.1750120193711; Mon, 16 Jun 2025
 17:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604-qrtr_mhi_auto-v2-1-a143433ddaad@oss.qualcomm.com> <20250609160042.7a8940d7@kernel.org>
In-Reply-To: <20250609160042.7a8940d7@kernel.org>
From: Chris Lew <chris.lew@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 17:29:42 -0700
X-Gm-Features: AX0GCFvc6F2pbAeWVNoCAEXGSMZa2DpN02Ww52JJsSMr40FBqwooK56KL_L_0sc
Message-ID: <CAOdFzchj8KKoBd-wz-KZbNu6V4BGWq6U0-spPdQx7TDCv7U9nw@mail.gmail.com>
Subject: Re: [PATCH v2] net: qrtr: mhi: synchronize qrtr and mhi preparation
To: Jakub Kicinski <kuba@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Hemant Kumar <quic_hemantk@quicinc.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDAwMSBTYWx0ZWRfXx2dUdwgtUL/n
 j5or+L5fhd6Hp5UTRsZVfWQN1N8kJ5GPFExjl6aN//UfVBDs5OsL8nAF1c9Jv2wWMD72+AtzXPp
 YaPuoL1jFD/U2+UHnIuGqU0wTRMtHVcgEUS7FOnAjkTCO2bPgoAxYeQdSloit43puigOtGswUvq
 UuMwk4z0zL7pWYHjKMNqagPPWzNY4dmEktIclL9eAWtVNbRi9FOn2/pVE10FFgP2TTMD1xDeqMM
 JEwSUem9uOSQdiVGMMAXhWEbbyaaULEowGy6mY8mqKJWoOKf9TXO+SaCO/qQaRYAZz9Kq6rwqq0
 dPBzNN7Q9E9oa5hVLGS2Q4FRYonBNjDABFZNh3Br6Xat9kW+bT/0SsHKshisP25NX5TYKW9Qghg
 0uDCz2IVSDDVsPwYVHeKSgkSi3wor9Sf2SIwQe9h37KXpyRyAqknv++KBS52GkFaw6b3U1ft
X-Proofpoint-GUID: GKeZ_1YngxEWerz_sHFR7Awvns8ruMVI
X-Proofpoint-ORIG-GUID: GKeZ_1YngxEWerz_sHFR7Awvns8ruMVI
X-Authority-Analysis: v=2.4 cv=FrIF/3rq c=1 sm=1 tr=0 ts=6850b703 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=VwQbUJbxAAAA:8 a=UYrFKEw7bejQHJ5Mm34A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_12,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=665 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506170001

On Mon, Jun 9, 2025 at 4:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 04 Jun 2025 14:05:42 -0700 Chris Lew wrote:
> > +     rc =3D qrtr_mhi_queue_rx(qdev);
> > +     if (rc) {
> > +             qrtr_endpoint_unregister(&qdev->ep);
> > +             mhi_unprepare_from_transfer(mhi_dev);
>
> is ignoring the rc here intentional? may be worth a comment
>

Ah no, not intentional. We should return rc here. Will update, thanks!

> > +     }
> > +
> >       dev_dbg(qdev->dev, "Qualcomm MHI QRTR driver probed\n");
> >
> >       return 0;
>
> Note that we return 0 here, not rc
> --
> pw-bot: cr

