Return-Path: <netdev+bounces-14068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BCB73EC03
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 22:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318DC1C20988
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 20:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E6D134BD;
	Mon, 26 Jun 2023 20:45:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB541125DA
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 20:45:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4622115
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687812281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jg84V4EUJQpXdxqWzxivCvOZP0F5oMgT+7AkEanWAjY=;
	b=Cpf6OWKtYIIsMAq+YthMzi0KeMDv4G97m9HMMo2zHP0m/LJlwaONp1t7MX9xOKu09pexpW
	sM5ND6xxWVZS4awpDs2sh1Gpl46c7YwxmKjIPqtQndXKV4wQfJbaj6sVfrG7EbokEpCepX
	tOg7epQEit63RlP9QdA9eVYwLAJzupw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-7YCo_sUtM-2ljXNnHnLNqA-1; Mon, 26 Jun 2023 16:44:37 -0400
X-MC-Unique: 7YCo_sUtM-2ljXNnHnLNqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D44F6280D5BC;
	Mon, 26 Jun 2023 20:44:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 71C6340C206F;
	Mon, 26 Jun 2023 20:44:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAOi1vP_g70kV_YFjHNoS1hHPpCiMxW1hTfm92Ud35ehYrmv=1Q@mail.gmail.com>
References: <CAOi1vP_g70kV_YFjHNoS1hHPpCiMxW1hTfm92Ud35ehYrmv=1Q@mail.gmail.com> <3101881.1687801973@warthog.procyon.org.uk>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
    Matthew Wilcox <willy@infradead.org>, ceph-devel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] libceph: Partially revert changes to support MSG_SPLICE_PAGES
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3109247.1687812255.1@warthog.procyon.org.uk>
Date: Mon, 26 Jun 2023 21:44:15 +0100
Message-ID: <3109248.1687812255@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ilya Dryomov <idryomov@gmail.com> wrote:

>   if (sendpage_ok(bv.bv_page))
>           msg.msg_flags |= MSG_SPLICE_PAGES;
>   else
>           msg.msg_flags &= ~MSG_SPLICE_PAGES;

Hmmm...  I'm not sure there's any guarantee that msg, including msg_flags,
won't get altered by ->sendmsg().

David


