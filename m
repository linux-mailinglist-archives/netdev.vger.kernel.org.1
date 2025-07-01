Return-Path: <netdev+bounces-202847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C85AEF56D
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392591BC6A4F
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D707527147F;
	Tue,  1 Jul 2025 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NrUxfgt3"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577CC271450
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366704; cv=none; b=ck6jdKho3jFTknLVTh0wNTZZJgOCGGKeqdi3QklA1OIbzN8NKOXYZCdwcPE16FkNBXbXWRPdmPEcUtujnyR2gtawmrYRtIZZhHcNGeZFYarae9OzTKE0UKLnvC2VwCvnjnDYz9Fbeg33fBD6ePDGue7jio1586VTWqVBQjdWahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366704; c=relaxed/simple;
	bh=INmLLPubcO8F013mfC37AITmn0/rP7i9xV1mAcdD+ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ms14IAiZjAzYJMtHl0io+Bmob0z+Tuu0SpIChoWtlVo/yETAs+3PsMGe6nNPCmfPmj5LCm1VK8+ST0goGFOQZQY5fg0+xviyKG05YAG1XMorNUbbBv0YLv9KsJA2kKMcZHIhKtM/XJpkY/eWu/bmJ4HPO4coqDTPTNEPEkq/c8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NrUxfgt3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C2237A0185;
	Tue,  1 Jul 2025 06:45:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 01 Jul 2025 06:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751366702; x=1751453102; bh=1PCm/BJeKbPoj8YnYJdeGTrg1wILOW2WShH
	1/lx5sIk=; b=NrUxfgt3PSswID3LVdFr3qEJEz16s36RicOroXuYEOCKFDnrdtl
	8fw/MVaptPxC50HX9sdZ8VTlyqenoxqWD+CZUyEWPGxWrKpqutym/PG1eUW0nY99
	ZTlMiEG9VlSemyFr/W1l6N3xLxPaVB9F2PiiRSxbY96CxDlzVJtiuN/4jj/D3LB9
	gewbHtjkSk1zSfCMJ/H4hLK6KQPsbdaq9jIaDUxApiZDBn1C62azxGQADR+VwJWA
	QWSheraDEKzgAt2+yxWdhaC+p2dG77rO070xvzjPGoXVzzpn5f2TSod/Fo2nOUrb
	9rf5PSDQYaNfVs+H1oUYR9d1K5UYI4raAkQ==
X-ME-Sender: <xms:LbxjaOLytmLjiQjqDCJlEOZfq-mHm_lquMwCFwpgK6miZK7Z6Y87bA>
    <xme:LbxjaGKSapJqykIAlDDOm1KrQK2zdQk4U02t5BhQASYIGsQmnNcMs76aZkMIy8mmh
    7HdBdepKfNiexI>
X-ME-Received: <xmr:LbxjaOu3nPwPR0M4Bmc1BTtlY8WqGKRf7YUNdaBbcDPRDMMzM8EOvD5OUIvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgt
    hhdrohhrgheqnecuggftrfgrthhtvghrnhephefhtdejvdeiffefudduvdffgeetieeige
    eugfduffdvffdtfeehieejtdfhjeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughosh
    gthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepug
    grvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphht
    thhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohephhhorh
    hmsheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LbxjaDbdfvffVx8JPoD1wFW9TTDz4SwRqkWlpM96xNFVLpgV_keyLA>
    <xmx:LbxjaFZ4zlnPIUYtMMlTDZVhhWgxi96NtN82y4l3Swcl8UvWt0OQHw>
    <xmx:LbxjaPAcNcGlOkFkmTaXazk2fAq1gDUUKKsLaq_76G0NNLX3uXGHXA>
    <xmx:LbxjaLaDejs-MLK50U8rppyBXudoY2tuXtHjrxH7gvT6wngrEe4L_Q>
    <xmx:LrxjaHVWRbtXZ4R0TdxricjxQ7TS7dSGeQVGFpMfoSXSyx3oKYXefcEK>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 06:45:00 -0400 (EDT)
Date: Tue, 1 Jul 2025 13:44:58 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next] net: ethtool: fix leaking netdev ref if
 ethnl_default_parse() failed
Message-ID: <aGO8KoNoWs2MJpDe@shredder>
References: <20250630154053.1074664-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630154053.1074664-1-kuba@kernel.org>

On Mon, Jun 30, 2025 at 08:40:53AM -0700, Jakub Kicinski wrote:
> Ido spotted that I made a mistake in commit under Fixes,
> ethnl_default_parse() may acquire a dev reference even when it returns
> an error. This may have been driven by the code structure in dumps
> (which unconditionally release dev before handling errors), but it's
> too much of a trap. Functions should undo what they did before returning
> an error, rather than expecting caller to clean up.
> 
> Rather than fixing ethnl_default_set_doit() directly make
> ethnl_default_parse() clean up errors.
> 
> Reported-by: Ido Schimmel <idosch@idosch.org>
> Link: https://lore.kernel.org/aGEPszpq9eojNF4Y@shredder
> Fixes: 963781bdfe20 ("net: ethtool: call .parse_request for SET handlers")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks!

