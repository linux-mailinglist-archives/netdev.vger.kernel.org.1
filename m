Return-Path: <netdev+bounces-247471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC01CFAF63
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 21:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B31230124D8
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 20:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F3F345CBF;
	Tue,  6 Jan 2026 20:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d9Kuwg3k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Us/marAh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C2C3446C8
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 20:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731915; cv=none; b=KTnQTawj5yVgLAW+fp7QZQzgTRmql8a4EE04WCOHH5M7AOSABB0e4cwx5qenXSufqlzaVd59e94b2Lg+wHhjsjgPvQM+wdofODKuS3xG+C2m6TK+y0Qr0G6+CFEui9Xz0EdMpQlC7FncKmkFiRPW/OPDZFPgYbWsMbFE4BfdcVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731915; c=relaxed/simple;
	bh=m+mqoHY9jyFRTwUjJOCNI3RXKOV9Ei7H1Imflz3+Z6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDiT3qJedH+ENuQm2I0nCt0XoRk9xTWaKFfz1aBzP7zMjfcWQyM+e0Mvda5HHEKlFrsfrTLQcYOlkhgyAdjZYFQZ8QR9bfaA2g0dMDIr2SKxU1pFWqxdNLkFM0EuMuc5q4XW8IzTvCjuQ26y5PZ1Nvb/f6PghX2tKyegJXQGL3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d9Kuwg3k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Us/marAh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606IZOxF805162
	for <netdev@vger.kernel.org>; Tue, 6 Jan 2026 20:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pgbYcoRfksEGynoETQjAaX5B6RZgXXVK6cJiP1DX+KI=; b=d9Kuwg3k/tS7OPn1
	XDfNqNnzRMSaKD8DmJvpMSXZWiQtS+tba70AiTvcYHhbqhukgjAfsnMKFbM2ZksB
	fzxVcqemMFVlmLHCPYFYqLoQybZZg4XWldOKS9mX3bZ5YBpisKJgaeBVNXxSyC7C
	H0i+Gu5ppt9T4aZ60I9FdvqNlfrdKnJGk6j0x7ow46pQbB4neMFN8Rqc4nOPTf6E
	ll9j04E1bGi3vVQg7jGNr7AHfyofFyqRjy5fjm/OQCJBv3zqo3cH/GPneARx20km
	9o2XHrzllGeoJ51Y6kvUUyDLsJCH0vFvvfhjX8n28DbDaCmrV265JBrHNxqD7j5T
	r9OTPw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh7t9gasm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 20:38:31 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88a43d4cd2bso19292896d6.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 12:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767731911; x=1768336711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgbYcoRfksEGynoETQjAaX5B6RZgXXVK6cJiP1DX+KI=;
        b=Us/marAh0PAv0OukupVWirdhYiRDC5opNxcZZ/VS5BuHacjCLYTr5DDlRZ3wWv9f8C
         8AM5eaYX5MRlosFbZqQermxhRwzbf0q4zvJHg3irNvHDkkvZ+3+klsg/bHuohrvX6aIL
         OCpsg6ACoy04EkXLv6hLJfSNEHfzPJeW1PMZm9fhujr5mg+OgUCd/9mT0BKQK29kwkOp
         twHVfu5pmgnEwtF8ylBPvQktLpRePtmzuZCAgW0hpL5Fo0SsY+OMprAqDUXkP26cLoky
         oi1E1n7AJKt3iecWD4jw0J5Cz6xYw2u/5yADZRJ/z8ZPoONRcCpUfsW7htRT4Ao1Togm
         tJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767731911; x=1768336711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pgbYcoRfksEGynoETQjAaX5B6RZgXXVK6cJiP1DX+KI=;
        b=iRHETX6v2hsDelsMjB1OavfIk80DHOZy7e1r+yDFTBjXPS9VtKtiwtsDzGk6Iv8M2b
         H+u08jRluqbyx4YT7yiheFLAPIemR/5M1V9e13qRXuxHD6cizkUJSnzlntjOxvqxkyIj
         /fpsiDiJESpEhdECLKxmtDA+AjTYouOVIrwz2pqWvkF5g3TFtidRTMGhJE/EJBDrDb0r
         haBiMt6d84Zj5dYJ/vX+Qtas/0fTyRZJqO3vjYSkqM9R94a8jK6OlpX8TArdp6B4vRou
         9jMJ0dtfMCCJJwYtXQrTDB0TqGGYDt+NhP1tflqne51/8uTEys/LhQLwvJ5sFocPoUzt
         tOVw==
X-Forwarded-Encrypted: i=1; AJvYcCXeGQJsrM70PF7931ShZyjoZkc62kVA8Oc6kphRaH4iM3Zwth/Cm1JCr00YfOVWO1XWmwO9QQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6H3YlFVTUuzRYLqZXW3VYyc9cp+scGzPrM2LnA4VZIfkflMl9
	tFJYN8uSbCOYL2Xyu4qBNyJiAUs1ejYdpPxMoiiwyJa7v0Q6NDvqYI2pWo/fN6+Sz0rilBsyT7L
	DSdXTp1CvoUZ19eufkR8x9Rve4rcid7LvMmQlTnooIMCsVgCQNfljV3JUTILcvMK40ZsiPiJ8aq
	rzJNZRpbAV6KGq4KZG51zZaPWKGgJYuwwtvg==
