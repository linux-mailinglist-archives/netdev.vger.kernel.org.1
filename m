Return-Path: <netdev+bounces-16546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC59274DC84
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 19:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182091C20B28
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 17:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D782714278;
	Mon, 10 Jul 2023 17:30:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB4614277
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 17:30:49 +0000 (UTC)
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC43C4;
	Mon, 10 Jul 2023 10:30:47 -0700 (PDT)
Received: from mg.bb.i.ssi.bg (localhost [127.0.0.1])
	by mg.bb.i.ssi.bg (Proxmox) with ESMTP id 7D8AE18F34;
	Mon, 10 Jul 2023 20:30:44 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id 63C5D191B4;
	Mon, 10 Jul 2023 20:30:44 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id 625F53C0803;
	Mon, 10 Jul 2023 20:30:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1689010240; bh=GTzycfPTuL6xYhwrHAUqSMOXS9y7swYh/taQTI/rhUo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=o+Pqd5sLAlDt8AtdXenR/ZT1D2AWctaPbUeBWEAqkXC277L3wKh8qIR5/cvopEjSx
	 hd1gczybHTnm13BnmtgUTSJVA1FcgYkLuqscDKNjNxWmLxCsa2AuEGPFC/iQ/r3ysR
	 WT6rOpnXNWqqPyl/GuJD13mSWkL/7J/Pc38M4X/A=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 36AHUYve107992;
	Mon, 10 Jul 2023 20:30:36 +0300
Date: Mon, 10 Jul 2023 20:30:34 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Dust Li <dust.li@linux.alibaba.com>
cc: Jiejian Wu <jiejian@linux.alibaba.com>, Simon Horman <horms@verge.net.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH net-next] ipvs: make ip_vs_svc_table and ip_vs_svc_fwm_table
 per netns
In-Reply-To: <20230710152809.GD6751@linux.alibaba.com>
Message-ID: <3d37360e-846a-3b01-f2ad-9c1c5720a568@ssi.bg>
References: <20230707020708.75168-1-dust.li@linux.alibaba.com> <28a87ee9-5f94-2506-3cb9-8a19144e2061@ssi.bg> <20230710152809.GD6751@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


	Hello,

On Mon, 10 Jul 2023, Dust Li wrote:

> On Sun, Jul 09, 2023 at 08:45:19PM +0300, Julian Anastasov wrote:
> >
> >	Hello,
> >
> >On Fri, 7 Jul 2023, Dust Li wrote:
> >
> >> @@ -2303,9 +2293,9 @@ static struct ip_vs_service *ip_vs_info_array(struct seq_file *seq, loff_t pos)
> >>  
> >>  	/* look in hash by protocol */
> >>  	for (idx = 0; idx < IP_VS_SVC_TAB_SIZE; idx++) {
> >> -		hlist_for_each_entry_rcu(svc, &ip_vs_svc_table[idx], s_list) {
> >> +		hlist_for_each_entry_rcu(svc, &ipvs->ip_vs_svc_table[idx], s_list) {
> >>  			if ((svc->ipvs == ipvs) && pos-- == 0) {
> >> -				iter->table = ip_vs_svc_table;
> >> +				iter->table = ipvs->ip_vs_svc_table;
> >
> >	We can change iter->table to int table_id, 0 (ip_vs_svc_table)
> >and 1 (ip_vs_svc_fwm_table), for all these ip_vs_info_* funcs.
> 
> Sorry, I don't get this. Why do we need to change this ?

	It is a hint which table to walk, no need for such
dereferences. For example:

	iter->table = ip_vs_svc_table;
	becomes
	iter->table_id = 0;

	iter->table = ip_vs_svc_fwm_table;
	becomes
	iter->table_id = 1;

	etc

> >> @@ -3392,9 +3384,9 @@ static int ip_vs_genl_dump_services(struct sk_buff *skb,
> >>  	struct net *net = sock_net(skb->sk);
> >>  	struct netns_ipvs *ipvs = net_ipvs(net);
> >>  
> >> -	mutex_lock(&__ip_vs_mutex);
> >> +	mutex_lock(&ipvs->service_mutex);
> >
> >	While do_ip_vs_get_ctl is a reader that can block we
> >can not use RCU but in ip_vs_genl_dump_services() we can replace
> >the __ip_vs_mutex with rcu_read_lock because we just fill the skb.
> >
> 
> I think we can replace mutex in ip_vs_genl_dump_services() by RCU.
> Do you prefer replacing it in this patch or later ?

	You can include these RCU conversions

> >	Also, there is more work if we want independent
> >namespaces and to give power to users:
> >
> >- account memory: GFP_KERNEL -> GFP_KERNEL_ACCOUNT
> >
> >- the connections table is still global but it should be possible
> >to make all tables per-net and to grow on load from NULL to max bits
> >
> >- convert GENL_ADMIN_PERM -> GENL_UNS_ADMIN_PERM and make
> >sysctls visible to other namespaces
> >
> >	If the plan is to have multiple netns loaded with many
> >conns may be I can follow your patch with more optimization
> >patches.
> 
> Yes, we do missed those details. I think moving those into different
> netns is good, besides we already have netns supported. So why not do
> it more completely ?
> 
> If it is convenient for you to do more optimizations, we would greatly
> appreciate it !

	Yes, I'll prepare more patches on top of your patch.

Regards

--
Julian Anastasov <ja@ssi.bg>


