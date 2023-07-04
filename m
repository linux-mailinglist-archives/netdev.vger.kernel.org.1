Return-Path: <netdev+bounces-15328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE504746DD4
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 11:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B237D280E86
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 09:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5EB525B;
	Tue,  4 Jul 2023 09:42:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAAC539F
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 09:42:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD62510D5
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 02:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688463709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zLSEosjlinrCxKCLRBdlkkdM07HJXUp3DKjWoDpchWo=;
	b=Q8xgGU/mnJHWe/a7CXjCpQguvg2z0t4wWZqzNs49POXMPSR2atVHyOpJaT8YK/WxL/Omh2
	8a4hZrJjcTyuVdGT3pSPXGK0CEhSNu+NCbO76LbYra3etGPxx2v1B9vpGmJkVFiGFwzAj3
	abiKvMARplFadCvd4Z+tUjbIy3i9yL0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-UDuYkHNINm63hneICkQI6g-1; Tue, 04 Jul 2023 05:41:47 -0400
X-MC-Unique: UDuYkHNINm63hneICkQI6g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6201C3814950;
	Tue,  4 Jul 2023 09:41:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.195])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 81309492C13;
	Tue,  4 Jul 2023 09:41:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZKPgkgiddAl9qddT@gondor.apana.org.au>
References: <ZKPgkgiddAl9qddT@gondor.apana.org.au> <CAAUqJDvFuvms55Td1c=XKv6epfRnnP78438nZQ-JKyuCptGBiQ@mail.gmail.com> <1357760.1688460637@warthog.procyon.org.uk>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dhowells@redhat.com, Ondrej Mosnacek <omosnacek@gmail.com>,
    Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    regressions@lists.linux.dev
Subject: Re: Regression bisected to "crypto: af_alg: Convert af_alg_sendpage() to use MSG_SPLICE_PAGES"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1361503.1688463705.1@warthog.procyon.org.uk>
Date: Tue, 04 Jul 2023 10:41:45 +0100
Message-ID: <1361504.1688463705@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> All it's saying is that if you modify the data after sending it off
> via splice then the data that will be on the wire is undefined.

Er, no.  It can literally remove the page from the process's VM and paste it
somewhere else - though in this case, that shouldn't happen.  However, the
buffer passed to SPLICE_F_GIFT should also be page-aligned, which it might not
be because they used calloc().

There's no reason to use SPLICE_F_GIFT here.  vmsplice() still attaches the 

> There is no reason why this should crash.

Agreed.  I'm still looking at it.  Interestingly, the output comes out the
same, no matter whether vmsplice(), vmsplice() + SPLICE_F_GIFT or writev(), so
it looks like the buffers get to 

> If we can't fix this the patches should be reverted.

I didn't change vmsplice() or the way pages are stored in the pipe.

And, note, there are also a bunch of GUP changes that could have an effect.

David


