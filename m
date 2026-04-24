Return-Path: <netdev+bounces-280900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKJFImy86mlPDAAAu9opvQ
	(envelope-from <netdev+bounces-280900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 02:42:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D56AE45897E
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 02:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C6B430078E8
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B14717D6;
	Fri, 24 Apr 2026 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sZLSlA2s"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7603A1E7C18
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 00:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776991337; cv=none; b=IN5RUe6NcHPY43KGDVaBy2Y57eNl5YhSUPc5Hq4eV8xMcNIvvbJBpXREfgp1o+vVfca0CgqG9aUvI/vHRBmOZz+Feo9RcYqKhBvZzx79VEbieDGD012rzJ2bHv6CbRSYhlMOF0u6HnnoOQ4BKUTTE+S1MsNIbJc8H+t3G7v+Qgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776991337; c=relaxed/simple;
	bh=HxasFVtwjC3AOAksdUMADU4qhgML9rAHGFKuZRPB1Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFIfSLSivpVCus26cwJ6r32LjWJcuRjSH9UxLzG4yWFEzh9aPym3DjUsYkqCETFeXmITegeWTdEXOOXbqKhqYTsGm9uSuE7JDotmmsBLxHRdlBSN1XPsJKWFFuxH7ro4qVBz/9GGF5zMv0TghN45S2yfRehz0SjQoYeYIkXYRzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sZLSlA2s; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 23 Apr 2026 17:41:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776991324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=potNxk/pM0MniWtXALjT6MlDua7BAZZZoXk/cZMfdQ4=;
	b=sZLSlA2soQ8pThSVn3XG4aIICFiQLDgQm5dkRFbvhTfKjP0oKC87OMh/0x23uR8xA2u6ZG
	PjD3GUkyivNoonqHC1KyHu6/wmt954V1AoZH+ghMKwgIaeU25fINHtVeWfEkLP2ccVbi3Q
	eKAyX8XCGIH9z2hGaUegBhqiyHcVAL4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, Leon Hwang <leon.hwang@linux.dev>, Kees Cook <kees@kernel.org>, 
	Fushuai Wang <wangfushuai@baidu.com>, Menglong Dong <menglong8.dong@gmail.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH bpf v3] bpf: Fix NULL pointer dereference in
 bpf_sk_storage_clone and diag paths
Message-ID: <202642403529.Rc5t.martin.lau@linux.dev>
References: <20260422065411.1007737-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422065411.1007737-2-bestswngs@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: D56AE45897E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280900-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linux.dev,baidu.com,vger.kernel.org,asu.edu];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 21, 2026 at 11:54:12PM -0700, Weiming Shi wrote:
> @@ -668,7 +670,11 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
>  
>  		diag_size += nla_value_size(diag->maps[i]->value_size);

This is the same issue pointed out as v1. diag_size is updated with
a smap in diag->maps[i]...

>  
> -		if (nla_stgs && diag_get(sdata, skb))
> +		smap = rcu_dereference(sdata->smap);
> +		if (!smap)
> +			continue;

... and then nothing is stored in skb, so diag_size is incorrectly inflated.

> +
> +		if (nla_stgs && diag_get(smap, sdata, skb))

diag->maps[i] can be directly used here. I fixed it up before applying.

>  			/* Continue to learn diag_size */
>  			err = -EMSGSIZE;
>  	}
> -- 
> 2.43.0
> 

