Return-Path: <netdev+bounces-121145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0187D95BF71
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 22:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C64B21A18
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 20:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC081607AA;
	Thu, 22 Aug 2024 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wIjMG/ai"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B4B15098A
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724357511; cv=none; b=b23TQ32YPDBo5i6XxXcRsQqQsTEo0mP/hwhqAC9WsdwqjUDjI0OAON84PeMYameVOK9d0JHzlMzybiXY2xjqFnTFhGOd/lQ2p7tXpu3PtCSMjA8M5HykGvUtZLKQI16/dsdzdvE5bCXkhZX9qAH6bRtstD2WGEyBLFYAmzueRD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724357511; c=relaxed/simple;
	bh=qGlhYFF3nk7bXnzKNyoCRhhPqyWWpHcvSbN2qBzJQ+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdfaCtncnbZUtLbSzcNUNuG7dgWY56/I4SlZr60dfLhlWYVT4S2kWBcj4qtZK5NqFobHXdm/yLZqEAGS6oeWCHr2qi5VNqyU2PXlLNCLEPLbPdyyIJnOP9NnLJ9a+g2fVo4XDaCAbN71VmnDiOhijchY5WpTA+H+a55ucXxMWzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wIjMG/ai; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a80eab3945eso143064466b.1
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 13:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724357507; x=1724962307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGlhYFF3nk7bXnzKNyoCRhhPqyWWpHcvSbN2qBzJQ+0=;
        b=wIjMG/aiXwJltio8zYRNyjQokW+cfZMwZV253rMyWlPko49z8CdB8onfAzoxgnMChM
         Bt3phiGc65g2QILuvlNjxlRIPu/qMWqbNsBm0L36BC3cW9xwqI5JHbaP1n07nv7qOVrd
         0sndu+FHQxfcuroJqsDayw+It2ccu4mizTOGo8gKI07g/i08fvM229Ck6gnCMWj22GvD
         Ad1fUGoxhOc3nBLufJ6ylDcK1mgLCQpN3+lEpOvYHMGAdM/FCBlpZdBEh8dx3uc7QicB
         u3WyoC/6rNBz3Nk75+AmNbU55nCgbPNddGEhz3qmTy4R+oxH8kHTUGjBoPwrJsKUyfG6
         CLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724357507; x=1724962307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGlhYFF3nk7bXnzKNyoCRhhPqyWWpHcvSbN2qBzJQ+0=;
        b=hgFYGo+mWy5ckWPXw9zVxJSrz/2aA3Mxukswp+IU/P5lRKjmWsF6zhrqlkccOJNXXu
         KsTnYwQY0hbgDBns+fDqNmeBwt4IEjwjAl9OmPT/5C5P/g6eivH7pZ26tRV8bfXPP/6c
         wrUzizHI3CJuMUwFLfQqq1iT52XdNSoC3UkHbMH3KpAZxsX2X3+iLQgmCmt/sP5TiArV
         UaHZqdUHLDpTZacaVaWMopruWmbSTvhvHKu3xMA/Ct+A19FM60ouLWQLnkbK9lFzBGXD
         8xW0feVcPXfvSUT2PMEuUmQyvy3iA+M74LJD+b/TPD00CUZQfp44rrpeDbbCGnv3mE2k
         2gXg==
X-Gm-Message-State: AOJu0YxWzvPBzynkc3JGZBUWeIn66LIjaKX6WQxW6JH/9ttPQQmJOYm8
	d01Eg9klDUKmU32zZOU5FCxuK/OP6JF50RDpzWIUjSjZYECz4MALcgs3tM0p/6UyewQXBz6PpAX
	Tq4jXzhAXlhtiS1QoTM/XWrVKmxxo5K+aYuQVEwbSgVDZ+yYse/Mg
X-Google-Smtp-Source: AGHT+IFUZZVYeFvoYeBf0qaPOytPvPF/rXlKa4hyu52acLVoMXtMt3F/SCNMVQe2zBPVaxfhjpbBHSXCssKNH4YtA5U=
X-Received: by 2002:a17:907:dab:b0:a86:8ecd:bb1b with SMTP id
 a640c23a62f3a-a868ecdbd6bmr310203566b.58.1724357506677; Thu, 22 Aug 2024
 13:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812182317.1962756-1-wangfe@google.com> <ZsLg3YEX/o/GEe+P@gauss3.secunet.de>
In-Reply-To: <ZsLg3YEX/o/GEe+P@gauss3.secunet.de>
From: Feng Wang <wangfe@google.com>
Date: Thu, 22 Aug 2024 13:11:35 -0700
Message-ID: <CADsK2K-kOv-w+ZGFUKfUgpSdcx0d8wX4GHkecg6=qy2gtgmNfA@mail.gmail.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, antony.antony@secunet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steffen,

I have added the reason why SA info is needed in the commit message.
The new patch is
https://patchwork.kernel.org/project/netdevbpf/patch/20240822200252.472298-=
1-wangfe@google.com/

Thanks for your review.

Feng


On Sun, Aug 18, 2024 at 11:06=E2=80=AFPM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>
> On Mon, Aug 12, 2024 at 11:23:17AM -0700, Feng Wang wrote:
> > From: wangfe <wangfe@google.com>
> >
> > In packet offload mode, append Security Association (SA) information
> > to each packet, replicating the crypto offload implementation.
> > The XFRM_XMIT flag is set to enable packet to be returned immediately
> > from the validate_xmit_xfrm function, thus aligning with the existing
> > code path for packet offload mode.
>
> Please explain in the commit message _why_ we need that change.
>
> Thanks!

