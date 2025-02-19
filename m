Return-Path: <netdev+bounces-167778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DC2A3C3AD
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F2F3AFDFE
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2368F1F460A;
	Wed, 19 Feb 2025 15:29:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A631F4189;
	Wed, 19 Feb 2025 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978985; cv=none; b=KlR50vkKvtaVJCfR7aNCgmlCwo/2+W48EhhhPe5O/hG7+8Fc6V7VpDgGYaQ1rJ+D+Xq1JURTFXWPUtiMDxprUhxckUba67eJAs7xbRPXG4cTptX6DSHl/W4ncsY5SqmULVAcbdjzAatgtTKqTeCj/IBiCW5bF/cuUq1LXikIwKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978985; c=relaxed/simple;
	bh=UsKZ39nIpTlqgfW7RnzFvobcmXbvJRZKB5HsCiFSs40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlRg5rWgyQVVWBjWFK/dP1sBb9QC4LvJC5XItglAjOH4oh94y7mf1R8mKAqUwLA2/jkBAv7qQLzgAw5eVDUZMjWIQQaVCFNq6DcM6T/tq9hNXMO8vBmNmlTc4Fe1ZRCz/IgxeWWYx/FhGVF3Gl3mnHa8Pu8Eone0/Dy8/90p0vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B2AC4CED1;
	Wed, 19 Feb 2025 15:29:42 +0000 (UTC)
Date: Wed, 19 Feb 2025 10:30:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, clrkwllms@kernel.org, jgarzik@redhat.com,
 yuma@redhat.com, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other()
 handling for PREEMPT_RT
Message-ID: <20250219103006.6a1ef14d@gandalf.local.home>
In-Reply-To: <20250219102916.78b64ee4@gandalf.local.home>
References: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
	<20250205094818.I-Jl44AK@linutronix.de>
	<mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>
	<20250206115914.VfzGTwD8@linutronix.de>
	<zy3irjybyc32hnow3ckhkfsrtfm5nev44aeovinlkkfc6tyyjv@gcblibp5ng3o>
	<20250212151108.jI8qODdD@linutronix.de>
	<CAAq0SU=aU=xpw0bDwaanFh_-r5tts0QNCtSmoteP3dM8-K6BFA@mail.gmail.com>
	<20250212152925.M7otWPiV@linutronix.de>
	<mtmm2bwn3lrsmsx3evzemzjvaddmzfvnk6g37yr3fmzb77bpyu@ffto5sq7nvfw>
	<20250219102916.78b64ee4@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 10:29:16 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> After adding the probes by perf, what's the content of the format files for them?

Also, what's in:

  /sys/kernel/tracing/dynamic_events

 ?

-- Steve

