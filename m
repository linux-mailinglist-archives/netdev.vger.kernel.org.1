Return-Path: <netdev+bounces-296921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J1yoNsqwJ2qI0gIAu9opvQ
	(envelope-from <netdev+bounces-296921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 08:20:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B88A65CB04
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 08:20:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=QhmSyWOp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296921-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296921-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD6F930C2E4C
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 06:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC1A3D300D;
	Tue,  9 Jun 2026 06:19:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1053D3CEE
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 06:19:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985954; cv=none; b=i3m4oy22bzLLkThm+lO5j9F1o6GAWvE/Rxw9RWhTAZWnv59yZqaO2IN5EMgtkUhaUXLNe8R1rrtasAlCE+/tXaH74evraLkSQOreXrN6OZhbBg/F6+KzlpYn4u0lh4989/5JlSHweMxY2aD2Efp8jeEj2mT0o6MZQDuCA+Pb/7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985954; c=relaxed/simple;
	bh=m/8588E549Sx7YLNT/Ae9prWJC1TGYAlx64orwC3YfE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=W7SkMAQYwFYFEZ3vUYcuLbEWtaBxTy+xunbrzz3YGLnTrf1wsRV2NxTIq7HBmjgJP0bQ8Pcva9Q+RPqb82g0DtlTKizhvUv6Q0q5559P0a5K1CBR3mBDFlxLNUzrJPzBeBfl2bA0VTrVfi6p/UhuqtP8ek8FPmASiLAha0eGm9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhmSyWOp; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780985952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+LsXj9LcLVuo5P5r2vxoLuNRU5yNtKTpqcp3OxS8uYM=;
	b=QhmSyWOpoPuWKWwhknduBl8Bvf3ZtlvfVMOgz+TRb2p+hKBCFqttGpsNEBaA7/qlarNiN0
	RbbWFI36wePXr8bgimtd4TJkPhX2nSMChc9uWSZljtjj1JHAw3up4YnkmJpJjn8ExAIRKg
	njTBnDglXDXieQI3XaqDX1+YFfjZRtM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-arpG9RpbNhSZ3v-1X6q95Q-1; Tue,
 09 Jun 2026 02:19:06 -0400
X-MC-Unique: arpG9RpbNhSZ3v-1X6q95Q-1
X-Mimecast-MFC-AGG-ID: arpG9RpbNhSZ3v-1X6q95Q_1780985944
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3418E19560B4;
	Tue,  9 Jun 2026 06:19:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.43])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F4D51800598;
	Tue,  9 Jun 2026 06:19:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260608173921.GA434331@google.com>
References: <20260608173921.GA434331@google.com> <20260522050740.84561-1-ebiggers@kernel.org> <CAB9dFduBir-41_Ef4noEJPHsFU-++JHDxMU-6S7B8pBYynvadA@mail.gmail.com> <20260603050557.GB18149@sol>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, Marc Dionne <marc.c.dionne@gmail.com>,
    netdev@vger.kernel.org, linux-afs@lists.infradead.org,
    linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
    "David S . Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 0/5] Consolidate FCrypt and PCBC code into net/rxrpc/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <764076.1780985938.1@warthog.procyon.org.uk>
Date: Tue, 09 Jun 2026 07:18:58 +0100
Message-ID: <764077.1780985938@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296921-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:dhowells@redhat.com,m:marc.c.dionne@gmail.com,m:netdev@vger.kernel.org,m:linux-afs@lists.infradead.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:marccdionne@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,vger.kernel.org,lists.infradead.org,davemloft.net,google.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,warthog.procyon.org.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B88A65CB04

Eric Biggers <ebiggers@kernel.org> wrote:

> > If there's no more feedback, could this be applied to net-next?
> 
> Any update on this?

It's fine by me, but I'm not sure what I need to do with it - shouldn't it
already be in the netdev queue, or do I need to post it?

David


