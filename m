Return-Path: <netdev+bounces-167764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CA1A3C258
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965973B486A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F851E0E08;
	Wed, 19 Feb 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iroxxNW4"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5441AA1DC
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975976; cv=none; b=QHit99q3C2Ghz/8rzmHzE5wbM9DHbUK5QCHT01Jrx8BoKnjlmQWCib+ARrLdJ5o8LDJ1mEDtyGuB2GmU1Jdqz/sdJ3TZcflJkv1tCo4NGexztJ55cO2e/z3MmkznkjwSPrt79uyL2vuQXTXT+X1KqU2hlqUnjnWxcbUgjQ9ExXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975976; c=relaxed/simple;
	bh=9I/BZiLhzWple5N0YCrrpg/AF3Coux0TdHISZeVziws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrcItelpO6g0O/IW6US9aOFdKMoUmTZK2e13s9D7F6EvI6bt68/E/adj8gMW5Kn1XVIecwZly1Zfek+kl3uUVP6vK7cuWoNTkMUMKQFVt5MCytRtl1YCOj2N3AJi3HSpQ3+SBytxruGmtu7UvW96/2wR2tskwsAYoOrKA+F7AmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iroxxNW4; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 22DE725401DE;
	Wed, 19 Feb 2025 09:39:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Feb 2025 09:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739975971; x=1740062371; bh=DaYnopw+uS+8ccDYyRtJU1PTHrVQNpDmouK
	GS6ZrBPE=; b=iroxxNW4NRmrdbncBAuY3+gSQo25Xj5JflifgYT+ZL3OoCDN+yQ
	uKrHsEdI+azRIZCSNbvmoLRv/mK0pa8vVW3SJNFQ32WYeOpdNZayWAVJnVGbSIbB
	b13Aygd5W8qlklrZ6d/y4+BH9rYnGmtHGtAi8i1XZSFL4po8tux6rmDckZH+9m3h
	xuTnMZqLeTbJty0H+UtRdAwegDozzISW00ANefowgT4vbZ8h4UpRfFHTC1HNPysg
	4JgNAZ1SnIno0vbL469GS5rvOwnxF/RlYAEShB5A8xgDKOEP1D0zVt42riZMEm/r
	jYraylpwkaYRkq0z3oQuCitgLwPXA6WMokQ==
X-ME-Sender: <xms:I-21Z8J5v0d0WDMPlXCtDhB8jsbPuLngHhFwt0zZ_DsvlP7IiWOkkQ>
    <xme:I-21Z8I_uVZi4TvYlaeny9BdN2Rj9JA3hSp7GZjktkja5UdGOfsKOgGMt1BU2fRoy
    3VwgaseRAWoVG8>
X-ME-Received: <xmr:I-21Z8vJYFZ_bHvmyqcaSKKYaxJf6DKLpeucuPsqHDs7wGugT0uzXa1xVOp1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefg
    udffvdfftdefheeijedthfejkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghh
    sehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepgihihihouhdrfigrnhhgtghonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epughtiihqtddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhomhgrtghhihdrhiho
    shhhihhkihesghhmrghilhdrtghomhdprhgtphhtthhopehjhhhssehmohhjrghtrghtuh
    drtghomhdprhgtphhtthhopehjihhrihesrhgvshhnuhhllhhirdhush
X-ME-Proxy: <xmx:I-21Z5a5iRIAS-azxvn8rDpYwoTs6cRJVylP0rGg6vO_Y-MZjSLHLg>
    <xmx:I-21ZzaN7AdHvRcCYYaAHEFVoeV-8csYh95vzQjDVO0T1LCe-TGa_A>
    <xmx:I-21Z1BARWmdb87cn6yAkHopPL8rsu0IVvy6FFJbvcn8FtjgGxUpsw>
    <xmx:I-21Z5bToSaHIp8AaI1azlL2-9I-XLF9yB6udHn9XCS4s97bz1I7aQ>
    <xmx:I-21Z-zWjdUQf_j5t2QzYrQOcWz0MosGeBkViRLphrlSgdYZahTtMIIp>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 09:39:30 -0500 (EST)
Date: Wed, 19 Feb 2025 16:39:28 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, Qiang Zhang <dtzq01@gmail.com>,
	Yoshiki Komachi <komachi.yoshiki@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [Patch net 1/4] flow_dissector: Fix handling of mixed port and
 port-range keys
Message-ID: <Z7XtIP8D7clSMnjg@shredder>
References: <20250218043210.732959-1-xiyou.wangcong@gmail.com>
 <20250218043210.732959-2-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218043210.732959-2-xiyou.wangcong@gmail.com>

On Mon, Feb 17, 2025 at 08:32:07PM -0800, Cong Wang wrote:
> This patch fixes a bug in TC flower filter where rules combining a
> specific destination port with a source port range weren't working
> correctly.
> 
> The specific case was when users tried to configure rules like:
> 
> tc filter add dev ens38 ingress protocol ip flower ip_proto udp \
> dst_port 5000 src_port 2000-3000 action drop
> 
> The root cause was in the flow dissector code. While both
> FLOW_DISSECTOR_KEY_PORTS and FLOW_DISSECTOR_KEY_PORTS_RANGE flags
> were being set correctly in the classifier, the __skb_flow_dissect_ports()
> function was only populating one of them: whichever came first in
> the enum check. This meant that when the code needed both a specific
> port and a port range, one of them would be left as 0, causing the
> filter to not match packets as expected.
> 
> Fix it by removing the either/or logic and instead checking and
> populating both key types independently when they're in use.
> 
> Fixes: 8ffb055beae5 ("cls_flower: Fix the behavior using port ranges with hw-offload")
> Reported-by: Qiang Zhang <dtzq01@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAPx+-5uvFxkhkz4=j_Xuwkezjn9U6kzKTD5jz4tZ9msSJ0fOJA@mail.gmail.com/
> Cc: Yoshiki Komachi <komachi.yoshiki@gmail.com>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

