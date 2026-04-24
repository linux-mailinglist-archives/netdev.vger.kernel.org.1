Return-Path: <netdev+bounces-281037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCBtD0O762lpQwAAu9opvQ
	(envelope-from <netdev+bounces-281037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 20:49:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A86C74628E0
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 20:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E67D3006207
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 18:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7243D16EB;
	Fri, 24 Apr 2026 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mR77e+kg"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919F93F23CE
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777056573; cv=none; b=MXovzBTvJ7xJ/UHFFE5Oym28ePB/YI3e0ZvHP98VH8YKHC7KFA1rgJwvvBbi2Z//ZsLT758AAqpZ6Ttfjyr+rmpdAkjltcIcgllPEgZAXGpJHMMrQahmUVx9MmfsU+Vh58S5FeDI+DsNeu6YQlTrejeH11j9XYTryRy8v94d2DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777056573; c=relaxed/simple;
	bh=6IOZ5fpZbuwuN9Ze3ZwE4QuHE/XPBHxy1JSI0V89eYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdxCTzyzr08LI6aprnXjUWcY2x4dD5kLZd0Ko7mmfnP3qoI/0Pm9CKxnzWV2Hm8aTEZGNGfR7ls8ESwEwTqzGqWkWTVEcmAfhrgH6NOTcdx8nZ2ki84vV0D29U1mbfSF1TSNHkbbLEKl1hJZHux8HYbM6xzzP2ySxZJV3ZxthEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mR77e+kg; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 24 Apr 2026 11:49:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777056568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSZgyp08bC/BsjWgJ2L5WaVTAHLbGzENzzPVS9GKMN4=;
	b=mR77e+kgFV+3RQ1z3gkmr4d4Bpa0qyPIrOe6JnrjHLKcDyMgrNCpcqpgZRR8jSTQb+Lo8e
	tbdEdPTcAX0lef4UKk8Xphf3tDJEY+Mxz97XOQxtLFo3LthWAPWLg+Ozo4fD5zCh7/9OXU
	TXxdLhXqWVKwI/Pfen2rCS7HUy3ERj4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, martin.lau@kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH bpf v1 1/1] bpf: Fix sk_local_storage diag dumping
 uninitialized special fields
Message-ID: <2026424184430.ui0Q.martin.lau@linux.dev>
References: <20260423222356.155387-1-ameryhung@gmail.com>
 <8cc73c03-afb6-4b7d-97ea-e05d9cc56c2d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cc73c03-afb6-4b7d-97ea-e05d9cc56c2d@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: A86C74628E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281037-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]

On Fri, Apr 24, 2026 at 12:50:34AM +0100, Mykyta Yatsenko wrote:
> > diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> > index 14eb7812bda4..b50d26a542ed 100644
> > --- a/net/core/bpf_sk_storage.c
> > +++ b/net/core/bpf_sk_storage.c
> > @@ -558,6 +558,7 @@ static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
> >   				      sdata->data, true);
> >   	else
> >   		copy_map_value(&smap->map, nla_data(nla_value), sdata->data);
> > +	check_and_init_map_value(&smap->map, nla_data(nla_value));
> 
> I think check_and_init_map_value() should be moved before the
> copy_map_value(), because copy_map_value_locked() already uses
> spin lock special field, which if uninitialized can deadlock?

The src (sdata->data) lock is used instead of
the dst (nla_data(nla_value)) lock, so it should be fine.

