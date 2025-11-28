Return-Path: <netdev+bounces-242527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E16C91668
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 10:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E1E3AAA54
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532EA308F05;
	Fri, 28 Nov 2025 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="QsDUx4ei"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555E0305962
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321367; cv=none; b=M5m2tgzJVvoFALavC4Y2XgJv8uWT8OsnrQzbc9LOvNuPdqfiKPRYy2l37C/qdxByWNdmeRm3ZhuOFvV8kqTc7h2szNexuqw1yhgpVfm0Er27MXIb6NOslt8PrVKnW3PLsRmVUeA901leRBAE6CiVb1A3kMS+ljuTbyZ3KwytAjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321367; c=relaxed/simple;
	bh=F+CjRqBrjC0rAcQccPgfnKMmmA7NQZelpcIoR5ArYis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BqdwW7awoM39KxgItOxafnmlUOt1dty8BbAiiu9jlEfniTKQjmlPLjSTRyxMEDGJd57yn+t2fe4vWdp2e8jan6wc376J6vABntezMLngjsa4ot76bngZ6EfQE5CRPrwmtDpIei5p9SbHmoljJzed54mxfREmcg11Weoeh0vQjqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=QsDUx4ei; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1764321354; bh=F+CjRqBrjC0rAcQccPgfnKMmmA7NQZelpcIoR5ArYis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QsDUx4eiQf3NYHLRNNEzF9dhPWxQbNFAhRMn9f88igM2SH7qH6hULPNDogqOagoxQ
	 oEWH9geuciATS5yEotIzL6aaiLSBnBjX/t4Myc4OFfPm8YjLrtZcECwxgD+IXHmuI+
	 dng9LELNcRnYr+tQ9ePRXkEkrEaedi0So7hP100DI2/KwuFGfXBGnyElodl87Ca2s7
	 rUj1U2LQSRb5jRiGK5ma0Vf/RRel41XPdDAC4ppFRVLvKSrnVPVNPyLFkpg6WRWCFj
	 EVZJk9+mLTCSLiwV4hQBTVbQC61APOOnqPTHr6XBgbdJ41ZVJ0ocDIhVZbqxjqMOpV
	 zDkukhREo8QCw==
To: Xiang Mei <xmei5@asu.edu>, security@kernel.org
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com,
 cake@lists.bufferbloat.net, bestswngs@gmail.com, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v8 1/2] net/sched: sch_cake: Fix incorrect qlen
 reduction in cake_drop
In-Reply-To: <20251128001415.377823-1-xmei5@asu.edu>
References: <20251128001415.377823-1-xmei5@asu.edu>
Date: Fri, 28 Nov 2025 10:15:53 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ikeubjqu.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Xiang Mei <xmei5@asu.edu> writes:

> In cake_drop(), qdisc_tree_reduce_backlog() is used to update the qlen
> and backlog of the qdisc hierarchy. Its caller, cake_enqueue(), assumes
> that the parent qdisc will enqueue the current packet. However, this
> assumption breaks when cake_enqueue() returns NET_XMIT_CN: the parent
> qdisc stops enqueuing current packet, leaving the tree qlen/backlog
> accounting inconsistent. This mismatch can lead to a NULL dereference
> (e.g., when the parent Qdisc is qfq_qdisc).
>
> This patch computes the qlen/backlog delta in a more robust way by
> observing the difference before and after the series of cake_drop()
> calls, and then compensates the qdisc tree accounting if cake_enqueue()
> returns NET_XMIT_CN.
>
> To ensure correct compensation when ACK thinning is enabled, a new
> variable is introduced to keep qlen unchanged.
>
> Fixes: 15de71d06a40 ("net/sched: Make cake_enqueue return NET_XMIT_CN whe=
n past buffer_limit")
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Please retain tags when reposting...

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

