Return-Path: <netdev+bounces-76251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C9C86D026
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610541F215AE
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F154AED4;
	Thu, 29 Feb 2024 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGT4IUcx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE8E3839D
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226473; cv=none; b=OVXW5rZ1Q7L8T12vlL2kPch7MBPhsL68KS991G4IFo3Q88BesVNdU91fGkW9f2jIAIW9mIa739xtZWOhWqLbLCYxlKku361K78n+N/fhWmaalRp0SymLPJjfFduOq+z9JPdgDyjKeHBcNuj035TthI+Lb0CzqN/86Oznvg12oHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226473; c=relaxed/simple;
	bh=amo0eNZtd9oU8O56/+6pIemgnDn7UMyF4LASrdgemWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNZZVmkDbJvWnnyuKLbv51rNGnXtBxqKYCqU+qvAO3PWdqKJIg074LYYQITP5dNFXnSJQ6ksUWHyoOgn06KMWPbj3wfrQioniG5K1fsOqQs5eNTOmT7/rf9Pryevx5FuSJM4OX9m41z4GqpgsB7lvWqcyDgtSgljo9hkCsESjO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oGT4IUcx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so12090a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 09:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709226470; x=1709831270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amo0eNZtd9oU8O56/+6pIemgnDn7UMyF4LASrdgemWY=;
        b=oGT4IUcxCY0Qbkn5onrXbU2sUUOaNSKb9T76wH1SVAQAIiAwAS5NCLpCsKNmHhoNng
         kVUsVHdUQ7iZDEj/JKarv/lsnPZdI3+9+99zC843Z2lrkbg/jr6AqzS11xDnGEBEPAPg
         /5WYJIgI9PDT0IAvalRMaAmv0ulcHjbWblY6XQ7nlvU4tovHBd2Qj3v8WrHMD6Yd03IC
         sb2UqGeUcW3dZO9kMkYedTygeenLBiWeIXMHgr1ZCvxD0hZusFIVkLm8lqoCMoLijc7E
         MLQl0xOyfY2pxs1FFEEuKqJdItlSS90PRZMKg9Z7j5Nt4vSotD9sS//qjowqPc+/y25M
         jzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709226470; x=1709831270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amo0eNZtd9oU8O56/+6pIemgnDn7UMyF4LASrdgemWY=;
        b=mwb22Fjg6ns/zpEr3CCsGnQvQy4IO2BYfJtA4gdEVg/DyRtWJ1D+GU0PcvgjDVkCYG
         YyRWsUUa1ECDv5NPxQyen3qRysHbRbOCETE00C2A4g9J7WH+C5b+VeLp8HwRr4fi6J/r
         txQ6tQ/X749OcG9fpQZtpVYDTIfiO+FvSGSnA4HaFzug7fHyzL43pXahsR3T03mH+IU1
         SQx6/VA+vq+Jlh5XUati/y12rm34pkfqVx1A3GIUTwT5PMhJ8mV6rMHFdlLD/oK4TdwQ
         C450uh2VQrD2nX7TZrnrDt4dM4IU53+I5pR0VJ8L1tGESybwM9wr+UHsoqHqzlloJjAo
         mdCg==
X-Forwarded-Encrypted: i=1; AJvYcCUTvxO3I3xndUb0QMQfG7tgMwN7ZugL0yK1BT2cV7LIa0nT4mAKcL83ZDTIxxDlxKifk1AqRHRbEhBQIH4dodLRlDgCejwJ
X-Gm-Message-State: AOJu0YyTfyevhVxj3B5KhTDZk2lT1n/5GXHbWdUEmNagCXhddfczxERp
	3I+/c7RotlEYDfl4BNowXXC4QAkNptZoPPJRSgRStDhQw7YTH7OZnY2iLKzJKQ9aXY1XGshL3K4
	fyQ5lEt/VF2pj9f2lgTIbFQw/MlEQ5bcN0vVZ
X-Google-Smtp-Source: AGHT+IGjUaP2d8ryvQOL7I76Mhftue8l+Y6MKjxFwnbwPjrjVcWt+iNF8KdMk94wH9VJ9YPUvWsAk5cy4qw6oSF5Y4s=
X-Received: by 2002:a05:6402:2227:b0:561:a93:49af with SMTP id
 cr7-20020a056402222700b005610a9349afmr120493edb.7.1709226469560; Thu, 29 Feb
 2024 09:07:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com>
 <20240227062833.7404-1-shijie@os.amperecomputing.com> <CANn89iL2a2534d8QU9Xt6Gjm8M1+wWH03+YPdjSPQCq_Q4ZGxw@mail.gmail.com>
 <018b5652-8006-471d-94d0-d230e4aeef6d@amperemail.onmicrosoft.com> <b7825865-c368-1b72-3751-f1928443db32@linux.com>
In-Reply-To: <b7825865-c368-1b72-3751-f1928443db32@linux.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Feb 2024 18:07:36 +0100
Message-ID: <CANn89iJpZ6udACMC9EF=zgYJU5rqLFiTuYJRf1UNA3UKu7CxJg@mail.gmail.com>
Subject: Re: [PATCH v2] net: skbuff: set FLAG_SKB_NO_MERGE for skbuff_fclone_cache
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Shijie Huang <shijie@amperemail.onmicrosoft.com>, 
	Huang Shijie <shijie@os.amperecomputing.com>, kuba@kernel.org, 
	patches@amperecomputing.com, davem@davemloft.net, horms@kernel.org, 
	ast@kernel.org, dhowells@redhat.com, linyunsheng@huawei.com, 
	aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, cl@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:01=E2=80=AFPM Christoph Lameter (Ampere) <cl@linu=
x.com> wrote:
>
> On Wed, 28 Feb 2024, Shijie Huang wrote:
>
> >>
> >> Using SLAB_NO_MERGE does not help, I am still seeing wrong allocations
> >> on a dual socket
> >> host with plenty of available memory.
> >> (either sk_buff or skb->head being allocated on the other node).
> >
> > Do you mean you still can see the wrong fclone after using SLAB_NO_MERG=
E?
> >
> > If so, I guess there is bug in the slub.
>
> Mergin has nothing to do with memory locality.
>
> >> fclones might be allocated from a cpu running on node A, and freed
> >> from a cpu running on node B.
> >> Maybe SLUB is not properly handling this case ?
> >
> > Maybe.
>
> Basic functionality is broken??? Really?

It seems so.

>
> >> I think we need help from mm/slub experts, instead of trying to 'fix'
> >> networking stacks.
> >
> > @Christopher
> >
> > Any idea about this?
>
>
> If you want to force a local allocation then use GFP_THISNODE as a flag.
>
> If you do not specify a node or GFP_THISNODE then the slub allocator will
> opportunistically allocate sporadically from other nodes to avoid
> fragmentation of slabs. The page allocator also will sporadically go off
> node in order to avoid reclaim. The page allocator may go off node
> extensively if there is a imbalance of allocation between node. The page
> allocator has knobs to tune off node vs reclaim options. Doing more
> reclaim will slow things down but give you local data.

Maybe, maybe not.

Going back to CONFIG_SLAB=3Dy removes all mismatches, without having to
use GFP_THISNODE at all,
on hosts with plenty of available memory on all nodes.

I think that is some kind of evidence that something is broken in SLUB land=
.

