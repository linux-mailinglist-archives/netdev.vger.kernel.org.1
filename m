Return-Path: <netdev+bounces-194787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72320ACC764
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 15:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676077A72AB
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7577C1F582F;
	Tue,  3 Jun 2025 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NufXdo3j"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69C12745E
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956284; cv=none; b=sQD9eG/RS3clDsVwa83eAfHPBqhSFZeQm+OpmhsC/W6GMYNJGeP7RR0YHo0VrD8KS7Ndlh9HgeQNuTbzPWwfLdJjSnh1omz2FexkSOfRadxIQK43lABxMkhSa4QJrP8Z8TLRjcdSJ6jv62ucwqK+y8soL77UismIYDQu693TsKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956284; c=relaxed/simple;
	bh=TbKV3/RDFoI8S/Wi7InOA70l+ab8kgqF51huSVGh2MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKdIbUlWwqpV+SlhAg20emmiR7ilPZE1bPXjQPzv1lTaa+NWWlGzVnIE3fGOj5rv3leXomsLOSbtZvpOTmYJ6RMzn9F75FmL23Zapxr1On28oEWYtcEe5ytIu6FgYlMZ/JkI/2Y482OBsmAdantkSI9PaM8MVmWc5FJ7rXk9Gjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NufXdo3j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5539JUBP000905
	for <netdev@vger.kernel.org>; Tue, 3 Jun 2025 13:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vx4mR9/yjJyUbX937a2wax+tMVYoVmakZ/SdGBT6cew=; b=NufXdo3j3XvH3SZL
	eopHZPMTE4K32rCcz+Q7hIiEUeGjDUh/vYmq8M63FXehJOofh1+ReIKWArYJ/J+H
	ObRGm2nX5VskZeA4qIqWIRPlAMD7PMsTEKQLXCQ9OxT+r6znydIMI4u7xmn7VEYT
	U06xlP1xmnD4HE2VlaG/9t5nTw6WpbrDbVQFbMVnInvGt5/IssSgUat/XepkeSHd
	gjIldZtoF5lMBQRQPTchaFGzPcoPrrRxe7WV5nKOT/cVWgnk0s/AEOwe5yOyGKtF
	/GSoRiddp+h0sdOAyBg08QeqjSJHxROgGqJiIImkP22vEA/kGKZP2mbwqqPKIGDZ
	wyLQhQ==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8q2nwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 13:11:19 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-60efd18a0dbso261661eaf.2
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 06:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748956278; x=1749561078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vx4mR9/yjJyUbX937a2wax+tMVYoVmakZ/SdGBT6cew=;
        b=OIJqPeToMOORlkB3k6xNqg7HzRL8HOPPic+IXmH0kmA8yf0QyVyeJAXuZc+fMVoesv
         3YVzG7LXp7LmwLZaOyiS0qp7avjc8I9fMhqxdt7auKYoKMgF5m8yVhol+ZR/nB14y7bS
         qJRFlTUoGV64ZqY9V8HWXV0Gw+m4Lum2O+HmynO6DJej+v0nOlh2H3bdRNm88rGFkovj
         46vCI7bmcHR0rCRf+Bv8FA4tofu/MvVdA4DBdwLk5X4rZU2YB9pMSpexAbb/65zycXo9
         +toFJN375XeCSZkngE+T2cUYtKf6KBzVAFMvMuG+1fjyUcSusAvMVgyyJfH/p3F2Bj1P
         UEsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaWD64V9nqK0SNwg5UFoo3j9uKDQvz8xuIEOki44RtlJMGxyP+iPPQL8zfzI5Y8Iyl7Hb9zqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9FxY+MwKpE1ZedpjPVcO1XeNHengZIQCVWlUlPJXzOHqZQKj3
	S/eR0OpbqD0Nl8R+BqtHu9GSyTy2njcH0h6EQVQl3CP+8HgdTZtbb+m9IBLmCyWja/3FbCm6zN9
	s4cRY1ewwIECxm3Ilukpkq99HDL8ygIZPNltnTfn1X+ZddhvcCCKogzAzaheFF/lnIUr9dQePeZ
	OrZdxI8McwvGOkBVm9CxFzsPulVfOW8lMSQtVOe0tYE9K8X4Ixuw==
X-Gm-Gg: ASbGncuHNLH8ShvHYP0T8/b4QbPmpZG+ZIFlKxWy4wJ9OsC+Ar6/PmtHY3zvZeIk+l4
	oUZbQ/579MgQ3OY0CjwU92dJh+s8LaA2IYlZxfGRE1xVYvHzm3V5tBNML5CbA5EV2fxvW3Q==
X-Received: by 2002:a05:6820:178a:b0:60b:6a75:2107 with SMTP id 006d021491bc7-60c4d6f86ebmr10186940eaf.3.1748956277834;
        Tue, 03 Jun 2025 06:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFmbVLFZcUF1vChZX06WBsp2sysQGTD1ki0HkV4ji1dxmyTaCyAaFBtb0QbvsTWVIXOCdUCCb7fTiz8mgMlnc=
X-Received: by 2002:a05:6214:258e:b0:6e8:fbb7:6764 with SMTP id
 6a1803df08f44-6faced5d164mr282629536d6.45.1748956266974; Tue, 03 Jun 2025
 06:11:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603091204.2802840-1-dnlplm@gmail.com>
