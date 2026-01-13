Return-Path: <netdev+bounces-249603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 877C6D1B762
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FF49302BA9C
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D2934A3C5;
	Tue, 13 Jan 2026 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="hMrDZUET";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B8jzd1fq"
X-Original-To: netdev@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17768324B23
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 21:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768340561; cv=none; b=T+6+M5P0VdjyrJB/T7SQJ59sJYWDmHk8wCSTdu54N03Pau7SRGqJYm6oVBh2CCxtqFit/Up5pRCV+9YjnV2OiQjRbGkUHNNjXG7WFqEqCoRsKch/J1uGWqNpxdtVzIJ8q6p7c27EVMVRlqEFpLdP8jLFjfqqShv8IByQDhcgd+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768340561; c=relaxed/simple;
	bh=mELgttC5ZHc7+AUHEXoVvbK84+T/AA9RqXfrm+f7LRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wl8dZGg2CX/1/1SI8p8HMiPvU9/GBUnnZI8t1GWj/D5+OhnsC1a+s/PjVeava9oJajne6sIrTXhdKYITs0TkOVF0SPqaiPtd4FuWuOVtBFXaX5Z4mRl2XqgMm5rDd/4gRsQLqndITw477GPg9pc5J/FrKJntMg7m6CGeMjFQqGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=hMrDZUET; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B8jzd1fq; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id 47B0013800B2;
	Tue, 13 Jan 2026 16:42:39 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 13 Jan 2026 16:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1768340559; x=
	1768347759; bh=8fIUvzEggopi40wYb9pIZh67igzJ55lZADPKUmMCog4=; b=h
	MrDZUETvuKKIFfJ96OV7G8aSnubEQ2le5tH3wULKm0DdSKiTDC1OB344vPWftd7S
	/yej1bjYmXO5BtH7OoPJ9FBvyeXkBtA00kTJRaAz8T5F6cE+UGAGrdQ+YKwJHCYS
	j1swiJADT/jzuTgFpMJ/1jupuxVxDWbHAm6D2ViT/c85clhqKb0yVrdT5fzizyrC
	d2hpgaYrrJ8SSA1Dps1T8gI4k6afmq79B9xpi08khLjSW4WrgEvQgJiJRb7KVFmy
	t5H5osbGentKHb9OeJD3tS2fZsLPZOvsZXGc6cvWUHT0tZFNVS0ZFuECu/qaOW90
	YEho2mNnrvo014rbMmR/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1768340559; x=1768347759; bh=8
	fIUvzEggopi40wYb9pIZh67igzJ55lZADPKUmMCog4=; b=B8jzd1fqlNlib6vXJ
	iDeJJyG2iCPfO8mJR7TMi5rGd0QMiT62BilRRNlNNDH+hSYnqqt1lP1LcSoj6EM+
	LnbvDUJdPjVlkRU1UE5DQ6Nw804OjDcHZqxjcgPiYn6w35LTBlI9nk/5NVfhrJzH
	f1mevLO+dV36r7XWL30UMqwX+xjUHhLzaWWggGbOAP5ZFwn7Fx//6cKmECreTV5g
	rnjZwfZ6NsaxxJynzpks1FcUxSw+tMXvsLjm5xLbEJ5EZkIbFWRqImcb1XcoxpiH
	GLoPPjB/wc4Lir/wbOctu22b3AurmZAEfUQuN1wyDjFvOQNlpUplkaJOO8ytxNZl
	XnH/Q==
X-ME-Sender: <xms:T7xmaUHcYOg-f0I7IJuNJmbBJrJ9SZ9bxrbQnbhB7DVouDRbTcnTLw>
    <xme:T7xmaUMUOXwTfP2y_DRHRNsDeZeRt4gTRVZTByFWgbs28WNwCuvSLb6cQSyQLCaEi
    7i_XBis1-Ky9il72SknxgzJSzXQCP4PN0DsADtjV0vhOH9UaJjczw>
X-ME-Received: <xmr:T7xmaWdlWJeABSx4NDA-vGTJ3KroHqfQrHbH0S1zcnbGt0mCsZ2RUCIVWHYiiNcipRH8DveAdBQiJX0TmHokwpGS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddugeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdhqredtredttdenucfhrhhomheptehlihgtvgcu
    ofhikhhithihrghnshhkrgcuoegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrd
    himheqnecuggftrfgrthhtvghrnhepjefgvefhheelvdetuddvgedtheekgfeitddvieei
    vdfggfeigeeuudevudevgeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvrdhk
    vghrnhgvlhesfhgrshhtmhgrihhlrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepmhgrkhhlihhmvghkleejsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrlhhitggvsehi
    shhovhgrlhgvnhhtrdgtohhmpdhrtghpthhtoheprghlihgtvgdrkhgvrhhnvghlsehfrg
    hsthhmrghilhdrihhm
