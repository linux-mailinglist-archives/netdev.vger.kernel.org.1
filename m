Return-Path: <netdev+bounces-28510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5FB77FA77
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9472A281D3E
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CBD14F90;
	Thu, 17 Aug 2023 15:14:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B4414F82
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 15:14:17 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C673590;
	Thu, 17 Aug 2023 08:14:10 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qWegr-0002Mq-Sh; Thu, 17 Aug 2023 17:13:37 +0200
Date: Thu, 17 Aug 2023 17:13:37 +0200
From: Florian Westphal <fw@strlen.de>
To: Lu Wei <luwei32@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, wsa+renesas@sang-engineering.com,
	tglx@linutronix.de, peterz@infradead.org, maheshb@google.com,
	fw@strlen.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipvlan: Fix a reference count leak warning in
 ipvlan_ns_exit()
Message-ID: <20230817151337.GH4312@breakpoint.cc>
References: <20230817145449.141827-1-luwei32@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817145449.141827-1-luwei32@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Lu Wei <luwei32@huawei.com> wrote:
> There are two network devices(veth1 and veth3) in ns1, and ipvlan1 with
> L3S mode and ipvlan2 with L2 mode are created based on them as
> figure (1). In this case, ipvlan_register_nf_hook() will be called to
> register nf hook which is needed by ipvlans in L3S mode in ns1 and value
> of ipvl_nf_hook_refcnt is set to 1.

[..]

> register nf_hook in ns2 and unregister nf_hook in ns1. As a result,
> ipvl_nf_hook_refcnt in ns1 is decreased incorrectly and this in ns2
> is increased incorrectly. When the second net namespace is removed, a
> reference count leak warning in ipvlan_ns_exit() will be triggered.
> 
> This patch add a check before ipvlan_migrate_l3s_hook() is called.

Reviewed-by: Florian Westphal <fw@strlen.de>

