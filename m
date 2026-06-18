Return-Path: <netdev+bounces-300358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ra/HAx+wM2pSFAYAu9opvQ
	(envelope-from <netdev+bounces-300358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:45:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E52969E8EC
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:45:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=2yA6YGRM;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=a+W9Xz9h;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300358-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300358-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B6CB3054D17
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FDC3DCD90;
	Thu, 18 Jun 2026 08:39:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4733F3DBD51;
	Thu, 18 Jun 2026 08:39:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771996; cv=none; b=SLMXafs2v4Y1/hPmTETsrYP40PqzIvwlqB0ATSy7sSyG4qYIyIRlA95YHWTUg0xFcDymmi6voKktOjiGFyzazMcXaCPy+Dadb71zJcLisjTnvn2KuCahwYL5z8K1QiyftMmPiW/3402k05npZjtUGMEyebeFTiL6UTJ2NX09h6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771996; c=relaxed/simple;
	bh=90RshJNXcbS0u0V9t6gk2WT1/7k8SRI015G/Y3dPI8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncrFhGe6U5PHXm6QZTeoytWVWYid1Yd/KoG9j85+ixyjeEH52BIScFRdIt/FfvFX1EbUVdNwdUsmqnfqAF695xjsk1PA+q+hAftlqf495B/wrE4sB3ZMrnEktOxrv0qACIG3RNlAGPCRKaKg7BMmaelcvip9wvY6rrUELAYc6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2yA6YGRM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a+W9Xz9h; arc=none smtp.client-ip=193.142.43.55
Date: Thu, 18 Jun 2026 10:39:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781771993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W/ovdTd4uY76NriLjPfuTvG51woYHXGCCe1NOFnV+UA=;
	b=2yA6YGRMiIW0zc84lKoWwO1tfPH3yl0c5wDv4vHZYF63XEz0hhs9R08ZNtgtJbsYo5C7/t
	tk52D7lK1mRTHgQ9nJ+QYxFqg/e6w377FjTrLYr0nOzTCNtjFzARzzqRVxMl3dsKollszZ
	oO1jMNg81C+RyD81kgMTmQeuKYRuP9M9wmYF0BAOV/tacygPMoAbyihuaSfd0CE14SaOG9
	C7vpe72a8lXGT+iQbyyw7M70mR8IkfQuOShd0SrJIDJHGzGM4eBIY+35QVE9enVyHxrIEi
	4cLrjYBdJ0E16xKZChMgHoeicM5QIsxuzFSswMG9WMMS7Ebkgd7WXUpuSnjZ1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781771993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W/ovdTd4uY76NriLjPfuTvG51woYHXGCCe1NOFnV+UA=;
	b=a+W9Xz9hwmI/fqkVqBlUSyrE+RxOmn4jPut/eiMWAo/g35/8wP+mmVFVfNsOwmigIIocA/
	s0cY9XrlyLz9vQAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	clrkwllms@kernel.org, rostedt@goodmis.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] net: mvneta: free/request IRQ across suspend/resume
Message-ID: <20260618083952.IbGzrvJL@linutronix.de>
References: <20260617092028.1722407-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617092028.1722407-1-yun.zhou@windriver.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300358-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:yun.zhou@windriver.com,m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,goodmis.org,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linutronix.de:dkim,linutronix.de:mid,linutronix.de:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,windriver.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E52969E8EC

On 2026-06-17 17:20:28 [+0800], Yun Zhou wrote:
> On PREEMPT_RT, the mvneta IRQ handler is force-threaded. Under high

There is also the `threadirqs' option.

> network traffic, the IRQ can enter suspend with desc->depth == 1
> (masked by the oneshot mechanism between handler invocations).

That would be irq_desc::depth.

> During suspend, the kernel increments depth to 2 and masks the
> interrupt at the MPIC level (clearing the SRC_CTL CPU routing bit,
> due to IRQCHIP_MASK_ON_SUSPEND). 

The interrupt should be masked while the depth counter goes 0->1, no?

>                                  On resume, depth is decremented
> back to 1, but since it does not reach 0, the unmask is never
> called. The MPIC CPU routing remains cleared, permanently disabling
> interrupt delivery.

But why not? In my naive assumption, we get into suspend with
irq_desc::depth = 2 and the threaded should be woken up. Once the
treaded handler is done the counter should decrement by one. Then again
during resume reaching 0 leading to the unmask. If the thread handler is
frozen and defrosted on resume then it should still happen but in
different order.

Something is missing here based on my naive assumption.

> Fix by freeing the IRQ in suspend and re-requesting it in resume.
> This ensures a clean IRQ state (depth=0, proper hardware routing)
> on every resume cycle, regardless of the pre-suspend depth. This
> follows the approach used by other drivers (e.g. igb).

The igb shutdowns the device entirely, not just freeing the IRQ.

> Fixes: 9768b45ceb0b ("net: mvneta: support suspend and resume")
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>

Sebastian

