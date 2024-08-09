Return-Path: <netdev+bounces-117143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E8694CDB3
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0F3284D7C
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 09:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBB51991DC;
	Fri,  9 Aug 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmhE7PPL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387311991D9
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196840; cv=none; b=eMhCD/QcHJWHT2K8WO2l3pBBLsPFR7+4imjxtb7secW6kqus80JQQegQ+hH8bCavH2hwxjoZVm4PHswQF6RzbLbHJV817nH0E5MC34E3D6ehnt0YSCJoksjVG5dW0daByZ9wrkXz/A9VpjekFN/7rQd6MWShT+MNQAkIMrEq7tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196840; c=relaxed/simple;
	bh=BdYw+LHFjtkUvwFB2WBbiwlWiYYIE3knhdZr8o3sUtQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TPyghmxXGE7ewoT+t8rqq/YqXe2P6z8bIv2UYr4UZDc9AmQYVVbA9GeoAKIl2RV1twM+W3FBbJSl7jwV8gV0ZjNLhPPpkL1gKfGzxH1s7Vvhq0UQM1llbSgh7h/HYhFHJW91P3nANeNEitCpv2rZ/KO7MhzeLsp9koS5oN7xano=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmhE7PPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00B3C32782;
	Fri,  9 Aug 2024 09:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723196839;
	bh=BdYw+LHFjtkUvwFB2WBbiwlWiYYIE3knhdZr8o3sUtQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XmhE7PPL5QMJYJ7Pxb1ZbOte92YXi45daezweCRTRcbCUpK0xx/wV8WLlsuZZ+ko3
	 ze1QQdJHBwpPPgnldaIUdF9aGWRN9MZuhU6ysV6VPrdQ/e193xoD7ZE6BPt1xSqExZ
	 y2OnPBCPU644uyoLl43Xuofg058dnLzmaaqXgD//t8hsFFT8Pi+JDq0wJUhw9blWiD
	 evkARekTn9Mg5/D8rHhxEAN8mOg1dLDhjF7iHhZE/G/zldDd25M8OQNHz16hYy/Pdi
	 0jUu+p5egvaPmKwdyFA0xILXqS1ZUSrSizHZxwqU6jsn+i7I5IJAx/rRZMjt2ZDQ1b
	 Wy9I0afP0grhg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4722C14ADA25; Fri, 09 Aug 2024 11:47:17 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, djduanjiong@gmail.com
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v3] veth: Drop MTU check when forwarding packets
In-Reply-To: <66b51e9aebd07_39ab9f294e6@willemb.c.googlers.com.notmuch>
References: <20240808070428.13643-1-djduanjiong@gmail.com>
 <87v80bpdv9.fsf@toke.dk>
 <CALttK1RsDvuhdroqo_eaJevARhekYLKnuk9t8TkM5Tg+iWfvDQ@mail.gmail.com>
 <87mslnpb5r.fsf@toke.dk> <00f872ac-4f59-4857-9c50-2d87ed860d4f@Spark>
 <87h6bvp5ha.fsf@toke.dk>
 <66b51e9aebd07_39ab9f294e6@willemb.c.googlers.com.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 09 Aug 2024 11:47:17 +0200
Message-ID: <87seveownu.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> djduanjiong@gmail.com writes:
>>=20
>> > This is similar to a virtual machine that receives packets larger than
>> > its own mtu, regardless of the mtu configured in the guest.=C2=A0=C2=
=A0Or, to
>> > put it another way, what are the negative effects of this change?
>>=20
>> Well, it's changing long-standing behaviour (the MTU check has been
>> there throughout the history of veth). Changing it will mean that
>> applications that set the MTU and rely on the fact that they will never
>> receive packets higher than the MTU, will potentially break in
>> interesting ways.
>
> That this works is very veth specific, though?
>
> In general this max *transfer* unit configuration makes no assurances
> on the size of packets arriving. Though posted rx buffer size does,
> for which veth has no equivalent.

Well, in practice we do use the MTU to limit the RX size as well. See
for instance the limit on MTU sizes if an XDP program without
multibuffer support is loaded. And I don't think having an asymmetric
MTU setting on a physical point-to-point Ethernet link generally works
either. So in that sense it does make sense that veth has this
limitation, given that it's basically emulating an ethernet wire.

I do see your point that a virtual device doesn't really *have* to
respect MTU, though. So if we were implementing a new driver this
argument would be a lot easier to make. In fact, AFAICT the newer netkit
driver doesn't check the MTU setting before forwarding, so there's
already some inconsistency there.

>> You still haven't answered what's keeping you from setting the MTU
>> correctly on the veth devices you're using?
>
> Agreed that it has a risk, so some justification is in order. Similar
> to how commit 5f7d57280c19 (" bpf: Drop MTU check when doing TC-BPF
> redirect to ingress") addressed a specific need.

Exactly :)

And cf the above, using netkit may be an alternative that doesn't carry
this risk (assuming that's compatible with the use case).

-Toke