In-Reply-To: <20250603091204.2802840-1-dnlplm@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 3 Jun 2025 15:10:56 +0200
X-Gm-Features: AX0GCFveA17iMqCouj12-mLZyTZuPpXoNHicrYDP9UP8lyP8BTsjv6HfoI9PutE
Message-ID: <CAFEp6-09wwTxNVodaUCPaRhycz=oyHP+9yvXA1bK1GejrtNSQQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net: wwan: mhi_wwan_mbim: use correct mux_id
 for multiplexing
To: Daniele Palmas <dnlplm@gmail.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Slark Xiao <slark_xiao@163.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 5PvmHl9RNN5JZTvlTM6gHI2KdYzt3otf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDExNCBTYWx0ZWRfX+t7WIm2yhc/3
 2U4eafjbVyZiDxZ2I5epart6VAAOGlFe7MZDMxAnr9vPEFFaPGNcSjFBcHBxTE2KwO5zCPhOYnR
 JGVS+Yx+A2oSpAu182T381muPMp8froYPLjD6syigsdnsEk5fefWPEcOKkbjSxU3MVVsjzXvDNQ
 hmH/CJOL7M62MLfQ6/97hWqAx4yz2Zt3gdfTwkNs+QpoaoV8AaT0s11FUSVtkudmXLEkkZLKKgt
 5KjRzCaClyTEYgloaw/Sxp5ULRiEtDoZYQ+zVVCWYc2TWCvl0TVdKUiSOwzo+whrB52SK75C90y
 PZSrkolw7mIcdsHSpInFTq094yuLiig6iiDJbp5xM1L+IKiAm/J3N+GuXGLffTyV4VkeWGlw+bN
 iBkfZ1qosBiWIISySLudAjQft4q6JU+A9LUHLBqWEXMXlgm6fSCfofBrgBk/gubuzDg9HnB1
X-Proofpoint-ORIG-GUID: 5PvmHl9RNN5JZTvlTM6gHI2KdYzt3otf
X-Authority-Analysis: v=2.4 cv=PrmTbxM3 c=1 sm=1 tr=0 ts=683ef477 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=-DCivLcqdKLNXXhIV0UA:9 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030114

On Tue, Jun 3, 2025 at 11:24=E2=80=AFAM Daniele Palmas <dnlplm@gmail.com> w=
rote:
>
> Recent Qualcomm chipsets like SDX72/75 require MBIM sessionId mapping
> to muxId in the range (0x70-0x8F) for the PCIe tethered use.
>
> This has been partially addressed by the referenced commit, mapping
> the default data call to muxId =3D 112, but the multiplexed data calls
> scenario was not properly considered, mapping sessionId =3D 1 to muxId
> 1, while it should have been 113.
>
> Fix this by moving the session_id assignment logic to mhi_mbim_newlink,
> in order to map sessionId =3D n to muxId =3D n + WDS_BIND_MUX_DATA_PORT_M=
UX_ID.
>
> Fixes: 65bc58c3dcad ("net: wwan: mhi: make default data link id configura=
ble")
> Signed-off-by: Daniele Palmas <dnlplm@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>


> ---
> v2: change commit description including information from QC case accordin=
g to
> Loic's feedback
>
> @Loic, I've left out the mux-id macro/function renaming, since I'm not su=
re
> that it can really be considered a fix for net. Maybe we can think about =
it
> when net-next opens again.
>
>  drivers/net/wwan/mhi_wwan_mbim.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan=
_mbim.c
> index 8755c5e6a65b..c814fbd756a1 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -550,8 +550,8 @@ static int mhi_mbim_newlink(void *ctxt, struct net_de=
vice *ndev, u32 if_id,
>         struct mhi_mbim_link *link =3D wwan_netdev_drvpriv(ndev);
>         struct mhi_mbim_context *mbim =3D ctxt;
>
> -       link->session =3D if_id;
>         link->mbim =3D mbim;
> +       link->session =3D mhi_mbim_get_link_mux_id(link->mbim->mdev->mhi_=
cntrl) + if_id;
>         link->ndev =3D ndev;
>         u64_stats_init(&link->rx_syncp);
>         u64_stats_init(&link->tx_syncp);
> @@ -607,7 +607,7 @@ static int mhi_mbim_probe(struct mhi_device *mhi_dev,=
 const struct mhi_device_id
>  {
>         struct mhi_controller *cntrl =3D mhi_dev->mhi_cntrl;
>         struct mhi_mbim_context *mbim;
> -       int err, link_id;
> +       int err;
>
>         mbim =3D devm_kzalloc(&mhi_dev->dev, sizeof(*mbim), GFP_KERNEL);
>         if (!mbim)
> @@ -628,11 +628,8 @@ static int mhi_mbim_probe(struct mhi_device *mhi_dev=
, const struct mhi_device_id
>         /* Number of transfer descriptors determines size of the queue */
>         mbim->rx_queue_sz =3D mhi_get_free_desc_count(mhi_dev, DMA_FROM_D=
EVICE);
>
> -       /* Get the corresponding mux_id from mhi */
> -       link_id =3D mhi_mbim_get_link_mux_id(cntrl);
> -
>         /* Register wwan link ops with MHI controller representing WWAN i=
nstance */
> -       return wwan_register_ops(&cntrl->mhi_dev->dev, &mhi_mbim_wwan_ops=
, mbim, link_id);
> +       return wwan_register_ops(&cntrl->mhi_dev->dev, &mhi_mbim_wwan_ops=
, mbim, 0);
>  }
>
>  static void mhi_mbim_remove(struct mhi_device *mhi_dev)
>
> base-commit: 408da3a0f89d581421ca9bd6ff39c7dd05bc4b2f
> --
> 2.37.1
>

