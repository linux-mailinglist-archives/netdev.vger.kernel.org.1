Return-Path: <netdev+bounces-305388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ykl2DjjMTGqhpwEAu9opvQ
	(envelope-from <netdev+bounces-305388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:51:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D592719F9F
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:51:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pnWFmxsH;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305388-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305388-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C649302977B
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 09:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBD03D5C07;
	Tue,  7 Jul 2026 09:48:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63E33D648F
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 09:48:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417728; cv=none; b=JmcdfvraxFOsXZ5BmFsel+/NBSc2/C7aU2lGxjQBlauchlQfF9IYJ40BjaG+tOHkl87fKthXBn28mWMUpEYf0a+hxSE4QN8pQyTNU9qRg8XRb54asrC4iDudr+u3RnGbg7g8EXvhJp972JtB6Jr3LsFId/L3sBfrpY/QpSpTTfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417728; c=relaxed/simple;
	bh=KbABl74tqG5GNUvT0QDb0Q47cc8vCeHZWLO1bl26ED4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0DuCRKURwJRNMgFsQadwx7nNOYgxIv6Bob4Rp6q2Rz6xCFumUKOfs5JTsh65GCBs3Ae5HvX3TMYlGW16zyM/5ZyByDFVcxGUZFJjrb+DawqCOkqH8BaNQEAItgHg8/8NsDYrKEVOjJvAjfs6EGV3G03qEvKhKQDgLmQcj2sMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnWFmxsH; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4798bea72f9so2404670f8f.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 02:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783417725; x=1784022525; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J0oaZRt2VWFRfQvi/SNR337ENDlCcdDtqHlqF7h8Mhg=;
        b=pnWFmxsHcHi+IV2mcxnLNG4LFXms2f7dhMM+nWQLPtcQ57Neym52Ukr4q27SxgzeVG
         pmrC3MgTAXh63FQRJcULNSAqWvWFxoKxugJ2Jy4Y/lONeqrnBwyq7TubQwnUlfFoJETD
         5nYkBxhj2hTv99wVXtvknQpWmijsQRRUqx90Nbw0dJvxcBK2+v5nWm/sYmUuD7N8ITNR
         yCbjakWkZ/hnWEtji15qTeTtm6yOTOwo5hdm/ovltTzUSL0VEFMZCOz3Q5tE8o6j9hk/
         avbVOMfUePO/QR/gxiVL8z/BLnydad2ejq8LnFDyo/KqW7Oba+AxJYDowbtsWqP4qj4F
         c53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783417725; x=1784022525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0oaZRt2VWFRfQvi/SNR337ENDlCcdDtqHlqF7h8Mhg=;
        b=PyrwdsFJ4329CpfcaCGGvt5ThG3AfTu0SJzCwqFbSTFb/pC+fcmlq+8EDXl7qCewXS
         r6VSEP3X2t64T3DawHQPVBNFHBZ5qWk98cmBPAblrZKW2e88aC6VxCD7P9huDkbbNiO8
         +YUBsR58MNK+fNzo58fG3TVsnWeWCGp5U9pVBpT1UqEa8mwUKoA4Rh3lOePrM3laDjla
         dDFBdWVL1X6trTNRILDo2wnXEql8vo6rTdsivcQ/tcz7nkp5SQDwHaK+Y4QVcx6lCJ4+
         d1cld7skhZz9mYDfnzEYHdmxm72KDJjl6YXCDOVbPnlJR6PQlbnibCwtOicuKhHukfl4
         9RFw==
X-Forwarded-Encrypted: i=1; AHgh+RpyP8sgI2sWHieiQKvxdhuobRWqn56Knx0k7dHw8TY6ciOcZbXmDLRvjptxEojWn6YmX6wfeMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRbxPC/Uct4o+jVMCIaoDdCFLDO8VN/PsKj6FmFuiGwkrXYktN
	sExwCLj453EsCUro8BO8WZ4N+xMw2/23nRqc+qCicm4PIl21Ww5c1Yua
X-Gm-Gg: AfdE7ck2e8oZd/dGshPC+DHWPoF0pRUc6yIJ4msYm4fIPNnvdHljbMoWxXeSQBaK2dz
	zgozaWWkW+3WhIaKPMs9g8YvMQlT48nXRVN6w/8WrhSoWJnOXkFpTPa2FlqGPzWOajbLhPr7Puh
	ZlwmywjWK1poIr/yuz92pC5lyzRTxVcet/dkb+TR7j5VEk2m1+GGWMNxCeD16nxy/Hz4HRny4ke
	VeSkFex/pqwvODAf7JSTr+l8wl9rW19JVgzKUSyB8Ye0LW2Mu9GF5JOs5zGgfa2uYQgfLyiF0od
	5IaIE5w2ydve+uJcuPcNOzZ4sAQj8svHsRetw2eR/X96D2d1oTTSAILBgfnJ7mklB4LsBf+eY4w
	8q8NiFmxbhn/xI8JrutdFQG9Y5ZNCCulzNIKHbvTBXGeSxSe3MjN3hASkZUNLCBELxeqnp4njh3
	yrw1Vs6qlpwaACSrlf9nVIkBREIUCVs9jD6+Dn7TVBYvYS
X-Received: by 2002:a5d:4644:0:b0:474:9dd3:981 with SMTP id ffacd0b85a97d-47de66b1354mr3643129f8f.26.1783417725020;
        Tue, 07 Jul 2026 02:48:45 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d7801sm32987273f8f.16.2026.07.07.02.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:48:44 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:48:42 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
Message-ID: <akzLeuHT1gQqFBM0@gmail.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
 <20260706093525.13030-3-mahe.tardy@gmail.com>
 <CAMB2axO2cHcKRZzrQyY8Zd2aO56MZd8=bf5po+59qnGj=bXrkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB2axO2cHcKRZzrQyY8Zd2aO56MZd8=bf5po+59qnGj=bXrkw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305388-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:andrew+netdev@lunn.ch,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:liamwisehart@meta.com,m:martin.lau@linux.dev,m:pabeni@redhat.com,m:song@kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D592719F9F

On Mon, Jul 06, 2026 at 02:33:43PM -0700, Amery Hung wrote:
> On Mon, Jul 6, 2026 at 3:26 AM Mahe Tardy <mahe.tardy@gmail.com> wrote:
> >
> > Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> > sending data. This provides a mechanism for BPF programs to emit
> > telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> > socket types with IPPROTO_UDP protocol but could be easily extended to
> > SOCK_STREAM and IPPROTO_TCP in the future.
> >
> > The API consists of six kfuncs:
> >
> >   bpf_ksock_create()   - Create a socket (sleepable)
> >   bpf_ksock_bind()     - Bind socket to local address (sleepable)
> >   bpf_ksock_connect()  - Connect socket to remote address (sleepable)
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
> Are these the first BPF kfuncs that invoke (attachable) security
> hooks? Some fs kfuncs seem to deliberately skip them. Can we avoid the
> limiting recursion check by skipping the security hook in
> bpf_ksock_send()? There is still security_socket_connect() in
> bpf_ksock_connect() to prevent undesired send.

FYI I found some piece of documentation around kfuncs and LSM hooks[^1],
people tried to avoid the recursion to happen in the first place.

Initially I wrote this with kernel sockets, which are not subject to LSM
hooks on the send path iirc. I migrated away from this thinking that
those "bpf sockets" should still be subject to the LSMs and not bypass
them, but we can change that or also have it partially as you mentioned
with connect but not send? Note that this would maybe change if we go
the sendto route as suggested on the other thread.

[^1]: https://docs.kernel.org/bpf/fs_kfuncs.html

> 
> >
> > A bpf_ksock_max sysctl is added to limit the maximum number of BPF
> > kernel sockets that may exist in each network namespace. Out of
> > simplicity for now, the settings is host wide but the counters are per
> > network namespace.
> >
[...]


