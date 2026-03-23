Return-Path: <netdev+bounces-270756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOEcD4+2wWlyUwQAu9opvQ
	(envelope-from <netdev+bounces-270756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:54:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 951C12FDF82
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53D773037D6C
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99504381AE9;
	Mon, 23 Mar 2026 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/hjF6pj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4637C10F
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 21:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302682; cv=none; b=blolpxf12aZq5ESZ6tEfglrwM+6NoCd0A4cjO0Q5b60BDWO1Z/57Eveaddbz5gpp4Th6dVdBYqRP0VA7MdLAlKfucVn5hKzmDbowj5wa5XjGO81Sv2P/uMuwb+iF4z9cITSf13fZjeR7wdWoI8JKHJyeZS9YYkq07ffsaKiV4Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302682; c=relaxed/simple;
	bh=rmi62A5m0JVyidoow8H/5MjFSMmBj2DZN5EMYO5VQxA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=kNgD+xt4euSDbDF35az7RLNvpHwCFri8pP7fDAMlL2PcBep6eVcFpxK9+RyZJkudzE/u77/73gJTzSZXKPK/ddjhWjDt7r9l8P8qG9BhJzjMP2GsqDCB9kmgJrtxj5ki9TIotHhQBGzNhK6cE5HG04hz5Kf2M1wS0e+jNreYUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/hjF6pj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774302680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rjce6AQ7rpAwX8F+yxH7SfgbXUXizWAdGPnndtzZ7E0=;
	b=Q/hjF6pjMNcAk6yiYIV5YRK1nx6dbH0ue7ONM1YZAzU1Tlfb2RCnHrkCsQAVrrCQzys8wn
	KtJQwjc8qPxJ4kUj80OU7JIwJcJE+stY1pYvj9Bxoce0aP3jhnP038qVb6zI8VpUfTobhE
	gBf88NunhGv6ajmfsJBTbkHQtfgy1kQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-LA2U4Ru-N_6YIPXvFDxJ1A-1; Mon,
 23 Mar 2026 17:51:16 -0400
X-MC-Unique: LA2U4Ru-N_6YIPXvFDxJ1A-1
X-Mimecast-MFC-AGG-ID: LA2U4Ru-N_6YIPXvFDxJ1A_1774302675
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8463E195608D;
	Mon, 23 Mar 2026 21:51:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.121])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C6C201800351;
	Mon, 23 Mar 2026 21:51:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260323144541.3ef887b7@kernel.org>
References: <20260323144541.3ef887b7@kernel.org> <20260321014543.3892478-2-kuba@kernel.org> <20260319150150.4189381-3-dhowells@redhat.com> <1433905.1774080919@warthog.procyon.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    linux-afs@lists.infradead.org, horms@kernel.org,
    alok.a.tiwari@oracle.com, davem@davemloft.net,
    marc.dionne@auristor.com, linux-kernel@vger.kernel.org,
    security@1seal.org, stable@kernel.org, pabeni@redhat.com,
    anderson@allelesecurity.com, jaltman@auristor.com,
    edumazet@google.com
Subject: Re: [PATCH net 2/5] rxrpc: Fix use of wrong skb when comparing queued RESP challenge serial
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3585121.1774302668.1@warthog.procyon.org.uk>
Date: Mon, 23 Mar 2026 21:51:08 +0000
Message-ID: <3585122.1774302668@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270756-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,warthog.procyon.org.uk:mid]
X-Rspamd-Queue-Id: 951C12FDF82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Btw, do you know how to credit the AI site with reporting something?  For
instance for syzbot gives me a Reported-by: line that carries something that
can be used as an email address.  There were other things in the AI report,
some of which I added patches for.

David


