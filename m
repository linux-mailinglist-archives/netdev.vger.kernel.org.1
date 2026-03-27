Return-Path: <netdev+bounces-272631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNqXKg/PxmmuOwUAu9opvQ
	(envelope-from <netdev+bounces-272631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 19:40:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E869F349163
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 19:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F752303E75D
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 18:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CFC410D3B;
	Fri, 27 Mar 2026 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6So7/fn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68312407119
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774636784; cv=none; b=X3s4ofBwogm4kpXdQDvLQYzhpqqPxwTkmvV1GVjPbyQmK2yFGHoOnLeGJL2JVdbVmykBLd+ClDUfvNxl2LyDK7TW4hVdQEwyRpuP1HvpFjlw99mc9Y95q63r473vH0ggzn9BpxpO4i69x7ZRaTd/VG5Q61jNY4aXmVvodi/JESQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774636784; c=relaxed/simple;
	bh=22Xz3+eZMS7/J6rdfE1EEuhHi9H26t+XeUeP6Ef2daI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3S08NX2FOPIer/w8Wm/vSSnBBXjNdUfTj0xGH4apKHmjuFXfquMwLDF3VLHkEnBq/fHGztDBSjSCeVfQY1ygqqUP3idX6+nzZxfVA71r3XSJkv2Rm/DXc5HFkF1auanQ+jERSeZzXM4YxXJbVET2+h7kuAy1K0kGj/UwCUHJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6So7/fn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774636782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYQ+qhUAXb2Z9JfIpc10XqqDG6/nzFbrgxdQauX3Mys=;
	b=a6So7/fn33pBGF7x++NLD4b80u94MkUAzkR/wN+TuDw9h9tQ4SIhZidYUlKUguJyVyG6jq
	xc6TjaHB1XFpDCr9+tforxfBaPfW0Zfq8+zEIPgZ18zbkwADj6AW8yCIg2b8rUE8NDSiku
	c4nn8A8pkVD5ZUINM1QuljtAWxBzmak=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-z0Gue9LOOhq3GuO7EECm2w-1; Fri,
 27 Mar 2026 14:39:39 -0400
X-MC-Unique: z0Gue9LOOhq3GuO7EECm2w-1
X-Mimecast-MFC-AGG-ID: z0Gue9LOOhq3GuO7EECm2w_1774636777
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C4FD1956062;
	Fri, 27 Mar 2026 18:39:37 +0000 (UTC)
Received: from thinkpad (unknown [10.44.33.208])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C987F1800351;
	Fri, 27 Mar 2026 18:39:34 +0000 (UTC)
Date: Fri, 27 Mar 2026 19:39:31 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Luka Gejak <luka.gejak@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
	liuhangbin@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net: hsr: fix VLAN add unwind on slave
 errors
Message-ID: <acbO48xPc--SBzOu@thinkpad>
References: <20260326154715.38405-1-luka.gejak@linux.dev>
 <20260326154715.38405-3-luka.gejak@linux.dev>
 <acZvYp_SYvypHWgk@thinkpad>
 <F40ED495-9115-489C-A010-0011A9229C4A@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F40ED495-9115-489C-A010-0011A9229C4A@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-272631-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E869F349163
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 05:03:18PM +0100, Luka Gejak wrote:
> On March 27, 2026 12:52:02 PM GMT+01:00, Felix Maurer <fmaurer@redhat.com> wrote:
[...]
> >nit: superflous empty line (it's inconsistent with the other case
> >blocks)
> Good catch. I'll drop the extra newline in v3.
> >I think this would look cleaner with the good and the bad paths in
> >the same switch-case, but that may be a matter of (my) taste. What do
> > you think?
> Very well. I will take your preference into consideration and will
> make mentioned changes in v3. However I am not currently home and will
> send v3 once I come home in 1-2 days.

Alright, thank you! No hurry, take your time. Just fyi, I'll be out of
office next week, but I'll definitely review v3 as soon as I'm back (if
nobody else did it in the meantime).

Thanks,
   Felix


