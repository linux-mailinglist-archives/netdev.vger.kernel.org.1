Return-Path: <netdev+bounces-135630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CBC99E9DD
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD5C1F236E7
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF8F2139AF;
	Tue, 15 Oct 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QA/bqYwl"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B346E21263B;
	Tue, 15 Oct 2024 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995437; cv=none; b=rw/eTCIvnF3qhvM29k5yApBda2ex0mX3VMl/OkyAZEUItH4lGV9uEXfS1Vcjib/6Bo85uX8Hjf39EgTTJ3De47eAOxsAF6XEy3M8eiH/ABKeikTmDkf2195XKT49d1q6RXNaAyJpNgahApu21/HWLKCAfO/3XJJMDuWwnYZqSZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995437; c=relaxed/simple;
	bh=eL7JCKO9uu2d1gd8wDs3fExywNPWCIC7IBWB3q6aC6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxhPHHLn/BcDttXVNK4S+y1llNsia0vf68t3UwJkxDMNGJv4RlxnRopdAUxv2/m79F/uSGLqKxUgTbrWdu19d65ZU4hOOr2hfFYzkMlEMnHX7bZZ60essoPj3j4WZkOXBsq8qWq+9FH/NZTbTCERki8lFY9J09ICH02f+giRdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QA/bqYwl; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ABFD11140225;
	Tue, 15 Oct 2024 08:30:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 15 Oct 2024 08:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728995434; x=1729081834; bh=MwqVBPnTbXJp1eVz0QqOSSjQgJz9
	OUv9qXtnOnH7KpM=; b=QA/bqYwllo/g1p7uXM2mBaH43oasEEVp0aneOX29TvE7
	g9TVlowM3NHG7BYq0TkUnK69eSBXBNMm0qnXZcBtekkJncip1k7BVLSVwjJKTdMV
	LK804gbxf4mAD3O3CRMOv75oz4rPnm8ELfj22dgiEli5820wRfwNeSEcgcqoMqvq
	pGvsNS+lS4qraeM2z79x6lzzIV15MWFuRe9oWGUvWmQYDtCfHMI7mGYXAvLpM4fd
	kLjuZY7luCp1mYERfemdoHKciVY7O8NCrNmeN3WIW4hRL1jhpCq/rvzemaEV42Jz
	r7RGS3DVxN+PABq4uxwmmBSlk8oNz5YIqPCtxlxSnQ==
X-ME-Sender: <xms:aWAOZ4yDAzxEY91zpQH1cbMsoB28aSShW0uSczGLHIj1zsqTGO_LAw>
    <xme:aWAOZ8TmtKqNV_FH5o7mfepCjQ37YeT1LB0xlIVLeb4Id8k13ZHT1ZxLpz9TBdz7O
    UNLMt87OTDPIeo>
X-ME-Received: <xmr:aWAOZ6WxauIVFVaY48QzA5yq5naWnfqGpOB_0vU0h1zOItMJLqSJPsihgS_Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieef
    gfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthht
    ohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvghnghhlohhnghekrd
    guohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtth
    hopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhi
    sehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopeguohhnghhmlhdvsegthhhinhgrthgvlhgvtghomhdrtghnpdhrtghp
    thhtohepghhnrghulhhtsehrvgguhhgrthdrtghomhdprhgtphhtthhopegrlhgvkhhsrg
    hnuggvrhdrlhhosggrkhhinhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:aWAOZ2hNB2IpMorYqDYkCRf8JHXtWGZRlMi6Wd3oVfDOWCjibLgAtQ>
    <xmx:aWAOZ6ApyxSG71JkCwyy5AOquRSjgAP6vy2EeHhVn-Se4QSxaGGCrA>
    <xmx:aWAOZ3IVTQLWhRxk59rS-B75dAVSXZTfO6QmqDa0TDxDCOXUpPtTig>
    <xmx:aWAOZxAfzE_Ais1Cju9_FmhfrpViCDiXpksXQoJwvzpOtgq9-wvp-A>
    <xmx:amAOZyaY9ZbqPriz0Qjg5rYK0ktC2HY2NAon-e0vuHp4ovB0hMD1Gmrg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 08:30:32 -0400 (EDT)
Date: Tue, 15 Oct 2024 15:30:30 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, dongml2@chinatelecom.cn,
	gnault@redhat.com, aleksander.lobakin@intel.com, leitao@debian.org,
	b.galvani@gmail.com, alce@lafranque.net,
	kalesh-anakkur.purayil@broadcom.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: vxlan: replace VXLAN_INVALID_HDR with
 VNI_NOT_FOUND
Message-ID: <Zw5gZvIY9Tw8gIHe@shredder.mtl.com>
References: <20241015082830.29565-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015082830.29565-1-dongml2@chinatelecom.cn>

On Tue, Oct 15, 2024 at 04:28:30PM +0800, Menglong Dong wrote:
> Replace the drop reason "SKB_DROP_REASON_VXLAN_INVALID_HDR" with
> "SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND" in encap_bypass_if_local(), as the
> latter is more accurate.
> 
> Fixes: 790961d88b0e ("net: vxlan: use kfree_skb_reason() in encap_bypass_if_local()")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

