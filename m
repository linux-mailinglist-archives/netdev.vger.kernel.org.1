Return-Path: <netdev+bounces-122628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0F1961FD3
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 08:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C627628193A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 06:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497FA155A3C;
	Wed, 28 Aug 2024 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TzqEt/hI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2606E12CD8B
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 06:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826720; cv=none; b=CRVSi1bezMzbaRS0tm6nCG0Ubpi/rR8McjDFEcAuXWFa/pi+uFVPglIr8EdPo5JHK4NK73jbEkeANSXyz7/tvx/kuVhW8jD/8+nec+AfHVkV/ByaKXP/FijwbxJyKzqtUEAye1U1hJg4L7xi5E8rtzO+7Ij9zAUb2Kpfaubn/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826720; c=relaxed/simple;
	bh=Fgf+fTYQQ9E808a+4XeEvcTakzn55Pwb1eIGyRXZ2S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+9REHB3b37gBEJFh9Sm/II3NKzCkzmUtUY8gtSpFORjPyunCpQD6RlVW6lN0SXzSr5DAQW9/tiUJiIXLpbHYsfN5Lt+c7Yjl4vgMYvXjV3oSzsowXXP6T2XqiQkvKjU8QJf/XEVz5IV/I/cUFhvYNslgV+G8bzpDVEwXR2RDk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TzqEt/hI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724826719; x=1756362719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fgf+fTYQQ9E808a+4XeEvcTakzn55Pwb1eIGyRXZ2S0=;
  b=TzqEt/hImyO3yVTOO2Iz1bo1Gj0Ot1s8ruzMGdZMpB6R+i7fNmCZnyX+
   1XEFC3FNSGjGRqkANO8eKSs2igadrYOglPiY+pIkvC9lGWh5v97Oom4xA
   BQPDMpj9C7koiq//75AjnOXTYBAoB6thvWJmm5aysDXuhmoVj6EF05XgD
   aLgs/yATT+cWcvqyeJ0tymwQonw0P6KbXspQpwCdly/+oq3xyeotdwZVQ
   +I5NpvY+R52I4iMUrmMCKRKq6kZXb7dY5kE//QTsWeu1fuM+P9VbBYQiD
   YFj8xOUfK72r1nf1yNHz1z16JCfZoQKhx0vztLVfM288jvkAYoXOhVr5Z
   Q==;
X-CSE-ConnectionGUID: b0rNyJb5QQWLAppZV/dSnA==
X-CSE-MsgGUID: pErtsoBaRc2mIbbH2kXzyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="40811214"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="40811214"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 23:31:58 -0700
X-CSE-ConnectionGUID: VGiy6s9mTFqOZvhWUAR1DQ==
X-CSE-MsgGUID: BiWxCa99Rj6z5zp7epqX0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="93829215"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 23:31:54 -0700
Date: Wed, 28 Aug 2024 08:29:58 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, kernel-team@meta.com, sanmanpradhan@meta.com,
	sdf@fomichev.me, jdamato@fastly.com
Subject: Re: [PATCH net-next v2 1/2] eth: fbnic: Add ethtool support for fbnic
Message-ID: <Zs7D5hij6gQOiEGc@mev-dev.igk.intel.com>
References: <20240827205904.1944066-1-mohsin.bashr@gmail.com>
 <20240827205904.1944066-2-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827205904.1944066-2-mohsin.bashr@gmail.com>

On Tue, Aug 27, 2024 at 01:59:03PM -0700, Mohsin Bashir wrote:
> Add ethtool ops support and enable 'get_drvinfo' for fbnic. The driver
> provides firmware version information while the driver name and bus
> information is provided by ethtool_get_drvinfo().
> 
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
> v2:
> - Update the emptiness check for firmware version commit string
> - Rebase to the latest
> 
> v1: https://lore.kernel.org/netdev/20240807002445.3833895-1-mohsin.bashr@gmail.com

Correct link:
https://lore.kernel.org/netdev/20240822184944.3882360-1-mohsin.bashr@gmail.com/

