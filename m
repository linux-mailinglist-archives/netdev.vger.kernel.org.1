Return-Path: <netdev+bounces-166018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B346EA33F22
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C757A25DF
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0567C22154D;
	Thu, 13 Feb 2025 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pe67htdL"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DBF22155E
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449674; cv=none; b=G3A2MvD8+7NTBFt2mWh1jn+HbFrel7pa/8dUQcLXGT1S/chOuwkctswSFv8AqPjg/4nZkwZAJPvfP3xw/M8gGj2Q0uwlIIRtcmcAFh5gr7o6N7mWJ3PSdnTYLYYdEMpJfZue2PCb8bdVZ24v7XQRgEPHjocODHUW40OHM8+sUmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449674; c=relaxed/simple;
	bh=ZzQf/gICF0NaInz07XO7R2BcQiL2ViPc7R3cpXi5eLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GinHdGFbt14vPEjWdmhXzjybBmgtBMLKYfjBiputevlb0GKGdRK8c7PE1Hd9PZGU+jOuCjB7WqX8FVQD5TqhW9/+lfXgp4kUmC6CNKnnvDb3L8AyvAZbe1hK8xaFQI6poxOShOYrUPsIuafneZyET3PNNhxFKD9fcJSrCnBphRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pe67htdL; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D2C625401CE;
	Thu, 13 Feb 2025 07:27:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Thu, 13 Feb 2025 07:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739449670; x=1739536070; bh=u1OBWQzn7G7a9JfKJgKyzjsmeOfUWBuEnGp
	m5jnkdjk=; b=pe67htdLY02uf2r0Xlr2BwOMry0dcP/YEdef6vnlccVKPkj61GW
	kmDD75EjKtkvWYKglyLCWiN04jiOT2UeUil+pkQZtHngj1T/PY3lA/pVEdobokvI
	fCaym8TeJDxj8zm973mgGUqv5RP6VFBwL3t9rAtJgpcCF5SRTWiYI44YYegmVNuB
	iM1fCun8IxmGmctiABikWwGE1G2fAnDUVVH/Dn5Im++jnkdXt4A3x067GSCl3+Iv
	pg8uKYDrmTPmDHWHbNjWR6fNCTjYAMDaLw+tedh8fjIzBqR+4/nABo9pkSadw1Um
	+E/2UZ9/L4clEyclxjc34rfac1T/oLkPGhw==
X-ME-Sender: <xms:RuWtZ17qhV6RQw8bzyD9ybh8wy_H3P1zmVlcgl8FDwq4bttzsL-I4Q>
    <xme:RuWtZy5aM2r92bvmM5B4YAr1cyc_hCrCd2CQTjA5S7Eazk-CIzw2vLs3p351tkSnc
    o-PN--MMq-T24M>
X-ME-Received: <xmr:RuWtZ8cRq1gs9QMVd_0bD98djddzcc0Y_qCgPbJyDjyulkJvJpUEUkl7enph_No70SBRYMedfT2nxoYv9Ld0ezkpslw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhushhtihhnrdhiuh
    hrmhgrnhesuhhlihgvghgvrdgsvgdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvg
    htpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgt
    phhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrrg
    hrihhnghesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:RuWtZ-LHJq0xtlmrBm7d9NtxR0jF7zIw0A151dkF8A77QvXfSbo88A>
    <xmx:RuWtZ5Lrsw0FLR1TVAu5oaRoPFKuFbOlczPmsWARBIBdGhL4hE01ng>
    <xmx:RuWtZ3wVv8IpFfWEDog0QQCwSYV2vrpRqUxTy_a6r_wrpJo_eLnubw>
    <xmx:RuWtZ1Ifl2G54VpBsGbO1CYFqhHKpGYtcrcVnTJ06uTHiOJpe7BmQQ>
    <xmx:RuWtZyWl5bO2pDwuqu-KeRZC6Pe8ypjTme3yMVz7J-yc-Zaza9IRodap>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 07:27:49 -0500 (EST)
Date: Thu, 13 Feb 2025 14:27:46 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, Alexander Aring <alex.aring@gmail.com>,
	David Lebrun <dlebrun@google.com>
Subject: Re: [PATCH net v2 1/3] net: ipv6: fix dst ref loops on input in rpl
 and seg6 lwtunnels
Message-ID: <Z63lQiyiNoQkgJFk@shredder>
References: <20250211221624.18435-1-justin.iurman@uliege.be>
 <20250211221624.18435-2-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211221624.18435-2-justin.iurman@uliege.be>

On Tue, Feb 11, 2025 at 11:16:22PM +0100, Justin Iurman wrote:
> As a follow up to commit 92191dd10730 ("net: ipv6: fix dst ref loops in
> rpl, seg6 and ioam6 lwtunnels"), we also need a conditional dst cache on
> input for seg6_iptunnel and rpl_iptunnel to prevent dst ref loops (i.e.,
> if the packet destination did not change, we may end up recording a
> reference to the lwtunnel in its own cache, and the lwtunnel state will
> never be freed).
> 
> Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
> Fixes: af4a2209b134 ("ipv6: sr: use dst_cache in seg6_input")
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> Cc: Alexander Aring <alex.aring@gmail.com>
> Cc: David Lebrun <dlebrun@google.com>

Not an expert but was asked to take a look. Seems consistent with the
output path and comparing the state address seems safe as it is only
compared and never dereferenced after dropping the dst in the input
path.

I would have probably split it into two patches to make it a bit easier
to backport. 5.4.y needs the seg6 fix, but not the rpl one.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

