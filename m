Return-Path: <netdev+bounces-46582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB787E5264
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 10:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674BD28130B
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 09:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C83DDDD2;
	Wed,  8 Nov 2023 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621CEDDC2
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 09:08:21 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AD6171D
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 01:08:20 -0800 (PST)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375--2j0IgigP7ym7xCqA1Yr_g-1; Wed, 08 Nov 2023 04:08:03 -0500
X-MC-Unique: -2j0IgigP7ym7xCqA1Yr_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EFF382DFB0;
	Wed,  8 Nov 2023 09:08:01 +0000 (UTC)
Received: from hog (unknown [10.39.192.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A9D240C6EB9;
	Wed,  8 Nov 2023 09:07:59 +0000 (UTC)
Date: Wed, 8 Nov 2023 10:07:58 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Dae R. Jeong" <threeearcat@gmail.com>, borisp@nvidia.com,
	john.fastabend@gmail.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ywchoi@casys.kaist.ac.kr
Subject: Re: Missing a write memory barrier in tls_init()
Message-ID: <ZUtP7lMqFnNK8lw_@hog>
References: <ZUNLocdNkny6QPn8@dragonet>
 <20231106143659.12e0d126@kernel.org>
 <ZUq-GrWMvbfhX74a@hog>
 <20231107185324.22eecf10@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231107185324.22eecf10@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

2023-11-07, 18:53:24 -0800, Jakub Kicinski wrote:
> On Tue, 7 Nov 2023 23:45:46 +0100 Sabrina Dubroca wrote:
> > Wouldn't it be enough to just move the rcu_assign_pointer after ctx is
> > fully initialized, ie just before update_sk_prot? also clearer wrt
> > RCU.
> 
> I'm not sure, IIUC rcu_assign_pointer() is equivalent to
> WRITE_ONCE() on any sane architecture, it depends on address
> dependencies to provide ordering.

Not what the doc says:

    /**
     * rcu_assign_pointer() - assign to RCU-protected pointer
     [...]
     * Inserts memory barriers on architectures that require them
     * (which is most of them), and also prevents the compiler from
     * reordering the code that initializes the structure after the pointer
     * assignment.
     [...]
     */

And it uses smp_store_release (unless writing NULL).


rcu_dereference is the one that usually doesn't contain a barrier:

    /**
     * rcu_dereference_check() - rcu_dereference with debug checking
     [...]
     * Inserts memory barriers on architectures that require them
     * (currently only the Alpha), prevents the compiler from refetching
     * (and from merging fetches), and, more importantly, documents exactly
     * which pointers are protected by RCU and checks that the pointer is
     * annotated as __rcu.
     */


> Since here we care about
> ctx->sk_prot being updated, when changes to sk->sk_prot
> are visible there is no super-obvious address dependency.
> 
> There may be one. But to me at least it isn't an obvious
> "RCU used right will handle this" case.

Ok, I think you're right. Looking at smp_store_release used by rcu_assign_pointer:

    #define __smp_store_release(p, v)					\
    do {									\
    	compiletime_assert_atomic_type(*p);				\
    	barrier();							\
    	WRITE_ONCE(*p, v);						\
    } while (0)

it's only going to make sure ctx->sk_proto is set when ctx is visible,
and not guarantee that ctx is visible whenever sk->sk_prot has been
switched over.

-- 
Sabrina


