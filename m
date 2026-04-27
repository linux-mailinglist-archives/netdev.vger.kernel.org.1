Return-Path: <netdev+bounces-281520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMjvEdzl72kFHgEAu9opvQ
	(envelope-from <netdev+bounces-281520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:40:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B169147B8EA
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 529EE3016818
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1605834C806;
	Mon, 27 Apr 2026 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XJLizVjH"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A720F17B418
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777329624; cv=none; b=JzHGIAbkaUVvTPA+KM6hCu8y+kBSIFWpd6B+hdP4vkOm217N6S/FToH2x9irHRoFu7M6dG4uYtyAPLIcQNXmXPqf4MbQlUUDoQxdlMm48e59rrotCwCLXiMhL5pOgrwoj7QYLwhNt5GhTWLN067n8pTzClegQphod50OmaMO9/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777329624; c=relaxed/simple;
	bh=d5GAfifer7UhwpqXfJzxG4VAbQdW+fQHcgwzYkW70Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDkcPvTNIrYbrN52GTddRg4TK1Ay7W9T18rkmTIQAWvkFhR4tu2xEKZcv/KhiZVA8qn3t7c81lBdrBauXo9JrkiSmKIg191T9z8z4ZeI2VE6EQz77VluQtGctm7IEG+1bIstxrO7kajh8Zf8ioIIAUcHY0aun9vTYfQDzPvcHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XJLizVjH; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 27 Apr 2026 15:40:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777329620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WzrZN74GVBZokC1ryglYdW2bR4JGJX0G4YAAV4itqnE=;
	b=XJLizVjHfNvoYMow1Gn+PESNu7GTFZH7JoiHLokhkU7NgzjoW4JfgkCkROS113iawSgOdc
	ScOEwT8TqT+nbYw5BviqAr6mlCrLzc9pExN5zvd9cXgh17qOnmbyO2gNZA79M10CW8CkUY
	Omj6sAtmd/uqwZgrobjziByoinoh4vk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Nick Hudson <nhudson@akamai.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Max Tottenham <mtottenh@akamai.com>, 
	Anna Glasgall <aglasgal@akamai.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] bpf: refactor masks for ADJ_ROOM flags and encap
 validation
Message-ID: <2026427223629.lOYH.martin.lau@linux.dev>
References: <20260420104051.1528843-1-nhudson@akamai.com>
 <20260420104051.1528843-3-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420104051.1528843-3-nhudson@akamai.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: B169147B8EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281520-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,akamai.com,iogearbox.net,kernel.org,gmail.com,davemloft.net,redhat.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, Apr 20, 2026 at 11:40:47AM +0100, Nick Hudson wrote:
> @@ -3618,8 +3623,8 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>  {
>  	int ret;
>  
> -	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
> -			       BPF_F_ADJ_ROOM_DECAP_L3_MASK |
> +	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_DECAP_MASK |
> +			       BPF_F_ADJ_ROOM_FIXED_GSO |
>  			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))

It has conflict with a recent change. Please rebase with bpf-next/net.

pw-bot: cr

