Return-Path: <netdev+bounces-248009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32258D0255B
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 12:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29E5E31CA2A6
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885DC3876DE;
	Thu,  8 Jan 2026 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q5ew7+gP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TpiR/AZj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F64D3816E9
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767862771; cv=none; b=OQC9DeFJ80YxsTo4L/M7N8ddhYZvUnuGPmji8C8SNY31T+L3NQoN6xE2LqgqYNZ2oZnL8aq8tCMcOaaNsm0dVhJdw7WmL5pD0IqJczjSXzLwbnebLI9Iy6dvgWhODt7iMGbsY+0el38wN+HguJ5aFaYLfmBKfDModzEXH0K+pt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767862771; c=relaxed/simple;
	bh=YHlE0d4Zdg3zGpi7vnXaRyEcbTQU0hyKWGZwGGtXrSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rc3Qe9ewCrcJvP6Wr1gGuOGO4OVOZjlKvUMMtXaaXDnRGNXdM/TTHk5+ZwSlL5ScS35Rl0xTUgIFjaYwpm0drmrtH+jj51TEZPri088RrBta4/QD+Ky8jgJl56Nfpgz6yozl0zcNnEE/uPRUNkOUln9Fe70sqovV6s8fbu1XaTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q5ew7+gP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TpiR/AZj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6087QBlR1258526
	for <netdev@vger.kernel.org>; Thu, 8 Jan 2026 08:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W2zJ4MmBHNV6iOH+dkgfjuEvhOikcvGRf00d0zwDe6E=; b=Q5ew7+gPvSW9mncm
	F8RfLr5tQRPOkbtavnM7YN/f8Bt9awTCBEUDwhtPzQ+K4XMyje09PSOqA11FXX/T
	m3UUAZnJVRyvRNHEG8Qorff0g3b8XIopMpFUUMwB5jKHJYSFd7SSsEQvnAAaKI4w
	r4kK4klhGFa1Me4X3JuzKqc0pucPdIuIaWfYxKiNitoevdZ0DjefJGyBMfYl/qXt
	8hSFaQPHt6mStl2DpkKU6yo/UFYO8O6/VUaZWV9Oip1EfSys83N5+Mw1wL0KsNjA
	z6hWf7LCqKqetACoxnBYoe4Q5eR+D0TnJjuDV1dl58ZZZrwC/d8BBCUUmYQwXQaE
	gJmNuQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj86gr8ss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:59:23 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88a360b8096so77759836d6.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 00:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767862762; x=1768467562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2zJ4MmBHNV6iOH+dkgfjuEvhOikcvGRf00d0zwDe6E=;
        b=TpiR/AZjAEbPz1ufTkh1t3QlzWStNyaDUcXq7iXPQB21AdRICkcRMQ5+xInVIkUPWV
         4kXBsmiGNvFFc3BaZbx6rJmxZWpT0Bd8fM85tK+9wNOnr5sC/gXOxzGowOh/EmW20FLk
         EHDcamOJZKZNRpGriTorai761SzwcFeznidBmYml29DcWlBM/A+iRSqG6D8Z/pxs4DKT
         CHUNonDLZVXMoDKVLZhY65hkZHbw9fCdvU8n0wMFi/hclrb7Ks1Xs4w4H57yE3/t8PDy
         s+gwOyYSh1GljWsXuSJgSRUOkxwOl+UdEGumGKFUWSY0AIYJ3DD9ZSCxx7z/Q82GSJpl
         qz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767862762; x=1768467562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W2zJ4MmBHNV6iOH+dkgfjuEvhOikcvGRf00d0zwDe6E=;
        b=EEVlP57Z3PBhPGj+7KggZq5eOg/mqzzj6LGq1qX49QO2cvn8YRxjXhGAGzsdQPLvXW
         SX4wQI6AEAuF8/3I/Td6LiAGLBJHu5V8efJra0xxSHG/tK5frXmihnwe5qBkMEn3Fya+
         Ip2htnQl+AzuKn1Rhcp4nEi1hJgyQlTOdMpRTwMIh2d8xzcJNwRTvgWoxUOMaiwm4PMH
         p6gkXP3bsU4kK/kGGsuQV14zEImQYAPYN/H4MEdpOefQ3+E3XxOypMnaZ6+HC0kRZkl4
         w9w41fheTbkcx7DDNoXfDZiTPbPOoAwmcjHmhKED9eMId5njP1V02OiDyAfWXcRZMujw
         Jt5w==
