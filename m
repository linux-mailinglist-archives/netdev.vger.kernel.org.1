Return-Path: <netdev+bounces-176395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E28BA6A0A9
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 08:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C340017C83D
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 07:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDAC1E3769;
	Thu, 20 Mar 2025 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl7ON9Ij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6897C1C3BF1
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456650; cv=none; b=KkpfY4R2QoyKWCF+iQRE9CJ0WunmDx8YsmR72Yo2rdQzriyItLK6KWREnAVyOq8sFFzPP+uaNH3CEgIjSKxIijnu0T4ljAJlsI6Z2nWBUDOPH6UJMZ/H2qoWkvZ+jYtC4w0qLpXqCWN5/rbG2eVyc300F/VBIdb3VhYJS4IPYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456650; c=relaxed/simple;
	bh=MeU5zki0DsbzQ822JYCKt94NM17uJkO5B1I6KwJdr3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDTA5DeHLwNf6lo7cOw3zEhW3f5vRhjPYvic+icqd699y2DdaVtsGBKg+qR/07fJP3jSi9H6/T2fOiLCUHh6IC1FCtAZl9OLrnSD9uAQwyM7Xudas0z8vDz1ezMQVE7oA6pEM5NifXucZQ5mh44RZqO74SvkWKQFVNpq4hVhB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl7ON9Ij; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so683584a12.3
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742456647; x=1743061447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow/3xqwBK5KieARUhFcvXt4TAstS2rn0fmKi8gJYFGc=;
        b=Jl7ON9Ij0/qu4yfA/TURIkrkULrVWYLeAt+XyhiAw/dp0SWhXAVtrU2KoSaKnlYKcW
         3aD2rX/0Xi7K9WLFEdWmnbb/d32yg8tjGkXLz4FK3lsYYlLguvmhJD9Qv9uctj2tEDV7
         RG05ZrIqcBJGkdwtxEytWHOuV/pW4T0ufcsYHQCRMjAuBEccNoXCk8EEwUJDynqVrQLp
         zqCJVXAPj5cpaXG3g4xGTHc62HcTANDU2QwwldmuQZdj7R1ZTLCgLx4sq35PPhR6lKrX
         iqr5ZwKh7LChsVMmOI4prXnDsnUJhZSAwTZWHNWHQeixYwaTmf73vuTRmu91I2yRm2kH
         6ySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742456647; x=1743061447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ow/3xqwBK5KieARUhFcvXt4TAstS2rn0fmKi8gJYFGc=;
        b=AyJdE1aHMnfi9t5qKr5J2rqewaLL7su5AyNj57MTgM5JUA2mp7iA/P2LlC/8AOhm0l
         bc5LxeU5gGlssG9lFMZi9zf051yGFZT+AuNCAGIQHUz0y3Xytd95PTwv12C8RIdVc8mn
         fozPYsHcvsWP9XZI6bTRPuTEumRtNI+guPLGZLTBBrwwOfzeHahaY0G45dPZNuyJVY2I
         mz7+Vvp+u9617QHVwryNYr3TW7BlBS114Lq4kpIaXhwM4KCk9owCnmADiwEdnaqHtQe1
         N/Su+XudhzSTuwnk8xJZ/iNIIU2v25NUH1zZtljBHjp12GQISmK0ilOfvVL7eQ6g6zRD
         ItCA==
X-Forwarded-Encrypted: i=1; AJvYcCU7en3l4L9nL3i17WfK13apNUR02xyQpKlZoZ2UgrOo8nKOdS3yzja3X1v9w/6LwmYDiIdZBV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygvGhOvAzbCT1JwZh5ZpkvDYCIXjGmZsORykqQdXH/ZcJfwMEY
	kExPmM/GRjdsRC52FGputfMAykd5ZjNrJ42ILvG9zL37dA8tSeIgc6dHD8MsnuwH7oMpbeKmUr9
	xKGduGbbID6+RCex9N41t8cd33VgMNsEJauphkw==
X-Gm-Gg: ASbGncvTmlBM/mmTTQMhuCzTKMoY/Qk/T3S+jaJTc0ulZ0AdgNSgVo3EdH0HUT1iTOC
	ji28EX9n+M0wmbDNH2VTKyXtBd01bquQLnVthie0zKlMykKUvY8JfCawSXejbcED11rfvqGOPev
	8SfaZuIYDd/EljV3L8txmcHZW6rj/jBAcWCUXxLA+yIQ+GCE2TPO+gOebITw==
X-Google-Smtp-Source: AGHT+IFv68Nd9py9Eo6ObQJB3NRfD+4jc1LmrEovpBjqLsUI1YpHv/1Le/bwpRNU36/D/GWLCi/LV7XmNiYJ3y3BHEs=
X-Received: by 2002:a05:6402:13d3:b0:5e0:8c55:50d with SMTP id
 4fb4d7f45d1cf-5eb80d29dc8mr5591443a12.14.1742456646354; Thu, 20 Mar 2025
 00:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319124508.3979818-1-maxim@isovalent.com> <0fa82602-3b4c-46a7-bdfc-e8a9535e74c1@gmail.com>
