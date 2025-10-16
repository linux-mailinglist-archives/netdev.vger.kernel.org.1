Return-Path: <netdev+bounces-229920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06F9BE2115
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF4A405973
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24238301715;
	Thu, 16 Oct 2025 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yRfFkKU5"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4702FFF9F;
	Thu, 16 Oct 2025 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601592; cv=none; b=LR466AtCFkAh1EmdE2fe6E3oAi8aPqwGhZAWZ0Abtl2v8LltQFmuSV/z7BI3V95m38TuBmleaOno6el96rOMjCunTvTpi9JpeSfuYEh3Jo7eL5Vyvm3xnmL89PnNRPoLGXvHXX7SfA+t27+JYyofo9wSbHTk3gwU+eGneFhNlQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601592; c=relaxed/simple;
	bh=+vKJQP1mIQMNYZf++4ZYhUdYx+YT07eIKK3wxNp2eZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocrswmy3Mu5aM+w0c7P6FTonu2IMR6DuzlktXxg4muYOn6D17UbIFSPLx6qi+sDKsQY1oV6qMnmdF7ZsI2EjvljYhzV9rLSd5BrfHpWO0EA2Ptf54j70tMV+V7S8KeTeLX6ThL0Vlf1sCJK4rOX2tlxApjxSKpGEt3aRPYg04LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yRfFkKU5; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id DCD021D0015C;
	Thu, 16 Oct 2025 03:59:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 03:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760601587; x=
	1760687987; bh=wVqgocYI0n8kgCp0cVXx1uCWfFzvoA7KTcrmb8YK+08=; b=y
	RfFkKU5JijraOUbNjh6inSU1k8sULCj/OmFqlTRWEsD4YwZ3zfaBJzDmTONprw6o
	RLHA0mtymgHdULBY/DYJoMfIe9p+iLYMgmXZ1PxZDt0dkJLYcwZGC+gDRNrDfwN/
	RB3vQg2Py9kYwr4NKX/AZLnPTa2Olw7p522GbXBB6YgH/Jtdv1/cMejjXMh+TVMT
	rTtsH6Q3oYmUcB+AOWuA00gLaguw96TCu6LaOrgWVEyZ/sdmglDyUz6u+7d6uUQY
	3iR12WnjZhJ/FQmv9G7I6UtjIQxl5jy5AAr+s3oz8w/ICeJLcJ3n6TCYL9s4DY16
	2pDMbn5CYP5Er9v8XTGIQ==
X-ME-Sender: <xms:8qXwaJJTany_uT-PPHttB2bzj8N06UwExF4vztgfrdyCvPdqP_I_ew>
    <xme:8qXwaBGAN3D4jGhMKRgUKILb8hti7z_DFASEP0kxcny0SrrQrq9PKvPe6bIbwhSzS
    Gb7oC50CG-L4vRLmFjRhC4sn1H_I4F_sgaC71qilVOE8i4Jwked>
X-ME-Received: <xmr:8qXwaH1pPjV93IhbQ4ykNlMQogY5EGB8OQxbY2FIbpL-hs7CJAV21fQB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdehjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeegheekuddvueejvddtvdfgtddvgfevudektddtteevuddvkeetveeftdevueej
    veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopedujedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdifihgvshgsohgvtghksegrih
    hsvggtrdhfrhgruhhnhhhofhgvrhdruggvpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhhunhhihihusehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpthhtohepshhhrgifrdhlvghonhesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:8qXwaAwRO4YW0r5nsoQD3wdrEmq6JCOt_XvzGQLNZ69s7LgdwwE2JQ>
    <xmx:8qXwaOi8RmTOEArw2qwbL7INBsjnSaiDLSJVO0uTZe0mWzjNZT69-Q>
    <xmx:8qXwaHx63zLDd6loTzk3AfcjGLpdwQIqbznXyllp8enyGkr2I_qePg>
    <xmx:8qXwaEyuIS7cCsySSbdPaosOFHkgLg-zA39tp_UhfwyzyQhGhOLnfg>
    <xmx:86XwaMJ0BtddSqnTgfvTDAFdYWsFZvptt0bXxhJoouzZ4sRUsscCFUpq>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 03:59:46 -0400 (EDT)
Date: Thu, 16 Oct 2025 10:59:44 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Johannes =?iso-8859-1?Q?Wiesb=F6ck?= <johannes.wiesboeck@aisec.fraunhofer.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Vlad Yasevich <vyasevic@redhat.com>,
	Jitendra Kalsaria <jitendra.kalsaria@qlogic.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	gyroidos@aisec.fraunhofer.de, sw@simonwunderlich.de,
	Michael =?iso-8859-1?Q?Wei=DF?= <michael.weiss@aisec.fraunhofer.de>,
	Harshal Gohel <hg@simonwunderlich.de>
Subject: Re: [PATCH net v2] rtnetlink: Allow deleting FDB entries in user
 namespace
Message-ID: <aPCl8EO8xkRVzaQi@shredder>
References: <20251015201548.319871-1-johannes.wiesboeck@aisec.fraunhofer.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251015201548.319871-1-johannes.wiesboeck@aisec.fraunhofer.de>

On Wed, Oct 15, 2025 at 10:15:43PM +0200, Johannes Wiesböck wrote:
> Creating FDB entries is possible from a non-initial user namespace when
> having CAP_NET_ADMIN, yet, when deleting FDB entries, processes receive
> an EPERM because the capability is always checked against the initial
> user namespace. This restricts the FDB management from unprivileged
> containers.
> 
> Drop the netlink_capable check in rtnl_fdb_del as it was originally
> dropped in c5c351088ae7 and reintroduced in 1690be63a27b without
> intention.
> 
> This patch was tested using a container on GyroidOS, where it was
> possible to delete FDB entries from an unprivileged user namespace and
> private network namespace.
> 
> Fixes: 1690be63a27b ("bridge: Add vlan support to static neighbors")
> Reviewed-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> Tested-by: Harshal Gohel <hg@simonwunderlich.de>
> Signed-off-by: Johannes Wiesböck <johannes.wiesboeck@aisec.fraunhofer.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

