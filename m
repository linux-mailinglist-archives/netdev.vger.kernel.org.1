Return-Path: <netdev+bounces-230892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEADEBF1577
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 14:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E373B53A9
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38163126DB;
	Mon, 20 Oct 2025 12:52:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07307EAF9;
	Mon, 20 Oct 2025 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964750; cv=none; b=IegvyONC7CnR0NHuLRPtELHXTy8rTc3rpX9LcfSrRcmyjJckvC2bECFAgHlBvLSBZrouxRazooBZQV9NJGvJpa/z+OEZMRW71JUE/urYcrT2MYYVtb9a0iUwuiID8e9a8vhOhqUjkFzCTg1PtZlBXO4LNA8a17t9OZ0vSqddFyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964750; c=relaxed/simple;
	bh=lAqAFT4GVUeCpwBeJIgV5QqxXzg23w/OzLcrc2FHEKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwoVvcAJuZvAl8FQHDmIF6sxAueIM8v08Wx6jYTwOk8JhrkA4/qyWDQ6oWogU/wXdvoDdokSCpbIDedU6eCoNgogNeD1ZycP2Pzv3Fk8L8+YJ16ryZl9yacDhLDdpQGmbH7Z/RtZyUHKDxjQ1Dk1/JmjKHeyvDCxe4pEvtrR6w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C8C41007;
	Mon, 20 Oct 2025 05:52:17 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9E4B3F66E;
	Mon, 20 Oct 2025 05:52:22 -0700 (PDT)
Date: Mon, 20 Oct 2025 13:52:20 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Adam Young <admiyo@os.amperecomputing.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH  v30 2/3] mailbox: pcc: functions for reading and writing
 PCC extended data
Message-ID: <20251020-honored-cat-of-elevation-59b6c4@sudeepholla>
References: <20251016210225.612639-1-admiyo@os.amperecomputing.com>
 <20251016210225.612639-3-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016210225.612639-3-admiyo@os.amperecomputing.com>

On Thu, Oct 16, 2025 at 05:02:20PM -0400, Adam Young wrote:
> Adds functions that aid in compliance with the PCC protocol by
> checking the command complete flag status.
> 
> Adds a function that exposes the size of the shared buffer without
> activating the channel.
> 
> Adds a function that allows a client to query the number of bytes
> avaialbel to read in order to preallocate buffers for reading.
> 
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>  drivers/mailbox/pcc.c | 129 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/pcc.h    |  38 +++++++++++++
>  2 files changed, 167 insertions(+)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 978a7b674946..653897d61db5 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -367,6 +367,46 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> +static
> +struct pcc_chan_info *lookup_channel_info(int subspace_id)
> +{
> +	struct pcc_chan_info *pchan;
> +	struct mbox_chan *chan;
> +
> +	if (subspace_id < 0 || subspace_id >= pcc_chan_count)
> +		return ERR_PTR(-ENOENT);
> +
> +	pchan = chan_info + subspace_id;
> +	chan = pchan->chan.mchan;
> +	if (IS_ERR(chan) || chan->cl) {
> +		pr_err("Channel not found for idx: %d\n", subspace_id);
> +		return ERR_PTR(-EBUSY);
> +	}
> +	return pchan;
> +}
> +
> +/**
> + * pcc_mbox_buffer_size - PCC clients call this function to
> + *		request the size of the shared buffer in cases
> + *              where requesting the channel would prematurely
> + *              trigger channel activation and message delivery.
> + * @subspace_id: The PCC Subspace index as parsed in the PCC client
> + *		ACPI package. This is used to lookup the array of PCC
> + *		subspaces as parsed by the PCC Mailbox controller.
> + *
> + * Return: The size of the shared buffer.
> + */
> +int pcc_mbox_buffer_size(int index)
> +{
> +	struct pcc_chan_info *pchan = lookup_channel_info(index);
> +
> +	if (IS_ERR(pchan))
> +		return -1;
> +	return pchan->chan.shmem_size;
> +}
> +EXPORT_SYMBOL_GPL(pcc_mbox_buffer_size);
> +

Why do you need to export this when you can grab this from
struct pcc_mbox_chan which is returned from pcc_mbox_request_channel().

Please drop the above 2 functions completely.

