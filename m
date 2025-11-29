Return-Path: <netdev+bounces-242691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0BAC93B13
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 10:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1B594E101B
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 09:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330EF224B06;
	Sat, 29 Nov 2025 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="B8illfKG"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDCA3B2A0
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764408110; cv=none; b=Pl0wcICC5kSHuCMXwZuFrlQJaMRcVQunEBnyVaqMc5E5Q3MTAsoC6Fi2ntwYqRlhPb8EqwBXMOmYM91XYZKhq5hXMcUMCoi8QGr2+YXvKfRqlzPIxQOlXsX5LufOfnLfG8h2EJXpL2GpVnkxk2F/v7S5xLayy2uq2PZI7mXhUQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764408110; c=relaxed/simple;
	bh=TcHF9XI+kpMbFyGDJlrjny70cbMfdgOug3ms9WKBPl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ovfls/tcFZy0igZJtwJGWMZXY+Jjb2AtCY7F8fomWi0FKqoThy56pawKaPGQIxrPwgKIqhj8HX1glSzl7pk1QbsKnbv2i5hxxUeOpxl+CWEb8vFwBL1ykO2K9iubns2Qo8CJAq7J4glLfVAVNmMbQgKd994mtdROgn8HZEfzC2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=B8illfKG; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1764408095; bh=TcHF9XI+kpMbFyGDJlrjny70cbMfdgOug3ms9WKBPl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=B8illfKGqRmxTe+Hw/pryELSotuukBz7eIrdjZ14eGSw49arwh8yrw5fGQTwF6CjL
	 HRrHmziB7DQqVW29bk4WSXKkCwRqioiiJQrOV1+jShpdMXsIT9HOAw9+9GqjysDnRt
	 IVi8hybtYRmeIHA4ZbQBQxQAnRwN8/MkjX9dqA1iWr2nioV/d24DVfHgm8Yb+su5jV
	 Pwy7DE16Sxi5oZ/JJ6/OA+Fy/XtY2gVNBgkTVzhNTCseSkYoKWpe+KiTUf42m246dR
	 WXftBuGoKDN4+Wdn8tJZcbjLhro/ES1sy77ybXSa7YvSJQ6phJJ6Fh5L+Zt6fTIXGp
	 JRsNS2REtfP9Q==
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Jonas =?utf-8?Q?K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 cake@lists.bufferbloat.net,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net/sched: sch_cake: Add cake_mq qdisc
 for using cake on mq devices
In-Reply-To: <willemdebruijn.kernel.2e44851dd8b26@gmail.com>
References: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
 <20251127-mq-cake-sub-qdisc-v2-2-24d9ead047b9@redhat.com>
 <willemdebruijn.kernel.2e44851dd8b26@gmail.com>
Date: Sat, 29 Nov 2025 10:21:34 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87a505b3dt.fsf@toke.dk>
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
>> Add a cake_mq qdisc which installs cake instances on each hardware
>> queue on a multi-queue device.
>>=20
>> This is just a copy of sch_mq that installs cake instead of the default
>> qdisc on each queue. Subsequent commits will add sharing of the config
>> between cake instances, as well as a multi-queue aware shaper algorithm.
>>=20
>> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  net/sched/sch_cake.c | 214 ++++++++++++++++++++++++++++++++++++++++++++=
++++++-
>>  1 file changed, 213 insertions(+), 1 deletion(-)
>
> Is this code duplication unavoidable?
>
> Could the same be achieved by either
>
> extending the original sch_mq to have a variant that calls the
> custom cake_mq_change.
>
> Or avoid hanging the shared state off of parent mq entirely. Have the
> cake instances share it directly. E.g., where all but the instance on
> netdev_get_tx_queue(dev, 0) are opened in a special "shared" mode (a
> bit like SO_REUSEPORT sockets) and lookup the state from that
> instance.

We actually started out with something like that, but ended up with the
current variant for primarily UAPI reasons: Having the mq variant be a
separate named qdisc is simple and easy to understand ('cake' gets you
single-queue, 'cake_mq' gets you multi-queue).

I think having that variant live with the cake code makes sense. I
suppose we could reuse a couple of the mq callbacks by exporting them
and calling them from the cake code and avoid some duplication that way.
I can follow up with a patch to consolidate those if you think it is
worth it to do so?

-Toke

