Return-Path: <netdev+bounces-185452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC201A9A6C3
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89A01B828AE
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314DF222577;
	Thu, 24 Apr 2025 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AC70rOvk"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E461F2701AB
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745484422; cv=none; b=OC/dTq+RinwYOPYNvm5AAGgpqM6WB1FndEmNDdqU/nR5GNAh14Be6f2tK2TMQ44DkOQVqgDoQ2R1sDNzgmVJk2H4NqnUDgJEUUNI8PforSa2lsufJGSuFBuXAVUjhyYuoJaGKewmF4+yeJBzTCcMKl3w01HxoFgWkw4ltsSBBQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745484422; c=relaxed/simple;
	bh=09YR4trOID9Pb/yj83azaIIYs48TvTpJM9lmdBcJFLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXv5b3BMwtyEPUNDjbA6cs7YGEcXUUNaKeY3llH1XQTle/rh4CX5UxpAYlUIOTHPwZeFs4hhzSMAQjTN+wuECWXXqTRUkqSRHlCz0CJ1R1lgXSgoO00MH1QPu2+VjJw2i+snjo7/N+Xq6e0wUIoQ7a0CB54R3DmkndyvUH9g9dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AC70rOvk; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DB0CA11402B1;
	Thu, 24 Apr 2025 04:46:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 24 Apr 2025 04:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745484417; x=1745570817; bh=81QcHKFE2K61345Bc3RwDZ2vvr+juiOhgoZ
	Pe60K0og=; b=AC70rOvkRZEND5rYUitGE97pLjixJcXf8bRu1UX3Tv+rKDso4OB
	le4muFX6HZd5k45VME5h6Gr+xnU+OuEkJMQvPV7dwA2az/y0bvjUJShNKZG/Dbqr
	mI2Dfjbp9bEKUrC1qnxBs8FShlM8Xph8olLH3GVD2vCX2So7sbH1ZVKdiwDn+Nip
	0a5Fs8AgtdgD3FCKzxgVzIYGdZH4HNcjdz/ruKBBU9pfEOtbyFUvhr+qyZmUnkN7
	LD07ar2S4lcLqRZxOtoX5Wqr0KIRL95H+AvBd6+6IWzpyqPzTbtsU9huGxOPyGQu
	gPGdNQxw0VnaVcxbHVFtonlK4MtGJoFyoxg==
X-ME-Sender: <xms:gfoJaP34mLKxBpP2TbYvthJoznnjH5XpbJA2l9rJz9p9h7ICfOWPjA>
    <xme:gfoJaOFtB7J7c8jkVODhvIEAfRuQq0FPeEOnQTIldgECe-FbTJnTaQqJOR23DX_-j
    50HBcN6m3a3txo>
X-ME-Received: <xmr:gfoJaP5Grtq2vMA3YX-p2FEekT4GQTEktmHGSP0PUUBnZN9LJYFoAXcAf8S7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifedu
    ieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhimhhonhhksggrsg
    ihsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:gfoJaE3aB6vg3mWWzla7SuT5UskRwbf_w_lsIZfcebqOmkW14WkqTg>
    <xmx:gfoJaCHluCE2hk7K9rAv8QH_SchTf6AA4TyXdZpxGH-vib_yNeKbcA>
    <xmx:gfoJaF_R59KaO_p5Lr1yGK857xiz7WVj8ybNn2NLvD_rZUskrlKlXg>
    <xmx:gfoJaPkQAesuyUzpCY1S_ReMtj5sMOwjJwq_VafVjHxwEHb3wRFsYw>
    <xmx:gfoJaIEtDsXPAYEFXa_KildlJ2hHedRQcny8nHilAgDdesTKnsxH4WZk>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 04:46:57 -0400 (EDT)
