Return-Path: <netdev+bounces-243121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 875CFC99B2A
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 02:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 317643410C3
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 01:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20095136672;
	Tue,  2 Dec 2025 01:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRpsp/xD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD293F9D2
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 01:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764637508; cv=none; b=Wb+xcyhjAeKPr7P1zstfxJ6DIzm56faI8DHnFiPt3x1VhUfTev6wdR8XabxQMS4R6K5IgVwtmRcCHd01mGBTnQznWhtxeW4HBDZrUd4stfFsCoh4JvHLgvkswS0OLVVdv+d7KBU1nwdiQ3TUKQP5kROlL7j+3Qjwv3LYm0ikzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764637508; c=relaxed/simple;
	bh=cXQH/ctkDiDQh3xBDL7BFKJAorODKba2HS8mZ4TuzXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkaCTPAfnGgRX2d69xoVtQ78qIdiBfETJ8U57Bh3n5pH6jLCi/qgtom4R6v3AJto/vF2uao96E03GuyM1g0FqHFccT5iUJZbRq07nr1ZUqe3yhEAItvpkxYq5lA6fJb0OIbwO7uu9ZPlUWnEPVD0dX0oW5b3NhN46qAly+i/y5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRpsp/xD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1D2C4CEF1;
	Tue,  2 Dec 2025 01:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764637507;
	bh=cXQH/ctkDiDQh3xBDL7BFKJAorODKba2HS8mZ4TuzXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tRpsp/xDtkTz6aG6kBRfmltmu2fAzwNxRqSyqckjvzM4TCMU3ouyT9CHm0lK7LUIl
	 FP9TkxRPv68STofYQo+zp3odCi8Q4FPbZrfOLyD2hFTQlORBw9+uUOXJC8jMH6iX/Z
	 EVNuuzW1qFhiz/82Ng0IEjeKpHferc9Bu/urkI2fAu1NvROgkrdgzXjAUz/IVHh4+g
	 cYRP7d8cXPWwv3diWp5ShRkrkyTCxdg4Njfq4adqOPTEDjoosG1bCus7vQlLMVduUl
	 V6vqoO+zukMfhIcy8eoyXwaeOgo0YYWC5bBg+xHUUeei9xBE2h7bda5Xk2XTS82ckn
	 Mak082Ki0vByg==
Date: Mon, 1 Dec 2025 17:05:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>
Cc: Xiang Mei <xmei5@asu.edu>, security@kernel.org, netdev@vger.kernel.org,
 xiyou.wangcong@gmail.com, cake@lists.bufferbloat.net, bestswngs@gmail.com
Subject: Re: [PATCH net v8 1/2] net/sched: sch_cake: Fix incorrect qlen
 reduction in cake_drop
Message-ID: <20251201170505.6e74c1e4@kernel.org>
In-Reply-To: <87ikeubjqu.fsf@toke.dk>
References: <20251128001415.377823-1-xmei5@asu.edu>
	<87ikeubjqu.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Nov 2025 10:15:53 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Xiang Mei <xmei5@asu.edu> writes:
>=20
> > In cake_drop(), qdisc_tree_reduce_backlog() is used to update the qlen
> > and backlog of the qdisc hierarchy. Its caller, cake_enqueue(), assumes
> > that the parent qdisc will enqueue the current packet. However, this
> > assumption breaks when cake_enqueue() returns NET_XMIT_CN: the parent
> > qdisc stops enqueuing current packet, leaving the tree qlen/backlog
> > accounting inconsistent. This mismatch can lead to a NULL dereference
> > (e.g., when the parent Qdisc is qfq_qdisc).
> >
> > This patch computes the qlen/backlog delta in a more robust way by
> > observing the difference before and after the series of cake_drop()
> > calls, and then compensates the qdisc tree accounting if cake_enqueue()
> > returns NET_XMIT_CN.
> >
> > To ensure correct compensation when ACK thinning is enabled, a new
> > variable is introduced to keep qlen unchanged.
> >
> > Fixes: 15de71d06a40 ("net/sched: Make cake_enqueue return NET_XMIT_CN w=
hen past buffer_limit")
> > Signed-off-by: Xiang Mei <xmei5@asu.edu> =20
>=20
> Please retain tags when reposting...
>=20
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

AI code review asks:

When ACK thinning occurs, the incoming packet contributes len -
ack_pkt_len bytes to sch->qstats.backlog, but this compensation uses
the full len value. Should this be prev_backlog - (len - ack_pkt_len)
to match what was actually added to the backlog?

