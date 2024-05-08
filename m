Return-Path: <netdev+bounces-94674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 442F88C02A6
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679101C21159
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F7510A0B;
	Wed,  8 May 2024 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFKT1UeF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546D79F6
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188186; cv=none; b=sYop90FNsTygiEJCmVVvjVAGvuBfZMNIQtAmaRajuQyAJ14Biht8gUtZFWJ3ry9X1U5eQpZkkme5oSks4yqDa5kntHcqrQCFZxRp0W2LefLIgA0UffNOY6ZdAn/bVI+fS2wAME6pc8sl8j3TumJvN53SSqXKCSWyB+5DRwwzkys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188186; c=relaxed/simple;
	bh=uoe8OefhoAQwuRJ5zIBBp2lOQ2PpzIoMN1huezqBpXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joYqcVZ7OiUvTxRUetI++XJwFGon+o2HJeMO3jToqdvoyZ4r3aXodPYXIS5gdoEtjLOI1XJPiMBvgyM2do0ETQEd1DGhKCjBvFEz95gHMIVnjMZbvdHlyqt4uQTheT0+hjBvZoTVApL7desWbxXpJgPT6NVRnzYd0M52jvJcsZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFKT1UeF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a599c55055dso1151199766b.0
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 10:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715188183; x=1715792983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clnddFl7CyMUj06XhlRnWKoGEkF5U3jOoc+oVu9EUmo=;
        b=BFKT1UeFLjiOGuYMWRzCvAg2WINq+fpyRhMP7LuVewzjYUDFkDiyRAJqDWkuBc9msQ
         4fXGWlQ8Nw1pk/DmxEmNuddJHIgFsDWuZ0u5Pnc9iah2/Z163Mpb903JpAYwcNoK6DRX
         OhT+UzhA+0bl5eU/+QKVCF0i5u+UnzXRg4XdYdScd8rwhsS8gp0hOYmCWcj78n7sQBg0
         G6+6ynGIToKNcvh7Iu+NVOgLUtR27YLAFgwcWTaYrJAzK90ZFTyO7Ev/hKjL8i+lw54P
         CiVx70yv1s5NUg03Cbg9/BQotvapG9AZFeHo/enzWKtwixAOJ7hq9ZuaYQ0XKXpWI4a8
         JmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715188183; x=1715792983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clnddFl7CyMUj06XhlRnWKoGEkF5U3jOoc+oVu9EUmo=;
        b=MOGmM7IejpBzSWHKx0QXw/CWGf5XnRp+1ItvDPcZfMPumPu31D9drVMg2zUaTByj4p
         F9xhaMwi+36HfcZX4wwtZ6HK2Yrp9EQQY45jQPellJmtS199a9munaVNcx9Qha3sMeBV
         MP72RWsLLN05SMIDE5tbzhmvJ43KVTkMDo8GaaMEfBDqikko3taE5cF7Ef0N2Rg8Zcjw
         GluXqP17sIq1H411z7paMGPiaz575/kRD0W32/uLR5c3ZXa8Gy8ITkV/P3zHhgQWA66J
         uEEncNIDOcdTkW30XD51cEpobQE7qJwFB5aWU9DnsYmqQkDU7PaEge2F+huF3jF01uvR
         +CFw==
X-Forwarded-Encrypted: i=1; AJvYcCX6zJ0BuvGLbFb3QtZsF37HTmK0maZbMoLDdhwd6E6zR5xKldCLk7Z43+NEL2Yng7FLSvhuGVXx1zAYlOPoxtxT0yTQ2XKH
X-Gm-Message-State: AOJu0YxCsEgnbF9xOancMiSfFncciPAuYJ2DG4G5ZwTKl2H4AzlSJ286
	RFzsVEvypmp7KpbBXVq4n/5X1AswxHgkT9ubx006SJk917L4xG0lkH2SVFYEnGSqU69RDTp02fb
	Czqg3AIXlvXjEklD4CsgrjE0sJ0wO5U1joQOr
