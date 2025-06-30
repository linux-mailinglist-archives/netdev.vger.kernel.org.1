Return-Path: <netdev+bounces-202424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09275AEDD01
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A3237AAA6E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C27128A73F;
	Mon, 30 Jun 2025 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0G5pjEl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB228AAF7
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286913; cv=none; b=IEvrKuNJwc7PqH7tgy2B9imeKtjTBwZyO0MyUUfNSz/TyHdma5NmFHN4uNMgcIsB0m/W21l31t0mfSCM1PDwC4srx0vppOk5NM0xMho9Vqh9FFw+2azgvFcrklmSwBygXtgWx7fO+koGLzNwJhAdX81M+T1uIIbWIwkpUF20Gnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286913; c=relaxed/simple;
	bh=lY3Zsewcm2ReGuVfcxa8lSUEgvcXNn0cstVJAeJ/Zk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qvsLmfHdejKYZkeVpCSQlY2S6ZdXARVckQwpYLii4dZzzRi5tkX8RDUzPSZh2za9mEvhDTm1zxD2FLrwfaCmI5WzAtsEZNJCw3yygC78Aeh7gncnYeVPVc8PSJmTtJ5axGV7WbMORQet7pZIMRiwG17N9smj8sO/9QxVrcZx5Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V0G5pjEl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751286909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nmXj/nQM+/0F5mb9kwoXzTFhwJUIHJlzLE6L627y4sg=;
	b=V0G5pjElXZnx0mK6qjDO0w3S0F9EoFUGGN7nrV4jLGgieCjHUxRFLgSp0Nsri/cHNLhCdp
	t8/aSQ/WWLSR2DXskn6zQAnDSN+ccjYTSriqUMECPPJWf83MUISiYaSlZe/2y1NqaxN2iy
	7d7DUGY2wzAfpgtoAstlM/fkHVk54dE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-Tmf72cqUMr-wbeSSJXZXNA-1; Mon,
 30 Jun 2025 08:35:04 -0400
X-MC-Unique: Tmf72cqUMr-wbeSSJXZXNA-1
X-Mimecast-MFC-AGG-ID: Tmf72cqUMr-wbeSSJXZXNA_1751286902
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F7701955EC1;
	Mon, 30 Jun 2025 12:35:02 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.89.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E997830001B1;
	Mon, 30 Jun 2025 12:34:58 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: dev@openvswitch.org,  netdev@vger.kernel.org,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Eelco Chaudron <echaudro@redhat.com>,  Ilya
 Maximets <i.maximets@ovn.org>,  =?utf-8?Q?Adri=C3=A1n?= Moreno
 <amorenoz@redhat.com>,  Mike
 Pattrick <mpattric@redhat.com>,  Florian Westphal <fw@strlen.de>,  John
 Fastabend <john.fastabend@gmail.com>,  Jakub Sitnicki
 <jakub@cloudflare.com>,  Joe Stringer <joe@ovn.org>
Subject: Re: [RFC] net: openvswitch: Inroduce a light-weight socket map
 concept.
In-Reply-To: <aGAWMLjQhKPvKx2R@pop-os.localdomain> (Cong Wang's message of
	"Sat, 28 Jun 2025 09:20:00 -0700")
References: <20250627210054.114417-1-aconole@redhat.com>
	<aGAWMLjQhKPvKx2R@pop-os.localdomain>
Date: Mon, 30 Jun 2025 08:34:56 -0400
Message-ID: <f7ta55ppfv3.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Cong Wang <xiyou.wangcong@gmail.com> writes:

