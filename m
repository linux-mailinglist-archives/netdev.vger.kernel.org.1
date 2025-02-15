Return-Path: <netdev+bounces-166721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E379FA370D9
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 22:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E2D16FF69
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 21:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1995C1EEA5A;
	Sat, 15 Feb 2025 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/WVQI4/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC55158851;
	Sat, 15 Feb 2025 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739654214; cv=none; b=Tlvzoc8ijYD1EzqDd+dmxFvOHgIBkfHcWi2zhGpa58/8T4GwTmkd1zUinaTyeIerEmbtYt5OLFWUksa3/8SE43NEfMBo4g7tw0Uq2axdq9WOaRh+h7nLw97Z01sGwo0De9DP0ibDGwFU/cw5ECbE2dFsPPSFmwOd0IQx1xrRMQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739654214; c=relaxed/simple;
	bh=ner3TNyOFY2Dhnybh/9oA+yR/WkVoDzvAfBFKBlqDck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnYiI9jRqh68TfRZDgxssG2KGEpuyImMvpVz/8srz2VaWtyyTz+GQldUKdvI/0tpGI23V1r6R/cC81a9NB1o/WSFTij4f/yyiNxqGrRT1ztVX4z7rrX6LJWpXAfJ/I54a/oRd8ZB/QatGPKHan8Hafy8RzEBtS+viPmsfxPjMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/WVQI4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF13DC4CEDF;
	Sat, 15 Feb 2025 21:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739654212;
	bh=ner3TNyOFY2Dhnybh/9oA+yR/WkVoDzvAfBFKBlqDck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/WVQI4/8AaDcJlQY+cNBnnq+j7Q3ICBzWFbsyRehFIdnHncDrFWHmbJH5IE37Li3
	 MhD8I0ktOu4fYmNr7wiHQP+ZDgt4PbnQMBv57i0ylJQHlYojqDIyr6GIWOReZcyHos
	 Ut93ikC6aJEMUxHmLxmgY+Zi8VvWsklDmu0Rz+459OlfR4JO9lpHZRM5s/vldp7TD1
	 JCofrR1ECyKFEfj8tsAVFdX6RRFcRhrWYsF4r6sbDRa7QUvNrHk7VdunjGh2mlim6k
	 bkEq5j7EgBuJ64GS7x4Dsymn+Fn1GALNi3M419xTlTF/trjC0immZVi5y0wFIkVn1a
	 X5rykiKSqFjgw==
Date: Sat, 15 Feb 2025 22:16:49 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Hayes Wang <hayeswang@realtek.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] net: Assert proper context while calling
 napi_schedule()
Message-ID: <Z7EEQalDIm1n_XRc@pavilion.home>
References: <20250212174329.53793-1-frederic@kernel.org>
 <20250212174329.53793-2-frederic@kernel.org>
 <20250212194820.059dac6f@kernel.org>
 <20250213-translucent-nightingale-of-upgrade-b41f2e@leitao>
 <20250213071426.01490615@kernel.org>
 <20250213-camouflaged-shellfish-of-refinement-79e3df@leitao>
 <20250213110452.5684bc39@kernel.org>
 <Z65YNFGxh-ORF7hm@pavilion.home>
 <20250214140045.547f1396@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214140045.547f1396@kernel.org>

Le Fri, Feb 14, 2025 at 02:00:45PM -0800, Jakub Kicinski a écrit :
> On Thu, 13 Feb 2025 21:38:12 +0100 Frederic Weisbecker wrote:
> > > > Just to make sure I follow the netpoll issue. What would you like to fix
> > > > in netpoll exactly?  
> > > 
> > > Nothing in netpoll, the problem is that netdevsim calls napi_schedule
> > > from the xmit path. That's incompatible with netpoll. We should fix
> > > netdevsim instead (unless more real drivers need napi-from-xmit to
> > > work).  
> > 
> > Let me clarify, because I don't know much this area. If the problem is that xmit
> > can't call napi_schedule() by design, then I defer to you. But if the problem is that
> > napi_schedule() may or may not be called from an interrupt, please note that
> > local_bh_enable() won't run softirqs from a hardirq and will instead defer to
> > IRQ tail. So it's fine to do an unconditional pair of local_bh_disable() / local_bh_enable().
> 
> I don't know where this is in the code TBH, but my understanding is
> that HW IRQs - yes, as you say it'd be safe; the problem is that 
> we have local_irq_save() all over the place. And that is neither
> protected from local_bh_enable(), not does irq_restore execute softirqs.

Yeah actually checking local_bh_enable() again, it's not safe to call within
a hardirq. Ok I've been thinking some more and how about this instead?

diff --git a/net/core/dev.c b/net/core/dev.c
index c0021cbd28fc..2419cc558a64 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4692,7 +4692,7 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 	 * we have to raise NET_RX_SOFTIRQ.
 	 */
 	if (!sd->in_net_rx_action)
-		__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+		raise_softirq_irqoff(NET_RX_SOFTIRQ);
 }
 
 #ifdef CONFIG_RPS


This will simply wake up ksoftirqd if called from a non-IRQ. I expect such
callers to be rare enough to not impact performances and it has the advantage
to work for everyone.

Thanks.

