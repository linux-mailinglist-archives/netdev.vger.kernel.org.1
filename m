Return-Path: <netdev+bounces-168825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39026A40F45
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 15:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D851189363E
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 14:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728B2205AB6;
	Sun, 23 Feb 2025 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4EeOOFLX"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB4163
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320987; cv=none; b=KV99JZBckFbkrsqTBQZz/vjVT5YAqqT45A0RlyeG0tChxT3RCB9V5DUk9A8HEPZIEhMmE9Yn//qjx3TlT5dlvkJgqZclodF0vgRxfZKbfDob2SsG/AB5h2DAfmD1s0KcC1z6mvqwd7Dn7M6Y8OwhBN+ww5Y8uiRmulTZg12MFSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320987; c=relaxed/simple;
	bh=N9eYfn2zn9bHh7uK3ZU9xbTbkTkqKFJE5iIHBeiZWyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwf6HIlHn6hFZ/8s4ZqCCYHX5GsboISwERBHy9TEofOZvZsodKNNpfcRf/2mk32Lx3BeCtMPk8kq89bjElxgj/sBFDf/N5jCMAjNvZdbqZ3T3WKHbMp7HGohfkLN/eAH1IsHOx/Bbergga3rejHbFq7pmiJVT18IMg77OXjp1Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4EeOOFLX; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C7221140141;
	Sun, 23 Feb 2025 09:29:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 23 Feb 2025 09:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740320984; x=1740407384; bh=WC5+Wt6Y2zwG4QUlmEplEm8BOPI04Pmx396
	1hisxzGs=; b=4EeOOFLXdonpqxb2wQ+5ahsvSc8Uol1/fddofg+XpoXMLun41YP
	N6tozDv+4qxyYUPpYe0THg3X1wWA5YqPR4PAA9zMXpOEiZxIaKEdNeFX4piNipJl
	kibuPVR4poS9f+G/M91guurJWbvsnwmVW1jwK7v/kV7KGkVW2Ja9wFHjVmhUlj7P
	FdeTL/5T8+tqT9rmjqKOrTtySPRAhsr+YCHCUtNYIF/mhK64pYd5SkyRa1OvY3Xf
	/q+zmdZJw2Du1KAAE/vGv3OIOvToGD0IpXxKaIX3xgcPSKQI4BE/FklYJFuuUgWb
	Wbyh7uHjmAwP7uOzS+KwG81a/tkte4Om5gg==
X-ME-Sender: <xms:1zC7ZyAgJp0zpWF_3VG3V1NKGmawiuSl_qJo5aVHZGYWdtQiyPHaNQ>
    <xme:1zC7Z8iJjs_bfyeC608DttK2R3lDDljcU-be-oX0vQRDvwnqi_ePYRJmG7YnRdLee
    nuNfMYEnadOaJc>
X-ME-Received: <xmr:1zC7Z1myOttygyp6YXaUrG8gY9phdf842PtG5QZyAVGlJbZTrux75wFc8UVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejiedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpeejgeejhfffiefggfehveefffetkeevkeduueeh
    ieeiudelgedtleelteekvdefkeenucffohhmrghinheptghonhhfrdguvghvnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehi
    ughoshgthhdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepghhnrghulhhtsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghv
    vghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthht
    ohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrnhhtohhnihhosehmrghnuggvlhgsihhtrdgtohhm
X-ME-Proxy: <xmx:1zC7ZwxSKfHXyEXRG8801JddgvrwEZ3o5JRIbbduJMpD0eqTFbSzjA>
    <xmx:1zC7Z3R7ohUWelbAShIDIJ4tdUjcoGkwpyZtJD9txEABJKnMDUNeJQ>
    <xmx:1zC7Z7Zk7xjBJTD4r5e-gRD3uToKIiGzp7J4wen7pC5bY73-NdtGGA>
    <xmx:1zC7ZwT3ztBtvs0h893p5P_2XEzho_2BpbdU_sWHpr4nJDOjxDxgXw>
    <xmx:2DC7ZyHjToddmfBR3v1OTXGcAIza8wUWQUPj8WsN_JCjZ8SEjlllkTlQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 09:29:43 -0500 (EST)
Date: Sun, 23 Feb 2025 16:29:40 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: Re: [PATCH net v2 2/2] selftests: Add IPv6 link-local address
 generation tests for GRE devices.
Message-ID: <Z7sw1PPY48pkEMxB@shredder>
References: <cover.1740129498.git.gnault@redhat.com>
 <5c40747f9c67a54f8ceba9478924a75755c42b07.1740129498.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c40747f9c67a54f8ceba9478924a75755c42b07.1740129498.git.gnault@redhat.com>

On Fri, Feb 21, 2025 at 10:24:10AM +0100, Guillaume Nault wrote:
> GRE devices have their special code for IPv6 link-local address
> generation that has been the source of several regressions in the past.
> 
> Add selftest to check that all gre, ip6gre, gretap and ip6gretap get an
> IPv6 link-link local address in accordance with the
> net.ipv6.conf.<dev>.addr_gen_mode sysctl.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

There are some helpers from lib.sh that could have been used, but the
test is very clean and easy to follow, so:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

Thanks!

