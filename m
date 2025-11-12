Return-Path: <netdev+bounces-237973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 005C4C52543
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 13:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3997318E09F5
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1993148D0;
	Wed, 12 Nov 2025 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fYQkGzgf"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C03064AE
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951727; cv=none; b=IU5BuNWQM4YIlK/KtP6uy7XWHdSngQwLurkx21pcVrYxtEq6GqnpESiOApcRuB58r1nYtO8mqox81ICH3XyOXjMTCdNOvahL8thWLe7K2J+6NGoz7rnZfd77mkJtN5md3JWVGex5MrCp1cu3U/IXJw/PwxVPyyapv7FerxiBfFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951727; c=relaxed/simple;
	bh=isfOvoDsUNbS+4rrDRrZ0MxtAIS5HcdJN2a1pVHWhFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbjFKQqJaYZe4eslPF7dZy1O+nmTlGg+l9x8KRXwcNXl+HWLAOOgRFUxG1ojdopPQNXs2FRedm3YTGTXQ9mBtFrLSoJjfJmJ5P+4v6sjMDYOLnKQbBX3mpsXeKJeYqDfMhMHk4O4GwYCSlQx1fMccxdPDXkVGPkAaLEOLFlrnB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fYQkGzgf; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b7702efc-9994-4656-9d4e-29c2c8145ab3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762951721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8l+E9IpLLcDLisYso3baO3KCeuDTFGkwAE3ap7DSWUY=;
	b=fYQkGzgfLsG2HBgsKgKwLbXOKoflh3/eGr6eA28nifTJ9oH0t+Vt8WGcTtv9yzDZQccwdR
	B0A37zhl4zMoqKaAhveCDP81rQTKHv1gC/RPPjOmKBj2ua86D5Y3OAIeJaiVZaKJ+L2Sh6
	fwhyp9rrgbDenBngwYDHXwL6jX34c40=
Date: Wed, 12 Nov 2025 12:48:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 5/5] net: txgbe: support getting module EEPROM by
 page
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
References: <20251112055841.22984-1-jiawenwu@trustnetic.com>
 <20251112055841.22984-6-jiawenwu@trustnetic.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251112055841.22984-6-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/11/2025 05:58, Jiawen Wu wrote:
