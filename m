Return-Path: <netdev+bounces-119314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2256C95523C
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559D51C214D2
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E141B81AD7;
	Fri, 16 Aug 2024 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoVs/sRx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1EB26AFC
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 21:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723842543; cv=none; b=mys7SvQFryY9SHR7Ez/0eBS5BGlUsijnd2+Cc1VhO4z3m8BGBZDgUYwAUY5YHrvDWPaXyafXvPQoRhJ5nR1dSUT12EBDsScsy1bJ8hmpfwLMDatqsPwJT3ezSfEF6TVMyShPiS4U73Wq1d7ENxG/2Vbaf1mAWDQVH+reMmUsNpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723842543; c=relaxed/simple;
	bh=cTCUYEdVpmCrP+BPeuP75Hq2tLdbhIV/o7BGGVdbm2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X2OAC70XdOwgP0HXzLUUF/qB14Qbq6DJctA1qe4P9W+hQbvgJBZFM/NN168uo9ekw0e8xr5qlvb5ysjGUSDb7mNzqcz8tzxcB8NW3i+AGSWLxgIkWOkWQxmYfw8a1VAcPlEfLNh04DVs9Ts3JIi72wKVZ0sqPKcJVL8eQaznPe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoVs/sRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DE6C32782;
	Fri, 16 Aug 2024 21:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723842543;
	bh=cTCUYEdVpmCrP+BPeuP75Hq2tLdbhIV/o7BGGVdbm2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OoVs/sRxRg/vrgwQeAeAYuEjkyFyURBPJyjVB5/qRmfGryfNwEathqYuygl3ANNWY
	 CEk/cUp+XNRIsX9s5TfWz23MdRNr50KlpyGPoKK/98zgfLe6wd7FU++RA3qJh5oAy0
	 yIeL70G/AsdFN7ws7P8ksGe0MN5SgctOEgPqu588xp9gC/QTnjxMGFWDzXnGuucSAo
	 HA/wDDl4o3IZR+MqkL9Z8bqsObiI+IstlVjAYnnZeMpjEeFhgbxHj6qMtIdx8n8iLh
	 En7x6wK902Bwf4qqKb0epJRO6I22P56/HAW6mYhH+waccXOF2pc3CacI2Ty9KVll3s
	 5SmbsbbNJhgNQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 31CDC14AE0FD; Fri, 16 Aug 2024 23:09:00 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Duan Jiong <djduanjiong@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3] veth: Drop MTU check when forwarding packets
In-Reply-To: <CALttK1TWBeZWDwHoW9q6qkT6=XT4EmZM1ZbK3KtKSXR-ZcAFeA@mail.gmail.com>
References: <20240808070428.13643-1-djduanjiong@gmail.com>
 <87v80bpdv9.fsf@toke.dk>
 <CALttK1RsDvuhdroqo_eaJevARhekYLKnuk9t8TkM5Tg+iWfvDQ@mail.gmail.com>
 <87mslnpb5r.fsf@toke.dk> <00f872ac-4f59-4857-9c50-2d87ed860d4f@Spark>
 <87h6bvp5ha.fsf@toke.dk>
 <66b51e9aebd07_39ab9f294e6@willemb.c.googlers.com.notmuch>
 <87seveownu.fsf@toke.dk>
 <CALttK1Qe-25JNwOmrhuVv3bbEZ=7-SNJgq_X+gB9e4BfzLLnXA@mail.gmail.com>
 <87frr8wt03.fsf@toke.dk>
 <CALttK1TWBeZWDwHoW9q6qkT6=XT4EmZM1ZbK3KtKSXR-ZcAFeA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 16 Aug 2024 23:09:00 +0200
Message-ID: <87h6bkb2fn.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Duan Jiong <djduanjiong@gmail.com> writes:

> On Tue, Aug 13, 2024 at 7:40=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@kernel.org> wrote:
>>
>> Duan Jiong <djduanjiong@gmail.com> writes:
>>
>> >> >
>> >
>> > vm1(mtu 1600)---ovs---ipsec vpn1(mtu 1500)---ipsec vpn2(mtu
>> > 1500)---ovs---vm2(mtu 1600)
>>
>> Where's the veth device in this setup?
>>
>
> The veth device is used for ipsec vpn containers to connect to ovs, and
> traffic before and after esp encapsulation goes to this NIC.
>
>
>> > My scenario is that two vms are communicating via ipsec vpn gateway,
>> > the two vpn gateways are interconnected via public network, the vpn
>> > gateway has only one NIC, single arm mode. vpn gateway mtu will be
>> > 1500 in general, but the packets sent by the vm's to the vpn gateway
>> > may be more than 1500, and at this time, if implemented according to
>> > the existing veth driver, the packets sent by the vm's will be
>> > discarded. If allowed to receive large packets, the vpn gateway can
>> > actually accept large packets then esp encapsulate them and then
>> > fragment so that in the end it doesn't affect the connectivity of the
>> > network.
>>
>> I'm not sure I quite get the setup; it sounds like you want a subset of
>> the traffic to adhere to one MTU, and another subset to adhere to a
>> different MTU, on the same interface? Could you not divide the traffic
>> over two different interfaces (with different MTUs) instead?
>>
>
> This is indeed a viable option, but it's not easy to change our own
> implementation right now, so we're just seeing if it's feasible to skip
> the veth mtu check.

Hmm, well, that basically means asking the kernel community to take on
an extra maintenance burden so that you won't have to do that yourself.
And since there's a workaround, my inclination would be to say that the
use case is not sufficiently compelling that it's worth doing so.

However, I don't feel that strongly about it, and if others think it's
worth adding a knob to disable the MTU check on forward, I won't object.

-Toke

