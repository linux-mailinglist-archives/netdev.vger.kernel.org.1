Return-Path: <netdev+bounces-32547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A39798445
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 10:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD11B2819EE
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 08:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A087F1865;
	Fri,  8 Sep 2023 08:41:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930BB1849
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 08:41:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C88A1BDA
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 01:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694162505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hY8tZO882Jl0E+LR6+k1KutgEB/prW8NTGo4X92b6p4=;
	b=IfIgBxjCn4BEfAjSzIKGScDH3kdgO007gojKJgd8ou1leFNRVH86B0zsK3DoGxffv8KZ9J
	9WctpwFn+/X67q+w37CbKNdW7jKLD7Yzihq8FAa1hDZudUT3f5VeN90Vu4690y4L7nWILo
	eAcchGjPcAdkxC4HfbOTwlZmdOdNrGs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-cb6fuJdoPgeyTvXtnnt2jQ-1; Fri, 08 Sep 2023 04:41:42 -0400
X-MC-Unique: cb6fuJdoPgeyTvXtnnt2jQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FCE2817077;
	Fri,  8 Sep 2023 08:41:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.148])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 85397525726;
	Fri,  8 Sep 2023 08:41:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20230905141604.GA27370@lst.de>
References: <20230905141604.GA27370@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, Jan Kara <jack@suse.cz>,
    David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
    Lei Huang <lei.huang@linux.intel.com>, miklos@szeredi.hu,
    Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
    Jeff Layton <jlayton@kernel.org>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Anna Schumaker <anna@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    John Fastabend <john.fastabend@gmail.com>,
    Jakub Sitnicki <jakub@cloudflare.com>,
    Boris Pismenny <borisp@nvidia.com>, linux-nfs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
    linux-mm@kvack.org, v9fs@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: getting rid of the last memory modifitions through gup(FOLL_GET)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1520559.1694162496.1@warthog.procyon.org.uk>
Date: Fri, 08 Sep 2023 09:41:36 +0100
Message-ID: <1520560.1694162496@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Christoph Hellwig <hch@lst.de> wrote:

> we've made some nice progress on converting code that modifies user
> memory to the pin_user_pages interface, especially though the work
> from David Howells on iov_iter_extract_pages.  This thread tries to
> coordinate on how to finish off this work.

Right at this moment, I'm writing some kunit tests for iov_iter and I've found
at least one bug.

David


