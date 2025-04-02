Return-Path: <netdev+bounces-178876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96687A79511
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 20:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B437A5491
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733981C84C6;
	Wed,  2 Apr 2025 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QttT0U/t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7711C84A5
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 18:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743618535; cv=none; b=nObT+4TKsoMP4sW9SK+mKRh9O1ENln+h3ZnpPXRXKEbB6sdyTAA8kapvBTuCoY9jfoWEFGDIYfYscSmC3DYQvH7LpID1t3+CSljRO5/KUJBAveUCTCva5sPeSRAupIQCaigu+SJn5TMHR1oKbL8YplRg+sMq5kiSLekyExZsz6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743618535; c=relaxed/simple;
	bh=D3m5WoVt0h/8wkwTuJYrj8u9HKSDTlsX+T9QXbwiNP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqxrJfDluhuro9o6yD7ETuZwHXZ0dkUupVKHdOk3wiiTP0H7tpdXBlay8IqCQ+Np3tP8w88xeE2sBPF4ev6+LMf4QNdusLV/8fLE3m3lbfHFxVF9Q7kIjGkMo6YwcXfXt3GPCDv7EueNo/edp+LdBOAtckY4pFLKJ3VZPJQpgto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QttT0U/t; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6feb229b716so1260467b3.3
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 11:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1743618532; x=1744223332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3m5WoVt0h/8wkwTuJYrj8u9HKSDTlsX+T9QXbwiNP8=;
        b=QttT0U/tgZ2RcKzvg9upsB6tlV8UjxTlJ7sIc3ekFpxKwkLqbGZWucobtggxfmi8yz
         VAVzTWCZ0CO+Tige88YmNL7uawgDdB7RZr9/Y+CH0UCIatx5bsUf0YZgq4oGwLjrpPln
         2tfJloeA/rXFCEiSdbtE6R0bAUm8JI26Cb1s3kK1jq5a/OLmPESlD+jHxoNf/z7/InFf
         TBrZAjdmzXClEbmiRJugTHDHUZojPwpG4SvUbZm4BvQagJkXAK5XCySr/1KeHVVxOpYS
         Ygq+E3GH2e0gUgNDdmOfAdJpnGg5RvaQwOIZLg0LgSko2c6G+71jHA/VXVkfFfsGlAhY
         s04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743618532; x=1744223332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3m5WoVt0h/8wkwTuJYrj8u9HKSDTlsX+T9QXbwiNP8=;
        b=gUNpvU+60P1QqPq77tjb37FViutzRzGpz0KTVaVOnjq7DUTsSkG26pddvftz8Xc3up
         6bjAQLGftJOYAVQ40wOR0T35xM08g6AhI+CtcH8AObz70HOQeMI02Uxy4otiSSU5osKU
         RiwoZEZZ+LvF4pOA+QkwG16mdkCD2BjZ8qeXOgK+ganmr16olEID2gOaareNvgrB+5zb
         yF3ODVyPn3qXAqW7l/TaG0PQ/p5oLxDNEP5opUut7jEP30QMzd5rKUpPahiCKnZI9tTF
         nhFflp/iOr2KJE0vTRWKIBiCEgAoxqdu+WZzkTo+mO04W2pMrQ551cGb+XYYzKsjqBIF
         mHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnqtZjOVr6QX1Py6ltm1X2iF76XmimuMddBWylauFpcBwOvw8ATOWcQrIvaFLiAhAQ6Zmp1f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyicmHgbrJEIwIV+5GFfgDaMQmvZ4vZnyysZ3X0n3pHKGkrcHL/
	+jOz8NzHaIxgIujxEFW4Nkz1OFmdI5yLEDDslBOLeTV884I/1GMLJT9plRHQ6uvXccrW254gcX4
	2t0lbZR24CAJpJMDk6bfX+q/eI+9+1IpkOckr
X-Gm-Gg: ASbGncvbKE5DRAkLfhl6nSH3KOdnekjVeu4pqjyhoVFtMcbKlWX/k/d8GYHcNFbgyLx
	wRg3mcYuMWd74gWVeT8u7hiSDM3ZcpJHQQZcA43qUCtM0d5jTIHCkVTWvfsG6v4kGeqLPQ6N67C
	Jc4C8gYUPY9/wDaWtmgfh8SYhhbQ==
X-Google-Smtp-Source: AGHT+IHnExvPdDbkaYXl6TfzQuj2zh7liH916FifwMkueNLtDrglF+QixKyEuVLYWMHZBQP9nMP76oqS/6aEZzpPBHw=
X-Received: by 2002:a05:690c:6986:b0:703:c3b4:45d7 with SMTP id
 00721157ae682-703c3b44963mr40875207b3.28.1743618532599; Wed, 02 Apr 2025
 11:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2a4f2c24-62a8-4627-88c0-776c0e005163@redhat.com>
 <20250401124018.4763-1-mowenroot@163.com> <20250402093609.GK214849@horms.kernel.org>
In-Reply-To: <20250402093609.GK214849@horms.kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 2 Apr 2025 14:28:40 -0400
X-Gm-Features: ATxdqUGTOorUCYsRGQ4r2FDIOcagFPztRxz3oaDvDqEej0LSOzdzpbCppUGWWfU
Message-ID: <CAHC9VhQAdxADGrqEDH4kUuoXsUS_E92UtTDcf+uF7J=QavkP3g@mail.gmail.com>
Subject: Re: [PATCH v3] netlabel: Fix NULL pointer exception caused by CALIPSO
 on IPv4 sockets
To: Simon Horman <horms@kernel.org>
Cc: Debin Zhu <mowenroot@163.com>, pabeni@redhat.com, 1985755126@qq.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 5:36=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
> On Tue, Apr 01, 2025 at 08:40:18PM +0800, Debin Zhu wrote:
> > When calling netlbl_conn_setattr(), addr->sa_family is used
> > to determine the function behavior. If sk is an IPv4 socket,
> > but the connect function is called with an IPv6 address,
> > the function calipso_sock_setattr() is triggered.
> > Inside this function, the following code is executed:
> >
> > sk_fullsock(__sk) ? inet_sk(__sk)->pinet6 : NULL;
> >
> > Since sk is an IPv4 socket, pinet6 is NULL, leading to a
> > null pointer dereference.
> >
> > This patch fixes the issue by checking if inet6_sk(sk)
> > returns a NULL pointer before accessing pinet6.
> >
> > Fixes: ceba1832b1b2("calipso: Set the calipso socket label to match the=
 secattr.")
>
> There is probably no need to repost for this, but
> there is a missing space in the Fixes tag. It should be like this:
>
> Fixes: ceba1832b1b2 ("calipso: Set the calipso socket label to match the =
secattr.")

Thanks.

Not sure if the netdev folks are going to pick this up or if I'll end
up taking it, but if I end up taking it I'll update the tag while
merging.

> > Signed-off-by: Debin Zhu <mowenroot@163.com>
> > Signed-off-by: Bitao Ouyang <1985755126@qq.com>
> > Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

