Return-Path: <netdev+bounces-248066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0B6D02DE9
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 14:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 065963136212
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 13:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2396D4A13B4;
	Thu,  8 Jan 2026 12:31:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E75F4A1397
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875494; cv=none; b=e36VbthpZjNkceUrO4y/6qtV97uzfMIiryx9v9pWa6rz+5NMF/08ldKPklqmmVvj9sBk1BxurCBC+IYbZaEBu56aewyU7H6CPOolJuvzkmFDvgMEOu2QhoIHU8PgNQ8U5iYuQn+7lgsG7T3KYMHxgUg9LGyg6WeXqU2QeGNYbdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875494; c=relaxed/simple;
	bh=f4+xWQJpCuAm7Bs/CycA69IwDjWmQKczIzzGgzlUB3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjxHTseYMH/rPvcIvO0MIrxr3rQm9ZWVZIyrSgZR113o/OWL2f2dsg8kL5xhUB2u1nPxD4CFhIEMEy6FfXplkq09Srnfdcq1WV06D2vCIbLKsYMKXaMVrW+c+cEeMRJmxfg+yNzfNfyeP57quv4yA8O7IsCDa9Aj51k0Ak8EX5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.217] (p5dc552de.dip0.t-ipconnect.de [93.197.82.222])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9D117236E401C;
	Thu, 08 Jan 2026 13:27:58 +0100 (CET)
Message-ID: <2ad8d26a-794c-498b-a09b-5791acb0a9d5@molgen.mpg.de>
Date: Thu, 8 Jan 2026 13:27:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 1/3] igb: prepare for RSS
 key get/set support
To: Takashi Kozu <takkozu@amazon.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Kohei Enju <enjuk@amazon.com>
References: <20260108052020.84218-5-takkozu@amazon.com>
 <20260108052020.84218-6-takkozu@amazon.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260108052020.84218-6-takkozu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Takashi,


Thank you for the patch.

Am 08.01.26 um 06:20 schrieb Takashi Kozu:
> Store the RSS key inside struct igb_adapter and introduce the
> igb_write_rss_key() helper function. This allows the driver to program
> the E1000 registers using a persistent RSS key, instead of using a
> stack-local buffer in igb_setup_mrqc().
> 
> Tested-by: Kohei Enju <enjuk@amazon.com>
> Signed-off-by: Takashi Kozu <takkozu@amazon.com>
> ---
>   drivers/net/ethernet/intel/igb/igb.h         |  3 +++
>   drivers/net/ethernet/intel/igb/igb_ethtool.c | 12 ++++++++++++
>   drivers/net/ethernet/intel/igb/igb_main.c    |  6 ++----
>   3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index 0fff1df81b7b..8c9b02058cec 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -495,6 +495,7 @@ struct hwmon_buff {
>   #define IGB_N_PEROUT	2
>   #define IGB_N_SDP	4
>   #define IGB_RETA_SIZE	128
> +#define IGB_RSS_KEY_SIZE	40
>   
>   enum igb_filter_match_flags {
>   	IGB_FILTER_FLAG_ETHER_TYPE = 0x1,
> @@ -655,6 +656,7 @@ struct igb_adapter {
>   	struct i2c_client *i2c_client;
>   	u32 rss_indir_tbl_init;
>   	u8 rss_indir_tbl[IGB_RETA_SIZE];
> +	u8 rss_key[IGB_RSS_KEY_SIZE];
>   
>   	unsigned long link_check_timeout;
>   	int copper_tries;
> @@ -735,6 +737,7 @@ void igb_down(struct igb_adapter *);
>   void igb_reinit_locked(struct igb_adapter *);
>   void igb_reset(struct igb_adapter *);
>   int igb_reinit_queues(struct igb_adapter *);
> +void igb_write_rss_key(struct igb_adapter *adapter);
>   void igb_write_rss_indir_tbl(struct igb_adapter *);
>   int igb_set_spd_dplx(struct igb_adapter *, u32, u8);
>   int igb_setup_tx_resources(struct igb_ring *);
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index 10e2445e0ded..8695ff28a7b8 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -3016,6 +3016,18 @@ static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
>   	return ret;
>   }
>   
> +void igb_write_rss_key(struct igb_adapter *adapter)
> +{
> +	struct e1000_hw *hw = &adapter->hw;
> +	u32 val;
> +	int i;
> +
> +	for (i = 0; i < IGB_RSS_KEY_SIZE / 4; i++) {
> +		val = get_unaligned_le32(&adapter->rss_key[i * 4]);

Why is `get_unaligned_le32()` needed?

> +		wr32(E1000_RSSRK(i), val);

I probably wouldn’t get rid of `val`.

> +	}
> +}
> +
>   static int igb_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
>   {
>   	struct igb_adapter *adapter = netdev_priv(netdev);
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 85f9589cc568..da0f550de605 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4525,11 +4525,9 @@ static void igb_setup_mrqc(struct igb_adapter *adapter)
>   	struct e1000_hw *hw = &adapter->hw;
>   	u32 mrqc, rxcsum;
>   	u32 j, num_rx_queues;
> -	u32 rss_key[10];
>   
> -	netdev_rss_key_fill(rss_key, sizeof(rss_key));
> -	for (j = 0; j < 10; j++)
> -		wr32(E1000_RSSRK(j), rss_key[j]);
> +	netdev_rss_key_fill(adapter->rss_key, sizeof(adapter->rss_key));
> +	igb_write_rss_key(adapter);
>   
>   	num_rx_queues = adapter->rss_queues;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


