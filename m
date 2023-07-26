Return-Path: <netdev+bounces-21360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E65397635F2
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A54281E43
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919D3C12C;
	Wed, 26 Jul 2023 12:13:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872FCC128
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:13:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450B926A5
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690373620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LnW9xkF8qrzBpOp/lykCe+AD7AowiLx25o2vuyMj38Y=;
	b=hDidZsplBHfTnNb81gs1ixKnBaxeDndI1uHApANDSB0dbFs074hhh92URjf9ZSrRTQHvzF
	2DWPey1vd1nQI4V+tCZdO3wCyx/gy7aLxhJlywU9pvgJP6i9gLsqELq0WBMmEyL7HqLhat
	QW1NH62jaGKxNydfgTyP6lKRArJrUg0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-odnFqjtHNDuQw6wgKoCQAw-1; Wed, 26 Jul 2023 08:13:37 -0400
X-MC-Unique: odnFqjtHNDuQw6wgKoCQAw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3054185A793;
	Wed, 26 Jul 2023 12:13:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 34EB6200BA7C;
	Wed, 26 Jul 2023 12:13:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <168979146324.1905271.11000616800905663660.stgit@morisot.1015granger.net>
References: <168979146324.1905271.11000616800905663660.stgit@morisot.1015granger.net> <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
To: Chuck Lever <cel@kernel.org>
Cc: dhowells@redhat.com, linux-nfs@vger.kernel.org,
    netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 1/5] SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6579.1690373615.1@warthog.procyon.org.uk>
Date: Wed, 26 Jul 2023 13:13:35 +0100
Message-ID: <6580.1690373615@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Chuck Lever <cel@kernel.org> wrote:

> Add a helper to convert a whole xdr_buf directly into an array of
> bio_vecs, then send this array instead of iterating piecemeal over
> the xdr_buf containing the outbound RPC message.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: David Howells <dhowells@redhat.com>


