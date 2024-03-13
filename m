Return-Path: <netdev+bounces-79735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B84287B15B
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 20:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317C21F26AEB
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 19:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFF86281D;
	Wed, 13 Mar 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DsWP5D+9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B74CB35
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355230; cv=none; b=KDqOb3IzU2uRU4ux06oYJKrzRSouxYFugLgXJCZvm7pCuaE+TTNunjAbRGwLufapWcWSupZRiDyKBZqW//TV+ZsneRSadOGhOXbyybAoDJ42Y8nt1WqLtWRe+wtYAvkSiV5YNwA+76KNtcRljS2jhxY3nN/EUrhG776598fwuPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355230; c=relaxed/simple;
	bh=UKCF2JgHU6sGdK9UO+UqDfgKMPdx70tIOR76xFhLuAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muM3hjA2r9HLKOZoSdjNRgVT7EgBzSugi7CbfSA92Jt6Qw74fFWGxxSbKBEvTdXlQSUZU0wnsxOAl6Ml5fmD8+yGmMSrSL+xyfVyoTDVowbx8HIWPSy+3I1PFscX66grHFOxIp+jl1YqxbeUgwoYUKz6KaHkulucnvLWq6YQ40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DsWP5D+9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29a5f100c1aso136092a91.0
        for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 11:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710355228; x=1710960028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKCF2JgHU6sGdK9UO+UqDfgKMPdx70tIOR76xFhLuAM=;
        b=DsWP5D+9ztT78OdfoxZNmKX7mrs3RRF6LNVAAVVePPTRkn31yOqFJc0zCijhsHStSg
         Jx6cJpITe3jyY38S6vzFQOX89Bv4SsBExza05GPCZerYL3CroKtwTjqZRhbVjAvPFRh7
         Ad4XG9GtXEPZaT3bbebPlGGyX+TyJx7JT3exVJfn+Pj/eCExwBc7BDo9cAPhuMpZNaxp
         kkYZbsapbdYl+Xcr8G6pVAHrsbfECdeAV/zRj4890dNXfqY1F7zb6nqbX45gjXoPE6rl
         cOgX9M64EtCCpBxng3pynmHiPtBtKZLik96NVpR+84RxK45yUoOlIymPqyAf8Wlg/ybb
         hZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710355228; x=1710960028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKCF2JgHU6sGdK9UO+UqDfgKMPdx70tIOR76xFhLuAM=;
        b=AMr5OU1kpqdnYOIpMAJF8RxXnq0VEXTvb11INbRFSwKcTCnWAe+yl4Js5+mlZDzfdp
         dBi8nug7NahRcHzhTZJHuvP4Zclv0pnzVUKC7b952L11neAcFhKbyZEJcHfj6XKO/7Vv
         Wmhf5hVmWT7kx67c+DSjNQnlyN0u/hRWx/EEhD1a8YoIrLRwYSa4OoAaS8t4exrdl5Wy
         KrhI1fFMnII21JrQBtjpRANAWhQEBGcn54+pvoS33ViGsgxP1jqPVvA0Eq4kODhyHLFM
         dheHArGSeSkBR3GBxmHXykf0CN2hTXLP42EHrTuZWU41GO4PJIvOuorYT/nx4Ktvj9b+
         Bxpg==
X-Forwarded-Encrypted: i=1; AJvYcCX8PBz5PXWLZibadgz78ywNcYaTgMIu6KICzNPnnXBVyHN1g1REzOP4C3iG3XeuF/xT/78rhx5y07t6JMf5cyIlxUYm8eHt
X-Gm-Message-State: AOJu0YySW9ybcWyWmO757kMqFomwvZGG+npeVkgv8RBnIndSDfYQznVe
	OOO3Ij6bhy60Lyc0umSbSEMY9VND0xj+DlmItNJYQI+xieeFKsYCL/EbTzkjXZEjN7OHe7sK23u
	g+OvY2Xxr09NkXiCMmG7yuCu46sZkD8d8FG7gVg==
X-Google-Smtp-Source: AGHT+IFn7m3XPNUeSG6h1n4OWydgJgqKei2hyzaeIOCPn+b2XJT96X5dFxS6HSNU3tdMob4iV030gza5PkO6o4jft5g=
X-Received: by 2002:a17:90a:7784:b0:29c:720b:5f95 with SMTP id
 v4-20020a17090a778400b0029c720b5f95mr786007pjk.30.1710355228037; Wed, 13 Mar
 2024 11:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312160551.73184-1-ignat@cloudflare.com> <20240312164221.5bf92fd0@kernel.org>
In-Reply-To: <20240312164221.5bf92fd0@kernel.org>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 13 Mar 2024 18:40:16 +0000
Message-ID: <CALrw=nGE7kzj9wnPw0qkM2d0HT-BUYtLqoD5iJGjrOXcbMPe3Q@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] net: veth: ability to toggle GRO and XDP independently
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:42=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 12 Mar 2024 16:05:49 +0000 Ignat Korchagin wrote:
> > It is rather confusing that GRO is automatically enabled, when an XDP p=
rogram
> > is attached to a veth interface. Moreover, it is not possible to disabl=
e GRO
> > on a veth, if an XDP program is attached (which might be desirable in s=
ome use
> > cases).
> >
> > Make GRO and XDP independent for a veth interface.
>
> Looks like the udpgro_fwd.sh test also needs tweakin'

Sent a v3 with adjusted test

> https://netdev-3.bots.linux.dev/vmksft-net/results/504620/17-udpgro-fwd-s=
h/stdout
> --
> pw-bot: cr

