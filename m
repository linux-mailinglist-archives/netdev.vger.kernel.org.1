Return-Path: <netdev+bounces-302975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c/jZGIZYQ2p7XAoAu9opvQ
	(envelope-from <netdev+bounces-302975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:47:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F22436E0884
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:47:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BxJ9UAEA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302975-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302975-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D486300E29C
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C013CF211;
	Tue, 30 Jun 2026 05:47:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255F34F255
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 05:47:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782798466; cv=none; b=Tfge7DJng/uHvz1wc4tNdDDDZ9tt6oUd7WlGeXWZTwxpbSecAkGNWo7Rt1UjdZO3BEFI6Al7RYDmpwqBN21+pTqg7NIafVwvC5u2J6+pyvdhdM0t0glGIzOVFczyHOivVJzYqkYTZ8nmqArIgEy0GpnUN+OHgoskfu9/rcSxibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782798466; c=relaxed/simple;
	bh=3jrehyctvMEc3MHJHTIPowI90prvv9QUFRWeHO+jwj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sc35NZ7WZJJ482M3lH2wugD1t8ML1/3NZVzQ/leOkY1cyivYvlwQ3Pf55N2eKRAieD9rbxZqXVh/EPtv8d0s/V9gFlOqnJntnK4hOh8IsL+1KbDyFISobXgJakVLAFEeycAOxd72zelO9KXd9vOd8Q/5wHkN5nqZGb7EBxmMh3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxJ9UAEA; arc=none smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so1385172a12.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 22:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782798464; x=1783403264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zlu0CX51xYkZya/YVR32N8ij8qBdC/uMMOc3z2Ovtgg=;
        b=BxJ9UAEAZmUvff0zkVEkd0xO67tHkjgehmNJfCfdYo3CVTyRvR/u1q+3JtFT0Mz5wR
         dSTDYH0NmQE+Dk8m2opMkxvJDJipkcYrwg1biV1GpMpc0mAJwYWd7YAMECniekzDgz4+
         apBXO0JLrGC5yDWKajm4bg/1gPYYgfrgb4e5VTe7AuFOGRONKO4HeQrY44+muECxwUDm
         gQ0ElAW/Szi2OZ+I+6bVSKGoU7VLn/Hs3SSalQMX1NWzhxU/K5FBq7mtTgSDaC4WPEn0
         IGSXbwrIwp+YOIoyTeIwpZDm/3KJc+BXtE7/n2x54k50afErwCqy6Bt6oeNK8BIsZ5Lb
         itjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782798464; x=1783403264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zlu0CX51xYkZya/YVR32N8ij8qBdC/uMMOc3z2Ovtgg=;
        b=bDEp5Hk+Zfl09ow1VBfNnw/1aXVIMIgKdt9mYmi1xqGOutB+GZh4uexpRA0xZhuA4N
         ptsVbiTYfcJTfsyVy+nPpmFsjdssS/kThCe49DbGCkDajPxlJ1Fh+I3SWpQbYJ83u++l
         ijEy3hqcBlyQWbrAHpSdX2YxWffgnMAr9VXFhTynbDgsYQALgX57YVInCgwJZGLH7jFh
         /0sMVfvViWx9Dii680llm+ysSvYpR2KS2kh8UHZaVkyPQ8pMSubZJLnMsI9+O+OP1/2L
         XJ3B06Y33psWkzAqSM2mQF2RNgAKf5lctsYYWhlhOGwVQfpuZgTyTaRkGP0R9BfbU47/
         0EKA==
X-Forwarded-Encrypted: i=1; AHgh+RqE90Dvq+uqqk/K2UKAkLnUSGdUDV4e8b4w+lxFp/CZm59Qr3swl4txRawIsgTxW+dUyZM/b8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb6ezRU9vvNaTVUy+0nc5zR7EUSUyK6M7Pij4GUIHIBr/l9S9r
	75JaUYXDI3W7sjdf26uhxsGvuYnR4VmcDiWjp4gXPahuZ3FHCzLbZvIn
X-Gm-Gg: AfdE7cn+oZt4wvDRTxMQtm0vZv+DSM7Dtv7cF2EdZEISoDcUUe1TXQSuDlehQqqgtsr
	TrcUtvu51Y7YtnY0GazLwtKiYyELiRomNuAGYNBzbQf2FqM5lSkyFtSQsXqGvVeXOgtPsUg4mwr
	hzwjKTSj2cjq1uKRofp5/eHL3NzNllKDfV5XIhUUnCBB8guwOZlwbGhCp+lwViiZ8a4aI0WSsAj
	I1lSaRHEqWd90LH8sYP6YOg0H83FtWFcBuyfUY/dz0RWAG+YZxoNnM6V3PW/XXwq2YcSans2+8V
	pA8/p49G251tzA5JYE3rtYKkZT8H1JricLI3S/Xq7Eo3X8nFAZp2YtSmOH0E9hfyz4Me627iggk
	d/+P1YdrODf5x30jX5Cx3dpyvECTfHkkxEq8pT5YEVHn4JtQiFJ4PrvAP8OOO1n9rwEOu1ZEnX4
	Hmxd6evuSJL2g=
X-Received: by 2002:a05:6a00:1ca1:b0:845:d286:1fb4 with SMTP id d2e1a72fcca58-8479f3fe9c1mr1760758b3a.50.1782798464051;
        Mon, 29 Jun 2026 22:47:44 -0700 (PDT)
Received: from john-p8 ([98.97.43.212])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a037b015sm1064984b3a.50.2026.06.29.22.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 22:47:43 -0700 (PDT)
Date: Mon, 29 Jun 2026 22:47:41 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Sechang Lim <rhkrqnwk98@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Lorenz Bauer <lmb@isovalent.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf, sockmap: disallow update and delete
 from tc, xdp and flow_dissector
Message-ID: <akNXhg5K7aV7Opdr@john-p8>
References: <20260629172704.1302218-1-rhkrqnwk98@gmail.com>
 <20260629172704.1302218-2-rhkrqnwk98@gmail.com>
 <DJLQSC87KCSV.314DTZAWRNA8C@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DJLQSC87KCSV.314DTZAWRNA8C@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302975-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:rhkrqnwk98@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:sdf@fomichev.me,m:emil@etsalapatis.com,m:lmb@isovalent.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:shuah@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,davemloft.net,linux.dev,fomichev.me,etsalapatis.com,isovalent.com,cloudflare.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,john-p8:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F22436E0884

On Mon, Jun 29, 2026 at 11:24:49AM -0700, Alexei Starovoitov wrote:
>On Mon Jun 29, 2026 at 10:27 AM PDT, Sechang Lim wrote:
>> sock_map_update_common() and __sock_map_delete() hold stab->lock and call
>> sock_map_unref() -> sock_map_del_link(), which takes sk_callback_lock for
>> write. That gives the order stab->lock -> sk_callback_lock.
>>
>> The reverse order comes from the SK_SKB stream parser.
>> sk_psock_strp_data_ready() holds sk_callback_lock for read, and after the
>> verdict tcp_bpf_strp_read_sock() acks the consumed data inline via
>> __tcp_cleanup_rbuf(). The ACK goes out egress, where a sched_cls program
>> deletes from the sockmap and takes stab->lock:
>>
>>   WARNING: possible circular locking dependency detected
>>   ------------------------------------------------------
>>   syz.9.8824 is trying to acquire lock:
>>   (&stab->lock){+.-.}-{3:3}, at: __sock_map_delete net/core/sock_map.c:421
>>   but task is already holding lock:
>>   (clock-AF_INET){++.-}-{3:3}, at: sk_psock_strp_data_ready net/core/skmsg.c:1173
>>
>>   -> #1 (clock-AF_INET){++.-}-{3:3}:
>>          _raw_write_lock_bh
>>          sock_map_del_link net/core/sock_map.c:167
>>          sock_map_unref net/core/sock_map.c:184
>>          sock_map_update_common net/core/sock_map.c:509
>>          sock_map_update_elem_sys net/core/sock_map.c:588
>>          map_update_elem kernel/bpf/syscall.c:1805
>>
>>   -> #0 (&stab->lock){+.-.}-{3:3}:
>>          _raw_spin_lock_bh
>>          __sock_map_delete net/core/sock_map.c:421
>>          sock_map_delete_elem net/core/sock_map.c:452
>>          bpf_prog_06044d24140080b6
>>          tcx_run net/core/dev.c:4451
>>          sch_handle_egress net/core/dev.c:4541
>>          __dev_queue_xmit net/core/dev.c:4808
>>          ...
>>          tcp_bpf_strp_read_sock net/ipv4/tcp_bpf.c:701
>>          strp_data_ready net/strparser/strparser.c:402
>>          sk_psock_strp_data_ready net/core/skmsg.c:1174
>>          tcp_data_queue net/ipv4/tcp_input.c:5661
>>
>>   Possible unsafe locking scenario:
>>
>>          CPU0                    CPU1
>>          ----                    ----
>>     rlock(clock-AF_INET);
>>                                  lock(&stab->lock);
>>                                  lock(clock-AF_INET);
>>     lock(&stab->lock);
>>
>>    *** DEADLOCK ***
>>
>> A tc, xdp or flow_dissector program has no reason to update or delete a
>> sockmap, and redirect does not go through here. Drop them from
>> may_update_sockmap() so the verifier rejects it. It also closes the
>> matching sockhash inversion.
>>
>> Suggested-by: John Fastabend <john.fastabend@gmail.com>
>> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>
>John,
>
>please ack.

Hi Sechang,

I think we additionally need to also block BPF_PROG_TYPE_SOCKET_FILTER? 
Did you check this case I guess the same case is possible there?

Then another patch needs to restrict BPF_SOCK_OPS users. For that
we need to block BPF_SOCK_OPS_HDR_OPT_LEN_CB and BPF_SOCK_OPS_WRITE_*.
Let me know if you want to do those as well. Let me know if you want
to do both patches or just the prog blocking above with the possible
addition of SOCKET_FILTER. I didn't search very hard so probably need
to check all the BPF_SOCK_OPS_* to find the valid cases.

Thanks,
John

