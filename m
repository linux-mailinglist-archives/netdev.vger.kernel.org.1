Return-Path: <netdev+bounces-20551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADA6760114
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 23:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9BE1C20BA1
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 21:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADF81097C;
	Mon, 24 Jul 2023 21:20:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B488101EC
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 21:20:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43379139
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 14:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690233636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVwkfPUpFSXUbI4e0RCN90tgfefnC8zInlyZN7AoFF4=;
	b=F+SVjwFfkfkLHU5okO+M7pc8pI1OzU6wH3vzCFKrpZAsvSwfFGPx/bft4ik/pvExk59SwQ
	GNOyW/nZjuraitfE9xM8kvCNuEkug6nFtD/tyJQKtQE5TdWK/b8gwOwiJlbf2Uuwrds4hw
	erqsVV3HGLrASj7D8FPB1M2+sOOsupw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-I_GAWX1eN7ij9MzPAOoN7g-1; Mon, 24 Jul 2023 17:20:33 -0400
X-MC-Unique: I_GAWX1eN7ij9MzPAOoN7g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A01B11C068D8;
	Mon, 24 Jul 2023 21:20:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 69BB2200BA63;
	Mon, 24 Jul 2023 21:20:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000836b2805fffd6d7e@google.com>
References: <000000000000836b2805fffd6d7e@google.com>
To: syzbot <syzbot+6f66f3e78821b0fff882@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, akpm@linux-foundation.org, axboe@kernel.dk,
    herbert@gondor.apana.org.au, kuba@kernel.org,
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] KASAN: slab-out-of-bounds Read in bio_split_rw
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20205.1690233630.1@warthog.procyon.org.uk>
Date: Mon, 24 Jul 2023 22:20:30 +0100
Message-ID: <20206.1690233630@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

#syz fix: crypto: algif_hash - Fix race between MORE and non-MORE sends


