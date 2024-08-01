Return-Path: <netdev+bounces-114947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB96944C30
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0391C25E70
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060171AB524;
	Thu,  1 Aug 2024 12:59:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE0A1A2579;
	Thu,  1 Aug 2024 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517149; cv=none; b=cRQotfvItNzLXrGt4UfEf9BZlKibscg/4T3AzDs9xNQOUpjO7Jeti7hH1NRNlSA/Cuu0C4e85r8sIyOlUHpVJsLi+oMRGaj7Y2Z1sVmi8tMI/9LVyVQu+xBNkSWx4lcY4RsAAYpoxp65LoQyIeCdJWrHKlzTyUittRUJHp7ClhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517149; c=relaxed/simple;
	bh=qzfZVrjr2FXtfy2acQZqRUjaq5PPxknpsnS0xvtWVfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE56NRfPrdJ2U42nUcCLOuPJikiY3RlIne99jgl2+SrzVDY6AVuTopyjtjyoEoItC6HQ9yuMxytgrBbcKQVLsIe50KrzJkjnt/EvPishwgzjHm/JRJxw5W3OStfcgYhJf2JwW8h0LdSmtJa+o1aKBeNxjR2mrf1wsaGkLbMM6jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sZVOS-00007o-6A; Thu, 01 Aug 2024 14:58:56 +0200
Date: Thu, 1 Aug 2024 14:58:56 +0200
From: Florian Westphal <fw@strlen.de>
To: Wojciech =?utf-8?Q?G=C5=82adysz?= <wojciech.gladysz@infogain.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/net: missused TCQ_F_NOLOCK flag
Message-ID: <20240801125856.GC10274@breakpoint.cc>
References: <20240801105707.30021-1-wojciech.gladysz@infogain.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240801105707.30021-1-wojciech.gladysz@infogain.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Wojciech Gładysz <wojciech.gladysz@infogain.com> wrote:
> TCQ_F_NOLOCK yields no locking option for a qdisc. At some places in the
> code the testing for the flag seems logically reverted. The change fixes
> the following lockdep issue.
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.10.0-syzkaller #0 Not tainted

This kernel is over 3 years old.  Please either only fuzz
on net or net-next and keep them up-to-date, or wait for
the fuzzer to get a reproducer and then verify that reproducer
still triggers on current kernels.

>  static inline bool qdisc_is_running(struct Qdisc *qdisc)
>  {
> -	if (qdisc->flags & TCQ_F_NOLOCK)
> +	if (!(qdisc->flags & TCQ_F_NOLOCK))
>  		return spin_is_locked(&qdisc->seqlock);

Are you absolutely sure?  I find it hard to believe something
like this would go unnoticed for years.

Curious glance tells me seqlock is used to sync nolock qdiscs vs.
qdisc reset, i.e. exiting code is correct.

