Return-Path: <netdev+bounces-157468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18431A0A609
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 22:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A1D47A3447
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641541B7901;
	Sat, 11 Jan 2025 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0PuUbxO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBA614F102
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736629316; cv=none; b=h9FFVzzf848aO4pCTsMBsGzBfV7da/bTYWfFhxqqAwF3O6pKSESH6+FPtAV5Ne/7ccj3HpNufPWRh1mL+uYRqe8l6ImKL2RszAnO8t42o2s86nBqsV4vIcFZXR+nrYRJS2GJOIyBqo0aErF5S68rqa7w5xvqu4PAI2F+yzILK5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736629316; c=relaxed/simple;
	bh=AQiR99l4dGsCVarxFb4t6aEzpV+Gg4+DZvMFjlYC9AI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9GPYS3zKR9J96GSOekqqy1Th0tLQtoasfpVaJQraG6l7A21nR7yrVhfRMn+id3CxAKiFD+9JHd6HzxD0gzYNfDltPHkV3q1CmpEv4ppEytjUL+d7DoVQTDeuKilf4y4HlI6pdsYOvrjqGu3QAraqpjIL6IUlF8EPyIUgzxV8E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0PuUbxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B8BC4CED2;
	Sat, 11 Jan 2025 21:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736629315;
	bh=AQiR99l4dGsCVarxFb4t6aEzpV+Gg4+DZvMFjlYC9AI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S0PuUbxOvnIiE2sWOpLcmUqzNkokpG7PL/d4Wdwg8qLCWtEiNkJ/KAt5MkOi6GlUt
	 Lx6B8dpeVblh5CrbFnYk24v8fYIaq+ahJC5UQxfntJaDMbDn2507n+BmsxUHfyUMn3
	 WyjZrSo1H4gXCTVSXtUOxp1AjuQ2DSgre8wv9++dnPRISq+sshjq8Z7+2+7gPULu+L
	 WcuTqpzyI/NmNa+COnXwXa4ZHanXDoyqA8XhzyGra3lVj1PsQgoaLv91nqQJPgplk9
	 9+mKDZm3bR/UeVBeLP81oOdxX2CG2i0vsbdfQt+X1Z3VN8v1CTUCSU9t0lLu9QU1lU
	 koR+BQiJFBDSQ==
Date: Sat, 11 Jan 2025 13:01:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, petrm@mellanox.com,
 security@kernel.org, g1042620637@gmail.com
Subject: Re: [PATCH net v4 1/1] net: sched: fix ets qdisc OOB Indexing
Message-ID: <20250111130154.6fddde00@kernel.org>
In-Reply-To: <20250111145740.74755-1-jhs@mojatatu.com>
References: <20250111145740.74755-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 09:57:39 -0500 Jamal Hadi Salim wrote:
> Haowei Yan <g1042620637@gmail.com> found that ets_class_from_arg() can
> index an Out-Of-Bound class in ets_class_from_arg() when passed clid of
> 0. The overflow may cause local privilege escalation.

Code is identical to v1 here...

While fixing the code, could you also trim the stack trace?
Like this:

   UBSAN: array-index-out-of-bounds in net/sched/sch_ets.c:93:20
   index 18446744073709551615 is out of range for type 'ets_class [16]'
   CPU: 0 UID: 0 PID: 1275 Comm: poc Not tainted 6.12.6-dirty #17
   Call Trace:
    <TASK>
    ets_class_change+0x3d6/0x3f0
    tc_ctl_tclass+0x251/0x910
    rtnetlink_rcv_msg+0x170/0x6f0
    netlink_rcv_skb+0x59/0x110
    rtnetlink_rcv+0x15/0x30
    netlink_unicast+0x1c3/0x2b0
    netlink_sendmsg+0x239/0x4b0
    ____sys_sendmsg+0x3e2/0x410
    ___sys_sendmsg+0x88/0xe0
    __sys_sendmsg+0x69/0xd0

the rest has no value.

