Return-Path: <netdev+bounces-110063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9777D92AC8A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 01:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34BA9B22814
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0B5152E0E;
	Mon,  8 Jul 2024 23:23:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25C152798
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720481017; cv=none; b=X7oQpr6R+KRAknYRaCwdZTUk7A+Tcojhjb1XHezNak0qw4EGfn9z5WLigKSt9Kh82l5W89sLLMAkC61BmmhE7VV6Wp8oRp3r8rp9sKatQ/kMSpKe4I+2slgR0e6C3MsmX2y0Cmg7BbUhfr8C30Y+kMNZjSEeILrjdkcvSCaONXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720481017; c=relaxed/simple;
	bh=viFzJ94D/9goW4gHxe8JXgfhSTzovaLlzFiulBvvjjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwNTCTITuWj3yKOK7iI7vyMnBxFj7AU+nzP3EcJJeAukD5gq2fBW14HKf9VBSGulk4PuawAdRKKPCtP4NUScbzv5VmwCHAysjYLQXDIwogV6HXg5CjXAD6xjAQ8XWtjgsgUQI58dCgMIkmWnsyeglSXAePIb47qKhUAv6lBVKI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sQx0J-0004pJ-Iz; Tue, 09 Jul 2024 00:38:39 +0200
Date: Tue, 9 Jul 2024 00:38:39 +0200
From: Florian Westphal <fw@strlen.de>
To: Xin Long <lucien.xin@gmail.com>
Cc: Florian Westphal <fw@strlen.de>, Ilya Maximets <i.maximets@ovn.org>,
	network dev <netdev@vger.kernel.org>, dev@openvswitch.org,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Davide Caratti <dcaratti@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Eric Dumazet <edumazet@google.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, kuba@kernel.org,
	Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH net-next 3/3] openvswitch: set IPS_CONFIRMED in tmpl
 status only when commit is set in conntrack
Message-ID: <20240708223839.GA18283@breakpoint.cc>
References: <5a9886fd-cdd7-4aa2-880f-5664288d5f25@ovn.org>
 <619f9212-fa90-44d2-9951-800523413c8d@ovn.org>
 <CADvbK_cFvGT--MVJQ=tGa4bugJ5MeeVbbTqJwNw-Aa0Tf8ppiA@mail.gmail.com>
 <e42d36d5-1395-4276-a3ed-5b914bb9d9d0@ovn.org>
 <CADvbK_dWpZd6RyqRdiHvWP9SrG1Otfi4h5Ae=yhErLc+DhLkaw@mail.gmail.com>
 <20240619201959.GA1513@breakpoint.cc>
 <CADvbK_dAB3iHmM=nkbxGJca2c_1J-NK3R4241b3RAvV8Q9Q+QQ@mail.gmail.com>
 <20240619212030.GB1513@breakpoint.cc>
 <CADvbK_dPyPP3wwjLB4pD2o_AqpXEprkn70M7e=8aVoan+vTDGg@mail.gmail.com>
 <CADvbK_fqi=m99e5+5pkHZTuRz7kKWFLZ8CFG3q=mUEtaaKm2hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_fqi=m99e5+5pkHZTuRz7kKWFLZ8CFG3q=mUEtaaKm2hQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Xin Long <lucien.xin@gmail.com> wrote:
> I can avoid this warning by not allocating ext for commit ct in ovs:
> 
> @@ -426,7 +426,7 @@ static int ovs_ct_set_labels(struct nf_conn *ct,
> struct sw_flow_key *key,
>         struct nf_conn_labels *cl;
>         int err;
> 
> -       cl = ovs_ct_get_conn_labels(ct);
> +       cl = nf_ct_labels_find(ct);
>         if (!cl)
>                 return -ENOSPC;
> 
> However, the test case would fail, although the failure can be worked around
> by setting ct_label in the 1st rule:
> 
>   table=0,priority=30,in_port=1,ip,nw_dst=172.1.1.2,actions=ct(commit,nat(dst=10.1.1.2:80),exec(set_field:0x01->ct_label),table=1)
> 
> So I'm worrying our change may break some existing OVS user cases.

Then ovs_ct_limit_init() and nf_connlabels_get() need to be called
once on the first conntrack operatation, regardless if labels are asked
for or not.

Not nice but still better than current state.

ovs_ct_execute() perhaps?

