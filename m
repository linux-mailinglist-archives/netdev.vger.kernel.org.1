Return-Path: <netdev+bounces-44263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FD57D7685
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC28FB20E6B
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60D2339A0;
	Wed, 25 Oct 2023 21:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7312B6D
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 21:20:46 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9866184
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 14:20:44 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-w4m3W4JtM1qeNA1RPUeHUg-1; Wed, 25 Oct 2023 17:20:26 -0400
X-MC-Unique: w4m3W4JtM1qeNA1RPUeHUg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 277A7857CF6;
	Wed, 25 Oct 2023 21:20:26 +0000 (UTC)
Received: from hog (unknown [10.39.192.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D12321121314;
	Wed, 25 Oct 2023 21:20:24 +0000 (UTC)
Date: Wed, 25 Oct 2023 23:20:23 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hangyu Hua <hbh25y@gmail.com>, borisp@nvidia.com,
	john.fastabend@gmail.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tls: Fix possible NULL-pointer dereference in
 tls_decrypt_device() and tls_decrypt_sw()
Message-ID: <ZTmGl1BFr0NQtJRn@hog>
References: <20231023080611.19244-1-hbh25y@gmail.com>
 <ZTZ9H4aDB45RzrFD@hog>
 <120e6c2c-6122-41db-8c46-7753e9659c70@gmail.com>
 <ZTjteQgXWKXDqnos@hog>
 <20231025071408.3b33f733@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025071408.3b33f733@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

2023-10-25, 07:14:08 -0700, Jakub Kicinski wrote:
> On Wed, 25 Oct 2023 12:27:05 +0200 Sabrina Dubroca wrote:
> > > My bad. I only checked &msg->msg_iter's address in tls_decrypt_sw and found
> > > it was wrong. Do I need to make a new patch to fix the harmless bogus
> > > pointer?  
> > 
> > I don't think that's necessary, but maybe it would avoid people trying
> > to "fix" this code in the future. Jakub, WDYT?
> 
> No strong feelings, but personally I find checks for conditions which
> cannot happen decrease the readability. Maybe a comment is better?

There's already a comment above tls_decrypt_sg that (pretty much) says
out_iov is only used in zero-copy mode.

 *          [...]            The input parameter 'darg->zc' indicates if
 * zero-copy mode needs to be tried or not. With zero-copy mode, either
 * out_iov or out_sg must be non-NULL.

Do we need another just above the call to tls_decrypt_sg?

-- 
Sabrina


