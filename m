Return-Path: <netdev+bounces-249808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B008D1E43B
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5642300CCEB
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F340395248;
	Wed, 14 Jan 2026 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="gzMW+j3Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF814304BCB
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388229; cv=none; b=BmK+p6eEPs19ktAppvcG18QuLdcnQ72lJ93xehZxRbfOjL/SiV5mneTWRx/eRSgUjQJ06Zeya5ULfNnwOLKhfgO0GSOLbWJJWajsgyEMlf1rFYDnZCkrpaLjqikJLCuJA/VvQot3DGeRQ5KXOelOUsI50p4o1PQ0yT6F88Qp8lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388229; c=relaxed/simple;
	bh=ebA5xYZs+17O4zaAsWAKepT51kZFKCWS1n0x4EfFURg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ntiNPdHCdnFt6Rs4gtlFcTFCgmZSsOu0MPzLfSL6DGm9+XeZKXOjTIaJDVRk8hmlRDF230CPrPdYiCpXJt7rRNsGLgZvFiuOwxW5oAMEdW+tRtaC9iv7/HFhNBGITmMqxNFmYgFKdj5XnLRIG4iEoGsNJvMh6Izhq26rmbqO1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=gzMW+j3Q; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1768388054; bh=ebA5xYZs+17O4zaAsWAKepT51kZFKCWS1n0x4EfFURg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gzMW+j3Qw9O4WKbG/prvJRpqAFP4vz9w5tZ0PzYaBdsX1x+kFpGnhnWwihMQViWm7
	 7XqQiEz3wVNUaucnmfVmPYNqkqQUbpQKXfwsYoQ0ia+I9dbX9L4nuFzH8d7j0KHhRn
	 R7jZWOi0obkMVYigAKLVS84JAfq5DKsvDNYjMoar6UnUBpJRnnpUxG37e/N/fgMlzz
	 /CB4rHb5KlEIRB7GNg0Yi28zNfo5e4Lx8aQHJNoZFlPfi1xxy5edWVYPf6R9a3gHll
	 Kc3S/JQsImCeWECBqeVp0cWJTmV0hqQvslI3+kmkJ3KK1DVFsjOjeIjnXobU80Ubgi
	 HOAkCquwjVLQA==
To: Eric Dumazet <edumazet@google.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 cake@lists.bufferbloat.net, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net/sched: cake: avoid separate allocation of
 struct cake_sched_config
In-Reply-To: <CANn89iLdM=a=oagYA=LKbfaDuhQaYtxA0wNERuzNLGghA58Phw@mail.gmail.com>
References: <20260113143157.2581680-1-toke@redhat.com>
 <CANn89iLdM=a=oagYA=LKbfaDuhQaYtxA0wNERuzNLGghA58Phw@mail.gmail.com>
Date: Wed, 14 Jan 2026 11:54:12 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ecns1n3f.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> On Tue, Jan 13, 2026 at 3:32=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> Paolo pointed out that we can avoid separately allocating struct
>> cake_sched_config even in the non-mq case, by embedding it into struct
>> cake_sched_data. This reduces the complexity of the logic that swaps the
>> pointers and frees the old value, at the cost of adding 56 bytes to the
>> latter. Since cake_sched_data is already almost 17k bytes, this seems
>> like a reasonable tradeoff.
>>
>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>
> This is also fixing a panic, so :
>
> Fixes: bc0ce2bad36c ("net/sched: sch_cake: Factor out config variables
> into separate struct")
>
> For the record, a fix for the panic would be :

Ah yes, of course; thanks for noticing (and for the tag)!

-Toke

