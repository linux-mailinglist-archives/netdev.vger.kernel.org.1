Return-Path: <netdev+bounces-99971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE438D7426
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 09:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54802281C31
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 07:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF831C6BD;
	Sun,  2 Jun 2024 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oTDjHXAY"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5870C18E1E;
	Sun,  2 Jun 2024 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717313733; cv=none; b=sGehwyrQmXXXE/nlqD+zvrgq5uOqxxbEG7vT+BQP+QS2hmo+sjQlTXwvzCvZIxJpBGAxxYHToG+zLaX2B1JRcoQBDKSlFuMYF420gVEKdM5L1Lh+VbViGgY1bDjeWDn/4av4ayWXl9GfQzgyEcWZz3hgt3NNVn41g5DllBxnFOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717313733; c=relaxed/simple;
	bh=WrL/dzPK6dyk4/rUnyH625rKKaobfOcsBjRdT0BEGjM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Izo2vx8I+2dyTbQr3rc5pLR5PAdFEcPdFAaWwyoQtB3V7Um1WyJq24vplKLuCHRPmzFQf4VbEdy9bx0bR3o+rAs50xNfwpzR/8/18PqIInaFryormjIoMhr6tH1EniszzNtQoGl+bMd/XA0RF0b/iigxfcv+LRVvNdjRv8eoWhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oTDjHXAY; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4527ZDZi047118;
	Sun, 2 Jun 2024 02:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717313713;
	bh=NPwiSUWPZffMQdrpny0/ObFSmYXer4XLAJ1sktspOOI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=oTDjHXAYn6d+/GjzRxJYhe+98WNfA3qOkIZneWTAQdtvqZbV/IItW0tIvAVMIZunW
	 Et/5GdiLc/4HKk5h6s3mp+brHalefTdVQYcs+d3iilsGCWGeJjgGuoABcFjKvnvwpb
	 pcjxzW/oT0t8wQxMxxDDhs1FwFB+8yCfxawWdo6c=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4527ZDaW001002
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Jun 2024 02:35:13 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Jun 2024 02:35:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Jun 2024 02:35:12 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4527ZCpK035720;
	Sun, 2 Jun 2024 02:35:12 -0500
Date: Sun, 2 Jun 2024 13:05:11 +0530
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
Message-ID: <70166bc4-2c55-4a46-b442-4a3c49d6d64d@ti.com>
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
>  #endif /* __ICVE_RPMSG_COMMON_H__ */
> diff --git a/drivers/net/ethernet/ti/inter_core_virt_eth.c b/drivers/net/ethernet/ti/inter_core_virt_eth.c
> index bea822d2373a..d96547d317fe 100644
> --- a/drivers/net/ethernet/ti/inter_core_virt_eth.c
> +++ b/drivers/net/ethernet/ti/inter_core_virt_eth.c
> @@ -6,11 +6,145 @@
>  
>  #include "inter_core_virt_eth.h"

[...]

>  
> +static int create_request(struct icve_common *common,
> +			  enum icve_rpmsg_type rpmsg_type)
> +{
> +	struct message *msg = &common->send_msg;
> +	int ret = 0;
> +
> +	msg->msg_hdr.src_id = common->port->port_id;
> +	msg->req_msg.type = rpmsg_type;
> +
> +	switch (rpmsg_type) {
> +	case ICVE_REQ_SHM_INFO:
> +		msg->msg_hdr.msg_type = ICVE_REQUEST_MSG;
> +		break;
> +	case ICVE_REQ_SET_MAC_ADDR:
> +		msg->msg_hdr.msg_type = ICVE_REQUEST_MSG;
> +		ether_addr_copy(msg->req_msg.mac_addr.addr,
> +				common->port->ndev->dev_addr);
> +		break;
> +	case ICVE_NOTIFY_PORT_UP:
> +	case ICVE_NOTIFY_PORT_DOWN:
> +		msg->msg_hdr.msg_type = ICVE_NOTIFY_MSG;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		dev_err(common->dev, "Invalid RPMSG request\n");
> +	};
> +	return ret;
> +}
> +
> +static int icve_create_send_request(struct icve_common *common,
> +				    enum icve_rpmsg_type rpmsg_type,
> +				    bool wait)
> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	if (wait)
> +		reinit_completion(&common->sync_msg);
> +
> +	spin_lock_irqsave(&common->send_msg_lock, flags);
> +	create_request(common, rpmsg_type);

Why isn't the return value of create_request() being checked?
If it is guaranteed to always return 0 based on the design, convert it
to a void function.

> +	rpmsg_send(common->rpdev->ept, (void *)(&common->send_msg),
> +		   sizeof(common->send_msg));
> +	spin_unlock_irqrestore(&common->send_msg_lock, flags);
> +
> +	if (wait) {
> +		ret = wait_for_completion_timeout(&common->sync_msg,
> +						  ICVE_REQ_TIMEOUT);
> +
> +		if (!ret) {
> +			dev_err(common->dev, "Failed to receive response within %ld jiffies\n",
> +				ICVE_REQ_TIMEOUT);
> +			ret = -ETIMEDOUT;
> +			return ret;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static void icve_state_machine(struct work_struct *work)
> +{
> +	struct delayed_work *dwork = to_delayed_work(work);
> +	struct icve_common *common;
> +	struct icve_port *port;
> +
> +	common = container_of(dwork, struct icve_common, state_work);
> +	port = common->port;
> +
> +	mutex_lock(&common->state_lock);
> +
> +	switch (common->state) {
> +	case ICVE_STATE_PROBE:
> +		break;
> +	case ICVE_STATE_OPEN:
> +		icve_create_send_request(common, ICVE_REQ_SHM_INFO, false);

The return value of icve_create_send_request() is not being checked. Is
it guaranteed to succeed? Where is the error handling path if
icve_create_send_request() fails?

> +		break;
> +	case ICVE_STATE_CLOSE:
> +		break;
> +	case ICVE_STATE_READY:
> +		icve_create_send_request(common, ICVE_REQ_SET_MAC_ADDR, false);

Same here and at all other places where icve_create_send_request() is
being invoked. The icve_create_send_request() seems to be newly added in
this version of the series and wasn't there in the RFC patch. This should
be mentioned in the Changelog.

[...]

Regards,
Siddharth.

