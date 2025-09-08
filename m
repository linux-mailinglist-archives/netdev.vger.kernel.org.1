Return-Path: <netdev+bounces-220836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 263CAB4905E
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC74A4E1BE2
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E532264B6;
	Mon,  8 Sep 2025 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="kfDkdVV1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aftFqDWR"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4FB30BF54
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339404; cv=none; b=kNlT8ze93P8FNwweeZ8bZGfn46Mz1Fl3TWUNc3Ox7IdCxpVSi70p+KbKGZQtYFXpE+HkGo9jdMmRnZFQqYq2+x0CUzpltPE1toFf0LQX4LAhf1lzoICaru1VBJM5UCFFLxfYjz5g/bSLxuzRZzwiaCaoY4SHGt0mS/nhMT0Kvp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339404; c=relaxed/simple;
	bh=eFMMnYbsUf1u6gT3FLeddmTMcT9VPE/X/Gm1NXdc2UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hENtwIqNkVnvTVsuMGqWkUIHdFV7yD07eB0E2vswzhKq+BYSe57Nu6myQlu1HqNSx2FotA2CMJQ4IcpG93IBSlR9hxBlcFr3vXdmfKM3kddNBVE9d+482w7NnIhrrZ3ejEyY9vfcNz620EilLGIq4oP4gDh7bK+3mWi1qcb6RcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=kfDkdVV1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aftFqDWR; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 4CE391D00126;
	Mon,  8 Sep 2025 09:50:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 08 Sep 2025 09:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757339401; x=
	1757425801; bh=XBrFmgmTV+G3VLXPuJCG1oIq1YcmEo++yiylC2+cllY=; b=k
	fDkdVV1wOQAcN9xbOTnNpgU8NQOiVeM16fw+04mFN8wz4g4MYS6SXPkQ3P3e21DF
	ny5Z5us8N3N9j1MZ3QxYqwh4DKnFnyzzLLeCei7mLCVrZ6XTsWwxqnUEueZMsFYx
	QbjOKyjDbWReSsm2QwO1YOLtPCxRt7JB5raYRNBaM5LqQY5hmkuoSSvpVyRZqR6L
	r6glvUBNwvXRnbGCBnpoJByRTgUoECoGLk7xXotWRNNrUzD6bG1pBimRQNJIWNlR
	+O9ErvqIYkDNs/Y2Sc2Z6yDo8XUx8H+LdIlxck9RpuHZ4xQvAbpINrJpdhBFaG4J
	Ht0oexnk9C6TVjNH9osjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757339401; x=1757425801; bh=XBrFmgmTV+G3VLXPuJCG1oIq1YcmEo++yiy
	lC2+cllY=; b=aftFqDWRoaMhjLwp0MAHcMv4qsiKq5j0VQNyAzTBlHZ3NdmSPD2
	FEb4TOxW5+thoa0mLGVg3t0FuWPE5x5QIg4YtElfuMMJXlE5stuuZXp7YosSyK0P
	HvnHRgYgL7v56LiKVQXarlf1IJ7AAURrjCyHTkupaqNDfb/EmTGPLyiKoluMgYer
	S3IbREetzCq5aYcYw90zJKsAqpDl1CIqUDVAdTx6VnS+VS+FQ0ie/gHzSIyRPSjA
	THP0omdRVTDBDzSMYB76gPV4mQX7wNRtmgDtdBkTOVG8wS1ryiRE8WUfLYVIJyoh
	jJKpCPuTU/peHqeBXanrdgUGZgSdNN2vn7A==
X-ME-Sender: <xms:CN--aDDEsNiJseIL_Lz_uFqtj5RXB3u2OKoblXX8weJBrv2TfhPz_Q>
    <xme:CN--aFPhbAME2piS-jffbIvl4xrUGjXcussk5X7J3eJjyfrrOa_L0d--ZI4EciahI
    LEPnEH3oBIXpwpzaKM>
X-ME-Received: <xmr:CN--aLCDxSrmyE7-D1dmMozdIolXvJeRhyN5-LUVKmg3S6F_hoILTiSW875b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhh
    grthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghmihgvrd
    gsrghinhgsrhhiughgvgesghhmrghilhdrtghomhdprhgtphhtthhopehrrgifrghlrdgr
    sghhihhshhgvkhelvdesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CN--aO4JxwzZSvABBWqHlGNwcv7GNd1xlAZy4uBrEZYAa8i0ZBe4yw>
    <xmx:CN--aN6FFahpH-TT8zeNh9Z8er7pquXplGKTk8dplFRZR9vUZRvGiw>
    <xmx:CN--aITc12c7c-ywoYtmxQgBckcXsKQ4kipMJU2VySQYQTsUwX1YKg>
    <xmx:CN--aN-MKavutAEBOTwWPl-AeKXYfPMCt2IwKK4VXdwayzfF73Q4Zw>
    <xmx:Cd--aNlev2wfgi1LIiEHc-4WUcnRuMJvYgxnf79IRNXgWHLzoSn9D0ON>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 09:50:00 -0400 (EDT)
Date: Mon, 8 Sep 2025 15:49:58 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	Abhishek Rawal <rawal.abhishek92@gmail.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 2/9] ipv6: snmp: do not use SNMP_MIB_SENTINEL
 anymore
Message-ID: <aL7fBlyyhiOrg0SU@krikkit>
References: <20250905165813.1470708-1-edumazet@google.com>
 <20250905165813.1470708-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905165813.1470708-3-edumazet@google.com>

2025-09-05, 16:58:06 +0000, Eric Dumazet wrote:
> Use ARRAY_SIZE(), so that we know the limit at compile time.
> 
> Following patch needs this preliminary change.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/ip.h | 24 ++++++++++++++++++++++++
>  net/ipv6/proc.c  | 43 ++++++++++++++++++++++++-------------------
>  2 files changed, 48 insertions(+), 19 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

