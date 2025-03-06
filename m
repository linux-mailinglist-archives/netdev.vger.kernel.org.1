Return-Path: <netdev+bounces-172546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3829A55559
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2582016EAC1
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 18:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D1525A2B5;
	Thu,  6 Mar 2025 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3eiXSf6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE9EB667
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287048; cv=none; b=N9q5XeEVLEg7JrSnvDgv2+5BmPC6trC+YMEkOTT115Xjka0XNoCYaIlaLIOnow+hFf0FDeABx7tJYv7/PMwIVcNzFICIQxUtW7ANbHSWIEvnVy6heSnY3amQ0KY9aKJEvBJSCRjypPDXUnp+C1julZ634aWAaV7nwOj/PTGuWvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287048; c=relaxed/simple;
	bh=hziwIFH8GqcTvGzzZypfshMXMU+Bp15ehcSnnNIyJR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ym/nXJ/qBVmU4sRm5TaOt/19Qp53SgQfhO23Wmg7VrPkTigTqwI78TB3N/vrFJOnbW30I0eT/gIpwxxZYXYAkEK+X5IjL69/boaqmp+XZa8Pmj70XdJXih+NT4oIWdyRXGulLuvdrCAuYMSZ4ilBBSgZ3nHZPbicNRlX0l09uoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3eiXSf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F09C4CEE4;
	Thu,  6 Mar 2025 18:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741287047;
	bh=hziwIFH8GqcTvGzzZypfshMXMU+Bp15ehcSnnNIyJR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G3eiXSf6dibM1+ant550/UzWuJEipRByfffjg+hJxS7fkDvCtlfE/hF0MJQ/5YMtW
	 Wmq3LAhL+W8BslNp/td77V0qIDeY3nTyCrTc5dkYO43qvcrZOo6m8yf+rXJrQos6aK
	 +NzcHXjqP/1bLiWD54Opi/Fz2007tTEplQYC0aLT6nIx8RCzKeTLCX/XI9NRqVINfq
	 H/n5iKGwFNByV58WhbMA1LayK2hp7Mq0ck2CvoX3IF5ggPXc3V+CSb1c5tunD6AY3e
	 Q8gNJumTZqPx3g73D/dsf8BA56C/kPUqt+YzmFi4vFht03rxLyW07uMzWXZBlqFerS
	 6+LOaz6pu/niQ==
Date: Thu, 6 Mar 2025 10:50:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, David
 Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next 0/2] udp_tunnel: GRO optimizations
Message-ID: <20250306105046.0aca16b3@kernel.org>
In-Reply-To: <cover.1741275846.git.pabeni@redhat.com>
References: <cover.1741275846.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  6 Mar 2025 16:56:51 +0100 Paolo Abeni wrote:
> The UDP tunnel GRO stage is source of measurable overhead for workload
> based on UDP-encapsulated traffic: each incoming packets requires a full
> UDP socket lookup and an indirect call.
>=20
> In the most common setups a single UDP tunnel device is used. In such
> case we can optimize both the lookup and the indirect call.
>=20
> Patch 1 tracks per netns the active UDP tunnels and replaces the socket
> lookup with a single destination port comparison when possible.
>=20
> Patch 2 tracks the different types of UDP tunnels and replaces the
> indirect call with a static one when there is a single UDP tunnel type
> active.
>=20
> I measure ~5% performance improvement in TCP over UDP tunnel stream
> tests on top of this series.

Breaks the build with NET_UDP_TUNNEL=3Dn (in contest) :(

net/ipv4/udp_offload.c: In function =E2=80=98udp_tunnel_gro_rcv=E2=80=99:
net/ipv4/udp_offload.c:172:16: error: returning =E2=80=98struct sk_buff *=
=E2=80=99 from a function with incompatible return type =E2=80=98struct skb=
uff *=E2=80=99 [-Werror=3Dincompatible-pointer-types]
  172 |         return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, hea=
d, skb);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
net/ipv4/udp_offload.c: In function =E2=80=98udp_gro_receive=E2=80=99:
net/ipv4/udp_offload.c:786:12: error: assignment to =E2=80=98struct sk_buff=
 *=E2=80=99 from incompatible pointer type =E2=80=98struct skbuff *=E2=80=
=99 [-Werror=3Dincompatible-pointer-types]
  786 |         pp =3D udp_tunnel_gro_rcv(sk, head, skb);
      |            ^
In file included from ./include/linux/seqlock.h:19,
                 from ./include/linux/dcache.h:11,
                 from ./include/linux/fs.h:8,
                 from ./include/linux/highmem.h:5,
                 from ./include/linux/bvec.h:10,
                 from ./include/linux/skbuff.h:17,
                 from net/ipv4/udp_offload.c:9:
net/ipv4/udp_offload.c: In function =E2=80=98udpv4_offload_init=E2=80=99:
net/ipv4/udp_offload.c:936:21: error: =E2=80=98udp_tunnel_gro_type_lock=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98udp_t=
unnel_gro_rcv=E2=80=99?
  936 |         mutex_init(&udp_tunnel_gro_type_lock);
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/mutex.h:64:23: note: in definition of macro =E2=80=98mutex_=
init=E2=80=99
   64 |         __mutex_init((mutex), #mutex, &__key);                     =
     \
      |                       ^~~~~
net/ipv4/udp_offload.c:936:21: note: each undeclared identifier is reported=
 only once for each function it appears in
  936 |         mutex_init(&udp_tunnel_gro_type_lock);
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/mutex.h:64:23: note: in definition of macro =E2=80=98mutex_=
init=E2=80=99
   64 |         __mutex_init((mutex), #mutex, &__key);                     =
     \
      |                       ^~~~~
cc1: all warnings being treated as errors
--=20
pw-bot: cr

