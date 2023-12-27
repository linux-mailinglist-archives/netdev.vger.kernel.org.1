Return-Path: <netdev+bounces-60424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CE681F267
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 23:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393FE1C211C0
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 22:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99936481BB;
	Wed, 27 Dec 2023 22:19:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E547F72
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 22:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nic.cz
Received: from [192.168.0.113] (unknown [185.251.120.166])
	by mail.nic.cz (Postfix) with ESMTPSA id 221691C0347;
	Wed, 27 Dec 2023 23:19:41 +0100 (CET)
Authentication-Results: mail.nic.cz;
	auth=pass smtp.auth=marek.mojik@nic.cz smtp.mailfrom=marek.mojik@nic.cz
Message-ID: <5f6b5096-d172-4a70-874c-be6d5a457ac0@nic.cz>
Date: Wed, 27 Dec 2023 23:19:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Content-Language: en-US
To: Asmaa Mnebhi <asmaa@nvidia.com>, davem@davemloft.net,
 linux@armlinux.org.uk, netdev@vger.kernel.org
Cc: davthompson@nvidia.com
References: <20231226141903.12040-1-asmaa@nvidia.com>
From: =?UTF-8?Q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>
In-Reply-To: <20231226141903.12040-1-asmaa@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.10 at mail
X-Virus-Status: Clean
X-Rspamd-Queue-Id: 221691C0347
X-Spamd-Result: default: False [3.01 / 20.00];
	BAYES_SPAM(3.10)[100.00%];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:44234, ipnet:185.251.120.0/23, country:SK];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spamd-Bar: +++
X-Rspamd-Server: mail
X-Rspamd-Action: no action



On 12/26/23 15:19, Asmaa Mnebhi wrote:
> Very rarely, the KSZ9031 fails to complete autonegotiation although it was
> initiated via phy_start(). As a result, the link stays down. Restarting
> autonegotiation when in this state solves the issue.
> 
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> ---
>   drivers/net/phy/micrel.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 08e3915001c3..de8140c5907f 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -1475,6 +1475,7 @@ static int ksz9031_get_features(struct phy_device *phydev)
>   
>   static int ksz9031_read_status(struct phy_device *phydev)
>   {
> +	u8 timeout = 10;
>   	int err;
>   	int regval;
>   
> @@ -1494,6 +1495,22 @@ static int ksz9031_read_status(struct phy_device *phydev)
>   		return genphy_config_aneg(phydev);
>   	}
>   
> +	/* KSZ9031's autonegotiation takes normally 4-5 seconds to complete.
> +	 * Occasionally it fails to complete autonegotiation. The workaround is
> +	 * to restart it.
> +	 */
> +        if (phydev->autoneg == AUTONEG_ENABLE) {
> +		while (timeout) {
> +			if (phy_aneg_done(phydev))
> +				break;
> +			mdelay(1000);
> +			timeout--;
> +		};
> +
> +		if (timeout == 0)
> +			phy_restart_aneg(phydev);
> +	}
> +
>   	return 0;
>   }


Hi Asmaa, mdelay is busy-wait, so you're unnecessarily blocking cpu core
for 10 seconds, msleep should be used here as explained in the docs 
https://kernel.org/doc/Documentation/timers/timers-howto.txt

Marek

