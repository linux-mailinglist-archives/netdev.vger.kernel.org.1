Return-Path: <netdev+bounces-194250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76048AC8087
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 17:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECEAD1BC3AD9
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 15:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5B31D63E1;
	Thu, 29 May 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m3bOh6Yr"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501CB22D4E7
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748533988; cv=none; b=HFZZws2kxpMJCuIb5wzG4rSJcQapHh6Rj2sIqN2YGkCYA7H1OIIg6F3QwWp+bf3Tg5Qim2s+LZT0mnJTYJJkLWDJt5jsfwvzmJwBt3dMuxgr8wPXXmOAI87LO2mkJ+GssxOTpQ4ZIcCukGsDJbkmMv1m8uf+7wcVYKYYTLwME7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748533988; c=relaxed/simple;
	bh=5NBNUD8Yuoq8lxj/n4qt71xK6wDjxPIEP+J+WXOYk50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqfZeT4c9f3H7abJhdI86ZsG8UwOhZreM6NeVX0vkx6m+0MDc/FJioB2ualll66V4QxHhptpeGI5+AgsPC0FFyTmieFb4SREQgVRGGDTJ/id0pe49up735U7DKUQZcDuFxGJgZ5dtnFlv51ZoyO+Jc4vIHQjhF9wOYIRa2M+gX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m3bOh6Yr; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 67FAE114015D;
	Thu, 29 May 2025 11:53:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 29 May 2025 11:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748533985; x=1748620385; bh=YlNk9d5xPdKQnWaorT1Jwz0iCHGgQam8U8C
	fiBJHEGc=; b=m3bOh6Yrg0G1zfH1VtRxnbzIoY7DTRuhhsUAejoivniNif1/njI
	A9CpTqDFj0xnUpRIYfzyEXGP2uHTQxoBxXKWLvysMSo0HIcJbrKMDE0XCV6ReTRb
	GTRCRTq4zAxHm7dWughjwhiRrgaoc5rP/qRdyvqmxYq6SeXdCcleCNcswuJyfes4
	8mCVvQhZCIRUYmF1OMZ70hNzQU/ni1OtkFIc+V/KG93bn48LKxVpqUxd23MbGRf/
	8NYrMgWgihFUmE1MPyFajSk9PRB1PtGH6q5Pu7u31Uoec750L7krCBHYjzp+6z10
	nl89f6GJ4GNatWC5bmiBfz9EVaWmtAyVhlg==
X-ME-Sender: <xms:4II4aHMwipX4STIEkxcciksn3dl1zJui4AdmcXWThoe4zJmRCUnWCQ>
    <xme:4II4aB8PWH8y70KnIUkt5lI0KfbAvGuZaXFu63x-5o1E1HtiXs0Pmf_cLMgL9NBm9
    r8CKU12Nvbqiwg>
X-ME-Received: <xmr:4II4aGSiCCBzT13-5A2sqxUwPht90Xx2q7V_LolS3mDfMaj_v7JcgpGEK03h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvieehfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhep
    kfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeel
    geejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepgedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmkhhusggvtggvkhesshhushgvrdgtiidprhgtphhtthhopegurghnihgv
    lhhlvghrsehnvhhiughirgdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4II4aLtophac_r8P6IHPeGvCCkCquhwkKIDvYkW8h7YcQdRJMVJu_w>
    <xmx:4II4aPddmhlPw-SEvGs6P3SJZ-pzXB3tQL1kxODwm0YJAIvTE_CvuA>
    <xmx:4II4aH2IwOk52wXGL3YHli3K1UbrSnIogM4knx_AY4LaKmmU-Hw14w>
    <xmx:4II4aL_8cy0BxMGVJ2H8DKXjw48LgIbeLZBtKc2m8-GEM55A7PtiJQ>
    <xmx:4YI4aF6Ic_sZcxacxYrLC5DXNrwchH8HMit4g6z7ZsruezLhvwWFo5br>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 11:53:04 -0400 (EDT)
Date: Thu, 29 May 2025 18:53:01 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: mkubecek@suse.cz, danieller@nvidia.com, netdev@vger.kernel.org
Subject: Re: [PATCH ethtool 1/2] module_common: always print per-lane status
 in JSON
Message-ID: <aDiC3ZTHzSwZGCXl@shredder>
References: <20250529142033.2308815-1-kuba@kernel.org>
 <20250529142033.2308815-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529142033.2308815-2-kuba@kernel.org>

On Thu, May 29, 2025 at 07:20:32AM -0700, Jakub Kicinski wrote:
> The JSON output type changes when loss of signal / fault is
> detected. When there is no problem we print single bool, eg:
> 
>   "rx_loss_of_signal": false,
> 
> but when there's a problem we print an array:
> 
>   "rx_loss_of_signal": ["No", "Yes", "No", "No"],
> 
> This appears to be a mirror of the human-readable output,
> but it's a pain to parse / unmarshall for user space.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

