Return-Path: <netdev+bounces-123087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C162B963A1B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 07:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E5D1F22AA0
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 05:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5DD4D8C8;
	Thu, 29 Aug 2024 05:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U80bwJ6P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE55914C5A3;
	Thu, 29 Aug 2024 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724910984; cv=none; b=tLrdag05VyZeng3zGaOgec32tiLCeTwpXCmm1UutZcoyjbtaS1tYz5JgzQPp3MVi68LavsG1NRbCs/+AonsEuyXSGXc8T1lHuXaf5mCOnMUi8B9Qqjc+VZawGOl9958dGRIpT3lF9xpOAwKIWyK6F3V5oJ382FsY0HI5+s6jCrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724910984; c=relaxed/simple;
	bh=iyainqTBOI2KJZnApzZhFisnYAo8hdGHlo9bPxtpQ6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByB0hVNK9mE4J48zbMAKw1U+tmgePzB/cx1ROC86T5dbos0WA+y8xbtU2Nk80tEjHNeF+OJJ1Z39G7Fjwnftbl78rSf6ZmAlQbuRZpK7RsJu4LQsZS+2YpSb/XUUgyvVzbjopZHYcsaBVK+m1eVR9DWWtxtVO9jCGUNXmdqrg9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U80bwJ6P; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6c3f1939d12so2973377b3.2;
        Wed, 28 Aug 2024 22:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724910982; x=1725515782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oN+N69wCZiTHjAzKrZyYz5mHgQfDfNRMmqum6pBByWw=;
        b=U80bwJ6PpIYsR+G8SpL+XAt8G4BSnfNbuU3K93QVT0/6BBMfDy9Yus5qTVQiYsn4YF
         ytXaowjrex+yh0xU6S30ot73qn6lylIeqkpXASHrbuDq7r179ob448AEGRF0d24o6en+
         nT73eNfAglANSEg0AWpkdjD5PHaIuUx0sFn/Xlpg3Jz4QJYsthLfRKV6Y6/GmM++fmDo
         cR2MJkhM06x7dXysw3pAGsunGpsKPYOH57/lmyrmOsKCqxxot7wUA9Pf7MxBzoq6C5VK
         KmUjm2zl/3frQKVk9NB7699bCMhmqWCjl0sB8ufYuALwtiYYgSb/RX2nfB51FkyBx6wF
         Vn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724910982; x=1725515782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oN+N69wCZiTHjAzKrZyYz5mHgQfDfNRMmqum6pBByWw=;
        b=bbLpewKeMKL4ZOgxADwOhBL/HxwHMDA1k+TB7IlLOALUsPXPaaQPIrJaVN2tLCNZ3l
         lpW1OdFcTHFmU304JQnP7N3xokCHz8ihd+oCt7v7oMRvgrAaAbNffprwu1i3gJifi7PG
         NuQMgtvrY519KTSjpGoeCj2NuL+Fuwd+lUouNm5vgQwoqjlPXk/GX9raXbn/lE3rU/P2
         1Fb2f9P/warIM/Y+CUcMYjq35xIrKt3LZfbyK+uFVt9Fh9qY5xER0PpABalblBIC4+z2
         u3CSXWnw+8LDci2kcF+3INWXE/B47dAK0KTPQqEDVTiIp2eo6zJNYfsk0lV53mEdV8pJ
         TLzg==
X-Forwarded-Encrypted: i=1; AJvYcCWaIEuS/PgXxYg7OFAN8pU78eoO5jLfienShfGaJk1heD9NPbArW+iRBrv/z7TNXCYkWdRuhVXDjAqn8Ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYft3tOTjgxtF/hWpe1KiyfrkpXB5P8z+5fJHWlZ26p8HKfeGw
	4rJnUTuDEmkcsWv3KbOgRuttlneL2VuHDbqZyx+b7/Xh7G2mDmyAlRgwa/H1OktQw4LbUNtbqyv
	n43BRzp3DAcdFYpSmsgveJC68FCs=
X-Google-Smtp-Source: AGHT+IHP6BaFC1oihqrY9vQTIo6gIv4P0ceqYs0YTlDpfFUYDYPaoTA+3NjEoRcXUKcqpFYiXkn7384WVB4BcOYCKJc=
X-Received: by 2002:a05:690c:6206:b0:6b2:1b65:4c05 with SMTP id
 00721157ae682-6d2764fa003mr20738067b3.17.1724910981723; Wed, 28 Aug 2024
 22:56:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826192904.100181-1-rosenp@gmail.com> <Zs_9yVMp8moxGfpE@pengutronix.de>
In-Reply-To: <Zs_9yVMp8moxGfpE@pengutronix.de>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 28 Aug 2024 22:56:15 -0700
Message-ID: <CAKxU2N9Lhe7vMpsUgrdpZ7m04-eoT4XA--LRHO0-ssfkPbEyKw@mail.gmail.com>
Subject: Re: [PATCHv4 net-next] net: ag71xx: get reset control using devm api
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 9:49=E2=80=AFPM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:
>
> On Mon, Aug 26, 2024 at 12:28:45PM -0700, Rosen Penev wrote:
> > Currently, the of variant is missing reset_control_put in error paths.
> > The devm variant does not require it.
> >
> > Allows removing mdio_reset from the struct as it is not used outside th=
e
> > function.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> You forgot to include my Reviewed-by tags from v3
Correct. Although Jakub wants me to respin this removing that always
true branch.
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

