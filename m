Return-Path: <netdev+bounces-198970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB6EADE772
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7AB33AB32E
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAA527F01C;
	Wed, 18 Jun 2025 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kuDyS5c2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B62556E
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750240049; cv=none; b=uNxmrR/jHAfAIaTZRF05DcLA4kgRHcsYcdsKHfe53V+aUXz73hqh3mMOK/mqaE94QOEJ9PFuGOMONtCtqDRAp4CJ4t6x7hpa7MTJJuv/qQI87496DGBc23Gpdl9W+G6ZK4sZiSmtgGen177JyoY9jvpIJNxs+/nZZt8HJv75SRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750240049; c=relaxed/simple;
	bh=/qNcIRScNoYh6m/SAdrzxTbXgsIJn06Jdeoce3V67Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETV01ELXqfVcKG6QyClTjINWJX/AwiBjI8Fhh9K+kwQ+Q26C5XVh8yr9KwL1P8alRytw9f4HeTh6d/cUimyLKPjG6d7ST+QdHX7LwtSqIE3jrZ3/Bt6VVA3crzc4eAD0PmNfIlCF0AmIgej4lE4MMDBbpTAod9J8vMfDoDmFKeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kuDyS5c2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750240047; x=1781776047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/qNcIRScNoYh6m/SAdrzxTbXgsIJn06Jdeoce3V67Lk=;
  b=kuDyS5c2RHXTY3vpVYc+sZy/iOT6l6iNfFf+gsaTADgJJOSYn4oLWSz6
   nZXyng+BxjIl8Akf39lh12+BKQuAjPNdcMz/mFvg4qYCilXsTW42ru4wB
   7yUDdYJAOtk0Rh3ePrqp/rcucrZrlwVR5nU4nHvugAaICAM2ADarBfjNy
   DB1pYx4WE1GZf4O/uNyOqspyAv4+QrRUN6fR7nXECgBa4jggT6cgewdq2
   hRF/2DgBwo3BkoWzyj3ROA2e4yyjwRHgzdg9s7vVd9L3TuW7bE2L6fK/Z
   uRvb/FHadae58n2OpqrKwMroCP7rN0KACdrUuxlVWJmIQjShlmho/3Mkp
   Q==;
X-CSE-ConnectionGUID: Q5gkiBddTtiPY6fZe9dmbA==
X-CSE-MsgGUID: /690OSFLTsun5OB7OBfj4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="51673461"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="51673461"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 02:47:26 -0700
X-CSE-ConnectionGUID: RvnqTE3zTIO2khs0Y9iWXw==
X-CSE-MsgGUID: alpGMoVwSdm56rl88xrkbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="150200215"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 02:47:24 -0700
Date: Wed, 18 Jun 2025 11:46:33 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com, jiawenwu@net-swift.com
Subject: Re: [PATCH net-next 01/12] net: libwx: add mailbox api for wangxun
 vf drivers
Message-ID: <aFKK+SiUG1jMXr10@mev-dev.igk.intel.com>
References: <20250611083559.14175-1-mengyuanlou@net-swift.com>
 <20250611083559.14175-2-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611083559.14175-2-mengyuanlou@net-swift.com>

