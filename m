Return-Path: <netdev+bounces-106784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 907819179F4
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1397CB25262
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 07:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C61F15FA7E;
	Wed, 26 Jun 2024 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mYB6LQre"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC7915F404
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387660; cv=none; b=TNt+8Wzeszh737DOkgB1JJ48VwN7/aSSnfz5THzdZXdVbtLXyak7J+laNszexgVdv7iGJwhlkIIE/e0rZpsc53flECoqJ7utBWSVZGLUjT63rTz1++xFGcYt1XYSdb9xO4xNHaPJpW4Fy/Ju1KaIkUeVV2Mst9Z69uB5ch4NJbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387660; c=relaxed/simple;
	bh=76pkgtRnyA6wgmLyWb+74L/fC7+jVztEQbOSI58lgpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRbgZb9Gbs/Nl313rl1Tf2jChbkHnBPanvw/6yCP+WGNH19JO8U+7PtFCseKR98JybUE6O1XmqoDz9fXqhK1yTCzlVf5yMCs7/oQyJnVMaGuDqSRsnqgmcdod8zpMmqGEYYh1On8EdGF9UDIzaZ1E3DGieKmm71GNKY260sDI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mYB6LQre; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57d16251a07so6741a12.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719387657; x=1719992457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jitGGi9wZVh1LaryMzXQYCvcFCuE5N8b7HFECxEWFtY=;
        b=mYB6LQrefbJVs3StRq3Uer8xz1VcHkQsr6bacNmCR0WWGlx2oOA6amtgfW0nq+vx1c
         7XstJPMkfG4Gvt5RRpXcfhVHgyM/V2/oxzwrMrk+fjpGfV7gIum5JB0zDgpGEdIHd4SV
         tYO6wxSH6b/+NMoCMacLDl3BAtiK0ID9mNfXJEbe9MEu7q9HmvCr9kYph8coDoutxtlk
         M3lLb+3948eTcZDX4Zx8J974L3YQeBeyR2tv3Qe1IjWYpb65FuBSLTbw2khMg8F/lW1x
         I14mNsDWNuWVhtKN7qd+TmAkmJSrBQi5nsKrGNWhH+50Fcv4bFrdWtv7t/VX7s6L2Vsd
         2E6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719387657; x=1719992457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jitGGi9wZVh1LaryMzXQYCvcFCuE5N8b7HFECxEWFtY=;
        b=RhR4f9KuaDAxV3W767yOxuCaRObfIrUtPQkNCH50kic0l+1YF1K+4VYCDYldIRRdHK
         e0W50dwX+RELQZOQb0RZB3/MhXC1Vb597e0R9FdnYnX3QNT4cK6K5bLLiZgFVlicnyFf
         I9rP+4nkuUuUl1VHPMM+ty7/yPaaglSfRaIkQS/RuyAZeDa2GjqgE65OLxkpCaD0JFfP
         LyObRGmrGsqeJmozo7OH+4RYiuCiy7rIwGKqNs2f/qw5q+XzwmFP/TjXmEXfsuHjHORe
         5uUdcLtUNZ4siFDiii1tWU6d3Uqk8sA1ZdZAZyWa6qNEr5L6BoqkSCcRFKO6A5O0Ycz8
         RWeA==
X-Gm-Message-State: AOJu0YxbUAexCXSJcHVpv1YfUmT7fKNT6tbH7kSoLU+clXhlLmuVNMjS
	+A6y2HgmcYGyUseTQnc3aoiVSqPkV6NOtxWcAo7ZIfu18lN3OEyoIBzoKzxIF9NPaPzxWQnc31A
	3W+jVRe2AgZuyjEiIQ2mqqa9eZYn47WTRstUU
X-Google-Smtp-Source: AGHT+IG8wfc6PvcZA+gcyGlDo27QZM5zyV/Mtx5m7lv99EWWtgVV10j66/rUgBaZTuTJDAvthQl2ko2Cb19BR5DsJ9c=
X-Received: by 2002:a05:6402:5203:b0:57c:c3a7:dab6 with SMTP id
 4fb4d7f45d1cf-58358a7d9ffmr115102a12.3.1719387656650; Wed, 26 Jun 2024
 00:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626070037.758538-1-sagi@grimberg.me>
In-Reply-To: <20240626070037.758538-1-sagi@grimberg.me>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Jun 2024 09:40:43 +0200
Message-ID: <CANn89iLA-0Vo=9b4SSJP=9BhnLOTKz2khdq6TG+tJpey8DpKCg@mail.gmail.com>
Subject: Re: [PATCH net v3] net: allow skb_datagram_iter to be called from any context
To: Sagi Grimberg <sagi@grimberg.me>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	David Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 9:00=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
> We only use the mapping in a single context, so kmap_local is sufficient
> and cheaper. Make sure to use skb_frag_foreach_page as skb frags may
> contain highmem compound pages and we need to map page by page.
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202406161539.b5ff7b20-oliver.sang@=
intel.com
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Thanks for working on this !

A patch targeting net tree would need a Fixes: tag, so that stable
teams do not have
to do archeological digging to find which trees need this fix.

If the bug is too old, then maybe this patch should use kmap() instead
of  kmap_local_page() ?

Then in net-next, (after this fix is merged), perform the conversion
to kmap_local_page()

Fact that the bug never showed up is a bit strange, are 32bit systems
still used today ? (apart from bots)...

Do we have a reproducer to test this?

> ---
> Changes from v2:
> - added a target tree in subject prefix
> - added reported credits and closes annotation
>
> Changes from v1:
> - Fix usercopy BUG() due to copy from highmem pages across page boundary
>   by using skb_frag_foreach_page
>
>  net/core/datagram.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index e614cfd8e14a..e9ba4c7b449d 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -416,15 +416,22 @@ static int __skb_datagram_iter(const struct sk_buff=
 *skb, int offset,
>
>                 end =3D start + skb_frag_size(frag);
>                 if ((copy =3D end - offset) > 0) {
> -                       struct page *page =3D skb_frag_page(frag);
> -                       u8 *vaddr =3D kmap(page);
> +                       u32 p_off, p_len, copied;
> +                       struct page *p;
> +                       u8 *vaddr;
>
>                         if (copy > len)
>                                 copy =3D len;
> -                       n =3D INDIRECT_CALL_1(cb, simple_copy_to_iter,
> -                                       vaddr + skb_frag_off(frag) + offs=
et - start,
> -                                       copy, data, to);
> -                       kunmap(page);
> +
> +                       skb_frag_foreach_page(frag,
> +                                             skb_frag_off(frag) + offset=
 - start,
> +                                             copy, p, p_off, p_len, copi=
ed) {
> +                               vaddr =3D kmap_local_page(p);
> +                               n =3D INDIRECT_CALL_1(cb, simple_copy_to_=
iter,
> +                                       vaddr + p_off, p_len, data, to);
> +                               kunmap_local(vaddr);
> +                       }
> +
>                         offset +=3D n;
>                         if (n !=3D copy)
>                                 goto short_copy;
> --
> 2.43.0
>

