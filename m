Return-Path: <netdev+bounces-219885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A22E9B4396E
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5262A5E2933
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA6D2EE294;
	Thu,  4 Sep 2025 11:01:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536352D060C;
	Thu,  4 Sep 2025 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756983661; cv=none; b=bOWvO4/FTN17utTTdTK3ij0t32VZqDTigGl+2OqPdhoAshvY86rsdrfNMpH46HfzZRqeXn+q8zQ+29pnbIFeLAJ/UCSSip7Xm5XPmB0myyIXiTudIpXOREW+3AFpN2JcQEjx9WYNTK1e5/v2iOThbXm7rA5SyXmysaGGFnl/Y+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756983661; c=relaxed/simple;
	bh=xWRVw89k7h1Suf90F5RME/j9SuV8+qey+IWjsJE+7Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ocp9ozMnppT6HrtAtZaJDCIIOdiAznihKSSM2oItbQAexQO6Q8cHpuaNEVItGTtmFk4NW8e2BvmSiqw7Oh63AooEJ8XI9vkeTB1HCo9MNSvBDELdD5FoRu29Rc6naSobRbjGHLE9SCnoFXs8mjbXVXtL87Ph6QAjOTmpu1hWV+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B4131756;
	Thu,  4 Sep 2025 04:00:50 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8A9A3F6A8;
	Thu,  4 Sep 2025 04:00:55 -0700 (PDT)
Date: Thu, 4 Sep 2025 12:00:53 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: admiyo@os.amperecomputing.com
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v23 1/2] mailbox/pcc: support mailbox management of the
 shared buffer
Message-ID: <20250904-expert-invaluable-moose-eb5b7b@sudeepholla>
References: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
 <20250715001011.90534-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715001011.90534-2-admiyo@os.amperecomputing.com>

On Mon, Jul 14, 2025 at 08:10:07PM -0400, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
> 
> Define a new, optional, callback that allows the driver to
> specify how the return data buffer is allocated.  If that callback
> is set,  mailbox/pcc.c is now responsible for reading from and
> writing to the PCC shared buffer.
> 
> This also allows for proper checks of the Commnand complete flag
> between the PCC sender and receiver.
> 
> For Type 4 channels, initialize the command complete flag prior
> to accepting messages.
> 
> Since the mailbox does not know what memory allocation scheme
> to use for response messages, the client now has an optional
> callback that allows it to allocate the buffer for a response
> message.
> 
> When an outbound message is written to the buffer, the mailbox
> checks for the flag indicating the client wants an tx complete
> notification via IRQ.  Upon receipt of the interrupt It will
> pair it with the outgoing message. The expected use is to
> free the kernel memory buffer for the previous outgoing message.
>

I know this is merged. Based on the discussions here, I may send a revert
to this as I don't think it is correct.

> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>  drivers/mailbox/pcc.c | 102 ++++++++++++++++++++++++++++++++++++++++--
>  include/acpi/pcc.h    |  29 ++++++++++++
>  2 files changed, 127 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index f6714c233f5a..0a00719b2482 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -306,6 +306,22 @@ static void pcc_chan_acknowledge(struct pcc_chan_info *pchan)
>  		pcc_chan_reg_read_modify_write(&pchan->db);
>  }
>  
> +static void *write_response(struct pcc_chan_info *pchan)
> +{
> +	struct pcc_header pcc_header;
> +	void *buffer;
> +	int data_len;
> +
> +	memcpy_fromio(&pcc_header, pchan->chan.shmem,
> +		      sizeof(pcc_header));
> +	data_len = pcc_header.length - sizeof(u32) + sizeof(struct pcc_header);
> +
> +	buffer = pchan->chan.rx_alloc(pchan->chan.mchan->cl, data_len);
> +	if (buffer != NULL)
> +		memcpy_fromio(buffer, pchan->chan.shmem, data_len);
> +	return buffer;
> +}
> +
>  /**
>   * pcc_mbox_irq - PCC mailbox interrupt handler
>   * @irq:	interrupt number
> @@ -317,6 +333,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>  {
>  	struct pcc_chan_info *pchan;
>  	struct mbox_chan *chan = p;
> +	struct pcc_header *pcc_header = chan->active_req;
> +	void *handle = NULL;
>  
>  	pchan = chan->con_priv;
>  
> @@ -340,7 +358,17 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>  	 * required to avoid any possible race in updatation of this flag.
>  	 */
>  	pchan->chan_in_use = false;
> -	mbox_chan_received_data(chan, NULL);
> +
> +	if (pchan->chan.rx_alloc)
> +		handle = write_response(pchan);
> +
> +	if (chan->active_req) {
> +		pcc_header = chan->active_req;
> +		if (pcc_header->flags & PCC_CMD_COMPLETION_NOTIFY)
> +			mbox_chan_txdone(chan, 0);
> +	}
> +
> +	mbox_chan_received_data(chan, handle);
>  
>  	pcc_chan_acknowledge(pchan);
>  
> @@ -384,9 +412,24 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>  	pcc_mchan = &pchan->chan;
>  	pcc_mchan->shmem = acpi_os_ioremap(pcc_mchan->shmem_base_addr,
>  					   pcc_mchan->shmem_size);
> -	if (pcc_mchan->shmem)
> -		return pcc_mchan;
> +	if (!pcc_mchan->shmem)
> +		goto err;
> +
> +	pcc_mchan->manage_writes = false;
> +

