Return-Path: <netdev+bounces-138404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C82EA9AD5DB
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 22:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69B41C21876
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 20:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C4D1E5735;
	Wed, 23 Oct 2024 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZaRjA0i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9D21E2844;
	Wed, 23 Oct 2024 20:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716860; cv=none; b=FQ0d5DIFJLTzaIxRqRztWNB5y/T4ZCuduGAd6vcw2XI+eRSWXHNTHBaawvDKvAxefaAlfxrbNh+BCuVWdUjVSQQdpfe5J7e2KTMV6+BMavlCCI1sVAbrhATDTHheN3z6rJa5S+gTWNAFjjy3aW9kjHqlYWvEq3zZW2SAMh3OxMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716860; c=relaxed/simple;
	bh=0ZJH1tg6Y1edCRrqp9Sf6DHWEh8mb9yux+PSI5k4boY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlgQ0n8mvTG4JhvxtIXFn32Iki83KUOecMmfdahJ59C4ki2rTCz53bZnTBnejb7DNBP5S3xfQZMblzFmmtDEtpCPJP4MPX0iJ+DBOkKw1oFi/5UCKSSKHKm9BoNTDqT9gqFMYeCWaBkK5kJvw+hr8T+EoL+0xr6QLqy8Ncj2qoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZaRjA0i; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729716860; x=1761252860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0ZJH1tg6Y1edCRrqp9Sf6DHWEh8mb9yux+PSI5k4boY=;
  b=JZaRjA0iC4NVvA01DvEgyhQwmK+sitm2pS/urNoRVUt+CQcEs9y/lf/N
   XqoPco45fkuPSrCZdSyfDv3A3wnrzTtEZmgKCO2AHIIFUhzDQ/RcW5dst
   cVk9fkg3zwYwsP2q1Z+WUlwYeHa9soINQcU0RjfCpsUjY7WYC2FAc4mpn
   uz0WQMsQGz5kBqvlGc50cT/RqozPa7t4oNZcLePuEXJ2VVM2Cd8pi1URf
   x8RLVR9sUO8elOyyN8elXxb5LdFmbMmw989m9aefsA2Mxnv0SIGtDKTiD
   UvMixTifRh+wN12iiwiTgy+bJDFbWznqFnIrBUAOVK0cAcdbCXaGyyMp9
   Q==;
X-CSE-ConnectionGUID: HE771IYrSDqpcKyMMpv6DQ==
X-CSE-MsgGUID: gJy9n+4jQVmwthkOYAu1pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29489455"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29489455"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 13:54:19 -0700
X-CSE-ConnectionGUID: MKv2nNyiQKCvJu/RCWVqSQ==
X-CSE-MsgGUID: 3drdinVSRfmhXjb2/4zFKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80691801"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 23 Oct 2024 13:54:13 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3iMt-000VYU-01;
	Wed, 23 Oct 2024 20:54:11 +0000
Date: Thu, 24 Oct 2024 04:53:16 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	andrew@lunn.ch, Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	horatiu.vultur@microchip.com,
	jensemil.schulzostergaard@microchip.com,
	Parthiban.Veerasooran@microchip.com, Raju.Lakkaraju@microchip.com,
	UNGLinuxDriver@microchip.com,
	Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, jacob.e.keller@intel.com,
	ast@fiberby.net, maxime.chevallier@bootlin.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 06/15] net: lan969x: add match data for lan969x
Message-ID: <202410240405.kPh7im63-lkp@intel.com>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-6-c8c49ef21e0f@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-6-c8c49ef21e0f@microchip.com>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on 30d9d8f6a2d7e44a9f91737dd409dbc87ac6f6b7]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Machon/net-sparx5-add-support-for-lan969x-SKU-s-and-core-clock/20241021-220557
base:   30d9d8f6a2d7e44a9f91737dd409dbc87ac6f6b7
patch link:    https://lore.kernel.org/r/20241021-sparx5-lan969x-switch-driver-2-v1-6-c8c49ef21e0f%40microchip.com
patch subject: [PATCH net-next 06/15] net: lan969x: add match data for lan969x
config: arm64-randconfig-002-20241024 (https://download.01.org/0day-ci/archive/20241024/202410240405.kPh7im63-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241024/202410240405.kPh7im63-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410240405.kPh7im63-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c: In function 'sparx5_fdma_rx_get_frame':
>> drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c:178:20: error: 'struct sk_buff' has no member named 'offload_fwd_mark'
     178 |                 skb->offload_fwd_mark = 1;
         |                    ^~
--
   drivers/net/ethernet/microchip/sparx5/sparx5_packet.c: In function 'sparx5_xtr_grp':
>> drivers/net/ethernet/microchip/sparx5/sparx5_packet.c:154:20: error: 'struct sk_buff' has no member named 'offload_fwd_mark'
     154 |                 skb->offload_fwd_mark = 1;
         |                    ^~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SPARX5_SWITCH
   Depends on [n]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y] && NET_SWITCHDEV [=n] && HAS_IOMEM [=y] && OF [=y] && (ARCH_SPARX5 [=y] || COMPILE_TEST [=y]) && PTP_1588_CLOCK_OPTIONAL [=m] && (BRIDGE [=m] || BRIDGE [=m]=n [=n])
   Selected by [m]:
   - LAN969X_SWITCH [=m] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y]


