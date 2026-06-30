Return-Path: <netdev+bounces-303399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9OjbBN9LRGrWsAoAu9opvQ
	(envelope-from <netdev+bounces-303399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 01:06:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ACA6E8936
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 01:06:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Sp3Rh6QS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303399-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303399-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 420EF300F271
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 23:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3D31F997;
	Tue, 30 Jun 2026 23:05:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B602D1F44;
	Tue, 30 Jun 2026 23:05:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860758; cv=none; b=nkmYuJzWZgEoU2s5o4U7enGRVFDOhdT7mMuOKDxzRWdBefLSmHrXFZYsHuObADAt2e2HQ2dszluFEbSYBn9YgPDaq6zEHoo73scNU3Qie2PGIzWNl5eNGhbW6/Z7fCUv3/3t7xUyRzBlFSYNGtUxhv4Wxofi7EkYckWRvGLZ730=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860758; c=relaxed/simple;
	bh=as2AH+swBCP/OHIkj3mwvYyZ71kqHokbMzPrMnDz4UM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sz6yPj9ZwIt0kySbCv9vnKE+6BoGhCEFjn9zZza6eJHFrxPZzClV9lvK3UdCoYn+8c1cdWWZalE8WeJhzUVYeTuSJcYywIipmAsQ92p9bc6Q4CnCZ2MRBWAsZU3RCS9MwdByGMvqIBxnEsuH/t/CiuMKfUxg6ZtJqBfTe9yJAlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp3Rh6QS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADFC1F000E9;
	Tue, 30 Jun 2026 23:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782860757;
	bh=7cQ+oNW/YJFawXWPCbHUU3zJTsMASw9/tH0G0Srn6mU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Sp3Rh6QSCQC/Cb6fL7AjuWd5aEVLvkPoqNr75rDTgsnKxR+79xQZjylzgYSGoLbPk
	 zPmUMnh1JHUsKI4hPZ8p5jxskDqfTTOxBmuvtduKbA1TiC4Kj0g/sFuZyDFe/WqtTn
	 zGpK7L58Avwi031LILnOER1EnXQpYS1SfOi54PMKM24Sy462NnOzPpIdXiGWXDiNeg
	 ZpG7+rtKhmvGZs+P2rT7/vVNQgJqyllwo43ksaPtBS63EMGeE3tZiqqZov8ZX9YUj0
	 Fid8jisDVQjg9kKmPHU1tH54tGEuCNHM5K8wsH4uGJhUoHFKdWODcGPqAJEchOIICh
	 9WvT8bQGsFn/Q==
Date: Tue, 30 Jun 2026 16:05:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, Jordan Rhee
 <jordanrhee@google.com>, Shuhao Tan <tanshuhao@google.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, Samiullah Khawaja
 <skhawaja@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v1 0/2] Reuse threaded NAPI kthread across
 napi_del()/napi_add().
Message-ID: <20260630160555.3736f900@kernel.org>
In-Reply-To: <CAHS8izNeoJiLyoyiPgzmX5CGcyivYqBpVxOcFnoxeOX_zzFd4Q@mail.gmail.com>
References: <20260629192029.4013794-1-tanshuhao@google.com>
	<20260629162619.55297244@kernel.org>
	<CAABY+HEcNnh+ATyA_JMg4LnVpP=egprTTi4UXxV9CfW2+71z+g@mail.gmail.com>
	<20260629181955.00e63b61@kernel.org>
	<CAHS8izNeoJiLyoyiPgzmX5CGcyivYqBpVxOcFnoxeOX_zzFd4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303399-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:almasrymina@google.com,m:hramamurthy@google.com,m:jordanrhee@google.com,m:tanshuhao@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:shuah@kernel.org,m:skhawaja@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 02ACA6E8936

On Tue, 30 Jun 2026 10:38:01 -0700 Mina Almasry wrote:
> > > It feels surprising that the userspace needs to reconfigure thread
> > > properties when changing NIC configurations unrelated to threading.
> > > Another downside is that when userspace configures NIC configurations
> > > in quick succession, re-application becomes messy because a previous
> > > re-application might still be in progress when the thread is gone.  
> >
> > Can you explain more about your deployment and system configuration
> > flow? We may be adding micro optimizations when the problem is that
> > we recreate the NAPIs in the first place.  
> 
> We have an AF_XDP application with extremely low latency and jitter
> requirements running on our servers. Sami developed busypolling
> threaded napi for them. Since it's an AF_XDP application, they attach
> their umem to specific RX queues, and then configure threaded NAPI
> busypolling to achieve low latency. That involves using the Netlink
> API to set the threaded/busypolling property, grabbing the kthread
> PID, and setting some properties on the kthread.

What I don't understand is how you have an "application with extremely
low latency and jitter requirements" and at the same time "user runs 
an unrelated ethtool command" reallocating NAPIs and disrupting that
application.

Honestly, the last two times y'all were touching NAPI it was a major
effort to get the code into acceptable shape. I don't have the cycles
right now to help another unknown-upstream (intern?) get their patches
into shape.

Can y'all not open a pidfs fd for the NAPI thread? You'll get a
notification when the existing kthread dies?

