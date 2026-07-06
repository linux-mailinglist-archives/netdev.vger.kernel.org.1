Return-Path: <netdev+bounces-305152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e7RlBnD3S2o2dwEAu9opvQ
	(envelope-from <netdev+bounces-305152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:44:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8467149F5
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:43:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KYUkjdZS;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305152-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305152-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DD4633DF63E
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAFB434E25;
	Mon,  6 Jul 2026 16:58:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BA5357D00
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 16:58:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357100; cv=none; b=SfNyvP1BMOfTz9fEgUVRcAJBGkAGUvcijAtkE3FcywFZXGiyEjd4vliIBULxwBbVBP17dpkHEZx7OxmrsGQlI6Nu61AlDLV+SODxNEjHgWyCZndtIe2iGVUmSqaX9N6ivDSas8HtJD1tESYktT6ujIEChdjMaOvDJfqUAlkr8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357100; c=relaxed/simple;
	bh=ww7lCt6NpJeU6KKhYEyofAyOhJWk5zB8DqbthydSzU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUplq2LMPt29VHwDjeZTAl2pN4yhB+0NsirkthHVQUleiB8tBaLb8Cr+MTTLkvYzBX+5QwY/ojYX1zthIyB9FueXKxH8cUVzXpa2ToGz7xyEKiMpAdgJ8lVpLwmB3FLCW0JyQ5Bu4HZOzqeai3wJJZins+Z49y6T55K1FRIuEVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYUkjdZS; arc=none smtp.client-ip=74.125.227.132
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cc7ef596c6so2764415ad.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783357099; x=1783961899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yCktVGKDr9d58r4vlA1PSQeqKAytnjdIS32qXzkgbaU=;
        b=KYUkjdZSCIF4b0cm2KLL1+10MAj23ccTmUc7MQPUafwirB0sEGz14heT4laggVu9uZ
         +tvO182u5QGm3t4ErE4v/NDt/k8jyal5qb8mt3sgv/AzSBtNzzS2A9KSgouMf6nf/Dxo
         xoYCDjg00EwOK3ZUHJq8AhPVtotUS1K8K9Cr1mM+JydpE9v8A9dHcGosjGoTMWI+5+Su
         9ootqqn1lGrbqHz8JJbgJg0kR/PSWTQleTA3kN29Gpku7Km35oVrhXAaqpdVQ3aRVIYl
         hoG7QVfwArwykWmz0DgtCsuMZ3AFkMOqkPhhzuZIg2biEES3YCN0P9NoOltv9D8sHb5p
         OG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357099; x=1783961899;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yCktVGKDr9d58r4vlA1PSQeqKAytnjdIS32qXzkgbaU=;
        b=DaOzTOdRnD+ShhZF3vMiqENxhQB4PPkp4OnN3dWe4+VxACJhvv+CrcvoaLTlyrLjS0
         EuDFDxdC0P3ZJ1MuSisqjYVUP3AKck4itNBIbHDrsoSjSq7a7w7CzkCcctBbB/q8gGO9
         iGTVAnQENJChfBYpbvMwSCFsqTCXhaVhKqdvwx1xg8aRM9gKUU31Qn9mg+8D6f0s7HR0
         qlj1ebIuQp0z7AKvsLZM6Y7twQ8xeVl0LX6t1Ym/xGSJ0FeJSKUlwEkQP96Pfh0mwIdJ
         fobtM3WftW/kLeTaHEYuumgIOlKzYMMZhg4m1pzizguUvrp5i0jYNyr0qJRpZXuOJrII
         RNyw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2yVwbhIp+3bxGMdojXBztDFV9kZZaylEkHmxXcyRrtp+dZzGL+LMXPKW4SkbifICyizTh++k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6+2gjijqTK8WlABSjuS759B8TQFu2/aFQj5BbyBK2iFI7TjaL
	IGU8ZMslZqRId3hcVc00Lby4lH/gQg94/5zRTIH5Y2kQkMbKvF2x81Nc
X-Gm-Gg: AfdE7cmWkeB9Ar+cO/x3nGZBlhhuo1Ik2arZWyWFNyzWehBzlV8l4XJJfQm2qQJ7LCk
	e91dMJaFY/5T7mB/Qm899v4OGrCIA7tEuEJ+zOQ+D5Z7wmZhKujCY0xS0s07NZLXB3O8INyhfBZ
	9tXylbDsHJjH8YUM2uBlEOiT7RPg+R6IMc+hw3AoNuEbxAq+F7tg+rs+yLzvqv5i7PFBoIC5PBf
	tY0PpKdX277+walTvj9f8w8uiIYZNILEm1/ZFGa0sGsLfw+s4pZ9BJcbpvNsivtU307xQ0zPV2C
	cqQR/k3d/i83QfR/ZScnC1b65wm8UqDxcPbtThHQ9A66xNs8IgV9IQYoyKrnWh4BKVsAY5cb7Br
	fka93UYLKyvkNgy2wtxNGu/jO8irFCgLoa2ACEMhvk6o0Se8BYz8cTSvbBjPtGN7cL+cv7EfMoC
	Lyroo5vbgQlYHvxLNJ
X-Received: by 2002:a17:902:d4c7:b0:2ca:ce91:f027 with SMTP id d9443c01a7336-2ccbf08784fmr14779995ad.36.1783357098686;
        Mon, 06 Jul 2026 09:58:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f260acsm54342455ad.6.2026.07.06.09.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:58:18 -0700 (PDT)
Date: Mon, 6 Jul 2026 09:58:09 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, liamwisehart@meta.com, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
Message-ID: <akvdsqFhq0x19cu2@devvm7509.cco0.facebook.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
 <20260706093525.13030-3-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706093525.13030-3-mahe.tardy@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305152-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:andrew+netdev@lunn.ch,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:liamwisehart@meta.com,m:martin.lau@linux.dev,m:pabeni@redhat.com,m:song@kernel.org,m:netdev@vger.kernel.org,m:mahetardy@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,kernel.org,iogearbox.net,davemloft.net,gmail.com,google.com,meta.com,linux.dev,redhat.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D8467149F5

On 07/06, Mahe Tardy wrote:
> Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> sending data. This provides a mechanism for BPF programs to emit
> telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> socket types with IPPROTO_UDP protocol but could be easily extended to
> SOCK_STREAM and IPPROTO_TCP in the future.
> 
> The API consists of six kfuncs:
> 
>   bpf_ksock_create()   - Create a socket (sleepable)

[..]

>   bpf_ksock_bind()     - Bind socket to local address (sleepable)
>   bpf_ksock_connect()  - Connect socket to remote address (sleepable)

Since you're doing only UDP for now, maybe you don't need bind/connect? The
kernel should autobind (by default) when you sendmsg over UDP socket (IIRC).

>   bpf_ksock_send()     - Send data through the socket (sleepable)
>   bpf_ksock_acquire()  - Acquire a reference to a socket context
>   bpf_ksock_release()  - Release a reference (cleanup via
>                          queue_rcu_work since sock_release sleeps)
> 
> The setup kfuncs bpf_ksock_create, bpf_ksock_bind, bpf_ksock_connect,
> can be called from SYSCALL programs only. While bpf_ksock_acquire,
> bpf_ksock_release and bpf_ksock_send can be called from SYSCALL and LSM
> programs.
> 
> The implementation follows the established kfunc lifecycle pattern
> (create/acquire/release with refcounting, kptr map storage, dtor
> registration). The kernel socket is wrapped in a refcounted bpf_ksock
> struct. Cleanup is deferred via queue_rcu_work() because sock_release()
> may sleep.
> 
> The kfuncs are only compiled when CONFIG_INET is enabled, as they
> specifically support AF_INET and AF_INET6 sockets.
> 
> The socket operations go through the expected LSM hooks instead of
> by-passing them like many kernel sockets since those are created by BPF
> programs and thus system users. Thus bpf_ksock_send() kfunc, which is
> exposed to LSM progs, has a re-entering protection to avoid recursion.
> Also, because of the LSM checks, we prevent the use of the kfuncs from
> asynchronous workqueue as the current value would then be invalid.

[..]

> A bpf_ksock_max sysctl is added to limit the maximum number of BPF
> kernel sockets that may exist in each network namespace. Out of
> simplicity for now, the settings is host wide but the counters are per
> network namespace.

What is this guarding against? Rogue bpf programs creating too many sockets?

