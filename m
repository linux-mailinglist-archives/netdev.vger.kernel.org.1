Return-Path: <netdev+bounces-105884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E6C9135CE
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 21:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9633028472D
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 19:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361173CF74;
	Sat, 22 Jun 2024 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZEA1jYz7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88321374DD;
	Sat, 22 Jun 2024 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719083687; cv=none; b=pjkEwLkWIAEKe8vYJLYtaGJDOGo1/fZgB5JvUYrXtPjxJTZgKlsOZUGGC9IPIOSGcap3cvctp2iHaMrVQyDbXTQjffg0kz+yc8Bv1zHT36auMkfgIz+xiErE+1un5jnf+znSgsF7QLFIMexGvOXQPBZ/Yg0dbnMJmhp7QnMZERI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719083687; c=relaxed/simple;
	bh=+JqTdA8wvpQSv5/F2nqxbN/ClKq6Im2toILPCPSST90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ9ETPj6A2P3dMScd3LcaKI61BOnxr+hg5Cd0t9X9Yaydcs/ohNsM2qvzdK+d2+eHWCT1QczJv5lO3sP3p4TBTjC5t/NQbOcpp6kCK3pLQ3DsRd92i6HzgVcoc1KFxK/PELCdrjflSuyCJaNg1zdiFu80vikjYHZwJ3bHHRjo/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZEA1jYz7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bl2UDFgJifu/epzrwQQ13v/3jSYdeUOAeSznWfWh2RM=; b=ZEA1jYz76cr8UalFb1d0WdgkLN
	ROFvySG26WggUZlU45zfMQoZur+jdVfnZhYkUX08XaAd0D2VIAOuE6pZp4FwDIFLjl/QbExBPE8AA
	agw45Se0V/L4ET6Aup0IRNeNI3J9b5J07pJqoZrO5yFYyX007jPi1k8cGXTzL4n3mMrU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL6C0-000kOI-AK; Sat, 22 Jun 2024 21:14:32 +0200
Date: Sat, 22 Jun 2024 21:14:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH net-next v7 1/4] net: macb: queue tie-off or disable
 during WOL suspend
Message-ID: <6a9bdad3-ed97-4409-8c47-1a8339036ade@lunn.ch>
References: <20240621045735.3031357-1-vineeth.karumanchi@amd.com>
 <20240621045735.3031357-2-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621045735.3031357-2-vineeth.karumanchi@amd.com>

On Fri, Jun 21, 2024 at 10:27:32AM +0530, Vineeth Karumanchi wrote:
> When GEM is used as a wake device, it is not mandatory for the RX DMA
> to be active. The RX engine in IP only needs to receive and identify
> a wake packet through an interrupt. The wake packet is of no further
> significance; hence, it is not required to be copied into memory.
> By disabling RX DMA during suspend, we can avoid unnecessary DMA
> processing of any incoming traffic.
> 
> During suspend, perform either of the below operations:
> 
> - tie-off/dummy descriptor: Disable unused queues by connecting
>   them to a looped descriptor chain without free slots.
> 
> - queue disable: The newer IP version allows disabling individual queues.
> 
> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

