Return-Path: <netdev+bounces-15315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092BA746C61
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 10:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4C31C209EF
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 08:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD2F443F;
	Tue,  4 Jul 2023 08:51:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD25F1879
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 08:51:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6050E47
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688460661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zdyxwyfyCuKz7/7BHOPg3TNF1zFyGIHGDllKl8O41gE=;
	b=jWLJsInSvF2oQRYBtZVnQXYo9ad8f3p/vbrHwX22TaNyURQwDp3CAakXpet1GOrR6vl5Lx
	2/E1HvdC13vRogDhmmIfberkUnhEQUO7qIV8SA9sAwEaKGY/+7ez5GtY2e7m8YiPMSZFIF
	/AxUbjnbd0wnYF6BxGVyY4TGIjYJ6Ik=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-75wUcZQuO5O7AiS-mVACww-1; Tue, 04 Jul 2023 04:50:58 -0400
X-MC-Unique: 75wUcZQuO5O7AiS-mVACww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FE6F1044590;
	Tue,  4 Jul 2023 08:50:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.195])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 14DE62166B34;
	Tue,  4 Jul 2023 08:50:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAAUqJDvFuvms55Td1c=XKv6epfRnnP78438nZQ-JKyuCptGBiQ@mail.gmail.com>
References: <CAAUqJDvFuvms55Td1c=XKv6epfRnnP78438nZQ-JKyuCptGBiQ@mail.gmail.com>
To: Ondrej Mosnacek <omosnacek@gmail.com>
Cc: dhowells@redhat.com,
    Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: Regression bisected to "crypto: af_alg: Convert af_alg_sendpage() to use MSG_SPLICE_PAGES"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1357759.1688460637.1@warthog.procyon.org.uk>
Date: Tue, 04 Jul 2023 09:50:37 +0100
Message-ID: <1357760.1688460637@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

One problem with libkcapi is that it's abusing vmsplice().  It must not use
vmsplice(SPLICE_F_GIFT) on a buffer that's in the heap.  To quote the manual
page:

	      The user pages are a gift to the kernel.   The  application  may
              not  modify  this  memory ever, otherwise the page cache and on-
              disk data may differ.  Gifting pages to the kernel means that  a
              subsequent  splice(2)  SPLICE_F_MOVE  can  successfully move the
              pages;  if  this  flag  is  not  specified,  then  a  subsequent
              splice(2)  SPLICE_F_MOVE must copy the pages.  Data must also be
              properly page aligned, both in memory and length.

Basically, this can destroy the integrity of the process's heap as the
allocator may have metadata there that then gets excised.

If I remove the flag, it still crashes, so that's not the only problem.

David


