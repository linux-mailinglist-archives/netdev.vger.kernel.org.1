Return-Path: <netdev+bounces-112640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5BA93A491
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 18:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F70B22033
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 16:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B10157A58;
	Tue, 23 Jul 2024 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hCgUakyh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54713B287
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721753438; cv=none; b=fzbkvbMFb8/yHvgStC/OzTNyO1p0Uk9Ylh65LmOB3R06HeI/lzev42kOFPAZOqIgllFcSY/y71a0bexGqYYKgq9UL+CQNXzs2rW5mmATLws+5meooupHVSwAhVSdf6dWgmWb6h/LfFACbWSmuR7xkDVawgFDcU+Iu0jcEJyfhsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721753438; c=relaxed/simple;
	bh=rjOPepZienLvRBVDmZYnsVN69H/VU3gR3Md07Jb/n2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjaPUlRSVZ2SjLQCuPcLo/itWodClh260KqwKTHbuBTlMR4wlZjoIzUR9oF+qSlGmW0XxRj8ctMT+dXRyAVccwa3bOsS6diRbT1TNdCaKUwgtMOUUE1fIJQUf8xwhe0yOmh4ArZ2FAOlC+nChUr4RxJZ6mnMCBOLnAtuHbHxLpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hCgUakyh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so378a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721753435; x=1722358235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKWgdAeZuHdBhrsiOBXBN0l4aZDc5ko6p3m24/F8bXM=;
        b=hCgUakyh09AsmQm4ANR5tFnrXZO7GcwKT6I0HfPPscKa+5MDdwc7xyneFFIsk3tVbN
         vqIAf6tlFtXLzIwiCefvk+OpXMQ5nKf/t4q+HFFjmJbiymZmzt1JxmocDnYNgZAdBu3m
         pj0fFKfQT6nPInCnzZjx+epf/2VcNAHcIzhzBsst8mCwttucu0xr2azBKCKimcoxOoyq
         e5GlUSCBOUQjCH41m4yqLqOlHJAeHAW5VmWWGFZjbFEYKz9CKye/h7SbfGljpD6IVbuW
         3L7j14U1Sshe8YPONsnrVwFHQfCGb/9uXX7rTsFm2Fo1gHvyGYLR2jKUAFiKMAFXqUGY
         AV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721753435; x=1722358235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKWgdAeZuHdBhrsiOBXBN0l4aZDc5ko6p3m24/F8bXM=;
        b=VHheSd5cqZZt3PVyOTplfGUszmsSKEGyzY+MkUceRhJ96T6M4XXKa/BWHY6jNCzCm6
         Au7Th/5FLlokoHn6/x2eZANDChc8x4MOZlGtP74MFyotlp4CKZd44v6U82jtiU0SbGdq
         9TRqGWwCow91qOl4aT59BBy247Xcg0tJPof2hXVcDHKBcNrbH2qz9YKTFNdNZDi/U/9g
         StLQrvqOhQfvXXpcNidPzXel63lDcezeeK2cGmICWVtMIDCKBC0/asgQwFFxXCtyFE/U
         4waDmohGweizIudUfdceRzsRA4ijkaiy5ZszXn31bBwbmMjfM6KubibmTrXSRIMbcV7D
         KbVA==
X-Forwarded-Encrypted: i=1; AJvYcCVImhf+yicdYgnUXh60xcSmQtqEfWgwWgiDziVaTN+GoDVOEsbtil/OQNdx7cKtlvjO2zTbtjATF3PACDITrvHM5xOvhh2M
X-Gm-Message-State: AOJu0YzuT/NZEPblEvX4l5hxNyFqy5gi2ONqe+u0wCVCIJdIePeeCVJy
	5fWH47qwbs5JZw9DCPCXuMKINiKEs2z2XDPCtDzGaJcQW4Em8GGkJsM+UoZfOKAyBWmROh1kFp1
	TB8bXIEAuM3bu5G2mrbxcOoaMx1h5fWMWWK8N
X-Google-Smtp-Source: AGHT+IEKM142/O9hQcpgaQy80O52RAjBfdLuLzFRcfK1f+9xezNKmTMV22/npfDj7m/hQevPvTWELF1uzkUVJwH6kaE=
X-Received: by 2002:a05:6402:2681:b0:5a1:4658:cb98 with SMTP id
 4fb4d7f45d1cf-5aac71248ddmr20547a12.0.1721753435089; Tue, 23 Jul 2024
 09:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8b06dd4ec057d912ca3947bacf15529272dea796.1721749627.git.petrm@nvidia.com>
In-Reply-To: <8b06dd4ec057d912ca3947bacf15529272dea796.1721749627.git.petrm@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 18:50:24 +0200
Message-ID: <CANn89iJQB4Po=J32rg10CNE+hrGqGZWfdWqKPdY6FK0UgQpxXg@mail.gmail.com>
Subject: Re: [PATCH net] net: nexthop: Initialize all fields in dumped nexthops
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, mlxsw@nvidia.com, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 6:05=E2=80=AFPM Petr Machata <petrm@nvidia.com> wro=
te:
>
> struct nexthop_grp contains two reserved fields that are not initialized =
by
> nla_put_nh_group(), and carry garbage. This can be observed e.g. with
> strace (edited for clarity):
>
>     # ip nexthop add id 1 dev lo
>     # ip nexthop add id 101 group 1
>     # strace -e recvmsg ip nexthop get id 101
>     ...
>     recvmsg(... [{nla_len=3D12, nla_type=3DNHA_GROUP},
>                  [{id=3D1, weight=3D0, resvd1=3D0x69, resvd2=3D0x67}]] ..=
.) =3D 52
>
> The fields are reserved and therefore not currently used. But as they are=
, they
> leak kernel memory, and the fact they are not just zero complicates repur=
posing
> of the fields for new ends. Initialize the full structure.
>
> Fixes: 430a049190de ("nexthop: Add support for nexthop groups")
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Interesting... not sure why syzbot did not catch this one.

Reviewed-by: Eric Dumazet <edumazet@google.com>

