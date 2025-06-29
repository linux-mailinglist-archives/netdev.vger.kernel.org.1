Return-Path: <netdev+bounces-202206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6389EAECB1C
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 04:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7EB117745C
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 02:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D633770B;
	Sun, 29 Jun 2025 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IfjSA3ly"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54F68F54
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751165433; cv=none; b=qVS9w8E5mMluRb2ZPIPaRenbGBTvqeku+4V6bCCJj2L4M5CRO4zjZhQd/hFq/4M0wlZ82NWCO4vjlEGW83BX+QYkSdxDnfGSlV9RQEzZb+4a7olGrM/RVCwTCP2ItqDIKw7D/ZJyOdsCLOMiTzDJv0BbobQAA0D3YI9WMGI7dgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751165433; c=relaxed/simple;
	bh=SZ3WelT84TIF+hZlmtN0iz4c58cHv4E32QHp4fX580c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syWkID+H9ctbDBafBOcYtYEzmT6oK12pu+LC4P/YtIIsUNJZJTMVjOgQhqOfnzPEllFY8YSZ1fv95c6+Ox35Br3C41czAqLI8sIZxoDHDUmRJYPnJga1jOnvnN2YAQydFJ9L9mNO2mWqii7rrMaJmK0q1GUINbSfyrhOHULLqp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IfjSA3ly; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55T2LZcP004323
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 02:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i9JVOf8bKYOZXSHoakkXpMm2sgNl0m6sGyRz0jx2MQ4=; b=IfjSA3lygR3iU2Fo
	3hqH7dd+iNOtFFe9zf5XiFV8VlvHZF2GJZwSzqtFomu27TyULxtu9QJ7sPvVje/q
	ZZjTGZfr05E1w8YquwkRVRurEdvpQgGiuPEohWMTuyj3jeXm4TW9AWqXrBLmJsCV
	trAyOuXGdcZ7dAd8jZn4smP/1cTPpGc7qeLQfGr0XSiZN6Bw3B/dz11hy5sWn65G
	kvOjw69acL3ZXUwb7OqNIBEdsQqgTuyi3j9aNTqYjc5B+CpzAeX7qEcu8Xf6YrqQ
	gnkI0HvBYdBTt+0zzLpzLFT5eANqRXaQgCfikTDu6fzYN3L6KodvUquxPObD0FWt
	2lVWSw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8fx9ker-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 02:50:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a6f89098cfso23784771cf.0
        for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 19:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751165430; x=1751770230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9JVOf8bKYOZXSHoakkXpMm2sgNl0m6sGyRz0jx2MQ4=;
        b=CiuqdEsHh0/TQZY/oDvCt/MG76FanKNmaVd4+JnmBo7yz0PSlyn1FZrsWgGKyb0mge
         lOrSYXknZ2AmXZk6l0HMIICtTcPiEHU9lEaDFIxy2QLNw9KllToyYC/eGuaTnpUNWCtb
         tI6S+7wRx4cDBRq2zePhEpbU8+lFVYX8rCBRbcKxPjug3T93MykbDmkb6dxwDjcIvE1f
         dOqFs6oA6FXALQQ3jCjlXu7YkEx+gazgm3njymqMvGpgVw5Cwohu2DF/jNosOx8dCSxl
         FsId2JDqWuhplodrYdvonk+INiHzlxXCvLojyN17THQn95WZFxuV0eVLfpderEUCjaHK
         NrDA==
X-Forwarded-Encrypted: i=1; AJvYcCVuNkXVg2m/BirTOo1j8zXnPYFT7BK0A0P8ffwZAKdMmqweWTshT+6srugwHVcU/v8BtpD1qWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnhQzWL044UhagiVx1yzZDFo9ycA1AyaOZrbODaxQWdGBpAU3s
	ljlWXurgJstsqbwcZUgXYnfjP6r2+8IjVG3xarexJQPlb5zZJMrHv+pj5BPONxzzw86ab4n7pMt
	9If5BUWNs7Jn5+OlxsCsq3F2wRPtdhc4bvMrNSQDR/EaG4BWc8C84MmGkBfg/7M36SQL1B3lTCG
	mdno4R+L7aloFRal00KXazK2wmaE+KkkeQdQ==
X-Gm-Gg: ASbGncuzOyG/grN0Y4J53cm2kF7PohKfki0nXqP4HzkSCM2X/i1pK7m9DGDkPFIp+LF
	8omHtvbjxjT0LAXVO6v5x6ZWDfCLDPlVFoMfbmmYXESuJGD+kOhd9T0a2xRQL1V2hGTz6IV6LU/
	nL5yaL8Q==
