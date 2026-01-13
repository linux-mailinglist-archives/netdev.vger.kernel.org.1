Return-Path: <netdev+bounces-249473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C33FD19966
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB92030051A0
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EC72BE03D;
	Tue, 13 Jan 2026 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="THo42ORN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nGrRtNtZ"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583C2882AA
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315650; cv=none; b=suPoiKkr7XsXWN5+yttkX/NhQR8agfCofwAv7uJg0dUyeiVEic/48BDGOcnh34a29wtTCQFPjgZ0g9NOcAjW1dBKSZSBlwbXuVs1fYqO7EpkX2hjuSLZUgkovoowUbmrB96LGxS0NzAt9sPNBy9B5Y0IwoD08b5d94lphYVHRD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315650; c=relaxed/simple;
	bh=DPsaozP02D+oj6LjGsl+/R1e3/hwLEaGNCudGzshqi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qd9Li0aRkZAgYtfF8IPdpVl/DZEejd+NgF/En2aAHGUfoKcCHf4gBcjVMgEgECTLXHAwB+cwzZYkky5NtFOQFVlgVpbzKEzDcmQ3sd7QB6x+9zLGYLsHCPro+LG3dcZD5t5tfJZ6gYU8lrGuLqQ1jbI6qY3LTAS9kv5NGKrXd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=THo42ORN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nGrRtNtZ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5D6C11D0005A;
	Tue, 13 Jan 2026 09:47:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 13 Jan 2026 09:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1768315646; x=1768402046; bh=Jyi8VyiRY0ISKBxz3cWM8sKd8NbV2SGl
	k0NqAfCFAf8=; b=THo42ORNeg3QTwmuBwEqqv4/OhptCSJCSlyDAeWzoLBWt8pf
	t+CgkOo79ba7H3lDcvLOlu18XpCbb6Cz+TgxuQZbZ2YITJy1hlEangL++ZV1Hkqs
	AFm8XkzHUri0tKwJAezOBJpXU8KyZIBfF4y76ISM5vYxcfqiSgtFLHRpCaBdMEHC
	y8OP9xBlEeb7hwwfZE0TOeM6okJ74d/3rQiLJo8cQDBRrz56xLXu/d3KYg3AK21x
	/US54OXmOGSJteXc4/JS+3iMaLVgtRWk9LM33+qmqOSQHT1Yy2IDOYTrt01KxutO
	VP0tLSXyqmZW4N6djWo8yG8XXd88q7GPMFko4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768315646; x=
	1768402046; bh=Jyi8VyiRY0ISKBxz3cWM8sKd8NbV2SGlk0NqAfCFAf8=; b=n
	GrRtNtZC3ru9UpiYYgtJtxTgAViPQc4Lk6Ue3jA8qUmS3rY5aiKgWG90hnycwJuq
	X580G/WAX0jo7ksIkkkFpnogOHljpnh1j15P1I0Ngzw6y0FRA2AC/vDdB6jdBZdy
	zivMOTSFu6O+5RC9HJv7Fi2xFxK0PkDZpeCPSQIkKcECWXkiiqAHRuEaGq55UEc6
	P6evjYEc6P0rWOxzIZWyNUnFUsU0CBYA1+J/eHkg7v/vYcj+MXN0rYwPNKTSXUIV
	z0nQNfkDsJGCqLHnxeA8g7PAZe2376u+UuwYZSuNRCfQJwk/5p8gOuZcCzJ2tFeG
	c10x/24h2H+0wrxm4NibQ==
X-ME-Sender: <xms:_VpmaWTJw_yHl4d_D7bdgzSCTUUxzaQeMDTS2v-xa7QfzeGpc9ai-w>
    <xme:_Vpmaa2S5XT3ehj95OMInqX__B5mmayKbs0Ok21tygvEMgaEddTm6b2XYrxZiIjMI
    -TGSgH6nHOnRFq7y56jVeR8mqo8jE0tHjrmRjZ2JizJNUrTeYvMSHA>
