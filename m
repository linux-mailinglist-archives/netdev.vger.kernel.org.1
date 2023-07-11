Return-Path: <netdev+bounces-16702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9F874E756
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 08:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607082815B4
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 06:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAB83D6A;
	Tue, 11 Jul 2023 06:30:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C004A171AD
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:30:27 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A640B8
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 23:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689057022; x=1720593022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SOCidrNOmN1mAjmk0iRXNFjXvAlc36nfBv6N5Z4qIr0=;
  b=E/YYa+vP1YaqwFYJjV8Uym/MQk7B1eSDdGiiSNALFnVl3igmfHubfTNQ
   JGEcBo0L1qFTdmjPhBsTl2er4lMtKQsqM7R1brmLf6IzFEnTFU9EmHGcJ
   DO3vjtVXx3rcYuucwW5wssbCpwr9ojMVsD/H3krSrjRMe4yTQozxs8rc/
   SyamwUPL4FLxQ7MWaPLxGYElo1zTm+Yt1sHeNlllUZ7D4w+d2rmJeQFYw
   s7Mixe3iSHFm0gHVoCKgkzigLn4op1HIkhBsLRHhPOqALL5eAdDigC0DA
   WkFH69S5R9UX+LRKv9aoG9Udu2+0nunP3tPyblzzooqk5mLx+7crrhPp8
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="234765815"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jul 2023 23:30:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 10 Jul 2023 23:30:21 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 10 Jul 2023 23:30:21 -0700
Date: Tue, 11 Jul 2023 08:30:20 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <Tristram.Ha@microchip.com>
CC: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v1 net] net: dsa: microchip: correct KSZ8795 static MAC
 table access
Message-ID: <20230711063020.kmipc2wxsfuwpypz@soft-dev3-1>
References: <1689034207-2882-1-git-send-email-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1689034207-2882-1-git-send-email-Tristram.Ha@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The 07/10/2023 17:10, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <Tristram.Ha@microchip.com>

Hi Tristram,

It looks like you forgot again to add all the maintainers to the email
thread. Was it something wrong with the command
./scripts/get_maintainer.pl?

> 
> The KSZ8795 driver code was modified to use on KSZ8863/73, which has
> different register definitions.  Some of the new KSZ8795 register
> information are wrong compared to previous code.
> 
> KSZ8795 also behaves differently in that the STATIC_MAC_TABLE_USE_FID
> and STATIC_MAC_TABLE_FID bits are off by 1 when doing MAC table reading
> than writing.  To compensate that a special code was added to shift the
> register value by 1 before applying those bits.  This is wrong when the
> code is running on KSZ8863, so this special code is only executed when
> KSZ8795 is detected.
> 
> Fixes: 4b20a07e103f ("net: dsa: microchip: ksz8795: add support for ksz88xx chips")
> Signed-off-by: Tristram Ha <Tristram.Ha@microchip.com>

Other than what I mentioned aboved, it looks OK.
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>

> ---
> v1
> - Use correct commit for fixes
> 
>  drivers/net/dsa/microchip/ksz8795.c    | 8 +++++++-
>  drivers/net/dsa/microchip/ksz_common.c | 8 ++++----
>  drivers/net/dsa/microchip/ksz_common.h | 7 +++++++
>  3 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
> index 84d502589f8e..91aba470fb2f 100644
> --- a/drivers/net/dsa/microchip/ksz8795.c
> +++ b/drivers/net/dsa/microchip/ksz8795.c
> @@ -506,7 +506,13 @@ static int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
>  		(data_hi & masks[STATIC_MAC_TABLE_FWD_PORTS]) >>
>  			shifts[STATIC_MAC_FWD_PORTS];
>  	alu->is_override = (data_hi & masks[STATIC_MAC_TABLE_OVERRIDE]) ? 1 : 0;
> -	data_hi >>= 1;
> +
> +	/* KSZ8795 family switches have STATIC_MAC_TABLE_USE_FID and
> +	 * STATIC_MAC_TABLE_FID definitions off by 1 when doing read on the
> +	 * static MAC table compared to doing write.
> +	 */
> +	if (ksz_is_ksz87xx(dev))
> +		data_hi >>= 1;
>  	alu->is_static = true;
>  	alu->is_use_fid = (data_hi & masks[STATIC_MAC_TABLE_USE_FID]) ? 1 : 0;
>  	alu->fid = (data_hi & masks[STATIC_MAC_TABLE_FID]) >>
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 813b91a816bb..b18cd170ec06 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -331,13 +331,13 @@ static const u32 ksz8795_masks[] = {
>  	[STATIC_MAC_TABLE_VALID]	= BIT(21),
>  	[STATIC_MAC_TABLE_USE_FID]	= BIT(23),
>  	[STATIC_MAC_TABLE_FID]		= GENMASK(30, 24),
> -	[STATIC_MAC_TABLE_OVERRIDE]	= BIT(26),
> -	[STATIC_MAC_TABLE_FWD_PORTS]	= GENMASK(24, 20),
> +	[STATIC_MAC_TABLE_OVERRIDE]	= BIT(22),
> +	[STATIC_MAC_TABLE_FWD_PORTS]	= GENMASK(20, 16),
>  	[DYNAMIC_MAC_TABLE_ENTRIES_H]	= GENMASK(6, 0),
> -	[DYNAMIC_MAC_TABLE_MAC_EMPTY]	= BIT(8),
> +	[DYNAMIC_MAC_TABLE_MAC_EMPTY]	= BIT(7),
>  	[DYNAMIC_MAC_TABLE_NOT_READY]	= BIT(7),
>  	[DYNAMIC_MAC_TABLE_ENTRIES]	= GENMASK(31, 29),
> -	[DYNAMIC_MAC_TABLE_FID]		= GENMASK(26, 20),
> +	[DYNAMIC_MAC_TABLE_FID]		= GENMASK(22, 16),
>  	[DYNAMIC_MAC_TABLE_SRC_PORT]	= GENMASK(26, 24),
>  	[DYNAMIC_MAC_TABLE_TIMESTAMP]	= GENMASK(28, 27),
>  	[P_MII_TX_FLOW_CTRL]		= BIT(5),
> diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
> index 28444e5924f9..a4de58847dea 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -601,6 +601,13 @@ static inline void ksz_regmap_unlock(void *__mtx)
>  	mutex_unlock(mtx);
>  }
>  
> +static inline bool ksz_is_ksz87xx(struct ksz_device *dev)
> +{
> +	return dev->chip_id == KSZ8795_CHIP_ID ||
> +	       dev->chip_id == KSZ8794_CHIP_ID ||
> +	       dev->chip_id == KSZ8765_CHIP_ID;
> +}
> +
>  static inline bool ksz_is_ksz88x3(struct ksz_device *dev)
>  {
>  	return dev->chip_id == KSZ8830_CHIP_ID;
> -- 
> 2.17.1
> 

-- 
/Horatiu