> ---
>  drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
>  drivers/net/ethernet/meta/fbnic/fbnic.h       |  3 +++
>  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 26 +++++++++++++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 13 ++++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  6 ++---
>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  2 ++
>  .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  1 +
>  7 files changed, 49 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
> index 9373b558fdc9..37cfc34a5118 100644
> --- a/drivers/net/ethernet/meta/fbnic/Makefile
> +++ b/drivers/net/ethernet/meta/fbnic/Makefile
> @@ -8,6 +8,7 @@
>  obj-$(CONFIG_FBNIC) += fbnic.o
>  
>  fbnic-y := fbnic_devlink.o \
> +	   fbnic_ethtool.o \
>  	   fbnic_fw.o \
>  	   fbnic_irq.o \
>  	   fbnic_mac.o \
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
> index ad2689bfd6cb..28d970f81bfc 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
> @@ -132,6 +132,9 @@ void fbnic_free_irq(struct fbnic_dev *dev, int nr, void *data);
>  void fbnic_free_irqs(struct fbnic_dev *fbd);
>  int fbnic_alloc_irqs(struct fbnic_dev *fbd);
>  
> +void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
> +				 const size_t str_sz);
> +
>  enum fbnic_boards {
>  	fbnic_board_asic
>  };
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> new file mode 100644
> index 000000000000..7064dfc9f5b0
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -0,0 +1,26 @@
> +#include <linux/ethtool.h>
> +#include <linux/netdevice.h>
> +#include <linux/pci.h>
> +
> +#include "fbnic.h"
> +#include "fbnic_netdev.h"
> +#include "fbnic_tlv.h"
> +
> +static void
> +fbnic_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
> +{
> +	struct fbnic_net *fbn = netdev_priv(netdev);
> +	struct fbnic_dev *fbd = fbn->fbd;
> +
> +	fbnic_get_fw_ver_commit_str(fbd, drvinfo->fw_version,
> +				    sizeof(drvinfo->fw_version));
> +}
> +
> +static const struct ethtool_ops fbnic_ethtool_ops = {
> +	.get_drvinfo		= fbnic_get_drvinfo,
> +};
> +
> +void fbnic_set_ethtool_ops(struct net_device *dev)
> +{
> +	dev->ethtool_ops = &fbnic_ethtool_ops;
> +}
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> index 0c6e1b4c119b..8f7a2a19ddf8 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> @@ -789,3 +789,16 @@ void fbnic_mbx_flush_tx(struct fbnic_dev *fbd)
>  		count += (tx_mbx->head - head) % FBNIC_IPC_MBX_DESC_LEN;
>  	} while (count < FBNIC_IPC_MBX_DESC_LEN && --attempts);
>  }
> +
> +void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
> +				 const size_t str_sz)
Don't you need a prototype for this function?

> +{
> +	struct fbnic_fw_ver *mgmt = &fbd->fw_cap.running.mgmt;
> +	const char *delim = "";
> +
> +	if (mgmt->commit[0])
> +		delim = "_";
> +
> +	fbnic_mk_full_fw_ver_str(mgmt->version, delim, mgmt->commit,
> +				 fw_version, str_sz);
> +}
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> index c65bca613665..221faf8c6756 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> @@ -53,10 +53,10 @@ int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership);
>  int fbnic_fw_init_heartbeat(struct fbnic_dev *fbd, bool poll);
>  void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd);
>  
> -#define fbnic_mk_full_fw_ver_str(_rev_id, _delim, _commit, _str)	\
> +#define fbnic_mk_full_fw_ver_str(_rev_id, _delim, _commit, _str, _str_sz) \
>  do {									\
>  	const u32 __rev_id = _rev_id;					\
> -	snprintf(_str, sizeof(_str), "%02lu.%02lu.%02lu-%03lu%s%s",	\
> +	snprintf(_str, _str_sz, "%02lu.%02lu.%02lu-%03lu%s%s",	\
>  		 FIELD_GET(FBNIC_FW_CAP_RESP_VERSION_MAJOR, __rev_id),	\
>  		 FIELD_GET(FBNIC_FW_CAP_RESP_VERSION_MINOR, __rev_id),	\
>  		 FIELD_GET(FBNIC_FW_CAP_RESP_VERSION_PATCH, __rev_id),	\
> @@ -65,7 +65,7 @@ do {									\
>  } while (0)
>  
>  #define fbnic_mk_fw_ver_str(_rev_id, _str) \
> -	fbnic_mk_full_fw_ver_str(_rev_id, "", "", _str)
> +	fbnic_mk_full_fw_ver_str(_rev_id, "", "", _str, sizeof(_str))
>  
>  #define FW_HEARTBEAT_PERIOD		(10 * HZ)
>  
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> index 571374361259..a400616a24d4 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> @@ -521,6 +521,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
>  	netdev->netdev_ops = &fbnic_netdev_ops;
>  	netdev->stat_ops = &fbnic_stat_ops;
>  
> +	fbnic_set_ethtool_ops(netdev);
> +
>  	fbn = netdev_priv(netdev);
>  
>  	fbn->netdev = netdev;
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> index 60199e634468..6c27da09a612 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> @@ -58,6 +58,7 @@ int fbnic_netdev_register(struct net_device *netdev);
>  void fbnic_netdev_unregister(struct net_device *netdev);
>  void fbnic_reset_queues(struct fbnic_net *fbn,
>  			unsigned int tx, unsigned int rx);
> +void fbnic_set_ethtool_ops(struct net_device *dev);
Isn't it cleaner to have it in sth like fbnic_ethtool.h file? Probably
you will have more functions there in the future.

Thanks,
Michal

>  
>  void __fbnic_set_rx_mode(struct net_device *netdev);
>  void fbnic_clear_rx_mode(struct net_device *netdev);
> -- 
> 2.43.5
>

