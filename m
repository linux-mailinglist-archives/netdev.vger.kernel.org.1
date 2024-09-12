Return-Path: <netdev+bounces-127953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E66119772DB
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 22:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FD1285FBE
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EB21C0DEB;
	Thu, 12 Sep 2024 20:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U50hkH8F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFBA1BF80E
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174012; cv=none; b=nGMj0pHZeM62x6LGLOzJIA4Q9gmpqZYL5rPPIUdHmlVHVxMwfm6CO0UHxePhdmNKhJ49hNOIaS7iAP9X3CezLb16goWKHr9SxjQwIud53iag5wARs4I6ESC+/E7Q/Dmz/bEojpD18pecniNHKscOMxQ6/grz55+Fls/UZs+mLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174012; c=relaxed/simple;
	bh=PUgomda2CyhMlJY9xvvj+l3lLegayrInbUbBuHIKUHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtriCaeXjpkfr6yooTtyXWU0jYZ17jx/DwXZsu7qjH+bEBGP0UvYoeLzz1pYIXkfRIxYqRHA0z8rAR154P62WZf7ZQ+VHdSMDrBhQXLg7ygjOdjWxioTnPI1bE3EKEy6bY4zJE038QTE8Vc6PMgu9PhdO42r5sWAp4gm/AJPcyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U50hkH8F; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-846bcb525f7so393774241.3
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 13:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726174010; x=1726778810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wK58VG1V7FuECBcBg38MFAxruS5KPVTGw+RO+/DWnyY=;
        b=U50hkH8Fr1D+FwvTK/Ah61oO19h9A/6MrZhQQ5vcX0V4rt/WZ99w53//MbLqyY5LUF
         KTZ1mxEAznhf+5UMFUhg6Y/LE6xzQytZp/P8mabW5QbOHdpIbQpfEzbVC2O3BuAs2mdP
         qPF6D/MNrWMY/vOtDKY5vPv8p2GFNgvu/19E/le+G5FbKL1oI8Zbt5i+U6/dW64Yd11y
         nNTV7yu2TwGEJWdNosrLblu7XKVc5V19osN6CLezIYyrIHsAvBqvj+ZId3Pww7jCF5V4
         RYP6OIel6NCEMhI2YCf9xkdeGMUXsXCeqdh8gefy2VLHUR52sxgXgRiK4rZbQslRjFVD
         cYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726174010; x=1726778810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK58VG1V7FuECBcBg38MFAxruS5KPVTGw+RO+/DWnyY=;
        b=enQT/Y6fOyUG46ghhI9/ewJtJzVPgxQsYhgdrJtJOqx9YX0A9rP1gNhKGU7SIj2Lri
         xhqKISGvii3XKy5AV7xiCb3UDppX0g+pqzeA0JMBs0hROIr4kqR0oAwCHwrZlXX8pBHQ
         FWCwmnQrQP6BBO65dlTh76B6rlGPmRSQGxzOlAmyuLZ1VYO2jdKkeIhpASNRXiGrBDiu
         ZmPB386EN9ovSjN5kc86C8T1dyAxofRXjwKBci+t6NN3dt3sI+ITjin5jUZeP4YOh1VU
         9uC1wtYXLb7lMfeKLzzwr4cAePrdUeO5Ild4vKoGg7UlpGcIpIgj+L0qhjRkiEgZNqw+
         bX3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3kp+JPgJRkQzA6pf67D+c2z8/fiXaiVMx7z5A/dh85PSQhH5gh+tCiqJUmKMI9nC/d+b78Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbgeyUBYVKOLY+bHg2w15Wtit9WLU0Qe46lmUyaJib8mK4wFDE
	O+s7aTdWS2VESKhoR3yGJh2RFKjl2N9CLL0nFtJ0NAIj6JAjhPqVxkHjxznD1dwa2fPnCP6U1R0
	tquskJqxYAOkwKOFOJb3+Xe+4qwdCQxAM1O+p
X-Google-Smtp-Source: AGHT+IFR9c4mGvOi2HrDdg0buWSsv/T5WBLE+nQhkC9Wov8wJy7lx1tENOcz5mVUb25Wiz64bUjJDIXKFIwDlZYJ3b8=
X-Received: by 2002:a05:6102:94d:b0:498:d3b7:be37 with SMTP id
 ada2fe7eead31-49d41459242mr4307759137.3.1726174009541; Thu, 12 Sep 2024
 13:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911015228.1555779-1-kuba@kernel.org>
In-Reply-To: <20240911015228.1555779-1-kuba@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 12 Sep 2024 13:46:38 -0700
Message-ID: <CAFhGd8oaLC3Q=eopGb2=VPnhNVM4vb9rkGP0hM-gdT2C4m7c=g@mail.gmail.com>
Subject: Re: [PATCH net-next] net: caif: remove unused name
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 10, 2024 at 6:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Justin sent a patch to use strscpy_pad() instead of strncpy()
> on the name field. Simon rightly asked why the _pad() version
> is used, and looking closer name seems completely unused,
> the last code which referred to it was removed in
> commit 8391c4aab1aa ("caif: Bugfixes in CAIF netdevice for close and flow=
 control")

Thanks for looking into this a bit deeper.

>
> Link: https://lore.kernel.org/20240909-strncpy-net-caif-chnl_net-c-v1-1-4=
38eb870c155@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: justinstitt@google.com
> CC: horms@kernel.org
>
> It's a bit unusual to take over patch submissions but the initial
> submission was too low effort to count :|
> ---
>  net/caif/chnl_net.c | 2 --
>  1 file changed, 2 deletions(-)

the best kind of diff :)

>
> diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
> index 47901bd4def1..94ad09e36df2 100644
> --- a/net/caif/chnl_net.c
> +++ b/net/caif/chnl_net.c
> @@ -47,7 +47,6 @@ struct chnl_net {
>         struct caif_connect_request conn_req;
>         struct list_head list_field;
>         struct net_device *netdev;
> -       char name[256];
>         wait_queue_head_t netmgmt_wq;
>         /* Flow status to remember and control the transmission. */
>         bool flowenabled;
> @@ -347,7 +346,6 @@ static int chnl_net_init(struct net_device *dev)
>         struct chnl_net *priv;
>         ASSERT_RTNL();
>         priv =3D netdev_priv(dev);
> -       strncpy(priv->name, dev->name, sizeof(priv->name));
>         INIT_LIST_HEAD(&priv->list_field);
>         return 0;
>  }
> --
> 2.46.0
>

Acked-by: Justin Stitt <justinstitt@google.com>

