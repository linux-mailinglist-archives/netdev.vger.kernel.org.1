Return-Path: <netdev+bounces-106049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF07B914758
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52D42B21330
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 10:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C8013667E;
	Mon, 24 Jun 2024 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpnYJl0v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9551040BF5
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224626; cv=none; b=IYUlLPiV/yS21Om96lVva5amp3VSIpDxlkYJA9OSi6Osn8HtOaY8TJdGhNWG32M1sla5Hiit7c48fW/4v3aOtsp8ALwZNOpoyXOCVpHCm0rEi3sMl2Dsv8+GH8AGVdVM6iyefg0XMyMGGByMmNCRdeT8dEpjtZRMhGOLH4bslDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224626; c=relaxed/simple;
	bh=PznXkuxX4DZcuGgjq58Mb+676cJc+RbOm6Hk5fWQusI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sL0NBd8PMkRv/rXHXZ4jkwLkodZzfCbmQyPAwtwKhf+m1QJj0hMI6/xbWUA4UmzvWr6UhfZZBf3ob9kYMKIWqPJWJeFKULod9QGFIuaEWCiqOn7pFriXuOs7k1ttkD3SZj5MCvKVr7QkJWmauR4RUSBHgM2rBAgLNgRrqlCTQHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WpnYJl0v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719224623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Hjk+DoOwQKd0jZlvg+VAbFDl7yand2LnLV84Jmyyes=;
	b=WpnYJl0vVGwJIfzDhSzInFgHjPGcpWl4EiNROX8OtPIywCBawmXYnjIdqySNVRmsHujFZB
	E6v3nDhAyqmmabdeaPYY9rrFhEkhyE5ceSQiH8sTwDE9/rUycSll3MUckwWiAZR806ag5F
	9Nm8a57sHzmIykhAhd5vYhmPN1bGDcw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-AIWvhfkZNVGd18-Wgi0XUQ-1; Mon, 24 Jun 2024 06:23:41 -0400
X-MC-Unique: AIWvhfkZNVGd18-Wgi0XUQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52cd8c15ce5so1934913e87.1
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 03:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719224620; x=1719829420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Hjk+DoOwQKd0jZlvg+VAbFDl7yand2LnLV84Jmyyes=;
        b=wxH4Gvn2XKMjYU+5tbYK8axXOIaoZQnlJpPUxNErdw7kdNQQGJOf+Ey5MG3W0/J6MV
         4tSgqPgcqwv2hPj77dS+GrYwgqWBUwZ4ut3gHw0r/h5r3caVI0u1kRIwUQt63ajZJThG
         YOEZVtiaoehoux1hZR8EwzAsWX0Y/PLaih+YJOF1dxge9Im+tKsOisTvOjsPKanBG05T
         1q8YQ3Acb7FJi4MRIZk26YgBuhDagHZyvhiHEaq2AM8LT+Tx7IiuIicF5D++lcwDy9g7
         wHDtw4zLYkX/wXn57g8E17dro1+DFQ18mw5NKcdmweD13bFa1IC4zwBK19JLB/BPddSE
         QfOg==
X-Forwarded-Encrypted: i=1; AJvYcCWDKrivKFpidS0vAOScsWE9M5Lq4QzL1/PJTHhErTxiEUrR9OC/YI6rh3jFvhF7fu4n7vDq8pM4yaYXVroMXrTR1SJuVvKd
X-Gm-Message-State: AOJu0YwOQFTg+Y8DD5wEpR+xg+m01DUSqaw84KqRQMqjj+2hvbK6GO5N
	ULQ0UxRavxMHCU3tHSSAkZLuTqOvUxxXjR+LvCLqUvis8RlN7hNoA/X3cY3mnjK5vXhVZUXPzqY
	0baq3JPjtcYBABKetofBwF5710AxGAyRvX1aNcbn6TQRZnJVj/bN/qpUE3rXewt4HhpUf467mk9
	88sulIw+BCVEMla+l0hwELZFgJvb+I
X-Received: by 2002:ac2:5f8b:0:b0:52c:df2c:65fe with SMTP id 2adb3069b0e04-52ce18350bemr2804724e87.15.1719224620442;
        Mon, 24 Jun 2024 03:23:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfnbpZbFH7ayIt404IdYoEK4urJrTlHgaZMO5rvHxCjCGSOkUqRPmg/1UDBzqCFTz11dQkM5zIzR6YjbS/lYo=
X-Received: by 2002:ac2:5f8b:0:b0:52c:df2c:65fe with SMTP id
 2adb3069b0e04-52ce18350bemr2804705e87.15.1719224620049; Mon, 24 Jun 2024
 03:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624095331.351039-1-ihuguet@redhat.com>
In-Reply-To: <20240624095331.351039-1-ihuguet@redhat.com>
From: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date: Mon, 24 Jun 2024 12:23:28 +0200
Message-ID: <CACT4oufqR100dshYZXw76MOvmkgNmSfViAwcktK6b2JMENbkcw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: igc: return error for link autoneg=off
To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I thought I had done `git pull` on my net-next tree, but I
didn't and the patch doesn't apply due to context differences.

I will send an updated patch in one or two days, including the
requested changes if there are any.

On Mon, Jun 24, 2024 at 11:53=E2=80=AFAM =C3=8D=C3=B1igo Huguet <ihuguet@re=
dhat.com> wrote:
>
> The driver doesn't support force mode for the link settings. However, if
> the user request it, it's just ignored and success is returned. Return
> ENOTSUPP instead.
>
> Signed-off-by: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/e=
thernet/intel/igc/igc_ethtool.c
> index 93bce729be76..b7b32344d074 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -1832,6 +1832,12 @@ igc_ethtool_set_link_ksettings(struct net_device *=
netdev,
>                 }
>         }
>
> +       /* The driver does not support force mode yet */
> +       if (cmd->base.autoneg =3D=3D AUTONEG_DISABLE) {
> +               netdev_err(dev, "Force mode currently not supported\n");
> +               return -EOPNOTSUPP;
> +       }
> +
>         while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
>                 usleep_range(1000, 2000);
>
> @@ -1844,14 +1850,10 @@ igc_ethtool_set_link_ksettings(struct net_device =
*netdev,
>         if (ethtool_link_ksettings_test_link_mode(cmd, advertising, 2500b=
aseT_Full))
>                 advertising |=3D ADVERTISE_2500_FULL;
>
> -       if (cmd->base.autoneg =3D=3D AUTONEG_ENABLE) {
> -               hw->mac.autoneg =3D 1;
> -               hw->phy.autoneg_advertised =3D advertising;
> -               if (adapter->fc_autoneg)
> -                       hw->fc.requested_mode =3D igc_fc_default;
> -       } else {
> -               netdev_info(dev, "Force mode currently not supported\n");
> -       }
> +       hw->mac.autoneg =3D 1;
> +       hw->phy.autoneg_advertised =3D advertising;
> +       if (adapter->fc_autoneg)
> +               hw->fc.requested_mode =3D igc_fc_default;
>
>         /* MDI-X =3D> 2; MDI =3D> 1; Auto =3D> 3 */
>         if (cmd->base.eth_tp_mdix_ctrl) {
> --
> 2.44.0
>


--=20
=C3=8D=C3=B1igo Huguet