vim +178 drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c

10615907e9b51c Steen Hegelund 2021-08-19  141  
10615907e9b51c Steen Hegelund 2021-08-19  142  static bool sparx5_fdma_rx_get_frame(struct sparx5 *sparx5, struct sparx5_rx *rx)
10615907e9b51c Steen Hegelund 2021-08-19  143  {
e8218f7a9f4425 Daniel Machon  2024-09-02  144  	struct fdma *fdma = &rx->fdma;
10615907e9b51c Steen Hegelund 2021-08-19  145  	struct sparx5_port *port;
8fec1cea941d32 Daniel Machon  2024-09-02  146  	struct fdma_db *db_hw;
10615907e9b51c Steen Hegelund 2021-08-19  147  	struct frame_info fi;
10615907e9b51c Steen Hegelund 2021-08-19  148  	struct sk_buff *skb;
10615907e9b51c Steen Hegelund 2021-08-19  149  
10615907e9b51c Steen Hegelund 2021-08-19  150  	/* Check if the DCB is done */
4ff58c394715ee Daniel Machon  2024-09-02  151  	db_hw = fdma_db_next_get(fdma);
4ff58c394715ee Daniel Machon  2024-09-02  152  	if (unlikely(!fdma_db_is_done(db_hw)))
10615907e9b51c Steen Hegelund 2021-08-19  153  		return false;
e8218f7a9f4425 Daniel Machon  2024-09-02  154  	skb = rx->skb[fdma->dcb_index][fdma->db_index];
4ff58c394715ee Daniel Machon  2024-09-02  155  	skb_put(skb, fdma_db_len_get(db_hw));
10615907e9b51c Steen Hegelund 2021-08-19  156  	/* Now do the normal processing of the skb */
aa7dfc6611fae2 Daniel Machon  2024-10-21  157  	sparx5_ifh_parse(sparx5, (u32 *)skb->data, &fi);
10615907e9b51c Steen Hegelund 2021-08-19  158  	/* Map to port netdev */
3f9e46347a466a Daniel Machon  2024-10-04  159  	port = fi.src_port < sparx5->data->consts->n_ports ?
3f9e46347a466a Daniel Machon  2024-10-04  160  		       sparx5->ports[fi.src_port] :
3f9e46347a466a Daniel Machon  2024-10-04  161  		       NULL;
10615907e9b51c Steen Hegelund 2021-08-19  162  	if (!port || !port->ndev) {
10615907e9b51c Steen Hegelund 2021-08-19  163  		dev_err(sparx5->dev, "Data on inactive port %d\n", fi.src_port);
10615907e9b51c Steen Hegelund 2021-08-19  164  		sparx5_xtr_flush(sparx5, XTR_QUEUE);
10615907e9b51c Steen Hegelund 2021-08-19  165  		return false;
10615907e9b51c Steen Hegelund 2021-08-19  166  	}
10615907e9b51c Steen Hegelund 2021-08-19  167  	skb->dev = port->ndev;
10615907e9b51c Steen Hegelund 2021-08-19  168  	skb_pull(skb, IFH_LEN * sizeof(u32));
10615907e9b51c Steen Hegelund 2021-08-19  169  	if (likely(!(skb->dev->features & NETIF_F_RXFCS)))
10615907e9b51c Steen Hegelund 2021-08-19  170  		skb_trim(skb, skb->len - ETH_FCS_LEN);
70dfe25cd8666d Horatiu Vultur 2022-03-04  171  
70dfe25cd8666d Horatiu Vultur 2022-03-04  172  	sparx5_ptp_rxtstamp(sparx5, skb, fi.timestamp);
10615907e9b51c Steen Hegelund 2021-08-19  173  	skb->protocol = eth_type_trans(skb, skb->dev);
10615907e9b51c Steen Hegelund 2021-08-19  174  	/* Everything we see on an interface that is in the HW bridge
10615907e9b51c Steen Hegelund 2021-08-19  175  	 * has already been forwarded
10615907e9b51c Steen Hegelund 2021-08-19  176  	 */
10615907e9b51c Steen Hegelund 2021-08-19  177  	if (test_bit(port->portno, sparx5->bridge_mask))
10615907e9b51c Steen Hegelund 2021-08-19 @178  		skb->offload_fwd_mark = 1;
10615907e9b51c Steen Hegelund 2021-08-19  179  	skb->dev->stats.rx_bytes += skb->len;
10615907e9b51c Steen Hegelund 2021-08-19  180  	skb->dev->stats.rx_packets++;
10615907e9b51c Steen Hegelund 2021-08-19  181  	rx->packets++;
10615907e9b51c Steen Hegelund 2021-08-19  182  	netif_receive_skb(skb);
10615907e9b51c Steen Hegelund 2021-08-19  183  	return true;
10615907e9b51c Steen Hegelund 2021-08-19  184  }
10615907e9b51c Steen Hegelund 2021-08-19  185  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

