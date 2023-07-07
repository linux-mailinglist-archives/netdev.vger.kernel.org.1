Return-Path: <netdev+bounces-15994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B3974ADA4
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 11:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF1C2816B9
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 09:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717B79479;
	Fri,  7 Jul 2023 09:12:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6242A63C9
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 09:12:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930D01FEE
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 02:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688721164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wU3D20g/JxtCROQUSiRgjpayIvu8cn+paX5zco5nOco=;
	b=bbWmP+qWBgfZp0Aut9eT3/nhgbpVfKdKfQ54k0lTAAF7CM7WjQXD0EUqV70qI9BIXZGBfF
	a/uujDeqw8y8mXfYOjc1/oEkw0ZaDpkPwFFWr4wbKK1zKWmcX96kNbil7xsoYqVzlJmKZq
	Fn1uYsVybGWdQmrDJS9akSkYvTvbaUA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-aTE9Asg2OD6HYPoA1q_yrQ-1; Fri, 07 Jul 2023 05:12:41 -0400
X-MC-Unique: aTE9Asg2OD6HYPoA1q_yrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C79483FC20;
	Fri,  7 Jul 2023 09:12:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.195])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3DAD64067A00;
	Fri,  7 Jul 2023 09:12:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: dhowells@redhat.com,
    syzbot <syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com>,
    Paolo Abeni <pabeni@redhat.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
    linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: algif/hash: Fix race between MORE and non-MORE sends
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2227987.1688721158.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Jul 2023 10:12:38 +0100
Message-ID: <2227988.1688721158@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The 'MSG_MORE' state of the previous sendmsg() is fetched without the
socket lock held, so two sendmsg calls can race.  This can be seen with a
large sendfile() as that now does a series of sendmsg() calls, and if a
write() comes in on the same socket at an inopportune time, it can flip th=
e
state.

Fix this by moving the fetch of ctx->more inside the socket lock.

Fixes: c662b043cdca ("crypto: af_alg/hash: Support MSG_SPLICE_PAGES")
Reported-by: syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/000000000000554b8205ffdea64e@google.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: Paolo Abeni <pabeni@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: linux-crypto@vger.kernel.org
cc: netdev@vger.kernel.org
---
 crypto/algif_hash.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index 0ab43e149f0e..82c44d4899b9 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -68,13 +68,15 @@ static int hash_sendmsg(struct socket *sock, struct ms=
ghdr *msg,
 	struct hash_ctx *ctx =3D ask->private;
 	ssize_t copied =3D 0;
 	size_t len, max_pages, npages;
-	bool continuing =3D ctx->more, need_init =3D false;
+	bool continuing, need_init =3D false;
 	int err;
 =

 	max_pages =3D min_t(size_t, ALG_MAX_PAGES,
 			  DIV_ROUND_UP(sk->sk_sndbuf, PAGE_SIZE));
 =

 	lock_sock(sk);
+	continuing =3D ctx->more;
+
 	if (!continuing) {
 		/* Discard a previous request that wasn't marked MSG_MORE. */
 		hash_free_result(sk, ctx);


