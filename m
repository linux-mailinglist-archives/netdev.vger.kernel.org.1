Return-Path: <netdev+bounces-276688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAVTHL6l1ml9GwgAu9opvQ
	(envelope-from <netdev+bounces-276688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:00:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E60293C2282
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6A80306436C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 18:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEE23D9053;
	Wed,  8 Apr 2026 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/3pooMV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487CF3D890F
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674607; cv=none; b=FjIIJZKBXgffHLgB3lc8Do24D3h5m1EHf+DEAl55gbLmiiviOpUYV5tjMTv7MQ6fV3rukemHSpjyxK3gYFmyj08YDVX/dTDAvZee7jO5aOWlFwsvHsxBZ3jro2JLXd7Ihta2s4vhLhXvfTrNgp7sYDj2Sf8BHn79e/UJLnY+TEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674607; c=relaxed/simple;
	bh=crZm2PijcEAXzpKSJa5xA82z7xsDYnBu7ZN0nWLhBuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h192IhCcoZtJiaru9VmSS3p1L9qKb261YBPhL+nE2mwImo3LYPPD2tZmyT1XjI/EiYuD+l3I1ejsyPNBEE/3ixC+mRLPa1K5dvtHYnjFCLj0bwaOhonrl6EO9nuCr1fsqdkGQbZKDhR8cg1b/9Qxz7OsaHVXJut6SP6d7xRF8tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/3pooMV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4888375f735so576255e9.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 11:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775674602; x=1776279402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SerQ/zT5jOcTdy+y8E9YY089fNttq9APZn3BZTXc58=;
        b=j/3pooMVrumXrMdNyTUFFQ2zdsP2Y8tQqosjKcKYNA7TzLaJ4DfPI5q/DpK5Bd8k6z
         CWt9T8JOdAsQ8jZfHTV9AC0ezqEMRjHfBlq08e6iezIgovNg6QkkdePK9y2LFh59ioZU
         KLe7K0P2jgoTQfKcMdtbvg2Jz7z1ISNO9B5VZFfsKpv0AewkU0EtMhvRejYfh5jB59X2
         TvpqnRsfHv7Bfj13a6GFqOkh3Bqt5FZGrNvj1zLvOh7paRgIgXFm1UVkdqf0c6e9B1yq
         4v0XBypuFMSrQsyv1xzGoJYrmeHeYTxykBXGIQwTkcGEX26VFxQsfZjwLe5IYnW91hls
         GXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775674602; x=1776279402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6SerQ/zT5jOcTdy+y8E9YY089fNttq9APZn3BZTXc58=;
        b=YWrweDE0klvGAm4K+3Os2OOsmXLG2lgzO9eSCdV4wAi2Gq9CbNWxjLjfAHhieCjmRH
         Ykxcy8D1/9fPAmPfn1Uk6nkXDZLcOTu9m++ddlNUFPF7kNPptpZev+UBSIfCCzZaSm0E
         L5ma3XsAOKNmQnwWxRtIq+wYxFn/QY28lNWdqil5cSbgnQXXJycsR9P3ZnA0Wiz3tdZ2
         uh35IbsraK2Z/Ig+TE1br8tOBWl2Pgk9z+ZV21bUxx3pWY5E+/iH4m9H+JtwqVsSUBnK
         Cz+m/61m9UkIRJ7V3HNjOLtGIIsArczM9yn1Or7knVurB/kLwe1h4AWT6/kK2mOuFKFk
         orBA==
X-Forwarded-Encrypted: i=1; AJvYcCUeNLUzdN/6qefG76TMhAK69tgDIVw+VD3u1KKwLFPpgtbYxUH3YPo6O7GY1jIVQa8rNu+eWgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe1tZnBY1eolt6QOlRTvaAu5z+taHOprqhTAPOVr1lyOvp4Leq
	HLii0I53toJ4/zrUTj3DvCH+6TqgBqpaKW36zE4IYNtbqQXwZXahacEO
X-Gm-Gg: AeBDiev75DjqNrdgxQWcQcHATL7DcyYxtnhJG/IpEW841nAuAjIG8h5LN3XXiV3NC4H
	eTaHB09aVjYEItInbsy3KO3dXerGonp31ApXAIRVH+bZHlg8UPSuk9IE0xeBizL1jDuI1JiQ2nR
	0BhY7qkmY3OIcWOrDlzAZQjTycjRA4iaL9LJEapOmv1F799LyGCNQs6WvzB+H+qlQ7qkUx/NNOr
	z6h9y/4JHHE9P9MZ5/nvB/RWCOTM87wYOWD2SaP12/OIiE8feR0dJoVTpBz5htLYVx6nFiBBeKH
	Jog0/1PYMTuJMxgj6DS3/oTsCHpS+f4jNAF7TSL3n65P6apbmimeyh3vVF7GzdM/HCbSyafoYZX
	gLSPSLgYXe7JMLGCy/cAvJHNe+d72aUtkIIm9pwHh6rMHiRf8h2GgYOJaKut2vT4DGdkKSKD+ZP
	8G7P5BjXykfzOMZpRcYj3CNIAMDTbzkcqvYZkPJXyNuAjatDLVLQSt8rnGCsWfHd/b
X-Received: by 2002:a05:600c:630a:b0:485:2fe9:336f with SMTP id 5b1f17b1804b1-488998e3cbemr314394195e9.30.1775674602340;
        Wed, 08 Apr 2026 11:56:42 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e221bsm57990166f8f.29.2026.04.08.11.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:56:41 -0700 (PDT)
Date: Wed, 8 Apr 2026 19:56:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 metze@samba.org, axboe@kernel.dk, Stanislav Fomichev <sdf@fomichev.me>,
 io-uring@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v3 0/4] net: move .getsockopt away from __user
 buffers
