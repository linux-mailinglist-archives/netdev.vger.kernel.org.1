Return-Path: <netdev+bounces-15127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEBD745C77
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 14:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7186F1C209B3
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 12:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F12DF56;
	Mon,  3 Jul 2023 12:45:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C44046AC
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 12:45:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F661E54
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 05:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688388335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sbr2zsR02hBkXXr/+t6FgeUGHT0OM2sZEGRGoWKe3g0=;
	b=bKnvSuidIbvfnIYmtpJEc0e0GMs/TWOm+9J3VpOoV7FOHv5SO0I1Nunm6uvF/uM6QgstVG
	Ibs/4dOGaUWm3ViTH6SKVqgxZApf5GKGDwSs7/40EY6vGYrKsYC1RyvB68P9Z3vw/KWfmQ
	XbrHw5NxpZ7WmcoKYVa3AmMDUC0Y4SQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-RSLTATY6NlykV4zGJ2427g-1; Mon, 03 Jul 2023 08:45:32 -0400
X-MC-Unique: RSLTATY6NlykV4zGJ2427g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2CF11C4FD85;
	Mon,  3 Jul 2023 12:45:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.195])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 90A4C15230A7;
	Mon,  3 Jul 2023 12:45:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6859f3b7-90fa-7071-857e-d9354165a445@suse.de>
References: <6859f3b7-90fa-7071-857e-d9354165a445@suse.de> <03dd8a0d-84b9-c925-9547-99f708e88997@suse.de> <20230703090444.38734-1-hare@suse.de> <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me> <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de> <bf72459d-c2e0-27d2-ad96-89a010f64408@suse.de> <873545.1688387166@warthog.procyon.org.uk>
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
Content-ID: <874610.1688388330.1@warthog.procyon.org.uk>
Date: Mon, 03 Jul 2023 13:45:30 +0100
Message-ID: <874611.1688388330@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hannes Reinecke <hare@suse.de> wrote:

>                         msg.msg_flags &= ~MSG_SPLICE_PAGES,

Ah, yes - as Sagi pointed out there's a patch for that comma there.

David


