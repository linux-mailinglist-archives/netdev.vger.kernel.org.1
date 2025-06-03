Return-Path: <netdev+bounces-194743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DA2ACC35D
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D461884BB9
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBB72820DA;
	Tue,  3 Jun 2025 09:43:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9C1F30BB;
	Tue,  3 Jun 2025 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748943811; cv=none; b=Rx0xIC690XQ8trxEH7vvd1Wupm8XXGoHVqz+N8n5aCb4shbk8IbYCgpZAfJs8JGGC3fR6TrKYprYzQ0Yx2XXtBiweVkbTmRgum4oFYP4NMQw86P6dHok8v0Fkt4gk6YIdeha9UJp196W6q7GrdKE9MEXoxwzgJ/GK118P+NBeWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748943811; c=relaxed/simple;
	bh=ISNgnd29PMBrvsUWw5jw8nPncxgXW5hH7ePZLNkAFiU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FklG3pZyXDw4u9yEMdrHPe2sR4uosrEA7nyUKe0mwzDrDQiWzHTVZFXwneV8fiymgug/JtO6Lh5jLp/ehUfc4WisSevMKUA+d1wQnuZdXeAAEk9GcIktufKxJeIaW5CTTvVn6WQuhPo3RF/rdXc2Jw8OgvcCSaYLoCLa/J3aKcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bBQdv0hj8zQlK2;
	Tue,  3 Jun 2025 17:39:15 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id ADBF91800B4;
	Tue,  3 Jun 2025 17:43:24 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Jun 2025 17:43:23 +0800
Message-ID: <8467f587-7111-420c-ba10-604b5ab44cc9@huawei.com>
Date: Tue, 3 Jun 2025 17:43:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <thomas.petazzoni@bootlin.com>, Simon Horman
	<horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>, Romain Gantois
	<romain.gantois@bootlin.com>
Subject: Re: [PATCH net] net: phy: phy_caps: Don't skip better duplex macth on
 non-exact match
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20250603083541.248315-1-maxime.chevallier@bootlin.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250603083541.248315-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/6/3 16:35, Maxime Chevallier wrote:
> When performing a non-exact phy_caps lookup, we are looking for a
> supported mode that matches as closely as possible the passed speed/duplex.
>
> Blamed patch broke that logic by returning a match too early in case
> the caller asks for half-duplex, as a full-duplex linkmode may match
> first, and returned as a non-exact match without even trying to mach on
> half-duplex modes.
>
> Reported-by: Jijie Shao <shaojijie@huawei.com>
> Closes: https://lore.kernel.org/netdev/20250603102500.4ec743cf@fedora/T/#m22ed60ca635c67dc7d9cbb47e8995b2beb5c1576
> Fixes: fc81e257d19f ("net: phy: phy_caps: Allow looking-up link caps based on speed and duplex")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Tested-by: Jijie Shao <shaojijie@huawei.com>

> ---
>   drivers/net/phy/phy_caps.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
> index 703321689726..d80f6a37edf1 100644
> --- a/drivers/net/phy/phy_caps.c
> +++ b/drivers/net/phy/phy_caps.c
> @@ -195,7 +195,7 @@ const struct link_capabilities *
>   phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *supported,
>   		bool exact)
>   {
> -	const struct link_capabilities *lcap, *last = NULL;
> +	const struct link_capabilities *lcap, *match = NULL, *last = NULL;
>   
>   	for_each_link_caps_desc_speed(lcap) {
>   		if (linkmode_intersects(lcap->linkmodes, supported)) {
> @@ -204,16 +204,19 @@ phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *supported,
>   			if (lcap->speed == speed && lcap->duplex == duplex) {
>   				return lcap;
>   			} else if (!exact) {
> -				if (lcap->speed <= speed)
> -					return lcap;
> +				if (!match && lcap->speed <= speed)
> +					match = lcap;
> +
> +				if (lcap->speed < speed)
> +					break;
>   			}
>   		}
>   	}
>   
> -	if (!exact)
> -		return last;
> +	if (!match && !exact)
> +		match = last;
>   
> -	return NULL;
> +	return match;
>   }
>   EXPORT_SYMBOL_GPL(phy_caps_lookup);
>   