Message-ID: <20260408195640.324ee932@pumpkin>
In-Reply-To: <adZcnNgxhsUjAgZW@gmail.com>
References: <20260408-getsockopt-v3-0-061bb9cb355d@debian.org>
	<20260408122653.295953dd@pumpkin>
	<adZcnNgxhsUjAgZW@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276688-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E60293C2282
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 8 Apr 2026 06:52:54 -0700
Breno Leitao <leitao@debian.org> wrote:

> Hello David,
> 
> On Wed, Apr 08, 2026 at 12:26:53PM +0100, David Laight wrote:
> > On Wed, 08 Apr 2026 03:30:28 -0700
> > Breno Leitao <leitao@debian.org> wrote:
> >  
> > > Currently, the .getsockopt callback requires __user pointers:
> > >
> > >   int (*getsockopt)(struct socket *sock, int level,
> > >                     int optname, char __user *optval, int __user *optlen);
> > >
> > > This prevents kernel callers (io_uring, BPF) from using getsockopt on
> > > levels other than SOL_SOCKET, since they pass kernel pointers.
> > >
> > > Following Linus' suggestion [0], this series introduces sockopt_t, a
> > > type-safe wrapper around iov_iter, and a getsockopt_iter callback that
> > > works with both user and kernel buffers. AF_PACKET and CAN raw are
> > > converted as initial users, with selftests covering the trickiest
> > > conversion patterns.  
> >
> > What are you doing about the cases where 'optlen' is a complete lie?  
> 
> Is this incorrect optlen originating from userspace, and getting into
> the .getsockopt callbacks?

Look at tcp_ao_copy_mptks_to_user() in net/ipv4/tcp_ao.c
This isn't 'old code' it was added in 2023.

Basically what is being transferred is an array and 'optlen' is the
size of one element.
The number of elements is in the first one.

Yes, it is completely broken.

There was also some very old code that just didn't check the length
(probably only for 'int' sized parameters).
That might all have disappeared when decnet support was removed.

There was also a very longstanding bug that pretty much all the IP
protocols would treat negative lengths as 4.
That got 'fixed' not long ago, I do wonder how many applications that
broke! Passing an uninitialised on-stack variable would have worked
(for 'int' parameters) provided it wasn't in [0..3].
Even then there is code that will copy 1 byte (instead of 4) when
a short length is passed - but it only does something sensible on LE.

I've been though all this code trying to replace the 'int *optlen'
with 'unsigned int optlen' and then returning the updated length
(or -ERRNO) to the wrapper.
That simplifies 99% of the code.
However there are a very small number of places that want to return
an error with a corrected length.
If you were starting from scratch you could say that returning a bigger
length would return a specific errno (maybe -ERANGE) and the updated
length - but there is no consistency.

I pretty much decided that the getsockopt() functions would have to
be able to return one of:
	-errno
	length
	GETSOCKOPT_RVAL(errno, lenght)
with the wrapper separating out the merged value.

	David


> 
> > IIRC there is one related to some form of async io where it is just
> > the length of the header, the actual buffer length depends on
> > data in the header.  
> 
> Could you point me to the relevant code so I can examine this case?
> 
> > This doesn't matter with the existing code for applications, when they
> > get it wrong they just crash.  
> 
> Is this crash being triggered by the protocol callbacks?
> 
> I tried searching for this but couldn't find it. I'd appreciate any
> hints you could provide about this case.
> 
> Thanks
> --breno


