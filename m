Return-Path: <netdev+bounces-104625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3B490DA2C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 19:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA82A1F235DE
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D92C446DE;
	Tue, 18 Jun 2024 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqiTNqGm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03692535B7;
	Tue, 18 Jun 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730132; cv=none; b=anvBHksIX96r0cRHttzJnbwp5W93HptJKM0vBt2k9bg51syC/HusYa7E7Evl8SXnwrON2YdIk+cEGclU+ZKOH/YvU57ct7/6zDcZRG4fmx+RA26pBBG6KRjeXQ/NA2pu/WoXYsVaNM1Xf6NTx6jJ8Wy4pMTdaX2UyjYczaBn8P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730132; c=relaxed/simple;
	bh=Rox7hA3gEwDHsn/OtUndZMrIzG+7ua2p/cM8oQWxptQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDrjPstuHHXFR7DfVNfBXRpZ/qrC/jOpzoZvB9EbJi7jttCqtQqBgFZejPLtgatnSJ2rJpuDd1TAEfRYJygzMLECaJ3JUIesueI6cDLhcrMQGNr2GtWmgT61autCSSzMO7yyk2ywRePjtgiY+Wt/aPzOGhZgULXStOYGojnUYe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqiTNqGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB60C3277B;
	Tue, 18 Jun 2024 17:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718730131;
	bh=Rox7hA3gEwDHsn/OtUndZMrIzG+7ua2p/cM8oQWxptQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lqiTNqGmp9YJy0CJ++0aR/ANGIbUd6+Rz9Yk0YX2ufigeeK5dFV3exaZ0nOTUMy11
	 4IZO1NMgy+9W3HMJusq9FdpLbm0Vw4b5PM4Dq9QOcGIYm2Gky9MO4ZdcDc0Lwi8S/R
	 cjDJ1Dgt4yFZP7UmlHPxJS9BvSdQk62mBEpZIUKTzPHy9VSpD/19dMrNFrnWt6pKP7
	 4awak0TP0y99eYxiHvn/rBQhImzbMUEUVyh7mLYupiQN9VC7CgzuMSv3LHzdCkQFm5
	 gWgjY9BrqHRtSlaTMKOv8zsZO0Ys0U0cTUAiITraLL3nR1iR9HvcYh8MiZJaDtCepi
	 hiEWT2vz1FXMw==
Date: Tue, 18 Jun 2024 10:02:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [TEST] TCP MD5 vs kmemleak
Message-ID: <20240618100210.16c028e1@kernel.org>
In-Reply-To: <ee5a9d15-deaf-40c9-a559-bbc0f11fbe76@paulmck-laptop>
References: <20240617072451.1403e1d2@kernel.org>
	<CAJwJo6ZjhLLSiBUntdGT8a6-d5pjdXyVv9AAQ3Yx1W01Nq=dwg@mail.gmail.com>
	<20240618074037.66789717@kernel.org>
	<fae8f7191d50797a435936d41f08df9c83a9d092.camel@redhat.com>
	<ee5a9d15-deaf-40c9-a559-bbc0f11fbe76@paulmck-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 09:42:35 -0700 Paul E. McKenney wrote:
> > FTR, with mptcp self-tests we hit a few kmemleak false positive on RCU
> > freed pointers, that where addressed by to this patch:
> > 
> > commit 5f98fd034ca6fd1ab8c91a3488968a0e9caaabf6
> > Author: Catalin Marinas <catalin.marinas@arm.com>
> > Date:   Sat Sep 30 17:46:56 2023 +0000
> > 
> >     rcu: kmemleak: Ignore kmemleak false positives when RCU-freeing objects
> > 
> > I'm wondering if this is hitting something similar? Possibly due to
> > lazy RCU callbacks invoked after MSECS_MIN_AGE???  

Dmitry mentioned this commit, too, but we use the same config for MPTCP
tests, and while we repro TCP AO failures quite frequently, mptcp
doesn't seem to have failed once.

> Fun!  ;-)
> 
> This commit handles memory passed to kfree_rcu() and friends, but
> not memory passed to call_rcu() and friends.  Of course, call_rcu()
> does not necessarily know the full extent of the memory passed to it,
> for example, if passed a linked list, call_rcu() will know only about
> the head of that list.
> 
> There are similar challenges with synchronize_rcu() and friends.

To be clear I think Dmitry was suspecting kfree_rcu(), he mentioned
call_rcu() as something he was expecting to have a similar issue but 
it in fact appeared immune.

