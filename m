Return-Path: <netdev+bounces-228635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61582BD0673
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 17:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301D8189319B
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5592EC0B1;
	Sun, 12 Oct 2025 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="rew1nlBj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929C82EBDC8
	for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760284293; cv=none; b=VGdOZQsGMrq6vHusgKuK0WQM806kDYDBA/6C8HXA4A6zjOugQ64dVwfzcVx3ZfzTLLWK7yP08IsURaUIdNJfVXJHi0PSp/10RFXxutbr0rAxdDPJrN0JLumqP1VARJTQ19569Tu5kA2sZfhzBGVcEoYmaTWDT56SjdWZ8jjF32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760284293; c=relaxed/simple;
	bh=O2MKRwoq0uUdpv+E7NS/geJIHbvnnDJNkrqVbC6Fn4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSRtI0hLu3M/wycSbavd8ZvGYgVOobFJaTYbr9jojunvckQG9zQqasZcAkIp11A8zqWubw43lc1toav/bTE1YI/Q8MdJMWxUvyNISOlPFNPmKH0b51m2UNQ1WSFYPTBrK/hBXFbZPq51rxWBAl556hL3g45KyPh+7JDSK4cbCY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=rew1nlBj; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6271ea39f4so2295391a12.3
        for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1760284290; x=1760889090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nokm4b1fJ6STX0tx8BP4NI1/qKuZKnYqjVb6I3fubi0=;
        b=rew1nlBj4ubTZ7idbzT29vXebqXJcDv0Jd2qU5qPhCX5Tb/YXXYPk9/kOUW7QIZaa3
         I1Txj+O2wM1W3Pf1iMVunCJJ5yaD64DHVfhj8z+7xwt1tUfJLb6ohISFBHWehdeOgbUr
         4bqXkhXVU9GyP/OpU88L4ao+oNYjML/Urbf167eizx8uXCTzvSnPKT7bY5rCybumtFkv
         4kEApGXA5Dy2GKELEZnz/1sznneHG3O7zleqcOyPhcgPTM/k4PGgPtQ/2mcM9awPuAA/
         uD20/Lkij/WaIC2Aliu9dkwAfW6d/GZmN5xdzohjAvsxR+Ez6R93E4yYSt0Rncklp9Cv
         /q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760284290; x=1760889090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nokm4b1fJ6STX0tx8BP4NI1/qKuZKnYqjVb6I3fubi0=;
        b=kqYPPOW+3nXd5FGjDlvBsRfL3H1j+BTLN5lAW5ta2CDrjwHMBj752Vn+630U0CYSxz
         QfLx8051ySK7AowuQp+xJ88rjHBxX1rRcRW0ifnieK+AkWE8sLPDvUm/dRwTKLV/ljgv
         xEimtejFNgy7WRC9OjJQVSwlZ2Zc8sy+/wSJCdk2jysUdV67tDwmWSLjYYxGwb1Idf2m
         zSyXxIw2CngCbKP/jgZZWmjLbHabnh26Q0CAaMyMUAxRgY7BqYG8JQj0/bGRiwBgWZDc
         /tmLDwWKSdVVwXLFDiPnrUFtZZG1OVXPwCBNsftsXAPiKvZX1q4CcoMw9bk/89hS5BGm
         CD5g==
X-Forwarded-Encrypted: i=1; AJvYcCU+lD9kGIiiRzF0HhvMk9TNdcw4KupqVHOMq1UjRe2KA1W/gLZcEAxxBNewsRN7bede23htyDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJjhhVkfOM34SVXTsdp0vJJfTVNkf92rBs2uyKHVhZEI4PGfZP
	noK70xev9wc6FHJuYcSud7tWSprP7d7iHBNV65JTUhwelkaoquQ9Bem/B5U7q/BpLl/ngC346ST
	WMjbBUFA+V9/bH3X+CXab7rcNNxJ24JAzvgRM8NkY
X-Gm-Gg: ASbGncuhUm4dePRsXvxBsz2P4G4XH2y3wj8XbGTf9GcVyGkJHAdst/+2+ugUJPuIrOS
	FHygUW4iMvxUejMYd9Nc9Yo/+IQ11LnQY1TkKnvUOb2foalRMBwfzCizIGyDuFXp31l1reetHpG
	O3klpz9Nwg7DDx+q6qu07z9APhVstyjm4JfkBZJIgMLVtYwSaIRizU5SZfAq0o4uCTPG6P+EC42
	tg8jVbVqnpzcn2/4JoPI8BdMZLrezAyrkbeTv5/PrHB8ZrMkIIxhOMQDloS9SwcN9uGsjZT/yul
	yG4n8dmuQY7A
