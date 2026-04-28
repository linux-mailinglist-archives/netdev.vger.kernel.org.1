Return-Path: <netdev+bounces-281702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNA7Ditp8GkITAEAu9opvQ
	(envelope-from <netdev+bounces-281702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:00:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B8F47F80B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA0E3306882B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8E72F532F;
	Tue, 28 Apr 2026 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnArU3iX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45572EA48F
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362835; cv=none; b=NwE0JJ4Dzz7mdnhNN2I17xZG7Bm2fyk200rlWlbSBD6BX5u3L9KJ/WQYa4ng1Ir1tRfN977z6PQdO23Pf4pu/0CF4a/wSaLGIZBgOZ2tdWHZyCTPM4qVZNt+2VEZWyI470mWH7dPyUMo8jvomHhip/3YoRK2mh/logLKY4xu1D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362835; c=relaxed/simple;
	bh=W2ux99vm/YR+fWjrnwRiZup/PYxG31SHUrlOrY3Sk+k=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=eVTiu09LcgMre+8rMh+HBeyM0y51Hl+dSqP+Hk7uT3axu/nMATtn2eIySmG4Q+YWM0R6pd+BzUzFNEWgojtvUlYcSmaL/P1Lo/bfKl3SDEoH7spmq2biq0cirW7oad0UoxImAezyIm5gXs3RPKZxD6jF/5w0kbH4I+8Ntyl93Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PnArU3iX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777362832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2t/FQHBc4YwiSUDHUyxx0oj6pNb+ROc36MbcJMBmi8w=;
	b=PnArU3iXndl5/Aeu4z3kvaIEI1fYQnri6vMqhGWlpcIvFlwEMiXDBtnIOvXt68PwfuHL3a
	pwixevJcPMxCQ6HtMMyq46sqU7UmB+bTfzc2HuSfkeYHavHicv8Dk+qqpY1P3C0IdQOXK+
	J5sdNVLI3F2zm6XxaOQ3I4tNDGN2RVM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-qsX_92UiPIah9O2Y47wL1A-1; Tue,
 28 Apr 2026 03:53:49 -0400
X-MC-Unique: qsX_92UiPIah9O2Y47wL1A-1
X-Mimecast-MFC-AGG-ID: qsX_92UiPIah9O2Y47wL1A_1777362827
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07E78195609F;
	Tue, 28 Apr 2026 07:53:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.126])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 49B09195608E;
	Tue, 28 Apr 2026 07:53:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260428024400.123337-1-ebiggers@kernel.org>
References: <20260428024400.123337-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    linux-afs@lists.infradead.org,
    Marc Dionne <marc.dionne@auristor.com>, linux-crypto@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    "David S . Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 0/5] Consolidate FCrypt and PCBC code into net/rxrpc/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <772373.1777362820.1@warthog.procyon.org.uk>
Date: Tue, 28 Apr 2026 08:53:40 +0100
Message-ID: <772374.1777362820@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: F3B8F47F80B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281702-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[dhowells.redhat.com:query timed out];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[warthog.procyon.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Eric Biggers <ebiggers@kernel.org> wrote:

> [This series applies to v7.1-rc1 and is intended to be taken via
> net-next.  Patches 4-5 could be left for later if desired.]
> 
> The FCrypt "block cipher" and the PCBC mode of operation are obsolete
> and insecure.  Since their only user is net/rxrpc/, they belong there,
> not in the crypto API.
> 
> Therefore, this series removes these algorithms from the crypto API and
> replaces them with local implementations in net/rxrpc/.
> 
> The local implementations are simpler too, as they avoid the crypto API
> boilerplate.
> 
> I don't know how to test all the code in net/rxrpc/, but everything
> should still work.  I added a KUnit test for the crypto functions.

It seems to work, so apart from the two points I noted, you can add:

	Acked-by: David Howells <dhowells@redhat.com>

It looks like it might be slightly faster, but I think the overhead reduction
is not that visible with all the other things the filesystem and protocol do
plus I/O overhead.  RxGK is a lot faster and more secure, so we should be
moving that way anyway.

David


