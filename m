Return-Path: <netdev+bounces-299497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yiHMHU0YMGqwNQUAu9opvQ
	(envelope-from <netdev+bounces-299497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:20:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2E2687965
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:20:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FPPL6peT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299497-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299497-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B24EE304893C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452D7402447;
	Mon, 15 Jun 2026 15:15:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFE040243A
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:15:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536543; cv=none; b=fW3Zc7p81kmliR0NyxQvf06fmaRa7iYPvaqJT/0dYv/jCq3cN8Uz+/HXpUmL6dexqGEmEn+slD3nVPOC1pLPbenA3G/GX8btA8jIoeWZrStl5EZeQmYGOcO0eOJGdPUGjTVYyCXzvSc7yw8bAYiS89gQVGHeGZ9e7iU2RLT7BVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536543; c=relaxed/simple;
	bh=L4pAGtHfLq3VAcz6DEuvZqfESh3HFAcYxo5zdcfmsOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy7P8qVG/d8+koaR5sozbFiq4NBzAoO6wXJGCKQPwB57LZY254QQq6zbUkUyYzDuweKIYSCsw2Qf/dzU7kQimc+HobuQCFV9P7hximDUWhhHSsHlQQRQdsoCjkyi/TNTkMTV3ZZIxQakC5yTft31ETLcnFGnE/g3qd5upGVB3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPPL6peT; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so22836065e9.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781536538; x=1782141338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TFEbBl2In0eA69OX+ycS9WcHidui4es5vXgLSbxb9jc=;
        b=FPPL6peTeSWqt0OVku3yve2nUvwoa3JMMMh/aZKPoJezsbAu7dE0ZFcp8AcB05gUQy
         kD9xcijd2V4bIMFgDGg8BKyzxBQtMZ24/ZB+ZZpEi7iTHWaL8mS44tTOtn4hCt/hFVWL
         XG5Ma/ghrDw6t6w2qcoM6Na9uiyBNIcyTV7DEwlQ3CetI81enD7k7cK+/eEwUe5ObxDh
         A4itPiY6MZMUtJnC+rs9q/vYoaRZqw9qyxA5cv5JVfFDK6WVRzLx4l55hdMXk1sKtk1u
         /1K/2OyJ1DBQlDheoH0DaV3hPiM83LgCqhs1q/LeYvaIs9JDYQ7nVMgQA81uBiljH2w+
         CEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781536538; x=1782141338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFEbBl2In0eA69OX+ycS9WcHidui4es5vXgLSbxb9jc=;
        b=HFmYzD0rLsf3rsehYkXPNMj7fsp9+0dlEa8mJ4yJQyHf2XbeR5SLQxfRI4I+s0f5Vk
         phU+5gyCwszERux/xHlbLyThwdWmZpVp8jSrENbBIKnQM8IujhTU3YT4aj/0L7qUUxUu
         a/p7gJZpwU1h2l7+qbUka7Sx9Q6BMxZtyhVPvNVMAXiksRmLKJ6CUEKRQU95xIp5nEBJ
         q7fId2qVbBITM/KHn+6NwNlG4rs6tzvD3YnIQtyK/+yXwZ96hkp9MOgwN6/B30bJ9/nC
         Q2oGRbGl5tf7PJVAprfHKwSE5lffVqcjhl6l0VHpQ+DVJZ/F/ijsie3nX5nq8VW7tn8s
         4RUg==
X-Forwarded-Encrypted: i=1; AFNElJ+FK9Q62ZzUZ4TS1vQtJ62Zl8AY6VBlE2yq3clg87KsTKPPHV4JVJzLzqDI+Xft8RV3ZIdxcUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlex5jOVjLmWqIVixDSa5+egyYGuSs26z7Dr7NLHtBK1siwKVW
	Z1GWl7sTccFD8dr1xPTt8w17a+TVESyWV3DFYXjBWHt0iBWFSwaPx8iN
X-Gm-Gg: Acq92OF1TRQijRTyavTTg5eKlrNr1p2/TV2Qy1YrrRqUs4WJEKPayUCbs7BBndY2XdS
	CvJmFc8BTrGXi99NPJTkj4QPivMKUWHrgip9w7OKF+Y6A13WVylkpTdHYA/EWPd3UtWwaa2peUr
	vM4Pb9UPqQcRwl2f5jXRA6YyIXfXqa1dJNr0OYXw++uBX8IsGDgTfexLl3X+T8xgHH9uP1Zvlsl
	Gn6IC6kwu7uG17ZqOnEc0JSuPui8ph5if3E3lfkgarJoRfcHEM07ugfcrE8LRG42SsNoQSvmpiT
	RBt7Dz9XUWGHdQ4D3NZlSB095WE3ReVbk2uZB5z8VLrQQXpqKAtR2Rivsn/mh9ALd802Eeyh5iD
	muwZFZZClJZPdErLX+xke6k6HwGNcJDk7G7L9K8RL/fJidkiKMqU0kWkV5Km6IGSWZbvbb9ENYH
	meDaS249B+mHB/BTT5xq3DO3pW/+4uuR8VhhT8jz7wGoiMzqgKA2JsqKYCX6e6rUQ+WEPZaqDbA
	wTFh2KlxsbSHBc1rlJyd9ivoZc7TcExyIkXt/aMvwtJQLjE1e/3uJsxFqlk7ATHLC2b+3CqjdEY
	Q7uFpmFO4KVK+T/5E0u4LHMG6FW1z2kYsUJJUcGSSQA=
X-Received: by 2002:a05:600c:1392:b0:490:a646:9d75 with SMTP id 5b1f17b1804b1-49220091dbemr131573105e9.9.1781536537951;
        Mon, 15 Jun 2026 08:15:37 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e009a0d3db09e2f2ffb.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:9a0d:3db0:9e2f:2ffb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea95c512sm197508155e9.2.2026.06.15.08.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:15:37 -0700 (PDT)
Date: Mon, 15 Jun 2026 17:15:35 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Jordan Rife <jordan@jrife.io>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH v1 bpf-next 0/2] bpf: bpf_redirect_peer egress redirection
Message-ID: <ajAXF8Nvg91xU4f2@mail.gmail.com>
References: <20260613183424.1198073-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613183424.1198073-1-jordan@jrife.io>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299497-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jordan@jrife.io,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE2E2687965

