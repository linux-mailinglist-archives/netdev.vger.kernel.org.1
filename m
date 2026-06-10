Return-Path: <netdev+bounces-297381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /s4uD9K9KGqXIwMAu9opvQ
	(envelope-from <netdev+bounces-297381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:28:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0535665345
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:28:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=bxpB40Vv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297381-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297381-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B849C3020A44
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140EB2475D0;
	Wed, 10 Jun 2026 01:21:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0F01A0BD0
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:21:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054510; cv=none; b=mx4lPqwUPOhDAonl0Ocy9itbXbjQZD13gXhJSqZy9U5D44H5ndYtnB0QOqmi7fkSAHyRrZpV1+17gIRwwFOv284Lz6tKAbPkC+ig96dYgebKFLj0Zy0kvROQAVeM8Y3oK5h4OGf5Jw8utufVRV7NKYcOs+6vX6Pdv6/tZd5lvnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054510; c=relaxed/simple;
	bh=RvIol9gM/1py5Hk7h4bLp0YoIkMSmUzyYPhAbZ4stdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsiWJg4UaHlQvtJz/ud6+uGF2cIHq3YcEni0/D2bgBqQkKNhn+iVTyf425i+ziY04Cbc0YbbMmBmf4dkuEGEiA3eFnl/i7WJU3mycbigBgud5jSM19hib/VD1PoGtOkEAcBVmShEU0oNSc07o5Z52GC9UmdhtesM8unaws5Iorg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bxpB40Vv; arc=none smtp.client-ip=91.218.175.172
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781054496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jbRzG6Pa36uez5VKdsIv2ql0J1GpmIHCqFTPixbR7/o=;
	b=bxpB40Vvc0ffLgfxsdSmHEVmfGQoqhtPRbWF8R6I+AuIYCZJGyL0xye2AExJHV1Illbc1D
	uM3OlhIi9wkbKa/S2XQc7lN3WqvWYoymrvt3l2eQ0vrRL42Wd7mwYh0JPnRjG8S+1UtCPG
	37kMelikDsIFVMspvuA4BOtMrAHttVg=
From: Menglong Dong <menglong.dong@linux.dev>
To: Sun Jian <sun.jian.kdev@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 shuah@kernel.org, liuhangbin@gmail.com
Subject: Re: [PATCH] bpf: Unshare cloned skb before devmap egress XDP program
Date: Wed, 10 Jun 2026 09:21:25 +0800
Message-ID: <AgOg1pJHQN-gpKhYUz3SMw@linux.dev>
In-Reply-To: <DJ4XIOT2RVMT.28I5LA2UOZVUI@etsalapatis.com>
References:
 <20260609100214.337538-1-sun.jian.kdev@gmail.com>
 <L0cwr1-KRSKR7-dJdjDmJA@linux.dev>
 <DJ4XIOT2RVMT.28I5LA2UOZVUI@etsalapatis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297381-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,etsalapatis.com];
	FORGED_SENDER(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:sun.jian.kdev@gmail.com,m:emil@etsalapatis.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:liuhangbin@gmail.com,m:sunjiankdev@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,gmail.com,fomichev.me];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[etsalapatis.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0535665345

On 2026/6/10 08:06 Emil Tsalapatis <emil@etsalapatis.com> write:
> On Tue Jun 9, 2026 at 7:06 AM EDT, Menglong Dong wrote:
> > On 2026/6/9 18:02 Sun Jian <sun.jian.kdev@gmail.com> write:
> >> dev_map_redirect_clone() uses skb_clone() when redirecting a generic XDP
> >> skb to multiple devmap destinations. The cloned skb can share packet data
> >> with other clones.
> >> 
> >> If the destination devmap entry has an egress XDP program, that program
> >> can modify packet data. Such modifications can then be observed by other
> >> clones sharing the same packet data.
> >> 
> >> This can be reproduced by strengthening xdp_veth_egress to configure a
> >> different source MAC for each egress device and checking that store_mac_1/2
> >> observe the MAC configured for their own egress devices. Without the fix,
> >> the SKB_MODE subtest observes store_mac_1 receiving the MAC configured for
> >> the next egress device.
> >> 
> >> Fix this by unsharing the cloned skb before running the devmap egress XDP
> >> program. Limit the extra copy to destinations with an attached egress
> >> program.
> >
> > Hi, Jian.
> >
> > This sounds like a good idea in this case. When I have a look at bpf_clone_redirect(),
> > I found that it use skb_clone() too, which means it has the same problem. The
> > data can be modified by other xdp prog in the destination NIC if we use
> > bpf_clone_redirect().
> >
> > So maybe this is the default logic, and I'm not sure if this patch can break the
> > existing users :/
> 
> I think for use cases where we are using bpf_clone_redirect() to use
> one clone for inspection this would add an unnecessary copy. Maybe
> adding *_copy() variants instead of changing the *_clone() would be
> better? That way we wouldn't be changing the behavior for existing
> consumers and the naming would be consistent with the skb_* methods.

Agree. It's not a good idea to change the logic of the existing API. Or
maybe we can add a BPF_F_CLONE flag for the existing API.

> 
> But more importantly, is there an actual use case for the kind of API
> that the modified selftest requires? Nobody until now has considered
> the existing behavior to be a problem.

Agree too. Obviously, this is not a bug. For the use case in the commit
log, it's something that can be fixed by the user themself. If we need
modify the MAC, we'd better attach a BPF program for all the egress
device in the devmap.

> 
> >
> > Thanks!
> > Menglong Dong
> >
> >> 
> >> Tested with:
> >>   ./test_progs -t xdp_veth_egress
> >>   ./test_progs -t xdp_veth
> >>   ./test_progs -t xdp
> > [...]
> >>  
> >>  destroy_xdp_redirect_map:
> >> -- 
> >> 2.43.0
> >> 
> >> 
> >> 
> 





