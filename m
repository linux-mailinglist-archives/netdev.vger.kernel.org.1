Return-Path: <netdev+bounces-287474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHutH8cyBGqNFQIAu9opvQ
	(envelope-from <netdev+bounces-287474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:13:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2202D52F676
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 802BB3028AAA
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E603D3D07;
	Wed, 13 May 2026 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyjXt7jX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264D13DB63F
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778660034; cv=none; b=schWe2x0oixcsh9UYjxCecBveJEJdNVHc2uWlWuhBOruwk/Fr7/N69yB5BexdrOGcMg5bvZLFYX0eIr6zRaf62QSh++tRdI+WY2GltgY6+o8QIKCUnBiwrLoDK4NO2jVbqS2ER0sA+CLClXvVxg8eaVmgNVdC9Y6roSDm3KEvDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778660034; c=relaxed/simple;
	bh=kmni9OLhg4Pd5n62/ER2xoJKPdcU2TOdP1z0TI3HiTM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=g4guY/k49ibk1i2JLUKqzQfIxIY9+e3SIlV7+ySUgcz8P/iQu/cs1bxIHloSCyhV+mHmVJXDdrP4+u7t8Fc/YYXmQ2w949GTv6w8cawWgw98XqURcfpScwbprxvRM2LghdkaKN5KFOEcHYP0Pnu5zy81P7A8FckVnXaXZ7vQons=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GyjXt7jX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778660028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7jMVBsE7V/XEqCjzIOK4vL1Dn6WnzW8J5Vfp3OVDYBM=;
	b=GyjXt7jXgjEcX95WcZM3iZzmhFS/P5iO26O9XpQvlWc/LWiIIAgp627zfqbWxdEcMlEGKA
	ORZB4yL8o7SoAtzjnbagR4Cw/aJ1b7QhaasxW3cvdQPjNqQb2K31e2kkq8spamiu65fIlN
	2Y+kfsf6fexeYfzvD1sR/kb4Of22Q78=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-oKIoDh_dMDOuYwnVtVm4_A-1; Wed,
 13 May 2026 04:13:47 -0400
X-MC-Unique: oKIoDh_dMDOuYwnVtVm4_A-1
X-Mimecast-MFC-AGG-ID: oKIoDh_dMDOuYwnVtVm4_A_1778660025
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F37CD19560B2;
	Wed, 13 May 2026 08:13:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.83])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EAE4B1800349;
	Wed, 13 May 2026 08:13:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1354628.1778659274@warthog.procyon.org.uk>
References: <1354628.1778659274@warthog.procyon.org.uk> <437CCB8A-5333-4349-B120-A103B1F0E617@auristor.com> <20260511160753.607296-1-dhowells@redhat.com> <20260511160753.607296-3-dhowells@redhat.com>
To: Jeffrey Altman <jaltman@auristor.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Hyunwoo Kim <imv4bel@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org, Jiayuan Chen <jiayuan.chen@linux.dev>,
    stable@vger.kernel.org
Subject: Re: [PATCH net 2/3] rxrpc: Fix DATA decrypt vs splice() by copying data to buffer in recvmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1354985.1778660019.1@warthog.procyon.org.uk>
Date: Wed, 13 May 2026 09:13:39 +0100
Message-ID: <1354986.1778660019@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 2202D52F676
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,linux.dev];
	TAGGED_FROM(0.00)[bounces-287474-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

David Howells <dhowells@redhat.com> wrote:

> > > + kfree(call->rx_dec_buffer);
> > 
> > It might be better to avoid deallocating the buffer on the error
> > path and permit it to be freed during normal call (or call channel)
> > deallocation.
> 
> Hmmm.  But I then need some other way to note that the buffer is no longer
> occupied by valid data.  I suppose I could set ->rx_dec_offset to USHRT_MAX.

Actually, I'm not sure that just freeing the buffer is all that bad.

If skb_copy_bits() fails (ie. EFAULT), then the sk_buff is unrecoverably
broken somehow and the app will may have to abandon the call.  Possibly the
call should be aborted directly here.  The case really shouldn't happen and
probably merits a pr_warn().

If ->verify_packet() fails with ENOMEM, then it's retryable.  Releasing the
buffer temporarily might help the system.

If ->verify_packet() fails with anything else, then the call should have been
aborted.

David


