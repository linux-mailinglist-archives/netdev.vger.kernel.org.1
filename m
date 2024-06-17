Return-Path: <netdev+bounces-104222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 426B290B93D
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BDC1F230B0
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB3C194154;
	Mon, 17 Jun 2024 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlLEcbew"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA7A192B88;
	Mon, 17 Jun 2024 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647991; cv=none; b=UFU9Ciu7bU2tVnKLsmdFtpGcMHqv65bO4KdOxJTYUL5sYop1Vm8n92pzWO7d8epBTmAMmpj+pGc2LVk8cF+H7D8IO/LNo8QYtlmvAZbCClFBhk0HKbabFTcN0gJVftViJoii6mCb+BMnjDYzprrtFC5Xg2ETxaA+ah5/1jGJgoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647991; c=relaxed/simple;
	bh=hRLVvLtRBbOdvUPno8a93Vzcp5jl8gtbD85/dJV2oDk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YPdQ6whchcI0UGtLQ+oCyu/0Ne+rdIhSkr5cPCoXnXl5bwdap5E40wvd/55eAdd0Q2yHyhJVliKhtS3r4OT6DyCqUp1hY1gtUZAXnfeOZzElnPkgXANnNpY9lTpB5MklNRmUkX/O67l8lge1LL2eMwJkb10v2qJOJ0/ES/jIbTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlLEcbew; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f97a4c4588so2829443a34.2;
        Mon, 17 Jun 2024 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718647988; x=1719252788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnDgtRUgKAlSFYmIuJjQW/N6laowqIFFEW1+oJmutvU=;
        b=KlLEcbewk7h6zmGsCJhFMwfBX80bMe9Af+jSQO8fBE7wdZDqfyNqf73lw5Hg4QASIG
         bfrOVw0p9ZxWpV1qvIK4idgbQJ6cVCTkuoGr7GfgL0g6bDVQbN7tSWfzUUKpzJVEDAGI
         fbWFrUwW6G6pv2S9KuwHDukfMYXrJVAcf1uJ+sX1bg1T0EgE8jwVbLIdt6LJTKmMvsDY
         FLqPDcTbi6TTFHM1kH+c+BSCHsWfbu44hJaTfBd8F3orwJskwmMoL2ST1eqDddEH8DgV
         cmCOIJlckVhDTHu4vE7OM24u8abShyErJn5Zt805uDBzv0JnJxEJMxbNaKexHRJ65lzw
         GHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647988; x=1719252788;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wnDgtRUgKAlSFYmIuJjQW/N6laowqIFFEW1+oJmutvU=;
        b=DAfEyC802YnorjZYyGyBh8AAV5BqZupdI8q9PnGUZ3Rsmi/YA1so2lmwWpGAwC/d5R
         PMXTWTGM+/Zsm+7x2h8tDcguQ8IWewfzrysSGDAth7S/tMj2HtiKLx5r+NNDvh+M+MmI
         V+3W6I/iSLcGrm1ihtLNC/+fjqHmPllcFfNb06vrhTdXba1zr/2d4IkAHhXJiP5C5++8
         Dgk+kVCOMDqSXkmHg7ynygnAC4IxjpDS3v7/EM3aeWeFLUlFB1hESG1eWmcTI8gq66+Z
         /VleJioB4bQ9CS/T/Q6PXCHM9w3a1kukDq7CJw4FNgL6JRma7l3xlMzGXrTlNkR6b7XE
         Xc0g==
X-Forwarded-Encrypted: i=1; AJvYcCWjDrdFsncnKZzXe9c8n2jWC1ynaY/Vghy2krESaSRSEl+dNydyhi5mUs3jOn38KkCTNJyZ4uRkkmdlfib5JjXUOPoBDfqXcHF8PD/jurmorPrBMETLtlStF2cr+Xy7tJy2yOlT
X-Gm-Message-State: AOJu0YyHk7jnKG3wQx3u5pZbjjGDDClp6OJFswlOdGy5R/27y3NF+PQG
	uU6U/o5Wse3/e3Nbg9tCg2EPgPvJnnH9Ao9khP/swPJr0IzCWSbT