X-Gm-Gg: AY/fxX67HYQtLqSiJB18ynC4t9DY1UHOpgJCm6Zp/U2TwesKBWFi6JBlLKvXuexayPn
	w+fUkq4NoRH/nLzJMxnBUtArjaC478IwIp8EpWY595yQ+Gkc6/c9lpIILSIBE5pRNsj43gGUTmx
	wghr23TNiz1/pGygZoyXFzeAngDze8yQhbdLXLTJO/tbAL6gbsImxoyixnX14zYzthRVSUqfj9r
	vwNnnmL0pvzFcZ2SpueP0Pe/Lc=
X-Received: by 2002:a05:6214:20c7:b0:890:271c:1993 with SMTP id 6a1803df08f44-89084183a00mr4223386d6.7.1767731911257;
        Tue, 06 Jan 2026 12:38:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBBLtOM0ea4b4KKucdo0q8hx1o91rWXZpTMQeJ8xsbjVMrZP/Q0raFt5Wfbq7mPFTYWXq9YR+WaGR1Lv6v5yc=
X-Received: by 2002:a05:6214:20c7:b0:890:271c:1993 with SMTP id
 6a1803df08f44-89084183a00mr4223096d6.7.1767731910861; Tue, 06 Jan 2026
 12:38:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105102018.62731-1-slark_xiao@163.com> <20260105102018.62731-9-slark_xiao@163.com>
In-Reply-To: <20260105102018.62731-9-slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 21:38:19 +0100
X-Gm-Features: AQt7F2p316PMEj5I0n1W74Y6VYMXxlMdEkuAv5wrQLsQqcvIMgNzfb2cB-VZfIA
Message-ID: <CAFEp6-1j2nb+aJ1GCrRdHAYxzVam1fw9i=v9RfQRKs_GxqskUQ@mail.gmail.com>
Subject: Re: [net-next v4 8/8] net: wwan: mhi_wwan_ctrl: Add NMEA channel support
To: Slark Xiao <slark_xiao@163.com>
Cc: ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mani@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: ElKkjEvlcEJRXogOkBnytU0HnQIqu38x
X-Authority-Analysis: v=2.4 cv=QfRrf8bv c=1 sm=1 tr=0 ts=695d72c7 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8
 a=laIMyccDeTmSpVvBuxYA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE3OCBTYWx0ZWRfXwMjBFJGEBQqz
 I+heqar7T11SDHotwwVODaDw7wCWCyqCd3Va1Y3sTG+bm4QCI7ZDHRRin1vAOsNexuc3CKHTaPi
 kIuf4o6Z+vc6buHZmkQb7c9xy83BEfQyN6WXRaPwTI5oLdoIhgs7bd7xwAQA5Hbp5JwDT9wOBAc
 U0nlUXY/DijSe+lwhFi8WNmYh44dbc4Jr58JVBc+OxU3cXJajXD5MEI3sxlGGxiNc1vAPggQG4p
 Ltza6o5WVHPtu7g0RKN3heu4Udq//Ytntx7k6yvIbaBxqZ1/J6nELwzgRalmWeP1rZtM8BRHDGM
 wHtDnJbur6v4ZGRfrg7DKOTHROk+dNTjbmwGpax2/nC4LXxyxNDDgAxXI1ynYBJGJA5/XDTDd4x
 e7HDAswvU0kgUwflz7NvcR/rcrV/JbOR4QCirBeEKFVsdhUckK9YIsMP8ILZ/tE1ryPeLzIT4Bm
 IYlie7HarFbslm1zBBQ==
X-Proofpoint-ORIG-GUID: ElKkjEvlcEJRXogOkBnytU0HnQIqu38x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060178

On Mon, Jan 5, 2026 at 11:21=E2=80=AFAM Slark Xiao <slark_xiao@163.com> wro=
te:
>
> For MHI WWAN device, we need a match between NMEA channel and
> WWAN_PORT_NMEA type. Then the GNSS subsystem could create the
> gnss device succssfully.
>
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wwan/mhi_wwan_ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan=
_ctrl.c
> index e9f979d2d851..e13c0b078175 100644
> --- a/drivers/net/wwan/mhi_wwan_ctrl.c
> +++ b/drivers/net/wwan/mhi_wwan_ctrl.c
> @@ -263,6 +263,7 @@ static const struct mhi_device_id mhi_wwan_ctrl_match=
_table[] =3D {
>         { .chan =3D "QMI", .driver_data =3D WWAN_PORT_QMI },
>         { .chan =3D "DIAG", .driver_data =3D WWAN_PORT_QCDM },
>         { .chan =3D "FIREHOSE", .driver_data =3D WWAN_PORT_FIREHOSE },
> +       { .chan =3D "NMEA", .driver_data =3D WWAN_PORT_NMEA },
>         {},
>  };
>  MODULE_DEVICE_TABLE(mhi, mhi_wwan_ctrl_match_table);
> --
> 2.25.1
>

