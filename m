Return-Path: <netdev+bounces-191280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 629D3ABA8B2
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 09:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF671B662F3
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 07:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDD41C2DB2;
	Sat, 17 May 2025 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ozmiuTmz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD451519AC
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747467527; cv=none; b=GgNdkZ8B8EwemKFzzG1nY+X/xh2+SLbfabovqXZWRLhr+dm3g+trsQLOKU/THlDEMm9+b9kZGDlpBvJFC8QfRxyUi9H1gU1vtMeHFiqqHrK+FCzHJoKVKPNkiEyCawRrxZOPDI21rMFlfXqwPI6slDhAJVzyOEZARyQBMiaYzIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747467527; c=relaxed/simple;
	bh=/UzpW5GFx8tR8oPBJ+IxSaWjYlrW3/bxH6xCqRRDNWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/QFgO8aiAPQ0OnaRhVUspibhWat4gtPLdcgVJra+z34Hc2wbNp7djySJUo0I3FEdWC30xUqQI68h8R8spDMeBWZCniYEsXXDWUApcfa6RB352rjgnB+i9jE0jNxUKx9RS5sIv4S6URR1gn1b1r1X2dgiH49HwETrJsp3Du2P5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ozmiuTmz; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47691d82bfbso51779471cf.0
        for <netdev@vger.kernel.org>; Sat, 17 May 2025 00:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747467524; x=1748072324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9kA7G8jvAebsZm9fFd+gZxu9or/CeU8wcOw+bvlUpY=;
        b=ozmiuTmzFRDTRGkWiCYBKNZIxb+Qqj6uUqqVNJEC+e8HD6jfgXtQET5wRRWvjytz27
         lx/2ekIdy1gQ+D4ufqoNTKnI1UyGw66w+EUlaSsYO1q9dLbfkWMKTr6mbSi9FOTjW2SF
         g4/Z4+LIKeQdy4YrmfyiGYKT+7TXiVTS+aYq9lElbVlb2/7pESdG3pnjvbLW78zTKlv1
         MEHwa0UsEPn0Fc/PPwzSSDwKF6St5Cfhlx6eKGoVZ9iYEA/ov1xGrn1b9fLfZ2eAfD+I
         DymBP33TF4J8XXzXJ9JlXWQbAfp8aeJaVftstDr1rXTLDGoh/XQKPv0bZgDwHQOn6duX
         7m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747467524; x=1748072324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9kA7G8jvAebsZm9fFd+gZxu9or/CeU8wcOw+bvlUpY=;
        b=Y1uFsoRWP1FXlVHjrjK+5A+wIcjmTN/R3jLiusnMV3L4oyk2klxeZ9ZnS30zSr1DAq
         Nzb2kCldo8hXx7nCzALcTqep9cURvwl/q7Gk/wbxuEsXoNpN1kfFJiq7FGXeyK9OU42G
         VmzvsbFdoqG74qySTbTwF+/V2gqMn8he53TlaxCIMtI7RmihqYiVEA0jgtITTgsruEIp
         Tfp6meEy1tTPSezNj5P1JH+6IjnDafvXhvVsCXZpIW5//O6rwUd/YPxwYmFw/j5tD4ca
         y/aj+aqpSGryA7xZgCLcT7F+95iX3fIBxsOoGN5dibazUjDlZPwJ9UJnJCeSa5wpa/Lx
         xQeg==
X-Forwarded-Encrypted: i=1; AJvYcCXFqaBTsOxcdnpS+oOcbjLQ0Zh6XfvzMhIQwj0S1V0HYt2hHQWDwDKqeXPppoCPI4Dj8lEOY8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw45G1S+XtjtllVDDxCNNrNLQ58Y7RwJslEkfUHeoc/ZgeMx1Ub
	Eam5V8JnnOq3UtZl/Nwac4Tj3EVqKXK/jkSnadQGBUE1QAlmiBB8cf+AO1PmnNoFK96m8ocWXtm
	jthVTdEAMGcQ2qIkOi1D8thlf3vxWamyIvUTbNUROz843vQGJb92p0Xn/sZg=
X-Gm-Gg: ASbGncuz2uZojsIeD1qM1DqI3PDOKMF/+O2kCW/mIPHa9tdUjVObvQsZMgvHGLDTi8R
	dV1WhdydQfvOi4obJ7fVaiSITDxdreVN5fT6lMDPvK1aNhG1pUtlgfSURZyeChHD6v/yY8qzQw8
	bRT2QQ/6GMchC2mz5pNA/OVBZoCnkTlzM=
X-Google-Smtp-Source: AGHT+IFBfqp+Um/HWnxSdG273xN1f/RM4LtAAlsUIHqaQXuBsq8Q9M571VqWyPoxieYzKpp8L5rKZkatRVDwKHE/5cM=
X-Received: by 2002:a05:622a:5915:b0:477:1edc:baaa with SMTP id
 d75a77b69052e-494b075afb4mr90658281cf.6.1747467523796; Sat, 17 May 2025
 00:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430085741.5108-1-aaptel@nvidia.com> <20250430085741.5108-2-aaptel@nvidia.com>
 <CANn89iLW86_BsB97jZw0joPwne_K79iiqwogCYFA7U9dZa3jhQ@mail.gmail.com> <2537c2gzk6x.fsf@nvidia.com>
In-Reply-To: <2537c2gzk6x.fsf@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 17 May 2025 00:38:32 -0700
X-Gm-Features: AX0GCFuZltUxtYUb1nPOItK5LArEgIDp57rbKbS10vKZC2yAJgYMDJKD8I5OG_4
Message-ID: <CANn89iJa+fWdR4jUqeJyhgwHMa5ujZ96WR6jv6iVFUhOXC+jhA@mail.gmail.com>
Subject: Re: [PATCH v28 01/20] net: Introduce direct data placement tcp offload
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org, sagi@grimberg.me, 
	hch@lst.de, kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, 
	davem@davemloft.net, kuba@kernel.org, Boris Pismenny <borisp@nvidia.com>, 
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com, 
	ogerlitz@nvidia.com, yorayz@nvidia.com, galshalom@nvidia.com, 
	mgurtovoy@nvidia.com, tariqt@nvidia.com, gus@collabora.com, pabeni@redhat.com, 
	dsahern@kernel.org, ast@kernel.org, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 7:47=E2=80=AFAM Aurelien Aptel <aaptel@nvidia.com> =
wrote:
>
> Hi Eric,
>
> We have looked into your suggestions, but both have drawbacks.
>
> The first idea was to make the tailroom small/empty to prevent
> condensing. The issue is that the header is already placed at the skb
> head, and there could be another PDU after the first payload.

What function in the driver puts the headers in skb->head ? Of course
you would need to change it.

Something like this

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 5fd70b4d55beb4ed277a5ea896a6859350b72d21..9a87b3bb46c01dc09d729923e70=
5ca6df93f1df1
100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -553,6 +553,11 @@ mlx5e_copy_skb_header(struct mlx5e_rq *rq, struct
sk_buff *skb,

        dma_sync_single_for_cpu(rq->pdev, addr + dma_offset, len,
                                rq->buff.map_dir);
+
+       if (ddp_mode) {
+               skb_reserve(skb, skb->end - skb->tail);
+               len =3D headlen;
+       }
        skb_copy_to_linear_data(skb, from, len);
 }

