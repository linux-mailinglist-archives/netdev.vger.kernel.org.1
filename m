Return-Path: <netdev+bounces-193429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB2FAC3F28
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA3A3A46CC
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 12:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356CA1FDA8D;
	Mon, 26 May 2025 12:14:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79F31B9831
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748261694; cv=none; b=ejNrBB+5toTyIHJRGUljhjTs0tIUz/6sZLOPx6PjoLy2Z6KQ/EWuGlu8kuYbOBmr7a0bq533YWnxauTg9mj5EIKfyxtZB9Q+5t4F9AgLvL6nyE59OpnLFDcA0HV2YzvYX4zB552nkfz0WvhBjOAzNVg6mfHQ1Lay2VcpmSZxkP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748261694; c=relaxed/simple;
	bh=9UqfnThMvum1TfmpummcbOlYu7CQNFG1uRR9cpi6ClQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjlVsc7RXPPoWKcz8m9OLl5dG0RWm045vzPnB/yUaXxE8rBFY/DW5RwCx+SSJiAEpRcj48C8PuxB+eQ/qhSbSh2nH51oTMBYUoLp3rNms2qASIcf3XtudqJooH3QbAOpm0zVzxyig6qxTjHLcrw2bGlGW4G995Rvz6R7rKTIOR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B5758602AE; Mon, 26 May 2025 14:14:42 +0200 (CEST)
Date: Mon, 26 May 2025 15:57:04 +0200
From: Florian Westphal <fw@strlen.de>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	Antony Antony <antony.antony@secunet.com>,
	Tobias Brunner <tobias@strongswan.org>
Subject: Re: [PATCH ipsec 2/2] xfrm: state: use a consistent pcpu_id in
 xfrm_state_find
Message-ID: <aDRzMLL1vMXOIgHf@strlen.de>
References: <cover.1748001837.git.sd@queasysnail.net>
 <6d0dd032450372755c629a68e6999c3b317c0188.1748001837.git.sd@queasysnail.net>
 <aDQJ+kt5c0trlfo5@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDQJ+kt5c0trlfo5@gauss3.secunet.de>

Steffen Klassert <steffen.klassert@secunet.com> wrote:
> > -	pcpu_id = get_cpu();
> > -	put_cpu();
> > +	pcpu_id = raw_smp_processor_id();
> 
> This codepath can be taken from the forwarding path with preemtion
> disabled. raw_smp_processor_id will trigger a warning in that case,

Are you sure? smp_processor_id() emits a warning when called from
preemptible context, raw_smp_processor_id() should not do that.

We use raw_smp_processor_id from various netfilter modules as well
and I never saw preemption warnings.

