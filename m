Return-Path: <netdev+bounces-233681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516FEC17520
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8EBC1898E48
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4B436CDE0;
	Tue, 28 Oct 2025 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oD5wz8Vw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7798B34EF15;
	Tue, 28 Oct 2025 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761693191; cv=none; b=Y0QWO3sC3DH2dF25afwDQQps2pKqpOSxa+kWpzo2VPFsQlHmU+I/cz+JdQiqM+aL51vD94lVa2clhw/BjmT4nrgxUl2Q1kQ1KnQhcR5EYrMRVYKM+BJkI1S27L+DaLqsbBMpDwM/c2bbO2jbahzbXYu5m+GAerXH5JGs73SLNQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761693191; c=relaxed/simple;
	bh=AiS5+eaC+wRoxyLnfMkuh+p/vlavCHo0gn8Xi+UuLXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6cR8P9U3t5UL07eoxFOt8BiXyyA2L3SVY8wVpW5ZAN4jFFvalIep0GrjYB2cts/biDKVC1otKlriqJ0Js+5ivQWXOIkaqFYgkdcH4jNKLWwehFnASlMYuRUYDIEKzPEKxGyalBNzUGGgatMELhDKACcLNhbNsn3SfPbOzW6Uys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oD5wz8Vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D2DC4CEE7;
	Tue, 28 Oct 2025 23:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761693191;
	bh=AiS5+eaC+wRoxyLnfMkuh+p/vlavCHo0gn8Xi+UuLXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oD5wz8Vwfy8yqjaRDZr+iZ3L6fsdoCOH6+midGTWkwIQWGZjytKgVZLSjeUxQb9Nu
	 sy1RWkAgGoNVJlCPnSgWSJ3NOLH47t23povygYgfWvoMyi9CiqBXAgrOOclNQ+hVAm
	 HpztGLF4c564WU4tVBdBHRTci3iFGWdEylrG+zFDZabwXLNuxB2o6dZvNaMpn9vHlS
	 tG939c4ZUGSkImcEq/bYsvtkhNrmx2bf/gaxOJpWImL7PM4rBtjGVWwuwqxFVHSlDX
	 eAOfJyvBDeaXfluOyGL4zMayks/vmStSWUmLYljqyVYxJyPG8GGUjDa6CObZabKoCZ
	 s7bdeFpRh1pbw==
Date: Tue, 28 Oct 2025 16:13:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, junjie.cao@intel.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, thostet@google.com
Subject: Re: [PATCH] ptp: guard ptp_clock_gettime() if neither gettimex64
 nor
Message-ID: <20251028161309.596beef2@kernel.org>
In-Reply-To: <20251028155318.2537122-1-kuniyu@google.com>
References: <aQDOpeQIU1G4nA1F@hoboy.vegasvil.org>
	<20251028155318.2537122-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 15:51:50 +0000 Kuniyuki Iwashima wrote:
> From: Richard Cochran <richardcochran@gmail.com>
> Date: Tue, 28 Oct 2025 07:09:41 -0700
> > On Tue, Oct 28, 2025 at 05:51:43PM +0800, Junjie Cao wrote:  
> > > Syzbot reports a NULL function pointer call on arm64 when
> > > ptp_clock_gettime() falls back to ->gettime64() and the driver provides
> > > neither ->gettimex64() nor ->gettime64(). This leads to a crash in the
> > > posix clock gettime path.  
> > 
> > Drivers must provide a gettime method.
> > 
> > If they do not, then that is a bug in the driver.  
> 
> AFAICT, only GVE does not have gettime() and settime(), and
> Tim (CCed) was preparing a fix and mostly ready to post it.

cc: Vadim who promised me a PTP driver test :) Let's make sure we
tickle gettime/setting in that test..

