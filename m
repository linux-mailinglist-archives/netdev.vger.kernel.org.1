Return-Path: <netdev+bounces-80659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C5D880343
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 18:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F091F23429
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 17:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2F8171A1;
	Tue, 19 Mar 2024 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NoUVK/p+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DA12031D
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868683; cv=none; b=mPdGvn3IixpHMld1kxmolh7H4Y+ydXodcCm0Y7gJhzKNSyAwTcvovBOTJ+6X2GiwvtJFY3P5N0kxNfaXjPcARLrN6QIYHbO1ZLVI7NcNOFwI65aGYEIRYmDQs0uR8xsr4AmQGP5i4K7vBRkmR+noLmAuy4z4N4s7gu4SO7JYbzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868683; c=relaxed/simple;
	bh=W83zl3ZLS+HsPMQS5LRUk7fpZ5MkYeiNO326nwQR+TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3OPRFGif5rHKQSCSThNoh77Jx/LXy807FKEF2quA4bAmyx8aURKMNAi05BY8rVCqQbiuKupdDhTwJSawl9lfF2pAadwsB0pT7EE5tRyMQrT0tUD2bOgp/YRH5uJlbSfvdoV0oVCrxAxaaoEfXXiyla2IXPzLpT2Fcvr15KpuK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NoUVK/p+; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56b9dac4e6cso794a12.1
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710868680; x=1711473480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dr7fBtM1LEiJ2CrIx0DhLAiCaLMDkZLjkCt42+n7qho=;
        b=NoUVK/p+Pda5yCds4rgDV21A7eXyEAOqZRmpFimbSvTubHER0ebnODWYLBn+lAMa3k
         Vnv2Rbd+92UDaCsL5yRlnVWQXsJyAV4IBMftahQ6SzQkES96h8ZqKPE6FYvCZlKOWaRQ
         oIIOuSg7YttfCQ8mP8o/QcZBgakZXtJwL4F9KirW198EzlQ7XenO3r31PROSjVCWRd1v
         yQQ8cePHaOMnBdNXTXwtC8lHbTac5pF6q+WfUuicgtoLxn2YTfnWzQqnNtuh5jf6HIrC
         /DmKZG5zmfJ4qELpBUF8L3Vn0C05eLzT2seubvYcV/Rc2TY6X/VYJVCbwpMcfnOmG7F0
         tByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710868680; x=1711473480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dr7fBtM1LEiJ2CrIx0DhLAiCaLMDkZLjkCt42+n7qho=;
        b=S+jDYpSiEE5FSUtffTFDgBDHPZ6tVpN/psstmHccgsxN/3DVhW+z2z5r2aIBR2f5uL
         DPIcblm8zieNVfJE2t42BZDw9B1Y/quGQA6AIM85MKYd8C6kwl32m8muB44HmQIriJZq
         cCMoIVhoWIoVQS6i6cGhBcZZQRfMnA0DpKC0Tpsr9fXTYznjRKs3WZ3GSTyUvls/+Rep
         EZs3VEPM+t0KJbnqc7akQ7CQmGu6yzdzBcGJGQhapo8Pb7anDdgC9/tRS11SQXmo0QJE
         4O2vYsNK60QzSDAcpW6MqH2608pwuMhJeogIY6bJZY611SbTrT2whOtScoGINgaE5lVf
         h4Ag==
X-Forwarded-Encrypted: i=1; AJvYcCV4M1G6q784YPXQthH7PpeI3Nhewa4gMLwQlMNSl34Ppye/YS/0yrFiHUkQb6sTUtnt5qCabBqT9m67FB3mu5k9zZ+tkGeQ
X-Gm-Message-State: AOJu0YzL1+kqeuYFs6386Uo/Q8X4tbmEnaZuIaPvvFRbags1Oep7qtIo
	1DH5GRWKrpaD/i7N7UtFoO+5v9u+vIf60l2d0TeG/mvNgPFS98sbe2gfx5J0nzwBzqQTBI77yr/
	DOkooLEaJOR3j38wlh6+vtH0lyLC/nOkcOBYn
X-Google-Smtp-Source: AGHT+IF0twPJdIbDYmQIt9YeIlCGcp/gll7JcM72FFU1CPR/ot3fi3BO5PjM35ZbOWi/A2yW3jIEYlBgBMTxtQrCblM=
X-Received: by 2002:a05:6402:8c7:b0:56a:4f23:f644 with SMTP id
 d7-20020a05640208c700b0056a4f23f644mr13054edz.0.1710868679798; Tue, 19 Mar
 2024 10:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303052408.310064-1-kuba@kernel.org> <20240303052408.310064-4-kuba@kernel.org>
 <20240315124808.033ff58d@elisabeth> <20240319085545.76445a1e@kernel.org>
In-Reply-To: <20240319085545.76445a1e@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Mar 2024 18:17:47 +0100
Message-ID: <CANn89i+afBvqP564v6TuL3OGeRxfDNMuwe=EdH_3N4UuHsvfuA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] genetlink: fit NLMSG_DONE into same
 read() as families
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Brivio <sbrivio@redhat.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	pabeni@redhat.com, jiri@resnulli.us, idosch@idosch.org, 
	johannes@sipsolutions.net, fw@strlen.de, pablo@netfilter.org, 
	Martin Pitt <mpitt@redhat.com>, Paul Holzinger <pholzing@redhat.com>, 
	David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 4:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 15 Mar 2024 12:48:08 +0100 Stefano Brivio wrote:
> > > Make sure ctrl_fill_info() returns sensible error codes and
> > > propagate them out to netlink core. Let netlink core decide
> > > when to return skb->len and when to treat the exit as an
> > > error. Netlink core does better job at it, if we always
> > > return skb->len the core doesn't know when we're done
> > > dumping and NLMSG_DONE ends up in a separate read().
> >
> > While this change is obviously correct, it breaks... well, broken
> > applications that _wrongly_ rely on the fact that NLMSG_DONE is
> > delivered in a separate datagram.
> >
> > This was the (embarrassing) case for passt(1), which I just fixed:
> >   https://archives.passt.top/passt-dev/20240315112432.382212-1-sbrivio@=
redhat.com/
> >
> > but the "separate" NLMSG_DONE is such an established behaviour,
> > I think, that this might raise a more general concern.
> >
> > From my perspective, I'm just happy that this change revealed the
> > issue, but I wanted to report this anyway in case somebody has
> > similar possible breakages in mind.
>
> Hi Stefano! I was worried this may happen :( I think we should revert
> offending commits, but I'd like to take it on case by case basis.
> I'd imagine majority of netlink is only exercised by iproute2 and
> libmnl-based tools. Does passt hang specifically on genetlink family
> dump? Your commit also mentions RTM_GETROUTE. This is not the only
> commit which removed DONE:
>
> $ git log --since=3D'1 month ago' --grep=3DNLMSG_DONE --no-merges  --onel=
ine
>
> 9cc4cc329d30 ipv6: use xa_array iterator to implement inet6_dump_addr()
> 87d381973e49 genetlink: fit NLMSG_DONE into same read() as families
> 4ce5dc9316de inet: switch inet_dump_fib() to RCU protection
> 6647b338fc5c netlink: fix netlink_diag_dump() return value

Lets not bring back more RTNL locking please for the handlers that
still require it.

The core can generate an NLMSG_DONE by itself, if we decide this needs
to be done.

I find this discussion a bit strange, because NLMSG_DONE being
piggybacked has been a long established behavior.

Jason patch was from 2017