Who will change this value as it is fixed to false always.
That makes the whole pcc_write_to_buffer() reduntant. It must go away.
Also why can't you use tx_prepare callback here. I don't like these changes
at all as I find these redundant. Sorry for not reviewing it in time.
I was totally confused with your versioning and didn't spot the mailbox/pcc
changes in between and assumed it is just MCTP net driver changes. My mistake.

> +	/* This indicates that the channel is ready to accept messages.
> +	 * This needs to happen after the channel has registered
> +	 * its callback. There is no access point to do that in
> +	 * the mailbox API. That implies that the mailbox client must
> +	 * have set the allocate callback function prior to
> +	 * sending any messages.
> +	 */
> +	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
> +		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
> +
> +	return pcc_mchan;
>  
> +err:
>  	mbox_free_channel(chan);
>  	return ERR_PTR(-ENXIO);
>  }
> @@ -417,8 +460,38 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
>  }
>  EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
>  
> +static int pcc_write_to_buffer(struct mbox_chan *chan, void *data)
> +{
> +	struct pcc_chan_info *pchan = chan->con_priv;
> +	struct pcc_mbox_chan *pcc_mbox_chan = &pchan->chan;
> +	struct pcc_header *pcc_header = data;
> +
> +	if (!pchan->chan.manage_writes)
> +		return 0;
> +
> +	/* The PCC header length includes the command field
> +	 * but not the other values from the header.
> +	 */
> +	int len = pcc_header->length - sizeof(u32) + sizeof(struct pcc_header);
> +	u64 val;
> +
> +	pcc_chan_reg_read(&pchan->cmd_complete, &val);
> +	if (!val) {
> +		pr_info("%s pchan->cmd_complete not set", __func__);
> +		return -1;
> +	}
> +	memcpy_toio(pcc_mbox_chan->shmem,  data, len);
> +	return 0;
> +}
> +
> +
>  /**
> - * pcc_send_data - Called from Mailbox Controller code. Used
> + * pcc_send_data - Called from Mailbox Controller code. If
> + *		pchan->chan.rx_alloc is set, then the command complete
> + *		flag is checked and the data is written to the shared
> + *		buffer io memory.
> + *
> + *		If pchan->chan.rx_alloc is not set, then it is used
>   *		here only to ring the channel doorbell. The PCC client
>   *		specific read/write is done in the client driver in
>   *		order to maintain atomicity over PCC channel once
> @@ -434,17 +507,37 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
>  	int ret;
>  	struct pcc_chan_info *pchan = chan->con_priv;
>  
> +	ret = pcc_write_to_buffer(chan, data);
> +	if (ret)
> +		return ret;
> +

Completely null as manages_write is false always.

>  	ret = pcc_chan_reg_read_modify_write(&pchan->cmd_update);
>  	if (ret)
>  		return ret;
>  
>  	ret = pcc_chan_reg_read_modify_write(&pchan->db);
> +
>  	if (!ret && pchan->plat_irq > 0)
>  		pchan->chan_in_use = true;
>  
>  	return ret;
>  }
>  
> +
> +static bool pcc_last_tx_done(struct mbox_chan *chan)
> +{
> +	struct pcc_chan_info *pchan = chan->con_priv;
> +	u64 val;
> +
> +	pcc_chan_reg_read(&pchan->cmd_complete, &val);

Not checking return from pcc_chan_reg_read(). Be consistent with the
other code in the file.

> +	if (!val)
> +		return false;
> +	else
> +		return true;
> +}
> +
> +
> +
>  /**
>   * pcc_startup - Called from Mailbox Controller code. Used here
>   *		to request the interrupt.
> @@ -490,6 +583,7 @@ static const struct mbox_chan_ops pcc_chan_ops = {
>  	.send_data = pcc_send_data,
>  	.startup = pcc_startup,
>  	.shutdown = pcc_shutdown,
> +	.last_tx_done = pcc_last_tx_done,
>  };
>  
>  /**
> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
> index 840bfc95bae3..9af3b502f839 100644
> --- a/include/acpi/pcc.h
> +++ b/include/acpi/pcc.h
> @@ -17,6 +17,35 @@ struct pcc_mbox_chan {
>  	u32 latency;
>  	u32 max_access_rate;
>  	u16 min_turnaround_time;
> +
> +	/* Set to true to indicate that the mailbox should manage
> +	 * writing the dat to the shared buffer. This differs from
> +	 * the case where the drivesr are writing to the buffer and
> +	 * using send_data only to  ring the doorbell.  If this flag
> +	 * is set, then the void * data parameter of send_data must
> +	 * point to a kernel-memory buffer formatted in accordance with
> +	 * the PCC specification.
> +	 *
> +	 * The active buffer management will include reading the
> +	 * notify_on_completion flag, and will then
> +	 * call mbox_chan_txdone when the acknowledgment interrupt is
> +	 * received.
> +	 */
> +	bool manage_writes;
> +
> +	/* Optional callback that allows the driver
> +	 * to allocate the memory used for receiving
> +	 * messages.  The return value is the location
> +	 * inside the buffer where the mailbox should write the data.
> +	 */
> +	void *(*rx_alloc)(struct mbox_client *cl,  int size);

Why this can't be in rx_callback ?


I am convinced to send a revert, please respond so that I can understand
the requirements better.

-- 
Regards,
Sudeep

