Return-Path: <netdev+bounces-186381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 140EAA9EDC4
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 12:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D97F7AB8FE
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 10:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475F225F993;
	Mon, 28 Apr 2025 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrEblxjZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D7A25F79A
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745835743; cv=none; b=d2yNjMcAq+oU9WrpF68zbC1YzfAjG1Y31pyKKwiILKwgUXn0Zy/23xpKm6EpjDA+PNI0+CPlKX+fEB/CmmF1kFUZCjpfB59mHTXW5aE5191900nKtmoh4xcdeu+0xOf7u6ayOFt8Vem8piifFbK2EHxoEzc4n6Il/0YvKWgQHzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745835743; c=relaxed/simple;
	bh=RqdM6tQLULttWm7Qo9KtY2xD21nhVT3B5OXxTPkQ95A=;
	h=To:cc:Subject:MIME-Version:Content-Type:From:Date:Message-ID; b=gcgQPw4afeiNXoZrIWZvgQLDeRiCjHTr2QJs/LyRRs9adxE1O3oJQo73FJR4K8VmjggJTxz4Tw5S+YqiXJtVObdIp/WhbL0cNvkNBJ107bqVofKzgfy1YmwKJFT2I00SrpJhuI4eyVuu6SJ+yPa6kN21/nPHpOBpZQ5LkbbI2iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OrEblxjZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745835740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XZR60ryduJ6qSqqolVECpQBm6DPYshoNtZhT2Jgpp+U=;
	b=OrEblxjZBzdeN47Qtl/RR87kOf3XLzRqXmfymrA9ildTdauAcM/u2PMieFNRHmiYU0cK09
	ozNtJDzCHITN4MzYxmb8fhexCAqO4Yr8Hwub5AUlAPgq/oZcCunT+zHrUltqbdV//CD12p
	gUdjbNv0p2whA2rQHL/sW6aaGwKaTjo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-uYhzPZYtOZicjZElV4RmHQ-1; Mon,
 28 Apr 2025 06:22:16 -0400
X-MC-Unique: uYhzPZYtOZicjZElV4RmHQ-1
X-Mimecast-MFC-AGG-ID: uYhzPZYtOZicjZElV4RmHQ_1745835734
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D183319560A6;
	Mon, 28 Apr 2025 10:22:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E1901800367;
	Mon, 28 Apr 2025 10:22:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
To: netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Chuck Lever <chuck.lever@oracle.com>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH net-next] crypto/krb5: Fix change to use SG miter to use offset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3823907.1745835655.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From: David Howells <dhowells@redhat.com>
Date: Mon, 28 Apr 2025 11:22:06 +0100
Message-ID: <3824017.1745835726@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

[Note: Nothing in linus/master uses the krb5lib, though the bug is there,
 but it is used by AF_RXRPC's RxGK implementation in net-next, so can it g=
o
 through the net-next tree rather than directly to Linus or through
 crypto?]

The recent patch to make the rfc3961 simplified code use sg_miter rather
than manually walking the scatterlist to hash the contents of a buffer
described by that scatterlist failed to take the starting offset into
account.

This is indicated by the selftests reporting:

    krb5: Running aes128-cts-hmac-sha256-128 mic
    krb5: !!! TESTFAIL crypto/krb5/selftest.c:446
    krb5: MIC mismatch

Fix this by calling sg_miter_skip() before doing the loop to advance by th=
e
offset.

This only affects packet signing modes and not full encryption in RxGK
because, for full encryption, the message digest is handled inside the
authenc and krb5enc drivers.

Fixes: da6f9bf40ac2 ("crypto: krb5 - Use SG miter instead of doing it by h=
and")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: "David S. Miller" <davem@davemloft.net>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-crypto@vger.kernel.org
cc: netdev@vger.kernel.org
---
 crypto/krb5/rfc3961_simplified.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/krb5/rfc3961_simplified.c b/crypto/krb5/rfc3961_simpli=
fied.c
index 79180d28baa9..e49cbdec7c40 100644
--- a/crypto/krb5/rfc3961_simplified.c
+++ b/crypto/krb5/rfc3961_simplified.c
@@ -89,6 +89,7 @@ int crypto_shash_update_sg(struct shash_desc *desc, stru=
ct scatterlist *sg,
 =

 	sg_miter_start(&miter, sg, sg_nents(sg),
 		       SG_MITER_FROM_SG | SG_MITER_LOCAL);
+	sg_miter_skip(&miter, offset);
 	for (i =3D 0; i < len; i +=3D n) {
 		sg_miter_next(&miter);
 		n =3D min(miter.length, len - i);