X-Received: by 2002:a05:622a:2c9:b0:4a5:aa42:49f3 with SMTP id d75a77b69052e-4a7fcadb7b8mr150204971cf.20.1751165429809;
        Sat, 28 Jun 2025 19:50:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmJnbRXFH3gg/Nd7+ZF6ivi7RKazfCJZm5OiWiEeHsXmQj+ixig9E5TZsifKgQBXEsrpFz6v9gPyPxFqCXn8Y=
X-Received: by 2002:a05:622a:2c9:b0:4a5:aa42:49f3 with SMTP id
 d75a77b69052e-4a7fcadb7b8mr150204721cf.20.1751165429404; Sat, 28 Jun 2025
 19:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
In-Reply-To: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sun, 29 Jun 2025 04:50:18 +0200
X-Gm-Features: Ac12FXwTvwXy-7P9RZLkGbTa8wSDID66dwjJ4_9agyN7BuXABGlvR6pgMlijDII
Message-ID: <CAFEp6-08JX1gDDn2-hP5AjXHCGsPYHe05FscQoyiP_OaSQfzqQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] net: wwan: add NMEA port type support
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, Slark Xiao <slark_xiao@163.com>,
        Muhammad Nuzaihan <zaihan@unrealasia.net>,
        Qiang Yu <quic_qianyu@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI5MDAyMiBTYWx0ZWRfX4z1mqmequ3ru
 T+VP4VJQ7I60+WZxgn5tAls8ExJt0+QiR49ub33BuYcBkYxDvC9Tj/Fd8kSCJRbo5vsPyvF1VNu
 Xw+XNV8UYVl6MprjAKgIAcPMKFzDx8LR2ed0l5SaFxVKqh92noTYNvSgcIHxsckSki5iBcteanF
 TGkKLEcUCuL367/617asoKNuOIYNy3NXCzG8u9L4MRuIobnciRLunYe19TYcZBrmJWy5R1Esh3r
 c7e3uYA537Nz3aGYaUsC9ThG6YMEQFXqS2VWoQNYj6H5ayLaIHCzAQ9g3e0S9Q13wd3tINv9qMm
 kEa4WSBSs0qx1qTFGUmSmta1/6eXebAcQyZ6ax0Jv8wH/vHYgq1FxghHQHwXfDCp/wF6HARrCvN
 mgrigwD3lXkBdZvRVgdfwfy30Elx5VBPmbrDXmalSso8WAfTx1JqgfeRNpZvP0qgBZYv6mK4
X-Proofpoint-GUID: 1DfQmI2pc5o28xcpPo6gPZaOmYxWc7ge
X-Proofpoint-ORIG-GUID: 1DfQmI2pc5o28xcpPo6gPZaOmYxWc7ge
X-Authority-Analysis: v=2.4 cv=TqPmhCXh c=1 sm=1 tr=0 ts=6860a9f6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=pGLkceISAAAA:8 a=1APRVNvs_67XWry2tgoA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 mlxlogscore=855 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506290022

Hi Sergey,

On Tue, Jun 24, 2025 at 11:39=E2=80=AFPM Sergey Ryazanov <ryazanov.s.a@gmai=
l.com> wrote:
>
> The series introduces a long discussed NMEA port type support for the
> WWAN subsystem. There are two goals. From the WWAN driver perspective,
> NMEA exported as any other port type (e.g. AT, MBIM, QMI, etc.). From
> user space software perspective, the exported chardev belongs to the
> GNSS class what makes it easy to distinguish desired port and the WWAN
> device common to both NMEA and control (AT, MBIM, etc.) ports makes it
> easy to locate a control port for the GNSS receiver activation.
>
> Done by exporting the NMEA port via the GNSS subsystem with the WWAN
> core acting as proxy between the WWAN modem driver and the GNSS
> subsystem.
>
> The series starts from a cleanup patch. Then two patches prepares the
> WWAN core for the proxy style operation. Followed by a patch introding a
> new WWNA port type, integration with the GNSS subsystem and demux. The
> series ends with a couple of patches that introduce emulated EMEA port
> to the WWAN HW simulator.
>
> The series is the product of the discussion with Loic about the pros and
> cons of possible models and implementation. Also Muhammad and Slark did
> a great job defining the problem, sharing the code and pushing me to
> finish the implementation. Many thanks.
>
> Comments are welcomed.
>
> Slark, Muhammad, if this series suits you, feel free to bundle it with
> the driver changes and (re-)send for final inclusion as a single series.
>
> Changes RFCv1->RFCv2:
> * Uniformly use put_device() to release port memory. This made code less
>   weird and way more clear. Thank you, Loic, for noticing and the fix
>   discussion!

I think you can now send that series without the RFC tag. It looks good to =
me.

