Return-Path: <netdev+bounces-110975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FC592F2FA
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8BEDB237BD
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC8410E3;
	Fri, 12 Jul 2024 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="y9+oXhF0"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B8910F7
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 00:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720743536; cv=none; b=YQUHHmbHrrQ5EB/Denu/A8wuOqEhwZBZWh1KUWxd1uXkUErj/BDA770WfBzz+nYGFxI4vv2CWNvuCNq/O6SRzUTNYt65q1KzpuFi+lE1gfpXci0uzeLOGVy5dh5zfrrufyQi0/V2weHTwgUyEQMJH2YF0227tuke1z8SPDGy0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720743536; c=relaxed/simple;
	bh=dHA1sAyICXeXAyeTrTyn+F1a3T53f9Ce1DxfhpdX9F8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WlqzW9UYeF+rYWuTSXQ7chVEiIEB+IcsmPchl83YSRR5//JgwkWc7XIdT4ciK2ethF+XrMBnfQHFOBUqnm8zMpdccEKnvxYCZUmbjypgx4fDvUCL8NjxvCSvHU6JKkYcw+fRrqdRHikOeubb50MTXfpuEcZliULcvOBnYOFfwOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=y9+oXhF0; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 86C1C2C05DB;
	Fri, 12 Jul 2024 12:18:50 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1720743530;
	bh=3OCG5/sq7hUWed5H/Wvskkk6G+SOIRvNFtZx0uP4BXY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=y9+oXhF0D8kE2mLdL47A8yVwqy0fAeTJ4388Sqel5G//sZlw1y7yS0/tOF9An+Apo
	 qmnJi8Y6YllzrEpw/Y8nMELjwcZ4Z/jxNB2DY3YeDsa/xYC4vALeNju/2y12svDa+J
	 moMIbZ9OSvGWhTHdF1TNGTidsakcsUYlq1zSy8wqiy3mIvjfYt7cy11uchEBom1y7A
	 0R2tXWaHduGYh3dsg46OtNs7A3G5shLMwrvD8WtZR1rft0G3PuI0fbz4E4kZYqzabx
	 aIqlqJDJLuI5/pp/K/Jm4pL9DqYAG2E+SyrA5Zw8C7OGGb/mtBIwsQ72G05mXn+FTh
	 kAoNu2JpJuE4Q==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6690766a0000>; Fri, 12 Jul 2024 12:18:50 +1200
Received: from elliota2-dl.ws.atlnz.lc (elliota-dl.ws.atlnz.lc [10.33.23.28])
	by pat.atlnz.lc (Postfix) with ESMTP id 59F2A13EE2B;
	Fri, 12 Jul 2024 12:18:50 +1200 (NZST)
Received: by elliota2-dl.ws.atlnz.lc (Postfix, from userid 1775)
	id 56C193C0681; Fri, 12 Jul 2024 12:18:50 +1200 (NZST)
Received: from localhost (localhost [127.0.0.1])
	by elliota2-dl.ws.atlnz.lc (Postfix) with ESMTP id 53F3A3C0149;
	Fri, 12 Jul 2024 12:18:50 +1200 (NZST)
Date: Fri, 12 Jul 2024 12:18:50 +1200 (NZST)
From: Elliot Ayrey <elliota@alliedtelesis.co.nz>
To: Nikolay Aleksandrov <razor@blackwall.org>
cc: davem@davemloft.net, Roopa Prabhu <roopa@nvidia.com>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Tobias Waldekranz <tobias@waldekranz.com>, 
    bridge@lists.linux.dev, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: bridge: mst: Check vlan state for egress
 decision
In-Reply-To: <9aff7e76-0799-4439-afff-a5ca4880bc72@blackwall.org>
Message-ID: <f9b6b092-c859-4978-32e-d5306f95cd8@alliedtelesis.co.nz>
References: <20240711045926.756958-1-elliot.ayrey@alliedtelesis.co.nz> <9aff7e76-0799-4439-afff-a5ca4880bc72@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SEG-SpamProfiler-Analysis: v=2.4 cv=PIKs+uqC c=1 sm=1 tr=0 ts=6690766a a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=kj9zAlcOel0A:10 a=4kmOji7k6h8A:10 a=62ntRvTiAAAA:8 a=VwQbUJbxAAAA:8 a=mHDNdhOA_S9NhVmJMKYA:9 a=3ZKOabzyN94A:10 a=CjuIK1q_8ugA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat



On Thu, 11 Jul 2024, Nikolay Aleksandrov wrote:

> On 11/07/2024 07:59, Elliot Ayrey wrote:
> > If a port is blocking in the common instance but forwarding in an MST
> > instance, traffic egressing the bridge will be dropped because the
> > state of the common instance is overriding that of the MST instance.
> > 
> > Fix this by skipping the port state check in MST mode to allow
> > checking the vlan state via br_allowed_egress(). This is similar to
> > what happens in br_handle_frame_finish() when checking ingress
> > traffic, which was introduced in the change below.
> > 
> > Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
> > Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
> > ---
> > 
> > v2:
> >   - Restructure the MST mode check to make it read better
> > v1: https://scanmail.trustwave.com/?c=20988&d=i-GP5uRIMfh6vd5ovR02aBzmN2wu2NxHqGSNFOAFMA&u=https%3a%2f%2flore%2ekernel%2eorg%2fall%2f20240705030041%2e1248472-1-elliot%2eayrey%40alliedtelesis%2eco%2enz%2f
> > 
> >  net/bridge/br_forward.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> > index d97064d460dc..e63d6f6308f8 100644
> > --- a/net/bridge/br_forward.c
> > +++ b/net/bridge/br_forward.c
> > @@ -25,8 +25,8 @@ static inline int should_deliver(const struct net_bridge_port *p,
> >  
> >  	vg = nbp_vlan_group_rcu(p);
> >  	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
> > -		p->state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
> > -		nbp_switchdev_allowed_egress(p, skb) &&
> > +		(br_mst_is_enabled(p->br) || state == BR_STATE_FORWARDING) &&
> 
> Does this compile at all? How exactly did you test this change?
> There is no "state" variable in that context.
> 

My apologies I must have sent an older patch. I will re-test and submit a 
v3.

