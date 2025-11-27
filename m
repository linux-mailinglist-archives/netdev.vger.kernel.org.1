Return-Path: <netdev+bounces-242389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C90F2C9002A
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 20:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5AEC4E181F
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 19:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEA230170E;
	Thu, 27 Nov 2025 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="fiffvJBw"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B612DA75A
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 19:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764271679; cv=none; b=CHRaAwLTsltN4I8QD0srD4FkwBfi2zi/Axcno4TJwr0P83m8omVE/wtLIuIkNM6FgsJCdo+kG2X8YUTSItBOR1g/Ym8/14OI1I/CQi5ewKYiRS4b6HcRU1jIgvPHyX/lU8up/GU1CmlaWhVEJc5N+8WNWswLNUvzk5oB3LwulH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764271679; c=relaxed/simple;
	bh=byOpwHBiMxL3uSBexjGsaLR2xKlpLWJHeTrPx2wTXmw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ri2iBlnk1C0d31IkysQWewTKIr1xMH8yn7I2Oi5iNeCh3PbG6HMXslKeStgR7QLr9h8ySvbMrYiNjV9IoIGIjWkFvlEPV4fl9F9+CwlxI9Yidnje5yBSzpiwFrndSM/5A3DQ/jrg5Qdb+X43W6f+4zkl2ZNe11uwhV2Gd5qOgNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=fiffvJBw; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1764271670; bh=byOpwHBiMxL3uSBexjGsaLR2xKlpLWJHeTrPx2wTXmw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fiffvJBwflH68EeoRvs0Qj2hYCoOFGn+8U9PdPq/lSLwA0vzTqBOdsqxiqFgkrFf8
	 mkJ+FpAPuMSb400jQXyaq7tvpaxkz3UWAcBNPbVlWiIRUyE0OicEClfJRhXD0Fxxze
	 TgdZINwWVtl87uoMgd0fNYtux57eHVdq3MY1vB9r0fExUKIt9+IkOfyn73SqnPPU5C
	 ZK+h9ouL5CIj7P5dh/G1N6pHlrHBZHDuQBUregwaWc5OpzIHlWGRN8RYhqz4BmQGBO
	 ODVsFwsCo6ExyS8VURyLFHVbVlQ748scqotIshL58pmnXdXLTHCCDG2aERnhRexGyY
	 9c6PbB1g7FObA==
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonas =?utf-8?Q?K?=
 =?utf-8?Q?=C3=B6ppeler?=
 <j.koeppeler@tu-berlin.de>, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] Multi-queue aware sch_cake
In-Reply-To: <aSiYGOyPk+KeXAhn@pop-os.localdomain>
References: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
 <aSiYGOyPk+KeXAhn@pop-os.localdomain>
Date: Thu, 27 Nov 2025 20:27:49 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87o6onb7ii.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Cong Wang <xiyou.wangcong@gmail.com> writes:

> Hi Toke,
>
> On Thu, Nov 27, 2025 at 10:30:50AM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>>  Documentation/netlink/specs/tc.yaml |   3 +
>>  include/uapi/linux/pkt_sched.h      |   1 +
>>  net/sched/sch_cake.c                | 623 ++++++++++++++++++++++++++++-=
-------
>>  3 files changed, 502 insertions(+), 125 deletions(-)
>
> Is there any chance you could provide selftests for this new qdisc
> together with this patchset?
>
> I guess iproute2 is the main blocker?

Yeah; how about I follow up with a selftest after this has been merged
into both the kernel and iproute2?

-Toke

