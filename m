Return-Path: <netdev+bounces-13334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61D773B490
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232341C21179
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875F65665;
	Fri, 23 Jun 2023 10:08:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EBB8BE0
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:08:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D143595
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687514822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a8zctNHXPgKBvwmbSrMZOmVOWXmFLWvtXxUTrnOkd+k=;
	b=BXul0+ZqIJ/Y/bUYtaA3aOT6kk+k5n1ua+XwFjHs/CbjrfHybHpcBTr9bDo11rf5F2s2QM
	2c9hEayAM287CWsOxEqbIj9txURZhjQy0BaMiAB8KjaPo7DNXiZwk3DriNguZ5eyDqb/78
	PW6Q+Ql01mPoSNg5lJIDx6jybxw4CC4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-kstXw8CJPgO8BATJTV0qIA-1; Fri, 23 Jun 2023 06:06:56 -0400
X-MC-Unique: kstXw8CJPgO8BATJTV0qIA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42DE11C07257;
	Fri, 23 Jun 2023 10:06:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CB61E2166B25;
	Fri, 23 Jun 2023 10:06:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ccf93f92b2539c9dddd1c45fcfa037bb21ccd808.camel@redhat.com>
References: <ccf93f92b2539c9dddd1c45fcfa037bb21ccd808.camel@redhat.com> <20230622191134.54d5cb0b@kernel.org> <20230622132835.3c4e38ea@kernel.org> <20230622111234.23aadd87@kernel.org> <20230620145338.1300897-1-dhowells@redhat.com> <20230620145338.1300897-2-dhowells@redhat.com> <1952674.1687462843@warthog.procyon.org.uk> <1958077.1687474471@warthog.procyon.org.uk> <1969749.1687511298@warthog.procyon.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
    Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
    Alexander Duyck <alexander.duyck@gmail.com>,
    "David S. Miller" <davem@davemloft.net>,
    Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
    David Ahern <dsahern@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org,
    Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next v3 01/18] net: Copy slab data for sendmsg(MSG_SPLICE_PAGES)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2048547.1687514811.1@warthog.procyon.org.uk>
Date: Fri, 23 Jun 2023 11:06:51 +0100
Message-ID: <2048548.1687514811@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Paolo Abeni <pabeni@redhat.com> wrote:

> I'm unsure I follow the above ?!? I *thought* sendpage could be killed
> even without patch 1/18 and 2/18, leaving some patches in this series
> unmodified, and mangling those explicitly leveraging 1/18 to use
> multiple sendmsg()s with different flags?

That's what I meant.

With the example, I was showing the minimum needed replacement for a call to
sendpage.

David


