Return-Path: <netdev+bounces-99731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AED8D61F4
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 14:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05561F2677C
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FB3158D85;
	Fri, 31 May 2024 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="40hxvKXr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29A1158A37;
	Fri, 31 May 2024 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717159055; cv=none; b=Xf5LbFQQODuweGdbI7RE/j2eqDZoIW7qIqH25m7bvBA8F//zJN7M0D5Lwd0RwSO/+2OTPUtpuPS3RFoV7i2VQyYMrkaa2HHvRmqxlBDlpTdxC3JVFPmeUpS7PnIIyUqaZRPuAX/fLNYbLr2OtIgWvxmaXivHZB11kDvQ0hVAy5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717159055; c=relaxed/simple;
	bh=lw5lxYGG7QNyW/AQo8G8xHIGJcPJU+mNS8IZY8Z1Elo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIUN6eCmdocWWFePWz9dHBq6aXMcje6AJKWnz7tBnxt734RzDa6orK+csTMkML5G4N/AA6w3XTVLnqClwCBqr1R8QSbyBzr2FjDiKi2rDRiNTjvVk73No8ppYyMiyOJunAynuxZWcHSiGdmZ/cw0qEMzXgBIbzZzWd98OULz5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=40hxvKXr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NwrTE5NFFBVwImdPHTY4kClZsQLoC7dc/JgAoHbMaR4=; b=40hxvKXrPYqzM6vIvfhc/ZzHk1
	mpwPa/03mAu5dvWheuv3XnXeqokKCA3S1HKVHiBMVU1obW6dcLSReHztaUBLyM7cHlKTSP1FsGFOk
	ADUbeWgy4N1/+6CztKY/FGVtX3pSP9diX/G5qurf5++x8DYnoqTls8m2bPIKca/SrOl4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sD1VS-00GStD-49; Fri, 31 May 2024 14:37:14 +0200
Date: Fri, 31 May 2024 14:37:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch, Viliam.Vozar@onsemi.com,
	Arndt.Schuebel@onsemi.com
Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Message-ID: <585d7709-bcee-4a0e-9879-612bf798ed45@lunn.ch>
References: <6ba7e1c8-5f89-4a0e-931f-3c117ccc7558@lunn.ch>
 <8b9f8c10-e6bf-47df-ad83-eaf2590d8625@microchip.com>
 <44cd0dc2-4b37-4e2f-be47-85f4c0e9f69c@lunn.ch>
 <b941aefd-dbc5-48ea-b9f4-30611354384d@microchip.com>
 <BYAPR02MB5958A4D667D13071E023B18F83F52@BYAPR02MB5958.namprd02.prod.outlook.com>
 <6e4c8336-2783-45dd-b907-6b31cf0dae6c@lunn.ch>
 <BY5PR02MB6786619C0A0FCB2BEDC2F90D9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
 <0581b64a-dd7a-43d7-83f7-657ae93cefe5@lunn.ch>
 <BY5PR02MB6786FC4808B2947CA03977429DF32@BY5PR02MB6786.namprd02.prod.outlook.com>
 <39a62649-813a-426c-a2a6-4991e66de36e@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39a62649-813a-426c-a2a6-4991e66de36e@microchip.com>

> So I would request all of you to give your comments on the existing 
> implementation in the patch series to improve better. Once this version 
> is mainlined we will discuss further to implement further features 
> supported. I feel the current discussion doesn't have any impact on the 
> existing implementation which supports basic 10Base-T1S Ethernet 
> communication.

Agreed. Lets focus on what we have now.

https://patchwork.kernel.org/project/netdevbpf/patch/20240418125648.372526-2-Parthiban.Veerasooran@microchip.com/

Version 4 failed to apply. So we are missing all the CI tests. We need
a v5 which cleanly applies to net-next in order for those tests to
run.

I think we should disable vendor interrupts by default, since we
currently have no way to handle them.

I had a quick look at the comments on the patches. I don't think we
have any other big issues not agreed on. So please post a v5 with them
all addressed and we will see what the CI says.

Piergiorgio, if you have any real problems getting basic support for
your device working with this framework, now would be a good time to
raise the problems.

	Andrew

