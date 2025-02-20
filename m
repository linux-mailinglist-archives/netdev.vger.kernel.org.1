Return-Path: <netdev+bounces-168276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F145A3E580
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 21:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32ED3175714
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 20:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A76214218;
	Thu, 20 Feb 2025 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="En7pk8j6"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533591E570E
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081751; cv=none; b=SbMPQvpUgaWuxOwA7D9NdPUV6oAgHQZmt+maNW0Y/oBRbBf+1agWvoQ1O6kmSNbmtedA2mezG6ceI8Dvqi6ZIO1hBV/xSw30wohuOJKpuf1N4OiDEPR0ZzEPIu9Cd58L3ZfRvRtb5/Q46UMcQKDtN0Q9Kz4Cz6a765Kg13SeKBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081751; c=relaxed/simple;
	bh=hpILy+3+EU9ILSRAJ3KXzhjnj5YTgS1SMPd2/RuJ1C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jl2gTg3OLyYaaqGSPUU6fepf4hFhWGufl4KKhz0HqTfltgboXK1qWE58zezNvYq0/b8j8Kk2xZ0WicY6CYubfXan6F/qaC9W+qctO5djgRY8TAXNpHMua8jAE71vegWQO3gBzGc6ybUxgNF0JDg1VM0cxKTKYTeCfPPNNY7puzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=En7pk8j6; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <df9e0dea-bfcf-4199-ac26-55f04f72ae2c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740081747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJHYVCQd+aLBIct9NdfukVqf0I+4+iDHWBrkMmpXD+0=;
	b=En7pk8j6vchSYynsCz703qLWmShixhf/3qpU4gNqqTP9ub+LcmiiKhr7qJUXOrY4M8p9GL
	vWh/FAcAEi2m+dznF7xroyHhD++Q8DrFsThhAvXjYSvClkfmmaA8uobXd+qTD6riy2rsXF
	qGqx0sf0fHOQcvHp9KDBYutz0N7zGuo=
Date: Thu, 20 Feb 2025 15:02:23 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: cadence: macb: Synchronize stats calculations
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
References: <20250218195036.37137-1-sean.anderson@linux.dev>
 <20250219094851.0419759f@2a02-8440-d103-5c0b-874f-3af8-c06f-cd89.rev.sfr.net>
 <451aca38-3b58-46c8-b6ce-6460f0504314@linux.dev>
 <32f5cc19-e4e6-4750-9942-e57126b0bad7@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <32f5cc19-e4e6-4750-9942-e57126b0bad7@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/20/25 14:48, Andrew Lunn wrote:
>> Yeah, looks like I missed this. Although I tested on a kernel with
>> lockdep enabled, and I thought that was supposed to catch this sort of
>> thing. Will send a v2.
> 
> It might be you need the sleep in atomic option, not lockdep. Better
> still, just enable them all :-)
> 
> 	Andrew

I think the issue was that the lock is only taken in an error path and I
didn't trigger it during my testing. So lockdep never saw that this lock
could be taken in an interrupt.

--Sean

