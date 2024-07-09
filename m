Return-Path: <netdev+bounces-110096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F64292AF95
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 07:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3371C21DB7
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 05:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC94F3BBC9;
	Tue,  9 Jul 2024 05:50:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE975139F
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720504200; cv=none; b=pxqF7dcHFlbyaHyWJrN42k1B6Vylb57eXOfDLcK4FB63tnGgCTHwK+iFuTibnwZoGj+Uxq5ROiUjIoMUmp7fsmciYUoIiUYgDa649YeUByDB4gq1vBL9KHdcu7xnaz4waxxz+nPFexTFAoGwWT6mOTfUwXflobhprDRzwVfSHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720504200; c=relaxed/simple;
	bh=4qy/RFEouRJyMzA1Kt2+nxhwdHIrvaxqYXtV+rOROY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwxYaL+ac5X93d6X9iMkEfDlZ0yC5NwGoAjdDJtw1UjBBSCr+xuEfzHfbxBIHnPW3QHbudTmS7fAzEC4CuZRcHgYHryOWz6RBjzWeLvdtqkCLcBpn2EtrDRwHoAYd9OYn8GmDYD34OH5PnCWIbq7gSoGpSJBTb5Q/SouoMUaudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sR3ja-0007hx-32; Tue, 09 Jul 2024 07:49:50 +0200
Date: Tue, 9 Jul 2024 07:49:50 +0200
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
Message-ID: <20240709054950.GA29568@breakpoint.cc>
References: <CADvbK_cFvGT--MVJQ=tGa4bugJ5MeeVbbTqJwNw-Aa0Tf8ppiA@mail.gmail.com>
 <e42d36d5-1395-4276-a3ed-5b914bb9d9d0@ovn.org>
 <CADvbK_dWpZd6RyqRdiHvWP9SrG1Otfi4h5Ae=yhErLc+DhLkaw@mail.gmail.com>
 <20240619201959.GA1513@breakpoint.cc>
 <CADvbK_dAB3iHmM=nkbxGJca2c_1J-NK3R4241b3RAvV8Q9Q+QQ@mail.gmail.com>
 <20240619212030.GB1513@breakpoint.cc>
 <CADvbK_dPyPP3wwjLB4pD2o_AqpXEprkn70M7e=8aVoan+vTDGg@mail.gmail.com>
 <CADvbK_fqi=m99e5+5pkHZTuRz7kKWFLZ8CFG3q=mUEtaaKm2hQ@mail.gmail.com>
 <20240708223839.GA18283@breakpoint.cc>
 <CADvbK_cYpB07dvyMSGOU3XsAJmZV_feb76hVg9tCJeFjs5iuxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_cYpB07dvyMSGOU3XsAJmZV_feb76hVg9tCJeFjs5iuxA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Xin Long <lucien.xin@gmail.com> wrote:
> > Xin Long <lucien.xin@gmail.com> wrote:
> > > I can avoid this warning by not allocating ext for commit ct in ovs:
> > >
> > > @@ -426,7 +426,7 @@ static int ovs_ct_set_labels(struct nf_conn *ct,
> > > struct sw_flow_key *key,
> > >         struct nf_conn_labels *cl;
> > >         int err;
> > >
> > > -       cl = ovs_ct_get_conn_labels(ct);
> > > +       cl = nf_ct_labels_find(ct);
> > >         if (!cl)
> > >                 return -ENOSPC;
> ovs_ct_get_conn_labels() must be replaced with nf_ct_labels_find() in here
> anyway, thinking that the confirmed ct without labels was created in other
> places (not by OVS conntrack), the warning may still be triggered when
> trying to set labels in OVS after.

Right.

> > Then ovs_ct_limit_init() and nf_connlabels_get() need to be called
> > once on the first conntrack operatation, regardless if labels are asked
> > for or not.
> >
> > Not nice but still better than current state.
> Right, not nice, it undermines the bits check against NF_CT_LABELS_MAX_SIZE.

Yes, but OTOH this bit check isn't used anymore, it comes from days when
label area was dynamically sized, today is hardcoded to 128 anyway.

