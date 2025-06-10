Return-Path: <netdev+bounces-195953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C2DAD2E0D
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCAC31890583
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 06:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D5327935F;
	Tue, 10 Jun 2025 06:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3PYYG52X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pCTXxOn7"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1131A0BFA
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749537801; cv=none; b=q5nB8ceMwC8/oUazc1GOAbMgYCfm1zc8IEyXj6hglokioT7FDhGshjIv38zFHYbwZaPjZpjlu+HXmbWWoxhcIwOvXXhCoWe7yKosfQyD8Zi4af9D6a19S/OP3YJUGp1oZM1/ZTGrqlL7tRS5ZMwAZ8zYS4YhGOcNNB5Lj3ulKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749537801; c=relaxed/simple;
	bh=sHPeGF3U0HLOqxS0XM7hLygfKpnrfH8V9f61On7pFkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYKyhLTsa36BZwhXKiagVaUPVLewJ95fgvCazti7q9po8w7BRza5DmV9txcySr93gQksHa9l2BU1/aebsGRYUVfxH44wIQzoBCX78TXJLjEAfsy7VJ1KqV0nv0CO6lCrJfMVgPiFO+TZqulRLE7Dxef4pBjeP6tiXY2+2GOxl2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3PYYG52X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pCTXxOn7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Jun 2025 08:43:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749537797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nNUZaDkolV5DrnmOzBXE2GGZf8Ihew2taqw5JXWD8tA=;
	b=3PYYG52XU/7sKj+T0yi0vEWW5GZzg64lLpfhr5lbq71eJ4oXr2aCYeDSEf4xCgdUpwDDzu
	ipVnpnz6UYH1bbtKvh8EeM++uucmV2DfOYXUCsUYqWDwFVwO/jylTGw+jzImEmiVSPs4G6
	tdb2x9cj2c20RNGeF7L80ekvhvmZag51i335jevp5VWKzILiBuu39t+uO+dWIrQ992p/PR
	pSyV+WTFBk5O2sifBXwgfCHCAzQyu4/aeso+ZOUy94We4TP5fZfcH/E3Gll9T25VCLh/d1
	Quw7AONFX1U72R8dokuKDJgLHfMrzqZTtRSgVKYoBJHpSaMOPfS8ki3I4CmMiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749537797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nNUZaDkolV5DrnmOzBXE2GGZf8Ihew2taqw5JXWD8tA=;
	b=pCTXxOn7u57lTawja6C5NAYGhPQHhm8dcUDHW6zqM0wMLnK4L3VweKguxHXsZRY2Xma3cT
	NfNDtDbS8ZGLm2Cg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>, Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, dev@openvswitch.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/3] Revert openvswitch per-CPU storage
Message-ID: <20250610064316.JbrCJTuL@linutronix.de>
References: <20250610062631.1645885-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610062631.1645885-1-gal@nvidia.com>

On 2025-06-10 09:26:28 [+0300], Gal Pressman wrote:
> This patch series reverts a set of changes that consolidated per-CPU
> storage structures in the openvswitch module.
> 
> The original changes were intended to improve performance and reduce
> complexity by merging three separate per-CPU structures into one, but
> they have changed openvswitch to use static percpu allocations, and
> exhausted the reserved chunk on module init.
> This results in allocation of struct ovs_pcpu_storage (6488 bytes)
> failure on ARM.
> 
> The reverts are applied in reverse order of the original commits.

Is the limited per-CPU storage the only problem? If so I would towards a
different solution rather than reverting everything.
I assume a defconfig on arm is everything that is needed to reproduce
this.

Sebastian

