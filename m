Return-Path: <netdev+bounces-163380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DC8A2A0E4
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89545165234
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 06:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C94C224893;
	Thu,  6 Feb 2025 06:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7p6f/Ji"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D3822489C
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 06:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738823214; cv=none; b=dUgj68OBTd1laYKSIB3b7xTgymkt22vELoL9LyoijnRwh1L0ywdYpZ+1qFZEFlvq6sDds3G+H5udP9A8ItEcc7TwYgR4iO7NiC7YdGDRSgdm5orB9XrKX5gAYPQGsHsV+pBFSWQTqFK9o7bJhcQ6dPj25mNaDEhElqgPwJZutK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738823214; c=relaxed/simple;
	bh=DqeZXYxlQUMWfDhfpNmpJNCxBahKqpqoaaTG93nE3v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DygRu31kIfptLjBbSw7ysKyvZUZ7dsgUTkiKyxdSjU2WvGjMhkcvua2mKwj3h1b9N+d/ZNRnxRjvvfJTshLC7z85lUM5qgcv24svBbyPE8Aju93E6QeNx/OKskuuSE+v0iBsAKFmCnmL0Rg4cSFB/JcpmVlN3HPpjjrbPx8MgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f7p6f/Ji; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-435b0df5dbdso34595e9.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 22:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738823210; x=1739428010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03yRrzqwkoQNcy0a5o+voo3nHbEC43zmbznaf95qV3A=;
        b=f7p6f/JiSYs+9TIebmj9GbyRB9hYmRtYlqsQSwKCcnjgC00og8o85b0YGkpQWlSOI0
         EoRK0ootfVKU+duytEwWBDFCHLGnEFRPYEaM9Yjvx1Jk1Gd8cZMl8yhyj9n1PPLSND7o
         RtsC6OtOPzy/8QCnIKKEUvp6j0OeV1ThpBuaA4SCR2Ci/siblXixd0Nzds6gA0RQUVgP
         WzlW0tVqeieoLGmgLoftjeY3nTV/1FVOHTzUrYBKKJFQPqIs2y18TwzdFrkyLJDemcRd
         fH8LJMggqweM3JIN9cn6T44+3yKqATnFrf32oBjxGY2X8gnkTzF4qF2Z+K2BY1g1SU+c
         eG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738823210; x=1739428010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03yRrzqwkoQNcy0a5o+voo3nHbEC43zmbznaf95qV3A=;
        b=YOKMTfC/FtwdUU/8K1yCjXvtT6Vy5Jfinnu4L5tpeFsxvb9B02f9YWcooISY1KTS0D
         /F0DmriHuD15iOwj+A56VtqnFPQcTYUQZZSpkMSPB98yoohVEDzOMkvBtXC9RaqltIKY
         ZArTIVKARm0zYfw8DVm1u0mgVNn7NafRCIhzv8SRddZvW6JClhwznrbMTyf4y0Q/TdGP
         K2haDx9xrfN+tCPEPUSJbMsREhx1u2hKAp8ckBZvC/I0qwdA4UgRd1WBhaRCt8FAbDH4
         N0QRSmW4omZg6RqVUT0fP/ZftvXVdF4Gjrzo4VTWNmdHvlTYi2hTtsQkXOhs4un2Z8U6
         DL6g==
X-Forwarded-Encrypted: i=1; AJvYcCU510FEARvTGl92ZEMnIJTMoOaiTJa20qFPOzb4Iy69vsuDk7Wt2zzPwQgHI2GJhm0wFMeTL/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+UuAcIbTu9J4ovHhCgnsT8cVytxPtfeQWDa50njoJI1kG0p7f
	NnDO5McpDFOMJfNSFcj83/5QFuKTjD/mzzwCrGAfHyKZXgCVX+yGBR0mVytGWMZFRr3k8jSF3Ki
	zbF8ZTsIb8ZtZOSi42UwtuNJtWq1eGauG8FTU
X-Gm-Gg: ASbGncuR60JAw1XOs86GgoxksRYnjFfcX/JWr+6BMGdjC7mjYm9faJh8elkvdFAARU4
	zStGLFitGH3IIp3CHu0vkDHPYXrZVVX4vu6rqjcCRV5ze1a7YZcXa7SObtjr50UAg4LdUYX7jTw
	==
X-Google-Smtp-Source: AGHT+IEVztvMJcFJufCLJxG+rqwnV37blaPqUEHHEG4/YPqrXsBOAtuTMRsxeRmxk2+eGpCVw71JruXFsZiuK4zhtvw=
X-Received: by 2002:a05:600c:1f84:b0:436:186e:13a6 with SMTP id
 5b1f17b1804b1-439179d18e5mr495335e9.6.1738823210278; Wed, 05 Feb 2025
 22:26:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204213121.14195-1-jeroendb@google.com> <20250205162839.GH554665@kernel.org>