X-Forwarded-Encrypted: i=1; AJvYcCVzdRij5yAN+TA9VrSLBhE6ZZkqazONDIFzDlOT7HIINQ1IkJHQWuGQ4/kHRO3UVj0ZFPQOwr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9T/1ivCIonEOCOYzsJW/WCVNSGk7cG20Rkmeurd3DCAg78NbX
	HPhwoOClYwb9Us1FkmYQLdClZqHo3KrnUcCt2KaQRVklppOCEe7zwpnF2y9rd1Gp/1A6E5IvhTG
	UAdvpLDGom+lLD4UR7DiHlED3IXMTMKNfiwF0s9tahfD+4hixXJ5gRCZR89HZWi6QVPYPMxcTDr
	omSvsgm9bp5TbkTBs64wK+PvPxGM9ZhPAXlA==
X-Gm-Gg: AY/fxX6ofaV5PfSM3k0gebio2t2ZIystzYcmqQgWsiJMX5cSeDqAfh9bG1RyAfcvqkY
	WEOonRymAnJfsDUlX44jS1zglMvyOihXLNfBkhL8wF1OuVa/9uoFO4THwqUm5hv7/wY6nyMEMgR
	XjKtJw857s+lX0UhkAQvFW0DeG2cRjMZy2/gAiA3cJSp5Ejh7NIxPMb7gRop0y6otRA4hgyB2ME
	g8tDu8BiAa4EZd5uPer6lzuJDg=
X-Received: by 2002:a05:6214:5a13:b0:88a:2fb5:a085 with SMTP id 6a1803df08f44-8908429d1bdmr68994446d6.63.1767862762414;
        Thu, 08 Jan 2026 00:59:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD08pztITad85dXLvvLj/zaVI7S1hQWKy76WyLIAObgQ5gJ5PNnIvzvVBmR/unLMMKb1PuoQDxIPtYho/Irg8=
X-Received: by 2002:a05:6214:5a13:b0:88a:2fb5:a085 with SMTP id
 6a1803df08f44-8908429d1bdmr68994246d6.63.1767862761950; Thu, 08 Jan 2026
 00:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <63fddbfb.60e7.19b975c40ea.Coremail.slark_xiao@163.com>
 <20260108020518.27086-1-ryazanov.s.a@gmail.com> <20260108020518.27086-2-ryazanov.s.a@gmail.com>
In-Reply-To: <20260108020518.27086-2-ryazanov.s.a@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 09:59:10 +0100
X-Gm-Features: AQt7F2qaLtMgbw-nlldBcRtYDWUYk02042kppIpDTdXRJEkqAipSIXtzn8PNruc
Message-ID: <CAFEp6-17zHKA+88FfTqUKV44O18sg7Ow2HAt05ucucaXjXbSKA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] net: wwan: core: explicit WWAN device reference counting
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=ZNjaWH7b c=1 sm=1 tr=0 ts=695f71eb cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=ariseCS8t_dG9Y59fBMA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: fXD9YJn_P5059xqhCUhElmgugctubgzY
X-Proofpoint-GUID: fXD9YJn_P5059xqhCUhElmgugctubgzY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA1OSBTYWx0ZWRfX9E7jUEwrxiIc
 /i0ehP+UdkFTca8Y8lK2mAMNaRwstR4mdeeLsmRCjSUHpB2vVmHhgXwJnHI6TBK5VOgudhpcMeS
 9fM/dxq9OPMkQiYlZ8T08FztNEV8+erw5bFrx2zk42vbJLca6v+Z5Rq0c35uUdy5W2FL42yJBxd
 8JlXm+zP2v9mCa+4GImWKtPxrcNSH5EBRe9O5fT36Pxk3WIKSWxaaibtyjJ7Emd5nKD+jbwwEsW
 3Y3g9y0PVizDBb8Q7sGljts2CL1FmbXL1ptTQeoRy0PQbRyaLR/XyE2fC7uhgon0X2WALEjFTO/
 LOpdqi1OKzfBanLqA2TfKRGR2WHWAZ7EYiAwQSK9gsRKdKg0KqyyRi6Zygt94cv70Zzt65YUgty
 sFDnOPw7R+B5L60lkNKZrAkr/9qTnuF0WfcFrekQomRipZxDpKr66VGLpxCqFZkkCY9qTRtpzCr
 tur8Vn/tMNEz/YzAfCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080059

