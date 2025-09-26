Return-Path: <netdev+bounces-226783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6C7BA531C
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346F4381F4E
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C3F283FD9;
	Fri, 26 Sep 2025 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raschen.org header.i=@raschen.org header.b="fxsxgWS+"
X-Original-To: netdev@vger.kernel.org
Received: from www642.your-server.de (www642.your-server.de [188.40.219.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2F25B1D2;
	Fri, 26 Sep 2025 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.219.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758921911; cv=none; b=cFrkok3PfgmVoCSZfiJK9lINa6TX0IKbdhN8TD3xKABjUJRd9LoiYqkV602jP0kMhMLmyOPHWQVMhi9pHY1Kf4axxZiDxd68jozXDVapNGKXVzePbKalWJjZWhDcMMQF6s+2bZe022s6N4YY72BpjtsDwIBQjdRI8f/uBhftYyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758921911; c=relaxed/simple;
	bh=NaC5X2sjyaQPvL0sqQiYAeiwSLLySje4ucMrNBhjjAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLxUCDpnMcySdXL4iImyzXEryEqBfRXEc9qzQo8XqNaQcd1kRd5QUPmCUX0JikmKMG8pfy8vaYdJZJHltJq5CUdSxMdPakgd4Xl2rVnPh7PY5LeerVUtgU+/ROoC9qLRjjPU7foVjn/jkU3F/0Fl1khiu9VWMhUHXKXwBDmES20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raschen.org; spf=pass smtp.mailfrom=raschen.org; dkim=pass (2048-bit key) header.d=raschen.org header.i=@raschen.org header.b=fxsxgWS+; arc=none smtp.client-ip=188.40.219.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raschen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raschen.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=raschen.org
	; s=default2505; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=aSqYwTLw1PpD56Mn6MF5VwYFO4u7LDcD1H8dhtrmyBU=; b=fxsxgWS+EZ1P3Y+FJ6pgurO7O/
	7dEplyh6+mvlOjUUkkPd1HxiY+tQL0WlUh3/heVMf1jnGI5PQlOz+W0W7MyPzZnigg4AZRhI2f2y7
	7m1OGO3QgdNPi3+I2/4b93Ydfd8/EcnCzyw2QUBnugfnWeoYtqGMymZ1IgZZhOqUrlUlveCE57NYP
	GVrK4cGAiYSf91NfGefw/3KCkV68Bc7YFPUxR7OMs6P1tCZ0BAZODeiZKcoiaQWXF9FA82NoelTom
	WR6VzHTOtQYJnqzUsQnT7wrSgtqHOu3vz9PFSriIet6sQbxt4cN1IefydpeIVvEXe+OcnOw5/fFlK
	7aeFu1yQ==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www642.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <josef@raschen.org>)
	id 1v2Fw1-0000df-24;
	Fri, 26 Sep 2025 23:24:57 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <josef@raschen.org>)
	id 1v2Fw1-000MT6-2L;
	Fri, 26 Sep 2025 23:24:57 +0200
Message-ID: <6ac94be0-5017-49cd-baa3-cea959fa1e0d@raschen.org>
Date: Fri, 26 Sep 2025 23:24:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: microchip_t1: LAN887X: Fix device init issues.
To: Andrew Lunn <andrew@lunn.ch>
Cc: Arun Ramadoss <arun.ramadoss@microchip.com>,
 UNGLinuxDriver@microchip.com, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Josef Raschen <josef@raschen.org>
References: <20250925205231.67764-1-josef@raschen.org>
 <3e2ea3a1-6c5e-4427-9b23-2c07da09088d@lunn.ch>
Content-Language: en-US
From: Josef Raschen <josef@raschen.org>
In-Reply-To: <3e2ea3a1-6c5e-4427-9b23-2c07da09088d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27774/Fri Sep 26 10:27:36 2025)

Hello Andrew,

Thanks for your feedback.

On 9/26/25 00:00, Andrew Lunn wrote:
> On Thu, Sep 25, 2025 at 10:52:22PM +0200, Josef Raschen wrote:
>> Currently, for a LAN8870 phy, before link up, a call to ethtool to set
>> master-slave fails with 'operation not supported'. Reason: speed, duplex
>> and master/slave are not properly initialized.
>>
>> This change sets proper initial states for speed and duplex and publishes
>> master-slave states. A default link up for speed 1000, full duplex and
>> slave mode then works without having to call ethtool.
> 
> Hi Josef
> 
> What you are missing from the commit message is an explanation why the
> LAN8870 is special, it needs to do something no other PHY does. Is
> there something broken with this PHY? Some register not following
> 802.3?
> 
>      Andrew
> 
> ---
> pw-bot: cr
> 

Special about the LAN8870 might be that it is a dual speed T1 phy.
As most other T1 pyhs have only one possible configuration the unknown
speed configuration was not a problem so far. But here, when
calling link up without manually setting the speed before, it seems to
pick speed 100 in phy_sanitize_settings(). I assume that this is not the
desired behavior?

The second problem is that ethtool initially does not allow to set
master-slave at all. You first have to call ethtool without the
master-slave argument, then again with it. This is fixed by reading
the master slave configuration from the device which seems to be missing
in the .config_init and .config_aneg functions. I took this solution 
from net/phy/dp83tg720.c.

Regards,
Josef

