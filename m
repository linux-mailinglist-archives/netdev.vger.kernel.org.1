Return-Path: <netdev+bounces-200870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7716DAE726F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 00:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B3C3ACBDE
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09B72594AA;
	Tue, 24 Jun 2025 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsR2Pdo9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86806254B1F;
	Tue, 24 Jun 2025 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750805235; cv=none; b=oMpb3zMgE1aqSSoUDITN7/j8D/j2Ah3D9qaHl+CbGLbEHWlW48Sa/g1cwkGB4qk33HGKIieztRVDvJ64FO67v1eSfLWIOXl6+TtuJumzrTQmRst0OYX6uDR9SUe5L2ZPHPF1P22wglYgK4Um2qOZ2Ox24tkXTkgYvxBF5J/zzUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750805235; c=relaxed/simple;
	bh=yyIuPy3hmYKVaKki3At2/5DTM/08NHrLyix4AMMcTqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2erxYEafr8Cec27MXr+6FM3q/1XFejviOzwqzG2hhVAldiOlODN+N18v1xnYmBG/SZYpSMNZ/6U0Bwsyw5YwYmBdEaFfEULPRTylzMaplONjIZvPJfV+XIqcH3PKcT4yil0QvjZK8MlNTb4u2tcZExTzvtCzNIsrrIK3hfkgg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsR2Pdo9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF912C4CEE3;
	Tue, 24 Jun 2025 22:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750805234;
	bh=yyIuPy3hmYKVaKki3At2/5DTM/08NHrLyix4AMMcTqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsR2Pdo9Cj/dex4ghCywBVdoWW0KEHFSHfRbPQRDFv+Ij23Qes+/KL6aB5AXgQRcX
	 AdR/lQMA3st+kmreYN5V8rWqqRtDORmzVEb3ABJYdGJetHEMODcNwaen+b/myl9CoQ
	 oLqOhKPXaFHZ06jMXxjs6CDGrRLNPj2VEHS8N9M49g7Xiv3cWUJOl+oZ5+3dG3lR3b
	 QIEJvO8T2/wlxlknVdrlAClEoZPP89Kw83egeWQ3ZkOKzbDvA0pCo/SmQbBlpQsRUI
	 p3AdaS0Z1CJ+8qRzESso1lK6T7v+iJQp8nXw8uObfuEwEnTSOtD09IYH7T3De7f5Bs
	 +MXIldsJb/Kxg==
Date: Tue, 24 Jun 2025 17:47:13 -0500
From: Seth Forshee <sforshee@kernel.org>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Tonghao Zhang <tonghao@bamaicloud.com>, carlos.bilbao@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bilbao@vt.edu
Subject: Re: [PATCH] bonding: Improve the accuracy of LACPDU transmissions
Message-ID: <aFsq8QSZRNAE8PYs@do-x1carbon>
References: <20250618195309.368645-1-carlos.bilbao@kernel.org>
 <341249BC-4A2E-4C90-A960-BB07FAA9C092@bamaicloud.com>
 <2487616.1750799732@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2487616.1750799732@famine>

On Tue, Jun 24, 2025 at 02:15:32PM -0700, Jay Vosburgh wrote:
> Tonghao Zhang <tonghao@bamaicloud.com> wrote:
> 
> >
> >
> >
> >> 2025年6月19日 03:53，carlos.bilbao@kernel.org 写道：
> >> 
> >> From: Carlos Bilbao <carlos.bilbao@kernel.org>
> >> 
> >> Improve the timing accuracy of LACPDU transmissions in the bonding 802.3ad
> >> (LACP) driver. The current approach relies on a decrementing counter to
> >> limit the transmission rate. In our experience, this method is susceptible
> >> to delays (such as those caused by CPU contention or soft lockups) which
> >> can lead to accumulated drift in the LACPDU send interval. Over time, this
> >> drift can cause synchronization issues with the top-of-rack (ToR) switch
> >> managing the LAG, manifesting as lag map flapping. This in turn can trigger
> >> temporary interface removal and potential packet loss.
> 
> 	So, you're saying that contention or soft lockups are causing
> the queue_delayed_work() of bond_3ad_state_machine_handler() to be
> scheduled late, and, then, because the LACPDU TX limiter is based on the
> number of state machine executions (which should be every 100ms), it is
> then late sending LACPDUs?
> 
> 	If the core problem is that the state machine as a whole isn't
> running regularly, how is doing a clock-based time check reliable?  Or
> should I take the word "improve" from the Subject literally, and assume
> it's making things "better" but not "totally perfect"?
> 
> 	Is the sync issue with the TOR due to missing / delayed LACPDUs,
> or is there more to it?  At the fast LACP rate, the periodic timeout is
> 3 seconds for a nominal 1 second LACPDU interval, which is fairly
> generous.

To take a step back: we originally started looking at this code because
we've seen cases where TORs drop a link from the bond due to not getting
a LACPDU within the short timeout period. We don't currently know the
root cause of that problem, so this patch isn't trying to fix that issue.

But when looking at the LACPDUs that the TOR is receiving, we saw that
the packets were pretty consistently late by hundreds of milliseconds.
This patch from Carlos is trying to improve that inconsistency.

Yes, the math is incorrect, and that's partly my fault from giving
Carlos bad advice after looking at the code too quickly. But the fact
that this mistake improved the timing points to what I think may be at
the root of the inconsistency we see.

ad_tx_machine() resets port->sm_tx_timer_counter every time it reaches
zero, regardless of when the last LACPDU was sent. This means that
ad_tx_machine() is delaying LACPDU tx to the next expiration of this
periodic timer. So when Carlos made the counter very small, he made the
tx delay much shorter.

As I understand it the intention is to ensure that LACPDU tx is spaced
out by at least ~300ms, not to align them to an arbitrary ~300ms
boundary. If so, a simple improvement would be to reset the counter only
when an LACPDU is sent, then allow sending a LACPDU any time after it
reaches zero. Though I still think it makes sense to make the state
machines time-based rather than counter-based to ensure they aren't
sensitive to delays in running the delayed work.

Thanks,
Seth