On Thu, Jan 8, 2026 at 3:05=E2=80=AFAM Sergey Ryazanov <ryazanov.s.a@gmail.=
com> wrote:
>
> We need information about existing WWAN device children since we remove
> the device after removing the last child. Previously, we tracked users
> implicitly by checking whether ops was registered and existence of a
> child device of the wwan_class class. Upcoming GNSS (NMEA) port type
> support breaks this approach by introducing a child device of the
> gnss_class class.
>
> And a modem driver can easily trigger a kernel Oops by removing regular
> (e.g., MBIM, AT) ports first and then removing a GNSS port. The WWAN
> device will be unregistered on removal of a last regular WWAN port. And
> subsequent GNSS port removal will cause NULL pointer dereference in
> simple_recursive_removal().
>
> In order to support ports of classes other than wwan_class, switch to
> explicit references counting. Introduce a dedicated counter to the WWAN
> device struct, increment it on every wwan_create_dev() call, decrement
> on wwan_remove_dev(), and actually unregister the WWAN device when there
> are no more references.
>
> Run tested with wwan_hwsim with NMEA support patches applied and
> different port removing sequences.
>
> Reported-by: Daniele Palmas <dnlplm@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAGRyCJE28yf-rrfkFbzu44ygLEvoUM7fe=
cK1vnrghjG_e9UaRA@mail.gmail.com/
> Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> ---
>  drivers/net/wwan/wwan_core.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index ade8bbffc93e..d24f7b2b435b 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -42,6 +42,9 @@ static struct dentry *wwan_debugfs_dir;
>   * struct wwan_device - The structure that defines a WWAN device
>   *
>   * @id: WWAN device unique ID.
> + * @refcount: Reference count of this WWAN device. When this refcount re=
aches
> + * zero, the device is deleted. NB: access is protected by global
> + * wwan_register_lock mutex.
>   * @dev: Underlying device.
>   * @ops: wwan device ops
>   * @ops_ctxt: context to pass to ops
> @@ -49,6 +52,7 @@ static struct dentry *wwan_debugfs_dir;
>   */
>  struct wwan_device {
>         unsigned int id;
> +       unsigned int refcount;
>         struct device dev;
>         const struct wwan_ops *ops;
>         void *ops_ctxt;
> @@ -222,8 +226,10 @@ static struct wwan_device *wwan_create_dev(struct de=
vice *parent)
>
>         /* If wwandev already exists, return it */
>         wwandev =3D wwan_dev_get_by_parent(parent);
> -       if (!IS_ERR(wwandev))
> +       if (!IS_ERR(wwandev)) {
> +               wwandev->refcount++;
>                 goto done_unlock;
> +       }
>
>         id =3D ida_alloc(&wwan_dev_ids, GFP_KERNEL);
>         if (id < 0) {
> @@ -242,6 +248,7 @@ static struct wwan_device *wwan_create_dev(struct dev=
ice *parent)
>         wwandev->dev.class =3D &wwan_class;
>         wwandev->dev.type =3D &wwan_dev_type;
>         wwandev->id =3D id;
> +       wwandev->refcount =3D 1;
>         dev_set_name(&wwandev->dev, "wwan%d", wwandev->id);
>
>         err =3D device_register(&wwandev->dev);
> @@ -263,30 +270,12 @@ static struct wwan_device *wwan_create_dev(struct d=
evice *parent)
>         return wwandev;
>  }
>
> -static int is_wwan_child(struct device *dev, void *data)
> -{
> -       return dev->class =3D=3D &wwan_class;
> -}
> -
>  static void wwan_remove_dev(struct wwan_device *wwandev)
>  {
> -       int ret;
> -
>         /* Prevent concurrent picking from wwan_create_dev */
>         mutex_lock(&wwan_register_lock);
>
> -       /* WWAN device is created and registered (get+add) along with its=
 first
> -        * child port, and subsequent port registrations only grab a refe=
rence
> -        * (get). The WWAN device must then be unregistered (del+put) alo=
ng with
> -        * its last port, and reference simply dropped (put) otherwise. I=
n the
> -        * same fashion, we must not unregister it when the ops are still=
 there.
> -        */
> -       if (wwandev->ops)
> -               ret =3D 1;
> -       else
> -               ret =3D device_for_each_child(&wwandev->dev, NULL, is_wwa=
n_child);
> -
> -       if (!ret) {
> +       if (--wwandev->refcount =3D=3D 0) {

Looks good to me, though I=E2=80=99m not sure why this wasn=E2=80=99t the i=
nitial
solution. I=E2=80=99d suggest adding a paranoid WARN here, just in the
unlikely case there are still ops or wwan children attached.


>  #ifdef CONFIG_WWAN_DEBUGFS
>                 debugfs_remove_recursive(wwandev->debugfs_dir);
>  #endif
> --
> 2.52.0
>

