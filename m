Return-Path: <netdev+bounces-125928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF9D96F490
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1421C215E3
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADC7197A67;
	Fri,  6 Sep 2024 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6eW7PVo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E37D1AB6F4
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626852; cv=none; b=WlXSTIFV59jT+QSa44hs+h0ejsUGP6OBR9VPvKgLKPU+KrwjczlbuOQAOiltPHmJXrnBgnhAZFTLULBROW06sPzcV1BQbj3kgqQGivxQaNmjbH5EHbHNocA8D/OVkwP/dTGUaYO5BBIEw6oLJBPvfBjwQtsZWmaCIrr0319kDnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626852; c=relaxed/simple;
	bh=nkVX8x5PTDfynA2qFeKebBwbI/vgSjg3+jZ2RTvSU5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0pvXwATPKb1C90GQ5bHB01uGlrzJEycwA5zznKiktbVBgDy8KAFN5y4yaAT9Ek2xqnYmjZzHZ1j3r/pEIedxmVpHR10TlJI7YfrBNFDlgCk/XavQkyfXPqHUgbMfbfXIz0G/s1E0WYrnyOfkfLZnuUjSenAEvMvpuFlia3UZNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a6eW7PVo; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53659867cbdso905598e87.3
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 05:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725626849; x=1726231649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR4pd9F/THco+SSFccpfdKHI0uD3Tvf9dpZhnwAEH+o=;
        b=a6eW7PVorvORruKZvbJ6ysUdjdYslQmjyzGmzBrQMxPRgnElPuFgcbIstArOvwVoyX
         6tF7Ei1ym2lSj/UoAH84zfTWS+eIcxe8IVVHrfx8cOTmqvElTawpfVIjBWEcji0ljHlO
         aLqGfQyBEG9iZcTWZUcPsiR7m5zKNduqIAYw9FuW/k5qf8IlBdbrGL/OBEkmTYLWKbIM
         9/G07Kz/fb3CLqwEeVuYiX4pD16vRhVRK/CsIuIzD8HpnWkuDc/sClNQLQhtQRw7TBqS
         ZdDDA6/vsK8kULalQz+G2IQCzrcXgsHdGlO95CbixcDkE6OMMIFrud9DH/VWnu8oRs2N
         KASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725626849; x=1726231649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PR4pd9F/THco+SSFccpfdKHI0uD3Tvf9dpZhnwAEH+o=;
        b=wWc/ui3L8hQ9COE/CxJN+GUhR4W4DHZMDK0E02J539WWsRa3alnWXfww1ju7XoNhHW
         0+E3iY1Q8eEDLVInCDPZz7R1AuWS6kkndTxc4IvEpaHpD0oMvy/iEoul/WU/JJ53cmCe
         Rt99Dxn15De58TW7xP45vlCH+c8Tmv7XYXnHbIQbxNor915GpsGaFUzDlyojA9ladzM4
         Aj3BYhiyj6WV41It7mTUPXJ/no3REb1Dla/+sjiIOWQ0LAo3KIAvBLfPRNpedHZ1Gpmn
         5FshU5vu0ezeZ1Ix97tVex+x2rEMrC9ALnttMIdgYYmU4KaLH8VGVw1BXlo3Zcda9npc
         PhCA==
X-Forwarded-Encrypted: i=1; AJvYcCXXeHuBzGCPmrudP5gFtM6N6UHMwcH2HolAN1lu783Zcf5nhWGHkMbIyCEpl88Jl1QPGYNdbhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTCdPPiE5+O3qXraut/D8ZHdUEjrPjbK62Mp54oW8RHlZWy/5a
	OnUCLBpTfxlszwthENFbiiER3qs2ClTjhUjyxIWZNOUjJwSnudmCEdTT3urJEMBhcqOm+w1Q3DQ
	22lEo3GG/ofsFqRpZF63P1SQpY4ppIDDfoMHK
X-Google-Smtp-Source: AGHT+IEe7dipQ5wyoY8KEUiQgwuNhZDJ1wkzxhdfCXfkWXl4wenzdCvTiDXbQt0zl73UVMTIQ6hsrmnRYklBs6JEOHA=
X-Received: by 2002:a05:6512:b97:b0:535:ea75:e915 with SMTP id
 2adb3069b0e04-53658816f23mr1951314e87.56.1725626847630; Fri, 06 Sep 2024
 05:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <04b7b9d0b480158eb3ab4366ec80aa2ab7e41fcb.1725031794.git.gnault@redhat.com>
 <20240903113402.41d19129@kernel.org> <ZthSuJWkCn+7na9k@debian>
 <20240904075732.697226a0@kernel.org> <Ztie4AoXc9PhLi5w@debian>
 <20240904144839.174fdd97@kernel.org> <ZtrcmacoHyQkqZ0h@debian>
In-Reply-To: <ZtrcmacoHyQkqZ0h@debian>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 6 Sep 2024 14:47:15 +0200
Message-ID: <CANn89iJ-K82U8mSNW_NGQtzKr70weHrWiFqnBEj-ehhWRHveFg@mail.gmail.com>
Subject: Re: [PATCH net] bareudp: Fix device stats updates.
To: Guillaume Nault <gnault@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Martin Varghese <martin.varghese@nokia.com>, Willem de Bruijn <willemb@google.com>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 12:42=E2=80=AFPM Guillaume Nault <gnault@redhat.com>=
 wrote:
>
> On Wed, Sep 04, 2024 at 02:48:39PM -0700, Jakub Kicinski wrote:
> > On Wed, 4 Sep 2024 19:54:40 +0200 Guillaume Nault wrote:
> > > In this context, I feel that dstats is now just a mix of tstats and
> > > core_stats.
> >
> > I don't know the full background but:
> >
> >  *    @core_stats:    core networking counters,
> >  *                    do not use this in drivers
>
> Hum, I didn't realise that :/.
>
> I'd really like to understand why drivers shouldn't use core_stats.
>
> I mean, what makes driver and core networking counters so different
> that they need to be handled in two different ways (but finally merged
> together when exporting stats to user space)?
>
> Does that prevent any contention on the counters or optimise cache line
> access? I can't see how, so I'm probably missing something important
> here.

Some archeology might help.

Before we had tracing, having separate fields could help for diagnostics.

commit caf586e5f23cebb2a68cbaf288d59dbbf2d74052
Author: Eric Dumazet <eric.dumazet@gmail.com>
Date:   Thu Sep 30 21:06:55 2010 +0000

    net: add a core netdev->rx_dropped counter

    In various situations, a device provides a packet to our stack and we
    drop it before it enters protocol stack :
    - softnet backlog full (accounted in /proc/net/softnet_stat)
    - bad vlan tag (not accounted)
    - unknown/unregistered protocol (not accounted)

    We can handle a per-device counter of such dropped frames at core level=
,
    and automatically adds it to the device provided stats (rx_dropped), so
    that standard tools can be used (ifconfig, ip link, cat /proc/net/dev)

    This is a generalization of commit 8990f468a (net: rx_dropped
    accounting), thus reverting it.

    Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

