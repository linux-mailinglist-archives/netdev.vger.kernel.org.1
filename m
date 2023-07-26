Return-Path: <netdev+bounces-21364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62285763606
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C44B2812AF
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F23BC136;
	Wed, 26 Jul 2023 12:15:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035B4C132
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:15:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948B319A7
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690373735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84g7atOPu2tztvy36dveiFbDeLVcuT1Pc2w+WrFKbi8=;
	b=SDTQKQv4pBtOMJHB+6ANu1382L2QBsst1/PMD1LFXIcMcYWBKjNg5ZMsHsOnGmZLnGx6tA
	Y8ZW8xyvpI4s6+n90QlGvowJzuGVdNSsDUXjVyNe+Ae8iXpxW0HEAJHP9B9ViOUuT8aIFE
	KP9InyFsdd7dLwRYdv9gPs2287gbmA8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-zkogntADNbu_U0yKYHSGpw-1; Wed, 26 Jul 2023 08:15:32 -0400
X-MC-Unique: zkogntADNbu_U0yKYHSGpw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECFD538008AA;
	Wed, 26 Jul 2023 12:15:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 579B4F782E;
	Wed, 26 Jul 2023 12:15:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <168979147611.1905271.944494362977362823.stgit@morisot.1015granger.net>
References: <168979147611.1905271.944494362977362823.stgit@morisot.1015granger.net> <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
To: Chuck Lever <cel@kernel.org>
Cc: dhowells@redhat.com, linux-nfs@vger.kernel.org,
    netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 3/5] SUNRPC: Convert svc_udp_sendto() to use the per-socket bio_vec array
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6649.1690373730.1@warthog.procyon.org.uk>
Date: Wed, 26 Jul 2023 13:15:30 +0100
Message-ID: <6650.1690373730@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Should svc_udp_sendto() also be using MSG_SPLICE_PAGES now?

David


