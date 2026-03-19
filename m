Return-Path: <netdev+bounces-269559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFpcKKMrvGn4twIAu9opvQ
	(envelope-from <netdev+bounces-269559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:00:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABDF2CF471
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22E63300A50F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E559C3F0776;
	Thu, 19 Mar 2026 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YA9zfN55"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8153EF67D
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939371; cv=none; b=Jqsc/N6xBEbOIcQXcHavmj2e46WoedrZRxpJCtFg5pTZ63NqbL5eG8YsV7mhefNr0l0KECeqdblKHAg2QCLC4/vtIcX/q/XOLrgJFpCZaAW8ium1B9mmnQMmK6Mhk+EWZkg3a+ZRCrBewnIwM7XqNMeADNkV5u7i+qQu8rBavfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939371; c=relaxed/simple;
	bh=8Z9+HYHC4iK5Bq3d/7b9CH5D7YAMFhiiK/Qwo68KX9s=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=FQcEtU2gzstYiPCISZKD00XSYYqw5+LsDvr6UQ66sOnfVWUMlfYkdO6h7zmxJB7mACZrJaDK+VqXYQ8iK/3OkGKNGZgqkGjWJ98zFIgSrfMTj/uXl38iWA9AdPJtLqAUpVUYIZXekl8iSrpBhD5viY06GzP6LfgmKDOgD/YegPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YA9zfN55; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773939366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=61ZA3OJ04YuYBB74tm/IuSe/+rXb4fo247veXZOVHw4=;
	b=YA9zfN55kc8G7wUUaKwf/Qjr+zxsHTMIo3kYkNQOAzvnVr2MJ8JqHN3NjZj84woqdUFqT2
	0xEO1yRpJgHwpCPH+20RAtzIx7b1FAcLNyq4vUIUpe9pG+ucEpv5hfQrqbn0rejhmDz1gi
	50sb0si5aVC93/EpWd0j+n2f6U8qRrI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-xfuUb3BePayz4XZpx5ZKwQ-1; Thu,
 19 Mar 2026 12:56:01 -0400
X-MC-Unique: xfuUb3BePayz4XZpx5ZKwQ-1
X-Mimecast-MFC-AGG-ID: xfuUb3BePayz4XZpx5ZKwQ_1773939359
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09DB4180047F;
	Thu, 19 Mar 2026 16:55:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.45.224.65])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 243BD1800763;
	Thu, 19 Mar 2026 16:55:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260319161004.GH1753385@horms.kernel.org>
References: <20260319161004.GH1753385@horms.kernel.org> <20260313132327.409785-1-anderson@allelesecurity.com> <20260313132327.409785-2-anderson@allelesecurity.com>
To: Simon Horman <horms@kernel.org>
Cc: dhowells@redhat.com,
    Anderson Nascimento <anderson@allelesecurity.com>,
    marc.dionne@auristor.com, davem@davemloft.net, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, linux-afs@lists.infradead.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rxrpc: Fix keyring reference count leak in rxrpc_setsockopt()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <172884.1773939353.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Mar 2026 16:55:53 +0000
Message-ID: <172885.1773939353@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269559-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,warthog.procyon.org.uk:mid]
X-Rspamd-Queue-Id: 1ABDF2CF471
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Simon Horman <horms@kernel.org> wrote:

> > Fixes: 17926a7 ("[AF_RXRPC]: Provide secure RxRPC sockets for use by u=
serspace and kernel both")
> =

> nit: Please use 12 (or more if needed to avoid a collision) bytes
>      for the hash in Fixes tags.

I fixed this when I posted my collection of rxrpc patches, including this =
one.

David


