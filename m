Return-Path: <netdev+bounces-55777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5693C80C494
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8660F1C209A4
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 09:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0A921357;
	Mon, 11 Dec 2023 09:30:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546A1B3
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 01:30:25 -0800 (PST)
Received: from [78.30.43.141] (port=42842 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rCccD-00GnZc-SG; Mon, 11 Dec 2023 10:30:19 +0100
Date: Mon, 11 Dec 2023 10:30:16 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: jhs@mojatatu.com, Vlad Buslov <vladbu@nvidia.com>, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
	louis.peens@corigine.com, yinjun.zhang@corigine.com,
	simon.horman@corigine.com, jiri@resnulli.us,
	xiyou.wangcong@gmail.com, Paul Blakey <paulb@nvidia.com>
Subject: Re: [PATCH net] net/sched: act_ct: Take per-cb reference to
 tcf_ct_flow_table
Message-ID: <ZXbWqP3oO7gtliMK@calendula>
References: <20231205172554.3570602-1-vladbu@nvidia.com>
 <20231208154035.7cbec2f7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231208154035.7cbec2f7@kernel.org>
X-Spam-Score: -1.9 (-)

On Fri, Dec 08, 2023 at 03:40:35PM -0800, Jakub Kicinski wrote:
> On Tue, 5 Dec 2023 18:25:54 +0100 Vlad Buslov wrote:
> > The referenced change added custom cleanup code to act_ct to delete any
> > callbacks registered on the parent block when deleting the
> > tcf_ct_flow_table instance. However, the underlying issue is that the
> > drivers don't obtain the reference to the tcf_ct_flow_table instance when
> > registering callbacks which means that not only driver callbacks may still
> > be on the table when deleting it but also that the driver can still have
> > pointers to its internal nf_flowtable and can use it concurrently which
> > results either warning in netfilter[0] or use-after-free.
> > 
> > Fix the issue by taking a reference to the underlying struct
> > tcf_ct_flow_table instance when registering the callback and release the
> > reference when unregistering. Expose new API required for such reference
> > counting by adding two new callbacks to nf_flowtable_type and implementing
> > them for act_ct flowtable_ct type. This fixes the issue by extending the
> > lifetime of nf_flowtable until all users have unregistered.
> 
> Some acks would be good here - Pablo, Jamal?

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

I'd prefer driver does not access nf_flowtable directly, I already
mentioned this in the past.

