Return-Path: <netdev+bounces-46532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021157E4C00
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 23:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328451C2040E
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 22:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FFA30645;
	Tue,  7 Nov 2023 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D5C30643
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 22:45:58 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B230913A
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 14:45:57 -0800 (PST)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-PW-tGBIhPv288BDvM0_Hag-1; Tue, 07 Nov 2023 17:45:50 -0500
X-MC-Unique: PW-tGBIhPv288BDvM0_Hag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF39285A59D;
	Tue,  7 Nov 2023 22:45:49 +0000 (UTC)
Received: from hog (unknown [10.39.192.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 163AF2166B26;
	Tue,  7 Nov 2023 22:45:47 +0000 (UTC)
Date: Tue, 7 Nov 2023 23:45:46 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Dae R. Jeong" <threeearcat@gmail.com>, borisp@nvidia.com,
	john.fastabend@gmail.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ywchoi@casys.kaist.ac.kr
Subject: Re: Missing a write memory barrier in tls_init()
Message-ID: <ZUq-GrWMvbfhX74a@hog>
References: <ZUNLocdNkny6QPn8@dragonet>
 <20231106143659.12e0d126@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231106143659.12e0d126@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

2023-11-06, 14:36:59 -0800, Jakub Kicinski wrote:
> On Thu, 2 Nov 2023 16:11:29 +0900 Dae R. Jeong wrote:
> > In addition, I believe the {tls_setsockopt, tls_getsockopt}
> > implementation is fine because of the address dependency. I think
> > load-load reordering is prohibited in this case so we don't need a
> > read barrier.
> 
> Sounds plausible, could you send a patch?
>
> The smb_wmb() would be better placed in tls_init(), IMHO.

Wouldn't it be enough to just move the rcu_assign_pointer after ctx is
fully initialized, ie just before update_sk_prot? also clearer wrt
RCU.
(and maybe get rid of tls_ctx_create and move all that into tls_init,
it's not much and we don't even set ctx->{tx,rx}_conf in there)

-- 
Sabrina


