Return-Path: <netdev+bounces-184142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C91A9372B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 14:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584581B66863
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 12:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D692A274FC5;
	Fri, 18 Apr 2025 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orbstack.dev header.i=@orbstack.dev header.b="lFzcgBr2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7023A1A3168
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979689; cv=none; b=CO273W/Ie9HyHCX/+pW8o3IEkj8jZs04pDK6vLcph9jln5k06aWZFMjQ5mS5cqIyVydjUx8wzsUx8a7RRLq1EJPjshVY2zpZGVy0FJ1Fe0b0HlKMJFn9IhU0nI35tAK4lNHShYbGHKe3OhtfnhW9WAIq7m9q2CdZytr2/AR7V0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979689; c=relaxed/simple;
	bh=43hHFRCwrwfsE5PGa6AoyXcX6jfLuJQDkXOgCch4+f4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjtR6IcWRbYVN5fL3fH6+m383KoMGkU09DggoFyYeJxHOmSoZCu2bcJMwi3VsestCZN7E0CJ16UaP8iI6PsD1YXqudfTS0m6e/oLT6ilfYu6piOMiYOzUSJk6k7XjcmKgvdm24wpTopSlXTq1RQ12BCDEPmABI3E/bcPOK8T6yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev; spf=pass smtp.mailfrom=orbstack.dev; dkim=pass (2048-bit key) header.d=orbstack.dev header.i=@orbstack.dev header.b=lFzcgBr2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orbstack.dev
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2255003f4c6so22411825ad.0
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 05:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbstack.dev; s=google; t=1744979687; x=1745584487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43hHFRCwrwfsE5PGa6AoyXcX6jfLuJQDkXOgCch4+f4=;
        b=lFzcgBr2a6tbyJ3q7TWhNXxd2ok5oySM2t0HdSkPholovtgTP7LwzPpOOzxlb4AP8F
         LTiS0xTnmRSualSki2EM01N+cPcE7XT99zyJknyApjl97ufDbuHbURArb0k0wOmbkRti
         EmWovSoeYSIWpYnQH7TIKTES+YHNCDyIpdhWZ+9Zc8MCj3G+XE+UXqLyalWAUkjJQfZS
         cYNX9FYOjZlHm7QBS3TVfTf2yfkNh8TalEYODimEJSVyIdfScL+2kaNXrM+h2Nd3dgMU
         ApvDEWiEy9gloFvZ5zxDyrksDc+oexU99V9XZ193DNr3yBzAFPjRAEOhAxk9kFSfBuFS
         tbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744979687; x=1745584487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43hHFRCwrwfsE5PGa6AoyXcX6jfLuJQDkXOgCch4+f4=;
        b=CJgGRsIFYF0IpgX38lbf59/5CX9XwVWxDdAjw3xVBjIT2ICNJtxvGEHG/uNvk66lCl
         AK3qhdRa8wK3CZ9MUDf8S8S9gxDTfM2aAzAt5oeVi3oFe6DBvQpp7si+Td66K8QfeINm
         FShUHLjAUww5MFDWORbPyOBvsCDfG+ZYrc8T+DuvIVWvieNqryqMMFD7UKxBz35qyoBu
         hODmK+mj9ejrJOTFr4i/miS5hNRvyo71XkW+nzQGgxm/1NRA53OiMdZD2aCQmxDPsogW
         mner3Y8fmNr59YQ9KmnyWchciWrreys9QBCeps1W69O0PlVaprQmaqKyJEPAUvnL/8nN
         NJdA==
X-Gm-Message-State: AOJu0Yw2/8sIiBAJc9BVyAkeYA9QjpMLlJJ7RaDu1yXKGGKIM3J4PBdY
	IzLedDlwA4ddOn6u18HejRA32lMEhHHNOgLzbpvbeTEb6+XUWDkkzbZE36z+3yVeyFrCiBDgyas
	DKTU9MknPqowp5UFq6xNR8OeSdwoVqjRY7iGJNQ==
