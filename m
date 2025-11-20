Return-Path: <netdev+bounces-240344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA027C73950
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 11:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7AFA4E7266
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 10:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2647030DD19;
	Thu, 20 Nov 2025 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4Lks7VL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D642E7BA2
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636208; cv=none; b=kZpvueP6Y6MRpMMmI5/CdSBLjUbDpcsu/D0K7pfRW7pTBE4sN7nR4ZwxYKNvWbHG5ZPE25zN8SxB3k025XIwAZyCC+jHLQOhzg81XtvD6yh7kl8rfFoLyBxcb6PYfFUllkp9Rn0FWth0dX7eLo19xC7pxoRzdkFFTRj8dRpWh4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636208; c=relaxed/simple;
	bh=RLKCYMJbWg3wVaXkn6Ql8g5NF9XDZ0jFGbj0sgjqjQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDHfmD3TuLyutU+LfLN+EQSTgLLTrBdWBAai6U5ayMCYASWcFRflVEcr6YgOcb+9n670jqUH3Y+572fVZRzo7Z7ypfb/hspuKlvhTeEhFqHCm0Ra9ODJldUmIpERZjT3lHlIg6aN/TF3zjNHAxEudCzJFaDmOyzDT8NC8YGlQIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4Lks7VL; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-434709e7cc9so3839075ab.1
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 02:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763636205; x=1764241005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8odtBE8sLdskhW90dhEfIJ46nBmMlbNnS8SSIbrjUU=;
        b=H4Lks7VLTiSnnBQbPv/Cy4Ypoot2yZQ6K5Hz2hxuctpSH+g88wXP7bw+eQ4Sl9ks+S
         18bl4sAaYaY2VZL3UZfSo8hSvlgWIIwvth7W/jvHdBbYDLMErg/ylxYkT5zp0r/kNmuG
         EPL8cOm8JzNr5l6XLONpDB4SlsTJAVD0VBZLhtjaYleGWr+acRqA2jvdz5JwBo5H7m2l
         ao6EQO+vaX3aPCS0dGq/44CuZVXW3UC9grGwILLwvZeJzsisrzWsdxdaDWvcLf6DR2YB
         pXXcjH0P+n+s6OAvhhMebrUmv26QHIt3AjK7t3RfxYkAwfvYp3WmdFWEBj6wENTeToB2
         /jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763636205; x=1764241005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U8odtBE8sLdskhW90dhEfIJ46nBmMlbNnS8SSIbrjUU=;
        b=ETSblvAvSVg1FZnmX7+b7aQmvHmzppLchyhLvHUotwtMDH34hLdPEph7CpgCBHwNIS
         eM65gfwFvVH+HNG/jL5KYjQoDXA4dQXFmw6+vQFhoHUGHVC7agbQLn2hI3kWxapsCdWr
         5Lc77iWvqQ8gXZxva8TyRgS2wjgavG5VwxgcP35HCCuXqmbTj4XoZdgmzlU/EebrdxzI
         /l0LPt5dzu8Xd3EiznEYjlZWCnBaf9MptMCLiwX9drT5neaNbh31pSOPzEacvdWTnfoo
         wT8q9DOZivQVxvew7q1Pyw/gB43GMgw2htsPmvabajMlKajjbrITsfuuDU9F3xzSP3b0
         nSZQ==
X-Gm-Message-State: AOJu0YzYmErf6/UaJVEwgmg4wTDj8lOkwW6qzV/y77BFBlCiPiPVccMX
	8qQ25fz9cwnlVx0urNR7ddhPYNqVrFDx0Ed6Xy/Z+bmsJY+CcD/lqj2/9Oswnf6XbEXlgIXa3Z1
	GTgIfzAeV5YSk4cWDKnvuqazYlSi+3I4=
X-Gm-Gg: ASbGncvG/eOtaT8UyivBm2KNIRNnEOgud+xZWABn5HT6VBdV/vjTNMj88v7gKoZT4v2
	zioQrt9YJM2RmNql1yckbpXe0Irdj4Hw5PUhOLM65vGsE9TQUB0/+WxP9t0OdswYc5g/ODOgwq8
	VcZHJbYsSHm1pnyCWBKTGcrghL91uvGncTlLvYZIiABtgxi26IJuXxfhdKq4re9NmTP9xWJCLyJ
	1FSFbZlSKS8pA6k2DptwyBOjyi3D/zrF+ABx7jIa/CyEG/q6uMFVzBZ+8p8phyvUQ8tbvbGk+Z2
	0TTtKeZ4TA==
