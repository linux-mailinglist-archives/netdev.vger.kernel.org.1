Return-Path: <netdev+bounces-293052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPyZJxRXGWqCvggAu9opvQ
	(envelope-from <netdev+bounces-293052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:06:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BAF5FFAD8
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23D65303FB8A
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A29B3BA25E;
	Fri, 29 May 2026 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq5vIbAO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902A344D99
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045377; cv=none; b=TcfSsjftIyg5JfRm70u/v9B3+pHpFHtW27II5PkhclIa6c8gIrC4ZbAr+UwK0DsaOMNDz7LJYo/TmsvdlhI5SKhIcpM4FQHN3o9A7yjqTDx8mFKOv4oFmDFWugBRC/6vblXnQRbtg2jfZpLQxlR5W4mzsrrnCAKdR/FuUXvrF5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045377; c=relaxed/simple;
	bh=yYAsUywyR27qE6vul78x3gmb+ziWG12hAXlyRaI1uXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYMpx16By/1b9Z8C79nlThilQugOi/HpKKAk+DBlcqnlw73wnsvLwStWE75CdTpA8R01gEsY9onvis+qW7eGDxKaL3xBe3imybyBVpBxxhKRRj+wVihsNBcTFFjBv+1rfuO8ya7sgG3HR/hXnWQk3EPgIIp6Zmm1lh64MiYpq2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kq5vIbAO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49048e043e5so58928845e9.1
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 02:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780045375; x=1780650175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hgXlCsm5faN5BZz1S/HGhbOsFnx36ZERe35q1tpIjtU=;
        b=Kq5vIbAOUpLhDomSF/Ua9MOsvqV+3RV7U8CQjBkiWgQohi5iSbXbbO90hQTqEZ4UyV
         /knsowfZKl6qmh7zQurhjPTzvNTpU9XtB6rA9ESPsocG3mV+dYXHcLHeAD9ftEdTkQCL
         /0y8vIckS/8z5q5EJOI2fRrltUFU4M0djEl1T36R5iHV+NYYw36GEcE38np4w2pzMo7K
         ZTrBEBwcWgebIqcFTS+TCkpUnVrWKcUap9v4l6/Uebl6lNU1wyIdPNJtpLZAlnQwmcy3
         VrQV2fzxV9nwbqbbh8sPtrZeaqVmDwG8PbDYsZmQDkuD7MHpL03b2g40mHxozm22MO5K
         edPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780045375; x=1780650175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgXlCsm5faN5BZz1S/HGhbOsFnx36ZERe35q1tpIjtU=;
        b=K3GaJ0d5gW/Ak1KunHjAeVlwfGQrLTlOdQ1uQ1YcpDHV2zAsoQ1qd1gLk52aky3Ull
         1GaZyT0clvMvRyp3xvt3YlvQD9nAXwy+gO63LrCNM8dCnq2LmBv8DE3Bd9KLtSITQ7Ci
         JpvI7FUeVypvpHJfAsLpNUJk4ycH2a0sFqSKTHEDc3G8YTgRYBAS5rkexSHLsFGgumtF
         9+RTj0WDxL3WQV4xzbeiSXW1FUy9ww3kWf2u4p0elu9Q3PfN04VD7nE5HP8IYKUCVAbd
         sjuOWcXE8d6EPq4kWcVJhyWoxcyjsjgDbfG1tkq+ObmkBMw3WIDKhaor+R1ePTH8Lz1K
         OH8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8sC2lPtqWNEFqbySMsH97V176To+82srUalBACOU/mc1mSBPzZsGHfLsYq3EB5Uu7lMzdp+W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFr8/TW+5B/CAXUwyml2kmmbJYSlWItAXY3Kg0R9hnH0i6SLZt
	7SAv9YsglPpTuNQWOoyCqUSAr1o9mwSgVQYup1HFfvVSngJizIxZNs6M
X-Gm-Gg: Acq92OEIVy/m3AB5yF6vWDBy25YNi/Z+r4qGtJVQ+xYNe3QxxTyA/minlSCWI8bIQ3Y
	9kx+k9iMqB2zy+7O/0QrMkkTZRpFkZQlRhgWd+q/l/oi2g6GIioPPSJPbONIqkzk3Q/inBqANIQ
	XInAWNOZJbX3vLajNRnrIW1B40yVe0X7S56watkbgQrgmJv70x5FPvj7xVlzTJUN4+X+/Yl1GCU
	9uPMdSFcWwbWwzVAajwpzu9Iym1UTnfVF1LO8Far1aVc/Jj3PN/xM7yZ/qZ3xscRaK9L1wsjM3J
	P7JNWjCRGUmKTX6k2fT10CsN1vCdLia+r5GAZO4sJafZ0l0GFzc1Xsij/QNf1gSv5QDbpzZDmML
	RBnTnvOvwmTgmF7lEyOutlTSDc0FDkegN4esB7s8vWSsra8ZKU4yj+IUsDzqBQW6Z41wEixIqFl
	lEqtaGxAVWC3va1/6bemzY+/LcVLX21HslgcPU91meZcQRPbGNv5J/Q0PGWPtnwfpmNvVNvnIuA
	Kc7
X-Received: by 2002:a05:600c:4f53:b0:48f:e26a:1744 with SMTP id 5b1f17b1804b1-4909c07e7d7mr35184845e9.9.1780045374624;
        Fri, 29 May 2026 02:02:54 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6f35f8sm21915255e9.13.2026.05.29.02.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 02:02:54 -0700 (PDT)
Date: Fri, 29 May 2026 11:02:52 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Jordan Rife <jordan@jrife.io>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
	yonghong.song@linux.dev, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH bpf-next v7 3/7] bpf: add bpf_icmp_send kfunc