In-Reply-To: <0fa82602-3b4c-46a7-bdfc-e8a9535e74c1@gmail.com>
From: Maxim Mikityanskiy <maxtram95@gmail.com>
Date: Thu, 20 Mar 2025 09:43:39 +0200
X-Gm-Features: AQ5f1JptQOxFyaHBL_6whC1SLRV81O3E-muzaaTZA6TvBU9tdbJmm6wpfjbfMu4
Message-ID: <CAKErNvrfirDasvmDDbGDu=301tOE43RaTW9jVjBL8=pngPH6YQ@mail.gmail.com>
Subject: Re: [PATCH net] net/mlx5e: Fix ethtool -N flow-type ip4 to RSS context
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, Maxim Mikityanskiy <maxim@isovalent.com>, 
	Tariq Toukan <tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 09:32, Tariq Toukan <ttoukan.linux@gmail.com> wrote:
>
>
>
> On 19/03/2025 14:45, Maxim Mikityanskiy wrote:
> > There commands can be used to add an RSS context and steer some traffic
> > into it:
> >
> >      # ethtool -X eth0 context new
> >      New RSS context is 1
> >      # ethtool -N eth0 flow-type ip4 dst-ip 1.1.1.1 context 1
> >      Added rule with ID 1023
> >
> > However, the second command fails with EINVAL on mlx5e:
> >
> >      # ethtool -N eth0 flow-type ip4 dst-ip 1.1.1.1 context 1
> >      rmgr: Cannot insert RX class rule: Invalid argument
> >      Cannot insert classification rule
> >
> > It happens when flow_get_tirn calls flow_type_to_traffic_type with
> > flow_type = IP_USER_FLOW or IPV6_USER_FLOW. That function only handles
> > IPV4_FLOW and IPV6_FLOW cases, but unlike all other cases which are
> > common for hash and spec, IPv4 and IPv6 defines different contants for
> > hash and for spec:
> >
> >      #define  TCP_V4_FLOW     0x01    /* hash or spec (tcp_ip4_spec) */
> >      #define  UDP_V4_FLOW     0x02    /* hash or spec (udp_ip4_spec) */
> >      ...
> >      #define  IPV4_USER_FLOW  0x0d    /* spec only (usr_ip4_spec) */
> >      #define  IP_USER_FLOW    IPV4_USER_FLOW
> >      #define  IPV6_USER_FLOW  0x0e    /* spec only (usr_ip6_spec; nfc only) */
> >      #define  IPV4_FLOW       0x10    /* hash only */
> >      #define  IPV6_FLOW       0x11    /* hash only */
> >
> > Extend the switch in flow_type_to_traffic_type to support both, which
> > fixes the failing ethtool -N command with flow-type ip4 or ip6.
> >
>
> Hi Maxim,
> Thanks for your patch!
>
> > Fixes: 248d3b4c9a39 ("net/mlx5e: Support flow classification into RSS contexts")
>
> Seems that the issue originates in commit 756c41603a18 ("net/mlx5e:
> ethtool, Support user configuration for RX hash fields"),

Not really; commit 756c41603a18 configures the hash (not flow
direction), and IPV4_FLOW/IPV6_FLOW are already correct constants for
IP-based hashes. Moreover, we don't support them anyway, see
mlx5e_set_rss_hash_opt:

    /*  RSS does not support anything other than hashing to queues
     *  on src IP, dest IP, TCP/UDP src port and TCP/UDP dest
     *  port.
     */
    if (flow_type != TCP_V4_FLOW &&
        flow_type != TCP_V6_FLOW &&
        flow_type != UDP_V4_FLOW &&
        flow_type != UDP_V6_FLOW)
        return -EOPNOTSUPP;

> when directly
> classifying into an RQ, before the multi RSS context support.

Direct classification into an RQ actually works before my fix, because
it goes to another branch in flow_get_tirn, that doesn't call
flow_type_to_traffic_type. It's only steering to an RSS context that
was broken for flow-type ip4/ip6.

> > Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> > ---
> >   drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> > index 773624bb2c5d..d68230a7b9f4 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> > @@ -884,8 +884,10 @@ static int flow_type_to_traffic_type(u32 flow_type)
> >       case ESP_V6_FLOW:
> >               return MLX5_TT_IPV6_IPSEC_ESP;
> >       case IPV4_FLOW:
> > +     case IP_USER_FLOW:
> >               return MLX5_TT_IPV4;
> >       case IPV6_FLOW:
> > +     case IPV6_USER_FLOW:
> >               return MLX5_TT_IPV6;
> >       default:
> >               return -EINVAL;
>

