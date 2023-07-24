Return-Path: <netdev+bounces-20358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DF375F25A
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60C31C20A97
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A41779F0;
	Mon, 24 Jul 2023 10:13:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFD27479
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:13:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF8C26AD
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690193593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hElr3oAo1P+U1Ohn5FyKlRi/J/m2MdRTbO0VL1LnEoA=;
	b=RK//jA27sOEfpzdEUWVG+sDmRIXusDmj/3lnvLlOBbgqf0hpxZLbMyV12H3qB8xAg63NXd
	NInmgzF5Xl0BCZZCGzVIf429SnW2JEY8g2qQq8qqFQkNNv9qwX0Ngx9gH/rYtMmUivxxUW
	lGfbsxF5S48iqiwgj5fo3XW3XUls+A8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-6pDLNKHwOtGUQU_A7RZXCg-1; Mon, 24 Jul 2023 05:58:52 -0400
X-MC-Unique: 6pDLNKHwOtGUQU_A7RZXCg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE188185A78B;
	Mon, 24 Jul 2023 09:58:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.116])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 266AB2166B25;
	Mon, 24 Jul 2023 09:58:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <168979146971.1905271.4709699930756258041.stgit@morisot.1015granger.net>
References: <168979146971.1905271.4709699930756258041.stgit@morisot.1015granger.net> <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
To: Chuck Lever <cel@kernel.org>
Cc: dhowells@redhat.com, linux-nfs@vger.kernel.org,
    netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 2/5] SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <64139.1690192730.1@warthog.procyon.org.uk>
Date: Mon, 24 Jul 2023 10:58:50 +0100
Message-ID: <64140.1690192730@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Chuck Lever <cel@kernel.org> wrote:

> +	buf = page_frag_alloc(&svsk->sk_frag_cache, sizeof(marker),
> +			      GFP_KERNEL);

Is this SMP-safe?  page_frag_alloc() does no locking.

David