On Sat, Jun 13, 2026 at 11:34:04AM -0700, Jordan Rife wrote:
> We have several use cases where a pod injects traffic into the datapath
> of another so that the traffic appears to have originated from that
> pod. One such use case is a synthetic flow generator which injects
> synthetic traffic into a pod's datapath to enable dynamic probing and
> debugging. Another is a transparent proxy where connections originating
> from one pod are redirected towards another which proxies that
> connection. The new connection is bound to the IP of the original pod
> using IP_TRANSPARENT and its traffic is injected into that pod's
> datapath and handled as if it had originated there. This can be used for
> mTLS, etc.
> 
> We use bpf_redirect(BPF_F_INGRESS) to direct traffic leaving the proxy,
> flow generator, etc. towards the target pod, ensuring that eBPF programs
> that are meant to intercept traffic leaving that pod are executed.
> However, this doesn't work with netkit.
> 
> With netkit, an ingress redirection from proxy to workload skips eBPF
> programs that are meant to intercept traffic leaving the pod, since they
> reside on the netkit peer device. One workaround is to attach the
> same program to both the netkit peer device and the TCX ingress hook for
> the netkit pair's primary interface, but
> 
> a) This seems hacky and we need to be careful not to run the same
>    program twice for the same skb in cases where we want to pass that
>    traffic to the host stack.
> b) We're trying to keep the proxy redirection / traffic injection
>    systems as modular and separated from Cilium as possible, the system
>    that manages netkit setup and core eBPF programming.
> 
> It would be handy if instead we could redirect traffic directly from
> one netkit peer device to another. This patch proposes an extension
> to bpf_redirect_peer to allow us to do just that.
> 
> With this patch, the BPF_F_INGRESS flag tells bpf_redirect_peer to emit
> the skb in the egress direction of the target interface's peer device
> While the main use case is netkit, I suppose you could also use this
> mode with veth as well if, e.g., there were some eBPF programs attached
> to that side of the veth pair that needed to intercept traffic.
> 
>  +---------------------------------------------------------------------+
>  | +-------------------------+         6. bpf_redirect_neigh(eth0)     |
>  | | pod (10.244.0.10)       |           ------------------------      |
>  | |                         |          |                        |     |
>  | |              +--------+ |          |      +---------+       |     |
>  | | 1. packet -->|        | |          |      |         |       |     |
>  | |    leaves ^  | netkit |<===========|======| netkit  |       |     |
>  | |           |  | peer   |=======(eBPF)=====>| primary |       |     |
>  | |           |  |        | |          |      |         |       |     |
>  | |           |  +--------+ |          |      +---------+       |     |
>  | |           |             |          | 2. bpf_redirect        v     |
>  | +-----------|-------------+          |___________________   +-------|
>  |             |                                            |  | eth0  |
>  |             | 5. bpf_redirect_peer(BPF_F_INGRESS)        |  +-------|
>  |             |________________________                    |          |
>  | +-------------------------+          |                   |          |
>  | | proxy (10.244.0.11)     |          |                   |          |
>  | | IP_TRANSPARENT          |          |                   |          |
>  | |              +--------+ |          |      +---------+  |          |
>  | | 3. packet <--|        | |          |      |         |<--          |
>  | |    enters    | netkit |<===========|======| netkit  |             |
>  | |    [proxy]   | peer   |=======(eBPF)=====>| primary |             |
>  | | 4. packet -->|        | |                 |         |             |
>  | |    leaves    +--------+ |                 +---------+             |
>  | |    sip=10.244.0.10      |                                         |
>  | +-------------------------+                                         |
>  +---------------------------------------------------------------------+
> 
> Using the proxy use case as an example, in step 5 we would redirect
> traffic leaving the proxy towards the pod's peer device using
> bpf_redirect_peer(BPF_F_INGRESS).
> 
> As a bonus, since the skb doesn't have to go through the backlog queue
> it can take full advantage of netkit's performance benefits. I set up a