> On Fri, Jun 27, 2025 at 05:00:54PM -0400, Aaron Conole wrote:
>> The Open vSwitch module allows a user to implemnt a flow-based
>> layer 2 virtual switch.  This is quite useful to model packet
>> movement analagous to programmable physical layer 2 switches.
>> But the openvswitch module doesn't always strictly operate at
>> layer 2, since it implements higher layer concerns, like
>> fragmentation reassembly, connection tracking, TTL
>> manipulations, etc.  Rightly so, it isn't *strictly* a layer
>> 2 virtual forwarding function.
>> 
>> Other virtual forwarding technologies allow for additional
>> concepts that 'break' this strict layer separation beyond
>> what the openvswitch module provides.  The most handy one for
>> openvswitch to start looking at is the concept of the socket
>> map, from eBPF.  This is very useful for TCP connections,
>> since in many cases we will do container<->container
>> communication (although this can be generalized for the
>> phy->container case).
>> 
>> This patch provides two different implementations of actions
>> that can be used to construct the same kind of socket map
>> capability within the openvswitch module.  There are additional
>> ways of supporting this concept that I've discussed offline,
>> but want to bring it all up for discussion on the mailing list.
>> This way, "spirited debate" can occur before I spend too much
>> time implementing specific userspace support for an approach
>> that may not be acceptable.  I did 'port' these from
>> implementations that I had done some preliminary testing with
>> but no guarantees that what is included actually works well.
>> 
>> For all of these, they are implemented using raw access to
>> the tcp socket.  This isn't ideal, and a proper
>> implementation would reuse the psock infrastructure - but
>> I wanted to get something that we can all at least poke (fun)
>> at rather than just being purely theoretical.  Some of the
>> validation that we may need (for example re-writing the
>> packet's headers) have been omitted to hopefully make the
>> implementations a bit easier to parse.  The idea would be
>> to validate these in the validate_and_copy routines.
>
> Maybe it is time to introduce eBPF to openvswitch so that they can
> share, for example, socket maps, from other layers?

Hi Cong,

Yes, it's a good thought.  I don't really know the best way to introduce
it.  What I mean is, I'd rather completely switch to using something
like a set of XDP hooks all the way through, but currently OVS datapath
is still too complex to express in eBPF, from my understanding.
Hopefully that can change in the future, and then we can seriously
consider a larger effort like that.

But let's say we try a partial approach - for example, we can add
something like an rx side hook at ovs_vport_receive that builds an
xdp_buff object and passes it along.  That can let us use this one
specific use case, but it may not give the same kind of "XDP"
performance boost that people are used to seeing (if that matters) -
we're long past the time where an skb has been built and may need to
coalesce or ignore some skb from the driver.  I guess it's still doable,
and then the userspace can just attach the eBPF programs it wants.
Probably, we would add the xdp program to the vport object instead of to
the underlying device?  In that case sketching it in ovs_vport_receive()
might look like:

  {
  	struct bpf_prog *xdp_prog;
  	....

  	xdp_prog = rcu_dereference(vport->xdp_prog);
  	if (xdp_prog) {
  		struct xdp_buff xdpb = { ... }; /* Set up buff */
  		int result;

  		result = bpf_prog_run(xdp_prog, &xdpb);
  		switch (result) {
  		... /* break for XDP_PASS, and 'exit' for others*/
  		}
  	}

  	/* Extract flow from 'skb' into 'key'. */
	error = ovs_flow_key_extract(tun_info, skb, &key);

  }

Then I guess we can just do all the accounting, etc. in userspace.  But
I'm not sure whether that's better than being able to implement the
entire datapath in XDP from the start.  Although, it does solve the
immediate idea - getting access to bpf sockmap.  Not sure what others
think about that approach.  It's important to note that currently, OVS
userspace would need quite a bit more work to deal with this since it
isn't in the 'flow' that OVS is setup to deal with, so things like
accounting need to be changed on that side anyway.  The kernel hook for
it could be easier to add overall.

There's other possibility - like doing it as an action, but how that
would work from the userspace side is less clear to me because what a
user of (for example) the ovs-vswitchd daemon sees is actually openflow.
The DP actions aren't always a direct translation.  Maybe that's okay,
but it means much heavier changes in the userspace that I didn't think
about yet (for example, which cases make sense to use it).

> Thanks.


