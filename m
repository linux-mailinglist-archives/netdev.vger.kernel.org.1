Return-Path: <netdev+bounces-242694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3A8C93B43
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 10:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC720347E4F
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3A51A073F;
	Sat, 29 Nov 2025 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="FPiQ3SsL"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7D3B2A0
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764408311; cv=none; b=CQzM4o5ptJnL5BSbLbd14/CTuhlrmqqjCVSdm+Gl1w51bWrwOJRqdoJs/vRxm9IXN/2mk21x2hIfqJl3LbKjAR2mn8NGlZsE4O06q9lkQ6k1eznB51Qw1VWNgtwIKhF0bbPvVVFlkCIZlI4ato0p5ceY9QwPVrZdYyLqD2Qkmk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764408311; c=relaxed/simple;
	bh=Tf5//QxJR4XA1hIgE7mbVxfMEhfaK/xP+lUkwqMEQtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A7HYaL+Ib70keWc0t1RJKnSwn84yGDdYLOSB8fHoECZ7qzNKZ76B/9Zo0109Npumy79ufS9ZEl+ODYlbbedfYr6TTLA4Gu13HZCgHRYvoS8t34RibUi5U5LtdgEm4Ip0LzgsNU/hZpUbe0vNDAj+VKCU1wozoCnLK6A2byQNx7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=FPiQ3SsL; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1764408304; bh=Tf5//QxJR4XA1hIgE7mbVxfMEhfaK/xP+lUkwqMEQtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FPiQ3SsLMUyCHuKxWSc7QToEB1ICfJpeWfwFbn0Yo3PPXFm7xrL52JtMnQSg9HM1l
	 ph5AI3Z4s3LTO8XL7mA9QcFemEY3EcRLwMEwtAEMi5HDAzlTTw7mmTEbghZ1zvVlRu
	 ucjHVc9fl+l1sXbGQh1SD7FwgwMctyEwSZFgygWoL/BxSpD0kjnhYFSGmZEoqD0r3H
	 eFHvOWw+GeVMTPfOcIRNyRvt1Pwifokuxag/DUCAFVfp3UO9FLR8HDbM+JhCxUYztD
	 nrIEdKVHdKORFYa+T6wfeTlMj4PDGE53TQX+x/ezaAiZadmjU7+jf26A2i7QrdrLWX
	 jkV6NeoOYZCzQ==
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonas =?utf-8?Q?K?=
 =?utf-8?Q?=C3=B6ppeler?=
 <j.koeppeler@tu-berlin.de>, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] Multi-queue aware sch_cake
In-Reply-To: <20251128184852.7ceb3e72@kernel.org>
References: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
 <aSiYGOyPk+KeXAhn@pop-os.localdomain> <87o6onb7ii.fsf@toke.dk>
 <20251128095041.29df1d22@kernel.org> <87cy51bxe1.fsf@toke.dk>
 <20251128184852.7ceb3e72@kernel.org>
Date: Sat, 29 Nov 2025 10:25:02 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <877bv9b381.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 28 Nov 2025 23:33:26 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>> > On Thu, 27 Nov 2025 20:27:49 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wr=
ote:=20=20
>> >> Yeah; how about I follow up with a selftest after this has been merged
>> >> into both the kernel and iproute2?=20=20
>> >
>> > Why is iproute2 a blocker? Because you're not sure if the "API" won't
>> > change or because you're worried about NIPA or.. ?=20=20
>>=20
>> No, just that the patch that adds the new qdisc to iproute2 needs to be
>> merged before the selftests can use them. Which they won't be until the
>> kernel patches are merged, so we'll have to follow up with the selftests
>> once that has happened. IIUC, at least :)
>
> You can add a URL to the branch with the pending iproute2 changes
> when you post the selftests and we'll pull them in NIPA, or post=20
> the patches at the same time (just not in one thread).

Ah, cool.

Given the likely impending merge window, how would you feel about
merging this series as-is and taking the selftests as a follow-up? Would
be kinda neat to get it in this cycle :)

-Toke

