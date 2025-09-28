Return-Path: <netdev+bounces-226976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18316BA6BBD
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 10:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF5B3A20F6
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 08:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7B829B77E;
	Sun, 28 Sep 2025 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wtQCWUcX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D3186329
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759049115; cv=none; b=QCmim62JC9a/6/0aErHEzNfQvymKLv4YDHrtd+i/769BDuuhBxEie4BK3xvwRsLO7YxbwY8RYBbgExcJbwkTOy2HoFPUpsee0C/Fh476bXP2UycjeSK+jkQg2F4/jQE8Yzl5s8DnlpEdPXhKe/UQYejWTsHoCS4mlBbILHYFx2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759049115; c=relaxed/simple;
	bh=j4xe7ngKRRI3HhnwZ/3EYy6CJE5z79oU4vLUZCh2+8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHF9/cYtieZgzJIftG37CP3KNOmGWsh6GRnrHHRcVAbxGwpmK8tV9qIwgWdVyplYr45PgukgZuPxvzAzdv10HBftiMPRnj4cCZPBGKZLbgG/aeAsL1TJRjQciR2pWptNUvY9QL2vd+dnPTOSXEkFik20ZVS8SE1RjWwvh+pv/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wtQCWUcX; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4d9f38478e0so33167011cf.1
        for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 01:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759049112; x=1759653912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4xe7ngKRRI3HhnwZ/3EYy6CJE5z79oU4vLUZCh2+8U=;
        b=wtQCWUcX3IJkVM6ojZWF3EwNWl3dskYyT6LCDGDUuq8n2yNYOOMgARvHy0KrupyqXw
         TqWTfmQJeMNzhSJzai1FEqLpawUA+klD6/D/h7gGVww1Eai7KyZZRtW20lb2WbpAqzEC
         DdWkFdN8ul2yocngIAGypwH2GWLjkv5cmwEW94gfEh8Wh5+KWd89mB3Jv9uPRIxiVkb3
         u+JJNxuff0tlfEPBWqn2fBN/vR+DlbLDlfpaCA1U/5M3/hASxH3KVN+7a5M7slWlNcxc
         eOyHR9eVEuY7y4m0g3U7oni0WA4vjzImKXN0E/iMB8jl0J3eKNrVgTSKLvr+OcyRQ7qk
         7ACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759049112; x=1759653912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4xe7ngKRRI3HhnwZ/3EYy6CJE5z79oU4vLUZCh2+8U=;
        b=KnL/RJ1/eZJTYNi+nbOi53mtFgRkkfkacMtXfy9EA8J3UaHpsqEH9rKrHfYTwXFtZo
         9AZuExNB9n6TZND3iZZJehIkB+63FxHKRNMXrG1VaNkApKZY5d6cfnBI86/faZMCQgXO
         EtmNuFILNDKQ6/IDeRtfdTJYab5eAV/rXG2WE1mL97b+RYcBpinanS3gMw1RG425+WS8
         FDWVFIvikjMsLjR3InIf8FCsEfsAPxcu2pRXMxxPsvaCnGY6trss3TPvPjoUwPRx3T6U
         rWkexBpfEKP6beIm9mAkWh/QoLGKV5fDe7Lb8bpbPfu21xMdDkaYPsNyY+cdul/YEVKa
         vOkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSop8JtwmTr9TrI4OK0yCrSHDTH7+6PAd8GO8ZpBAIiCXTZx1Hh9kWhbQrbTzbIIIxjF5P5AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOCNO2slAzIkXFOC2wfC7pOAqQbiJwr60bbd3YeLpK55kBLVxf
	ybNwHUcookt8LjgL0Q11lnyfv0pwlomDuoGYMULsl3MmyXLhn+tyqR7CXp/f/He77xI1GN94w4A
	ouLdkIhV3Xubze9Ytlm7OLbIE9y9Zj2KB7FRHSuSt
X-Gm-Gg: ASbGncuGD4xHGYdn+sc860BM+5hrqeaDqmpZkjrFBhePtGYa3qh6Nl5KmNkME/gRylr
	TyU70KIxu9vZFAt7cgP+l+MhKc0siOIbHNKECx/GZ2G4lA2Js1C1XopkjEr0E5wNluWWCWhPXLP
	ItpZz0WTRhMVpomXLHiUFz5AW77DLrB2gUjmI8/BGDi2FTJhmchz6dVeVHRyUYLq3Km8eWgFNvM
	1L0K5jxYwn/2odlCA==
X-Google-Smtp-Source: AGHT+IG+KeO4G3gXdiUE7ly7J6qfgpI6jzYYgW4C932CFsk5+KDw7Q5B/BQo6CCkd2GmCV8ddYIXPxLEdXrihv+ZceI=
X-Received: by 2002:ac8:58c8:0:b0:4b7:8b67:edb9 with SMTP id
 d75a77b69052e-4dacd5261fdmr157649141cf.26.1759049112117; Sun, 28 Sep 2025
 01:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926151304.1897276-1-edumazet@google.com> <20250926151304.1897276-4-edumazet@google.com>
 <CAAVpQUDiGuCtUzXeJw0004VxDHFketF7J+Xu6tqEod_o=3r7Kg@mail.gmail.com>
In-Reply-To: <CAAVpQUDiGuCtUzXeJw0004VxDHFketF7J+Xu6tqEod_o=3r7Kg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 28 Sep 2025 01:45:00 -0700
X-Gm-Features: AS18NWBisJx1VR2RhverWDLVFmdnvTW6irtx8ZNUcQGSN-jXCoHiuVXkVCI2owQ
Message-ID: <CANn89iJ9=dv2=itEKAyhBVY6edkYRLCuGLbgt_vMNpohNU00rQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: add NUMA awareness to skb_attempt_defer_free()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 1:28=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Fri, Sep 26, 2025 at 8:13=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > Instead of sharing sd->defer_list & sd->defer_count with
> > many cpus, add one pair for each NUMA node.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>

> > -static void skb_defer_free_flush(struct softnet_data *sd)
> > +struct skb_defer_node __percpu *skb_defer_nodes;
>
> seems this is unused, given it's close to the end of cycle
> maybe this can be fixed up while applying ? :)

Good catch, I moved it to net_hotdata but forgot to remove this leftover.

Will send a V2.

Thanks.

