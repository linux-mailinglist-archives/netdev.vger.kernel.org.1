Return-Path: <netdev+bounces-99847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F768D6B81
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 23:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F2E1C2553A
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 21:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFA278C75;
	Fri, 31 May 2024 21:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gfg33T7M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493501CAA6
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717190769; cv=none; b=FDtQqoomuicGCZDCRJAeJfEfMM7qBBQMtW+NPlqfTo37wM9LDtrbaOXGBzJ9X5tDB9YzLhx6nPQDG8RuGK/XYS6cOejA1TeM2E/aWikj8nUtRZKfwFCbHx4xRMEpN79YMusw2fJJ4KCie5iYR4AatE0APOVt7erZqLT4dNcQ3iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717190769; c=relaxed/simple;
	bh=1ikvOiKNhK1M4JYjHVGiSxvirW1dNDuWwjzDg5/Lbc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FU4IWXvOdg9OqS09dwGr0ZEtdnacHXjkcxCV9QCD2iDzzkUItUWxsZV2Zm5i28jGJwP8gPygdTpZ0luF3Mtp59w981YYzBB8zpAJZKxTBFeccvrgoT0oXg4Q/TvMlmn15TRGpddvsFtGJm5iU9qtLnm9RUxR/gQgiCin8dL8JEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gfg33T7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE11C116B1;
	Fri, 31 May 2024 21:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717190768;
	bh=1ikvOiKNhK1M4JYjHVGiSxvirW1dNDuWwjzDg5/Lbc8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gfg33T7MST25NXJLGmc9VZwxVfFQIC6htnNSgj1oGqX8kyJnbjlYP1vGuLTulI5tG
	 HiFSLA+CB9GYVNBtAYTUlBLZcS2cnxRI4F/SblUZZdq1bPhhD6B+ZATrr+xSD77Y0d
	 T35FMnDZ16cF3KxKK65qJmAws3IsqlN6E8mSNQGOnQqAn891Uksno3QRMoD6i0qong
	 c/nC+9FHjsKfz0iSa55co55qMvxAhB5mRIrVFFeCMDTwVHsOuUnZCXqYk8BfYl3PxO
	 U+IXqouiHcpmaN3yRrIIK+MRCU5RziToeAWgyu0EDGTtDokWJmLlhWpVYsKfeK4BPC
	 SGlCRx/6BFioA==
Date: Fri, 31 May 2024 14:26:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: netdev@vger.kernel.org, Igor Raits <igor@gooddata.com>, Daniel Secik
 <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>
Subject: Re: [regresion] Dell's OMSA Systems Management Data Engine stuck
 after update from 6.8.y to 6.9.y (with bisecting)
Message-ID: <20240531142607.5123c3f0@kernel.org>
In-Reply-To: <CAK8fFZ6nEFcfr8VpBJTo_cRwk6UX0Kr97xuq6NhxyvfYFZ1Awg@mail.gmail.com>
References: <CAK8fFZ7MKoFSEzMBDAOjoUt+vTZRRQgLDNXEOfdCCXSoXXKE0g@mail.gmail.com>
	<20240530173324.378acb1f@kernel.org>
	<CAK8fFZ6nEFcfr8VpBJTo_cRwk6UX0Kr97xuq6NhxyvfYFZ1Awg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 08:48:31 +0200 Jaroslav Pulchart wrote:
> > Could you try this?
> >
> > diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> > index 96accde527da..5fd06473ddd9 100644
> > --- a/net/ipv4/devinet.c
> > +++ b/net/ipv4/devinet.c
> > @@ -1912,6 +1912,8 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
> >                         goto done;
> >         }
> >  done:
> > +       if (err == -EMSGSIZE && likely(skb->len))
> > +               err = skb->len;
> >         if (fillargs.netnsid >= 0)
> >                 put_net(tgt_net);
> >         rcu_read_unlock();  
> 
> I tried it and it did not help, the issue is still there.

Hm. Could you strace it ? I wonder if I misread something it doing
multiple dumps and now its hanging on a different one..

