Return-Path: <netdev+bounces-211048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA0BB164BF
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 18:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4943AF669
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF1D1D516A;
	Wed, 30 Jul 2025 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="YqrqAGxe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1423B1411EB
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893118; cv=none; b=gi45K03yQD5yEFwSDdCqUaYPP0BR6D52n6YLX5F50xNAJePIsQqdK9Dh2CeYqoE/88sJwzTvo3+lmIAkB4bbGXldxc+LQkR0UbqWezqMo9MxjME0CreE3TLo5YgUIiEkws6Yk3dZwDhYC5cqJSRA5U7dZ6ST0kYCtQ7NnbIfP6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893118; c=relaxed/simple;
	bh=tAMrQ2FGFyfTHTJMkhm+xHWPCxFiMsXykb5iK4+ZKTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTjM9UHJvB62LBcZ3N4tHdvL0y+xzH0zIZ4ZWlCeXZdCHrb7Jp6Olqsor8+Nh0AV0fezFALIaaJ3wLB+sF2ZU2aeLKXdAUicbuu2velhQdcd3VcDew5qm1EiP/Gt6ycA8QmAySKs8fzEACBCymbbCFoEn0N+Dd0J/68va9jbnGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=YqrqAGxe; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55b829c7f1aso761266e87.2
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1753893113; x=1754497913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDliXGKvlQ/BCMbKD+15lV6uBzdFVhBiyBD3CCNoi+4=;
        b=YqrqAGxeZqDn8zoz+745M5mBbzvEhzJ5kMBUDtznkWz9nmxqDrPoD3gOaMwaLMPNH2
         1GHiSxq16Y6E+1lrbJz3X9mz+FpbgRqEcLDEogmb2EDv2MTb/AE5D/mZDTl0JXVsCW1C
         0DfSSbJT8CKgXcoED0TKzmQwrFZkMC3jE3uJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753893113; x=1754497913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDliXGKvlQ/BCMbKD+15lV6uBzdFVhBiyBD3CCNoi+4=;
        b=rLr3QzG/ngkpq9AqoJ0HeXuta67kox2LNAA5EoqB0TOaCe9XsuZVWZAJdLqt3WDUBM
         QEwlIlw4SEfRk5bYDX2bDbGx+MclS5FtBvW7q0lmR7gueTv5e0WgowDG8DiH/WEMQMty
         WRxC2BZhykRE3FjJg8zthV6F7vQw5N6EiKRIZFE3FvZvYArJuZLVef27aA9W3hn491EJ
         VDRijEFI0DSFzfZKNdCEjUxjoXVvPI/12VFq1YU224Q1tVb1/U5QHqJovCCq4Io6CZ4f
         40qU7N8DWOZB0IiVDg3nD5Dicg0fCAZfewntYp+d7NB7cf7wrVE9/MNWfxmq31mn7Fjv
         SR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBFPVpRxiOnyNuREO8ssV+4i1XcJ5ai3RtZ61waXIRL2cHRU3Fn4TzIh6p1n3RqdhJn7+Hxmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhYbuyjPFMzWztsOHTKGB8BeRKNTJs9yP4KZuP6fAI7kUFYq+x
	1hQpIFFRiNLexmbceMymGNCHG8rUsyins4FdjCS3FQ1Gkvwla/93nJqokAfWaCKbRCAEhBWcOmw
	Igt87K/kSLoUN9qT59TA35YM652EmtCvvtxsaHhg+5A==
X-Gm-Gg: ASbGncvJsY2iQ+x2xiA78DF1MXEH6qaaVpSUkDAQilwFlAhJf0iuIOPPSE6Z5tJmmRJ
	0dNRfOa2qg5xZV8t8T8TRvwS+tAfRY6Gzpc49YjKG+5ex6ufBZUCwf51nUzFXDGGJKhTR23WliQ
	m9l9oVlDpWexDSWzGOJgZbXiHUgcR4SNvqOOSgqXbLmaFZrnP199tPKXwtfJhDGXhgoDaPtAcDe
	0e8rzhgChKmGfB19u4=
