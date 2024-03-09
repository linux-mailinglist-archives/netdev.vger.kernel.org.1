Return-Path: <netdev+bounces-78933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CB887700A
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 10:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307AA1F21686
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 09:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8708B3717B;
	Sat,  9 Mar 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d62eV0yI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+3D+0CT4"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A202D603
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709975391; cv=none; b=TsmUQ2pLvWLQUA99WwdX2aOoCESG8/T2ha/gpDmUYkpoDZ1r7LCTuNAMGR89JOYqKuxO/+5+NMAJSjLhryeGhGMexZuRVsDy/AKlDx5PT4aTKJOXxmdkdWl66cSrkvAvaBbMTQCmugPeQIIdUuTuANgukhokVLH3I6EV9Gvea8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709975391; c=relaxed/simple;
	bh=yWPyjJYW/srtoEgqpdmt2d94c+ebczXgIWqVkpz6CC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZVkcuEc4MUXC5TDZAH0yvRv2EHsNWsXBhAy2Ju+fD6JQpNWPbzT/W8385bOcY8faNSczI8kd+6mm52xUJkOVVuOHxk2qr6nSpJYe2goTEzqGkpjV1LKaUi4mTTIJH+SmlQklZf8l7WeHmlVq6eSw2DlKDaks0+VF4HCwI4644w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d62eV0yI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+3D+0CT4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 9 Mar 2024 10:09:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709975388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bm4lngz3t074YUbFcGm9uFI1Xqeh/Z9CaSE4aGZGkAQ=;
	b=d62eV0yI7Isj0L+N1odw0LivnMpZCkXcr4bjnjR6QxW5OaqA0iGA7FAtDhoZnl1+sZuH8K
	O/6EU7qoxVKcuVScdUKxEy2IulB4HIfSdYqkS6vvKc+S+xyNqmefzHPKDQ5R3fDLvzaJFJ
	fQ2BjKwNpK3WPwDMTf/vMDTlTefsjwBdm5ohzXp+kXJAgVXRxIKr2NGP3XFMOwoFXMjt4x
	YzWCThNLJ1QPoqijmQzwqzwnPTFy2XFm9ZrTLcFwcaAmKHLPp9aPa2X+s8T5KEjbryG3yF
	af4rl0aZtC4Bqdr7ya2LEE7CfYWkXtYbpMtk//FOz9IIjwDaYxriUj83VLefKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709975388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bm4lngz3t074YUbFcGm9uFI1Xqeh/Z9CaSE4aGZGkAQ=;
	b=+3D+0CT4CMBTPNzOnBMPM8XnycV6cMyrMuOjuehwY0A2KNHTbB24IPYGta3GyWpcINxQEL
	cul0wa38mns33fAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v4 net-next 0/4] net: Provide SMP threads for backlog NAPI
Message-ID: <20240309090946.3T8f5Ye1@linutronix.de>
References: <20240305120002.1499223-1-bigeasy@linutronix.de>
 <20240308153302.AmmDp45Q@linutronix.de>
 <20240308202954.1cca595a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240308202954.1cca595a@kernel.org>

On 2024-03-08 20:29:54 [-0800], Jakub Kicinski wrote:
> On Fri, 8 Mar 2024 16:33:02 +0100 Sebastian Andrzej Siewior wrote:
> > The v4 is marked as "Changes Requested". Is there anything for me to do?
> > I've been asked to rebase v3 on top of net-next which I did with v4. It
> > still applies onto net-next as of today.
> 
> Hm, I tried to apply and it doesn't, sure you fetched?
> Big set of changes from Eric got applied last night.

So git merge did fine but the individual import failed due to recent
changes. Now I rebased it on top of
   d7e14e5344933 ("Merge tag 'mlx5-socket-direct-v3' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux")

and reposted as of 20240309090824.2956805-1-bigeasy@linutronix.de.

Sebastian