On Wed, Jun 11, 2025 at 04:35:48PM +0800, Mengyuan Lou wrote:
> Implements the mailbox interfaces for Wangxun vf drivers which
> will be used in txgbevf and ngbevf.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_mbx.c  | 256 +++++++++++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_mbx.h  |  22 ++
>  drivers/net/ethernet/wangxun/libwx/wx_type.h |   3 +
>  3 files changed, 281 insertions(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.c b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
> index 73af5f11c3bd..ebfa07d50bd2 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
> @@ -174,3 +174,259 @@ int wx_check_for_rst_pf(struct wx *wx, u16 vf)
>  
>  	return 0;
>  }
> +
> +static u32 wx_read_v2p_mailbox(struct wx *wx)
> +{
> +	u32 mailbox = rd32(wx, WX_VXMAILBOX);
> +
> +	mailbox |= wx->mbx.mailbox;
> +	wx->mbx.mailbox |= mailbox & WX_VXMAILBOX_R2C_BITS;
> +
> +	return mailbox;
> +}
> +
> +/**
> + *  wx_obtain_mbx_lock_vf - obtain mailbox lock
> + *  @wx: pointer to the HW structure
> + *
> + *  Return: return 0 on success and -EBUSY on failure
> + **/
> +static int wx_obtain_mbx_lock_vf(struct wx *wx)
> +{
> +	int count = 5;
> +	u32 mailbox;
> +
> +	while (count--) {
> +		/* Take ownership of the buffer */
> +		wr32(wx, WX_VXMAILBOX, WX_VXMAILBOX_VFU);
> +
> +		/* reserve mailbox for vf use */
> +		mailbox = wx_read_v2p_mailbox(wx);
> +		if (mailbox & WX_VXMAILBOX_VFU)
> +			return 0;
> +	}

You can try to use read_poll_timeout(). In other poll also.

> +
> +	wx_err(wx, "Failed to obtain mailbox lock for VF.\n");
> +
> +	return -EBUSY;
> +}
> +
> +static int wx_check_for_bit_vf(struct wx *wx, u32 mask)
> +{
> +	u32 mailbox = wx_read_v2p_mailbox(wx);
> +
> +	wx->mbx.mailbox &= ~mask;
> +
> +	return (mailbox & mask ? 0 : -EBUSY);
> +}
> +
> +/**
> + *  wx_check_for_ack_vf - checks to see if the PF has ACK'd
> + *  @wx: pointer to the HW structure
> + *
> + *  Return: return 0 if the PF has set the status bit or else -EBUSY
> + **/
> +static int wx_check_for_ack_vf(struct wx *wx)
> +{
> +	/* read clear the pf ack bit */
> +	return wx_check_for_bit_vf(wx, WX_VXMAILBOX_PFACK);
> +}
> +
> +/**
> + *  wx_check_for_msg_vf - checks to see if the PF has sent mail
> + *  @wx: pointer to the HW structure
> + *
> + *  Return: return 0 if the PF has got req bit or else -EBUSY
> + **/
> +int wx_check_for_msg_vf(struct wx *wx)
> +{
> +	/* read clear the pf sts bit */
> +	return wx_check_for_bit_vf(wx, WX_VXMAILBOX_PFSTS);
> +}
> +
> +/**
> + *  wx_check_for_rst_vf - checks to see if the PF has reset
> + *  @wx: pointer to the HW structure
> + *
> + *  Return: return 0 if the PF has set the reset done and -EBUSY on failure
> + **/
> +int wx_check_for_rst_vf(struct wx *wx)
> +{
> +	/* read clear the pf reset done bit */
> +	return wx_check_for_bit_vf(wx,
> +				   WX_VXMAILBOX_RSTD |
> +				   WX_VXMAILBOX_RSTI);
> +}
> +
> +/**
> + *  wx_poll_for_msg - Wait for message notification
> + *  @wx: pointer to the HW structure
> + *
> + *  Return: return 0 if the VF has successfully received a message notification
> + **/
> +static int wx_poll_for_msg(struct wx *wx)
> +{
> +	struct wx_mbx_info *mbx = &wx->mbx;
> +	int countdown = mbx->timeout;
> +
> +	while (countdown && wx_check_for_msg_vf(wx)) {
> +		countdown--;
> +		if (!countdown)
> +			break;
> +		udelay(mbx->udelay);
> +	}

Here

> +
> +	return countdown ? 0 : -EBUSY;
> +}
> +
> +/**
> + *  wx_poll_for_ack - Wait for message acknowledgment
> + *  @wx: pointer to the HW structure
> + *
> + *  Return: return 0 if the VF has successfully received a message ack
> + **/
> +static int wx_poll_for_ack(struct wx *wx)
> +{
> +	struct wx_mbx_info *mbx = &wx->mbx;
> +	int countdown = mbx->timeout;
> +
> +	while (countdown && wx_check_for_ack_vf(wx)) {
> +		countdown--;
> +		if (!countdown)
> +			break;
> +		udelay(mbx->udelay);
> +	}

And here

> +
> +	return countdown ? 0 : -EBUSY;
> +}
> +
> +/**
> + *  wx_read_posted_mbx - Wait for message notification and receive message
> + *  @wx: pointer to the HW structure
> + *  @msg: The message buffer
> + *  @size: Length of buffer
> + *
> + *  Return: returns 0 if it successfully received a message notification and
> + *  copied it into the receive buffer.
> + **/
> +int wx_read_posted_mbx(struct wx *wx, u32 *msg, u16 size)
> +{
> +	int ret;
> +
> +	ret = wx_poll_for_msg(wx);
> +	/* if ack received read message, otherwise we timed out */
> +	if (!ret)
> +		ret = wx_read_mbx_vf(wx, msg, size);
> +
> +	return ret;

Nit, but usuall error path is in if statement. Sth like:

if (ret)
	return ret;

return wx_read_mbx_vf();

can be more readable for someone.

> +}
> +
> +/**
> + *  wx_write_posted_mbx - Write a message to the mailbox, wait for ack
> + *  @wx: pointer to the HW structure
> + *  @msg: The message buffer
> + *  @size: Length of buffer
> + *
> + *  Return: returns 0 if it successfully copied message into the buffer and
> + *  received an ack to that message within delay * timeout period
> + **/
> +int wx_write_posted_mbx(struct wx *wx, u32 *msg, u16 size)
> +{
> +	int ret;
> +
> +	/* send msg */
> +	ret = wx_write_mbx_vf(wx, msg, size);
> +	/* if msg sent wait until we receive an ack */
> +	if (!ret)
> +		ret = wx_poll_for_ack(wx);
> +
> +	return ret;
> +}
> +
> +/**
> + *  wx_write_mbx_vf - Write a message to the mailbox
> + *  @wx: pointer to the HW structure
> + *  @msg: The message buffer
> + *  @size: Length of buffer
> + *
> + *  Return: returns 0 if it successfully copied message into the buffer
> + **/
> +int wx_write_mbx_vf(struct wx *wx, u32 *msg, u16 size)
> +{
> +	struct wx_mbx_info *mbx = &wx->mbx;
> +	int ret, i;
> +
> +	/* mbx->size is up to 15 */
> +	if (size > mbx->size) {
> +		wx_err(wx, "Invalid mailbox message size %d", size);
> +		return -EINVAL;
> +	}
> +
> +	/* lock the mailbox to prevent pf/vf race condition */
> +	ret = wx_obtain_mbx_lock_vf(wx);
> +	if (ret)
> +		return ret;
> +
> +	/* flush msg and acks as we are overwriting the message buffer */
> +	wx_check_for_msg_vf(wx);
> +	wx_check_for_ack_vf(wx);

Isn't checking returned value needed here?

> +
> +	/* copy the caller specified message to the mailbox memory buffer */
> +	for (i = 0; i < size; i++)
> +		wr32a(wx, WX_VXMBMEM, i, msg[i]);
> +
> +	/* Drop VFU and interrupt the PF to tell it a message has been sent */
> +	wr32(wx, WX_VXMAILBOX, WX_VXMAILBOX_REQ);

It isn't clear that it drops lock, maybe do it in a function like
wx_drop_mbx_lock_vf()? (just preference)

> +
> +	return 0;
> +}
> +
> +/**
> + *  wx_read_mbx_vf - Reads a message from the inbox intended for vf
> + *  @wx: pointer to the HW structure
> + *  @msg: The message buffer
> + *  @size: Length of buffer
> + *
> + *  Return: returns 0 if it successfully copied message into the buffer
> + **/
> +int wx_read_mbx_vf(struct wx *wx, u32 *msg, u16 size)
> +{
> +	struct wx_mbx_info *mbx = &wx->mbx;
> +	int ret;
> +	u16 i;

int ret, i; like in previous function

> +
> +	/* limit read to size of mailbox and mbx->size is up to 15 */
> +	if (size > mbx->size)
> +		size = mbx->size;
> +
> +	/* lock the mailbox to prevent pf/vf race condition */
> +	ret = wx_obtain_mbx_lock_vf(wx);
> +	if (ret)
> +		return ret;
> +
> +	/* copy the message from the mailbox memory buffer */
> +	for (i = 0; i < size; i++)
> +		msg[i] = rd32a(wx, WX_VXMBMEM, i);
> +
> +	/* Acknowledge receipt and release mailbox, then we're done */
> +	wr32(wx, WX_VXMAILBOX, WX_VXMAILBOX_ACK);

Oh, so any value written into WX_VXMAILVOX drop the lock. Ignore my
comment about function for that.

> +
> +	return 0;
> +}
> +
> +int wx_init_mbx_params_vf(struct wx *wx)
> +{
> +	wx->vfinfo = kcalloc(1, sizeof(struct vf_data_storage),
> +			     GFP_KERNEL);

Why kcalloc() for 1 element?

> +	if (!wx->vfinfo)
> +		return -ENOMEM;
> +
> +	/* Initialize mailbox parameters */
> +	wx->mbx.size = WX_VXMAILBOX_SIZE;
> +	wx->mbx.mailbox = WX_VXMAILBOX;
> +	wx->mbx.udelay = 10;
> +	wx->mbx.timeout = 1000;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(wx_init_mbx_params_vf);
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
> index 05aae138dbc3..82df9218490a 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
> @@ -11,6 +11,20 @@
>  #define WX_PXMAILBOX_ACK     BIT(1) /* Ack message recv'd from VF */
>  #define WX_PXMAILBOX_PFU     BIT(3) /* PF owns the mailbox buffer */
>  
> +/* VF Registers */
> +#define WX_VXMAILBOX         0x600
> +#define WX_VXMAILBOX_REQ     BIT(0) /* Request for PF Ready bit */
> +#define WX_VXMAILBOX_ACK     BIT(1) /* Ack PF message received */
> +#define WX_VXMAILBOX_VFU     BIT(2) /* VF owns the mailbox buffer */
> +#define WX_VXMAILBOX_PFU     BIT(3) /* PF owns the mailbox buffer */
> +#define WX_VXMAILBOX_PFSTS   BIT(4) /* PF wrote a message in the MB */
> +#define WX_VXMAILBOX_PFACK   BIT(5) /* PF ack the previous VF msg */
> +#define WX_VXMAILBOX_RSTI    BIT(6) /* PF has reset indication */
> +#define WX_VXMAILBOX_RSTD    BIT(7) /* PF has indicated reset done */
> +#define WX_VXMAILBOX_R2C_BITS (WX_VXMAILBOX_RSTD | \
> +	    WX_VXMAILBOX_PFSTS | WX_VXMAILBOX_PFACK)
> +
> +#define WX_VXMBMEM           0x00C00 /* 16*4B */
>  #define WX_PXMBMEM(i)        (0x5000 + (64 * (i))) /* i=[0,63] */
>  
>  #define WX_VFLRE(i)          (0x4A0 + (4 * (i))) /* i=[0,1] */
> @@ -74,4 +88,12 @@ int wx_check_for_rst_pf(struct wx *wx, u16 mbx_id);
>  int wx_check_for_msg_pf(struct wx *wx, u16 mbx_id);
>  int wx_check_for_ack_pf(struct wx *wx, u16 mbx_id);
>  
> +int wx_read_posted_mbx(struct wx *wx, u32 *msg, u16 size);
> +int wx_write_posted_mbx(struct wx *wx, u32 *msg, u16 size);
> +int wx_check_for_rst_vf(struct wx *wx);
> +int wx_check_for_msg_vf(struct wx *wx);
> +int wx_read_mbx_vf(struct wx *wx, u32 *msg, u16 size);
> +int wx_write_mbx_vf(struct wx *wx, u32 *msg, u16 size);
> +int wx_init_mbx_params_vf(struct wx *wx);
> +
>  #endif /* _WX_MBX_H_ */
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 7730c9fc3e02..f2061c893358 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -825,6 +825,9 @@ struct wx_bus_info {
>  
>  struct wx_mbx_info {
>  	u16 size;
> +	u32 mailbox;
> +	u32 udelay;
> +	u32 timeout;
>  };
>  
>  struct wx_thermal_sensor_data {
> -- 
> 2.30.1

