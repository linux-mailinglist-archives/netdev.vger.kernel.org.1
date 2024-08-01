Return-Path: <netdev+bounces-114951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB65944CC7
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73ECB1C25A23
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA071A0733;
	Thu,  1 Aug 2024 13:05:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44401A2C20
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517528; cv=none; b=qNOuoNghe8iUldz5Jok42bwpcAAvaX9xdtPA0hw74qQMxsiaiqllUYPSYhNhjdab3XlvEy6ikD3lK9lMfNuLbRzE5s6KhsQNbsMkDnItztcX4RtuVlF0DgHrD4yiPbBgxaY4VfJydrIailMYKfY1lLPWYf4gk9EkYitJ8Ajqn2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517528; c=relaxed/simple;
	bh=gCyprHmx6PoDsIUnAhfiJ1TTTqsY3WVMwPaEOsYpyUA=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=PGVehdewSsA32YlumoZXn3BOlueZI3FAW4U3dBg5qwq7L4RGDyiTjMnr7DaKizsLnkHaklaHwQHHWE1shj9FtcK49koUEeJcjbbzQUFg4nYcz3aNBZQxrGCtg9MDRI3/N7FuyiZCnko22YKrhPFIdtBZ4cuCKkKt7apoJNCMSJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja-home.int.chopps.org.chopps.org (syn-172-222-102-004.res.spectrum.com [172.222.102.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 7EBCA7D06B;
	Thu,  1 Aug 2024 13:05:19 +0000 (UTC)
References: <20240801080314.169715-1-chopps@chopps.org>
 <20240801080314.169715-8-chopps@chopps.org>
 <20240801121310.GA10274@breakpoint.cc>
User-agent: mu4e 1.8.14; emacs 28.3
From: Christian Hopps <chopps@chopps.org>
To: Florian Westphal <fw@strlen.de>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v7 07/16] xfrm: iptfs: add new iptfs xfrm
 mode impl
Date: Thu, 01 Aug 2024 08:36:03 -0400
In-reply-to: <20240801121310.GA10274@breakpoint.cc>
Message-ID: <m2y15g75rl.fsf@ja-home.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed


Florian Westphal <fw@strlen.de> writes:

> Christian Hopps <chopps@chopps.org> wrote:
>> +static int __iptfs_init_state(struct xfrm_state *x,
>> +			      struct xfrm_iptfs_data *xtfs)
>> +{
>> +	/* Modify type (esp) adjustment values */
>> +
>> +	if (x->props.family == AF_INET)
>> +		x->props.header_len += sizeof(struct iphdr) + sizeof(struct ip_iptfs_hdr);
>> +	else if (x->props.family == AF_INET6)
>> +		x->props.header_len += sizeof(struct ipv6hdr) + sizeof(struct ip_iptfs_hdr);
>> +	x->props.enc_hdr_len = sizeof(struct ip_iptfs_hdr);
>> +
>> +	/* Always have a module reference if x->mode_data is set */
>> +	if (!try_module_get(x->mode_cbs->owner))
>> +		return -EINVAL;
>
> If the comment means that we already have a module owner ref taken
> before this try_module_get, then this should use __module_get and
> a mention where the first ref was taken.
>
> If not, then this needs an explanation as to what prevents another cpu to
> rmmod the owning module between the lookup in xfrm_init_state and the
> module reference in __iptfs_init_state.
>
> cpu0					cpu1
>  xfrm_init_state
>    -> xfrm_get_mode_cbs                 rmmod
>      -> __iptfs_init_state		  xfrm_iptfs_fini
>        <interrupt>                         xfrm_unregister_mode_cbs
>                                             release memory
>        <resume>
> 	try_module_get -> UaF

You are correct the code is not sufficiently protective.

I need to use rcu to keep `xfrm_mode_cbs_map[mode]` around long enough to do a `try_module_get(&xfrm_mode_cbs_map[mode]->owner)` and return from `xfrm_get_mode_cbs()` with that ref count held. The caller (xfrm_init_state()) will then need do a `module_put()` after it calls `mode_cbs->create_state()` to give the reference back.

Thanks,
Chris.