X-Google-Smtp-Source: AGHT+IHTkul/enVsD9dwHR6VUgmd9uRAtBWdTIKfWSzunBrU2Bd9xJYzW2KLXteJkXJUWXf7T4/wmyttFAeM7jjlAgc=
X-Received: by 2002:a17:906:1c48:b0:a59:bb20:9961 with SMTP id
 a640c23a62f3a-a59fb94d63fmr189019466b.20.1715188182707; Wed, 08 May 2024
 10:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501232549.1327174-1-shailend@google.com> <20240501232549.1327174-11-shailend@google.com>
 <43d7196e-e2f5-4568-b88b-c66e51218b2b@davidwei.uk> <CAHS8izOYj-_KKgpPm7Tn3SkcqAjkU1b4h9nkRpPj+wMyQ23JqA@mail.gmail.com>
 <320a7d5f-f932-467b-a874-dbd2d8319b9f@davidwei.uk>
In-Reply-To: <320a7d5f-f932-467b-a874-dbd2d8319b9f@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 8 May 2024 10:09:29 -0700
Message-ID: <CAHS8izO4EjXB4U=oq0zFTdJRnqXPzRJLo9fVqtSHPAFnKoU9aQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 10/10] gve: Implement queue api
To: David Wei <dw@davidwei.uk>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, hramamurthy@google.com, jeroendb@google.com, 
	kuba@kernel.org, pabeni@redhat.com, pkaligineedi@google.com, 
	rushilg@google.com, willemb@google.com, ziweixiao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 2:06=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-05-06 11:47, Mina Almasry wrote:
> > On Mon, May 6, 2024 at 11:09=E2=80=AFAM David Wei <dw@davidwei.uk> wrot=
e:
> >>
> >> On 2024-05-01 16:25, Shailend Chand wrote:
> >>> The new netdev queue api is implemented for gve.
> >>>
> >>> Tested-by: Mina Almasry <almasrymina@google.com>
> >>> Reviewed-by:  Mina Almasry <almasrymina@google.com>
> >>> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> >>> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> >>> Signed-off-by: Shailend Chand <shailend@google.com>
> >>> ---
> >>>  drivers/net/ethernet/google/gve/gve.h        |   6 +
> >>>  drivers/net/ethernet/google/gve/gve_dqo.h    |   6 +
> >>>  drivers/net/ethernet/google/gve/gve_main.c   | 177 +++++++++++++++++=
--
> >>>  drivers/net/ethernet/google/gve/gve_rx.c     |  12 +-
> >>>  drivers/net/ethernet/google/gve/gve_rx_dqo.c |  12 +-
> >>>  5 files changed, 189 insertions(+), 24 deletions(-)
> >>>
> >>
> >> [...]
> >>
> >>> +static const struct netdev_queue_mgmt_ops gve_queue_mgmt_ops =3D {
> >>> +     .ndo_queue_mem_size     =3D       sizeof(struct gve_rx_ring),
> >>> +     .ndo_queue_mem_alloc    =3D       gve_rx_queue_mem_alloc,
> >>> +     .ndo_queue_mem_free     =3D       gve_rx_queue_mem_free,
> >>> +     .ndo_queue_start        =3D       gve_rx_queue_start,
> >>> +     .ndo_queue_stop         =3D       gve_rx_queue_stop,
> >>> +};
> >>
> >> Shailend, Mina, do you have code that calls the ndos somewhere?
> >
> > I plan to rebase the devmem TCP series on top of these ndos and submit
> > that, likely sometime this week. The ndos should be used from an
> > updated version of [RFC,net-next,v8,04/14] netdev: support binding
> > dma-buf to netdevice
>
> Now that queue API ndos have merged, could you please send this as a
> separate series and put it somewhere where it can be re-used e.g.
> netdev_rx_queue.c?
>

Definitely happy to put it in a generic place like netdev_rx_queue.c
like you did, but slight pushback to putting it into its own series.
With the ndos merged finally, I can take our devmem TCP series out of
RFC and I am eager to do so. Making it dependent on a change that is
in another series means it must remain RFC.

What I can do here is put this change into its own patch in the devmem
TCP series. Once that is reviewed the maintainers may apply that patch
out of the series. I can also put it in its own series and keep devmem
TCP in RFC for now if you insist :D


--=20
Thanks,
Mina

