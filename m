Return-Path: <netdev+bounces-106503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C83A9169C3
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89531F274A5
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AFB167D80;
	Tue, 25 Jun 2024 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IfjzqcA1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8E614A60D
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324069; cv=none; b=mx4nHblhXcVGw6jp0J8QsJogSJLOggd57COiWBOwJ/sMFlZV2IADaNmRITsgBXmrLTe2C5rvtXdoEDChxkoNGpJhvPfwPVSNPpVj/uinMwT9Lnywp20OPulzE4RNwdjH7h88U4ZULCztmdnjCxzOTCPnW1d8oAkh+9OOBXksf6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324069; c=relaxed/simple;
	bh=0iUji4YU7CTd2c7VFZO5weBB3zZUqKVzHmxQ/+nux9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWGkOyuVaXWRwC8ecsX6Hhujq/MwJO1mG3M+CHXSNc1zByghlnuAJ8Y1INxZ6gsBk4fBVkThwV+Tq03tmHrDtO+r+bbWyvZ62o/6flH8LB487q1EgUQdzEmL9STj/K3+oDj89Z8tBf89NuGZZJh+qIb+FbzQELRIbY7R38+jqKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IfjzqcA1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-424786e4056so58915e9.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719324066; x=1719928866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iUji4YU7CTd2c7VFZO5weBB3zZUqKVzHmxQ/+nux9M=;
        b=IfjzqcA1V4xagt3sAQMZABEuucS2GkKWuerRzPAENhx1teT98KJiqZwySRrjeIuP0+
         LAWDq7/FckcFvpDQ4bWuURkRw+3EnWdloen8VTrItJq1E6SxRI/IMTzZnvxidYWk8kW3
         QeC/xVJIWoah2ryBRrYcN7OlcrrPMw5a2I16VLDb6rZ/eyVsRetnN48r9+zcUce6Pg13
         f8rO80B0KQwsP/rg1TP7STaxWhBhOsH1YSLyy5a95nLwYiL+5gQQp4c4/UsdAN8tEb6P
         FZAWINe1U5GB4yV26Kls3svnMU1mX1vJBeBvxFTmD8gYQHxuAN7gwWHJmSqerRcrOenE
         A8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719324066; x=1719928866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iUji4YU7CTd2c7VFZO5weBB3zZUqKVzHmxQ/+nux9M=;
        b=MQJekM3epz+H02XPaP7/eUepyevBmL7qdVb1o4ToMPwaJmmfJbQKAixR5+L8ZCfloH
         D8J0uEz+7MvKTH28pgqbz0Dl1nb68xcMNo451aodSYxNBwyyzVzXS3hNjEvzTXkFbXfQ
         QKSzSP+h/0VepcctRc3GKfjObYtt6Mpj9RVIn53KRAaCi/HUWzbap2/eQOvWjVnAzxtV
         6czCmq/GHEWTn35VvhWKXIDt78yeFRKl9ivo3yqQPPftrzRFaOzYdnW90DhYLiluu853
         tslFlZimlGDhtzES5+47zzmJwIwr9y+YS0zgDKhuvKGKlhyuw+axYGgS5GMJN3QmaXxm
         Eb2w==
X-Forwarded-Encrypted: i=1; AJvYcCVvvHk7WHJloD+eAXTu446s4wJXOx1RA7FbI/WZXZb2n322hxTMxDjZfHVUcCMFJ3v/nbwBEuJ7rzVRPArATnF2HdS2VwdY
X-Gm-Message-State: AOJu0YxDYDkb6RjWEm4wVbBVM2cvju92SmqKzxj8BlxSTX0Yb3b2usXX
	u+0kaAYUC0hOVGD6FRUj0VmIdWEVBlTz5tDJiFS8Bs7XRoV6NZE6JYxj7SjLvPFpdBic+j7QZwJ
	tLob+Nau9x3W0iCryksYF/LJIPqyzc59ZuyvZ
X-Google-Smtp-Source: AGHT+IFi60pqCTZ2PhmbScpfvVHSlP79Je6RZxTBeRVQa0tDIwHRTiXhex5MNwjEqX/qp24vK7+wKOEsa9glLbD7D54=
X-Received: by 2002:a05:600c:4e0d:b0:424:898b:522b with SMTP id
 5b1f17b1804b1-4249b65604emr1549465e9.1.1719324065471; Tue, 25 Jun 2024
 07:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625114432.1398320-1-aleksander.lobakin@intel.com> <20240625114432.1398320-4-aleksander.lobakin@intel.com>
In-Reply-To: <20240625114432.1398320-4-aleksander.lobakin@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Jun 2024 16:00:51 +0200
Message-ID: <CANn89iK-=36NV2xmTqY3Zge1+oHnrOfTXGY0yrH=jiRWvKAzkg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] netdev_features: convert NETIF_F_LLTX to dev->lltx
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew@lunn.ch>, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 1:50=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> NETIF_F_LLTX can't be changed via Ethtool and is not a feature,
> rather an attribute, very similar to IFF_NO_QUEUE (and hot).
> Free one netdev_features_t bit and make it a private flag.

> Now the LLTX bit sits in the first ("Tx read-mostly") cacheline
> next to netdev_ops, so that the start_xmit locking code will
> potentially read 1 cacheline less, nice.

Are you sure ?

I certainly appreciate the data locality effort but
dev->features is read anyway in TX fast path from netif_skb_features()

Thanks.

