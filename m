Return-Path: <netdev+bounces-102201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC3D901DFD
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1771C2121B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63B47406A;
	Mon, 10 Jun 2024 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8BKY8FO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8A1335A7
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011255; cv=none; b=a8GWQprBMjdcoZ8OBpO0AGi4J/SNQH1Lw1E5q0O/V90HTyFB2oFYYubdzoEUUQXrSRDayYjQZVHmQWdb7hWCW1PL+Xw60BbA0VrCCH6KDZHsB8u7U9wNv82I2eceRNez54yZrpFv3DHs1vOprMMzMQdf0FZx1uOw38xXwJ+XAOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011255; c=relaxed/simple;
	bh=Xv/dEiCRkSpodmaL2d//ZO1u0bmo9WpTjN01UGyMVF0=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vie01zt0I6jzXSDb9V8tR8bpRaeho0Miu8ERwgrZrSZZGkZLDJC/TeJd/u9pvTklyz6Aev/eqv+0qaCy/l2qUu3KjiSVr6rcqwR9xBliYWOK2qga/CRdIv8aNyHlW03wONGQtvh1C0G7PCDVHnaoy+Md+qpjCGZ+YTBGxv2pNSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8BKY8FO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8iJ6dvPVXFgwtQ4T7unQwyUfRp5ecBG5cGhKrfZARQs=;
	b=G8BKY8FOcWpbnMeeE2kw3xyjlKnSMiX7fc0hRhCOOlmBVaaWZLK8f/U8KwGM1X7ceK7EGP
	25uxZmMjuhuQygqdq6zgK62z6wQ8fazFciaC80A7mNYLW/pMKg1mdmAcMxWm4ROxz4Jpnm
	tyGYKnWcYYQy8YkPal16cj/vsPRKRno=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-r5rRz3VyOyCAlZ8tiJNrSQ-1; Mon, 10 Jun 2024 05:20:49 -0400
X-MC-Unique: r5rRz3VyOyCAlZ8tiJNrSQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-629f8a92145so69252257b3.0
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 02:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011249; x=1718616049;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iJ6dvPVXFgwtQ4T7unQwyUfRp5ecBG5cGhKrfZARQs=;
        b=tLaSBvLqIveczXY7EGp8adhPh2ns4Jd8nDPsn678F/r/SX8ABK+hjVS7+iMoiBMqKG
         CNSJs9IM+A9oQuGEeRGIjyAm3TFrLx+z0+gTxhdNG2HVHYldZ7aU/Ygjv22cPN3qF95n
         c9nWmMfIIWhfpVlyFeiMd7byluCWiP+nvML6NSEwNbrbRnT5QYYS+Re5/EOjLJx+bMm3
         fN2Syupg2Qub7adXJX6e7bwr4D2vFX2DHDAr0vTmIV55HtDDpR7zTtY4vW582abRSoS6
         xN0yR04wWz3USQvCjEvHCAjQ0w4pBMCx+t9BprHEDeZ9KpcAEb5nL0dGLLGEmSz2kqnC
         XMUQ==
X-Gm-Message-State: AOJu0YwTT4DTBMoKW0SWugz4SMlhyhoT6dpmaKlJCeOQYs5vc9THAi9M
	her8vAqF5ZNA8TbF7GbVeOo+bUP/zeQK7G6YCd+DX2dkt4bfHW0q2G4yB2b07hXuB01/k5UaiDw
	Xo4OZDGTri4KaemtdqGSoWTSMP4zFs/ncko5u+bdGoIRT017oVqtVXxJhJi7I57cp1Ao94dC9Hb
	LXC7bDhD9NIoHnX/5diqxudN2ZrLJR
X-Received: by 2002:a0d:e304:0:b0:61a:cea1:3c63 with SMTP id 00721157ae682-62cd56a9f69mr80025637b3.47.1718011248850;
        Mon, 10 Jun 2024 02:20:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFjnKBptFBgLEV5bzktHbMReA8zI8OX4PPVkODmioQ2wqMk8XLBtAg+pDd9bzT3M9lgzkU0g8BWKSGH4IH14Q=
X-Received: by 2002:a0d:e304:0:b0:61a:cea1:3c63 with SMTP id
 00721157ae682-62cd56a9f69mr80025547b3.47.1718011248570; Mon, 10 Jun 2024
 02:20:48 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Jun 2024 05:20:47 -0400
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-10-amorenoz@redhat.com>
 <20240605194314.GX791188@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240605194314.GX791188@kernel.org>
Date: Mon, 10 Jun 2024 05:20:47 -0400
Message-ID: <CAG=2xmMgEUVwhqSFV5uXe_HuXeMaN7kDPW5TpmcihHYe0seo+Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 9/9] selftests: openvswitch: add emit_sample test
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	i.maximets@ovn.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 05, 2024 at 08:43:14PM GMT, Simon Horman wrote:
> On Mon, Jun 03, 2024 at 08:56:43PM +0200, Adrian Moreno wrote:
> > Add a test to verify sampling packets via psample works.
> >
> > In order to do that, create a subcommand in ovs-dpctl.py to listen to
> > on the psample multicast group and print samples.
> >
> > In order to also test simultaneous sFlow and psample actions and
> > packet truncation, add missing parsing support for "userspace" and
> > "trunc" actions.
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>
> ...
>
> > @@ -803,6 +819,25 @@ class ovsactions(nla):
> >                  self["attrs"].append(["OVS_ACTION_ATTR_EMIT_SAMPLE", emitact])
> >                  parsed = True
> >
> > +            elif parse_starts_block(actstr, "userspace(", False):
> > +                uact = self.userspace()
> > +                actstr = uact.parse(actstr[len("userpsace(") : ])
>
> nit: userspace
>
>      Flagged by checkpatch.pl --codespell
>

Thanks. Will fix it.

> > +                self["attrs"].append(["OVS_ACTION_ATTR_USERSPACE", uact])
> > +                parsed = True
> > +
> > +            elif parse_starts_block(actstr, "trunc", False):
> > +                parencount += 1
> > +                actstr, val = parse_extract_field(
> > +                    actstr,
> > +                    "trunc(",
> > +                    r"([0-9]+)",
> > +                    int,
> > +                    False,
> > +                    None,
> > +                )
> > +                self["attrs"].append(["OVS_ACTION_ATTR_TRUNC", val])
> > +                parsed = True
> > +
> >              actstr = actstr[strspn(actstr, ", ") :]
> >              while parencount > 0:
> >                  parencount -= 1
>


