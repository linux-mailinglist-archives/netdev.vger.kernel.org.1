Return-Path: <netdev+bounces-268675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODTkJ4J/uWmxHAIAu9opvQ
	(envelope-from <netdev+bounces-268675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:21:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DE72ADD75
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27B2A30CC1B6
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FA62F9D83;
	Tue, 17 Mar 2026 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1BxvLWA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658D7283C87;
	Tue, 17 Mar 2026 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764102; cv=none; b=OQ1bRU7jJGsUER5tWyAV79ITJyA7jP1z3wmyTKfqtrzHHA1DTIm2Y5dWfkAavfXWdM/8ryp6vxrpuwv46B112NoVltbWmmIpNz7Ts9qgi2LqLkULKTbbSwjJEBWShdnpiSjXDZgto/KRABk7+ca6mOLUkw2p0+6odBVuE9QhOC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764102; c=relaxed/simple;
	bh=UphfycUSWzpIkA6CM6q6KSYT3Kt5Z/+FEK5eSxrCnWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCjfxAlPoz3xkCIkStlkN9unqL43KGwQYFtY+ogiP7AU4Koig8eRc71XZR1iyX1woovTloKvn/+CkwvGKSohKwvy4m34PSjuDlL7V4ubWf/8DhyPYi1I0LqPozDmYR53xLLDXpmAumDPayj3NjNeZBJJhg8GYOym4gPnuwLgA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1BxvLWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E54C4CEF7;
	Tue, 17 Mar 2026 16:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773764102;
	bh=UphfycUSWzpIkA6CM6q6KSYT3Kt5Z/+FEK5eSxrCnWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d1BxvLWAsohB++QNIhLN1YFQxrt4XnXj1JFsUQfvSoT0fFAnVztCTtpfjx7vKPnxk
	 6qGdhQo7nzE4F/mNL5Q0sRYKWEabLJX9GtIKERlnnLmzq8mMQj9bDY61FQ9eqlW3Tj
	 f5igX67Ru650I2e+gbseyqLyoGULpN4rj+znIUcrTwIcRzHzO3e9JfKhSfEuLpsCWC
	 Pqb8ttQoAR4pBXYhDFNJskQm1sAqZGUNGp1d8CbcljJ5uraC0X5mW23HaLS4sIxBwv
	 0nJp+xPBBBUq5MbgvSXUtiH6VYxzrFIJYnFvfcigqDjLGn7XX5B9KSqtUwO/MGZIWm
	 D8oyPcOa6WzTg==
Date: Tue, 17 Mar 2026 09:15:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: stfomichev@gmail.com, horms@kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, jasowang@redhat.com,
 mst@redhat.com, przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 jacob.e.keller@intel.com, ronak.doshi@broadcom.com, pcnet32@frontier.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 0/7] Introduce async callback
 ndo_set_rx_mode_async
Message-ID: <20260317091500.3b3488d4@kernel.org>
In-Reply-To: <CAPrAcgMBQsVAG3utAD=7dp5tU1jjEBPO5QQGpMUrDu+rMrDJaA@mail.gmail.com>
References: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
	<20260314130601.0ec7a534@kernel.org>
	<CAPrAcgMBQsVAG3utAD=7dp5tU1jjEBPO5QQGpMUrDu+rMrDJaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268675-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,linux.alibaba.com,intel.com,broadcom.com,frontier.com,vger.kernel.org,lists.linux.dev,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42DE72ADD75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 15 Mar 2026 01:29:14 +0530 I Viswanath wrote:
> On Sun, 15 Mar 2026 at 01:36, Jakub Kicinski <kuba@kernel.org> wrote:
> > Stan is actively working on this:
> > https://lore.kernel.org/20260313145113.1424442-1-sdf@fomichev.me
> > I feel like I spent enough time reviewing your attempts and Stan
> > will not need as much maintainer attention to bring this to
> > a closure so let him cook. Sorry.  
> 
> Honestly, I should be thanking you for not throwing it out sooner. I
> don't think I was skilled/experienced to actually make it work and
> someone more qualified should handle this. On the bright side, That
> means I am now much better at solving regular boring bugs and I think
> that's what matters. Cheers

Thank you for the understanding!

