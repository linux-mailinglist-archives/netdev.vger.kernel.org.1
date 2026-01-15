Return-Path: <netdev+bounces-250184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E29BD24927
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 13:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92BAC30C9E75
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EE9394473;
	Thu, 15 Jan 2026 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hkpLqDSq"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4E718DB01
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480298; cv=none; b=Afkx9ric4LdW1j94uk0ODZ7lfIx8dyt51hdYYCBnQ+s+WbR7ryAzLz9GWy0VsNI2hG6sWN9WIK4/mafu4PeH6H6a5v8/31g3Ro6pGljiWsfKNTJh+B7eA+7gN+8sl0YaLX/YpujuxOR+AzocVnDZnqcQCYSEGDogUFdk05HVaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480298; c=relaxed/simple;
	bh=iWRr1IbTjdrMOyK8HbQJ38WOEF5iGghTXvLQUmBJoe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EofryYi7dVobPY//0NXLq0MhkAzV2AzO1izPQafxw4hTX7w0zOgS5fobSOZbzWo8fX2xpMqaimVQG20610xKfu6unBSocZelVesAeQ/vT0W9Il8s2shI44B25oEl4/ZcZXE+6SAhIDl7QikYPRk5eA9zXk7/KBQCYF/w/DqkofI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hkpLqDSq; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c548e847-ec4a-4aeb-99c0-c48342a21a11@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768480294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXYbi4jjWeT6ITpty2L/OMrvhreUneAGlfUb7ET8lXY=;
	b=hkpLqDSqzfUE0QO57bw2slPOZnksrVcB65nwaQPORurnU81L1e6TJFr1deGE3ZHSCIjERS
	p98NDO1QMBquIM7At+n6sa0OThNr2uB0gQKe5erAy9ToS9gIECUYh788bb458NqZdBfDYC
	ucw+kyofY2FUyBOKQd3CKD875n3gpAM=
Date: Thu, 15 Jan 2026 12:31:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] net: remove legacy way to get/set HW
 timestamp config
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org
References: <20260114224414.1225788-1-vadim.fedorenko@linux.dev>
 <20260115125815.299accc6@kmaincent-XPS-13-7390>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260115125815.299accc6@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/01/2026 11:58, Kory Maincent wrote:
> On Wed, 14 Jan 2026 22:44:13 +0000
> Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
> 
>> With all drivers converted to use ndo_hwstamp callbacks the legacy way
>> can be removed, marking ioctl interface as deprecated.
> 
> Thanks for all this work converting drivers to ndo_hwtstamp!
> 
> Maybe you can also remove this:
> https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/infiniband/ulp/ipoib/ipoib_main.c#L1834

Hmm... looks like left-over from the drivers cleaning part. I'll remove
it in next version.

> 
> And in the driver development part of the documentation to avoid any new driver
> with it:
> https://elixir.bootlin.com/linux/v6.19-rc5/source/Documentation/networking/timestamping.rst#L630

Good point, I'll adjust it in v2!

Thanks!

> 
> Regards,


