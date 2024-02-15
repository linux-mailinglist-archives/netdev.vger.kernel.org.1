Return-Path: <netdev+bounces-72067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C625C8566F6
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 16:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D252899E9
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 15:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E05132499;
	Thu, 15 Feb 2024 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="kK4lOiEy"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FBF13248B
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009860; cv=none; b=tdFKZilJb1M7FKMlQZg9gkchBc2sqmaGSaQWPCFAWNs0smRCBsAloEheEEUHzoLzvGomDoQgUGHH7SjOeWFJMP7tItB2gdK6BknSKtSjx1WHm9wL1J3AIxrkjnd4JKPrQm4oQAajxJK9pmbY5en3v4jGcKOGa8rB0IT6d/pJ6XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009860; c=relaxed/simple;
	bh=cp2eUH5egMxj0cEFqB6tsXn6DbEGcgeQmtehEa59y2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NlbTzkL4cQz5eLJvA7Kbejl3cd9apGFFq7KA9zJauUw6KeKv0RhsUjBWzvCg2oDIeE0t6EUrc7kKBMwkzHqOQZQqk6YcOTAKhg43S/cL3l976JAWT/ficoPZFhNmAatsR1cjBkTjrnX/EDk2ThnqsLHxyFDpQwz2rRXQ0VBARV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=kK4lOiEy; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202402151510464271b5342c41b25c45
        for <netdev@vger.kernel.org>;
        Thu, 15 Feb 2024 16:10:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=e+mQxWuLTkUKp413+j0vTtl6jufruL+g0RwpCcEiRxg=;
 b=kK4lOiEyWhtqmbAtFtM9XtD48wNH1g1CPHCnv/zBKMhgdMRR4zhulp+e6OS13KZPNJLxS9
 lAjeVBzjxVug7dra59NNfNC1ndqaDuCAYzBri4VX/ZgkdJJ/CMuBzihAdyNnHUidrdYkJgla
 /c/Nve+Jz9iblvAoNuiGFyM0GZxoM=;
Message-ID: <c143cfbf-c474-42b8-adbb-13676e177d34@siemens.com>
Date: Thu, 15 Feb 2024 15:10:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: ti: icssg-prueth: Remove duplicate cleanup calls
 in emac_ndo_stop()
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, vigneshr@ti.com,
 jan.kiszka@siemens.com, dan.carpenter@linaro.org, robh@kernel.org,
 grygorii.strashko@ti.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 diogo.ivo@siemens.com
References: <20240206152052.98217-1-diogo.ivo@siemens.com>
 <ce2c5ee0-3bed-490e-ac57-58e849ec1eee@siemens.com>
 <3279544c-fbe9-446c-9218-4d2c59f30905@lunn.ch>
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <3279544c-fbe9-446c-9218-4d2c59f30905@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer


On 2/15/24 14:53, Andrew Lunn wrote:
>> Hello,
>>
>> Gentle ping on this patch.
> Gentle ping's don't work for netdev. Merging patches is pretty much
> driver by patchwork, so it is good to look there and see the state of
> the patch.
>
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Fnetdevbpf%2Fpatch%2F20240206152052.98217-1-diogo.ivo%40siemens.com%2F&data=05%7C02%7Cdiogo.ivo%40siemens.com%7Cc6a5a844ef59437e85f308dc2e35cb4b%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638436055786669669%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=CMjL%2Bkc9%2BOo0igLSnX4OzgxO3CGKP2m67afScU0pG0I%3D&reserved=0
>
> This is marked as Changes Requested.
>
> Looking at the discussion, it seemed to conclude this is a cleanup,
> not a fix. Hence the two Fixes: probably want removing.
>
> Please repost with them removed, and the Reviewed-by's added.
>
> You should also set the patch subject to include [net-next] to
> indicate which tree this patch is for:
>
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Flatest%2Fprocess%2Fmaintainer-netdev.html%23netdev-faq&data=05%7C02%7Cdiogo.ivo%40siemens.com%7Cc6a5a844ef59437e85f308dc2e35cb4b%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C638436055786678320%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=ZS2Gn%2F9kqM7UKL9VD8mSCXeegsx%2BXI6jvgW30XoqQ2M%3D&reserved=0
>
>         Andrew

Ok, thank you for the clarification!

I'll prepare the patch as requested.


Thanks,

Diogo