> +
>  /**
>   * pcc_mbox_request_channel - PCC clients call this function to
>   *		request a pointer to their PCC subspace, from which they
> @@ -437,6 +477,95 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
>  }
>  EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
>  
> +/**
> + * pcc_mbox_query_bytes_available
> + *
> + * @pchan pointer to channel associated with buffer
> + * Return: the number of bytes available to read from the shared buffer
> + */
> +int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan)
> +{
> +	struct pcc_extended_header pcc_header;
> +	struct pcc_chan_info *pinfo = pchan->mchan->con_priv;
> +	int data_len;
> +	u64 val;
> +
> +	pcc_chan_reg_read(&pinfo->cmd_complete, &val);
> +	if (val) {
> +		pr_info("%s Buffer not enabled for reading", __func__);
> +		return -1;
> +	}

Why would you call pcc_mbox_query_bytes_available() if the transfer is
not complete ?

> +	memcpy_fromio(&pcc_header, pchan->shmem,
> +		      sizeof(pcc_header));
> +	data_len = pcc_header.length - sizeof(u32) + sizeof(pcc_header);

Why are you adding the header size to the length above ?

> +	return data_len;
> +}
> +EXPORT_SYMBOL_GPL(pcc_mbox_query_bytes_available);
> +
> +/**
> + * pcc_mbox_read_from_buffer - Copy bytes from shared buffer into data
> + *
> + * @pchan - channel associated with the shared buffer
> + * @len - number of bytes to read
> + * @data - pointer to memory in which to write the data from the
> + *         shared buffer
> + *
> + * Return: number of bytes read and written into daa
> + */
> +int pcc_mbox_read_from_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
> +{
> +	struct pcc_chan_info *pinfo = pchan->mchan->con_priv;
> +	int data_len;
> +	u64 val;
> +
> +	pcc_chan_reg_read(&pinfo->cmd_complete, &val);
> +	if (val) {
> +		pr_info("%s buffer not enabled for reading", __func__);
> +		return -1;
> +	}

Ditto as above, why is this check necessary ?

> +	data_len  = pcc_mbox_query_bytes_available(pchan);
> +	if (len < data_len)
> +		data_len = len;
> +	memcpy_fromio(data, pchan->shmem, len);
> +	return len;
> +}
> +EXPORT_SYMBOL_GPL(pcc_mbox_read_from_buffer);
> +
> +/**
> + * pcc_mbox_write_to_buffer, copy the contents of the data
> + * pointer to the shared buffer.  Confirms that the command
> + * flag has been set prior to writing.  Data should be a
> + * properly formatted extended data buffer.
> + * pcc_mbox_write_to_buffer
> + * @pchan: channel
> + * @len: Length of the overall buffer passed in, including the
> + *       Entire header. The length value in the shared buffer header
> + *       Will be calculated from len.
> + * @data: Client specific data to be written to the shared buffer.
> + * Return: number of bytes written to the buffer.
> + */
> +int pcc_mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
> +{
> +	struct pcc_extended_header *pcc_header = data;
> +	struct mbox_chan *mbox_chan = pchan->mchan;
> +
> +	/*
> +	 * The PCC header length includes the command field
> +	 * but not the other values from the header.
> +	 */
> +	pcc_header->length = len - sizeof(struct pcc_extended_header) + sizeof(u32);
> +
> +	if (!pcc_last_tx_done(mbox_chan)) {
> +		pr_info("%s pchan->cmd_complete not set.", __func__);
> +		return 0;
> +	}

The mailbox moves to next message only if the last tx is done. Why is
this check necessary ?

> +	memcpy_toio(pchan->shmem,  data, len);
> +
> +	return len;
> +}
> +EXPORT_SYMBOL_GPL(pcc_mbox_write_to_buffer);
> +
> 

I am thinking if reading and writing to shmem can be made inline helper.
Let me try to hack up something add see how that would look like.

>  /**
>   * pcc_send_data - Called from Mailbox Controller code. Used
>   *		here only to ring the channel doorbell. The PCC client
> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
> index 840bfc95bae3..96a6f85fc1ba 100644
> --- a/include/acpi/pcc.h
> +++ b/include/acpi/pcc.h
> @@ -19,6 +19,13 @@ struct pcc_mbox_chan {
>  	u16 min_turnaround_time;
>  };
>  
> +struct pcc_extended_header {
> +	u32 signature;
> +	u32 flags;
> +	u32 length;
> +	u32 command;
> +};
> +

This again is a duplicate of struct acpi_pcct_ext_pcc_shared_memory.
It can be dropped.

-- 
Regards,
Sudeep

