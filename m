Return-Path: <netdev+bounces-94856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF958C0DF0
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD9F281BE9
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB27414AD3A;
	Thu,  9 May 2024 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Itkt0v0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E814A4EF
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248918; cv=none; b=ex4KdVuf1V0FCw+MGk0T8PR9HCZwEqo8i7+UbnJUj+kzgeyZG+gPGh+WlO+ZzbceVkLrqAKJwkyyI3sfI8XAUfONanvuU5Hfwk/jEttp67blU4pTbNxGI56++Uf6o2EcmuxUkH6h50zp2pN0TWWKykVxSxLOpPP6nvmtYfIHx6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248918; c=relaxed/simple;
	bh=NYJpFyV9an6wYIGKWV23Q/Kna1eP/R9zRyoF+YVFLi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eplZTs2pMqcumHf8mKW7vYtj91M0yT/GzfE/kmoXSPgASTB+b4a5IaA1+mjvPTRjPhzjWghXCQiqmjTj6mgBJp3jbXf2OeowwloGv5xShHXpeuY+0EcpCtMtag6cNYsYovNKu7oYuYWNV4b8BcZ8gtrL+zBRAajtPG6AlcuuFis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Itkt0v0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso8506a12.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715248915; x=1715853715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjSAyb5aQa39zuFxPsL4Y/BuhRbhGSV6tXIg8irbXFI=;
        b=0Itkt0v0MyfP66CLclGgtazS4pAcZGJOeTXs+2d+aWcBFZ62zUpAhFcmZlP2lxOuQK
         tIRHtvSZ7dA6b8w6cP4D/qFcLxV5LN3Ih7y3G8b2PztdaJyfuynWzKxkPr+XbImmDqzI
         mP8bBSWpXeN2gs3lbWXsqnBIHXFvYoY+3Vhoe6x0Vac3iHnsWu4v1x577TIT9JTm2NKw
         dkw9eLS7GaGZfOuGXYQMvTdJOIzKLwvvEflie2e5b8W3AoxXYnzDp+0CX8oPY4CZZYut
         JwhWwTRrA/vGT6sjiFzd00Hys/X7V55mg2RbVlWpyf7lYeukTBKQmC4CSUpVo4UTcwbx
         jBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715248915; x=1715853715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjSAyb5aQa39zuFxPsL4Y/BuhRbhGSV6tXIg8irbXFI=;
        b=teu33hLjPZI9Nyjx4plvCroh9QWnM/xaaqpri1T7SuiWCJjOoak4CBaCllEFdFnhLs
         drEg/OkDzvFm3+N0UaSTM6atGjkUVA0YO4kS2QoOhjd5Vb/6/98lsb3m6EcDLySrGSNS
         Jl//uts2U3w6qCBrBCyi1y/m5ZweDldYUVmWGCeA8/D7wBvBmbsZz4V1qHSbBOx+jQ0Y
         ofPHQ9loA/NeILM6+4OzFdRuzPjtJKOmTXKEH1FNftFQcM5iukwr3YyxvA8fYLhuP1dB
         NDN/8X3NT3n9txxqvdHgDBbFBuiOKE2nvSz6zhKKSUfRabM++IFe6Nn+JGiTHTm7m6QZ
         RF9A==
X-Forwarded-Encrypted: i=1; AJvYcCU95DM6AgTLnBG02vgEIg/L3Tw3SKej77jCwOGTJWUiaW+nWZ5HO7L2QcrlULczcZAffDRf5PrFv4e/LoatWm6NiDXTqB+D
X-Gm-Message-State: AOJu0Ywbqj00K5ZigVUeVdr2KlFwMmRyrPP4A7RuM9AKcoJfQYckZEKT
	t/QawphDlPOY9pJhELlZS+T2t0sLxcdIDBYrm0A83KQczuVZhK4gM2HX9S9X33E86pzciy5mN0a
	37p1DFbGu+jojIt8K9j+oXIwxo0PfZCKjQP/I
X-Google-Smtp-Source: AGHT+IFlTHosy6QIbjU9+OZKPS7G2oNflIiXV/y26AeVFMuWLubKooH/rIpCVLgXcPt5/T0O+sd+tR2T412KzHFXb74=
X-Received: by 2002:a50:ed0b:0:b0:572:988f:2f38 with SMTP id
 4fb4d7f45d1cf-5733434b017mr131354a12.6.1715248914311; Thu, 09 May 2024
 03:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715245883-3467-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1715245883-3467-1-git-send-email-shradhagupta@linux.microsoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 May 2024 12:01:41 +0200
Message-ID: <CANn89iJf68+GZ-myjkiZ40SJY1egD3-qYhVeZOdi=6TB13aE4w@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: Add sysfs atttribute for max_mtu
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Johannes Berg <johannes.berg@intel.com>, 
	Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Shradha Gupta <shradhagupta@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 11:11=E2=80=AFAM Shradha Gupta
<shradhagupta@linux.microsoft.com> wrote:
>
> For drivers like MANA, max_mtu value is populated with the value of
> maximum MTU that the underlying hardware can support.
> Exposing this attribute as sysfs param, would be helpful in debugging
> and customization of config issues with such drivers.
>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  Changes in v3:
>  * Removed the min_mtu sysfs attribute as it was not needed
>  * Improved the commit message to explain the need for the changes
>  * Seperated this patch from other mana attributes requirements.
> ---
>  Documentation/ABI/testing/sysfs-class-net | 8 ++++++++
>  net/core/net-sysfs.c                      | 2 ++
>  2 files changed, 10 insertions(+)


Sorry, this is a NACK from my side.

Adding sysfs attributes is costly for setups adding/deleting many
netns/devices per second.

RTNL already provides this value.

net/core/rtnetlink.c:1850:          nla_put_u32(skb, IFLA_MAX_MTU,
READ_ONCE(dev->max_mtu)) ||

