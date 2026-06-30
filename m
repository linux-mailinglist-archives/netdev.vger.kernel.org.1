Return-Path: <netdev+bounces-303368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mNFyF/YxRGqlqQoAu9opvQ
	(envelope-from <netdev+bounces-303368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 23:15:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB3D6E8113
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 23:15:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Sq5y5qbV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303368-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303368-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6262B304B7E7
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067AA282F06;
	Tue, 30 Jun 2026 21:15:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A1D1A683C
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 21:15:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854129; cv=none; b=OcT3GQc7AKtQfehOMSSE3mcRZMw2wVEALCAg7FbOJqCwk9ywzm5cL4To5T7l9RTvMO+ZLCG+6gjFd06CP+P49ngMLtOjV6/WuRvcAwVzC5e/zxegegrpc1aDCrYgQFqbcxaXpoSMgQJhxV575dq9rP4QKJeclLBhL8Kcjw4aMyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854129; c=relaxed/simple;
	bh=MxZdVF8AISof0knQo5kzT1fe2XBORoo1LKeTxz/VG/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nJ+mbqj66JvfUE2j24ZNVMyZ1glZu4iRfXEbnruaNANQ3LA/hmT8FIr9IEiD1587f0KZmejbP7TKL3ndRBw+gK1TkUnkjZq/WtnqPzEwtXDD59Fb31z58Zy5/L6Y/9aq2mM5S+G9wR2elxkKN/ILDk9OjJW1DqmnhgKYty/L/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sq5y5qbV; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37d125687b6so896a91.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782854128; x=1783458928; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nrOYOPALSh6uu9gvx9eTmaLw+m6UC6lWCwYa2QnPRwk=;
        b=Sq5y5qbVoBT6Ehbig7rd/EyYLHZZf6vZ8O1ATjwFJWgDdm/FsWzSO0Bcuw7P01JKob
         CmPPL9MdJntq90nLNm2MoJQ9n+JDDTCdJUHtWLIIv+0A4SsBKd+3laefo0NXBHs9FWjL
         pzNTfhQruprZyTLccwRaGlOfHjPgomR46C0WOW1zYWV972CblS8alSv4GQ8z69h7Pu+V
         aOCd+wKf24A8FGMjdv8ZtEkzdE4LC9VvdRX2Br6NblzQJV48rk22kEMTHBJpdmFq123F
         DW3uFNSvQAXp5Fo2wFF8qfrJ/sG6cjNDZs6wkhr5Wt2gVVu8gU3ywqkBPJIInJ7qduxG
         ZdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854128; x=1783458928;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nrOYOPALSh6uu9gvx9eTmaLw+m6UC6lWCwYa2QnPRwk=;
        b=IMvc6954jxI3u4w3fl7nQmR83Q5IPh2e/tiDJ4mNij0u6olgN0LHUE9BOyDVJR8rD3
         l9Jlct31x24f33MjB8QNZI6PnBG39M8VKbLFkxlIQ8lazaCfgQFbctyKAbmblOYl4DcR
         lsyB6D4Z29uRi02oemt0qSWmWArsXO57FxinmMgefI1F0yLUssxqly00Vxgvk+zM7R/H
         LyLtL5nHrlnQfbtICPqsJEkRdKNMCg7doRttBiGxoG/S1QWdskMzFdLgAOf55r6HIR7X
         PEOo7p9ZX1WJmc4aKbBvAk/Zvv1Sbqjfm8QP6ErQ0CHwtcgjFR3gGEmQMV/xodbgagDP
         MEMA==
X-Forwarded-Encrypted: i=1; AHgh+RpcnRDdzCc/IXEkkC+X6pnq9SBt4X6oFX1axmrE5Ood/wujKA2EPWKqtUMPWBUv0ZSeHCi7tgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyULY+V6+KwLTjGYjEf556dlCYcnBTsanD0aTZjZZkSBpgsBs4/
	jgWJrFv/f87Ck3ZUP6MP6cENuGugiYEQLrK1WPCOi76xt3pkVRdd0snkNtO8h5nQn8RPuG3M3qt
	SaHY0OA==
X-Received: from pjsb3.prod.google.com ([2002:a17:90a:be83:b0:380:9a95:5008])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3cc7:b0:37f:9ce3:ca96
 with SMTP id 98e67ed59e1d1-38052788a75mr3891946a91.31.1782854127779; Tue, 30
 Jun 2026 14:15:27 -0700 (PDT)
Date: Tue, 30 Jun 2026 21:13:11 +0000
In-Reply-To: <20260630165934.GA1227354@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630165934.GA1227354@shredder>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630211527.3365952-1-kuniyu@google.com>
Subject: Re: [PATCH net-next v2] ipv4: igmp: remove multicast group from hash
 table on device destruction
From: Kuniyuki Iwashima <kuniyu@google.com>
To: idosch@nvidia.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, jedrzej.jagielski@intel.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, yuyanghuang@google.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303368-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:jedrzej.jagielski@intel.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:xiyou.wangcong@gmail.com,m:yuyanghuang@google.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,intel.com,vger.kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CB3D6E8113

From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 30 Jun 2026 19:59:34 +0300
> On Tue, Jun 30, 2026 at 04:55:22PM +0900, Yuyang Huang wrote:
> > > Hi,
> > >
> > > why sending this to net-next not to net if that's a bug fix?
> > >
> > > In the v1 thread it was said
> > > >This is a long-standing bug, not a recent regression.
> > >
> > > so why do not cc stable kernel to get rid of this bug from
> > > stable kernels in such case?
> > 
> > Thanks for the advise, will send this patch to stable kernel.
> 
> Please target v3 at net and add a trace given you're claiming for a
> use-after-free. That way we know that the problem is real and not a
> false-positive from some tool. You can reproduce it by adding enough
> delay in inetdev_destroy():

I guess delay was added between ip_mc_destroy_dev() and
RCU_INIT_POINTER(dev->ip_ptr, NULL) ?

I feel like we should clear it first and destroy everything
as done in IPv6 addrconf_ifdown().


> 
> BUG: KASAN: slab-use-after-free in ip_check_mc_rcu+0x2cc/0x500
> Read of size 4 at addr ffff88810c571208 by task mausezahn/419
> 
> CPU: 2 UID: 0 PID: 419 Comm: mausezahn Not tainted 7.1.0-virtme-g15d4a7c23bf6 #17 PREEMPT(lazy)
> Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0x4d/0x70
>  print_report+0x153/0x4c2
>  kasan_report+0xda/0x110
>  ip_check_mc_rcu+0x2cc/0x500
>  ip_route_input_rcu.part.0+0x13d/0xbc0
>  ip_route_input_noref+0xb6/0x110
>  ip_rcv_finish_core+0x41b/0x1d90
>  ip_rcv_finish+0xea/0x1b0
>  ip_rcv+0xb7/0x1b0
>  __netif_receive_skb_one_core+0xfc/0x180
>  process_backlog+0x1ea/0x5e0
>  __napi_poll+0x97/0x480
>  net_rx_action+0x97c/0xfa0
>  handle_softirqs+0x18c/0x4f0
>  do_softirq+0x42/0x60
>  </IRQ>
> 

