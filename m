Return-Path: <netdev+bounces-140608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742189B72B8
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 04:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F94E1C22DD7
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 03:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E2341C77;
	Thu, 31 Oct 2024 03:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAKKSvLt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0550C1BD9C0
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730344160; cv=none; b=Il17oPrJoWobRSXAi+m/z6OW5hykig9xKdyFQqxbtMaEYxcPw9RFLrDkbkJtkOhQmLzGMAopQ+EvfUwFs+kk4TAk1SUR9veHQi86MyYrYqos71B4G5nQKTnJ87gjbA4ZOaLzGYmeeNU1nG9WoFa0ZqbExoDzuNzmdWShBXn664I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730344160; c=relaxed/simple;
	bh=KgnvZL2ZA+4SPyLTzr+3AIWZ0fzLF5OgOqG/8XWn2WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExuA0lHCGdYgM0RAU4f+JYVctmZZSiY/9NWgK0eXGfaJ9yAWwnyWL/Al9sSTYEY+YS3DELtM7LNwWDSAro5CcRyH60lGMgpoROh26NM/6VZAMfQP2MLUSK4XodIiKpN2XHs//O/m7pfVZrHpvky6jWOG4giC5JIwoO2dLlWv6w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAKKSvLt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so3685185e9.3
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 20:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730344156; x=1730948956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7MviYJaBTWpKrl0UgzKPOssN9tJfvfEubtHUkNJSeo=;
        b=bAKKSvLtOZXxFhXRhAT8Gx8Utyd+7fNhY4mmt+q82zz4DK8nIACZIosF6JgdyFmu9v
         dezYnlWiRDCqmMAQ3A6cnD8Fq/ZW8spQrMA34kGqwW0+7dorX4X1daIFkBZD4viqBVQg
         T2OqdiK9ekrQGDQD59L1lg/kdZbZT1LANMSC10jiZQAo/beuGTAVLgRUToaHAZN7lmMQ
         1kSWGX1HELSb2m5hpr72U/SxI+kNSBMJb0OfPh/DcGVdxiLdktYbaxvcxTSlQ+PflcLJ
         agFuE6qdauPjIjcieg9HFimytSPiaaCKImwO663oGgDmY4a+dPvIF0GAPpQC+tW+XvRI
         0Irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730344156; x=1730948956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7MviYJaBTWpKrl0UgzKPOssN9tJfvfEubtHUkNJSeo=;
        b=TB4u+g7Ar3AMeCM7iAaxToCndOySrltl8mjQ7GbnjIRm8o45EUNWBQCqW1w0IH1Tkn
         5dow2AqeNAwjVff0k6zN9yJrtyHzNqRzfcuTbsueop2PE75JGDGs/3nA6euXiFtX4S7D
         8u7tT2N+bO3wErhTBUT8Ty2WKbsXYklKhYxR/D4iHP67MEGE9lVm+hTLLVzgpyy22rbC
         BooTvR/aO3+An8tKubia3d2QGlSFbfYWjoCS9ymNRtzU1jtVtPyQXXl8ADFvTnvLjxUm
         a+1HOaVPT+dzKMmd+CORr5Uq2n5Vcab6E399SOxN70f0FjlZ7snIHwN67wpq6QBAjhE0
         X6XQ==
X-Gm-Message-State: AOJu0YyrxM8ENHWAXvr/MR2PzNhV84HCUvEGJoMGpX5mHYSNykVtJUQ5
	jRZwHa9e8XqoQG9uCxaNbvhCwAF9qOH98iN9ClpXNy/bCtYaxSfDsFpoAYcqu/yLTTce2w84G6V
	EZ0RQYNsbcBzCCkxlx7B8KJzoW5k=
X-Google-Smtp-Source: AGHT+IF8iQ8g0b48vMMTRI9mrFw/3njEGwWcAoh6NqWQpYWBSDiLDZ+XV+OP/pzoD1H+JexuYXJ37T6jc9NQvaS0x10=
X-Received: by 2002:a05:600c:1f82:b0:430:57f2:bae2 with SMTP id
 5b1f17b1804b1-431bb9d14afmr40464555e9.23.1730344156044; Wed, 30 Oct 2024
 20:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023023146.372653-1-shaw.leon@gmail.com> <20241029161722.51b86c71@kernel.org>
 <CABAhCOQ60u9Bkatbg6bc7CksMTXDw8v06SDsfv77YpEQW+anZg@mail.gmail.com> <20241030163504.47a375f5@kernel.org>
In-Reply-To: <20241030163504.47a375f5@kernel.org>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 31 Oct 2024 11:08:37 +0800
Message-ID: <CABAhCOR5G+7TprR1NnFpjM61kCBpjAZ+SFhQDxKKr6EsB7Y5JQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] net: Improve netns handling in RTNL and ip_tunnel
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 7:35=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 30 Oct 2024 10:10:32 +0800 Xiao Liang wrote:
> > > Do you think the netns_atomic module param is really necessary?
> > > I doubt anyone cares about the event popping up in the wrong
> > > name space first.
> >
> > We used FRRouting in our solution which listens to link notifications t=
o
> > set up corresponding objects in userspace. Since the events are sent
> > in different namespaces (thus via different RTNL sockets), we can't
> > guarantee that the events are received in the correct order, and have
> > trouble processing them. The way to solve this problem I can think of i=
s
> > to have a multi-netns RTNL socket where all events are synchronized,
> > or to eliminate the redundant events in the first place. The latter see=
ms
> > easier to implement.
>
> I think we're on the same page. I'm saying that any potential user
> will run into a similar problem, and I don't see a clear use case
> for notifications in both namespaces. So we can try to make the
> behavior of netns_atomic=3D1 the default one and get rid of the module
> param.

Ah.. I misunderstood your question... Besides notifications there's another
behavior change.
In this patchset, RTNL core passes link-netns as src_net to drivers. But
ip tunnel driver doesn't support source netns currently, and that's why
we have Patch 4. As a side effect, source netns will be used if link-netns
is not specified.For example:

  ip -n ns1 link add netns ns2 gre1 type gre ...

In current implementation, the link-netns is ns2. While with netns_atomic=
=3D1,
link-netns will be ns1 (source netns). The module param serves as a way to
keep the current behavior.
I think we can make it default for drivers that already have source
netns support.