X-Google-Smtp-Source: AGHT+IEobT5WZZ9llfzIFkvOO66J52WFUiWGnt25JF+3NqHKxdUDb76NjANoVgeOSeZ/Qa2KtCilqw==
X-Received: by 2002:a05:6830:1da8:b0:6f9:eb37:b49a with SMTP id 46e09a7af769-6fb93b5b890mr10915095a34.36.1718647988217;
        Mon, 17 Jun 2024 11:13:08 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5bf289csm57828316d6.26.2024.06.17.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:13:07 -0700 (PDT)
Date: Mon, 17 Jun 2024 14:13:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Mina Almasry <almasrymina@google.com>, 
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <66707cb3444bd_21d16f294b0@willemb.c.googlers.com.notmuch>
In-Reply-To: <ad06d2bb-df1d-41cd-8e5a-8758db768f74@intel.com>
References: <20240528134846.148890-1-aleksander.lobakin@intel.com>
 <20240528134846.148890-12-aleksander.lobakin@intel.com>
 <66588346c20fd_3a92fb294da@willemb.c.googlers.com.notmuch>
 <ad06d2bb-df1d-41cd-8e5a-8758db768f74@intel.com>
Subject: Re: [PATCH iwl-next 11/12] idpf: convert header split mode to libeth
 + napi_build_skb()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin wrote:
> From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Thu, 30 May 2024 09:46:46 -0400
> =

> > Alexander Lobakin wrote:
> >> Currently, idpf uses the following model for the header buffers:
> >>
> >> * buffers are allocated via dma_alloc_coherent();
> >> * when receiving, napi_alloc_skb() is called and then the header is
> >>   copied to the newly allocated linear part.
> >>
> >> This is far from optimal as DMA coherent zone is slow on many system=
s
> >> and memcpy() neutralizes the idea and benefits of the header split. =

> > =

> > In the previous revision this assertion was called out, as we have
> > lots of experience with the existing implementation and a previous on=
e
> > based on dynamic allocation one that performed much worse. You would
> =

> napi_build_skb() is not a dynamic allocation. In contrary,
> napi_alloc_skb() from the current implementation actually *is* a dynami=
c
> allocation. It allocates a page frag for every header buffer each time.=

> =

> Page Pool refills header buffers from its pool of recycled frags.
> Plus, on x86_64, truesize of a header buffer is 1024, meaning it picks
> a new page from the pool every 4th buffer. During the testing of common=

> workloads, I had literally zero new page allocations, as the skb core
> recycles frags from skbs back to the pool.
> =

> IOW, the current version you're defending actually performs more dynami=
c
> allocations on hotpath than this one =C2=AF\_(=E3=83=84)_/=C2=AF
> =

> (I explained all this several times already)
> =

> > share performance numbers in the next revision
> =

> I can't share numbers in the outside, only percents.
> =

> I shared before/after % in the cover letter. Every test yielded more
> Mpps after this change, esp. non-XDP_PASS ones when you don't have
> networking stack overhead.

This is the main concern: AF_XDP has no existing users, but TCP/IP is
used in production environments. So we cannot risk TCP/IP regressions
in favor of somewhat faster AF_XDP. Secondary is that a functional
implementation of AF_XDP soon with optimizations later is preferable
over the fastest solution later.
 =

> > =

> > https://lore.kernel.org/netdev/0b1cc400-3f58-4b9c-a08b-39104b9f2d2d@i=
ntel.com/T/#me85d509365aba9279275e9b181248247e1f01bb0
> > =

> > This may be so integral to this patch series that asking to back it
> > out now sets back the whole effort. That is not my intent.
> > =

> > And I appreciate that in principle there are many potential
> > optizations.
> > =

> > But this (OOT) driver is already in use and regressions in existing
> > workloads is a serious headache. As is significant code churn wrt
> > other still OOT feature patch series.
> > =

> > This series (of series) modifies the driver significantly, beyond the=

> > narrow scope of adding XDP and AF_XDP.
> =

> Yes, because all this is needed in order for XDP to work properly and
> quick enough to be competitive. OOT XDP implementation is not
> competitive and performs much worse even in comparison to the upstream =
ice.
> =

> (for example, the idea of doing memcpy() before running XDP only to do
>  XDP_DROP and quickly drop frames sounds horrible)
> =

> Any serious series modification would mean a ton of rework only to
> downgrade the overall functionality, why do that?

As I said before, it is not my intent to set back the effort by asking
for changes now.

Only to caution to not expand the patch series even more (it grew from
3 to 6 series) and to remind that performance of established workloads
remain paramount.
 =

> Thanks,
> Olek



