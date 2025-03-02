Return-Path: <netdev+bounces-170999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAEEA4B0BD
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 09:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B6416B0DD
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 08:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EE71CAA99;
	Sun,  2 Mar 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsVkSdHL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD817C210
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740905801; cv=none; b=nfkSY+G0Vthg43bhImGEYp66/2J2PVE5WtaVCq/+nhUaKPEZG8dc94n6Y3LeICvphLrpll03tST3U53avZCf4ogNGNpFRnVWqYL9UqZAC3oBthwWeGeffNrmjH+M9Yp9txYGWfeUhDQJEAjOFrSsGu2zxTXeGpT7pxNeOq7I9as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740905801; c=relaxed/simple;
	bh=WFX4BO4jjAI/7v7avdBoOaDes7s8A6WEwaMvJI9/zJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zc4dmu5KNyPIf1X/+GGplGZf7c6LnI8mUovi1SQ+nZUqFbbSfAJzLi1APVEzWqCxWQi5CfXXHT6Z/R6hKHGCiqiXFq7HVJqNuUly6HHd/v5RWAcT/VcOKMC/Pa895arHAw5HwXdZmP0qE0V1aI4aI9VRG35Nqbk2Nl4rMJHvvMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsVkSdHL; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d04932a36cso36787225ab.1
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 00:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740905799; x=1741510599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFX4BO4jjAI/7v7avdBoOaDes7s8A6WEwaMvJI9/zJ8=;
        b=bsVkSdHLYts2/VQ+ZDuh3dX4md43uCm+x3vps32S+lIZWzEmqmvacrQZKWt11cREBo
         jCoBvDOdzHZW+ZbvdKzvYnn9ie6T2eDRAACA2srTbKLPtFAGxt2bPKnd894iglcOMrlP
         4TZjl3q5Pg3BMrm9729b5S9ouj9/RkhEBcH+naSzUjTF/hPzOXBVVPO7ohPpXOxEzQDD
         ZzXnxjFsEU74hFrSAMQ7nauZlXnzjDArUIs/tDFq6JdEzvA2aoee8T3VeD3fMP/xQ8kU
         Idrl9nEpXhvWbBl+rbgmXxOEXSOxf7XS59zea/2RAO7Vcr9kL4Wgrb1XbV2Oc5lgLTdI
         5LHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740905799; x=1741510599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFX4BO4jjAI/7v7avdBoOaDes7s8A6WEwaMvJI9/zJ8=;
        b=ZgX4xSPAgWuNr6Ru9IWSGV88EapT9Pisglm4TL1I7AeKN5gb5WYfRiogQlF0oGWkMb
         On/YmJ/eT0pqGpmjmx5dfYhNpr7UAgw5dukQA3ebVc8vm7cg8lbxZEipVfhkhA/XdLX2
         OgwQpXdYv6Uwxbc4NF4AFQzjjUL6ry9SJ5caSWr9E0sOIcFXwHq/A3G/tWYorfcCg+ui
         2k5cops7wWBMIm+zKJYU92GexQCAuStqDnMRJiayeHyxkn9DBCa14qmVcbdtiXEWx1KY
         yssiONLBzioOQv0xTsTNmF+y9z6xvHNk+g2PCBKUj3MS+EC4Ma5KGUpwquBpp0QA3vQa
         SWeA==
X-Forwarded-Encrypted: i=1; AJvYcCWoBif42vB/MjRheiH02g1oUKK3rB7A4uUpfkfPIke3JdHocUU/iXcPArZbc6cfeiZevURUGcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyvzyiAUvsRcUHjSlX+1aD8ltff9vZ65a7EHx6ECpNErri/k3
	+q9k/OVKwYzBzvd2ZYdIEE6OJid0xMJ3i5unSt4JTdPHex5DYI73NCs1rc/TvEghnHmQYs3U6bK
	5TB7A+syaDn9hRLI2rKf5VasMRPA=
X-Gm-Gg: ASbGncspSSw4Uo1li4Mm7jomT7iQzkyvP26/eNhTuUVIZiqtj3SVaKZeCHdp6hA0tQ1
	792HbY9mdC505UfrVGE8sYHQv/y96nPnSfKRyD/iksyz6YXmyMs5hHKLAh179jDsRLHNRNTYt/e
	ZmOBJJCwrkv5R5RKXpPP8mwPad
