Return-Path: <netdev+bounces-210253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF5DB127D9
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 02:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FFDAA80DF
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20663645;
	Sat, 26 Jul 2025 00:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ed/bf9cn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B8527455
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 00:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753488650; cv=none; b=Pk94JLnXd86qTqIxnonXtkwTiQfFKx4C7G/d+OhtHBu4XlAWeGW0bDWAaIc0R5/vUPwjpRozTJ3he1gJKVg5ei55CA2BpJR3VlZbNlD27Mxz2P809hVft9Ww7rCy91qaSTIJEvfcc4ms1j3DiJxO8iXJaC6Cna0QA76pwayAlC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753488650; c=relaxed/simple;
	bh=je2cwoQlMLGlO7bmZ1skLQ8C7AdRJcUF+AQbwENZPhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sat19yEq+xZ6H21a0aPJWmZ65aZb8tQOiNPn1wPlbhn+NircxH29UftNP4aXo7lg7klgu7ZM6C8FKakQN2My5DHAxUatnCpfk4+j/w0vDAQ4nV7h+uTvMA2dwL3zJYtoT0LLs9IIo1G4TA8joj1IcLJJVuN2Q/gDizfbH4VQlKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ed/bf9cn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753488648; x=1785024648;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=je2cwoQlMLGlO7bmZ1skLQ8C7AdRJcUF+AQbwENZPhM=;
  b=ed/bf9cnnIuq/Ud0fD/i3NLapu0jTcFzk7C10x3EQTjbOqQ8PpcO4YKi
   65zUJf+DDWZW8QG5MvXC8+SCgW8HHI0mmlRwq7YVUC86y4ag+QG0L94uM
   2f89JvmcHcUxtcy1HgRamt1zompqa6O5sUIkXIL17u6BVDIORYY6CGnAb
   2KvLzCCSf+VKVaGs8EP3ZkyHiP0HbUVwYgoVMCMa8AQDrWdFrWWY536fX
   f8rJpbAnBCZzeSgkjTefKsFlzHp9Ir8gl8SDYcJawWmFXXtM7ChKppOTG
   5vjfWhUKauYTF9Yyr9v9APNOaBEFdzuAklWpmcCTq9SY9HlFFmYojNuPz
   w==;
X-CSE-ConnectionGUID: BSCwG++hSY24qLZtWdeUoQ==
X-CSE-MsgGUID: //hB3DdMTO2Y4AGxj7YWww==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="78379733"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="78379733"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 17:10:46 -0700
X-CSE-ConnectionGUID: vk8gS7AtTBG9ankqwXvl+A==
X-CSE-MsgGUID: 8gb+AOiiR42m54rZggY8Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161561934"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.220.84])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 17:10:45 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Simon Horman <horms@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, Maher Azzouzi <maherazz04@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] net/sched: taprio: align entry index attr
 validation with mqprio
In-Reply-To: <20250725-taprio-idx-parse-v1-1-b582fffcde37@kernel.org>
References: <20250725-taprio-idx-parse-v1-1-b582fffcde37@kernel.org>
Date: Fri, 25 Jul 2025 17:10:44 -0700
Message-ID: <87y0sbdd6j.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Simon Horman <horms@kernel.org> writes:

> Both taprio and mqprio have code to validate respective entry index
> attributes. The validation is indented to ensure that the attribute is
> present, and that it's value is in range, and that each value is only
> used once.
>
> The purpose of this patch is to align the implementation of taprio with
> that of mqprio as there seems to be no good reason for them to differ.
> For one thing, this way, bugs will be present in both or neither.
>
> As a follow-up some consideration could be given to a common function
> used by both sch.
>
> No functional change intended.
>
> Except of tdc run: the results of the taprio tests
>
>   # ok 81 ba39 - Add taprio Qdisc to multi-queue device (8 queues)
>   # ok 82 9462 - Add taprio Qdisc with multiple sched-entry
>   # ok 83 8d92 - Add taprio Qdisc with txtime-delay
>   # ok 84 d092 - Delete taprio Qdisc with valid handle
>   # ok 85 8471 - Show taprio class
>   # ok 86 0a85 - Add taprio Qdisc to single-queue device
>   # ok 87 6f62 - Add taprio Qdisc with too short interval
>   # ok 88 831f - Add taprio Qdisc with too short cycle-time
>   # ok 89 3e1e - Add taprio Qdisc with an invalid cycle-time
>   # ok 90 39b4 - Reject grafting taprio as child qdisc of software taprio
>   # ok 91 e8a1 - Reject grafting taprio as child qdisc of offloaded taprio
>   # ok 92 a7bf - Graft cbs as child of software taprio
>   # ok 93 6a83 - Graft cbs as child of offloaded taprio
>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Maher Azzouzi <maherazz04@gmail.com>
> Link: https://lore.kernel.org/netdev/20250723125521.GA2459@horms.kernel.org/
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius

