Return-Path: <netdev+bounces-105065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3F390F86C
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 23:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCAC1F21454
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE9F78C6D;
	Wed, 19 Jun 2024 21:20:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2E81D52B
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718832039; cv=none; b=rk9GpyOBwvvwhKK/ZABnZKNPVEprI2B2KoV8lrpjjo+P/J1WK5HK0hqwqP4zOIilCx0WCHmk+OaDJd9qJcz0J+vVepirs9FGUe2t8lOXMhNag3fwqU/peMfCjMxRw/tBz5Toytl1aVDPDYplLzrQ0Rx2aRuW2PRKeCVZrmYSVDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718832039; c=relaxed/simple;
	bh=3c+/iB98ztOoFHDjZBRZz5BQm+jz9vmvDHuS4m8eXAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNsYu9zhFijGNGKA/8+c7iLUmEiBsHUbaj01QwU5fVGhQFiu3KIA1aKXYWD9y26Yp5ug+wylirXHXvGsiTwHKij6rrkSw9ukmNNXBJcczXqYlkqT1qbPae5QTPr9Mm+VrkcKG4sF8ZfkmDhK47xDqe4qGGlm8XKG4IcWmILr5BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sK2jG-0002wn-11; Wed, 19 Jun 2024 23:20:30 +0200
Date: Wed, 19 Jun 2024 23:20:30 +0200
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
Message-ID: <20240619212030.GB1513@breakpoint.cc>
References: <d35d01d9-83de-4862-85a7-574a6c4dc8f5@ovn.org>
 <e90b291a-0e19-4b80-9738-5b769fcdcdfd@ovn.org>
 <CADvbK_f9=smg+C7M3dWWj9nvv7Z7_jCLn=6m0OLhmF_V0AEFsg@mail.gmail.com>
 <5a9886fd-cdd7-4aa2-880f-5664288d5f25@ovn.org>
 <619f9212-fa90-44d2-9951-800523413c8d@ovn.org>
 <CADvbK_cFvGT--MVJQ=tGa4bugJ5MeeVbbTqJwNw-Aa0Tf8ppiA@mail.gmail.com>
 <e42d36d5-1395-4276-a3ed-5b914bb9d9d0@ovn.org>
 <CADvbK_dWpZd6RyqRdiHvWP9SrG1Otfi4h5Ae=yhErLc+DhLkaw@mail.gmail.com>
 <20240619201959.GA1513@breakpoint.cc>
 <CADvbK_dAB3iHmM=nkbxGJca2c_1J-NK3R4241b3RAvV8Q9Q+QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_dAB3iHmM=nkbxGJca2c_1J-NK3R4241b3RAvV8Q9Q+QQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Xin Long <lucien.xin@gmail.com> wrote:
> Got it, I will fix this in ovs.

Thanks!

I don't want to throw more work at you, but since you are
already working on ovs+conntrack:

ovs_ct_init() is bad, as this runs unconditionally.

modprobe openvswitch -> conntrack becomes active in all
existing and future namespaces.

Conntrack is slow, we should avoid this behaviour.

ovs_ct_limit_init() should be called only when the feature is
configured (the problematic call is nf_conncount_init, as that
turns on connection tracking, the kmalloc etc is fine).

Likewise, nf_connlabels_get() should only be called when
labels are added/configured, not at the start.

I resolved this for tc in 70f06c115bcc but it seems i never
got around to fix it for ovs.

