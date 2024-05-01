Return-Path: <netdev+bounces-92743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CBE8B8860
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 12:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CE91C231A9
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 10:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE4050A66;
	Wed,  1 May 2024 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fuAvOe75"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C3A502B2
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714558247; cv=none; b=WG9QbznYdNPueNTm7LDTjRcOZDbPEZyGWlXTL6YbCj9tmjzbQqDK8yXplrwziwsXZUDOuWPiocIGsyxeMLd9Ylh8YVcdIbSXHB5rIuzhN1zfOQYyKu9BjF/IWshyWvx7Ziefjmoa1hxySjfEh7TAjkXU+xky/VbycYy7s5aGVvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714558247; c=relaxed/simple;
	bh=JtSyd7g4+Jtz1B3iI7NjqV+kh4fx8eViP4BIghgi424=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLQVsc28AEwbvppY/SSciY3THVR+w+u0gTwTG8Hj3PtkDwZ0zZhgLQdXeNu5j/MKd6L9NYDwzYc172rOmOFcLUjtgaSFcSr3SNN4Ciru4MyLlzf+xNgCZB7QPO7m9aQgyS4pBoZToUM3gXc9WVgd7wgjErZ9rdC3vcsyAUCrJSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fuAvOe75; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41b48daaaf4so43725e9.0
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 03:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714558244; x=1715163044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtSyd7g4+Jtz1B3iI7NjqV+kh4fx8eViP4BIghgi424=;
        b=fuAvOe75V9Ymh4h9YpPG/AXh5NVO7kROWHeCt0cmeJi5WtrQV4BicZob1DbJFwSy4V
         uQ01dKnk13NKJTCOe2T7xl3CRmI2OijgffrYyH2U9LDE1+0edu9aNw6j9MWxmWYCxqU3
         dJchytjbt1jNTUo6bpdIGt60zzU2h0zUQUuoV5hVrOGe/dXhPCfMydKgd411BqXiNS5P
         6cBGzQV+hm0hTrPw62enlZIR2pd+Ovjmd161PerujJs9JU7pDGBLhTbDNZHpiAEhEod2
         n61kYC8gpUsCjaUQAsn/pN4DCDNY2/rRtp7UvB7rI5loMxBJQ8hofGWtBhY+dt4+gwTX
         hfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714558244; x=1715163044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtSyd7g4+Jtz1B3iI7NjqV+kh4fx8eViP4BIghgi424=;
        b=e6d260ggpj+v9MKXionn+NEBBJF5SEwE0VKgTwtkTX5RcgJG0EstJSpZfpJ7knE+2k
         Uk0a9jHuH8RufIqMMCbEML9IyW1/Hrbx6P27GW8D/S6GQFNt6245HyEGirHczpR0saXO
         eELIUfnoa+bkvb0DTrNkj0QULl+TPpgCeCup6qAtk2+dNe/d+cfA4awaUpTZt/q4WEnx
         qqmT2+4TAle/208Sr2sRKm7z9WWmoA2+uK8W+etSxWtP0gVSRh06c9H6wvTdfUQUE1bO
         OK5YRtPulsTe2Yoq3KgCuPp86G8JoWYytdS1TwXLgEnTpUrq0N3cO6+RxzWe0ykvRKGf
         axBw==
X-Forwarded-Encrypted: i=1; AJvYcCWMpdF4TzusJ5TK4gTcpeAanGLIH56DURI8rfDqqJOyxBqFE/E02XqP9zfSxo9pHQAoUhDarLgVie3sr5xVuWlhig/1hgKm
X-Gm-Message-State: AOJu0Yz4H2JfabKARSbpBXVh+7HHht2u/E/uoE+mX11J1MotZj7lJ0a8
	I3mVp7CbyVFzXOnUC3rKGcAfI91lY8ncYPC2epnISSDM/nOGHB2C/1bwDCC1K0ss7z6AT4XlAdb
	0xUiRwfAqjoedNGkd3TkKxarojWCj0DOt/v+b
X-Google-Smtp-Source: AGHT+IHQS3yuesZZtZzWaIichEY/R/lr0LDHmlp+qEqzVBllxP7SotxY4UT0InZ0ezFgWFMgAUTTVyms5+Me3CJvUsg=
X-Received: by 2002:a05:600c:1c8b:b0:418:f219:6f4a with SMTP id
 k11-20020a05600c1c8b00b00418f2196f4amr163605wms.4.1714558243524; Wed, 01 May
 2024 03:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1239c8db54efec341dd6455c77e0380f58923a3c.1714495737.git.gnault@redhat.com>
 <ZjITTeK_BhGbGGjp@shredder>
In-Reply-To: <ZjITTeK_BhGbGGjp@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 May 2024 12:10:30 +0200
Message-ID: <CANn89iJ5Ro3Q51YOM2mT1rgwfKiwq6UWtRCMkADsfiTF-=P8kg@mail.gmail.com>
Subject: Re: [PATCH net] vxlan: Pull inner IP header in vxlan_rcv().
To: Ido Schimmel <idosch@nvidia.com>
Cc: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Amit Cohen <amcohen@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Jiri Benc <jbenc@redhat.com>, Breno Leitao <leitao@debian.org>, 
	Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 12:03=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Tue, Apr 30, 2024 at 06:50:13PM +0200, Guillaume Nault wrote:
> > Ensure the inner IP header is part of skb's linear data before reading
> > its ECN bits. Otherwise we might read garbage.
> > One symptom is the system erroneously logging errors like
> > "vxlan: non-ECT from xxx.xxx.xxx.xxx with TOS=3Dxxxx".
> >
> > Similar bugs have been fixed in geneve, ip_tunnel and ip6_tunnel (see
> > commit 1ca1ba465e55 ("geneve: make sure to pull inner header in
> > geneve_rx()") for example). So let's reuse the same code structure for
> > consistency. Maybe we'll can add a common helper in the future.
> >
> > Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
> > Signed-off-by: Guillaume Nault <gnault@redhat.com>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

