Return-Path: <netdev+bounces-242206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE80C8D75A
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0013A9AF3
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 09:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A139B326939;
	Thu, 27 Nov 2025 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="xbAjDc9M"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF66326D5F
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764234878; cv=none; b=UokbZpZOpK4jURoa8HPbHL2HbBJ40GDkh5APZg748egsLkpEEC/Jk61jjiZOPacRbOlnbiU+AoGfkLDpVyhLUiQA/0P761iJFy46BDOkT2/NXTRQ820Jgq29+73ElY6dDaYBxVluC5SFKGZ98lrbQMSayrUnRByqT2o2nrUWMm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764234878; c=relaxed/simple;
	bh=8LqIJbUdOQ/q1iHHyZfNB++O27UD71zydFgZOsV8bsk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pdI5xAEL0jznfiLG5ty1dGWBPRJ1wAzLsqFShpuCf2SfRoFQ6Bcm2/qAC7eIv0x4g0DjSmFLv7SESXety4RS1v5x/WwrzVO7Dlorz2APg4e129bWF0+wsgYBzDPIUVpXs3pRp3tWEciSAtDiAgvEH9iOHbyhoK4DFpfiFVHp8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=xbAjDc9M; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1764234874; bh=8LqIJbUdOQ/q1iHHyZfNB++O27UD71zydFgZOsV8bsk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=xbAjDc9MFejGWVe1doJC3xl32LlNHvNanXTkGFX1xMXbVZcr4NKPEgURAnYxDWNlZ
	 LaPyCZHOFilwaAy6yAsEtLmPvcsrffeb0onI3PGrAbY1k9wcF5DIMIFU20A3+51/+s
	 +LlugPVVV0BiW3IQFC0ej0kdZrK6nEN3Ia6xb5d7CsqEpoUiVvLbwk3nt2TzR213Jd
	 gu4tGNC5HrJjVIyLvKJHirURERaHNjsI0P6R22eTVD/YZzDdXuBSBKqNB5m6bLK0hu
	 6EyxZQwRIXlgqRUsZUVd/L+RuqREPAS8I3KGpPh0N/sXsnRSYwNJwzZWOb3KMtc3EA
	 /3hRocGcKTOAg==
To: Xiang Mei <xmei5@asu.edu>, security@kernel.org
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com,
 cake@lists.bufferbloat.net, bestswngs@gmail.com, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v7 1/2] net/sched: sch_cake: Fix incorrect qlen
 reduction in cake_drop
In-Reply-To: <20251126194513.3984722-1-xmei5@asu.edu>
References: <20251126194513.3984722-1-xmei5@asu.edu>
Date: Thu, 27 Nov 2025 10:14:32 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87wm3bbzwn.fsf@toke.dk>
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

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

