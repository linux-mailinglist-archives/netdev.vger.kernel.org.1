Return-Path: <netdev+bounces-122108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8C795FEE4
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 04:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12E9282F4B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 02:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD56DD517;
	Tue, 27 Aug 2024 02:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEtbVrrZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8259C8C7
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 02:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724724854; cv=none; b=HATHQ1Rpj0njwmMVnlCd0RrafAmW+7pCnnc45wOL3xZpne4R+K0MKZ5DCQv4MzkgBfmdEwGlKemR5l6/FGHWC1/owQzCmUx0oMU5a09v8b9rInbwY7moQXsMuwSRIjj/O2BVz5dXBYd2Tu4vJ+vdXBIx7GL+iSkQrupVGJ/oM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724724854; c=relaxed/simple;
	bh=2YEBbKmszqUcMCm3UY5v3BGVGSbeYecsOYJXAz12Cbc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AC7DKqvJxPb1pclH+/7zuzwC+Yn4bFlmyYVbFKObtY94KPbsbTkYXcRwAEYGEe66lgd00pfeShZAgCc+fKXzpLKGAMuJtim5isAxlhN8+TgILq8RNBjMrv/xedqpoGErfA4VgkZ0ibkoCW37qsadgaPOV4CSsDSz95LZsIUnaos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEtbVrrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D673EC4DE06;
	Tue, 27 Aug 2024 02:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724724854;
	bh=2YEBbKmszqUcMCm3UY5v3BGVGSbeYecsOYJXAz12Cbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MEtbVrrZPllXh/CRnyXIbdbn4GzD1e6AmYxUpDrgkumXSRAlvHCzkyfNG5mdyNyqS
	 72l1PlEbqZYO+3KVmUm5Ql0fEUNubly/zSthPA1T60QrwgBjdMbgoT1/WEXMX0Vvnv
	 Dg3g4vMm/rW8oevK78CCoQRT325Bq/KQnBtGdQk2FKwAGkleyC+bsePLDSjBamwAVm
	 wynmTvVG14MoAG26ieFhgIu6svvoM69jI+gCNzqcuTJy3NPR64zTF0bBvFBgVpx29K
	 e/TVa0bXTFAaACaZR2OErqe7Qsgi/X8toOikAgny/TMF8sdYDXMKTrbwBdRZHoBmbb
	 Pva+DBm+p2+Dw==
Date: Mon, 26 Aug 2024 19:14:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH v4 net-next 00/12] net: introduce TX H/W shaping API
Message-ID: <20240826191413.1829b8b6@kernel.org>
In-Reply-To: <d9cfa04f-24dd-4064-80bf-cada8bdcf9cb@redhat.com>
References: <cover.1724165948.git.pabeni@redhat.com>
	<20240822174319.70dac4ff@kernel.org>
	<d9cfa04f-24dd-4064-80bf-cada8bdcf9cb@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 09:51:24 +0200 Paolo Abeni wrote:
> On 8/23/24 02:43, Jakub Kicinski wrote:
> > On Tue, 20 Aug 2024 17:12:21 +0200 Paolo Abeni wrote:  
> >> * Delegation
> >>
> >> A containers wants to limit the aggregate B/W bandwidth of 2 of the 3
> >> queues it owns - the starting configuration is the one from the
> >> previous point:
> >>
> >> SPEC=Documentation/netlink/specs/net_shaper.yaml
> >> ./tools/net/ynl/cli.py --spec $SPEC \
> >> 	--do group --json '{"ifindex":'$IFINDEX',
> >> 			"leaves": [
> >> 			  {"handle": {"scope": "queue", "id":'$QID1' },
> >> 			   "weight": '$W1'},
> >> 			  {"handle": {"scope": "queue", "id":'$QID2' },
> >> 			   "weight": '$W2'}],
> >> 			"root": { "handle": {"scope": "node"},
> >> 				  "parent": {"scope": "node", "id": 0},  
> > 
> > In the delegation use case I was hoping "parent" would be automatic.  
> 
> Currently the parent is automatic/implicit when creating a node directly 
> nested to the the netdev shaper.
> 
> I now see we can use as default parent the current leaves' parent, when 
> that is the same for all the to-be-grouped leaves.
> 
> Actually, if we restrict the group operation to operate only on set of 
> leaves respecting the above, I *guess* we will not lose generality and 
> we could simplify a bit the spec. WDYT?

I remember having a use case in mind where specifying parent would be
very useful. I think it may have been related to atomic changes.
I'm not sure if what I describe below is exactly that case...

Imagine:

Qx -{hierarchy}---\
                   \{hierarchy}-- netdev
Q0-------P0\ SP----/   
Q1--\ RR-P1/
Q2--/

Let's say we own queues 0,1,2 and want to remove the SP layer.
It's convenient to do:

	$node = get($SP-node)
	group(leaves: [Q0, Q1, Q2], parent=$node.parent)

And have the kernel "garbage collect" the old RR node and the old SP
node (since they will now have no children). We want to avoid the
situations where user space has to do complex transitions thru
states which device may not support (make sure Q1, Q2 have right prios,
delete old RR, now we have SP w/ 3 inputs, delete the SP, create a new
group).

For the case above we could technically identify the correct parent by
skipping the nodes which will be garbage collected later. But imagine
that instead of deleting the hierarchy we wanted to move Q1 from P1 
to P0:

	group(leaves: [Q0, Q1], parent=SP, prio=P0)

does the job.

I admit this are somewhat contrived, and I agree that we won't lose
generality, but I think it will narrow the range of hierarchies we
can transition between atomically.

