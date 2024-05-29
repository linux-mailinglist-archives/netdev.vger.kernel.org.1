Return-Path: <netdev+bounces-98928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CDA8D324F
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3E61F217D2
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D65169361;
	Wed, 29 May 2024 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiNB/EY5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81A168C3B
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972619; cv=none; b=s1nYjmQ4SrbaAolpGmA0n84HLhZq7TLasNmL8dknQD5GxKtSFKB0qcUTZpKaxRcYCwPcl0u6JpggxwLb4gBpy0ODTE+XxZVH6TDk8dz2UbtmZpJqQ8asBxht9S6EVdUl9dtWK7X7Tjk/m6puuqTk0zws/Ft/4pWNYDRB8BGc5+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972619; c=relaxed/simple;
	bh=LWhapFlrYGlL3YLRtm+zR6NsKskGY0BJuUVe1XxwHE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVqJC408IoMVD04VwU4QYe/a0NBRkDTgaxYDY/ODCtp7cLCB0QxMTMMJSG/hgO1SbYfRwA1esM4F+wL3DrSDeKPz5QzsLvr8ZYTNpdhMYBOhqJuuJsVSJx/qD+On6PF6RCjpkw8Tk1rRQdyRBX55MCqir+K4nO6gylh7CjVqzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiNB/EY5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6302bdb54aso251973666b.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 01:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716972616; x=1717577416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0XUQiMDJ7IOckNnbNQGqUrJQwgDDw+TihOSXEGeG6I=;
        b=AiNB/EY5BH0PD9OPanQxumwHMLGK9kFjPfyhD2Sy/ZWZf51dQuJLOdDurL/Xbmpuwy
         Djqy7tdNBEViHHt062V1FTkezRlXOrew8eFfaI74NgI6tCwsujODVAN4D828H3Vv79ae
         HH38E8+hflGhh6nVw8N9qX58SDxWpYE7tGJk2tevJnGLPZIqcj5czxyu799XygUjqn4S
         QayXGCR+1PJzTVjAwpDudYAg8QTKtQ4MPm9YKSdW0f4f3Rjgx1ODfYY9TLpPyB2O2YQg
         DwQPmWegehl4AGdx8pbmUv0yHJi6K90iXMNh5alAnIPbcCSz7Jjsroj4R/a3A9Dzo3oR
         IE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716972616; x=1717577416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0XUQiMDJ7IOckNnbNQGqUrJQwgDDw+TihOSXEGeG6I=;
        b=npuz6FZzISWCqmYN6x28QOzq8wbXIaESUTiP/fPX1GIcsCWuQrP1EW9B8u4SIh/Ttq
         HjNmeCE+wRrnMUJpRgV8IJM2bryGu19JUbiMZh9jBRsoIZrdvpHIdzh5eN3N/ZauZRQ2
         ieRZR3wncfoo8DVpw0Hwq0LGjs1N5XPpAPvLlxYCKKdzNO2ciMJNxnofmn/V7QqNGEif
         T1ZYARf0kw8ML+OW+LBnCGY0najk4Sm5L8c2iqReOGEBtMb+CKkGAEw7WR/RCnJSGVkH
         We+GrKWh26lNj+O7Aw57etpzF1PMRRY4YGwcFEUXDT6emo3Jo733k4sWMEnzydW6iC25
         d/7g==
X-Forwarded-Encrypted: i=1; AJvYcCUGPxfvUUMl+mLl/Okq5hE4OVkkAfl7jobjr5XOdXEy9ptISrcaYzsHxTF7uXelRrSkTA+U5gEAwhouhAlPXfPASIYpNWph
X-Gm-Message-State: AOJu0YyjdI5zPhnJYKkrz711d/nxLmTTunxYttZaCuMM8nMxQaWCfADa
	ky+OvqgOoOkt8KScsdHbz1J9OGe/gpxNp9dniT2YTaR1UdS96nvJODUbezDlV1dit9vcutyFgem
	NQWSElb1ugevgszpeblEcwO0+U6s=
X-Google-Smtp-Source: AGHT+IFI1RPK5glHZ/4EktnJKhtO4T9eVv/b1sv89762iFJZPiMwMDmwNBakhvZE9IA0kSAnVtSiVAs0Pi69qR5sLcA=
X-Received: by 2002:a17:907:9491:b0:a62:e3b2:6676 with SMTP id
 a640c23a62f3a-a62e3b267a8mr728862466b.73.1716972616181; Wed, 29 May 2024
 01:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528171320.1332292-1-yyd@google.com> <ZlbXeytf4RkAI40N@TONYMAC-ALIBABA.local>
In-Reply-To: <ZlbXeytf4RkAI40N@TONYMAC-ALIBABA.local>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 May 2024 16:49:39 +0800
Message-ID: <CAL+tcoDBdRyrzEtkkZ-9orffzts43-0EKajSpu3-dAVYgMECbg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] tcp: add sysctl_tcp_rto_min_us
To: Tony Lu <tonylu@linux.alibaba.com>
Cc: Kevin Yang <yyd@google.com>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 3:21=E2=80=AFPM Tony Lu <tonylu@linux.alibaba.com> =
wrote:
>
> On Tue, May 28, 2024 at 05:13:18PM +0000, Kevin Yang wrote:
> > Adding a sysctl knob to allow user to specify a default
> > rto_min at socket init time.
> >
> > After this patch series, the rto_min will has multiple sources:
> > route option has the highest precedence, followed by the
> > TCP_BPF_RTO_MIN socket option, followed by this new
> > tcp_rto_min_us sysctl.
>
> For series:
>
> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
>
> I strongly support those patches. For those who use cgroup v1 and want
> to take effect with simple settings, sysctl is a good way.

It's not a good reason to use sysctl.

If you say so, why not introduce many sysctls to replace setsockopt
operations. For example, introducing a new sysctl to disable delayed
ack to improve the speed of transmission in some cases just for ease
of use? No, it's not right, I believe.

>
> And reducing it is helpful for latency-sensitive applications such as
> Redis, net namespace level sysctl knob is enough.

Sure, these key parameters play a big role in the TCP stack.

>
> >
> > Kevin Yang (2):
> >   tcp: derive delack_max with tcp_rto_min helper
> >   tcp: add sysctl_tcp_rto_min_us
> >
> >  Documentation/networking/ip-sysctl.rst | 13 +++++++++++++
> >  include/net/netns/ipv4.h               |  1 +
> >  net/ipv4/sysctl_net_ipv4.c             |  8 ++++++++
> >  net/ipv4/tcp.c                         |  3 ++-
> >  net/ipv4/tcp_ipv4.c                    |  1 +
> >  net/ipv4/tcp_output.c                  | 11 ++---------
> >  6 files changed, 27 insertions(+), 10 deletions(-)
> >
> > --
> > 2.45.1.288.g0e0cd299f1-goog
> >
>

