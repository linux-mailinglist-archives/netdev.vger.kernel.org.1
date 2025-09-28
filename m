Return-Path: <netdev+bounces-227026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B18BA73D1
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 17:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31328177435
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CAB225A38;
	Sun, 28 Sep 2025 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gp3+tb4v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C3A21FF3B
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759072799; cv=none; b=lTsFIVsjXUzs64xxM2w+JEj2Znw8j7yzhAiww7lvbhMPjUGkJLR73ccWdraB7NMCVceZlrLFK+BM508KfL3R5qZMfnmmZZ4v/TCQPx9nWHtdX9566PXlAPfjkVgx+3vyMq4vykt3kWnPRkkXxbnSlJmfTMthOUJAAnlNkNblLRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759072799; c=relaxed/simple;
	bh=wPDBrdQTCDXm8wWh7L1ZhRK7JSAkxj0PQWsiK8NKfeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glYeq6yX60NVlDcPI/039rj3wIbL4/9/SL7WmlEKcpFyt8uA9Th9HTR2xB08STULAtvUd8pV//IiKC75OjZYfzULQSNlsuunLfcVAVslv3UiV+247mMhE+sGgmyAn3C+SI8zzRsaTdV4VTWF5mm46iBJfY/0f39VYKqpeB6PzsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gp3+tb4v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759072795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Nj+XJ5XDmLzfECpTepH0pTjok0xdxtN8C8fEmo+ohU=;
	b=gp3+tb4vJVKaNU76Uk4YvmfgpZ/wTz+Vk/r+fsoZwkPD3VeqqhsSnz0Gy/Upr5bX+F4Os+
	ANUg+uOJxh43bpGQ5D76VWTbsiLbNeBlpBO1xkXh3d91F43d7VacTrpbRqbVjOH7zBeWy4
	G+qTZb2FlsXC2cAFcdG8GYePJFK0FTY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-Pa-_wmY6OWeChwDvjk5QBQ-1; Sun, 28 Sep 2025 11:19:54 -0400
X-MC-Unique: Pa-_wmY6OWeChwDvjk5QBQ-1
X-Mimecast-MFC-AGG-ID: Pa-_wmY6OWeChwDvjk5QBQ_1759072793
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-62f8fefe873so3534301a12.1
        for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 08:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759072793; x=1759677593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Nj+XJ5XDmLzfECpTepH0pTjok0xdxtN8C8fEmo+ohU=;
        b=YshfxJKWw6YSPJPFgLfGIWqQP1034Tpb06+9HbbX36C3p8yrNBKJ5Tj+FVLuImkOzp
         goAZFILt64IHAGq/1LeTkLxFFzeDFzuMBzevzyrsoCRSdiM4W9sv4xkfOZJtLlNMCwfj
         FUXnlr+h6PrksbSjHj2oaoiNvLVDRF2zwfnQPAPgRcvY3w4WXhWKq2c3jhR0WP3hcdj2
         Dj9qmxAkEVeXWDfjL2AOXnujAvQ64lUqfN7FLGN3nFCSkSi0id2nBWdBn/r/f7mb5ehr
         KCEZQTDQY2hodwxUyiiQNeob6PHj5kc37X8KXhya72vPd45i6CpH5GRwOCmRzvuNLpnz
         RH0A==
X-Forwarded-Encrypted: i=1; AJvYcCUnUGnR4pUkRQBwQMq/HGAD/4vXPvaBYvI/a7qDkEbTwDYCmXmUnBAcZanNhwBNZg8end3uqnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSqgXuaHSvNgkrq46/VC5e3NKMG+bqLzL6CgRfCh2yZwlzxEy5
	KMV61cHgoY7zDvdcXN+2RQsgiY3PQCSnVP/JyX3u702sdC+U6BfSNAmgdEFC960ztdlIAXR2i4K
	VFq8qavIbEPjYIbDInW70PuueEPzDwRJtpj1WbD+hSfms7ANkkbuERQceifW6KV0X+edYgN0yov
	4LlPxll58vo7qxT3E4uM71Futq4UX2CtEh
X-Gm-Gg: ASbGnctyhLYwP080nC2I+1frdQe9r4psy/Hr3Ek22ynr7te9pqrYK2ZDph2UAUPs076
	7aRnREXs7pVVqnlFJhWzP2nbtpLflp8IUhNwNgu4HQ2R6lIYLC+8Y6pa0Vz6f4y25uG+bK6WLrF
	1aL5jU08FVkudM6q7I3MMt2g==
X-Received: by 2002:a05:6402:1ed5:b0:634:abb6:8b4b with SMTP id 4fb4d7f45d1cf-634abb68ebdmr11666667a12.22.1759072793000;
        Sun, 28 Sep 2025 08:19:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEXOWbg90CJJkxha814gD+CuKt+/kXscwr2CNdbjM83qly0+8WAmk2G6QmTyhOM7V3maHx0B6gcYdklWD4E4E=
X-Received: by 2002:a05:6402:1ed5:b0:634:abb6:8b4b with SMTP id
 4fb4d7f45d1cf-634abb68ebdmr11666645a12.22.1759072792583; Sun, 28 Sep 2025
 08:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adb9d941de4a2b619ddb2be271a9939849e70687.1758690291.git.mst@redhat.com>
 <175892581176.80352.17113730544408747678.git-patchwork-notify@kernel.org>
In-Reply-To: <175892581176.80352.17113730544408747678.git-patchwork-notify@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Sun, 28 Sep 2025 23:19:16 +0800
X-Gm-Features: AS18NWBSpKZiEBLRbL5PnMmNdeGqjtYIf7q6ZYGPEWxXL3UeD_dVM7STFHMxMyw
Message-ID: <CAPpAL=wSFdEgHfA-OysFAqLSjTwAGLkcGYELFaRi-xHmyvO6=w@mail.gmail.com>
Subject: Re: [PATCH net] ptr_ring: drop duplicated tail zeroing code
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jasowang@redhat.com, 
	patchwork-bot+netdevbpf@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sat, Sep 27, 2025 at 6:30=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>
> On Wed, 24 Sep 2025 01:27:07 -0400 you wrote:
> > We have some rather subtle code around zeroing tail entries, minimizing
> > cache bouncing.  Let's put it all in one place.
> >
> > Doing this also reduces the text size slightly, e.g. for
> > drivers/vhost/net.o
> >   Before: text: 15,114 bytes
> >   After: text: 15,082 bytes
> >
> > [...]
>
> Here is the summary with links:
>   - [net] ptr_ring: drop duplicated tail zeroing code
>     https://git.kernel.org/netdev/net-next/c/4e9510f16218
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>


