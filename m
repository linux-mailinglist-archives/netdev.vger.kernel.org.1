Return-Path: <netdev+bounces-267233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EMyMnZRs2l8UwAAu9opvQ
	(envelope-from <netdev+bounces-267233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 00:51:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E13F27B570
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 00:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE11C30FBDB9
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB34408251;
	Thu, 12 Mar 2026 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKuiq7sy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC92402434;
	Thu, 12 Mar 2026 23:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773359476; cv=none; b=Tbc+GCOpz7ZaM5ZmZGYFOGbcxu/XmxUQCOZCsHPOMdgm/1PQFwk0ejNJHDZgLiK8ai6GS93f1z5zzYXwCuBpRPz7gJ1zcqCWwwTuttPsC34f8lyj7VDvrTcK+7k2wgXw+/EBR+rkEJ9PXroM74dwgnSmpbAvblZTyHaA6ElubcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773359476; c=relaxed/simple;
	bh=j+iIf2CgdsCIx42yS6EMYtotC9J1oAn8bvNT3RWoS3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/TUtsCGloLpkGRxFyAJoIzRrPscdAj9Jw5BjKf3ReEK3AT6XxP/BIbaHYn2k2Z7EMHRxjgwJo6KO8Gn6dqW7lbKw5zbUhxzDjDP7RTRrQGzWy5UdIcP+E0uKOJbEsyUnHV9mzufMvsoFtXqme+PtIQITtwekMCxU7FoGh4/M9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKuiq7sy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6CFC4CEF7;
	Thu, 12 Mar 2026 23:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773359475;
	bh=j+iIf2CgdsCIx42yS6EMYtotC9J1oAn8bvNT3RWoS3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LKuiq7syko/TtMDXlmbT70PyYi7dZ9cgv0bdOmNIlWANEN5nyZm4Idtu30XmU0WnR
	 93q/8VZjuf4pkNa0/eVrF/szwMugLfY11PHVLubl20eFapnRr0tDjM9SFH6Qv89dCC
	 vpZyQGy3mko2amFNrMr16bhRO1u8bksXYYM7hlaMGwzLAwklxIQ+/ZYiVJoAoWEfgB
	 NJtxKuvKK99JF3IXMBjdGban//UJO6e7rLyPus5Y+Fh95DLPqdxFabrzuWdRfd2WQt
	 wgrukXXfZ6JG0ln5CLmhtkcD+yEJUB1zkr8Tm9FK74H7Kv4qA+/1AqEM+mX+cP3RVp
	 I8eL3QvIhKmzg==
Date: Thu, 12 Mar 2026 16:51:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, toke@toke.dk,
 vinicius.gomes@intel.com, stephen@networkplumber.org, vladbu@nvidia.com,
 cake@lists.bufferbloat.net, bpf@vger.kernel.org, ghandatmanas@gmail.com,
 km.kim1503@gmail.com, security@kernel.org, Victor Nogueira
 <victor@mojatatu.com>
Subject: Re: [PATCH net] net/sched: Mark qdisc for deletion if graft cannot
 delete
Message-ID: <20260312165113.773a5f44@kernel.org>
In-Reply-To: <CAM0EoMnv14pSaJWW3ZQuegkbQEqqye0zp0-_tCaOEWEg=C3xCQ@mail.gmail.com>
References: <20260307212058.169511-1-jhs@mojatatu.com>
	<20260310184713.7e810431@kernel.org>
	<CAM0EoM=TAAfwZc3q1=RKWPrS778R_B8uM18ev_jYYz8oj4YiBA@mail.gmail.com>
	<20260311175249.54abe1b6@kernel.org>
	<CAM0EoMnv14pSaJWW3ZQuegkbQEqqye0zp0-_tCaOEWEg=C3xCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267233-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,toke.dk,intel.com,networkplumber.org,nvidia.com,lists.bufferbloat.net,gmail.com,mojatatu.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2E13F27B570
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 16:36:48 -0400 Jamal Hadi Salim wrote:
> > > Two of the several (I think 4!) patches we had took a similar path. I
> > > am trying to remember at least one variant was bad for performance and
> > > the other was unstable. Let's see if we can revive it and take a
> > > closer look. BTW - none were pretty, it was maybe half the lines of
> > > code but touched many things.  
> >
> > FWIW / of course, we have to apply similar change to all(?) callers of
> > __tcf_qdisc_find in cls_api. So LOC-wise it may end up also pretty long.
> > And it's not going to help the already spaghetti-looking locking. But
> > even if it's more LoC I quite like the idea of containing the poopy
> > code to where problems originate which is the lockless filter handling.
> > Fingers crossed..  
> 
> Something like attached.
> Unfortunately after running it for a few hours it reproduced.
> The action code path (entered by virtue of filter code path execution)
> releases the rtnl when attempting to load an action module. A parallel
> qdisc operation waiting for the lock then grabs it and we hit the same
> issue...
> 
> So now we have to be more invasive and start coordinating the action
> code etc, which is not appealing. Thoughts?

I see. Doesn't seem entirely crazy to let tcf_proto_lookup_ops()
return -EAGAIN without actually loading the module, and have it's
call path (of which there are only 2?) do the module loading once
all the locks are released. The call paths handle the EAGAIN and
retry already they just assume tcf_proto_lookup_ops() has loaded
the module so they don't have to.

