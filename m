Return-Path: <netdev+bounces-180604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23534A81D3B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C0C464920
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 06:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209491E1E06;
	Wed,  9 Apr 2025 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cRTNueH0"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED3A1DF26F
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744180839; cv=none; b=lKD8E9og91UvTHtAuR0C0jcnmyVt5drX1cx9ne6NqPzTes+Ubmklkm1jYt4gJp8jYb38nsYwwJf3GZVSVEqZTGpdYvmC0flZ4jKryyLPBgpJvM/cXblSFGSRwiNBrt9bv3S+OPkx1fSy+cRPq4U2G1hpUKEyuLCctz3wzwK6jbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744180839; c=relaxed/simple;
	bh=7o6a2nvVwLYHeX/c8zhJrI+adrIx2FSoCS5LnDERMWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVll/+9xnd5erwcBysqNL7DSHPKHTAAsNEBvCgx6w4vVJmdkNxuw04CuDNxv5MO28x6DGEYfELPxr/O8ghy6hdMMpiEfRO8dDgAbO40yZL4ahrxO3CYAppJsYWPSUrR4BWyNy28wtTzYOmyykf5J2s+cGwMk8V0mGfopvoroV/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cRTNueH0; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 11D751140192;
	Wed,  9 Apr 2025 02:40:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 09 Apr 2025 02:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744180836; x=
	1744267236; bh=BcwP9avawRhonmUticFT0MAEd9a2Df0v1P5/5LGiiZM=; b=c
	RTNueH0IIMwHk5ZWS3iQqiWHI4yQmVKZ4se9XthdxlD/m9oExf+w6/QAIh4mp1KA
	mALw5j+BbJ2P16SiQMF7gicYpaVN+yjbjrSaL9xMRMYcOutrtnLtGqmyC6O1diQk
	HqN5rrO+9VIjxOsjBiaTm+pDdaahU/Fjc9hTavqPKLMW/y9Yh1GtaYRgEnSxbBxu
	rzeImKV/jNqShgwat24210y6Fs/LH8KL+4oPjQ1Qu+GHcFKQI1yTfwce6CPxVlkR
	DoVzM/NPj5ETX2E+y2kTJxdijgpv1d8JRsfAAWzdiTpGXUXvzaNrJOLKy9mE9UBi
	PXAspbrFnqbwIAVWpJvOA==
X-ME-Sender: <xms:Yxb2Z8fzdfF-hOmcFTJtfygwTm3iYyAeOAhQkdRO4G0yBbJ0mAI1uQ>
    <xme:Yxb2Z-Oxp13VyChDHNE-WUytPEYEf2AKo1dX-l-ZbU1MBkU2Mrq0xNmGAQ8wfMH2X
    MlVzgKyCG05EOw>
X-ME-Received: <xmr:Yxb2Z9gH3Vi4f02DNUd3QY1szst7s10IGIQ9bZMQsZWQWJKU57zfH7VsJWB8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdehvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstg
    hhrdhorhhgqeenucggtffrrghtthgvrhhnpeekgefggefhuedvgeettdegvdeuvdfhudej
    vddvjeetledvuedtheehleelhffhudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitghhrggvlh
    drtghhrghnsegsrhhorggutghomhdrtghomhdprhgtphhtthhopegurghmohguhhgrrhgr
    mhdrrghmmhgvphgrlhhlihessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepuggrvh
    gvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    rggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnh
    drtghhpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Yxb2Zx_TKzubvdOve1nwM-gseuR7OYepl7cYZi9da7WMcP6JoZXAtg>
    <xmx:Yxb2Z4uCLlBLLrPL1bLiZv_nuxMeAJoNf1fuzJNskqzjyTtDfajFRQ>
    <xmx:Yxb2Z4ETIVArdXPVd1PPM5YkCDBQ93YilssOXhkaUpaFolbSP1OqnA>
    <xmx:Yxb2Z3PFJCGq7nQonZ38o1ci_KiqafccyLdAViwKeY-VaCoC_b2HSQ>
    <xmx:ZBb2Z4bJvk-Avj4yGDO-rquUYpLM4OetIFavlQiYFG3DXZ6M6sfZbRjO>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 02:40:35 -0400 (EDT)
Date: Wed, 9 Apr 2025 09:40:32 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
	horms@kernel.org, danieller@nvidia.com,
	andrew.gospodarek@broadcom.com, petrm@nvidia.com
Subject: Re: [PATCH net 2/2] ethtool: cmis: use u16 for calculated
 read_write_len_ext
Message-ID: <Z_YWYKfUATz19geO@shredder>
References: <20250402183123.321036-1-michael.chan@broadcom.com>
 <20250402183123.321036-3-michael.chan@broadcom.com>
 <Z-6jN7aA8ZnYRH6j@shredder>
 <Z_P8EZ4YPISzAbPw@shredder>
 <CACKFLik=7nTXHGUiTQH=aAsY=3sxd39ouZLEYkN2hj8rRHetsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLik=7nTXHGUiTQH=aAsY=3sxd39ouZLEYkN2hj8rRHetsw@mail.gmail.com>

On Tue, Apr 08, 2025 at 11:25:44AM -0700, Michael Chan wrote:
> On Mon, Apr 7, 2025 at 9:23 AM Ido Schimmel <idosch@idosch.org> wrote:
> >
> > To be clear, this is what I'm suggesting [1] and it doesn't involve
> > setting args->req.epl_len to zero, so I'm not sure what was tested.
> >
> > Basically, setting maximum length of read or write to 128 bytes as the
> > kernel does not currently support auto paging (even if the transceiver
> > module does) and will not try to perform cross-page reads or writes.
> 
> Ido, do you want to post your patch formally?  Damodharam has tested
> it and he is providing his:
> 
> Tested-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> 
> I'll drop this patch and repost patch #1 only.  Thanks.

OK, as you wish. I figured you would just incorporate the change into
v2, but I can post the patch myself.