Date: Thu, 24 Apr 2025 11:46:55 +0300
From: Ido Schimmel <idosch@idosch.org>
To: SIMON BABY <simonkbaby@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: query on EAPOL multicast packet with linux bridge interface
Message-ID: <aAn6f9c-sck_pCTp@shredder>
References: <CAEFUPH1Erfh9YUctVDHxL8TWsiVfs+Fr8aJLtrjiKECbiGTxHQ@mail.gmail.com>
 <aAjSCwwuRpI8GdB7@shredder>
 <CAEFUPH0cU-5ZJ_qAevp1DENYrUkSO4zipUTg0vzLmgz16nPbbw@mail.gmail.com>
 <aAkMhl3klxYx-n2Q@shredder>
 <CAEFUPH0kh73VU8TmbS3Jx8jJ_RjwbQStx5deV25Ji5a3ZQp-xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEFUPH0kh73VU8TmbS3Jx8jJ_RjwbQStx5deV25Ji5a3ZQp-xQ@mail.gmail.com>

On Wed, Apr 23, 2025 at 10:59:35PM -0700, SIMON BABY wrote:
> I tried with br0.10 and still did not see EAPOL packets are
> forwarding. Below are the tcpdump logs with lan5 and br0.10.
> 
> 
> root@sama7g5ek-tdy-sd:~# tcpdump -i br0.10 ether proto 0x888e -p
> tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
> listening on br0.10, link-type EN10MB (Ethernet), snapshot length 262144 bytes
> 
> br0: port 5(lan5) entered disabled state
> mv88e6085 e2800000.ethernet-ffffffff:10 lan5: Link is Down
> mv88e6085 e2800000.ethernet-ffffffff:10 lan5: Link is Up -
> 100Mbps/Full - flow control rx/tx
> br0: port 5(lan5) entered blocking state
> br0: port 5(lan5) entered forwarding state
> 18:15:59.243997 EAP packet (0) v2, len 5
> 18:16:02.245922 EAP packet (0) v2, len 5
> 18:16:08.252660 EAP packet (0) v2, len 5
> 
> 
> 
> root@sama7g5ek-tdy-sd:~# tcpdump -i lan5 ether proto 0x888e -p
> tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
> listening on lan5, link-type EN10MB (Ethernet), snapshot length 262144 bytes
> 
> 
> br0: port 5(lan5) entered disabled state
> mv88e6085 e2800000.ethernet-ffffffff:10 lan5: Link is Down
> mv88e6085 e2800000.ethernet-ffffffff:10 lan5: Link is Up -
> 100Mbps/Full - flow control rx/tx
> br0: port 5(lan5) entered blocking state
> br0: port 5(lan5) entered forwarding state
> 18:18:00.558929 EAPOL start (1) v1, len 0
> 18:18:00.566422 EAP packet (0) v2, len 5
> 18:18:00.580678 EAP packet (0) v1, len 28
> 18:18:00.688667 EAP packet (0) v2, len 6
> 18:18:00.711016 EAP packet (0) v1, len 172
> 18:18:00.866300 EAP packet (0) v2, len 1004
> 18:18:00.867310 EAP packet (0) v1, len 6
> 18:18:00.871946 EAP packet (0) v2, len 1004
> 18:18:00.872795 EAP packet (0) v1, len 6
> 18:18:00.877155 EAP packet (0) v2, len 1004
> 18:18:00.878087 EAP packet (0) v1, len 6
> 18:18:00.882673 EAP packet (0) v2, len 866
> 18:18:00.893136 EAP packet (0) v1, len 1492
> 18:18:00.898185 EAP packet (0) v2, len 6
> 18:18:00.899091 EAP packet (0) v1, len 903
> 18:18:01.912476 EAP packet (0) v2, len 4

The captures were taken at different times, but it seems that only a few
packets reach br0.10 compared to lan5. You can put the bridge in
promiscuous mode to make sure that everything that is received by lan5
is also received by the bridge interface:

ip link set dev br0 promisc on

If this helps, you will need to look at the destination address of the
packets and the bridge FDB ("bridge fdb show") to understand why the
packets don't reach the bridge interface.

