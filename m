Return-Path: <netdev+bounces-106779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 435EE9179AB
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938C71F23726
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 07:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DD3158A31;
	Wed, 26 Jun 2024 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="pEYm4i1Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0CB45978
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719386905; cv=none; b=Z9xXhkXIfoDi+Q+zBA8s2FHsijbHQtIF3lcou1YIHt7JbOa8lwyZ3O87ML/b/xnMBYfj+nv5eypzP2i29Gcq2SrGhVUgsLc4xRwhd1+PoYUXHm43GHn9wnjGof+K91XdkYcQiyrHnr3PPF5SCRrFcAWsDTDRlWGf7qNuZlsRCag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719386905; c=relaxed/simple;
	bh=RJ8nRPmMkXe9BI9/i2Yx1xqW65MxSnPm9qEXmIGKnQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjP5UCzoo2jfKzTvpbjqUPDMJ29f1I/SEuKbn4Vnd4lKPq60KxKXvjM+1apRHdnxPpJvG+h0wLftyg6aCM1rvMq/+YrxkoHK3h4oN3QZHjx25rsaY+xdb5A0kBtLfE9q2XAhRyCOOqOMnVwthPPWd4PO7n0h/eCMQ+TAM5T9mXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=pEYm4i1Y; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 171C29C59B0;
	Wed, 26 Jun 2024 03:28:20 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id lvDqkKGU-Hni; Wed, 26 Jun 2024 03:28:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 840AF9C5B50;
	Wed, 26 Jun 2024 03:28:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 840AF9C5B50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1719386899; bh=6GjU8ScEUczDrWt6QRBcmH7qEUS35pffwwR9OixIp0E=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=pEYm4i1YnK3IQirgrz8oKQtY16wfdwvv4BFvAytEOpOh+0MZhniFqo64RLcXu5Ige
	 stZq+oc9f1HPWs0Oug4XyRX9e1p5bUehTbbbvR32G9XX4MVsKJmuqAS+rggXoqgQY/
	 r5ZWwvGqhy1Dqle4BoFCXdO/Qev7kMGOKj8tkPs2VuiybXYW+B5lT00LeqqgGRTHKp
	 6Jti0yN6EAKb5yYg4EmHoQOTRZmgZBpuHFKPknr11SO8a0g1K3/tJkqbby5dbHZD/3
	 1riitscAnYZal8gxtB6nM3PDXXly9xVvIXFSIKrZnlXwgUU/sAOc8s8VJYrxZrJ8Om
	 rWZgC1jJQmCIA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id NaK_jYRx7eZQ; Wed, 26 Jun 2024 03:28:19 -0400 (EDT)
Received: from [192.168.216.123] (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 470CF9C59B0;
	Wed, 26 Jun 2024 03:28:18 -0400 (EDT)
Message-ID: <df1d8095-93ad-4b79-a614-321df475b64c@savoirfairelinux.com>
Date: Wed, 26 Jun 2024 09:28:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v8 0/3] Handle new Microchip KSZ 9897 Errata
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, horms@kernel.org, Tristram.Ha@microchip.com,
 Arun.Ramadoss@microchip.com
References: <20240625160520.358945-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240625184712.710a4337@kernel.org>
Content-Language: en-US
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20240625184712.710a4337@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ok, I can do an extra commit then?

On 26/06/2024 03:47, Jakub Kicinski wrote:
> On Tue, 25 Jun 2024 16:05:17 +0000 Enguerrand de Ribaucourt wrote:
>> v8:
>>   - split monitoring function in two to fit into 80 columns
>> v7: https://lore.kernel.org/netdev/20240621144322.545908-1-enguerrand.de-ribaucourt@savoirfairelinux.com/
> 
> too late, v7 has been applied:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=4ae2c67840a0a3c88cd71fc3013f958d60f7e50c
> 
> :(

-- 
Savoir-faire Linux
Enguerrand de Ribaucourt