In-Reply-To: <20250205162839.GH554665@kernel.org>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Wed, 5 Feb 2025 22:26:38 -0800
X-Gm-Features: AWEUYZn5QfQLmyauxa5E7e57SqvtCHGB3sOJiulqpZDH_lPqPTh9ZQ-BqHXPV_s
Message-ID: <CAG-FcCMAT7Bvmxgo1aJh+Bv=z8MJKJN9LyzxOBuQVNMO2A=2qQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] gve: Add RSS cache for non RSS device option scenario
To: Simon Horman <horms@kernel.org>
Cc: Jeroen de Borst <jeroendb@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	pkaligineedi@google.com, shailend@google.com, andrew+netdev@lunn.ch, 
	willemb@google.com, hramamurthy@google.com, linux-kernel@vger.kernel.org, 
	Jeroen de Borst <jeroend@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 8:28=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Tue, Feb 04, 2025 at 01:31:21PM -0800, Jeroen de Borst wrote:
> > From: Ziwei Xiao <ziweixiao@google.com>
> >
> > Not all the devices have the capability for the driver to query for the
> > registered RSS configuration. The driver can discover this by checking
> > the relevant device option during setup. If it cannot, the driver needs
> > to store the RSS config cache and directly return such cache when
> > queried by the ethtool. RSS config is inited when driver probes. Also t=
he
> > default RSS config will be adjusted when there is RX queue count change=
.
> >
> > At this point, only keys of GVE_RSS_KEY_SIZE and indirection tables of
> > GVE_RSS_INDIR_SIZE are supported.
> >
> > Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > Signed-off-by: Jeroen de Borst <jeroend@google.com>
> > ---
> > Changes in v2:
> >  - Change to initialize RSS config when the driver is up instead of
> >    doing that when the user setting the RSS.(Jakub Kicinski)
> >  - Use NL_SET_ERR_MSG_MOD to log errors when there is extack
> >    available.(Jakub Kicinski)
> >  - Use ethtool_rxfh_indir_default to set default RSS indir
> >    table.(Jakub Kicinski)
> >  - Adjust the default RSS config when there is RX queue count change to
> >    ensure the default RSS config is correct.
> >
> >  drivers/net/ethernet/google/gve/gve.h         | 16 +++-
> >  drivers/net/ethernet/google/gve/gve_adminq.c  | 64 ++++++++++---
> >  drivers/net/ethernet/google/gve/gve_ethtool.c | 60 ++++++++++--
> >  drivers/net/ethernet/google/gve/gve_main.c    | 92 ++++++++++++++++++-
> >  4 files changed, 209 insertions(+), 23 deletions(-)
>
> ...
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/ne=
t/ethernet/google/gve/gve_ethtool.c
> > index bdfc6e77b2af..efcafc607b2a 100644
> > --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> > +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> > @@ -482,6 +482,7 @@ static int gve_set_channels(struct net_device *netd=
ev,
> >       struct ethtool_channels old_settings;
> >       int new_tx =3D cmd->tx_count;
> >       int new_rx =3D cmd->rx_count;
> > +     bool reset_rss;
> >
> >       gve_get_channels(netdev, &old_settings);
> >
> > @@ -498,16 +499,14 @@ static int gve_set_channels(struct net_device *ne=
tdev,
> >               return -EINVAL;
> >       }
> >
> > -     if (!netif_running(netdev)) {
> > -             priv->tx_cfg.num_queues =3D new_tx;
> > -             priv->rx_cfg.num_queues =3D new_rx;
> > -             return 0;
> > -     }
> > +     if (new_rx !=3D priv->rx_cfg.num_queues &&
> > +         priv->cache_rss_config && !netif_is_rxfh_configured(netdev))
> > +             reset_rss =3D true;
>
> Hi Jerome,
>
> This is not a full review (which I was working on but ran out of time for=
 now).
> But, if the condition above is not met then reset_rss will be used
> uninitialised below.
>
> Flagged by W=3D1 build with clang-19.
>
Thank you for pointing that out. Will fix it on the V3 patch.
> >
> >       new_tx_cfg.num_queues =3D new_tx;
> >       new_rx_cfg.num_queues =3D new_rx;
> >
> > -     return gve_adjust_queues(priv, new_rx_cfg, new_tx_cfg);
> > +     return gve_adjust_queues(priv, new_rx_cfg, new_tx_cfg, reset_rss)=
;
> >  }
> >
> >  static void gve_get_ringparam(struct net_device *netdev,
>
> ...
>
> --
> pw-bot: cr