Message-ID: <ahlWPCJCXa6DMSwQ@gmail.com>
References: <20260526153708.279717-1-mahe.tardy@gmail.com>
 <20260526153708.279717-4-mahe.tardy@gmail.com>
 <d65aepu3gg5mzqy6umxvhwyvwq7gvpezle3f4u6dla7sorndt3@nirsf36ozbii>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d65aepu3gg5mzqy6umxvhwyvwq7gvpezle3f4u6dla7sorndt3@nirsf36ozbii>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,iogearbox.net,gmail.com,kernel.org,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-293052-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 03BAF5FFAD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 03:55:21PM -0700, Jordan Rife wrote:
> On Tue, May 26, 2026 at 03:37:04PM +0000, Mahe Tardy wrote:
> > [...]
> > +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
> > +{
> > +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
> > +	struct sk_buff *nskb;
> > +	struct sock *sk;
> > +
> > +	sk = skb_to_full_sk(skb);
> > +	if (sk && sk->sk_kern_sock &&
> 
> Won't this prevent the kfunc from working for traffic emitted from
> kernel sockets like those used by NFS/SMB mounts? I can imagine there
> being a legitimate use case where you'd want those kind of connections
> to fail fast as well by emitting ICMP*_DEST_UNREACH.

I don't know much about NFS/SMB but I'd expect them to use UDP or TCP
for their transport protocol, so the second half of the condition check:

> > +	    (sk->sk_protocol == IPPROTO_ICMP || sk->sk_protocol == IPPROTO_ICMPV6))
> > +		return -EBUSY;

should fail. Meaning that this should be suitable for it.

The goal here was to identify the ICMP kernel sockets, I think this way
should be precise enough and does not require new code. The other more
precise ways we thought about initially were more invasive:
- exposing ipv4_icmp_sk out of net/ipv4/icmp.c to compare the pointer:
  not clean as other part of the code could reuse those sockets.
- expose a helper like is_kernel_icmp_socket from net/ipv4/icmp.c to be
  used in net/core/filter.c: new exported functions.

> > +
> > [...]

