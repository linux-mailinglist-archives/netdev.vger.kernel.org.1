Return-Path: <netdev+bounces-93078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75768B9F54
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 19:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD961F2172C
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 17:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F6516FF29;
	Thu,  2 May 2024 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zMNpnUs0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644D416F919
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670124; cv=none; b=cdKIjSJj7E2AJZ8H9u2FQmV3zq5voiVw+s7yuTdQ8JTE42bBcWL9YNZDcmRQBUdsDWimih8eT7cvON5nOgkEUZkemxjatYO7JyZW1yCtxLK0nm4u0GnxxoOtTVTQy2zQ22djgGQ/SkXyaCNHI8J8hyHNVDxRhxsb8XMwVDMURyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670124; c=relaxed/simple;
	bh=VwkzLKKEfFPiSOWKSdU8+k/p4KaD7RNHUYpz4HTjwtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qu5IDCIBoJ29vrMX2dYVDH4N+NOQShij2ywJ4TUwMvnh+Iam7/tDv9/vCALgLt1aPFethuyZ4Vvw3x0gT9LDW2ZAX61L8qA2RiATwMfFDF32cW3n9u5PCITaWEr4pqvFtxTSCPg41239R/nyEaeK2S/1j0o4AnYy9IOOMWkN7l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zMNpnUs0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a587831809eso1020475766b.1
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 10:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714670121; x=1715274921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4f0BwrwMen83Jw4wdTEM4lK19L7K/EkBDT7vt6YVnE=;
        b=zMNpnUs03rbrahYs9iaAzPEk3qVNQ/68e4/y88ZArUvHy6YVrezwbSKeA8H77W7V+a
         7hX3yWjROKY4czTMgaasZgdu3n4J+dFxAAl8mCugaYQSFl0gn9vWIu+N09Yn2MTrctl+
         aVRoLMGmOXIcnOdFb6WkjlwV/znW2UdcBQqG7haWztYY0kWHGtF9MZk8Tb8j/XXEvGv/
         TGbHh3HTVUCwFHBFSkX4A76EdyXplBjI+ZlLqdErFSmzxaI6ao66cXgB6veWCmD/lzpa
         AsTjJ5k1TKZgC0j3ijoPZxNWKoT6CFda5tzSd/aQDQXEEopJhE3+2LSeYNmiIhzQZmZK
         G/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714670121; x=1715274921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4f0BwrwMen83Jw4wdTEM4lK19L7K/EkBDT7vt6YVnE=;
        b=j6cNIPw4nBK0QVLUlwPLVw/SLAeS7I/vim4iW5oU4DL+nCdWUnzMoAyWpDo1gIVzVX
         EwBbOS/qYc9N0y6Xvk9nBahUe/KS812auhOVKBCEZmM//rhGwV12KO0Atktob2QVDjan
         wBmzQT5gRNm0PCPU6GNsaR6xf6w1DY/SQZztttgJO9wZBl8phr5fZ+B7kcbogV0ua+Qe
         C/Sg3e2i4PL06zFjwxZk3Lv1q/UDFI349uoJuq2pFkMo3ue1qmDm0O/pXp/9xi/9hZUa
         Nsbz0MG43h6QXC5OX9wxcZT1BTe+h7O8QGpNCaQ6yngjdDKFQZj5tQBMzt1T77Wsl5js
         zgCQ==
X-Gm-Message-State: AOJu0YwVBxPOkjxkuq1R/9L42P6xBVF+B1Jv+vqos40Ffq6qmZ6bCEpe
	VTmevabNdOpPMdDFvrCey+O1LJp0RS/aBoMpxeuCLSpW+7vq2aXHbn44Cm4Mx94yNexngwgXklD
	b7UTl6UVZUYm5eE11rag8YG4BL7zeOsGVtUlq
