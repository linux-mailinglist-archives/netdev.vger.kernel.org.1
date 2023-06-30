Return-Path: <netdev+bounces-14802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D56743EEA
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 17:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA882810B1
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617481641D;
	Fri, 30 Jun 2023 15:31:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA016415
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 15:31:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F56E4ED9
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688138983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2RRepOp7BBkzoiWTZGgUNtL5p6yT9JMH864pOX91L68=;
	b=EzuFwtojsMQs81Vqt1pnhFWjY32Ebc0onH22+t8PPGUQ+kcotd39T6yph8JW6HojuLF3/E
	vnZ1O3F6NE89iyaPTk3lee8W5RnHi8arZ21Ueyz5/Vuks+BHFrbmLq3fmYxCnTJjHaVGKy
	2LSoNFYLlN0RyM3r/g+/ANqbnladOwI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-qXsOTZnVPBOawnT-lDiFOA-1; Fri, 30 Jun 2023 11:29:37 -0400
X-MC-Unique: qXsOTZnVPBOawnT-lDiFOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 533A785A58A;
	Fri, 30 Jun 2023 15:29:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.195])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E332B40C6CCD;
	Fri, 30 Jun 2023 15:29:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZJ7cQ8Wdiyb0Ax/r@corigine.com>
References: <ZJ7cQ8Wdiyb0Ax/r@corigine.com> <20230629155433.4170837-1-dhowells@redhat.com> <20230629155433.4170837-3-dhowells@redhat.com>
To: Simon Horman <simon.horman@corigine.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Matthew Wilcox <willy@infradead.org>,
    Dave Chinner <david@fromorbit.com>,
    Matt Whitlock <kernel@mattwhitlock.name>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org,
    Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] splice: Make vmsplice() steal or copy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <661359.1688138974.1@warthog.procyon.org.uk>
Date: Fri, 30 Jun 2023 16:29:34 +0100
Message-ID: <661360.1688138974@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Simon Horman <simon.horman@corigine.com> wrote:

> But, on a more mundane level, GCC reports that user_page_pipe_buf_ops is
> (now) unused.  I guess this was the last user, and user_page_pipe_buf_ops
> can be removed as part of this patch.

See patch 3.

David


