Return-Path: <netdev+bounces-281513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBZiHyLi72kHHQEAu9opvQ
	(envelope-from <netdev+bounces-281513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:24:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D82EB47B673
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21C373002A25
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6582F2FE575;
	Mon, 27 Apr 2026 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pRHQSdrA"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FF5279DC2
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328407; cv=none; b=KWBhdUwNNkPRSFYvyWliRUwl5AAMBFAymnj8xu/6/zHd6rDR6cTmYDyS2FNxoQ7aXOwZKZ6H6k2sqrrMdEsyb9gCYg5sqVKCkdQIre9NvdUi7VxibpTTN3FaIrM2Wn9zv9nH0SheY9hkEHbvAtRhUmBrF/hj1C7BNprd9crmNZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328407; c=relaxed/simple;
	bh=zQY1Ihl95rbJoD5Pls+d6pgq5/lc9rlQNQ7ivWYBUFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEn5faXbI3P33SYW+N5QL2ybOv8j8T8psE5o1RZZLd0ZJ859E4dcmePx22OR1Xf45z1Vg80i2bzPRH+jGL1n53Kbl22q8NIkQGtkpcYNW0mPcdjch64T9xq+8Xnae0enNKTRr0ZB6nUJf3DmgPDkWHxSl99NkgX1aIF5oLyvqmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pRHQSdrA; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 27 Apr 2026 15:19:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777328402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ng1WXyLPPjx7rAj1wQviBH2PP9whqvsrITu7SO6o16M=;
	b=pRHQSdrAbf/h1BDS/0yaVND9jPyTo1tiflzD9xE134bK3ZSxrmREwRwYb4l5Bl1ZMsnno7
	f4U0+K9k6pU1Mm2Rp9UKw9zPcgIdIrsvt2NEgxdhhZGpBwxJzu6aXtckMJoAgDva+7Vte1
	ohckSY8BSSLR+ifiEXhleWu+iqTCrko=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: nhudson@akamai.com
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	willemb@google.com, mtottenh@akamai.com, aglasgal@akamai.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Subject: Re: [PATCH v5 5/6] bpf: clear decap tunnel GSO state in
 skb_adjust_room
Message-ID: <2026427201356.-eYM.martin.lau@linux.dev>
References: <20260420104051.1528843-6-nhudson@akamai.com>
 <82df2b6834553e3f2da26e5ee1f1b880f8a1af073e6fd88894a4839c66b7b121@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82df2b6834553e3f2da26e5ee1f1b880f8a1af073e6fd88894a4839c66b7b121@mail.kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: D82EB47B673
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,google.com,akamai.com,iogearbox.net,gmail.com,davemloft.net,redhat.com,linux.dev,meta.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281513-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 20, 2026 at 11:19:31AM +0000, bot+bpf-ci@kernel.org wrote:
> > +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
> > +		    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> > +					 SKB_GSO_UDP_TUNNEL_CSUM)))
> > +			shinfo->gso_type &= ~(SKB_GSO_UDP_TUNNEL |
> > +					      SKB_GSO_UDP_TUNNEL_CSUM);
> > +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
> > +		    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
> > +			shinfo->gso_type &= ~(SKB_GSO_GRE |
> > +					      SKB_GSO_GRE_CSUM);
> > +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
> > +		    (shinfo->gso_type & SKB_GSO_IPXIP4))
> > +			shinfo->gso_type &= ~SKB_GSO_IPXIP4;
> > +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
> > +		    (shinfo->gso_type & SKB_GSO_IPXIP6))
> > +			shinfo->gso_type &= ~SKB_GSO_IPXIP6;
> > +
> > +		/* Clear encapsulation flag only when no tunnel GSO flags remain */
> > +		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> > +			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
> > +			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> > +						  SKB_GSO_UDP_TUNNEL_CSUM |
> > +						  SKB_GSO_GRE |
> > +						  SKB_GSO_GRE_CSUM |
> > +						  SKB_GSO_IPXIP4 |
> > +						  SKB_GSO_IPXIP6 |
> > +						  SKB_GSO_ESP)))
> > +				if (skb->encapsulation)
> > +					skb->encapsulation = 0;
> > +		}
> 
> All of this new GSO flag clearing logic is added inside the if (skb_is_gso(skb))
> block in bpf_skb_net_shrink(). Does this mean non-GSO packets bypass the
> decapsulation state clearing?
> 
> BPF programs can call bpf_skb_adjust_room() to decapsulate non-GSO packets
> as well. If a non-GSO packet undergoes decapsulation with the tunnel headers
> stripped, but skb->encapsulation remains set, could this cause downstream
> network stack components to misinterpret the packet as still being
> encapsulated?

It has been asked multiple times by different AI review agents but has been
ignored afaik. Please reply/address it so they won't reiterate. From
a quick look, bpf_skb_net_grow() sets the encapsulation regardless
of skb_is_gso.