X-Google-Smtp-Source: AGHT+IHlF87yt1sGF4mfsYTjr5DcCQHzlyp/fPJ2KzKKCuhmsciQ+9LBQj0uvlgAApGvkDLV62b8lv92hTjaIZ+oqQI=
X-Received: by 2002:a05:6512:2116:b0:553:35e6:393b with SMTP id
 2adb3069b0e04-55b7c0a8a83mr1006865e87.45.1753893113145; Wed, 30 Jul 2025
 09:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729-mlx5_gso_segs-v1-1-b48c480c1c12@openai.com>
 <195d0388-57ca-4a1a-bc92-65da899443ab@nvidia.com> <CANn89iJo5Fxx4kqhE4S+z4N0BtLW2462Pc6uBB2OvPDpo7-pKw@mail.gmail.com>
In-Reply-To: <CANn89iJo5Fxx4kqhE4S+z4N0BtLW2462Pc6uBB2OvPDpo7-pKw@mail.gmail.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Wed, 30 Jul 2025 09:31:42 -0700
X-Gm-Features: Ac12FXzSoEUK9l_mGx6YTVX7yGAZQwi_r3XaSTcdGrTnQqDZo9W7jb3xXlrX0wI
Message-ID: <CADg4-L-7UWVfWOAFOBjVJ4PXbz06b1riDO3r5d4QpGj+aTVcfw@mail.gmail.com>
Subject: Re: [PATCH net] net/mlx5: Correctly set gso_segs when LRO is used
To: Eric Dumazet <edumazet@google.com>
Cc: Gal Pressman <gal@nvidia.com>, Willem de Bruijn <willemb@google.com>, Bailey Forrest <bcf@google.com>, 
	Catherine Sullivan <csully@google.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Amir Vadai <amirv@mellanox.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 5:28=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Jul 30, 2025 at 4:06=E2=80=AFAM Gal Pressman <gal@nvidia.com> wro=
te:
> >
> > On 29/07/2025 21:34, Christoph Paasch via B4 Relay wrote:
> > > From: Christoph Paasch <cpaasch@openai.com>
> > >
> > > When gso_segs is left at 0, a number of assumptions will end up being
> > > incorrect throughout the stack.
> > >
> > > For example, in the GRO-path, we set NAPI_GRO_CB()->count to gso_segs=
.
> > > So, if a non-LRO'ed packet followed by an LRO'ed packet is being
> > > processed in GRO, the first one will have NAPI_GRO_CB()->count set to=
 1 and
> > > the next one to 0 (in dev_gro_receive()).
> > > Since commit 531d0d32de3e
> > > ("net/mlx5: Correctly set gso_size when LRO is used")
> > > these packets will get merged (as their gso_size now matches).
> > > So, we end up in gro_complete() with NAPI_GRO_CB()->count =3D=3D 1 an=
d thus
> > > don't call inet_gro_complete(). Meaning, checksum-validation in
> > > tcp_checksum_complete() will fail with a "hw csum failure".
> > >
> > > Even before the above mentioned commit, incorrect gso_segs means that=
 other
> > > things like TCP's accounting of incoming packets (tp->segs_in,
> > > data_segs_in, rcv_ooopack) will be incorrect. Which means that if one
> > > does bytes_received/data_segs_in, the result will be bigger than the
> > > MTU.
> > >
> > > Fix this by initializing gso_segs correctly when LRO is used.
> > >
> > > Fixes: e586b3b0baee ("net/mlx5: Ethernet Datapath files")
> >
> > Maybe we should put an additional Fixes line for the gso_size patch?
> > It doesn't directly fix it, but it will clearly emphasize the importanc=
e
> > of picking up this patch together with the other one.
> >
> > > Reported-by: Gal Pressman <gal@nvidia.com>
> > > Closes: https://lore.kernel.org/netdev/6583783f-f0fb-4fb1-a415-feec81=
55bc69@nvidia.com/
> > > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> >
> > Thanks Christoph,
> > Reviewed-by: Gal Pressman <gal@nvidia.com>
>
> I do not think we need many Fixes: tag.
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> If we really want to be precise, the issue also came when GRO got
> support for GRO packets ;)
>
> commit 5eddb24901ee    gro: add support of (hw)gro packets to gro stack
>
> This commit really implied that both gso_size and gso_segs had to be
> set by drivers RX paths.
>
> It seems drivers/net/ethernet/google/gve/gve_rx_dqo.c has a similar issue=
.
>
> gve_rx_complete_rsc() sets gso_size but not gso_segs
>
> shinfo->gso_size =3D le16_to_cpu(desc->rsc_seg_len);

I see! I can send a fix, but won't have the ability to actually test
it. So, maybe better if someone else takes this one.

Christoph

