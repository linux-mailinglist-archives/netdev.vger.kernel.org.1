Return-Path: <netdev+bounces-166581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D48A367F1
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33F91724F6
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2751DB122;
	Fri, 14 Feb 2025 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5B6iYLA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CD54A08;
	Fri, 14 Feb 2025 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739570447; cv=none; b=gf6ELGkJkF5l0LkkAyp+z1KfWO0nfuassZ06hh9dPkgwYPQO8DVPlzZxrGrqQ4ASZu2xGk7nH3EHIH2PojqxE6MBeeemsZ+NtPSXI3zWCEMQzflYQXSM+//EqdqpqgJ59i9FZ6lqWfa8+Vk16PIsjA3x3+bxfjoddCnCAaE0vHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739570447; c=relaxed/simple;
	bh=Z8hItMz1DzjYETMic8X3EnxNO+VEcvLxH/HMLZogLwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnOETKudLe3m33KAkvvMSsYFZkP3bEK5+crazHIyOzIeadEmsgEP2GlmwnkNWz+5tJhk7pAyNUiq/sVngs8scA2QU0reQAQnpXSZ8vdB8zFKItmSFLp1sY7u1S59pK8xIDVbvw2AkvQqwr/RGaJqwygkgonMHbz+rUF9WPmaCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5B6iYLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A957C4CED1;
	Fri, 14 Feb 2025 22:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739570447;
	bh=Z8hItMz1DzjYETMic8X3EnxNO+VEcvLxH/HMLZogLwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K5B6iYLASJgHzOIGjz1zMT/MkILvOzKcZI0xMJgT233UfVhyasoHhueMusdfx71Lj
	 QpxZctyK6X8wVIyVcdEqkp6bKNO6gAD4wJdQxNE71AN+OdDeR7lcBVVwON9BoCy4vm
	 uRYaifJFF5MrB8q5ZLwS8efistFnNA1xcSbFLSKPIBjoUM4rkQXjBuAashuI+WRNXE
	 +UququsSVwCSpGtGeyKGQJndSiS2HFbiV9O9NvD49kS/Hq5eTkXLPa+yUzxZzVnMf2
	 tXFQxZ30PPD6ztZjJ1Aind6Vj9qJHF6akHOhIc3YEVXtUkWNMreSNCT4s0DEc2NTzo
	 vtDZU1msGS08w==
Date: Fri, 14 Feb 2025 14:00:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, LKML <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will
 Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman Long
 <longman@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Hayes Wang <hayeswang@realtek.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] net: Assert proper context while calling
 napi_schedule()
Message-ID: <20250214140045.547f1396@kernel.org>
In-Reply-To: <Z65YNFGxh-ORF7hm@pavilion.home>
References: <20250212174329.53793-1-frederic@kernel.org>
	<20250212174329.53793-2-frederic@kernel.org>
	<20250212194820.059dac6f@kernel.org>
	<20250213-translucent-nightingale-of-upgrade-b41f2e@leitao>
	<20250213071426.01490615@kernel.org>
	<20250213-camouflaged-shellfish-of-refinement-79e3df@leitao>
	<20250213110452.5684bc39@kernel.org>
	<Z65YNFGxh-ORF7hm@pavilion.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 21:38:12 +0100 Frederic Weisbecker wrote:
> > > Just to make sure I follow the netpoll issue. What would you like to fix
> > > in netpoll exactly?  
> > 
> > Nothing in netpoll, the problem is that netdevsim calls napi_schedule
> > from the xmit path. That's incompatible with netpoll. We should fix
> > netdevsim instead (unless more real drivers need napi-from-xmit to
> > work).  
> 
> Let me clarify, because I don't know much this area. If the problem is that xmit
> can't call napi_schedule() by design, then I defer to you. But if the problem is that
> napi_schedule() may or may not be called from an interrupt, please note that
> local_bh_enable() won't run softirqs from a hardirq and will instead defer to
> IRQ tail. So it's fine to do an unconditional pair of local_bh_disable() / local_bh_enable().

I don't know where this is in the code TBH, but my understanding is
that HW IRQs - yes, as you say it'd be safe; the problem is that 
we have local_irq_save() all over the place. And that is neither
protected from local_bh_enable(), not does irq_restore execute softirqs.

