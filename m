Return-Path: <netdev+bounces-163163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA66A2974B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066FF168D9B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F421FDA9D;
	Wed,  5 Feb 2025 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWRfRO3j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D641FC7DB
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738776026; cv=none; b=ObT2CIMS7XCkuyTVukKP7j5PzxRrQ5ThkM/rDAnI/tdFZNoHUx7/v5I8SrbX3xULElo7xYPwLStIPNmux/WBLRlD0lO/5rw3YCCJGZaOrB4L+N9gf1PxrTI0uK5tBKkFbJchDX57LqwMgt7WiHCH+45ipePMK6E5Vl3m/u+37GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738776026; c=relaxed/simple;
	bh=ylZCtrYwDLg4pt2U6QXAZsBDiDJ/r6FMr2FXNj7Er8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMTvL3EjdAwKpVsEmwuXpx5B0X+fK/B1u5XL39tWJp8uBxCf7k0IC+0Buqh2ny9obnx+P9yuyceRL69uD1jnRQAUgixnBnPvFpCPPWEdfrF1MJZxagNd0pd5x0p4lccAeDbbtI/SqUV5sWhtKKsoRy4DD8/AmwTg+TL9p+wwOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWRfRO3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C55C4CEDD;
	Wed,  5 Feb 2025 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738776025;
	bh=ylZCtrYwDLg4pt2U6QXAZsBDiDJ/r6FMr2FXNj7Er8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWRfRO3jwywaGrKsSrTD/2cMBA6JaMj+U7KFIyx5upnbGX1lCkcj1mH4a7nAk8i9k
	 ALNrp7A/1dj7Lyn/P02PMhFX7yNgsEFDBATZeSd8FaQ9KTxJkEWWqssMaTO5RC8fLo
	 X35kDF/UpYjGRGnv625rFQnfQ+HTrvzCTSmMrXr+NMikRzJY0e5iPSx+aY+NSOilVY
	 3bBCsoY4uu9XIR7it7LdSwfmHSX87Yyb2H2yoXBQgd0ZIdLuzptHKGJvB/bjQWHCph
	 vSKW3TYz8zxYOqmdsANtn/tZGM7pTV291KyRLb42Ot86bxxiJvbupY9s92HHxbtML8
	 URMFrCOdSF+pg==
Date: Wed, 5 Feb 2025 17:20:21 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pedro Tammela <pctammela@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
	jhs@mojatatu.com, jiri@resnulli.us, mincho@theori.io,
	quanglex97@gmail.com, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch net v3 2/4] selftests/tc-testing: Add a test case for
 pfifo_head_drop qdisc when limit==0
Message-ID: <20250205172021.GI554665@kernel.org>
References: <20250204005841.223511-1-xiyou.wangcong@gmail.com>
 <20250204005841.223511-3-xiyou.wangcong@gmail.com>
 <20250204113703.GV234677@kernel.org>
 <20250204084646.59b5fdb6@kernel.org>
 <b06cc0bb-167d-4cac-b5df-83884b274613@mojatatu.com>
 <20250204183851.55ec662e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204183851.55ec662e@kernel.org>

On Tue, Feb 04, 2025 at 06:38:51PM -0800, Jakub Kicinski wrote:
> On Tue, 4 Feb 2025 23:21:07 -0300 Pedro Tammela wrote:
> > > This is starting to feel too much like a setup issue.
> > > Pedro, would you be able to take this series and investigate
> > > why it fails on the TDC runner?  
> > 
> > It should be OK now
> 
> Thank you!
> 
> Revived in PW, should get into the run 22 min from now.

TDC and all other tests appear to be passing now :)

