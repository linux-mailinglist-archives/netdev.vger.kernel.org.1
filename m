Return-Path: <netdev+bounces-287918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOIQNcaoBWrtZQIAu9opvQ
	(envelope-from <netdev+bounces-287918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:49:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D69540964
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1EEE3025E72
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30843AEF44;
	Thu, 14 May 2026 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MyEzHq5c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597443ADB9A
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755779; cv=none; b=uDzlczInr6Ume5O+ylq37cCbSn+fNPSvF+YuieFRoVjc0ZsllE9tIksC58Fcoo4e4LAXFgH844W13qr2TBvCK5ef5pkTftdi2Fw70FD5zGK/9G23l0ulLsNnu0yZTFTMbx1KmHlcG80EC24NIFr61xKT6oeEyyMeoxsefb6vpvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755779; c=relaxed/simple;
	bh=W2ELaAWxPWq9kV4aD5RtZ5GPohgOHYpCVcJj9TyZ2fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/A8ssKlDzk9oRJUaMpbymnAxnVlxRDw2YKkE0BoZpLCexnp1JJc/38s6eYEqfFKLhFhRjtH3xy3nESlLCwscrKfah/htIQEk8AG1uDQNGRvnCzLKaj7dRKoCxbemtAtXmww5sLE29jonRglW0tjtdVa5VrGCvrwB1lLSZ4wrps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MyEzHq5c; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd36614d329so363555366b.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1778755777; x=1779360577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2ELaAWxPWq9kV4aD5RtZ5GPohgOHYpCVcJj9TyZ2fg=;
        b=MyEzHq5coipkYbJMd1yo7waPyBK3HkZ8XjybpErDYtrdDgrj5r6HSfF/nhbiSveM1D
         bs+GkhECWjRn6m2FrgRNXo3EpYuqGZmfvNr0n7g72YwN3yM4v2cHFp3VC6lbU+l+HX3G
         otml/B2tvFm8bn2HxZSO7s9nTAcopIP7EyHiCHDYL6OyPEtWS2ck3FUobH/Ml7PboZeI
         86Fg+pzE0xt27l9SxaHxDHmIQ/vtKTzM1L1lStJNlkJ2CAjavVNsavKVILKfUF56IODy
         KdZhPCvitlO/kbz92w5UQRV0vlU7QPpCf+pPIy+DyedgLxk59olG3HSQpBQkeAWE6AGA
         tDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778755777; x=1779360577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2ELaAWxPWq9kV4aD5RtZ5GPohgOHYpCVcJj9TyZ2fg=;
        b=UY/vyUEuq+Jx/9O/NqJXmmskVP80sC+rZtQih0ok8y+HNAg+07xjRUbTrYQQqUtOY1
         uKfCEGmthnaFymAKd5dkpTtqW03ZkfvjjbVDDCB0qq3RZsO/WvlEo/4sGDQiRtdvJNWd
         5iANFafZi2n5hkZBhUrox39UgmWDRVXrhEPpcKjqGc7W3m6NXJYlI7bcYVg3KVXOZ9aG
         WTFZpjlUJYTsANomAV0e6+NHRU7NY72DX98p54qKiRaVZu4FUhWC19+PvNprYn1DP6tt
         QjEGVTPszd8wDU++7LxOe1RHywGoRKfLknzDd13nbEql1FHQ4MCXVBDG1PZMTGVAxGdg
         mStQ==
X-Forwarded-Encrypted: i=1; AFNElJ89u7jk7YYCd5g59jl87ARDsGcn6L9E8t8QsIg+6CRJOZXNBhRzOxPtGJA0xiK8OAHrT/71qIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZDC0CttD8bi6hXzkgtFHqMJL7ZwYyreUTqdAmT8eCez5j13a9
	XFoCia71QIvmqffjRaLl97yYb4jCVCKQL+CckUeUJpDCUH70C2I1i1wX7dR7w65rGYo=
X-Gm-Gg: Acq92OFYDclo3hd93t5WXbhhziYQ6Rf640HZr77CU48qwr2BppOO/zmpc0yw38Ab2Y7
	dGyYo34czz1NZXbl2dibh7k4i+Rv06WOR6xYrGGCp6dlCsDhJOL1t6NKS2tBcvxOIEENEFtqBt7
	O0ZxozDED5VKY7hVQb0AGwkiJ9Is6A7XLATlIEbMyOXkC6jVNaeDpPEpmvI95mgPWI6vd9X0a9n
	7ihfTgMc3wh4spmj9bXQtZOnKOpo9WObn/p8bxpmm+j0BUU2BTv77neCddgW4zXxOv5Tux1kOF/
	GdEqn1OxCC0XbaGFYdzA1c5U4QMcZPBnvyaAubIzDpCc66tAq1Qe+hEEMSzCym3PlN1di3aAhc3
	71DIr1e5LJ84dku9U9aZ7769T7ZOSZ6sC5m3AZJ9o2WY6H1Au2jHC6G+4kiVOEfg2o0IXhAD1uY
	wXj+pOIphFJhQFEo2+NXIul935Z1I=
X-Received: by 2002:a17:907:97ca:b0:bce:b80d:2843 with SMTP id a640c23a62f3a-bd3c18364famr554084766b.32.1778755776611;
        Thu, 14 May 2026 03:49:36 -0700 (PDT)
Received: from 2NNP224 ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4dec7d1sm73895166b.32.2026.05.14.03.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 03:49:36 -0700 (PDT)
Date: Thu, 14 May 2026 12:49:34 +0200
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Subject: Re: [PATCH net] net: Clear skb metadata before LWT xmit
Message-ID: <bdyx3frk2qpw5ujueebmhpyuadfybf7jtjkr5fqajytruh4c3i@yddzh6pypa42>
References: <20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com>
 <20260430173153.5cd1d348@kernel.org>
 <87jyt78y93.fsf@cloudflare.com>
 <20260513172612.6dcc5887@kernel.org>
 <dff89f5d-01ff-4869-bff2-5c5b285cf578@iogearbox.net>
 <68a1cc81-80b2-4d49-916a-2d3aca4d54a6@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68a1cc81-80b2-4d49-916a-2d3aca4d54a6@iogearbox.net>
X-Rspamd-Queue-Id: 41D69540964
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TAGGED_FROM(0.00)[bounces-287918-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:dkim]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 09:18:07AM +0200, 'Daniel Borkmann' via kernel-team wrote:
> Maybe the one case where it could break down is if you would
> try to transport data from container-related iface (e.g. tc @
> host-facing veth, or netkit) all the way to phys dev when there
> is tunnel in between. Not sure if it would survive today,
> potentially yes. In such case maybe better to move this further
> into lwt related paths?

That sounds good:

https://lore.kernel.org/r/20260514-bpf-lwt-drop-skb-metadata-v2-1-458664edc2b5@cloudflare.com

