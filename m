Return-Path: <netdev+bounces-212306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843B0B1F14F
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 01:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF30560DDD
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 23:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205ED28BA8C;
	Fri,  8 Aug 2025 23:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XoxYW8zd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6A42741DC
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 23:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754695720; cv=none; b=uJcJdk9VzcANpb5z0VtDhPCVaIgl0SwGPAM4HbZkGsDWAM1zpRmwXR3+RNLjLnjEiD3oEhrxyZ/ZuoKUxAIw75t/Xnam+ZaghOOss1ROHOi0IVuPQIBoc+UZoVDhK0o3oZOmPGP7Mn/h+3DiDhnwlVBqboojHblNJHT/GCHgMdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754695720; c=relaxed/simple;
	bh=vUytq915rflhnGC0E7wPq7cgARuQAeoXoFWbIqg4MQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SX6TOofganjbZU5iYVREKrBs7IbITdsLVm5C2380Ic7E4+zHkaHRYJjwico0rZhKX2KSKlZX8jBCivfMc+W/sJ2ntUO5CcjTSIwkzaNteGXECgRvrJKTOZrju9oohmr6KCw21PMoignwj2NXH/VEWy+X8QgxrGaunymezd5mzb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XoxYW8zd; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55cc866f01dso1383e87.1
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 16:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754695716; x=1755300516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+d20oXyWLn5bjTnK6D4tXgCVrsEi/H5G9og2EbOp+8=;
        b=XoxYW8zdJ78Lcd/v6eEuQqP+vMdxB3fbNJURQElC+RXy0bI6GimuXhr4bsnG1Txk9O
         Y0qfRcKQy6e6GF/4v2b794+pUIuyRooY1KIMvaibHx2VcjU+biMKmQn3o1qUErKXsZzC
         4sscGdMZAMMBgRAdW7R0VZ7HMq1nTnA6/xd+9f1cK7l5sGUTYIYgdLzkmcXAuk9VX/3K
         UxzVXph19Xr4Zn+u57BaVh14WVsqF87pbcFO45gYtrKjihWeeYW10RoZ8XBGOUQMdEX7
         0+otfZb96IJE1RkiNRxzEWFgC5jcAt1oDhx+iOjOB4SCqolv4uZRF/edwgu+wRuDYFpB
         +7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754695716; x=1755300516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+d20oXyWLn5bjTnK6D4tXgCVrsEi/H5G9og2EbOp+8=;
        b=YioLQzOcjP/djwQnwSkJxuFkIwwayYnird5cOCIPxtvkCypsUBbsN9ZFtfkcHNOOgg
         4sRKM08pNoScwh9iEjF3um9uKOjMd0vHxwVFtTkv0hzrxoDc07F+AW1CAU+UPii+xmbR
         fZmFv7U0hcAJIDZeZL2UXSbRoCxGpW/MyGIwnaODrapAS7TVxDsy080p32q9Jg+GrZ0W
         9bCeMYirfD6gnFqFS0IrY5vTUNI6JMmjL3u005015FZmykWc8F2xIrkQyT71dDqKBUt+
         5YqsHJYztczkhFMkSQ2+Pn3bBtJgNI1ViKIPoGD/sYg2eKsmY3sKw/xLXYrL5VtgAYyi
         FrZw==
X-Forwarded-Encrypted: i=1; AJvYcCVqzihKCMsOxyxgEW2ihWaIn3W0ZqF6UAkXSb12TW100WQEEZAuV0QAV7miWVRPeiYOILA4wEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnVqyMcw9/xDa/OaMn/m5UKZseIO3/+rdgXw9gCRIe+5qxzo4b
	lasLqa2TWTTNRjBsK3OGdihryVjvGkPKh6b028PjM5oVSiRwGVxF7vmtvfQHFhA+cEhSH6AwuvA
	eQeDS0LrQVWkU5nnp38zLmP5qx62hpflHr4DRBpSN
X-Gm-Gg: ASbGncu6H5qDIAxG9fm5GncUFvH4hoFPxGIU+7wIL/ZbYW67Qqr2ZwJtte+c6db4Wll
	IYD7xtd0hznFvRbWdjEzkhvXHpXzSyEf4yusJk7oURy5A6o+33YOCwnOxdGalIsgHzS5JMzSPIS
	sY6UcNCgoOnqzh6Qwt9aGIm/fDTTbM0mvGIDPnl4UrxHm8iEdv02n4QvifBbZt1M5zS1Q8Tyw4g
	GFsutAiB8dOb/eO6Z80/XexF/BxnYqcVR2oz6ZbQkBzMfxm
