Return-Path: <netdev+bounces-108024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F34791D93B
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E411F222BC
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 07:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AE775804;
	Mon,  1 Jul 2024 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PIZyo4Qt"
X-Original-To: netdev@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AAE482D8
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819728; cv=none; b=u+5FDp1MVhLdAZ5B5/fYlfHvGPa6noa6JOqFr0VizpJtLGzHL5laUlRKVYqjbRpuDNctigDjuQuf+qOO5XftgYDjrIXtyJpU/j7dismmvNeI03svWyCT7sa7KGt/CvMVoQs+znKyOP7R8A52zcaHHwn5sBfPYNjc62uK8ZNM6UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819728; c=relaxed/simple;
	bh=jJiuy+2Khia8yVvrGLVxKfCqiNvKzjUk/Ps11Bjfz54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zr9Kz1Hm4FuFfrfKhG1UI5vwWNfFJnK/S7twHOvIwqC8g+QkxBr/7L4xzAS/ELGWuyI2oBzG2TSK3mM9YunxejTA/hG0ZS0ok+4hhPTKsUqIyNqxkKPJS2vWDKLzm6utS0VOD7h8YsE9M9qW6sPiUbcKYH+q51Ej5f87PxYcRlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PIZyo4Qt; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5C85213801CA;
	Mon,  1 Jul 2024 03:42:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 01 Jul 2024 03:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719819725; x=
	1719906125; bh=caTIaH05O6FzS7OrDxczDxv9X1QIt4l3mxym03RS1Vg=; b=P
	IZyo4Qtbd5vnayjMPljc/T0c6I6sihtGkLBN/gQVE+jMCJRfgKaVKAASqgQ/H2g8
	CtId8PZU1VamxIP0D1xD/Zkoq9VgIfl2YvnvLm9g4Xc9GjnXDnI79AQ7XaYam0Ym
	EvnkwYSkRnDZ/GJ6JkaPBtVv/YJlhaOl/I3V0yvz5WqXB/JmflN5h0n/QRBPj/5q
	7lYcGmS5JtxvOgC01ovPJOOhZjOA/Rue0opZfgy+0AR77e5NAT5EtewSYmBGAYNP
	oyQ7KpCIEF4qBpEenG+PBlo8C312Gx7hOiWAZvhwBjbbKEi4ifXXgK6bMuOo4W0x
	osEq4nJTzDg4C7f1A5u3Q==
X-ME-Sender: <xms:zF2CZnHL_1feIhtwDkzEhKsGOT9X4l-2C6J7HfhUQJGBzA6IFJoOFw>
    <xme:zF2CZkVB0xpYglXRkkok8FbthCLEczYcyQK4TLin736ItHEbXFuktIonjwJu7nETZ
    q-J0kGGZ5tHGGg>
X-ME-Received: <xmr:zF2CZpIgkzGVNgLZIF2rA9HgbrXJX0ndgwJnYI3rCalUnU4PMFVaVsPlQXzG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpeduledvjeejhefgvdetheefheetjeejfeetjeevieejgfeujeffleffgeek
    ffeuieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhr
    gh
X-ME-Proxy: <xmx:zF2CZlF2YzLze2idltd-6ppbcwD6HlC9L-rWcFfMw94qgFT1NF3kgw>
    <xmx:zF2CZtXqlV0IhhuzXObJDEB5WYlfHmDRsA5Z8tOiYNO12oj55pPmRQ>
    <xmx:zF2CZgP3Ej0H3Cg-oqjY6_3NFtBD-ZZpzS23fWMqiOLQf9QQWq0XFA>
    <xmx:zF2CZs1vYc7S0WAjPV65vshrJdzVYyYtAPGPp-4jXufLYEODzkpAOA>
    <xmx:zV2CZgQa9ByAXlnxaJUeJHweZf8jQ4UIoKQKJ4ivmkeUn2s6kpKKE_En>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jul 2024 03:42:04 -0400 (EDT)
Date: Mon, 1 Jul 2024 10:41:58 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Dan Merillat <git@dan.merillat.org>, ole@ans.pl
Cc: Michal Kubecek <mkubecek@suse.cz>, netdev <netdev@vger.kernel.org>
Subject: Re: ethtool fails to read some QSFP+ modules.
Message-ID: <ZoJdxmZ1HvmARmB1@shredder.mtl.com>
References: <54b537c6-aca4-45be-9df0-53c80a046930@dan.merillat.org>
 <ZoJaoLq3sYQcsbDb@shredder.mtl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZoJaoLq3sYQcsbDb@shredder.mtl.com>

Forgot to add Krzysztof :p

On Mon, Jul 01, 2024 at 10:28:39AM +0300, Ido Schimmel wrote:
> On Sun, Jun 30, 2024 at 01:27:07PM -0400, Dan Merillat wrote:
> > 
> > I was testing an older Kaiam XQX2502 40G-LR4 and ethtool -m failed with netlink error.  It's treating a failure to read
> > the optional page3 data as a hard failure.
> > 
> > This patch allows ethtool to read qsfp modules that don't implement the voltage/temperature alarm data.
> 
> Thanks for the report and the patch. Krzysztof Olędzki reported the same
> issue earlier this year:
> https://lore.kernel.org/netdev/9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl/
> 
> Krzysztof, are you going to submit the ethtool and mlx4 patches?
> 
> > From 3144fbfc08fbfb90ecda4848fc9356bde8933d4a Mon Sep 17 00:00:00 2001
> > From: Dan Merillat <git@dan.eginity.com>
> > Date: Sun, 30 Jun 2024 13:11:51 -0400
> > Subject: [PATCH] Some qsfp modules do not support page 3
> > 
> > Tested on an older Kaiam XQX2502 40G-LR4 module.
> > ethtool -m aborts with netlink error due to page 3
> > not existing on the module. Ignore the error and
> > leave map->page_03h NULL.
> 
> User space only tries to read this page because the module advertised it
> as supported. It is more likely that the NIC driver does not return all
> the pages. Which driver is it?

