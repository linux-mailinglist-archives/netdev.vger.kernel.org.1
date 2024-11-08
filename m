Return-Path: <netdev+bounces-143415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64439C25A4
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8ED1F214E4
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 19:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD4618DF86;
	Fri,  8 Nov 2024 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Ob5BdJqi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GJsTT4aY"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E1915C0
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094567; cv=none; b=lDF3o8bJMU1OTi++sELb0X7tKprqYNMYtkUu3os1PJzppdOo5kh812PUtVb2t5A6brCCdSTipR3xHzNMY57bKlI19gkK21FntmbgpbBcrkoAdcFD6KW/E7ANzvmFZFpICd78xeJE5Ln4zfB/TYDmHsyt63ZEYQVv00eOijc4/AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094567; c=relaxed/simple;
	bh=/8b2U1jLjYM8g36+RwVbaaGhuP3Boib5mn1j2I8Bz4Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=X6i4sluGi5bStqh+vU/0zHzbpio3hZbDXJECktx2IB+cndkP2R+oFH3sgo1lXGrzQh9bTxoHXUxXisGxsydIZAUOltw9GfFv/CjtrSQovisrCZ6SpGRmqmn3lZ/xjWFTEFVWiOvI+vduheVy3Okt17T2XK3F1yhdIlVEc/ES4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Ob5BdJqi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GJsTT4aY; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D4E125400E8;
	Fri,  8 Nov 2024 14:36:03 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Fri, 08 Nov 2024 14:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731094562;
	 x=1731180962; bh=HNqk8UAukYiOwun/ji1txAiTv8zKVFAUg4KaIsjDPrM=; b=
	Ob5BdJqiei25g6fegGlGOiHl3N4eetqdf0jIIhVldot10YLU91J3zIbbMeLSP4wJ
	jlb92yHxR7Nxbj2jMVCI4QkJcNbHg72ASb94l0mOHpMlbqT3zvatUNbMnTRMc4iE
	YjJBLzY3Thdh54wqRfxEs2vgdBjmqF/hDYOaI6OClMSgYhLTmJBiz2nW8KOPPUAB
	QiWgLrZuhS7UaxlQtlv3Y43AJBr4YlEQ+3261m0LwdMLJKj+TGPxXLdny4+d76Rj
	EYcH/NToqmz82b2osasKo/Vtovo3Xot7UGqW/DtcHOyRT21LM7fJ3cu5oOBzphPC
	60nD+w3WNML1ThLcR0oOmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731094562; x=
	1731180962; bh=HNqk8UAukYiOwun/ji1txAiTv8zKVFAUg4KaIsjDPrM=; b=G
	JsTT4aYWHIhgvisdgZQ8gOl/7auL2p5jCE2TnqstXY6rQgIENZSJLAFEkl67MLcr
	ak7QdD/T77OuJZBz+JPko5iAUOwwz1z3hG7mlaBgHHPNIs/MCoGfN6pYOtVTIY3e
	6AEdWCELSPnf9a05srZysXnpYmQhcYio9MJ1XDmTg5pbiAE+7s/yTDl9RHVNaCrL
	Z7csg9iNNfnENcrsj+hDQElVjlhZbYLPbbcW7WQug7M5Zk41iviNROeCz32dSEbR
	21/zWcqaw4l7GYeVM/uTPxGkapQG+I3Werj6iBy9IEiKyolhut4sufFwjub1ZpOg
	DWPNClItOoZN9CGIPj0BQ==
