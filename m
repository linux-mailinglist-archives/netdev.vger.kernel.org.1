Return-Path: <netdev+bounces-305175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K8szBx3nS2ricQEAu9opvQ
	(envelope-from <netdev+bounces-305175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:34:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFE4713EB6
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:34:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dINVRXiz;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305175-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305175-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3ED63045C8B
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 17:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E4C3B0AE9;
	Mon,  6 Jul 2026 17:26:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4A73AF656
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 17:26:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358814; cv=none; b=pdm9N5/CrC3dbAXhJ18DG4Me66xZSZscooP8tuiLVc3fYNGLLNALpBXEFXYSh8h4mLnFui9AyRm8gP2zD6WzXie1NU2sOF2TjVCyscf7Mhnn7UdC21pirTixvzsiBm1a84tfNQxdZla6sQoYhaFqZrRvirjkAcxdR+i0hYoX9S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358814; c=relaxed/simple;
	bh=g7qWqVyY+iHjDRjtLMQRnNdNWq79ioRPbSLvXsnReaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XU/uxGVKs1Ctzn/wi5B+m1+zrReZs70PznZrk3wN95LoX4fRMaECnVpUaKB9RaqUVsUnwpH+HoLpHXlAFv22pYLZNqdWsHwawHER3yZpWUpJincbbYU3HtMdV3K6BHN7i+R2u6fXnJQpwylnmqKQIdiqlOr2zBmEQ0DIPoF1xhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dINVRXiz; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493d1e8aa46so17751335e9.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358811; x=1783963611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Qhyh669ZXxHpz8jMNLJsfrGWhAXNaBuHUx0OM+dLgc=;
        b=dINVRXizQnhe364x1rtCV19YvTTCKr2/TwBqMmX01EmhNWnm4gd9sNOOF5urYcE2lJ
         mq4D9eQ7VlErKs+TsUNtF8+9vHf3Vv6u/YzXHhYP3Jc8ZBEIn259fG+F1stp+zJPyi0W
         mtzLtHj3kLQQAFKIz3QOmGGZ2ahRjO6+a9O1xJgS0qKk9xNU5roOFbn1cMAME8PgF2zo
         gCmjKBWrBetud6Py8MghrqLd5vljdm9uVnOZcieV6ayc86GVW4mdVvj5xIw01hHbzt3/
         Hb4cGljF0H/WJh4AMJtujeC/l3nsn5/a2k22Q/PP0giApoqhwqAouQ0f37sne81Uo2+W
         YG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358811; x=1783963611;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Qhyh669ZXxHpz8jMNLJsfrGWhAXNaBuHUx0OM+dLgc=;
        b=bt6I0gJliBHvdmGQyEtcG6EG/vog8jeAX1x/hn0uT0dCO4HZlX5qcSPkeaXfuEVT01
         sQECmrcQ121t5dJ9nim3OBmg5RmrAkTCEQ/cdnTi9eqC9rcEiH5QzSZ+aqBCX/NVelXL
         49lQiNb++XBN9tTmXcx4+GNwki0YGgQKT63c4CMMA+ORVJs2980uECcfmvIa2stHX+6p
         U63hUf/evGymKXHw9VxnZPuK8ydy3HdaOVGaLqv55ivVsB+A956AFh1NG0DB1RlcY7OA
         0Tiuzm/lENOXdSz/JUhOG/nQ5pnhv/8dKhK1SmUnng5xjzQ2vk8DzxiCpdyUx8oGSi0K
         CRnA==
X-Forwarded-Encrypted: i=1; AHgh+RoC1yj+zQSehLrMrKidNZAhyVZIYuXXy4S3oU6QJfEQz516e8zqAO9yNyQWNB3KLtqAv4WvETM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXIY2o2ETN61V3qGoh94YQY5gmDrvM3XMWmwOBS+zrnqzE2l+R
	fNXTgCwA+VtsQA4hVT45kcIyexV6L1uCLQAdllKg6uOeMWlwRaM2JecT
X-Gm-Gg: AfdE7cnFkDhGO2rQqxX/F60wA9+F4PUd2jsveMnxpmSzXMHhpiqRatJxEh63zif0Xbc
	mHnz9fdxKPz4TXkh+h06ms+WN86ZX2h1qp05LC5lWK6aGKmrZsWCpXoYhP0y9kaxizitHj1KpUl
	gz/KFIpYFNwk2hg5q4Nxag/7ibgy2giFAxe5jwuL7Vwo9FZTLvy3eO2mcycw8WUNyA29MG6/rif
	0QludUXIf+sgx81nU7i5isOhs8oAgWCcyy6fenD//3n6zlYsN9ko9I0XVLvmqrRTKL3UllOsFUk
	mInuYK3hZbdIAx68hm/1YypdQ9rWNa9ZU908BL6KkjUdEFzPw+1tT9NRg5VG8lkiDqk0dlkp6QG
	+UbMTyCPrpc+Np3RYb8TVfBTxqjaGMP/k0HOPFghE/dXG6Bk8IsI4mD/ughi7IUflvhITLxvZsv
	W988H5wW8FHad/PICGiYXgErOyAZ5MgllVPS2cO5JAhNzkKOd5LjFLqYc=
X-Received: by 2002:a05:600c:8a1b:10b0:493:c1bc:79bd with SMTP id 5b1f17b1804b1-493df08c838mr14066975e9.20.1783358811347;
        Mon, 06 Jul 2026 10:26:51 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493df702209sm5264795e9.0.2026.07.06.10.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:26:50 -0700 (PDT)
Date: Mon, 6 Jul 2026 19:26:48 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
Message-ID: <akvlWB6AkP6kQ7xO@gmail.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
 <20260706093525.13030-3-mahe.tardy@gmail.com>
 <akvdsqFhq0x19cu2@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akvdsqFhq0x19cu2@devvm7509.cco0.facebook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305175-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sdf.kernel@gmail.com,m:bpf@vger.kernel.org,m:andrew+netdev@lunn.ch,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:liamwisehart@meta.com,m:martin.lau@linux.dev,m:pabeni@redhat.com,m:song@kernel.org,m:netdev@vger.kernel.org,m:sdfkernel@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,kernel.org,iogearbox.net,davemloft.net,gmail.com,google.com,meta.com,linux.dev,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DFE4713EB6

On Mon, Jul 06, 2026 at 09:58:09AM -0700, Stanislav Fomichev wrote:
> On 07/06, Mahe Tardy wrote:
> > Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> > sending data. This provides a mechanism for BPF programs to emit
> > telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> > socket types with IPPROTO_UDP protocol but could be easily extended to
> > SOCK_STREAM and IPPROTO_TCP in the future.
> > 
> > The API consists of six kfuncs:
> > 
> >   bpf_ksock_create()   - Create a socket (sleepable)
> 
> [..]
> 
> >   bpf_ksock_bind()     - Bind socket to local address (sleepable)
> >   bpf_ksock_connect()  - Connect socket to remote address (sleepable)
> 
> Since you're doing only UDP for now, maybe you don't need bind/connect? The
> kernel should autobind (by default) when you sendmsg over UDP socket (IIRC).

Yep indeed, I kinda overlooked that as I started with UDP & TCP supports
and mostly added the args checks. Another thing is that send is simpler
since only used on connected sockets, so you just pass the struct
bpf_ksock and data. So on one side it would simplify the current
UDP-only API for now by removing the kfuncs but we might need a more
complex send kfunc (something like sendto).

> 
> >   bpf_ksock_send()     - Send data through the socket (sleepable)
> >   bpf_ksock_acquire()  - Acquire a reference to a socket context
> >   bpf_ksock_release()  - Release a reference (cleanup via
> >                          queue_rcu_work since sock_release sleeps)
> > 
> > The setup kfuncs bpf_ksock_create, bpf_ksock_bind, bpf_ksock_connect,
> > can be called from SYSCALL programs only. While bpf_ksock_acquire,
> > bpf_ksock_release and bpf_ksock_send can be called from SYSCALL and LSM
> > programs.
> > 
> > The implementation follows the established kfunc lifecycle pattern
> > (create/acquire/release with refcounting, kptr map storage, dtor
> > registration). The kernel socket is wrapped in a refcounted bpf_ksock
> > struct. Cleanup is deferred via queue_rcu_work() because sock_release()
> > may sleep.
> > 
> > The kfuncs are only compiled when CONFIG_INET is enabled, as they
> > specifically support AF_INET and AF_INET6 sockets.
> > 
> > The socket operations go through the expected LSM hooks instead of
> > by-passing them like many kernel sockets since those are created by BPF
> > programs and thus system users. Thus bpf_ksock_send() kfunc, which is
> > exposed to LSM progs, has a re-entering protection to avoid recursion.
> > Also, because of the LSM checks, we prevent the use of the kfuncs from
> > asynchronous workqueue as the current value would then be invalid.
> 
> [..]
> 
> > A bpf_ksock_max sysctl is added to limit the maximum number of BPF
> > kernel sockets that may exist in each network namespace. Out of
> > simplicity for now, the settings is host wide but the counters are per
> > network namespace.
> 
> What is this guarding against? Rogue bpf programs creating too many sockets?

Yes. AI review raised this because users are prevented from creating too
many sockets by bumping against the max number of fd and this would
allow them to create way more sockets. I kind of agreed that having "a
limit" on resource creation would make sense but maybe it doesn't and we
can simplify this!


