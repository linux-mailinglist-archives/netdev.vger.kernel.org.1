Return-Path: <netdev+bounces-118007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DC79503E9
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2AD1F23C01
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256471990D6;
	Tue, 13 Aug 2024 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWbESJuz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40811990CE
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549232; cv=none; b=o8AigAlIXH9uA3Zi6g2IxY62xLJnbYtAdElONeUqc0Dula3/4wVpTeEUGJOoe9mkiDKkmFaYZucctLDXtJl9J7UPqn3ydq36WoOnvvcBvY+2oOKvrtTn3MlM8RikGrrhneK1j/V2E82KNKdTY+qfrHzQnTcgVe4VHUNIs5Nh8QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549232; c=relaxed/simple;
	bh=ebpFbm/NIDIJmFg9Q2QiDeBNxT+9vl/HwSgUXAcv5mE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nYhBXbNuoTR6FcObdQUkEwkVta4mb94J2xTqdpMx4N1E3dlwL/zJ48UxcMdU+zhblGac4iPmaxAyngUQogf8M87vT9sxe9AxVrpMulubyboF58fzvPhT6oF/5SvgS/sfMgGJrHSXAwogHGfO2KkvL8+2MFiCYkL16FTiqsyuU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWbESJuz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2840C4AF09;
	Tue, 13 Aug 2024 11:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723549231;
	bh=ebpFbm/NIDIJmFg9Q2QiDeBNxT+9vl/HwSgUXAcv5mE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rWbESJuzESu5IRQ0UQhWcrIZnexc0k3uRsMj7PrpJJRxknp2zjW0B4mb2wrdFgHT/
	 HTrOt5Pw8Ky7xGKUFnROFytF8pW4nVASGlFxo8jIiTjLk90EOXEGhhXxQPuZvZ6UPH
	 f3oIAH4Bko0egS2UcGXLqIBL1v1tyJJR8Y9mzg6idz5xIfggszJvtCmNkQml/+cC5p
	 EhQVedEadRfPiXX888iGCbCpwnNI0Tesp/YXPOvyampY0T4ieen69kPgHGcy7DTynm
	 mcPMJAv9Bh7jNALNnamUaEtSnlbXFv3GRHxQRLv/AQ+KBDgwHv7Z+2YwEBU/cO3Km8
	 NtvmhxKJ3t28w==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9332114ADED1; Tue, 13 Aug 2024 13:40:28 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Duan Jiong <djduanjiong@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3] veth: Drop MTU check when forwarding packets
In-Reply-To: <CALttK1Qe-25JNwOmrhuVv3bbEZ=7-SNJgq_X+gB9e4BfzLLnXA@mail.gmail.com>
References: <20240808070428.13643-1-djduanjiong@gmail.com>
 <87v80bpdv9.fsf@toke.dk>
 <CALttK1RsDvuhdroqo_eaJevARhekYLKnuk9t8TkM5Tg+iWfvDQ@mail.gmail.com>
 <87mslnpb5r.fsf@toke.dk> <00f872ac-4f59-4857-9c50-2d87ed860d4f@Spark>
 <87h6bvp5ha.fsf@toke.dk>
 <66b51e9aebd07_39ab9f294e6@willemb.c.googlers.com.notmuch>
 <87seveownu.fsf@toke.dk>
 <CALttK1Qe-25JNwOmrhuVv3bbEZ=7-SNJgq_X+gB9e4BfzLLnXA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 13 Aug 2024 13:40:28 +0200
Message-ID: <87frr8wt03.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Duan Jiong <djduanjiong@gmail.com> writes:

> Sorry for responding to the email so late.
>
>>
>> I do see your point that a virtual device doesn't really *have* to
>> respect MTU, though. So if we were implementing a new driver this
>> argument would be a lot easier to make. In fact, AFAICT the newer netkit
>> driver doesn't check the MTU setting before forwarding, so there's
>> already some inconsistency there.
>>
>> >> You still haven't answered what's keeping you from setting the MTU
>> >> correctly on the veth devices you're using?
>> >
>
> vm1(mtu 1600)---ovs---ipsec vpn1(mtu 1500)---ipsec vpn2(mtu
> 1500)---ovs---vm2(mtu 1600)

Where's the veth device in this setup?

> My scenario is that two vms are communicating via ipsec vpn gateway,
> the two vpn gateways are interconnected via public network, the vpn
> gateway has only one NIC, single arm mode. vpn gateway mtu will be
> 1500 in general, but the packets sent by the vm's to the vpn gateway
> may be more than 1500, and at this time, if implemented according to
> the existing veth driver, the packets sent by the vm's will be
> discarded. If allowed to receive large packets, the vpn gateway can
> actually accept large packets then esp encapsulate them and then
> fragment so that in the end it doesn't affect the connectivity of the
> network.

I'm not sure I quite get the setup; it sounds like you want a subset of
the traffic to adhere to one MTU, and another subset to adhere to a
different MTU, on the same interface? Could you not divide the traffic
over two different interfaces (with different MTUs) instead?

>> > Agreed that it has a risk, so some justification is in order. Similar
>> > to how commit 5f7d57280c19 (" bpf: Drop MTU check when doing TC-BPF
>> > redirect to ingress") addressed a specific need.
>>
>> Exactly :)
>>
>> And cf the above, using netkit may be an alternative that doesn't carry
>> this risk (assuming that's compatible with the use case).
>>
>> -Toke
>
>
> I can see how there could be a potential risk here, can we consider
> adding a switchable option to control this behavior?

Hmm, a toggle has its own cost in terms of complexity and overhead. Plus
it's adding new UAPI. It may be that this is the least bad option in the
end, but before going that route we should be very sure that there's not
another way to solve your problem (cf the above).

This has been discussed before, BTW, most recently five-and-some
years ago:

https://patchwork.ozlabs.org/project/netdev/patch/CAMJ5cBHZ4DqjE6Md-0apA8aaLLk9Hpiypfooo7ud-p9XyFyeng@mail.gmail.com/

-Toke

