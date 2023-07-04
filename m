Return-Path: <netdev+bounces-15386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A21674742E
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 16:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6A5280FE6
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 14:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97D6567B;
	Tue,  4 Jul 2023 14:34:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD58A2C
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 14:34:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF54F10C3
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 07:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688481254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gYHch/SklDJL/CopH6fHbY5oof68s+i62UNUpHYmC24=;
	b=OJVmoghSPwnbmW05G9nuWZSQpv0XNdDhggPRrakKxgVCeGFea/h7Tr/ddMjRgeoB1wrayh
	BxsciYIUTJPYyAUJ+Dulbuuw6JANdO43dNVIJj587fUYU1NuSR21MhblofhY8T5RJsxp2E
	JiYFfh/sq2LBA27JGAL0vsYHoUQx6iY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-TumVCkMINnWZXNJl7_pR8g-1; Tue, 04 Jul 2023 10:34:10 -0400
X-MC-Unique: TumVCkMINnWZXNJl7_pR8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8077B1C04B40;
	Tue,  4 Jul 2023 14:34:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.195])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D0A681121314;
	Tue,  4 Jul 2023 14:34:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAAUqJDvFuvms55Td1c=XKv6epfRnnP78438nZQ-JKyuCptGBiQ@mail.gmail.com>
References: <CAAUqJDvFuvms55Td1c=XKv6epfRnnP78438nZQ-JKyuCptGBiQ@mail.gmail.com>
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
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
Content-ID: <1506613.1688481248.1@warthog.procyon.org.uk>
Date: Tue, 04 Jul 2023 15:34:08 +0100
Message-ID: <1506614.1688481248@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The problem is caused by this bit in af_alg_sendmsg():

		/* use the existing memory in an allocated page */
		if (ctx->merge) {
			sgl = list_entry(ctx->tsgl_list.prev,
					 struct af_alg_tsgl, list);
			sg = sgl->sg + sgl->cur - 1;
			len = min_t(size_t, len,
				    PAGE_SIZE - sg->offset - sg->length);

			err = memcpy_from_msg(page_address(sg_page(sg)) +
					      sg->offset + sg->length,
					      msg, len);
			if (err)
				goto unlock;

			sg->length += len;
			ctx->merge = (sg->offset + sg->length) &
				     (PAGE_SIZE - 1);

			ctx->used += len;
			copied += len;
			size -= len;
			continue;
		}

it doesn't exist in the old af_alg_sendpage() code.  It merges data supplied
by sendmsg() into the last page in the list if there's space.  So we need a
flag to keep track of whether the last page is appendable-to or not.

David


