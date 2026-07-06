Return-Path: <netdev+bounces-305224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kh5lFwkYTGoigQEAu9opvQ
	(envelope-from <netdev+bounces-305224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 23:03:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA72471596C
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 23:03:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BUnL+QK+;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305224-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305224-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC5C5300463F
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 21:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E805A43B6E6;
	Mon,  6 Jul 2026 21:02:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14E4438484
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 21:02:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371774; cv=none; b=FAp54o6ypesGS8wGDRt9HKqZmIs2TiGE3kGscBC/ZB5+ECzifZY5BlgmSPDqV7Og5e4lga8UUNdBHewfSr+XQt39qAnbvOPcsNPRF9vcnEtewjQUpzY9aQBulEX4Nh3zddpsDIBkCFTzIjI5D/QtzAMP+pcddvDv0c7Am1lqUx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371774; c=relaxed/simple;
	bh=yE4a2OoB2EdymvEnSgE8O740pw/Pct2sb0k04H4xwtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGAXoU2PcrrdItgGm3gg3kr34t2fe9NlCth81PEm2k9FDANOqFWIpki+d8j8NW8JKeqU0MYFo5DJ3IeMasNiZh2TqUlcwMYM9Yc0+O9hWLCJqm0KZw29OEJJWfNB8Ll9FUEgiGxyRsyMpv7uZvBpDPkIHfwSOE/mJ79Vv4xSwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUnL+QK+; arc=none smtp.client-ip=74.125.227.131
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ccb0e85312so3602425ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 14:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783371769; x=1783976569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jaY5gLMzPvaPKGXT1DU4u3duCOtyWyKV0VKOG5KOP6Y=;
        b=BUnL+QK+y7nL68DJnLndwf/KjxL3gziIxvuyk/4B9HkYXwTPnfp47puFL9PMSgBEhq
         BXm4jZ8VWEfEtkloORIxSyY+usTG+vMa8rkpxf+7DF1kTvy5EeM32VKOSaybwJV1mEkb
         G2pM8KKt/7EES/e3C6ZkLeFkVxt8GAgxGT/J9ALhS7O5qDU3RGAqnZFJbKq5+385mAn4
         x8EcVTnj0G8rokD8pMgtgFKq6yjvvKRoy368tl/EiRrkZI5UXqoimcgoUnDhj4SH+BYX
         OwOcFUXxsGAb6jVU2EhUfvt1VjZEwVb+X4pkyWl40khZGRVihWNcC3FFnGsNVLuBDM3g
         4pqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371769; x=1783976569;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jaY5gLMzPvaPKGXT1DU4u3duCOtyWyKV0VKOG5KOP6Y=;
        b=B6JvC769FaDsGQaI10aDDZtQqNg3GohtKoiIEDZdueyw/isZhrquwEEpWi2pa7MXzZ
         oulkzEZg9i5dVpbIo14SD0o+hv2T7CylTGr4orFXpAdR5fevPW3Jys2KsUHcEiswdhJi
         l5zvvUxwvMfFQb7AXewxdXGVSGuJ/bg7P748Bgc/Cs49T/5OWKqHfhamm/EKzTxlXVGn
         vArsVauPZt13T8lFQTii3J3SHUON13GHceS8qjCog+lVH3vxoNsF3ENuKA3Pa+sOmUOb
         1wXsmmWOvg6D8jkOto/hPZtC4hEf3F9PVjhJG04RWJoqYaHqvCB71eqNvYvceIAvYhCp
         ptUg==
X-Forwarded-Encrypted: i=1; AHgh+RqMjQI73Jv8rH3jjcCIRIvHh6IzzQFS7DjcueFARdu9Dl2ZCe3MCGzuq1YWFUxg8hOIc0G8XMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWvnHso1uGR33jUxO7GXMhuNXiHu8bAzeSOZnYDxhA9FhZOvLr
	8nDVDXqmhjcEJl0vHUojF9KHLPdcwVpou1tKa39cj2Fy0eKL6P5ybSZ0
X-Gm-Gg: AfdE7ckMTZMmxD80zw03XrKPhVbOFs7k7dyNQUE5SLtevIpX4sjSLd66v6XdCt+Q6yw
	Hkehom/bUHTs9ccKhOmyi7RKUXj3/1phz2Pq25qvN4L3n8HUpwq1IHuEj2pOdjPP0S3CXOnQQax
	a1FviQ5Z1oWeQUJjtoBBTU1JjFfMqYz2o9Z6ATX1o8uTYWvOlgsmz14NZKlwluJU55ysIV1/xM6
	CeCHtj+JgCcjSNd/8V3XQB/NX00q+qOZzT0nDMLdvqQEO7axybXb2HGEuJMp3lusiuta9+jFmcJ
	EZRGG93E9iyNRn7Us69mWxZEKmwrUeT+J9wTUMvrA7OqhqeIAmguExrCKwF8F3Q267+1PIzEO/N
	l+j8JLaXXRfJ8mAchYZFNqYHIgIO8P9MA5ElQKVpkxFjO300Od0+mVdXPyTyYtsupNnoZpvPl0E
	wmJlOQcr3s/VG1D+4=
X-Received: by 2002:a17:902:ef48:b0:2c9:ff29:3f91 with SMTP id d9443c01a7336-2ccbe50aa67mr23504705ad.6.1783371769111;
        Mon, 06 Jul 2026 14:02:49 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb7e9sm568745ad.10.2026.07.06.14.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:02:47 -0700 (PDT)
Date: Mon, 6 Jul 2026 14:02:39 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, liamwisehart@meta.com, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
Message-ID: <akwTnnSGJpki9hAn@devvm7509.cco0.facebook.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
 <20260706093525.13030-3-mahe.tardy@gmail.com>
 <akvdsqFhq0x19cu2@devvm7509.cco0.facebook.com>
 <akvlWB6AkP6kQ7xO@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akvlWB6AkP6kQ7xO@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305224-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA72471596C

On 07/06, Mahe Tardy wrote:
> On Mon, Jul 06, 2026 at 09:58:09AM -0700, Stanislav Fomichev wrote:
> > On 07/06, Mahe Tardy wrote:
> > > Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> > > sending data. This provides a mechanism for BPF programs to emit
> > > telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> > > socket types with IPPROTO_UDP protocol but could be easily extended to
> > > SOCK_STREAM and IPPROTO_TCP in the future.
> > > 
> > > The API consists of six kfuncs:
> > > 
> > >   bpf_ksock_create()   - Create a socket (sleepable)
> > 
> > [..]
> > 
> > >   bpf_ksock_bind()     - Bind socket to local address (sleepable)
> > >   bpf_ksock_connect()  - Connect socket to remote address (sleepable)
> > 
> > Since you're doing only UDP for now, maybe you don't need bind/connect? The
> > kernel should autobind (by default) when you sendmsg over UDP socket (IIRC).
> 
> Yep indeed, I kinda overlooked that as I started with UDP & TCP supports
> and mostly added the args checks. Another thing is that send is simpler
> since only used on connected sockets, so you just pass the struct
> bpf_ksock and data. So on one side it would simplify the current
> UDP-only API for now by removing the kfuncs but we might need a more
> complex send kfunc (something like sendto).

Since you were targeting bpf_netpoll_send_udp originally, maybe sendto
is a better fit? You get the payload and the destination and you
bpf_sendto() it? We can later move to stateful bind/connect if needed.

(mostly coming from the pow of minimizing api exposure initially, but
not a strong preference)

> > 
> > >   bpf_ksock_send()     - Send data through the socket (sleepable)
> > >   bpf_ksock_acquire()  - Acquire a reference to a socket context
> > >   bpf_ksock_release()  - Release a reference (cleanup via
> > >                          queue_rcu_work since sock_release sleeps)
> > > 
> > > The setup kfuncs bpf_ksock_create, bpf_ksock_bind, bpf_ksock_connect,
> > > can be called from SYSCALL programs only. While bpf_ksock_acquire,
> > > bpf_ksock_release and bpf_ksock_send can be called from SYSCALL and LSM
> > > programs.
> > > 
> > > The implementation follows the established kfunc lifecycle pattern
> > > (create/acquire/release with refcounting, kptr map storage, dtor
> > > registration). The kernel socket is wrapped in a refcounted bpf_ksock
> > > struct. Cleanup is deferred via queue_rcu_work() because sock_release()
> > > may sleep.
> > > 
> > > The kfuncs are only compiled when CONFIG_INET is enabled, as they
> > > specifically support AF_INET and AF_INET6 sockets.
> > > 
> > > The socket operations go through the expected LSM hooks instead of
> > > by-passing them like many kernel sockets since those are created by BPF
> > > programs and thus system users. Thus bpf_ksock_send() kfunc, which is
> > > exposed to LSM progs, has a re-entering protection to avoid recursion.
> > > Also, because of the LSM checks, we prevent the use of the kfuncs from
> > > asynchronous workqueue as the current value would then be invalid.
> > 
> > [..]
> > 
> > > A bpf_ksock_max sysctl is added to limit the maximum number of BPF
> > > kernel sockets that may exist in each network namespace. Out of
> > > simplicity for now, the settings is host wide but the counters are per
> > > network namespace.
> > 
> > What is this guarding against? Rogue bpf programs creating too many sockets?
> 
> Yes. AI review raised this because users are prevented from creating too
> many sockets by bumping against the max number of fd and this would
> allow them to create way more sockets. I kind of agreed that having "a
> limit" on resource creation would make sense but maybe it doesn't and we
> can simplify this!

I believe even the kernel sockets go via lsm layer, so this enforcement
can be done in an lsm bpf program. Seems like that should be enough?