X-Google-Smtp-Source: AGHT+IGAV/J5KM7v7Wni7fp1uZ+pYkDMllI8brJJEiuS9kBasFE+HHPvZ/3J/t08yxso9/z7RLG2r6gEzhEHY3Z2CjI=
X-Received: by 2002:a17:902:e952:b0:262:4878:9dff with SMTP id
 d9443c01a7336-290273567a8mr226024845ad.12.1760284289952; Sun, 12 Oct 2025
 08:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-mq-cake-sub-qdisc-v1-0-43a060d1112a@redhat.com>
In-Reply-To: <20250924-mq-cake-sub-qdisc-v1-0-43a060d1112a@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 12 Oct 2025 11:51:18 -0400
X-Gm-Features: AS18NWCpWejm6_EFikvhcTI51qpJk4bosEjS9lUx2F59P9nxfEvx151uLU4uwVE
Message-ID: <CAM0EoMnkOoA1x0o4VQ35kS-Sa69QSCRwmQBtVx5hEF9qo6rv4A@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 0/4] Multi-queue aware sch_cake
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
	cake@lists.bufferbloat.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 8:16=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> This series adds a multi-queue aware variant of the sch_cake scheduler,
> called 'cake_mq'. Using this makes it possible to scale the rate shaper
> of sch_cake across multiple CPUs, while still enforcing a single global
> rate on the interface.
>
> The approach taken in this patch series is to implement a separate qdisc
> called 'cake_mq', which is based on the existing 'mq' qdisc, but differs
> in a couple of aspects:
>
> - It will always install a cake instance on each hardware queue (instead
>   of using the default qdisc for each queue like 'mq' does).
>
> - The cake instances on the queues will share their configuration, which
>   can only be modified through the parent cake_mq instance.
>
> Doing things this way does incur a bit of code duplication (reusing the
> 'mq' qdisc code), but it simplifies user configuration by centralising
> all configuration through the cake_mq qdisc (which also serves as an
> obvious way of opting into the multi-queue aware behaviour).
>
> The cake_mq qdisc takes all the same configuration parameters as the
> cake qdisc, plus on additional parameter to control the sync time
> between the individual cake instances.
>
> We are posting this series to solicit feedback on the API, as well as
> wider testing of the multi-core shaper.
>
> An earlier version of this work was presented at this year's Netdevconf:
> https://netdevconf.info/0x19/sessions/talk/mq-cake-scaling-software-rate-=
limiting-across-cpu-cores.html
>
> The patch series is structured as follows:
>
> - Patch 1 factors out the sch_cake configuration variables into a
>   separate struct that can be shared between instances.
>
> - Patch 2 adds the basic cake_mq qdisc, based on the mq code
>
> - Patch 3 adds configuration sharing across the cake instances installed
>   under cake_mq
>
> - Patch 4 adds the shared shaper state that enables the multi-core rate
>   shaping
>
> A patch to iproute2 to make it aware of the cake_mq qdisc is included as
> a separate patch as part of this series.
>

For this version of the patchset
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

Q: Does Eric's riddance of busylock help?

cheers,
jamal
> ---
> Jonas K=C3=B6ppeler (1):
>       net/sched: sch_cake: share shaper state across sub-instances of cak=
e_mq
>
> Toke H=C3=B8iland-J=C3=B8rgensen (3):
>       net/sched: sch_cake: Factor out config variables into separate stru=
ct
>       net/sched: sch_cake: Add cake_mq qdisc for using cake on mq devices
>       net/sched: sch_cake: Share config across cake_mq sub-qdiscs
>
>  include/uapi/linux/pkt_sched.h |   2 +
>  net/sched/sch_cake.c           | 635 +++++++++++++++++++++++++++++++++--=
------
>  2 files changed, 514 insertions(+), 123 deletions(-)
> ---
> base-commit: dc1dea796b197aba2c3cae25bfef45f4b3ad46fe
> change-id: 20250902-mq-cake-sub-qdisc-cdf0b59d2fe5
>

