Return-Path: <netdev+bounces-182254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3076A8854E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5442616AD86
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538FF28934C;
	Mon, 14 Apr 2025 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="L87HEPV4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mvr79Lkg"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E98274654
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639984; cv=none; b=R+R9n8yygkn8fyIlIE1ppTM6l6JV6cxpvTIJLndgEHbtW8A/oAhhvEMZbklE48m1mib6P4eCK4yyX+oRxRfleQfb3+brp4OF4x/CxSl6YLerInqpLg0dvXgDPoQSxJlsdCqZzQOFYd/Vx6LKgdTI7muiWxVjEemWfsy5Ah9cMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639984; c=relaxed/simple;
	bh=TryNN7oeMyii/YbAp3aR+ly4pYl8Bq4YPfv4UEc9lqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXmaCoeBEiFY8ZdnQ2vFKwU9XQ2WxWriJETOTgPih8muGX8EpY+J5ct0zAbE4WGfCzZMvAGsLBjBs286q89nXqOcijeJXyB8FmykzWA7JOjNLBds+I9f6tLvS45jQPhfmCO8ee0jANSZyrFvcPu6uw4YjEzZsDscQCbO/sjQPb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=L87HEPV4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mvr79Lkg; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id B0ED01380213;
	Mon, 14 Apr 2025 10:12:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 14 Apr 2025 10:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1744639979; x=
	1744726379; bh=gka1kQAx2UxjPk5MFKWIIYB7s0F5tImoSNQAzvKQOqw=; b=L
	87HEPV4mmvui2MppALHji2+v4IN2ER8jH7JXZ9bPHFtNyXql6ILfqFK9FWn1HsNq
	FI1VgYShwYCW5njkqlIipBUYwL3qBFEG1TYFKTOtAAqSmW0CIIy2iJuRr7kw8vVy
	iKRqP5UfS54BazAJVGxzqz6ENKq0IbN9Xo5fjdg/Q900vj2mUhaFSyu3ppTMJNm6
	qy5zonxB4p5lK+Pf7E7Qcuksvqo7Y2vWpw/fH+eNRqnvX8DXYYZgRv2Q1uyokJJZ
	8a9/Yi0uindgqD+KfxYal0xQXcr9MCKGiR0MHNXm8uXmj3zdBTYZsKTuIyC6oMza
	wQjPDuz2B2S4S+ZVFRbYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744639979; x=1744726379; bh=gka1kQAx2UxjPk5MFKWIIYB7s0F5tImoSNQ
	AzvKQOqw=; b=mvr79LkguC9iGccSguEV9aBrgNfoBK1p+YIo6/b15KSd6wdLabp
	Rm9ochwlaQ5+bgycGtMEYvgcaY5jgQJZWNEgkUk46vqQupF6Z+P0ZG+4YDJSf3Pq
	UeJnxsXMb/gt0zHB2k1lC2qcdfpiArSVuw5IumS2NlFgpIgiWFHmDxYGA9ODf3J7
	t6g3/bVRjOe10xXINWWDWUlDt6Yu97awmXCdXdy72THlNLehaFLig1UL8i/c+evN
	axFwS8Da2XQHOd7wZhqHrq2I3m+DsLfx/nrydBy3FB2M8/3Pk7EwWVFjnvY53jpe
	dnOshv4y5iBita4kbgzZBBIx7OQiU/cKCgg==
X-ME-Sender: <xms:6xf9Zxg5mlZ1uzrYJTMWFcpW_2NhFFp6M-RDqZIeGXBBioCe8Gi7jA>
    <xme:6xf9Z2D7CykuWbihRrkyP5QQoXGZBLnm8UTb0PLXAq7Ucmpd6wkEB1t0sbD22qYvC
    s3wT1S6PkhilQJfU90>
X-ME-Received: <xmr:6xf9ZxGg0jERT7Qz0ejnTb-ZFhRT68_tDgXyGcwbQH60Tn1qzvHyr6wfVZPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnheptddvjedugeeigfevveefkefgfedv
    udehhfeigedvheefveetteetjeffheeutefgnecuffhomhgrihhnpegtlhgvrghnuhhppg
    hnvghtrdhnvghtpdhunhhlohgrugdrnhgvthdpvgigihhtpghrthhnlhdrnhgvthenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvg
    grshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepkhhunhhihihusegrmhgriihonhdrtghomhdprhgtphhtthhope
    gurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivght
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhr
    mhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhhnihdukeegtdesghhmrghilh
    drtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6xf9Z2TZDAX45Nz-VloZN3VODWNbLWi_7cCu3krE6H8ZfJ_g933_Wg>
    <xmx:6xf9Z-wrPA6j06Y7zf5vxq233SmfsH_g08EvK5gTLjjPMKNgOkChZA>
    <xmx:6xf9Z85Xi8XHbQYMNna7UCHyS88Fq5e3QsuEG9JUVfPxOyikZO5MRA>
    <xmx:6xf9ZzwIvVVCSZZRI_hrKJt5vD4vxp1rBWfxQIetoXC9Nh6eeV7xow>
    <xmx:6xf9Z2EbGfHxkxxesBG2NW_9rk4T1teePITjcBsfHuqpRxy_5Q0WCOj4>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 10:12:58 -0400 (EDT)
Date: Mon, 14 Apr 2025 16:12:56 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 00/14] net: Convert ->exit_batch_rtnl() to
 ->exit_rtnl().
Message-ID: <Z_0X6JFujPlTtdEY@krikkit>
References: <20250411205258.63164-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250411205258.63164-1-kuniyu@amazon.com>

2025-04-11, 13:52:29 -0700, Kuniyuki Iwashima wrote:
> Kuniyuki Iwashima (14):
>   net: Factorise setup_net() and cleanup_net().
>   net: Add ops_undo_single for module load/unload.
>   net: Add ->exit_rtnl() hook to struct pernet_operations.
>   nexthop: Convert nexthop_net_exit_batch_rtnl() to ->exit_rtnl().
>   vxlan: Convert vxlan_exit_batch_rtnl() to ->exit_rtnl().
>   ipv4: ip_tunnel: Convert ip_tunnel_delete_nets() callers to
>     ->exit_rtnl().
>   ipv6: Convert tunnel devices' ->exit_batch_rtnl() to ->exit_rtnl().
>   xfrm: Convert xfrmi_exit_batch_rtnl() to ->exit_rtnl().
>   bridge: Convert br_net_exit_batch_rtnl() to ->exit_rtnl().
>   bonding: Convert bond_net_exit_batch_rtnl() to ->exit_rtnl().
>   gtp: Convert gtp_net_exit_batch_rtnl() to ->exit_rtnl().
>   bareudp: Convert bareudp_exit_batch_rtnl() to ->exit_rtnl().
>   geneve: Convert geneve_exit_batch_rtnl() to ->exit_rtnl().
>   net: Remove ->exit_batch_rtnl().

Series:
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