X-Google-Smtp-Source: AGHT+IEdv1w7QaR/0N5fORVsH+DJ9deVF62A3/i1e5So5KwiAuzIy0EDfzma97+kI6RU9BDDGv1QEy9xGRRRodJA/0Y=
X-Received: by 2002:a05:6512:1145:b0:55b:af38:41db with SMTP id
 2adb3069b0e04-55cc89c7bbcmr60515e87.7.1754695716156; Fri, 08 Aug 2025
 16:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2869548.1754658999@warthog.procyon.org.uk> <CAHS8izN89j9deyODUjxQroKrLoiAq1kF+RVowuvVecmg4tNAUg@mail.gmail.com>
 <2941083.1754684186@warthog.procyon.org.uk>
In-Reply-To: <2941083.1754684186@warthog.procyon.org.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 8 Aug 2025 16:28:23 -0700
X-Gm-Features: Ac12FXyPh-Jfeqe4_Ia59zNE4ggMPY6p0Hb0AzjzpPYfgU0oYp45vqpTmqQE3_w
Message-ID: <CAHS8izOj3OCD6+6GD9foc53J7u9o6-VK+YS-1RUWU4NR6d-9bQ@mail.gmail.com>
Subject: Re: Network filesystems and netmem
To: David Howells <dhowells@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, willy@infradead.org, 
	hch@infradead.org, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Byungchul Park <byungchul@sk.com>, netfs@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 1:16=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
>
> Mina Almasry <almasrymina@google.com> wrote:
>
> > >  (1) The socket.  We might want to group allocations relating to the =
same
> > >      socket or destined to route through the same NIC together.
> > >
> > >  (2) The destination address.  Again, we might need to group by NIC. =
 For TCP
> > >      sockets, this likely doesn't matter as a connected TCP socket al=
ready
> > >      knows this, but for a UDP socket, you can set that in sendmsg() =
(and
> > >      indeed AF_RXRPC does just that).
> > >
> >
> > the page_pool model groups memory by NIC (struct netdev), not socket
> > or destination address. It may be feasible to extend it to be
> > per-socket, but I don't immediately understand what that entails
> > exactly. The page_pool uses the netdev for dma-mapping, i'm not sure
> > what it would use the socket or destination address for (unless it's
> > to grab the netdev :P).
>
> Yeah - but the network filesystem doesn't necessarily know anything about=
 what
> NIC would be used... but a connected TCP socket surely does.  Likewise, a=
 UDP
> socket has to perform an address lookup to find the destination/route and=
 thus
> the NIC.
>
> So, basically all three, the socket, the address and the flag would be hi=
nts,
> possibly unused for now.
>
> > Today the page_pool doesn't really care how long you hold onto the mem
> > allocated from it.
>
> It's not so much whether the page pool cares how long we hold on to the m=
em,
> but for a fragment allocator we want to group things together of similar
> lifetime as we don't get to reuse the page until all the things in it hav=
e
> been released.
>
> And if we're doing bulk DMA/IOMMU mapping, we also potentially have a sec=
ond
> constraint: an IOMMU TLB entry may be keyed for a particular device.
>
> > Honestly the subject of whether to extend the page_pool or implement a
> > new allocator kinda comes up every once in a while.
>
> Do we actually use the netmem page pools only for receiving?  If that's t=
he
> case, then do I need to be managing this myself?  Providing my own fragme=
nt
> allocator that handles bulk DMA mapping, that is.  I'd prefer to use an
> existing one if I can.
>

Yes we only use page_pools for receiving at the moment. Some
discussion around using the page_pool for normal TX networking
happened in the past, but I can't find the thread.

I'm unsure what it would take to make it some-tx-path compatible off
the top of my head. At the very least, the page_pool at the moment has
some dependency/logic on napi-id that it may get from the driver, that
may need to be factored out. See all the places we touch pool->p.napi
in page_pool.c and other files. Or, like you said, you may want your
own fragment allocator, if wrestling the page_pool to do what you want
is too cumbersome.

--=20
Thanks,
Mina