X-ME-Sender: <xms:ImguZzyifrVNaH0IJhXlmlc4nbOIhzxFe-VuTJG3Xke8YQ1G7bc0qA>
    <xme:ImguZ7QX8-viiHUB-KciZbceE1saLcsOz-eXlFUWYDi4JfkS4-RFxc4BEjb4IkYB5
    GGcbkTxzanU5Hdpgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthejredtredttdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugi
    husegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeegleeifffhudduueekhfei
    fefgffegudelveejfeffueekgfdtledvvdeffeeiudenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtth
    hopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomhdprhgtphhtthhopehmkhhusggv
    tggvkhesshhushgvrdgtiidprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:ImguZ9UnHccwAUwkR3bSoYjXjdCftvNk_LRVEEJKr7qER0fv8O2usA>
    <xmx:ImguZ9i_cqw7kM1OqVwlkq2TbX5fIRoY9Fo1EnW7FBHmBYVN9al4Jg>
    <xmx:ImguZ1CDm-zyNY82bjOC3bCUEzzsVgNzhqraPThzQlDr5sCJOsUwBA>
    <xmx:ImguZ2Jl12SrWfEEy5x5cVgan5azZT4SeoN1oc_sL42jllLo24KpQA>
    <xmx:ImguZ46prW6DSbzleEd8yBlVGBdLR5kOxj2K0F3ZDurHb7X7UiOWUTay>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3F95E18A006B; Fri,  8 Nov 2024 14:36:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 08 Nov 2024 11:35:41 -0800
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "David Miller" <davem@davemloft.net>, mkubecek@suse.cz
Cc: "Jakub Kicinski" <kuba@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, netdev@vger.kernel.org,
 "Kernel Team" <kernel-team@meta.com>
Message-Id: <6d1a91b5-231f-4040-831e-f4485d02f102@app.fastmail.com>
In-Reply-To: 
 <890cd515345f7c1ed6fba4bf0e43c53b34ccefaa.1731094323.git.dxu@dxuuu.xyz>
References: 
 <890cd515345f7c1ed6fba4bf0e43c53b34ccefaa.1731094323.git.dxu@dxuuu.xyz>
Subject: Re: [PATCH ethtool-next] rxclass: Make output for RSS context action explicit
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Nov 8, 2024, at 11:32 AM, Daniel Xu wrote:
> Currently, if the action for an ntuple rule is to redirect to an RSS
> context, the RSS context is printed as an attribute. At the same time,
> a wrong action is printed. For example:
>
>     # ethtool -X eth0 hfunc toeplitz context new start 24 equal 8
>     New RSS context is 1
>
>     # ethtool -N eth0 flow-type ip6 dst-ip $IP6 context 1
>     Added rule with ID 0
>
>     # ethtool -n eth0 rule 0
>     Filter: 0
>             Rule Type: Raw IPv6
>             Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
>             Dest IP addr: <redacted> mask: ::
>             Traffic Class: 0x0 mask: 0xff
>             Protocol: 0 mask: 0xff
>             L4 bytes: 0x0 mask: 0xffffffff
>             RSS Context ID: 1
>             Action: Direct to queue 0
>
> This is wrong and misleading. Fix by treating RSS context as a explicit
> action. The new output looks like this:
>
>     # ./ethtool -n eth0 rule 0
>     Filter: 0
>             Rule Type: Raw IPv6
>             Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
>             Dest IP addr: <redacted> mask: ::
>             Traffic Class: 0x0 mask: 0xff
>             Protocol: 0 mask: 0xff
>             L4 bytes: 0x0 mask: 0xffffffff
>             Action: Direct to RSS context id 1
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  rxclass.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/rxclass.c b/rxclass.c
> index f17e3a5..80d6419 100644
> --- a/rxclass.c
> +++ b/rxclass.c
> @@ -248,13 +248,12 @@ static void rxclass_print_nfc_rule(struct 
> ethtool_rx_flow_spec *fsp,
> 
>  	rxclass_print_nfc_spec_ext(fsp);
> 
> -	if (fsp->flow_type & FLOW_RSS)
> -		fprintf(stdout, "\tRSS Context ID: %u\n", rss_context);
> -
>  	if (fsp->ring_cookie == RX_CLS_FLOW_DISC) {
>  		fprintf(stdout, "\tAction: Drop\n");
>  	} else if (fsp->ring_cookie == RX_CLS_FLOW_WAKE) {
>  		fprintf(stdout, "\tAction: Wake-on-LAN\n");
> +	} else if (fsp->flow_type & FLOW_RSS)
> +		fprintf(stdout, "\tRSS context id %u\n", rss_context);

Gah, missed { at end of line while transcribing patches between
different machines...

I can resend if y'all want.

>  	} else {
>  		u64 vf = ethtool_get_flow_spec_ring_vf(fsp->ring_cookie);
>  		u64 queue = ethtool_get_flow_spec_ring(fsp->ring_cookie);
> -- 
> 2.46.0