X-Google-Smtp-Source: AGHT+IFC3af3YGcUtMR/2f7wapKqrCIPzgJpAoVyr2np7EEI0rnydUEP++AYKyhGpO6OtTUwvh6l4b7SBgVBlRNpRU4=
X-Received: by 2002:a05:6e02:16c7:b0:433:7b4f:f8c3 with SMTP id
 e9e14a558f8ab-435b1fdfd26mr7710405ab.17.1763636205548; Thu, 20 Nov 2025
 02:56:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118124807.3229-1-fmancera@suse.de> <CAL+tcoCthXqJS=z3-HhMSn3nfGzrqt8co3jKru-=YX0iJ2Yd6w@mail.gmail.com>
 <c7fb0c73-12e9-4a6d-94d9-65f7fc9514ce@suse.de>
In-Reply-To: <c7fb0c73-12e9-4a6d-94d9-65f7fc9514ce@suse.de>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 20 Nov 2025 18:56:09 +0800
X-Gm-Features: AWmQ_bmwdP2Ky1CmR0H_rapr3ryMgjeUXCwnY8pfBLuLZAXGnWN_6Wy6iRoqC-U
Message-ID: <CAL+tcoC3ZkhV5d7rStShghVFdmGDx9pb13S4ZUqSo9KmrJesLg@mail.gmail.com>
Subject: Re: [PATCH net v4] xsk: avoid data corruption on cq descriptor number
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, csmate@nop.hu, maciej.fijalkowski@intel.com, 
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 5:06=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
>
>
> On 11/20/25 4:07 AM, Jason Xing wrote:
> > On Tue, Nov 18, 2025 at 8:48=E2=80=AFPM Fernando Fernandez Mancera
> > <fmancera@suse.de> wrote:
> [...]>> @@ -828,11 +840,20 @@ static struct sk_buff
> *xsk_build_skb(struct xdp_sock *xs,
> >>                                  goto free_err;
> >>                          }
> >>
> >> -                       xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_=
cache, GFP_KERNEL);
> >> -                       if (!xsk_addr) {
> >> -                               __free_page(page);
> >> -                               err =3D -ENOMEM;
> >> -                               goto free_err;
> >> +                       if (xsk_skb_destructor_is_addr(skb)) {
> >> +                               xsk_addr =3D kmem_cache_zalloc(xsk_tx_=
generic_cache,
> >> +                                                            GFP_KERNE=
L);
> >> +                               if (!xsk_addr) {
> >> +                                       __free_page(page);
> >> +                                       err =3D -ENOMEM;
> >> +                                       goto free_err;
> >> +                               }
> >> +
> >> +                               xsk_addr->num_descs =3D 1;
> >> +                               xsk_addr->addrs[0] =3D xsk_skb_destruc=
tor_get_addr(skb);
> >> +                               skb_shinfo(skb)->destructor_arg =3D (v=
oid *)xsk_addr;
> >> +                       } else {
> >> +                               xsk_addr =3D (struct xsk_addrs *)skb_s=
hinfo(skb)->destructor_arg;
> >>                          }
> >>
> >>                          vaddr =3D kmap_local_page(page);
> >> @@ -842,13 +863,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_=
sock *xs,
> >>                          skb_add_rx_frag(skb, nr_frags, page, 0, len, =
PAGE_SIZE);
> >>                          refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc=
);
> >>
> >> -                       xsk_addr->addr =3D desc->addr;
> >> -                       list_add_tail(&xsk_addr->addr_node, &XSKCB(skb=
)->addrs_list);
> >> +                       xsk_addr->addrs[xsk_addr->num_descs] =3D desc-=
>addr;
> >> +                       xsk_addr->num_descs++;
> >
> > Wait, it's too late to increment it... Please find below.
> >
> >>                  }
> >>          }
> >>
> >> -       xsk_inc_num_desc(skb);
> >> -
>
>
>
> >>          return skb;
> >>
> >>   free_err:
> >> @@ -857,7 +876,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_so=
ck *xs,
> >>
> >>          if (err =3D=3D -EOVERFLOW) {
> >>                  /* Drop the packet */
> >> -               xsk_inc_num_desc(xs->skb);
> >
> > Why did you remove this line? The error can occur in the above hidden
> > snippet[1] without IFF_TX_SKB_NO_LINEAR setting and then we will fail
> > to increment it by one.
> >
> >
> That is a good catch. Let me fix this logic.. I missed that the
> -EOVERFLOW is returned in different moments for xsk_build_skb_zerocopy()
> and xsk_build_skb(). Keeping the increment logic as it was it is better.

Right. Thanks!

My new solution based on net-next with your patch is ready now :)

Thanks,
Jason

