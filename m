Return-Path: <netdev+bounces-243186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1396CC9B0A2
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 11:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85E084E3CFE
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E891130DEA5;
	Tue,  2 Dec 2025 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="HR+7vsAZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C9C272813
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670399; cv=none; b=BteNIvFZekuA12SZXZhylfLfHHgGlWgoHl/SlcfV7aCgRNc++Wh/dz7/A2cpXbMpTUL7lKXOcxgoGp53H+SXJorfKYmX/nPQ9FEwQBZj6Aa33epWvlwE3ncEGrv+e9Kak66rOLhBQ84WXPcuFAoC8JtAf6WuxFZLhtBVytYbiDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670399; c=relaxed/simple;
	bh=gy+L6BZASwEtlGdIxLK9N2zjetMn9ZmMYO3SP9Fd4GU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nGGUQbHiTqzytBupCMoGu1HmWnx1PMm49BfcDzhzbc5Htd3gF9in2ErL0p/kxhfDZmPm+/UCz5EebHc/WcvquJOLkQAWmBYtpVv3PUawv2bAKbBqCZIRLtOD2eHHhOqopAW3aDylvw/ElMhnZeN/PUQc0hNKe48a4yoWqczwOB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=HR+7vsAZ; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1764670387; bh=gy+L6BZASwEtlGdIxLK9N2zjetMn9ZmMYO3SP9Fd4GU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HR+7vsAZt5N9RZrlozxJGE1WYCkO2N5WkX8HKPTX7PYgmG0fUIDHtQp11YFfRRUt0
	 2SGCZ/OoFdfjwU8dXMVQKxyHugRd6v1n/aAbbT5Nq6CYB5SuT2S6oyGmm8UWaIhjOQ
	 Ynf74P9inOc2LxStUy9Mq9X+VlRJDdvquvPgF0Ale+kFbxs36VOANmHbF7rMn7T34A
	 qWW/9Ztc/MGbe7vqWAbrJ2fvf3QziT8PBeKbYm1fro/xzSLvp9W69O1bdKJNy2QESS
	 MHFq3nLENdSlka8sI/s3OwqZh7BZvbj0ecbGU7MD1znfzaxU59Qa9/AraMzHbrzs8m
	 UiOaBI03OcwzA==
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xiang Mei <xmei5@asu.edu>, security@kernel.org, netdev@vger.kernel.org,
 xiyou.wangcong@gmail.com, cake@lists.bufferbloat.net, bestswngs@gmail.com
Subject: Re: [PATCH net v8 1/2] net/sched: sch_cake: Fix incorrect qlen
 reduction in cake_drop
In-Reply-To: <20251201170505.6e74c1e4@kernel.org>
References: <20251128001415.377823-1-xmei5@asu.edu> <87ikeubjqu.fsf@toke.dk>
 <20251201170505.6e74c1e4@kernel.org>
Date: Tue, 02 Dec 2025 11:13:06 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <878qfl9op9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 28 Nov 2025 10:15:53 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Xiang Mei <xmei5@asu.edu> writes:
>>=20
>> > In cake_drop(), qdisc_tree_reduce_backlog() is used to update the qlen
>> > and backlog of the qdisc hierarchy. Its caller, cake_enqueue(), assumes
>> > that the parent qdisc will enqueue the current packet. However, this
>> > assumption breaks when cake_enqueue() returns NET_XMIT_CN: the parent
>> > qdisc stops enqueuing current packet, leaving the tree qlen/backlog
>> > accounting inconsistent. This mismatch can lead to a NULL dereference
>> > (e.g., when the parent Qdisc is qfq_qdisc).
>> >
>> > This patch computes the qlen/backlog delta in a more robust way by
>> > observing the difference before and after the series of cake_drop()
>> > calls, and then compensates the qdisc tree accounting if cake_enqueue()
>> > returns NET_XMIT_CN.
>> >
>> > To ensure correct compensation when ACK thinning is enabled, a new
>> > variable is introduced to keep qlen unchanged.
>> >
>> > Fixes: 15de71d06a40 ("net/sched: Make cake_enqueue return NET_XMIT_CN =
when past buffer_limit")
>> > Signed-off-by: Xiang Mei <xmei5@asu.edu>=20=20
>>=20
>> Please retain tags when reposting...
>>=20
>> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>
> AI code review asks:
>
> When ACK thinning occurs, the incoming packet contributes len -
> ack_pkt_len bytes to sch->qstats.backlog, but this compensation uses
> the full len value. Should this be prev_backlog - (len - ack_pkt_len)
> to match what was actually added to the backlog?

No, there's a separate qdisc_tree_reduce_backlog(sch, 1, ack_pkt_len)
as part of the ACK thinning that compensates for the difference.

-Toke

