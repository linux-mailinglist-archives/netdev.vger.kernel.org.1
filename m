Return-Path: <netdev+bounces-109400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEFD928532
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB611F24CC4
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 09:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36CE146D6B;
	Fri,  5 Jul 2024 09:35:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0FA1465AE;
	Fri,  5 Jul 2024 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172142; cv=none; b=gXd0osQgmXNaqJnF3L8wHDQ9TI6ZMHTfaJpFUewYfiVlJnmaZDN5SM53eMiV8HIJefQReo8Z2GF/DVSgYF0Zkeo/xBO+SE7QC94uyAmSTMB2ZPCuIySQESWF3UDn+IwpTfkwMXp+w6fBfa4IGog/7O+gd8R3clIIZUI5MqgfBb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172142; c=relaxed/simple;
	bh=YIjlLoR0n3GWPTO9IjqGETA5117jD2yM9CxBxmhPTfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKWBfJx5VTFe0jzIztfGbxhrD4PPdV01fceId9Vf5EDLqoCFktGmzB54z63W78JTOSWpfPD0A4qHv+50vDos+gJxfwKZ4J+RADzIugIxk3o6rnwUpdzlp/Br8k/Nr3ScwvHOkOB5x3cXYn9z7o3c9SxnZ6UCftXc232iBOC7GhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sPfLh-0008CY-EW; Fri, 05 Jul 2024 11:35:25 +0200
Date: Fri, 5 Jul 2024 11:35:25 +0200
From: Florian Westphal <fw@strlen.de>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Chengen Du <chengen.du@canonical.com>, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ozsh@nvidia.com, paulb@nvidia.com, marcelo.leitner@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gerald Yang <gerald.yang@canonical.com>
Subject: Re: [PATCH net v2] net/sched: Fix UAF when resolving a clash
Message-ID: <20240705093525.GA30758@breakpoint.cc>
References: <20240705025056.12712-1-chengen.du@canonical.com>
 <ZoetDiKtWnPT8VTD@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoetDiKtWnPT8VTD@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)

Michal Kubiak <michal.kubiak@intel.com> wrote:
> On Fri, Jul 05, 2024 at 10:50:56AM +0800, Chengen Du wrote:
> The ct may be dropped if a clash has been resolved but is still passed to
> > the tcf_ct_flow_table_process_conn function for further usage. This issue
> > can be fixed by retrieving ct from skb again after confirming conntrack.

Right, ct can be stale after confirm.

> > diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> > index 2a96d9c1db65..6f41796115e3 100644
> > --- a/net/sched/act_ct.c
> > +++ b/net/sched/act_ct.c
> > @@ -1077,6 +1077,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
> >  		 */
> >  		if (nf_conntrack_confirm(skb) != NF_ACCEPT)
> >  			goto drop;
> > +
> > +		/* The ct may be dropped if a clash has been resolved,
> > +		 * so it's necessary to retrieve it from skb again to
> > +		 * prevent UAF.
> > +		 */
> > +		ct = nf_ct_get(skb, &ctinfo);
> > +		if (!ct)
> > +			goto drop;
> 
> After taking a closer look at this change, I have a question: Why do we
> need to change an action returned by "nf_conntrack_confirm()"
> (NF_ACCEPT) and actually perform the flow for NF_DROP?
>
> From the commit message I understand that you only want to prevent
> calling "tcf_ct_flow_table_process_conn()". But for such reason we have
> a bool variable: "skip_add".
> Shouldn't we just set "skip_add" to true to prevent the UAF?
> Would the following example code make sense in this case?
> 
> 	ct = nf_ct_get(skb, &ctinfo);
> 	if (!ct)
> 		skip_add = true;

It depends on what tc wants do to here.

For netfilter, the skb is not dropped and continues passing
through the stack. Its up to user to decide what to do with it,
e.g. doing "ct state invalid drop".

