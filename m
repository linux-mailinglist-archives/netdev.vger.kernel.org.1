Return-Path: <netdev+bounces-111328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2A2930872
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 06:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3A92B20CB0
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 04:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609A7D527;
	Sun, 14 Jul 2024 04:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9IXmtWu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3F4D51D;
	Sun, 14 Jul 2024 04:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720930152; cv=none; b=q0yMX0ncXciKK+Y4xxAZ3Vy9n71gmMwEC3J8cO+ed2d9OyoCkz3KcPnYBvXIoSejAzTMFEf1Fly8t4cP3q1AxUdwyK3tVbwh3Vf1VabUHxwPRpTib9QoQ2tQ+BuXSBNvGzDIze8bChHsYMKa0M3pR394voKLLoH7duyoJO/8Izk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720930152; c=relaxed/simple;
	bh=4RSIRByYvOzyuNRQjFNcr9BxvQQaQC7rVLUDeCW4J7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHAL4g0Ea2OcJ4PdRgN1aa8aFLvlfkDOGZZnOh5egqw+nVy4lQ7gPuBAhkmcpSyfL1JeAZ4Q1QX2T4HfoL3uRcm8UH8HKZ5twf0VLX4HHDlUZv9SPFBMxIhZ8rNhKwDk8f6rp5q/G61z2dOUJfW1ER4lxfGNqrhXuaZJh5xbhCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9IXmtWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA17C116B1;
	Sun, 14 Jul 2024 04:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720930151;
	bh=4RSIRByYvOzyuNRQjFNcr9BxvQQaQC7rVLUDeCW4J7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P9IXmtWuahNWN2DaXF2GyAYguohByViaJYiTTVBqSCgpAcSstIrHDBOpptA6YzHIz
	 BpKx32v2ABuPrEwL/uUxqNuPkBstHzATuQUVa2qFP2oMkt0aSj0WPluI1y3uAQEyCw
	 KolQ16wOjcOUFg5a+hUzB6cj7tMoAUuBAd8w9cpj/FAguZQ3nOVz5CeJfr/jke64L7
	 McGxXWZ8YzxxduOuqKJmte9VwBBmUksy1O6WNnf2f0C5F71rBvagBec0OvyYDl8p54
	 uW4vQvI5SjUNE9ojvQo8UN360awXQfDRJ0SPxZA/KB48K6quUMg5EbydHwYUoL8b8a
	 aRnfasPSlp5aA==
Date: Sat, 13 Jul 2024 21:09:10 -0700
From: Kees Cook <kees@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net/ipv4: Replace tcp_ca_get_name_by_key()'s strncpy()
 with strscpy()
Message-ID: <202407132108.1577A694@keescook>
References: <20240711171652.work.887-kees@kernel.org>
 <CANn89iKqZD68w1QtM3ztL_X290tj_EGyWRvFrhyAz-=T+GkogQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKqZD68w1QtM3ztL_X290tj_EGyWRvFrhyAz-=T+GkogQ@mail.gmail.com>

On Thu, Jul 11, 2024 at 10:38:01AM -0700, Eric Dumazet wrote:
> On Thu, Jul 11, 2024 at 10:16 AM Kees Cook <kees@kernel.org> wrote:
> >
> > Replace the deprecated[1] use of strncpy() in tcp_ca_get_name_by_key().
> > The only caller passes the results to nla_put_string(), so trailing
> > padding is not needed.
> >
> > Since passing "buffer" decays it to a pointer, the size can't be
> > trivially determined by the compiler. ca->name is the same length,
> > so strscpy() won't fail (when ca->name is NUL-terminated). Include the
> > length explicitly instead of using the 2-argument strscpy().
> >
> > Link: https://github.com/KSPP/linux/issues/90 [1]
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: David Ahern <dsahern@kernel.org>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: netdev@vger.kernel.org
> > ---
> >  net/ipv4/tcp_cong.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> > index 28ffcfbeef14..2a303a7cba59 100644
> > --- a/net/ipv4/tcp_cong.c
> > +++ b/net/ipv4/tcp_cong.c
> > @@ -203,9 +203,10 @@ char *tcp_ca_get_name_by_key(u32 key, char *buffer)
> >
> >         rcu_read_lock();
> >         ca = tcp_ca_find_key(key);
> > -       if (ca)
> > -               ret = strncpy(buffer, ca->name,
> > -                             TCP_CA_NAME_MAX);
> > +       if (ca) {
> > +               strscpy(buffer, ca->name, TCP_CA_NAME_MAX);
> > +               ret = buffer;
> > +       }
> >         rcu_read_unlock();
> >
> 
> Ok, but what about tcp_get_default_congestion_control() ?

Whoops. Yes. I'll do that at the same time. v2 coming...

-- 
Kees Cook

