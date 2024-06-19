Return-Path: <netdev+bounces-105034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4817A90F778
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7E7283E54
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACF745BF1;
	Wed, 19 Jun 2024 20:20:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4DAFC0C
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718828413; cv=none; b=umKH6HtcNNQnMnEaGeRzVdppHaShM9uVLLmt2JmnzqTn0odKtVfEFGnAETZG/tOKIAuaaIw1nyQus2pO0xkPhbhh1H0FVenBlFG9Cmgo/hvUWZEsFfDNZoI4tPrKjAZ7X8bDc2r4GFFaqkPhFX71g8tzQbRW6sLJHwzimt6qtCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718828413; c=relaxed/simple;
	bh=2u6c9DvRW6c/ZID9ei3+okhJP+O2vuieOd1dfJIIyrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPoOljRLtgUMAPw10CuF7YkLP667unNUd6kaPHVAL+X5QcDhEtjBcs14sct1aZwZ4nqFUGhz4KTutwYZ+KnkPH8d//uXr450w4OXD66X0tZIIn7RE+aMkfhqcWrtnPH63tCg3M9qvR4gdWrtZPWfkKm5Ei6mlClKC1RewctV+lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sK1mh-0002Ym-2x; Wed, 19 Jun 2024 22:19:59 +0200
Date: Wed, 19 Jun 2024 22:19:59 +0200
From: Florian Westphal <fw@strlen.de>
To: Xin Long <lucien.xin@gmail.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, Florian Westphal <fw@strlen.de>,
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
Message-ID: <20240619201959.GA1513@breakpoint.cc>
References: <cover.1689541664.git.lucien.xin@gmail.com>
 <cf477f4a26579e752465a5951c1d28ba109346e3.1689541664.git.lucien.xin@gmail.com>
 <d35d01d9-83de-4862-85a7-574a6c4dc8f5@ovn.org>
 <e90b291a-0e19-4b80-9738-5b769fcdcdfd@ovn.org>
 <CADvbK_f9=smg+C7M3dWWj9nvv7Z7_jCLn=6m0OLhmF_V0AEFsg@mail.gmail.com>
 <5a9886fd-cdd7-4aa2-880f-5664288d5f25@ovn.org>
 <619f9212-fa90-44d2-9951-800523413c8d@ovn.org>
 <CADvbK_cFvGT--MVJQ=tGa4bugJ5MeeVbbTqJwNw-Aa0Tf8ppiA@mail.gmail.com>
 <e42d36d5-1395-4276-a3ed-5b914bb9d9d0@ovn.org>
 <CADvbK_dWpZd6RyqRdiHvWP9SrG1Otfi4h5Ae=yhErLc+DhLkaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_dWpZd6RyqRdiHvWP9SrG1Otfi4h5Ae=yhErLc+DhLkaw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Xin Long <lucien.xin@gmail.com> wrote:
> > master connection only if it is not yet confirmed.  Users may commit different
> > labels for the related connection.  This should be more in line with the
> > previous behavior.
> >
> > What do you think?
> >
> You're right.
> Also, I noticed the related ct->mark is set to master ct->mark in
> init_conntrack() as well as secmark when creating the related ct.
> 
> Hi, Florian,
> 
> Any reason why the labels are not set to master ct's in there?

The intent was to have lables be set only via ctnetlink (userspace)
or ruleset.

The original use case was for tagging connections based on
observed behaviour/properties at a later time, not at start of flow.