X-Google-Smtp-Source: AGHT+IGwMsRmde7U2bYuwbVlyqsfHPtVNBhxrdU1wEL1tgyLUKRfj49Ta3OeaSewm4cfHhbBxjZBfFaY1a5wvR4xuMY=
X-Received: by 2002:a05:6e02:2142:b0:3d3:d2b9:6ae6 with SMTP id
 e9e14a558f8ab-3d3e6e421d3mr90819785ab.5.1740905799026; Sun, 02 Mar 2025
 00:56:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301194624.1879919-1-edumazet@google.com> <CAL+tcoAY1xKgdFzQDcU4LJ7wEZ7oFSaY_aqwtiw4MV-W1RMBWg@mail.gmail.com>
 <CANn89iLpVW5bs7y8Hr5b07_7CAV2XkOgC9E7goCWpjCaiEKj6A@mail.gmail.com>
In-Reply-To: <CANn89iLpVW5bs7y8Hr5b07_7CAV2XkOgC9E7goCWpjCaiEKj6A@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 2 Mar 2025 16:56:02 +0800
X-Gm-Features: AQ5f1JrTCeEUlVOJPJhCTVjOKH8iLxTCTqEn_BxjO3A3xUQH538LEfncp8-3mUU
Message-ID: <CAL+tcoBCo9r2eK5juV6Vb2WXdj6UnSCMDxc7QbpJSpHZOPJ0ng@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: use RCU in __inet{6}_check_established()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 3:11=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Sun, Mar 2, 2025 at 1:17=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Sun, Mar 2, 2025 at 3:46=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > When __inet_hash_connect() has to try many 4-tuples before
> > > finding an available one, we see a high spinlock cost from
> > > __inet_check_established() and/or __inet6_check_established().
> > >
> > > This patch adds an RCU lookup to avoid the spinlock
> > > acquisition if the 4-tuple is found in the hash table.
> > >
> > > Note that there are still spin_lock_bh() calls in
> > > __inet_hash_connect() to protect inet_bind_hashbucket,
> > > this will be fixed in a future patch.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> >
> > It can introduce extra system overhead in most cases because it takes
> > effect only when the socket is not unique in the hash table. I'm not
> > sure what the probability of seeing this case is in reality in
> > general. Considering performing a look-up seems not to consume much, I
> > think it looks good to me. Well, it's the only one I'm a bit worried
> > about.
> >
> > As you said, it truly mitigates the huge contention in the earlier
> > mentioned case where the available port resources are becoming rare.
> > We've encountered this situation causing high cpu load before. Thanks
> > for the optimization!
>
> Addition of bhash2 in 6.1 added a major regression.
>
> This is the reason I started to work on this stuff.
> I will send the whole series later today, but I get a ~200% increase
> in performance.
> I will provide numbers in the cover letter.
>
> neper/tcp_crr can be used to measure the gains.
>
> Both server/client have 240 cores, 480 hyperthreads (Intel(R) Xeon(R) 698=
5P-C)
>
> Server
> ulimit -n 40000; neper/tcp_crr -6 -T200 -F20000 --nolog
>
> Client
> ulimit -n 40000; neper/tcp_crr -6 -T200 -F20000 --nolog -c -H server
>
> Before this first patch:
>
> utime_start=3D0.210641
> utime_end=3D1.704755
> stime_start=3D11.842697
> stime_end=3D1997.341498
> nvcsw_start=3D18518
> nvcsw_end=3D18672
> nivcsw_start=3D26
> nivcsw_end=3D14828
> num_transactions=3D615906
> latency_min=3D0.051826868
> latency_max=3D12.015396087
> latency_mean=3D0.642949344
> latency_stddev=3D1.860316922
> num_samples=3D207534
> correlation_coefficient=3D1.00
> throughput=3D62524.04
>
> After this patch:
>
> utime_start=3D0.185656
> utime_end=3D2.436602
> stime_start=3D11.470889
> stime_end=3D1980.679087
> nvcsw_start=3D17327
> nvcsw_end=3D17514
> nivcsw_start=3D48
> nivcsw_end=3D77724
> num_transactions=3D821025
> latency_min=3D0.025097789
> latency_max=3D11.581610596
> latency_mean=3D0.475903462
> latency_stddev=3D1.597439931
> num_samples=3D206556
> time_end=3D173.321207377
> correlation_coefficient=3D1.00
> throughput=3D84387.19

Amazing! Thanks for the work and looking forward to your series then!

Thanks,
Jason

