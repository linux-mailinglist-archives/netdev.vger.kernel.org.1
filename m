Return-Path: <netdev+bounces-143217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DE89C16FA
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 08:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378441F22926
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 07:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBA51D0E35;
	Fri,  8 Nov 2024 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AnhH4xgz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7vyL7oQg"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D511D0E20;
	Fri,  8 Nov 2024 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731050410; cv=none; b=mnyjow0zPhLgS94NvWQ4A3J14e9J5PmIhtDnbpaqWDte8CRZ8H7o40fLvsa2b/i4Iye9oyLI+PCd5A+XLWrbxVnSEo9crZxRHh4IRoKkFrBjF+KNddsfwbh6HTF0VgGKteHav5LPdQLsgWmSI3NZZlJ3ScTUcyXdxWGFb5hU84I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731050410; c=relaxed/simple;
	bh=gJCl7S0bqZVvnT9SEcnwOQgBUZX+WHAwroqDTxnJL+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ck8QAkHxrDTflj9ooRVsuGKuOuzGJQLrx5sXb7tFPU4XkxxZ+sxT4AA9NrvZrkHfZr8OgOsuYXY0n3We19/FyPeE0Ffy8mIEasE3mbaGMDFENQpvQ6b+6Vxs3/Xzm9QGGRXeLfpPIESxtuJzG/j4o3slkYv+Abgk+5bsVmVmcAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AnhH4xgz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7vyL7oQg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Nov 2024 08:20:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731050405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1XdvSNOuZouYbPrso1Npt+Pw3m9uE9gj44xGyrYmPaU=;
	b=AnhH4xgzd7yEF5ZPSICzS90838h37rRz4QvNEoDVonGelJrNlW/RX0p/tso6Ybyy8ZK6QC
	IKF14CkaWFbgOfceFNhxhb2QhxU+leLMGlXWdwDF/0kyPEtfQuvK0HJ8SP8pDeRiLN7i0O
	6NuiWXP4gK480xVWEyFSwIoUb8z0dDZn24TyC13CyacDujoIGOCXZ8UcODpau7Cm+cEyPA
	jQXSHbvAC2TaKddjxmK92ulR2sbpMF6CbgVmDlQbExPBeOzRtrnOU9jEC/Xk4FaRmCxoJz
	bDY14JRtHUwtW0FUSfBtOlSeSOJTp1eLkovJ+ePNZrxJ6tyyCistLfdYhIyvaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731050405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1XdvSNOuZouYbPrso1Npt+Pw3m9uE9gj44xGyrYmPaU=;
	b=7vyL7oQgNV/EO92EBKAOkT+kUaIUcdDXypNUcpA/+SK2vhVxhAiIFnO5XGPi/PJFsdtepA
	iw7VOGjOOY1FzNCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>,
	tglx@linutronix.de
Subject: Re: [PATCH v2 1/4] Revert "igb: Disable threaded IRQ for
 igb_msix_other"
Message-ID: <20241108072003.jJDpdq9u@linutronix.de>
References: <20241106111427.7272-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106111427.7272-1-wander@redhat.com>

On 2024-11-06 08:14:26 [-0300], Wander Lairson Costa wrote:
> This reverts commit 338c4d3902feb5be49bfda530a72c7ab860e2c9f.
> 
> Sebastian noticed the ISR indirectly acquires spin_locks, which are
> sleeping locks under PREEMPT_RT, which leads to kernel splats.
> 
> Fixes: 338c4d3902feb ("igb: Disable threaded IRQ for igb_msix_other")
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This is the only patch.

Sebastian

