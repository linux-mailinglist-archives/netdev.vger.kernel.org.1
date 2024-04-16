Return-Path: <netdev+bounces-88436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804E48A7331
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 20:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF7AAB21AD1
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 18:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9279D134CD0;
	Tue, 16 Apr 2024 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0gmwjY3i"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344AA13343F
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291981; cv=none; b=f27QaDPdBkBizzhoAFG8P89mwmDYndarru+eVpAmZpUBzaPCbURZe+h262PUkusPyi5Mbjqg0tS9mgDp0clP+ejEgHTB/Wno7SvrRpca3vszhc253AZjuP+Ex9Z/N/ALI8gzGLGhFYKQTHHeRj1BYS1olEaTu8T0vYWAVpnPnuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291981; c=relaxed/simple;
	bh=R+gJ4azjutbCYyNAVS3TnSa1Oj+6Ii0fxTvdMVY4ysg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YND7SMQ73p03ZRwQ2YSKdgnWxGgQKAK6YJ9PWZ6xMNQ8bIKtCcxMWLPlamQ7VtICvplNr0sqbhAOFhx/F0YW3bewRe98Kg2ZA8/OlDWMnZcaem8aW1ZCk7DW7DO3ZwKuPkKcLASzQ3cRQabuuhWfQ+wzXNDLgd378fOo8iyOAqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0gmwjY3i; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Hsac5LxjBip4NFRgBqxL3G7rwSkkjJU31Nh6XYM1gxg=; b=0gmwjY3i3t4OAfkPXZ4MOgR1RS
	4pefLMrNhFy5AEIZmgB3EVr2jatOYSHe1i5RY92/P1bNXQ7Kr+7OS7X3gGQz1zUBEAJfv0k6LSvXm
	zGmetkfnCGeiZ2LxCSq3/msV7aWMloD+2qGMog3+57sNLi1lwD/jnyjuqIfu8uTqFS2A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwnVV-00DAUB-7r; Tue, 16 Apr 2024 20:26:13 +0200
Date: Tue, 16 Apr 2024 20:26:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	pabeni@redhat.com
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
Message-ID: <0d157a2a-ad6b-4360-8493-6a4530bf089c@lunn.ch>
References: <53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com>
 <CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
 <0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com>
 <CAKgT0UeRWsJ+NiniSKa7Z3Law=QrYZp3giLAigJf7EvuAbjkRA@mail.gmail.com>
 <bf070035-ba9c-d028-1b11-72af8651f979@huawei.com>
 <CAKgT0UccovDVS8-TPXxgGbrTAqpeVHRQuCwf7f2qkfcPaPOA-A@mail.gmail.com>
 <20240415101101.3dd207c4@kernel.org>
 <CAKgT0UcGN3-6R4pt8BQv2hD04oYk48GfFs1O_UGChvrrFT5eCw@mail.gmail.com>
 <008a9e73-16a4-4d45-9559-0df7a08e9855@intel.com>
 <CAKgT0UfyAQaPKApZoV6YJhMPAac3q3KBN4yHdF0j48mKZopsBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UfyAQaPKApZoV6YJhMPAac3q3KBN4yHdF0j48mKZopsBw@mail.gmail.com>

> Sorry that is a bit of my frustration with Yunsheng coming through. He
> has another patch set that mostly just moves my code and made himself
> the maintainer. Admittedly I am a bit annoyed with that. Especially
> since the main drive seems to be to force everything to use that one
> approach and then optimize for his use case for vhost net over all
> others most likely at the expense of everything else.

That is why we ask for benchmarks for "optimization patches". If they
don't actually provide any improvements, or degrade other use cases,
they get rejected.

> That is why I am more than willing to make this an x86_64 only driver
> for now and we can look at expanding out as I get time and get
> equipment to to add support and test for other architectures.

That sounds reasonable to me. But i would allow COMPILE_TEST for other
architectures, just to keep the number of surprises low when you do
have other architectures to test with.

     Andrew