X-ME-Received: <xmr:_VpmaaCfj9jd6iQDmkXIVIa5R7Z1t7L8DgpJZtFL10W1rbVbw4c-KY7QOWvZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddtiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefurggsrhhi
    nhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtf
    frrghtthgvrhhnpefgvdegieetffefvdfguddtleegiefhgeeuheetveevgeevjeduleef
    ffeiheelvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheptghrrghtihhusehnvhhiughirgdrtghomh
    dprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    rghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopeguthgrthhulh
    gvrgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhf
    thdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_VpmaejU-ZrzZchRrgDvLLgtgIMFc2D8gbTnUejbucrf-xzBr_GSpg>
    <xmx:_VpmaUOlxg_Jkh2QpJIQ-oyvd9aq0zHFThxV7xrQTolwMpJskZa6HQ>
    <xmx:_VpmaW-NioT1RiyfYQdi9zXGhbp6R3JG4ofRnEezKVXN80a_X0CTAA>
    <xmx:_VpmaddCJxH0S7bMdZ_CPBz2BZQdCkrLPahNkQgLOxOmS5gupyn7bg>
    <xmx:_lpmaRffWDanUAlrxQqGGGa4FY0CidsvKLmmDU7vTPxQXyVD7w5J-4Ms>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 09:47:25 -0500 (EST)
Date: Tue, 13 Jan 2026 15:47:23 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "edumazet@google.com" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] macsec: Support VLAN-filtering lower devices
Message-ID: <aWZa-6WUc3h2AboY@krikkit>
References: <20260107104723.2750725-1-cratiu@nvidia.com>
 <aWDX64mYvwI3EVo4@krikkit>
 <5bbb83c9964515526b3d14a43bea492f20f3a0fa.camel@nvidia.com>
 <aWDvTx9JUHzUKEGm@krikkit>
 <611d927472c46839ebe643bc05daa2321bd183b9.camel@nvidia.com>
 <aWLWgrL8UYJISOsu@krikkit>
 <34305da7654365c3c8ade9cde07cb992f7270634.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34305da7654365c3c8ade9cde07cb992f7270634.camel@nvidia.com>

2026-01-12, 10:32:17 +0000, Cosmin Ratiu wrote:
> On Sat, 2026-01-10 at 23:45 +0100, Sabrina Dubroca wrote:
> > 2026-01-09, 13:50:24 +0000, Cosmin Ratiu wrote:
> > 
> > > Would you like to see any tweaks to the proposed patch?
> > 
> > Well, updating the lower device's VLAN filters when not using offload
> > is undesireable, so macsec_vlan_rx_{add,kill}_vid should check that
> > offload is used, but then we'd have to remove/re-add then when
> > offload
> > is toggled after some vlan devices have been created on top of the
> > macsec device.  Keeping track of all the ids we've pushed down via
> > macsec_vlan_rx_add_vid seems a bit unreasonable, but maybe we can
> > call vlan_{get,drop}_rx_*_filter_info when we toggle macsec offload?
> > (not sure if that will have the behavior we want)
> > 
> 
> Perhaps "undesirable" is too strong of a word. I would use "unneeded".
> Having the encrypted VLANs in the lower dev HW filter can't do too much
> harm, except maybe allowing some non-macsec packets with those vlans
> when previously they wouldn't be allowed.

Well, if an admin has the filters working and suddenly starts seeing
packets that should have been filtered out, they may get confused.

> But remember what happened before the mentioned "Fixes" patch: the
> lower device was put in promisc mode because it didn't advertise
> IFF_UNICAST_FLT so it would have received all packets anyway.
> So this fix is strictly better, simple enough that it can be understood
> to be harmless.

Ok.

> The vlan_{get,drop}_rx_*_filter_info functions simply call device
> notifiers when the VLAN filter flags change, they're not useful for
> obtaining the list of VLANs. The upper devs keep track of those.

But that notifier gets caught in vlan_device_event, which calls
vlan_filter_push_vids. That iterates all existing vlans and pushes
them into the real device. That's why I thought it might work here,
but I haven't tried.

> If I engineer the fix we're discussing here (which would make macsec
> keep track of VLANs), it would be significantly more complicated, and
> it belonging into net instead of net-next could be called into
> question.

Sure, if we have to implement all that in macsec, I would agree to
take the current patch, and do the tracking later in net-next. In that
case, please just add a note to the commit message about the offload
vs non-offload behavior we're discussing here.

Either way, it would also be good to add some selftests.

-- 
Sabrina

