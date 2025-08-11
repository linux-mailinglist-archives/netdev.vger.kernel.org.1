Return-Path: <netdev+bounces-212499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AF4B210BD
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1593AB8C8
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 15:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A762E8881;
	Mon, 11 Aug 2025 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oiu9iENr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13352E7F32;
	Mon, 11 Aug 2025 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926659; cv=none; b=Rd146bHHIKS8R69+K+VcHi3tVllwZO9zHedVRj+W5GfOHeMANexskVumktaWeY+v6M209NzmyfHY8RjMmKDH6x5Rt6gF33U6fVkEoLRhVMs8HEKaQ/H4OdL6Cg/JzmhjaJDd9rgSdqvPbC9Q6ctfLSU+fqeCtqM7N9120rRLhVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926659; c=relaxed/simple;
	bh=xreD27Fpmb+ZqmNwEP6ViAFZpkCnuQJup+gAGGJ9mTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1437hjQNECmsIEFcFv0NDxACpHVxAU283VwGAv5H24+4HgCRsUvXl0YQKKiJNJad7j2mpAQ+dDEwXBX/0TpwZQQ9AYipwJfqo5+tDi/XQAEgNE7/wpmydxmCCG7wP9wgk3d9Xy97fRR5Jv0nhboE/EpgSZDq2mS5hX0xkZ5IyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oiu9iENr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D95C4CEED;
	Mon, 11 Aug 2025 15:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754926659;
	bh=xreD27Fpmb+ZqmNwEP6ViAFZpkCnuQJup+gAGGJ9mTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oiu9iENrS+e1XQffKABcxvqiEhWohi/qUbxG6ZtAPX1RGPlLyvFq4vT/rvK2TiuWR
	 x1gKlljxCN5FxXuqrpdWM8tjIowrLYip4heXRaIHDOD2TMPhs+i/QxsaNd9oF3LarC
	 jDQAMHY3dehZcZ7F1WEYwb0LsMAJ1D/htkO93jYCz1WUoFE7K1UqhkngyGsXNGiST9
	 j7nyMLStcWg2CQBNDCYYw8ZGCyvdgYX3hrrndQkJvTu7O0cr1cgYIOx9CdtFBC9DmG
	 +J89Eu80mTAd5ZhbnDsUkQYB1mC4GUaOb473XuKIlJzTdgTuIvg1Mjl3qifU/Pe1mL
	 Ywy59rof8eU3w==
Date: Mon, 11 Aug 2025 08:37:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "Simek, Michal"
 <michal.simek@amd.com>, "sean.anderson@linux.dev"
 <sean.anderson@linux.dev>, "Pandey, Radhey Shyam"
 <radhey.shyam.pandey@amd.com>, "horms@kernel.org" <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Katakam, Harini" <harini.katakam@amd.com>
Subject: Re: [PATCH net] net: xilinx: axienet: Increment Rx skb ring head
 pointer after BD is successfully allocated in dmaengine flow
Message-ID: <20250811083738.04bf1e31@kernel.org>
In-Reply-To: <BL3PR12MB65712291B55DD8D535BAE667C92EA@BL3PR12MB6571.namprd12.prod.outlook.com>
References: <20250805191958.412220-1-suraj.gupta2@amd.com>
	<20250808120534.0414ffd0@kernel.org>
	<BL3PR12MB65712291B55DD8D535BAE667C92EA@BL3PR12MB6571.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Aug 2025 20:31:40 +0000 Gupta, Suraj wrote:
> > The fix itself seems incomplete. Even if we correctly skip the incremen=
t we
> > will never try to catch up with the allocations, the ring will have few=
er
> > outstanding Rx skbs until reset, right? Worst case we drop all the skbs=
 and the
> > ring will be empty, no Rx will happen until reset.
> > The shutdown path seems to be checking for skb =3D NULL so I guess it's=
 correct
> > but good to double check..
>=20
> I agree that Rx ring will have fewer outstanding skbs. But I think
> that difference won't exceed one anytime as descriptors submission
> will fail only once due to insufficient space in AXIDMA BD ring. Rest
> of the time we already will have an extra entry in AXIDMA BD ring.
> Also, invoking callback (where Rx skb ring hp is filled in
> axienet)and freeing AXIDMA BD are part of same tasklet in AXIDMA
> driver so next callback will only be called after freeing a BD. I
> tested running stress tests (Both UPD and TCP netperf). Please let me
> know your thoughts if I'm missing something.

That wasn't my reading, maybe I misinterpreted the code.

=46rom what I could tell the driver tries to give one new buffer for each
buffer completed. So it never tries to "catch up" on previously missed
allocations. IOW say we have a queue with 16 indexes, after 16 failures
(which may be spread out over time) the ring will be empty.