The motivation makes sense. Cilium could probably use this as well to
avoid some of the hacks we have around proxy reinjection.

> test where outgoing iperf3 traffic is injected into the datapath of
> another pod using either bpf_redirect_peer(BPF_F_INGRESS) or
> bpf_redirect(BPF_F_INGRESS). I used Cilium's eBPF host routing mode
> which skips the host stack and uses BPF redirect helpers to do all the
> routing.
> 
>   (net.ipv4.tcp_congestion_control=cubic,mtu=1500,100GiB link,Cilium
>    eBPF host routing mode)
> 
> BASELINE [bpf_redirect(BPF_F_INGRESS)]
>   1. [iperf pod] ==bpf_redirect([pod b], BPF_F_INGRESS)==> [pod b]
>   2. [pod b]     ==bpf_redirect_neigh([eth0])==>           eth0
>   3. eth0        ==over network==>                         [host b]
> 
>   [ ID] Interval           Transfer     Bitrate         Retr
>   [  5]   0.00-60.00  sec   231 GBytes  33.0 Gbits/sec  12060     sender
>   [  5]   0.00-60.00  sec   230 GBytes  33.0 Gbits/sec            receiver
> 
> TEST [bpf_redirect_peer(BPF_F_INGRESS)]
>   1. [iperf pod] ==bpf_redirect_peer([pod b], BPF_F_INGRESS)==> [pod b]
>   2. [pod b]     ==bpf_redirect_neigh([eth0])==>                eth0
>   3. eth0        ==over network==>                              [host b]
> 
>   [ ID] Interval           Transfer     Bitrate         Retr
>   [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec    0       sender
>   [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec            receiver
> 
> In this test, using bpf_redirect_peer(BPF_F_INGRESS) for the hop from
> [iperf pod] to [pod b] led to ~18% more throughput compared to
> bpf_redirect(BPF_F_INGRESS).
> 
> Note: I wasn't sure about the flag name. I can see where BPF_F_INGRESS
>       might be confusing, since technically it's an egress redirection
>       from the perspective of the peer device's namespace. But, I didn't
>       want to add a BPF_F_EGRESS flag just for this and convinced myself
>       it makes sense, because from the perspective of the caller the skb
>       will be flowing towards the current namespace.

IMO, calling it BPF_F_EGRESS would be less confusing. It's a shame we
can't have the same flag API between bpf_redirect() and
bpf_redirect_peer(), but this is creating inconsistent semantics for
the terms egress/ingress across the two helpers.

> 
> Jordan Rife (2):
>   bpf: Support BPF_F_INGRESS with bpf_redirect_peer
>   selftests/bpf: Add tests for bpf_redirect_peer with BPF_F_INGRESS
> 
>  include/uapi/linux/bpf.h                      | 16 +++--
>  net/core/filter.c                             | 14 ++--
>  tools/include/uapi/linux/bpf.h                | 16 +++--
>  .../selftests/bpf/prog_tests/tc_redirect.c    | 68 +++++++++++++++++++
>  .../selftests/bpf/progs/test_tc_peer.c        | 22 ++++++
>  5 files changed, 116 insertions(+), 20 deletions(-)
> 
> -- 
> 2.43.0
> 
> 

