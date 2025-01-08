Return-Path: <netdev+bounces-156181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C3FA055DC
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 09:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6077161A07
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 08:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178561F0E2D;
	Wed,  8 Jan 2025 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyyLYDHj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCB01A76DA
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736326557; cv=none; b=rKmtq1YjCp4BhF5G5iZ4Y1aXiQz+c4Ngg5SLzrP+alnj8bnkxfA3ktvsOBoM8qDYLadnyaCZEP7qJFz+DpMziE/NUdDYltdTUaymmLEU1D0P4RWXp9vsiWNNGAOj8M+R6UMaTT21Bzg/ZJoBFKXj43RxZPeQI27PSV5263gQ7/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736326557; c=relaxed/simple;
	bh=Q5Dxr4gtscv3A3F72IILVRCAQ/tTaUjpJx/ct0GB/vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeUgvTtRJDLWCncRHUVYwbgSZbzbSC7VQpkbXSPQotxlMN8WYO9qGYr0LM0H49z8TcELqsfAG818LmoSOe1BaxIDRO/oY8nvQ6aL7j8pXaQnoPGIm32T6T9hfLe0IAnKidqiNTBHhsOUfGU8mMpwB0g87YT9THCmJ9dsJSm1Q58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyyLYDHj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3863494591bso8452755f8f.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 00:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736326553; x=1736931353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnDje2yjlBUu1qE8ko1BsSkGc+IliKEQLX6fjiyoDAU=;
        b=PyyLYDHjIxa5DfEbN9ueQVzzoeJSOPTDyXym8IngUMhyX+0IDeyTjfOIucP1UCRced
         fInKpZZmiek0b69vYIFwO3MRyGjVHhM9EalSG6LsKawf1jssk+CtjY0RicZLFbyR1mEW
         zyTgUYB47z0GGPIN9Ari9W7rMqS+qr09XzDxJbUdOfVElbJe39zxHcjy7cGDSzL1//fb
         zWnG7thNG9eZA32V2NfMQRA9cejivzuwXVkUGT1dGLSgiYubHGOqvOW79WOSxgNeTNY1
         C+EBuW+MydX/69JV/3DGidgBzzshXeR/Pu1ISoyCftjoVju/6j40Zqu03+lvRnisTWWd
         SGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736326553; x=1736931353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnDje2yjlBUu1qE8ko1BsSkGc+IliKEQLX6fjiyoDAU=;
        b=IQ/wvII6FUJSp/1qcVfNXdbA6riJh5JppyOxbO0Y1TJH7C8u6zQpGeeg8mkP2dwyOR
         T1dP+27sqW7eSZAQFIgiYl2ethgO9hzYyoOFDiq+fa3OdIfRRDyqhT5TqEpcSFusNDMo
         xH5hYhwO0lnMTNpc/pJ0LDFrNANVVMW1cqEplQdV0PW2UuqAqc6qhn0gROdhu6EIm+FS
         MixHK19ZLr0eYMdgKuBAglRDIQmyj18+EA7Vq0muYN9v3U+Q5wrW98gIxixOdOznzHvE
         ynQIz5t3Qf6E96hgDt3yy3yFIMuCihrSUUB8er5YKqkcyTU4OMUM1H9vEFLq+VDb+ok3
         hxEA==
X-Forwarded-Encrypted: i=1; AJvYcCX+Pxrq3ePDqUtluVp0KQ6F0EAHwcb7hhpaMV9L344cnIkLVWLClPoYI8514RofuBhbGjGWUDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUfEmHf1p3vE2BFpcjbuo1BC4c5QSq2jQK/lE7lMpWsAzCGUqE
	eCG+pidanWeIujuCWMp2mE/ZRb7ubRySSnqn3ufghylWNy+NKpchU6nRBV+rhUSWLi0FUq4kKOa
	QNMel5PNfrrZodF/QYvwR3NI+xN4=
X-Gm-Gg: ASbGncutFCzfMqtzELQtMbMsmkzTZHCDgeu3ooSLpI8ISq3T6DQejnCG6gh8Qhcur6v
	KfCaBDw/CxJxXrbY5203rVhIp30NGmAAdr+gI
X-Google-Smtp-Source: AGHT+IHWDMhiTxrI2Iv+BoAUOQP9eCFGMF/1aS1CvVoXc9KmJSHYBt46QITOpmGtIm1ADmNuRnCauWZ9+t9Te7w+rc8=
X-Received: by 2002:a05:6000:1446:b0:385:f47a:e9d1 with SMTP id
 ffacd0b85a97d-38a872dec76mr1505888f8f.17.1736326553561; Wed, 08 Jan 2025
 00:55:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108062834.11117-1-kuniyu@amazon.com> <20250108062834.11117-3-kuniyu@amazon.com>
In-Reply-To: <20250108062834.11117-3-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 8 Jan 2025 16:55:16 +0800
X-Gm-Features: AbW1kvZ-uS9YNZVFfvy8lWw6EySONvo2FH4TYYHYQMt_Sp-qEI3H0oHR7l4nHfY
Message-ID: <CABAhCOR7Y058pDUKBOQ6vDeEZkHYQqeyg97nrBYoJHqkFgDd7w@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/3] gtp: Destroy device along with udp socket's
 netns dismantle.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Harald Welte <laforge@gnumonks.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 2:29=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
[...]
> @@ -2480,6 +2480,11 @@ static void __net_exit gtp_net_exit_batch_rtnl(str=
uct list_head *net_list,
>         list_for_each_entry(net, net_list, exit_list) {
>                 struct gtp_net *gn =3D net_generic(net, gtp_net_id);
>                 struct gtp_dev *gtp, *gtp_next;
> +               struct net_device *dev;
> +
> +               for_each_netdev(net, dev)
> +                       if (dev->rtnl_link_ops =3D=3D &gtp_link_ops)
> +                               gtp_dellink(dev, dev_to_kill);

I'm not sure, but do we usually have to clean up devices
in the netns being deleted? Seems default_device_ops
can handle it.

>
>                 list_for_each_entry_safe(gtp, gtp_next, &gn->gtp_dev_list=
, list)
>                         gtp_dellink(gtp->dev, dev_to_kill);
> --
> 2.39.5 (Apple Git-154)
>

