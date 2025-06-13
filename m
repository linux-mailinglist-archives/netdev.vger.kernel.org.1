Return-Path: <netdev+bounces-197351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A884AD835A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 08:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DAB3B83BF
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 06:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4756257459;
	Fri, 13 Jun 2025 06:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kjv+E/fa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404262580E2
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749797099; cv=none; b=YBKyVPTI2G0EfVCQ+KieZIOPWqyGPx3eHXz0PxjXCJkXngyM3A6svVha902JGZ4F3JpeXJd3qe6lMqr0EfNiZe/jpwQ1XKmHnL/uHC5rz5F3CNFmqGeFTsbzX4nVdajnBhqAkL1CjZCKgFtxM0L9u8ggTXSTnO6xrIkavDYKokw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749797099; c=relaxed/simple;
	bh=++x7b23xKxa0fOXPJseMGeX9PSCVlALK3S4yXPCXtZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U42fMQXjdrAfMcsZYsfMKUrwjq5qGF9H1UuyyRxoZuCVJo7tTeKt8Q6FhocT1qgpxC2tBJNv6KB4aUp5W6R31QBOAEC+FfSdCYMXOhSrpn0Lxo3P/YGyu2CEWD253X24V++Jw6i23No2/ynF06CC0fGyY6aB0kMeZjy5D7IFGNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kjv+E/fa; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a58b120bedso21057301cf.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 23:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749797097; x=1750401897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++x7b23xKxa0fOXPJseMGeX9PSCVlALK3S4yXPCXtZM=;
        b=Kjv+E/faGyfrJDTpHYLxMrI3jO8vlrI3HGWGhUmZdl5v4Ryw9lenQCpfldk11v20JD
         wpR569yKlvc9g87BJCZ0t9zniAbJciYxG1lxqM/VR/1cJzFvmKNBsSjx7MvDcj3L/hgh
         Nv9HPApvhdoeXtINGJVdxhXELKIrQdcanUKKq6Nw5K2nampXnaR2he0ozyVPydzunOrv
         L1/oD0ceCNlp5bVjn4TQ1T+q28yKmpgf+Mu+95/BICxIVLxERz2d3v356iSKMRbjxMkQ
         13FCqWQeLgjBRAMicTjx88P5Tw4XH1ZyBZS6nLgBqGdEA0WKHyNxAUxU2OxrEWq8r5pZ
         X7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749797097; x=1750401897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++x7b23xKxa0fOXPJseMGeX9PSCVlALK3S4yXPCXtZM=;
        b=gQseYYWvLkdfCB6U2ZB5v6P/3rc6qWRqK0rkt1wfN+/GarzUSRlX6uVDkzKjOAY5os
         88pVLSzOxAcSx+KuNY5uvX1etXrcmGxMaU/KVjHX7flHJ+XCHyeWdgnfSwiygb1RKIHf
         UEy0FZFUlTP6+qMqPe1fxkaMd12GVCIZwbx4aH89lCzz1WSjOpsum1uUd5uNUb8gYsMR
         tgkK91iifRWzSSu8tIBDZYyeA6qHgIjzb28oq9+ojzZVVm1eD1SBxXwsefbB4sPRUPa2
         h3mrWJr2gKyKNdeNlEEFeQDD39TyaXMrT12vgTx3w5LdLcfapr7pYCyWJUJA/RylxQop
         jTdg==
X-Forwarded-Encrypted: i=1; AJvYcCVN0p9P04x+vVDrWUg6c2Pu3swcSIEPzeODPZhjI94EIbIvzOgPdT9hOTBd6DG3ycNbo1UqIt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAcok5zPuH89CotApPik1yb4qlHNKB1YCsnDp6uo/lR7ntCRNs
	iRtpRrA8tZNPuEk2Uu/FJYpzWq4JJNjVBwDurwCLFbewxEplxLNZW4GWsYHAlfUWciWp4LIT7KH
	24KdxSiDrSSio12AGgxe2Wywxd2qlMnG0zukVOIDK
X-Gm-Gg: ASbGncvterakplmGWDBgJqPBSAgBzWZ9DUcFwY3ollHTm4oyYQPBUUWSBHghH+VxK+0
	YkL3IurIuOoHobuv5BvgFkaqjR8EjNAykLOIiFwAkynFZBYQNef+YW8ZF7cGBBkxznV8hOj17Tl
	1tmBsiBS+fbNF/JIupVqRNQKoryVDm64pahhZyOnq85KA=
X-Google-Smtp-Source: AGHT+IEj+1ny/HyDjeRZFoWvdsGM/Xkue9vub+G6IKcGMytzHaGaMsWBE2LcPkspoiT9TKD/qNsITT5JR8t4e1R4ies=
X-Received: by 2002:a05:622a:608d:b0:477:13b7:8336 with SMTP id
 d75a77b69052e-4a72fed6a86mr32449161cf.17.1749797096926; Thu, 12 Jun 2025
 23:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613055506.95836-1-hxqu@hillstonenet.com>
In-Reply-To: <20250613055506.95836-1-hxqu@hillstonenet.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Jun 2025 23:44:44 -0700
X-Gm-Features: AX0GCFvaiZ7z64jwBjYb1Ac0YR4FXM6Yh0Q-YhK7_A1kkZndF3LZ7TlqC5BI9kM
Message-ID: <CANn89iKMuPaa=Pkrjv-fA4o8aCzF=_haFTdZ4bXsyyrzbFqqhw@mail.gmail.com>
Subject: Re: [PATCH] tipc: fix panic in tipc_udp_nl_dump_remoteip() using
 bearer as udp without check
To: Haixia Qu <hxqu@hillstonenet.com>
Cc: Jon Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 10:55=E2=80=AFPM Haixia Qu <hxqu@hillstonenet.com> =
wrote:
>
> When TIPC_NL_UDP_GET_REMOTEIP cmd calls tipc_udp_nl_dump_remoteip()
> with media name set to a l2 name, kernel panics [1].
>
> The reproduction steps:
> 1. create a tun interface
> 2. enable l2 bearer
> 3. TIPC_NL_UDP_GET_REMOTEIP with media name set to tun
>
> the ub was in fact a struct dev.
>
> when bid !=3D 0 && skip_cnt !=3D 0, bearer_list[bid] may be NULL or
> other media when other thread changes it.
>
> fix this by checking media_id.
>
> [1]
> tipc: Started in network mode
> tipc: Node identity 8af312d38a21, cluster identity 4711
> tipc: Enabled bearer <eth:syz_tun>, priority 1
> Oops: general protection fault
> KASAN: null-ptr-deref in range
> CPU: 1 UID: 1000 PID: 559 Comm: poc Not tainted 6.16.0-rc1+ #117 PREEMPT
> Hardware name: QEMU Ubuntu 24.04 PC
> RIP: 0010:tipc_udp_nl_dump_remoteip+0x4a4/0x8f0
>
> Signed-off-by: Haixia Qu <hxqu@hillstonenet.com>

Please add a FIxes: tag, as instructed in
Documentation/process/maintainer-netdev.rst

Thank you.

