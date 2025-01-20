Return-Path: <netdev+bounces-159867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0C3A1738B
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 21:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888631681D9
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 20:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CBB1F03D3;
	Mon, 20 Jan 2025 20:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkifebw2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE99155A52
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737404311; cv=none; b=a5Wqe/zCyafNLsWaAvVujh/iEGPjn5Zw2+YzLeWVzNvPRsAQD0LL54UBSGNepIvUW6ZN73TXUCG13HS6DgqcjpbwQDsR5Ye2tFLelXWRJVMTecj11DiBJvUpGJNmPrG4tbIx7pQlRxcGZ7pBshB5wzEF+vEY1su61KLpm2GTmJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737404311; c=relaxed/simple;
	bh=Kz2TlXXwQ+SzvxVI4EEYgGPZIS5aE1/jeFB9dM77uSI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=QwMo3TPzhT67S3hxTJOm5gOhoKwc8vDdPjiV957BhGhQDx/2NojpvIUB9dqJaCiLtjDmldD6FfUm82nRQmFLxTRpECBajpAVX0gZi3HyBPRav+QrIdiCgAkFRg4ZZWCUCswDcOo0BDYqqrBpekvwhl+7luf/jqGd1xGd9QXamqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkifebw2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737404308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1b+YsBqSK8VeGuQPF+mRZwuPBiG3uaSaaur3ZRV5/uk=;
	b=dkifebw2iq87Sl8/TwVpd/XW2G13z4j5IGG0Hy3rUMXyIEWSJJegh6sBlzBrCmk2BXV8mT
	dBakMyu1PVG8z9GVrFVJiDy31mSd+uYGAWCBwRF862rJXPZNpAGSJWnnsXsTX+/sGDM0Hm
	Yz3L7pvr16sbaAO5GDZrCazNHyzeL9g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-jn_OIywHOwaitWAB_dzWrQ-1; Mon,
 20 Jan 2025 15:18:24 -0500
X-MC-Unique: jn_OIywHOwaitWAB_dzWrQ-1
X-Mimecast-MFC-AGG-ID: jn_OIywHOwaitWAB_dzWrQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78F041956080;
	Mon, 20 Jan 2025 20:18:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2BC1019560A3;
	Mon, 20 Jan 2025 20:18:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250120191250.GA39025@sol.localdomain>
References: <20250120191250.GA39025@sol.localdomain> <20250120173937.GA2268@sol.localdomain> <20250120135754.GX6206@kernel.org> <20250117183538.881618-1-dhowells@redhat.com> <20250117183538.881618-4-dhowells@redhat.com> <1201143.1737383111@warthog.procyon.org.uk> <1212970.1737399580@warthog.procyon.org.uk>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, Simon Horman <horms@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Chuck Lever <chuck.lever@oracle.com>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    "David S. Miller" <davem@davemloft.net>,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
    linux-crypto@vger.kernel.org, linux-afs@lists.infradead.org,
    linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/24] crypto: Add 'krb5enc' hash and cipher AEAD algorithm
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1215833.1737404294.1@warthog.procyon.org.uk>
Date: Mon, 20 Jan 2025 20:18:14 +0000
Message-ID: <1215834.1737404294@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Eric Biggers <ebiggers@kernel.org> wrote:

> In any case, why would you need anything to do asynchronous at all here?

Because authenc, which I copied, passes the asynchronocity mode onto the two
algos it runs (one encrypt, one hash).  If authenc is run synchronously, then
the algos are run synchronously and serially; but if authenc is run async,
then the algos are run asynchronously - but they may still have to be run
serially[*] and the second is dispatched from the completion handler of the
first.  So two different paths through the code exist, and rxgk and testmgr
only test the synchronous path.

[*] Because in authenc-compatible encoding types, the output of the encryption
is hashed.  Older krb5 encodings hash the plaintext and the hash generation
and the encrypt can be run in parallel.  For decrypting, the reverse is true;
authenc may be able to do the decrypt and the hash in parallel...  But
parallellisation also requires that the input and output buffers are not the
same.

Anyway.  If it can be done asynchronously, that should probably be tested.

David


