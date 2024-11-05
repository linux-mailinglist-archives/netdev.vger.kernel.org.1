Return-Path: <netdev+bounces-142075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160C49BD481
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 19:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF536283D13
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85B81E7C15;
	Tue,  5 Nov 2024 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MniP+vPb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F79D1E766D
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831197; cv=none; b=hJMVsmtuvSdC5EcKeU00pt8itSIupF2ljLuBJMV13lvjxwPTjw9Y91FyiRJcxV/B946ye8VA06Le5coFPgRXlZGARe3M62ytraX9tsytUKMEtyO5PrSq/U+YzNeJ+zYXAi8Ij0gQYxolyC5v1o+xACUwQWUPdtYRDZDgOxKgGz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831197; c=relaxed/simple;
	bh=InNb+gvCNdcZrQhUZ8Q0bdT8EJmEYOXNE47Yzq/pXwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nglLAaxEJMkOldAkFoE9I0ZElmL5/zl7cVQ8cszDiToV1zm9aX9kR3anxyTI+T96eH7BT5tAOtWEONyRiZSDsUOryBXz2W2dfuO//7/Y/yVDIQDDkPUzc86JQbAKMukVCsYaKcRd3YIjjP8VC70sR9JDrqzEa0ndruufxNcRk5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MniP+vPb; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so55909641fa.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 10:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730831194; x=1731435994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtwNsdBCOe3/0ExpsXgR3R2fFtQXRWHEi3Sx3VDeZDc=;
        b=MniP+vPbXf1OAIrS5zNv9cWZ4Y849VY0bRj5ck/mAY5wLoAMdDn6xCureNgrvQPmAl
         +/W4GMQpBsTp52JzYIE6HgFLgdBhhOBjalUZuXEWoZwOEH+J+RfrtekWtJqm9C+wT2fh
         HCHnx0ChWz4tuLpfzruTM25Dz9ph3pxkbdbbEDh+abJtllsJ7LlWLLFtFtegQOgY8TEj
         MDDzkYNJVyvoSiNlu4nNuqrwFzwvbdg7MhfJW8k+N4DX8pE9ZCqEdzHRVHmRdK0Vj2F5
         x0EkAcIhrJIBXiv8Ov9uxA61CfolTfuRidLCtHCHWW1o5Hp+3QUXB7yZQ9L8fpZw6jah
         gihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730831194; x=1731435994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtwNsdBCOe3/0ExpsXgR3R2fFtQXRWHEi3Sx3VDeZDc=;
        b=EbIwj+wd57i7DgqXeq2fySbLiz1es6bgn1xa5l0N6dfdGKo5IUxXJc13Zbffja1llb
         BMmeLOZ1IWmzZBdZBoEBaCo8DVlQGy6bJTAZ1gRkbe0wwwjEDj5h8upDBKqvggCqSykk
         y+Np1rFjtWYP0y1ipteLtDVlTbTeGdVCQcDK8MAeyRw/uHXzAF2qj/2V6X+mQaixCkMl
         watV7qsctzvsKnweg+1RwiYK6+QKHT0Yh0b+73N4g3TohOrf9qPsIQEJIBchMaC9mOmC
         XmGCya/VgJVLBxRWiyawUBOsyrDSQ3SpjQkeJKo3W70PIrr89JZ6HLudGzSGKujXdjLF
         fmcQ==
X-Gm-Message-State: AOJu0YzoBLS3QEgLRgpE5/p/Uzc6m3kd9+C4WslP5o0rWiYHVVLD52UV
	ozmMrktW2iJYXieo+5oUMWl2m2NlIAlqoGMPA20Kc8UYTBScMXdO9IyRR6yhtTRrnQvzMQD8JCL
	I5/PlrGXF18YxHBPrxkiq94tIVnZlmIR0Sn35
X-Google-Smtp-Source: AGHT+IGHDZwYCo9e2i9ftI6T+IxPBOF5KQieEjlpU7qjlPpJDAqnmzcoibV5P3fhRr+cF2QpA3e1GyuvujT0POk2djU=
X-Received: by 2002:a05:651c:2226:b0:2f6:62a1:25fe with SMTP id
 38308e7fff4ca-2fd05950a40mr129394411fa.23.1730831193905; Tue, 05 Nov 2024
 10:26:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730828007.git.pabeni@redhat.com> <604c45c188c609b732286b47ac2a451a40f6cf6d.1730828007.git.pabeni@redhat.com>
In-Reply-To: <604c45c188c609b732286b47ac2a451a40f6cf6d.1730828007.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Nov 2024 19:26:22 +0100
Message-ID: <CANn89iJurbGWxN0Sbsh6XB7F6aYTmSPTa7LuaEDxVmCGs4wVgw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/2] ipv6: release nexthop on device removal
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 7:24=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> The CI is hitting some aperiodic hangup at device removal time in the
> pmtu.sh self-test:
>
> unregister_netdevice: waiting for veth_A-R1 to become free. Usage count =
=3D 6
> ref_tracker: veth_A-R1@ffff888013df15d8 has 1/5 users at
>         dst_init+0x84/0x4a0
>         dst_alloc+0x97/0x150
>         ip6_dst_alloc+0x23/0x90
>         ip6_rt_pcpu_alloc+0x1e6/0x520
>         ip6_pol_route+0x56f/0x840
>         fib6_rule_lookup+0x334/0x630
>         ip6_route_output_flags+0x259/0x480
>         ip6_dst_lookup_tail.constprop.0+0x5c2/0x940
>         ip6_dst_lookup_flow+0x88/0x190
>         udp_tunnel6_dst_lookup+0x2a7/0x4c0
>         vxlan_xmit_one+0xbde/0x4a50 [vxlan]
>         vxlan_xmit+0x9ad/0xf20 [vxlan]
>         dev_hard_start_xmit+0x10e/0x360
>         __dev_queue_xmit+0xf95/0x18c0
>         arp_solicit+0x4a2/0xe00
>         neigh_probe+0xaa/0xf0
>
> While the first suspect is the dst_cache, explicitly tracking the dst
> owing the last device reference via probes proved such dst is held by
> the nexthop in the originating fib6_info.
>
> Similar to commit f5b51fe804ec ("ipv6: route: purge exception on
> removal"), we need to explicitly release the originating fib info when
> disconnecting a to-be-removed device from a live ipv6 dst: move the
> fib6_info cleanup into ip6_dst_ifdown().
>
> Tested running:
>
> ./pmtu.sh cleanup_ipv6_exception
>
> in a tight loop for more than 400 iterations with no spat, running an
> unpatched kernel  I observed a splat every ~10 iterations.
>
> Fixes: f88d8ea67fbd ("ipv6: Plumb support for nexthop object in a fib6_in=
fo")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thanks a lot Paolo

Reviewed-by: Eric Dumazet <edumazet@google.com>