X-Google-Smtp-Source: AGHT+IHJdjIBD522Vb6EDyzjFZgQKvjIk+zkHbfcG52fc/ly+JBMPDYrhkUTNq7kirBWY5wh8feJePZk/6uzlCYOD3o=
X-Received: by 2002:a17:906:d146:b0:a58:f186:192 with SMTP id
 br6-20020a170906d14600b00a58f1860192mr140807ejb.0.1714670120309; Thu, 02 May
 2024 10:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430010732.666512-1-dw@davidwei.uk> <20240430010732.666512-2-dw@davidwei.uk>
 <CAHS8izOsZ+nWBRNGgWvT46GsX6BC+bWPkpQgRCb8WY-Bi26SZA@mail.gmail.com> <15333409-0cad-4580-b093-aeae58664034@davidwei.uk>
In-Reply-To: <15333409-0cad-4580-b093-aeae58664034@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 2 May 2024 10:15:08 -0700
Message-ID: <CAHS8izNuVoe67zdR3_=m+E8X0nLCGYnAJH0dvQZ8QBTNPHESpQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v1 1/3] queue_api: define queue api
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, Shailend Chand <shailend@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 7:44=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-04-30 11:00 am, Mina Almasry wrote:
> >
> > Sorry, I think we raced a bit, we updated our interface definition
> > based on your/Jakub's feedback to expose the size of the struct for
> > core to allocate, so it looks like this for us now:
> >
> > +struct netdev_queue_mgmt_ops {
> > +       size_t                  ndo_queue_mem_size;
> > +       int                     (*ndo_queue_mem_alloc)(struct net_devic=
e *dev,
> > +                                                      void *per_queue_=
mem,
> > +                                                      int idx);
> > +       void                    (*ndo_queue_mem_free)(struct net_device=
 *dev,
> > +                                                     void *per_queue_m=
em);
> > +       int                     (*ndo_queue_start)(struct net_device *d=
ev,
> > +                                                  void *per_queue_mem,
> > +                                                  int idx);
> > +       int                     (*ndo_queue_stop)(struct net_device *de=
v,
> > +                                                 void *per_queue_mem,
> > +                                                 int idx);
> > +};
> > +
> >
> > The idea is that ndo_queue_mem_size is the size of the memory
> > per_queue_mem points to.
> >
> > The rest of the functions are slightly modified to allow core to
> > allocate the memory and pass in the pointer for the driver to fill
> > in/us. I think Shailend is close to posting the patches, let us know
> > if you see any issues.
> >
>
> Hmm. Thinking about this a bit more, are you having netdev core manage
> all of the queues, i.e. alloc/free during open()/stop()?

No, we do not modify open()/stop(). I think in the future that is the
plan. However when it comes to the future direction of queue
management I think that's more Jakub's purview so I'm leaving it up to
him. For devmem TCP I'm just implementing what we need, and I'm
trusting that it is aligned with the general direction Jakub wants to
take things in eventually as he hasn't (yet) complained in the reviews
:D

> Otherwise how
> can netdev core pass in the old queue mem into ndo_queue_stop(), and
> where is the queue mem stored?
>

What we have in mind, is:

1. driver declares how much memory it needs in ndo_queue_mem_size
2. Core kzalloc's that much memory.
3. Core passes a pointer to that memory to ndo_queue_stop. The driver
fills in the memory and stops the queue.

Then, core will have a pointer to the 'old queue mem'. Core can then
free that memory if allocing/starting a new queue succeeded, or do a
ndo_queue_start(old_mem) if it wishes to start a new queue.

We do something similar for ndo_queue_mem_alloc:

1. driver declares how much memory it needs in ndo_queue_mem_size
2. Core kzallocs's that much memory.
3. Core passes that memory to ndo_queue_mem_alloc. The driver allocs
the resources for a new queue, attaches the resources to the passed
pointer, and returns.

We can also discuss over a public netdev bbb call if face to face time
makes it easier to align quickly.

> Or is it the new queue mem being passed into ndo_queue_stop()?
>
> My takeaway from the discussion on Shailend's last RFC is that for the
> first iteration we'll keep what we had before and have the driver
> alloc/free the qmem. Implementing this for bnxt felt pretty good as
> well.

We can certainly switch back to what we had before, and remove the
ndo_queue_mem_size we added if you've changed your mind, not a big
deal.

--=20
Thanks,
Mina

