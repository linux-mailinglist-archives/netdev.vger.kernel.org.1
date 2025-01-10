Return-Path: <netdev+bounces-156983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59624A088CE
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 08:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B1A3A8EF0
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 07:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46436206F04;
	Fri, 10 Jan 2025 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yv/mGnw7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639242063CE
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 07:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736493241; cv=none; b=GkBz79zdolDzLPpyitbZIaSIyzX1k9o+gCLr1sNcuXXTFaUBsgPTyAMpNq4+7qm4VBPnKE6YD9Uio8EAgWnB29FXjc43C/f1nOk6uW7Zas/ClYWbAMDJqRMhd0IvVX1LoUOvbBj8dqwl8Et5jTcqXrVXHnwVQhIZj1UdChiQaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736493241; c=relaxed/simple;
	bh=lprOQfulzu8v6KvGdaC/bIeIPCWpKvc6opCkgeRU8p8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=hIEAW8rMWzwBJkf4mhOkKqhw1RiCyaXdrr62ZBzLDq2LTsIyzPGh/ifbze84ucHbhmclrMLTS0JWSXJCVAQdj6b6BJ2Z+r4RViClLH2+e/Q5suKtlmZt+rp60GgnejpPzObbJPx6jNunOCf2fg3U/87OYrqOWOccsiUUIsmy7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yv/mGnw7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736493238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQbXIksEk073+Fi/YrEVMIhtLpzXwHk7tiFH7RnZK5M=;
	b=Yv/mGnw7bFv2bru2WS2HtNI1nJAa23pdy5ABEV+5iGXXokKa18rEjlWazz/Zut4Urvp4tX
	D0yz9sBOH5JIvidX5dIsi0GJXHvFzfVKS0NoeXX9zfAb4ab3spOIbtBviIbUFcbOUfkh2D
	gE7seXFrHtFWTKc2k+vl+qASsDsIrjY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-O0KBR35FP7uFyN5xYPBuug-1; Fri,
 10 Jan 2025 02:13:56 -0500
X-MC-Unique: O0KBR35FP7uFyN5xYPBuug-1
X-Mimecast-MFC-AGG-ID: O0KBR35FP7uFyN5xYPBuug
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 511911955D64;
	Fri, 10 Jan 2025 07:13:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C52530001BE;
	Fri, 10 Jan 2025 07:13:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250110055058.GA63811@sol.localdomain>
References: <20250110055058.GA63811@sol.localdomain> <20250110010313.1471063-1-dhowells@redhat.com> <20250110010313.1471063-3-dhowells@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
    Chuck Lever <chuck.lever@oracle.com>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    "David S. Miller" <davem@davemloft.net>,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    linux-crypto@vger.kernel.org, linux-afs@lists.infradead.org,
    linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] crypto/krb5: Provide Kerberos 5 crypto through AEAD API
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1478992.1736493228.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jan 2025 07:13:48 +0000
Message-ID: <1478993.1736493228@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Eric Biggers <ebiggers@kernel.org> wrote:

> It sounds like a lot of workarounds had to be implemented to fit these
> protocols into the crypto_aead API.
> =

> It also seems unlikely that there will be other implementations of these
> protocols added to the kernel, besides the one you're adding in crypto/k=
rb5/.
> =

> Given that, providing this functionality as library functions instead wo=
uld be
> much simpler.  Take a look at how crypto/kdf_sp800108.c works, for examp=
le.

Yes.  That's how I did my first implementation.  I basically took the code
from net/sunrpc/auth_gss/ and made it more generic.  Herbert wants it done
this way, however.  :-/

David


