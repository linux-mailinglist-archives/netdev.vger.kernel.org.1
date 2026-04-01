Return-Path: <netdev+bounces-274096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIVjMjITzWmMZwYAu9opvQ
	(envelope-from <netdev+bounces-274096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:44:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F55037AA70
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77016306A78A
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C5A40B6C4;
	Wed,  1 Apr 2026 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4GLcjd8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6CD408237
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047339; cv=none; b=ja156WFckV1R8XiF94ZsQu2ZwamgEnDc1R1+yBg5e+iENVbnmIiM3Y5HpWeWoC2XfXufMyzwebIjqD4GHxeW6Ot4LTD+a6si9Tzh3ILqiJhCz3XePH789lKjgDA4g8//deD6jMbZZ1fjPLR4LGXWcU+QwvCz/up6AcmJgYUOpow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047339; c=relaxed/simple;
	bh=W005LT9EE6iwxxJoodQSTE1vqXncxfiJo2rbwy8It/8=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=ZnzKxuJ6xUUCc/c2MLVToEpMd7hvXNvhsQ6DT/tlCgG/vEM34JIYbpL3gwOM4MiT25++OGSmfcP33TCZEcpcKiUevfsPy3bSkUU/Bs28qOA9d3gd6Vs7kDyjtrro8sOMBoYA4ptXB6t8nP8shg5ZUMgT1uscAOcGASc/NnbECP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I4GLcjd8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775047336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W005LT9EE6iwxxJoodQSTE1vqXncxfiJo2rbwy8It/8=;
	b=I4GLcjd8r/kKLizJw5D1K0HOGdF3HaVZkmmKzaeKvTLvqm1kU1gaNC48jApSYodQDn4x1L
	V7e02iqrTFt5tXlrVGSmXkBVS2/EkcLtW7mpYvoHkrWUzd9t71LsIY1Bal8OtFZm2cANhn
	JN/qtmsmvLLB8UTK5G/CtYCuT4uCljo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-k-F7VJ2KOP6RK_CXV3aXQw-1; Wed,
 01 Apr 2026 08:42:11 -0400
X-MC-Unique: k-F7VJ2KOP6RK_CXV3aXQw-1
X-Mimecast-MFC-AGG-ID: k-F7VJ2KOP6RK_CXV3aXQw_1775047330
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C03F71800283;
	Wed,  1 Apr 2026 12:42:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.35.245])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8D561953947;
	Wed,  1 Apr 2026 12:42:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260401105614.1696001-5-dhowells@redhat.com>
References: <20260401105614.1696001-5-dhowells@redhat.com> <20260401105614.1696001-1-dhowells@redhat.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    Jeffrey Altman <jaltman@auristor.com>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Simon Horman <horms@kernel.org>, stable@kernel.org
Subject: Re: [PATCH net v4 04/15] rxrpc: Fix call removal to use RCU safe deletion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1736861.1775047324.1@warthog.procyon.org.uk>
Date: Wed, 01 Apr 2026 13:42:04 +0100
Message-ID: <1736862.1775047324@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_TO(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274096-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,warthog.procyon.org.uk:mid]
X-Rspamd-Queue-Id: 7F55037AA70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fixes: 2baec2c3f854 ("rxrpc: Support network namespacing")