X-ME-Proxy: <xmx:T7xmaRvhUi4nxqU3zfHpl1fiWa2ZVkcb4yFxyZ389AAkef8xpQbemA>
    <xmx:T7xmaXnXgVMAzo1lYdSJ6gKbMH0ynG-sNbAmTwYJ0W15z-eQ6OdCGw>
    <xmx:T7xmaTzOZ8svXYTImP39_x0921Bcn3f_H_2B2SyPx2elBSnkJ0lQSQ>
    <xmx:T7xmaZP_BVxjqetZKr3dXaXBODwWFEAXMDxChGgef5UfpYt6Ga1FTQ>
    <xmx:T7xmaazb1VLiUXTLpjzM4HFKMQarmNHIj95IMo0lk9Um_uA5DHW7kjKl>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 16:42:38 -0500 (EST)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Mariusz Klimek <maklimek97@gmail.com>
Cc: netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Alice Mikityanska <alice@isovalent.com>,
	Alice Mikityanska <alice.kernel@fastmail.im>
Subject: Re: [PATCH net-next v2 0/3] net: gso: fix MTU validation of BIG TCP
Date: Tue, 13 Jan 2026 23:42:31 +0200
Message-ID: <20260113214232.129356-1-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106095243.15105-1-maklimek97@gmail.com>
References: <20260106095243.15105-1-maklimek97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 06 Jan 2026 at 10:52:40 +0100, Mariusz Klimek wrote:=0D
> This series fixes the MTU validation of BIG TCP jumbograms and removes th=
e=0D
> existing IP6SKB_FAKEJUMBO work-around that only fixes the issue in one=0D
> location.=0D
=0D
My series removes IPv6 HBH in BIG TCP entirely:=0D
=0D
https://lore.kernel.org/netdev/20260113212655.116122-1-alice.kernel@fastmai=
l.im/T/=0D
=0D
I believe, it makes this fix no longer necessary.=0D
=0D
> For GSO packets, the length that matters for MTU validation is the segmen=
t=0D
> length, not the total length of the packet. skb_gso_network_seglen is use=
d=0D
> by skb_gso_validate_network_len to calculate the segment length including=
=0D
> the network and transport headers and to then verify that the segment=0D
> length is below the MTU.=0D
> =0D
> skb_gso_network_seglen assumes that the headers of the segments are=0D
> identical to those of the unsegmented packet, but that assumption is=0D
> incorrect for BIG TCP jumbograms which have an added HBH header that is=0D
> removed upon segmentation. The calculated segment length ends up being 8=
=0D
> bytes more than the actual segment length.=0D
> =0D
> The actual segment length is set according to the MSS, so the segment=0D
> length calculated by skb_gso_network_seglen is greater than the MTU,=0D
> causing the skb_gso_validate_network_len check to fail despite the fact=0D
> that the actual segment length is lower than the MTU.=0D
> =0D
> There is currently a work-around that fixes this bug in some cases:=0D
> ip6_xmit sets the IP6SKB_FAKEJUMBO flag for BIG TCP jumbograms, which=0D
> causes the MTU validation in ip6_finish_output_gso to be skipped=0D
> (intentionally). However, this work-around doesn't apply to MTU validatio=
ns=0D
> performed in other places such as in ip6_forward. BIG TCP jumbograms don'=
t=0D
> pass the MTU validation when forwarded locally and are therefore dropped,=
=0D
> unless the MTU of the originating interface is lower than the MTUs of the=
=0D
> rest of the interfaces the packets are forwarded through.=0D
> =0D
> v2:=0D
>   fix jumbogram check in skb_gso_network_seglen=0D
>   add jumbogram check to skb_gso_mac_seglen as well=0D
> =0D
> v1:=0D
>   Link: https://lore.kernel.org/netdev/20251127091325.7248-1-maklimek97@g=
mail.com/=0D
> =0D
> Mariusz Klimek (3):=0D
>   net: gso: do not include jumbogram HBH header in seglen calculation=0D
>   ipv6: remove IP6SKB_FAKEJUMBO flag=0D
>   selftests/net: remove unnecessary MTU config in big_tcp.sh=0D
> =0D
>  include/linux/ipv6.h                   |  1 -=0D
>  net/core/gso.c                         | 14 +++++++++-----=0D
>  net/ipv6/ip6_output.c                  |  4 +---=0D
>  tools/testing/selftests/net/big_tcp.sh |  1 -=0D
>  4 files changed, 10 insertions(+), 10 deletions(-)=0D
> =0D
> -- =0D
> 2.47.3=0D
> =0D
> =0D

