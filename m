Return-Path: <netdev+bounces-245822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B51DFCD89ED
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 10:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B322300F8BF
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 09:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680BC329388;
	Tue, 23 Dec 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M3wUFad0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D8D23BCEE;
	Tue, 23 Dec 2025 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766483019; cv=none; b=bRziarNqzkP3ssifcGponGMgUEl0AzQngEP527W6zRqn1/SgbGVibn6u7pYXny3Ig2ZFinjqJHyOCIyty59MlSsCBkzAQx5u2wGAe3xhfjqaceoqvwccf8CGuEimqF8cO4F4H3uCZpmJZFJOfljJm8YomJ34tvb6QkweNhMZxB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766483019; c=relaxed/simple;
	bh=kyl5NSEdly2GP3pVasBEtWZUIw81dqMJBeRVW17lQr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohtzTXUME6DiLBZicavVJQKCLHmSPlOTrFl24Qo1iON0yJ8BIgNcYZknotOnCfyd+nneGHlKhmd32C4xpaXBN49j+AajReXl/8+PgZ+j+trsI8QBj/oQ8PU+IdIROgvKpK1M5T4o5k3CFLsttrwGy8N8jL1XpHMLVr/SoZJgCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M3wUFad0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3CU8RetBKiuYiU/km/7R2UHDh5rdZzaoEvY6kgZIpPg=; b=M3wUFad0PCWURDoMiBA/eVoMKS
	WsyxeixxjE8N3wpyUuffIXQfzCcdQQ+lHOLW0Z7d081gsljFSmPvZZa1SFIwS/mBNTqZ8yMgEMCdB
	IzsUiuOW6AgbrKv2qgdiJbB2jlzGkNVnYS8mqQ59iDpruN4RttnrtQSYqt4FkU0Xkm7g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vXyvP-000HY9-UW; Tue, 23 Dec 2025 10:43:27 +0100
Date: Tue, 23 Dec 2025 10:43:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dlink: mask rx_coalesce/rx_timeout before
 writing RxDMAIntCtrl
Message-ID: <ca3335ea-b9cd-4158-91a3-758cba9df804@lunn.ch>
References: <20251223001006.17285-1-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223001006.17285-1-yyyynoom@gmail.com>

On Tue, Dec 23, 2025 at 09:10:06AM +0900, Yeounsu Moon wrote:
> RxDMAIntCtrl encodes rx_coalesce in the low 16 bits
> and rx_timeout in the high 16 bits. If either value exceeds
> the field width, the current code may truncate the value and/or
> corrupt adjacent bits when programming the register.
> 
> Mask both values to 16 bits and cast to u32 before shifting
> so only the intended fields are written.

It would be better to do range checks in rio_probe1() and call
netdev_err() and return -EINVAL?

Anybody trying to use very large values then gets an error message
rather than it working, but not as expected.

	Andrew

