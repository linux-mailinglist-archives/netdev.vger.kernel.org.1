Return-Path: <netdev+bounces-99970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 850988D7418
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 09:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3544B281C1A
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 07:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E51D1BF53;
	Sun,  2 Jun 2024 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="swzICmPc"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1F18622;
	Sun,  2 Jun 2024 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717312972; cv=none; b=uPAFvy1Vj9x/wTbQIhJpzZtxorNYJz+6dJ/pHZtzL4y/NuLVQKOzYJLOslZmmt4KQbNkhxVrcBigDh3kEsD2MRNcx3HFhjbwT4YgFBYN0fydei9YELRTtpcv3kSj104t24G5kzWu7u1N7jOkCNZn2WL8nxILVImpy1DR4dxWcyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717312972; c=relaxed/simple;
	bh=5fxGNQvlCsuK+HkmVCYl0TkJtXY3bpZnE/pU+JXE13w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrBN3qxIlgRUoMZ44EUgAlZUJF5qniSUgLKcoNSHnswGmEohl7pW74dNotIgRjtqXOrvnp++AcguszGzF3q5fNYg7uRzJuEcmlIqcHuSa6GtTd8S95wBgjmU0dvV9N6IZxDQk57ejxR8R9/TPuc+QiUzIZ3dpdKMqDqn7oQR9EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=swzICmPc; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4527MKnx038835;
	Sun, 2 Jun 2024 02:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717312940;
	bh=0bQe2MMg1BGzsfZoS15d4Z/xa1p4naQh0k3czpfz3Ow=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=swzICmPcsNPq2ylZ1R9YJTRbawu11jhBvCvAyXPHjyA+hsZxjvrDRlhDONoyK8+oA
	 0NlLfdVjfGOBwrIHknxtlHAKlygpCbGb1zPIwnAT85c5W0gcDXKEeNa9NqpQP0IOGP
	 ZQUlpwPk9gSruXwDvP6BH6bcEbAejtdtofLsZskU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4527MKLx084660
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Jun 2024 02:22:20 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Jun 2024 02:22:19 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Jun 2024 02:22:19 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4527MIC5018831;
	Sun, 2 Jun 2024 02:22:19 -0500
Date: Sun, 2 Jun 2024 12:52:18 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Yojana Mallik <y-mallik@ti.com>
CC: <schnelle@linux.ibm.com>, <wsa+renesas@sang-engineering.com>,
        <diogo.ivo@siemens.com>, <rdunlap@infradead.org>, <horms@kernel.org>,
        <vigneshr@ti.com>, <rogerq@ti.com>, <danishanwar@ti.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH net-next v2 2/3] net: ethernet: ti: Register the RPMsg
 driver as network device
Message-ID: <cae9e96a-50ff-496d-93e7-fe1f16db7b89@ti.com>
References: <20240531064006.1223417-1-y-mallik@ti.com>
 <20240531064006.1223417-3-y-mallik@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240531064006.1223417-3-y-mallik@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Fri, May 31, 2024 at 12:10:05PM +0530, Yojana Mallik wrote:
> Register the RPMsg driver as network device and add support for
> basic ethernet functionality by using the shared memory for data
> plane.
> 
> The shared memory layout is as below, with the region between
> PKT_1_LEN to PKT_N modelled as circular buffer.
> 
> -------------------------
> |          HEAD         |
> -------------------------
> |          TAIL         |
> -------------------------
> |       PKT_1_LEN       |
> |         PKT_1         |
> -------------------------
> |       PKT_2_LEN       |
> |         PKT_2         |
> -------------------------
> |           .           |
> |           .           |
> -------------------------
> |       PKT_N_LEN       |
> |         PKT_N         |
> -------------------------
> 
> The offset between the HEAD and TAIL is polled to process the Rx packets.

The author of this patch from the RFC series is:
Ravi Gunasekaran <r-gunasekaran@ti.com>
The authorship should be preserved across versions unless the
implementation has changed drastically requiring major rework
(which doesn't seem to be the case for this patch based on the
Changelog).

> 
> Signed-off-by: Yojana Mallik <y-mallik@ti.com>
> ---
>  drivers/net/ethernet/ti/icve_rpmsg_common.h   |  86 ++++
>  drivers/net/ethernet/ti/inter_core_virt_eth.c | 453 +++++++++++++++++-
>  drivers/net/ethernet/ti/inter_core_virt_eth.h |  35 +-
>  3 files changed, 570 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icve_rpmsg_common.h b/drivers/net/ethernet/ti/icve_rpmsg_common.h
> index 7cd157479d4d..2e3833de14bd 100644
> --- a/drivers/net/ethernet/ti/icve_rpmsg_common.h
> +++ b/drivers/net/ethernet/ti/icve_rpmsg_common.h
> @@ -15,14 +15,58 @@ enum icve_msg_type {
>  	ICVE_NOTIFY_MSG,
>  };

[...]

>  
> +
>  #endif /* __ICVE_RPMSG_COMMON_H__ */
> diff --git a/drivers/net/ethernet/ti/inter_core_virt_eth.c b/drivers/net/ethernet/ti/inter_core_virt_eth.c
> index bea822d2373a..d96547d317fe 100644
> --- a/drivers/net/ethernet/ti/inter_core_virt_eth.c
> +++ b/drivers/net/ethernet/ti/inter_core_virt_eth.c
> @@ -6,11 +6,145 @@
>  
>  #include "inter_core_virt_eth.h"
>  
> +#define ICVE_MIN_PACKET_SIZE ETH_ZLEN
> +#define ICVE_MAX_PACKET_SIZE 1540 //(ETH_FRAME_LEN + ETH_FCS_LEN)

