Return-Path: <netdev+bounces-300994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lCaAI5HzOGoIkgcAu9opvQ
	(envelope-from <netdev+bounces-300994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:34:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F34386ADC3C
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:34:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="H6bb/gzD";
	dkim=pass header.d=redhat.com header.s=google header.b=RonTxDXl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300994-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300994-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF263301A43F
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 08:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1870736EA9F;
	Mon, 22 Jun 2026 08:32:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FD42FE0F
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 08:32:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117153; cv=none; b=WTReMYPsX8JOx1Qjv71DAR8uZ6/IBm6r0GIvxHGognAG48B+T++z+flv5BNAAbRog2UE98zFYsNKOoDkMf1bDpUrpKO1zCWg4EWBlv6KHWPdLW83ZGZ7R0o1WPZWPgLNzA0MBGpWbT3fvNDd2AiLIYXzDjNawKTg3frLXakbNDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117153; c=relaxed/simple;
	bh=DBN/8LG+p04HamuRQZ7d4P+IeoeyPwSQTAa76Ct7epw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfIrB7+BcEI5RJjCUMhnE9D1Z1Bhis8sxQAjkojJjQeFI6DceAAvX95FPBagPX87I19uUdC3wphaPGG0j193HdNY6go5Rz6AVxbRJgbtLXzdfn8kBJqCv2wt4NgELpj0bMExHuHvQR951yXyCYdEWiDbFskWps8mi/bXbLwlO8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H6bb/gzD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RonTxDXl; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782117149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtU4LEzvpIG16gvT3mw9H8YsfN3Y3PRH6FHNr5E7SNo=;
	b=H6bb/gzDeLIrK9VWzVuDR/KDqaX9WxgqonSAEA35iWZ9sZdccD8jYQyMErC2rV2o5Erj70
	eNGLsMIuqCirJ49E5lgtBrKzva3sVHc1s2bNwsqy8xDNp/Mofn55PpewJI6mb0MfE0aiDO
	dgzbhKhIIAAeI/9WphCJnLOC0hvAAOM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-3I-6huSuOM-ZC09Zl5FZcw-1; Mon, 22 Jun 2026 04:32:28 -0400
X-MC-Unique: 3I-6huSuOM-ZC09Zl5FZcw-1
X-Mimecast-MFC-AGG-ID: 3I-6huSuOM-ZC09Zl5FZcw_1782117147
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490aeaa6517so4112925e9.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 01:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782117147; x=1782721947; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dtU4LEzvpIG16gvT3mw9H8YsfN3Y3PRH6FHNr5E7SNo=;
        b=RonTxDXleHn678FMPFdcu3rfZ8nsOPX6bPeO8FibQs8HD7WUFYiy5izB5/acD7XIhY
         KFpsxbDiKBfeAGf7yYGu2h1hcL1bbyAU/wn6xxWhqn5gFTKD0jof5+gHj5ubhfN3jM4h
         8dBAaLuep07F4+6uBvYb6KINSKXtqci+iDrVQuzsXGwHQRWP/9LWzTHKfnpDmIS5ckiS
         ptPWMEAATBZGA5b+9NJtheAqTa7S1krokCRntFIPxkyIcgn34Eu81Z+4O8vfugA9o8Qi
         DdDyRXBVVY3YX9RHDgo2fOWJVCXjnB4+JM38cg7M4EKR0nacT9vPbCzvhphCROKGgyPK
         z5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782117147; x=1782721947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtU4LEzvpIG16gvT3mw9H8YsfN3Y3PRH6FHNr5E7SNo=;
        b=dj8Jdy5AnTol9vT7sshh9+5iekkMWjIBy/hY4BElMfQd0feZ2iWI9vAUlwOSFIDK67
         3tBc0Yie0u6gdhJ/YHlS+ELXNdUfA5FnNZImTU0h2CwgWU8otWVtu75pBlz4xDrnvDah
         JH6vb+/7D8ebFdffk5OC9k3CA4o4MUGUWbgWiS0JgBHm8xvZ2MWvxj1KrQuGztwz0Q7z
         k2EXfyb93hXECGFKBhGNLRzZF/RViTOZzE4Gq6uFVECRBiowiSvIIj+uFzmXfgEUa3YB
         +mTfMiOi3MeSvr98SttZqh0Ysr/IopLVWN7wOUidYrVyb1TP6Otns0BBoJux2z5I+UYx
         wglw==
X-Forwarded-Encrypted: i=1; AFNElJ9T99vdAInNcve7ZHMb8oceFU0SKyXB8vQjfkoOCyywZBJv4DpX+Nr+s1BGXLKBJEn94TbWE/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vVY1YyhgRrXw+rEaz8AI+UBy1VDkZZpclqFcjf9bvQof1L23
	77ZjB7B4K/uCU0nSUb1e7qELxqXv1Z1Bo3m3ZyDcOYKjq0sn/Bheg+Zb+qxgTxDwxQAXC9jXTyp
	W4xU5GXpRD4ehK8AVJ5vXCm4kiLtvSC2MkxFluSVSdJe1ubtMhfLr73mM
X-Gm-Gg: AfdE7ckCvvhC4ZAdPv4Yr6hH2xBRk5IYkeAR59P6npL9fRFcObsJLnp/c1Y/SGL/IQJ
	hj8ZjLGOlodoj4Ak/t6Jk4ndwd5N+UiV0bXd6U6c3UbWygQlfteJFQvknvfFxwTHoV96bf5DjIF
	jVc/HxCwPq02WwNp1oHdg9at0X0aDZG1aevjLEvuvT3kMBqei9Khrdih8fk2b6mX35azkLku5Fj
	w3p4IxtGGS4q1Ul+sROD2I+0oNoW36fvzfOvahCW2hMpaQx+fBtH3MMMqEIW0BIOT7Ounu4x/69
	YngpOToWHDVbZV9PQQxW6B2LQRICZ7C/Gjhc8K72XIrHi3r0pee6pA6RkAsb9H1bj+QIaL3tAS3
	q
X-Received: by 2002:a05:600c:8b74:b0:490:ade7:9ca4 with SMTP id 5b1f17b1804b1-4923ef5c3aemr98702315e9.2.1782117147079;
        Mon, 22 Jun 2026 01:32:27 -0700 (PDT)
X-Received: by 2002:a05:600c:8b74:b0:490:ade7:9ca4 with SMTP id 5b1f17b1804b1-4923ef5c3aemr98701815e9.2.1782117146523;
        Mon, 22 Jun 2026 01:32:26 -0700 (PDT)
Received: from tp ([2a02:29e1:404:f800:9fbc:ecd8:5c1a:509c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240f054e3sm283362245e9.2.2026.06.22.01.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:32:26 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:32:23 +0200
From: Beniamino Galvani <bgalvani@redhat.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>
Cc: Ralf Lici <ralf@mandelbit.com>, netdev@vger.kernel.org,
	Daniel =?iso-8859-1?Q?Gr=F6ber?= <dxld@darkboxed.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 08/15] ipxlat: add translation engine and dispatch
 core
Message-ID: <ajjzF3W-0xDC133f@tp>
References: <20260319151230.655687-1-ralf@mandelbit.com>
 <20260319151230.655687-9-ralf@mandelbit.com>
 <87a4tab1vs.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a4tab1vs.fsf@toke.dk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300994-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bgalvani@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:toke@kernel.org,m:ralf@mandelbit.com,m:netdev@vger.kernel.org,m:dxld@darkboxed.org,m:antonio@mandelbit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bgalvani@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gitlab.freedesktop.org:url,vger.kernel.org:from_smtp,mandelbit.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F34386ADC3C

On Thu, Jun 04, 2026 at 08:23:51PM +0200, Toke Høiland-Jørgensen wrote:
> Ralf Lici <ralf@mandelbit.com> writes:
> 
> > This commit introduces the core start_xmit processing flow: validate,
> > select action, translate, and forward. It centralizes action resolution
> > in the dispatch layer and keeps per-direction translation logic separate
> > from device glue. The result is a single data-path entry point with
> > explicit control over drop/forward/emit behavior.
> >
> > Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> 
> This is very cool! Going quickly through the series, this seems like
> thorough work that will be cool to have available in the kernel, so
> thanks for doing this! I'll be quite happy to retire my barebones
> BPF-based implementation once this lands :)


Hi,

speaking as a maintainer of NetworkManager, I would also like to see
this feature in the kernel!

In NetworkManager currently we are using a BPF program [1] to
implement the CLAT, but that approach comes with limitations: for
example, we can't fragment v4->v6 packets if needed, and it's not
possible to recompute checksums in certain cases (e.g. for v4->v6 UDP
packets with zero checksum, and for fragmented ICMP). systemd-networkd
is also adding CLAT support via BPF [2], with a fallback to userspace
for the cases that can't be handled in kernel.

It would be very useful to have a native in-kernel CLAT that solves
the limitations of BPF-based solutions, and can be used by different
tools without having to re-implement everything from scratch.

Beniamino

[1] https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/blob/1.57.2-dev/src/core/bpf/clat.bpf.c
[2] https://github.com/systemd/systemd/pull/41412