X-Gm-Gg: ASbGncuyLwol8rU0pI+ey5EtfzedKXjxXhce4F/vyj6ApZB3OQbdqoBfBNQgh3zLLP4
	nuwhhrxM5+xGSOJYuBurCJPJ/DOmQkPf2USGAv+p0XTzRrVRzJGapLg3YMKA+BOUdX2dxEwpMc7
	HCV7T19xzNqhabcLW0AUpyR/oNp8wlgo5RdB/GrukZXKUwBv4YgTfxG5Vb
X-Google-Smtp-Source: AGHT+IG5hnVsBWjkUmDaGddd3kNxM76BE02aaGQ6/6mkeMa3Whu0GdcJvbuW86cKDIht0D9pPl2GmX8ETJhwFoXXPkE=
X-Received: by 2002:a17:90a:d64f:b0:2fe:d766:ad95 with SMTP id
 98e67ed59e1d1-3087bb47646mr4283842a91.9.1744979686618; Fri, 18 Apr 2025
 05:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121745.8061-1-danny@orbstack.dev> <CAFnufp14ap0UfJcn2uwU4-3cstr313J86HvRCcKULZLRU=nZ6Q@mail.gmail.com>
In-Reply-To: <CAFnufp14ap0UfJcn2uwU4-3cstr313J86HvRCcKULZLRU=nZ6Q@mail.gmail.com>
From: Danny Lin <danny@orbstack.dev>
Date: Fri, 18 Apr 2025 05:34:35 -0700
X-Gm-Features: ATxdqUEj80hmbgdtqMeJNMf-q7-FLAiu7bNMA3xCWWCR3yFNOjqZUWqbn0J4ixs
Message-ID: <CAEFvpLe=wtaRGx0QyzCFgwhr+gWXHjWgcQLJrppb0EdsCFw7UQ@mail.gmail.com>
Subject: Re: [PATCH v4] net: fully namespace net.core.{r,w}mem_{default,max} sysctls
To: Matteo Croce <technoboy85@gmail.com>
Cc: netdev@vger.kernel.org, Matteo Croce <teknoraver@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, 
	Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 3:11=E2=80=AFAM Matteo Croce <technoboy85@gmail.com=
> wrote:
>
> Il giorno ven 18 apr 2025 alle ore 12:06 Danny Lin
> <danny@orbstack.dev> ha scritto:
> >
> > This builds on commit 19249c0724f2 ("net: make net.core.{r,w}mem_{defau=
lt,max} namespaced")
> > by adding support for writing the sysctls from within net namespaces,
> > rather than only reading the values that were set in init_net. These ar=
e
> > relatively commonly-used sysctls, so programs may try to set them witho=
ut
> > knowing that they're in a container. It can be surprising for such atte=
mpts
> > to fail with EACCES.
> >
> > Unlike other net sysctls that were converted to namespaced ones, many
> > systems have a sysctl.conf (or other configs) that globally write to
> > net.core.rmem_default on boot and expect the value to propagate to
> > containers, and programs running in containers may depend on the increa=
sed
> > buffer sizes in order to work properly. This means that namespacing the
> > sysctls and using the kernel default values in each new netns would bre=
ak
> > existing workloads.
> >
> > As a compromise, inherit the initial net.core.*mem_* values from the
> > current process' netns when creating a new netns. This is not standard
> > behavior for most netns sysctls, but it avoids breaking existing worklo=
ads.
> >
> > Signed-off-by: Danny Lin <danny@orbstack.dev>
>
> Hi,
>
> does this allow to set, in a namespace, a larger buffer than the one
> in the init namespace?

Yes, the idea is that each net namespace is controlled independently.
Privileges are still required to write to the sysctl for whichever
namespace you're in, so unprivileged containers wouldn't be able to
exceed host limits.

Best,
Danny
Founder @ OrbStack

>
> Regards,
> --
> Matteo Croce
>
> perl -e 'for($t=3D0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