Is the commented portion above required?

> +#define ICVE_MAX_TX_QUEUES 1
> +#define ICVE_MAX_RX_QUEUES 1
> +
> +#define PKT_LEN_SIZE_TYPE sizeof(u32)
> +#define MAGIC_NUM_SIZE_TYPE sizeof(u32)
> +
> +/* 4 bytes to hold packet length and ICVE_MAX_PACKET_SIZE to hold packet */
> +#define ICVE_BUFFER_SIZE \
> +	(ICVE_MAX_PACKET_SIZE + PKT_LEN_SIZE_TYPE + MAGIC_NUM_SIZE_TYPE)
> +
> +#define RX_POLL_TIMEOUT 1000 /* 1000usec */

The macro name could be updated to contain "USEC" to make it clear that
the units are in microseconds. Same comment applies to other macros
below where they can be named to contain the units.

> +#define RX_POLL_JIFFIES (jiffies + usecs_to_jiffies(RX_POLL_TIMEOUT))
> +
> +#define STATE_MACHINE_TIME msecs_to_jiffies(100)
> +#define ICVE_REQ_TIMEOUT msecs_to_jiffies(100)
> +
> +#define icve_ndev_to_priv(ndev) ((struct icve_ndev_priv *)netdev_priv(ndev))
> +#define icve_ndev_to_port(ndev) (icve_ndev_to_priv(ndev)->port)

[...]

>  	u32 msg_type = msg->msg_hdr.msg_type;
>  	u32 rpmsg_type;
>  
> @@ -24,11 +158,79 @@ static int icve_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
>  		rpmsg_type = msg->resp_msg.type;
>  		dev_dbg(common->dev, "Msg type = %d; RPMsg type = %d\n",
>  			msg_type, rpmsg_type);
> +		switch (rpmsg_type) {
> +		case ICVE_RESP_SHM_INFO:
> +			/* Retrieve Tx and Rx shared memory info from msg */
> +			port->tx_buffer->head =

[...]

> +					sizeof(*port->rx_buffer->tail));
> +
> +			port->icve_rx_max_buffers =
> +				msg->resp_msg.shm_info.shm_info_rx.num_pkt_bufs;
> +
> +			mutex_lock(&common->state_lock);
> +			common->state = ICVE_STATE_READY;
> +			mutex_unlock(&common->state_lock);
> +
> +			mod_delayed_work(system_wq,
> +					 &common->state_work,
> +					 STATE_MACHINE_TIME);
> +
> +			break;
> +		case ICVE_RESP_SET_MAC_ADDR:
> +			break;
> +		}
> +
>  		break;
> +
>  	case ICVE_NOTIFY_MSG:
>  		rpmsg_type = msg->notify_msg.type;
> -		dev_dbg(common->dev, "Msg type = %d; RPMsg type = %d\n",
> -			msg_type, rpmsg_type);

Why does the debug message above have to be deleted? If it was not
required, it could have been omitted in the previous patch itself,
rather than adding it in the previous patch and removing it here.

> +		switch (rpmsg_type) {
> +		case ICVE_NOTIFY_REMOTE_READY:
> +			mutex_lock(&common->state_lock);
> +			common->state = ICVE_STATE_RUNNING;
> +			mutex_unlock(&common->state_lock);
> +
> +			mod_delayed_work(system_wq,
> +					 &common->state_work,
> +					 STATE_MACHINE_TIME);
> +			break;
> +		case ICVE_NOTIFY_PORT_UP:
> +		case ICVE_NOTIFY_PORT_DOWN:
> +			break;
> +		}
>  		break;
>  	default:

[...]

>  }
>  
> diff --git a/drivers/net/ethernet/ti/inter_core_virt_eth.h b/drivers/net/ethernet/ti/inter_core_virt_eth.h
> index 91a3aba96996..4fc420cb9eab 100644
> --- a/drivers/net/ethernet/ti/inter_core_virt_eth.h
> +++ b/drivers/net/ethernet/ti/inter_core_virt_eth.h
> @@ -14,14 +14,45 @@
>  #include <linux/rpmsg.h>
>  #include "icve_rpmsg_common.h"
>  
> +enum icve_state {
> +	ICVE_STATE_PROBE,
> +	ICVE_STATE_OPEN,
> +	ICVE_STATE_CLOSE,
> +	ICVE_STATE_READY,
> +	ICVE_STATE_RUNNING,
> +
> +};
> +
>  struct icve_port {
> +	struct icve_shared_mem *tx_buffer; /* Write buffer for data to be consumed remote side */
> +	struct icve_shared_mem *rx_buffer; /* Read buffer for data to be consumed by this driver */
> +	struct timer_list rx_timer;
>  	struct icve_common *common;
> -} __packed;

Is the "__packed" attribute no longer required, or was it overlooked?

> +	struct napi_struct rx_napi;
> +	u8 local_mac_addr[ETH_ALEN];
> +	struct net_device *ndev;
> +	u32 icve_tx_max_buffers;
> +	u32 icve_rx_max_buffers;
> +	u32 port_id;
> +};
>  
>  struct icve_common {
>  	struct rpmsg_device *rpdev;
> +	spinlock_t send_msg_lock; /* Acquire this lock while sending RPMsg */
> +	spinlock_t recv_msg_lock; /* Acquire this lock while processing received RPMsg */
> +	struct message send_msg;
> +	struct message recv_msg;
>  	struct icve_port *port;
>  	struct device *dev;
> -} __packed;

Same comment here as well.

[...]

There seem to be a lot of changes compared to the RFC patch which
haven't been mentioned in the Changelog. Please mention all the changes
when posting new versions.

Regards,
Siddharth.

