Return-Path: <netdev+bounces-15119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4F2745C2E
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 14:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B511C2096D
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 12:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F6DEAC0;
	Mon,  3 Jul 2023 12:26:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2EEE573
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 12:26:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1420109
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 05:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688387174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVofWdEz7bPzVywRRrykczglwboQojFlLWbpVyADLFA=;
	b=h4B2YLGIWq8S2ygpCHJLFV499wTH6xVvoMYyfMWi8SW//jJd3uLcOKRPKFc93iG2JS5dZ4
	zSuM+o1LaDl0Do/faEVMC7501F43nSjXe7F9YH6ihET0d5GV7IVXl5PqlZB/si4MCeVJGa
	Fl/bQ4B5J1lPtjKTEVFDJaAnGeM6LqQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-9WRvCSZNMxiG57Oj8TujEQ-1; Mon, 03 Jul 2023 08:26:09 -0400
X-MC-Unique: 9WRvCSZNMxiG57Oj8TujEQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BED7800CAF;
	Mon,  3 Jul 2023 12:26:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.195])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B500814682F9;
	Mon,  3 Jul 2023 12:26:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <03dd8a0d-84b9-c925-9547-99f708e88997@suse.de>
References: <03dd8a0d-84b9-c925-9547-99f708e88997@suse.de> <20230703090444.38734-1-hare@suse.de> <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me> <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de> <bf72459d-c2e0-27d2-ad96-89a010f64408@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: dhowells@redhat.com, Sagi Grimberg <sagi@grimberg.me>,
    Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
    linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    netdev@vger.kernel.org
Subject: Re: [PATCHv6 0/5] net/tls: fixes for NVMe-over-TLS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <873544.1688387166.1@warthog.procyon.org.uk>
Date: Mon, 03 Jul 2023 13:26:06 +0100
Message-ID: <873545.1688387166@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hannes Reinecke <hare@suse.de> wrote:

> > 'discover' and 'connect' works, but when I'm trying to transfer data
> > (eg by doing a 'mkfs.xfs') the whole thing crashes horribly in
> > sock_sendmsg() as it's trying to access invalid pages :-(

Can you be more specific about the crash?

David


