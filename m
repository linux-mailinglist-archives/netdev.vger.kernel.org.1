Return-Path: <netdev+bounces-194251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D8CAC8088
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 17:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23AE4E1C6A
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 15:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FE622D4E7;
	Thu, 29 May 2025 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a9UskaOp"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465511D86C6
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748534013; cv=none; b=kdNVoy+Ar2KE/MEapLqa1qJcRkbXnkGUSTpS7iqtz2N+0CNqv4AhFhPtLweiAp7mAHshYh/HwmtNvoKs5VBiT+H4vv2SW67n/+KLtaWl/YNR0fgOYOPGBqqqXME+IV2G9sXXag97cLVmdruZj9W19B2FIAHhn5Ggasko2uzfSmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748534013; c=relaxed/simple;
	bh=l4K4yEbW/d2HTQn70eeGcDu3YI7wM/05AVyn0wYhVfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEFyapZsfDWe5CWUCpoD2QtCAAUAlV3XO/h4UNodK2Y95m7S7GvLZaXtIgMjpb9dzoWRzcRzL8cp8qzGcq7oTFl1wgiSaNILvHgv0ExjsA2ldp/0MQug3a/aiemQ6ctbUWA37aho8oM6sbUmC5kSlJCY+IQrrD0qRNzWenn3w60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a9UskaOp; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 494BE1140170;
	Thu, 29 May 2025 11:53:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 29 May 2025 11:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748534011; x=1748620411; bh=MbPsqhSUi4x2OvK7DgwCKz3vLCcEcC6CJE0
	Rv1XIDZI=; b=a9UskaOpv/mImmRky3oXJj5S07PhY2RRvwZ6w/mOspm8znNPfHQ
	Ma9Z4IfeHW63Fn9tBLGZNcTtvK2joPPx4/OJcQ28HrL0dBkwTTJK5JY0WZVKAfXT
	AziobU4kjhZW/1I5JPN5fVXrL5soILhAL+ro61158HrFrpRUfwVSlO5wpBUgXAfR
	E13bQp3bA0oRNTY+rKfFgsfMpbyPAc0mLH7H+hT//4VtHNprmCW8pPZEHD9TSZEF
	sYz3fduPh1Y7zEHXucu3Ymz84M5HOabEmAoodb7X4xsyi0u8mAmEFT/TcLsFdzKW
	RQbgsnKBrqOiZA92egCPVHOKU/aisNEUr7g==
X-ME-Sender: <xms:-oI4aIrgqfH6q32CLOLlkpjiILoA-bzt-WBPaOBex3QbZu_T_3F9Kw>
    <xme:-oI4aOqyPngmjfxBKZu9PRaEYsuzPFnulx9pzahHv0KvMbWEiE50pqJMIDgZ-H9cS
    yzPLKMuAlM8lEw>
X-ME-Received: <xmr:-oI4aNPBiFqKm66X48qTZn9shrS1JmwCpc7tFrA4af06JK9iKVIQo5puWccF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvieehgeculddtuddrgeefvddrtd
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
X-ME-Proxy: <xmx:-oI4aP6ExVc07VgD-zyL1Iso2s1Y13ZNDnGshKGkN2qZzlpIrdLhiQ>
    <xmx:-oI4aH6YAe-eVUUM4yePgBD22WfwHGJSmuTpaMZq8Pn5xGx2KwuwUQ>
    <xmx:-oI4aPi9vYv53QNlqXd53GE7Y5ikUyQAiJiYD0tdrwEBHaqNEhxIyw>
    <xmx:-oI4aB5EtJsx3Cr8wFkFVakiFqaz05vpFU1LcFjtVgcBrL-n4Io3KQ>
    <xmx:-4I4aHlodvzD7irzmLrqq9MfJb0B2vpluTlZyW2xbVvmjw-tbaIqnyV4>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 11:53:29 -0400 (EDT)
Date: Thu, 29 May 2025 18:53:27 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: mkubecek@suse.cz, danieller@nvidia.com, netdev@vger.kernel.org
Subject: Re: [PATCH ethtool 2/2] module_common: print loss / fault signals as
 bool
Message-ID: <aDiC9_sW5VArKBBi@shredder>
References: <20250529142033.2308815-1-kuba@kernel.org>
 <20250529142033.2308815-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529142033.2308815-3-kuba@kernel.org>

On Thu, May 29, 2025 at 07:20:33AM -0700, Jakub Kicinski wrote:
> JSON output is supposed to be easy to parse. We currently
> output "Yes" / "No" for the per-lane signal loss / fault.
> This forces user space to do string matching. Print bool.
> 
> Before:
>   "rx_loss_of_signal": ["No", "No", "No", "No"],
> 
> After:
>   "rx_loss_of_signal": [false, false, false, false],
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