> Getting module EEPROM has been supported in TXGBE SP devices, since SFP
> driver has already implemented it.
> 
> Now add support to read module EEPROM for AML devices. Towards this, add
> a new firmware mailbox command to get the page data.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>   .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 37 +++++++++++++++++++
>   .../net/ethernet/wangxun/txgbe/txgbe_aml.h    |  3 ++
>   .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 30 +++++++++++++++
>   .../net/ethernet/wangxun/txgbe/txgbe_type.h   | 11 ++++++
>   4 files changed, 81 insertions(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> index 3b6ea456fbf7..12900abfa91a 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> @@ -73,6 +73,43 @@ int txgbe_test_hostif(struct wx *wx)
>   					WX_HI_COMMAND_TIMEOUT, true);
>   }
>   
> +int txgbe_read_eeprom_hostif(struct wx *wx,
> +			     struct txgbe_hic_i2c_read *buffer,
> +			     u32 length, u8 *data)
> +{
> +	u32 buf_size = sizeof(struct txgbe_hic_i2c_read) - sizeof(u8);
> +	u32 total_len = buf_size + length;
> +	u32 dword_len, value, i;
> +	u8 local_data[256];
> +	int err;
> +
> +	if (total_len > sizeof(local_data))
> +		return -EINVAL;

if it's really possible? SFF pages are 128 bytes, you reserve 256 bytes
of local buffer. What are you protecting from?

> +
> +	buffer->hdr.cmd = FW_READ_EEPROM_CMD;
> +	buffer->hdr.buf_len = sizeof(struct txgbe_hic_i2c_read) -
> +			      sizeof(struct wx_hic_hdr);
> +	buffer->hdr.cmd_or_resp.cmd_resv = FW_CEM_CMD_RESERVED;
> +
> +	err = wx_host_interface_command(wx, (u32 *)buffer,
> +					sizeof(struct txgbe_hic_i2c_read),
> +					WX_HI_COMMAND_TIMEOUT, false);
> +	if (err != 0)
> +		return err;
> +
> +	dword_len = (total_len + 3) / 4;

round_up()?

> +
> +	for (i = 0; i < dword_len; i++) {
> +		value = rd32a(wx, WX_FW2SW_MBOX, i);
> +		le32_to_cpus(&value);
> +
> +		memcpy(&local_data[i * 4], &value, 4);
> +	}

the logic here is not clear from the first read of the code. effectively
in the reply you have the same txgbe_hic_i2c_read struct but without
data field, which is obviously VLA, but then you simply skip the result
of read of txgbe_hic_i2c_read and only provide the real data back to the
caller. Maybe you can organize the code the way it can avoid double copying?

> +
> +	memcpy(data, &local_data[buf_size], length);
> +	return 0;
> +}
> +
>   static int txgbe_identify_module_hostif(struct wx *wx,
>   					struct txgbe_hic_get_module_info *buffer)
>   {
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
> index 7c8fa48e68d3..4f6df0ee860b 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.h
> @@ -7,6 +7,9 @@
>   void txgbe_gpio_init_aml(struct wx *wx);
>   irqreturn_t txgbe_gpio_irq_handler_aml(int irq, void *data);
>   int txgbe_test_hostif(struct wx *wx);
> +int txgbe_read_eeprom_hostif(struct wx *wx,
> +			     struct txgbe_hic_i2c_read *buffer,
> +			     u32 length, u8 *data);
>   int txgbe_set_phy_link(struct wx *wx);
>   int txgbe_identify_module(struct wx *wx);
>   void txgbe_setup_link(struct wx *wx);
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> index f553ec5f8238..1f60121fe73c 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> @@ -10,6 +10,7 @@
>   #include "../libwx/wx_lib.h"
>   #include "txgbe_type.h"
>   #include "txgbe_fdir.h"
> +#include "txgbe_aml.h"
>   #include "txgbe_ethtool.h"
>   
>   int txgbe_get_link_ksettings(struct net_device *netdev,
> @@ -534,6 +535,34 @@ static int txgbe_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
>   	return ret;
>   }
>   
> +static int
> +txgbe_get_module_eeprom_by_page(struct net_device *netdev,
> +				const struct ethtool_module_eeprom *page_data,
> +				struct netlink_ext_ack *extack)
> +{
> +	struct wx *wx = netdev_priv(netdev);
> +	struct txgbe_hic_i2c_read buffer;
> +	int err;
> +
> +	if (!test_bit(WX_FLAG_SWFW_RING, wx->flags))
> +		return -EOPNOTSUPP;
> +
> +	buffer.length = (__force u32)cpu_to_be32(page_data->length);
> +	buffer.offset = (__force u32)cpu_to_be32(page_data->offset);

maybe txgbe_hic_i2c_read::length and txgbe_hic_i2c_read::offset should
be __be32 ?

> +	buffer.page = page_data->page;
> +	buffer.bank = page_data->bank;
> +	buffer.i2c_address = page_data->i2c_address;
> +
> +	err = txgbe_read_eeprom_hostif(wx, &buffer, page_data->length,
> +				       page_data->data);
> +	if (err) {
> +		wx_err(wx, "Failed to read module EEPROM\n");
> +		return err;
> +	}
> +
> +	return page_data->length;
> +}
> +
>   static const struct ethtool_ops txgbe_ethtool_ops = {
>   	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>   				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
> @@ -568,6 +597,7 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
>   	.set_msglevel		= wx_set_msglevel,
>   	.get_ts_info		= wx_get_ts_info,
>   	.get_ts_stats		= wx_get_ptp_stats,
> +	.get_module_eeprom_by_page	= txgbe_get_module_eeprom_by_page,
>   };
>   
>   void txgbe_set_ethtool_ops(struct net_device *netdev)
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> index e72edb9ef084..3d1bec39d74c 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> @@ -353,6 +353,7 @@ void txgbe_do_reset(struct net_device *netdev);
>   #define FW_PHY_GET_LINK_CMD             0xC0
>   #define FW_PHY_SET_LINK_CMD             0xC1
>   #define FW_GET_MODULE_INFO_CMD          0xC5
> +#define FW_READ_EEPROM_CMD              0xC6
>   
>   struct txgbe_sff_id {
>   	u8 identifier;		/* A0H 0x00 */
> @@ -394,6 +395,16 @@ struct txgbe_hic_ephy_getlink {
>   	u8 resv[6];
>   };
>   
> +struct txgbe_hic_i2c_read {
> +	struct wx_hic_hdr hdr;
> +	u32 offset;
> +	u32 length;
> +	u8 page;
> +	u8 bank;
> +	u8 i2c_address;
> +	u8 data;
> +};
you removed struct txgbe_hic_i2c_read in the patch 2 just to introduce
it in this patch?

> +
>   #define NODE_PROP(_NAME, _PROP)			\
>   	(const struct software_node) {		\
>   		.name = _NAME,			\


