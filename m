Return-Path: <netdev+bounces-231286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A96BF6F4E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A754E506BAE
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DED339708;
	Tue, 21 Oct 2025 14:02:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4825332EBA;
	Tue, 21 Oct 2025 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055366; cv=none; b=i1JB4ZozufGuTy/gS9wz4+q2iDh2GhM3NIgZnEKu2vZ6FE0uVvM0DW+3Uz+SNWKQ5YMGgWUEClD9SEq8uf2Kq9otryDmafPcwSrBtB5SYNgYlUnIg3dXCSrc7RgBfUuVqv/bICqplZZRnQ11VqyGyDOQmVeEG9kDNBz3GzzV4Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055366; c=relaxed/simple;
	bh=ORwRXaxTrWD/lBTXgh/vsZlF8HjFpIxg6AroUy7/mNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0OV/BVSx2Dl9SCeU0wmNsM3D48jxtjtS/IoMLWh+i7xvHJEEyjkZioMoiHjyqoQd+dxoSBGQ9xUjjMD7IBtVW1PIQC5EXnPMtxJ58koTtEnACU39h+MrGXB/sBeSUbo8waDGlcFthYlfP85+jWq79+6GnsaJa2G1zgWAV5WxHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2783E1063;
	Tue, 21 Oct 2025 07:02:35 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A6883F66E;
	Tue, 21 Oct 2025 07:02:40 -0700 (PDT)
Date: Tue, 21 Oct 2025 15:02:37 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Adam Young <admiyo@os.amperecomputing.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v30 2/3] mailbox: pcc: functions for reading and writing
 PCC extended data
Message-ID: <aPeSfQ_Vd0bjW-iS@bogus>
References: <20251016210225.612639-1-admiyo@os.amperecomputing.com>
 <20251016210225.612639-3-admiyo@os.amperecomputing.com>
 <20251020-honored-cat-of-elevation-59b6c4@sudeepholla>
 <78c30517-4b16-4929-b10b-917da68ff01c@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78c30517-4b16-4929-b10b-917da68ff01c@amperemail.onmicrosoft.com>

On Mon, Oct 20, 2025 at 01:22:23PM -0400, Adam Young wrote:
> Answers inline.  Thanks for the review.
> 
> On 10/20/25 08:52, Sudeep Holla wrote:
> > On Thu, Oct 16, 2025 at 05:02:20PM -0400, Adam Young wrote:
> > > Adds functions that aid in compliance with the PCC protocol by
> > > checking the command complete flag status.
> > > 
> > > Adds a function that exposes the size of the shared buffer without
> > > activating the channel.
> > > 
> > > Adds a function that allows a client to query the number of bytes
> > > avaialbel to read in order to preallocate buffers for reading.
> > > 
> > > Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> > > ---
> > >   drivers/mailbox/pcc.c | 129 ++++++++++++++++++++++++++++++++++++++++++
> > >   include/acpi/pcc.h    |  38 +++++++++++++
> > >   2 files changed, 167 insertions(+)
> > > 
> > > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> > > index 978a7b674946..653897d61db5 100644
> > > --- a/drivers/mailbox/pcc.c
> > > +++ b/drivers/mailbox/pcc.c
> > > @@ -367,6 +367,46 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
> > >   	return IRQ_HANDLED;
> > >   }
> > > +static
> > > +struct pcc_chan_info *lookup_channel_info(int subspace_id)
> > > +{
> > > +	struct pcc_chan_info *pchan;
> > > +	struct mbox_chan *chan;
> > > +
> > > +	if (subspace_id < 0 || subspace_id >= pcc_chan_count)
> > > +		return ERR_PTR(-ENOENT);
> > > +
> > > +	pchan = chan_info + subspace_id;
> > > +	chan = pchan->chan.mchan;
> > > +	if (IS_ERR(chan) || chan->cl) {
> > > +		pr_err("Channel not found for idx: %d\n", subspace_id);
> > > +		return ERR_PTR(-EBUSY);
> > > +	}
> > > +	return pchan;
> > > +}
> > > +
> > > +/**
> > > + * pcc_mbox_buffer_size - PCC clients call this function to
> > > + *		request the size of the shared buffer in cases
> > > + *              where requesting the channel would prematurely
> > > + *              trigger channel activation and message delivery.
> > > + * @subspace_id: The PCC Subspace index as parsed in the PCC client
> > > + *		ACPI package. This is used to lookup the array of PCC
> > > + *		subspaces as parsed by the PCC Mailbox controller.
> > > + *
> > > + * Return: The size of the shared buffer.
> > > + */
> > > +int pcc_mbox_buffer_size(int index)
> > > +{
> > > +	struct pcc_chan_info *pchan = lookup_channel_info(index);
> > > +
> > > +	if (IS_ERR(pchan))
> > > +		return -1;
> > > +	return pchan->chan.shmem_size;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pcc_mbox_buffer_size);
> > > +
> > Why do you need to export this when you can grab this from
> > struct pcc_mbox_chan which is returned from pcc_mbox_request_channel().
> > 
> > Please drop the above 2 functions completely.\
> 
> This is required by the Network driver. Specifically, the network driver
> needs to tell the OS what the Max MTU size  is before the network is
> active.  If I have to call pcc_mbox_request_channel I then activate the
> channel for message delivery, and we have a race condition.
>

No you just need to establish the channel by calling pcc_mbox_request_channel()
from probe or init routines. After that the shmem size should be available.
No need to send any message or activating anything.

> One alternative I did consider was to return all of the data that you get
> from  request channel is a non-active format.  For the type 2 drivers, this
> information is available outside of  the mailbox interface.  The key effect
> is that the size of the shared message buffer be available without
> activating the channel.
> 

Not sure if that is needed.

> 
> > 
> > > +
> > >   /**
> > >    * pcc_mbox_request_channel - PCC clients call this function to
> > >    *		request a pointer to their PCC subspace, from which they
> > > @@ -437,6 +477,95 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
> > >   }
> > >   EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
> > > +/**
> > > + * pcc_mbox_query_bytes_available
> > > + *
> > > + * @pchan pointer to channel associated with buffer
> > > + * Return: the number of bytes available to read from the shared buffer
> > > + */
> > > +int pcc_mbox_query_bytes_available(struct pcc_mbox_chan *pchan)
> > > +{
> > > +	struct pcc_extended_header pcc_header;
> > > +	struct pcc_chan_info *pinfo = pchan->mchan->con_priv;
> > > +	int data_len;
> > > +	u64 val;
> > > +
> > > +	pcc_chan_reg_read(&pinfo->cmd_complete, &val);
> > > +	if (val) {
> > > +		pr_info("%s Buffer not enabled for reading", __func__);
> > > +		return -1;
> > > +	}
> > Why would you call pcc_mbox_query_bytes_available() if the transfer is
> > not complete ?
> 
> Because I need to  allocate a buffer to read the bytes in to.  In the
> driver, it is called this way.
> 

Yes I thought so, I think we must be able to manage this with helper as well.
I will try out some things and share.

> +       size = pcc_mbox_query_bytes_available(inbox->chan);
> +       if (size == 0)
> +               return;
> +       skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
> +       if (!skb) {
> +               dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
> +               return;
> +       }
> +       skb_put(skb, size);
> +       skb->protocol = htons(ETH_P_MCTP);
> +       pcc_mbox_read_from_buffer(inbox->chan, size, skb->data);
> 
> While we could pre-allocate a sk_buff that is MTU size, that is likely to be
> wasteful for many messages.
> 

Fair enough.

> > 
> > > +	memcpy_fromio(&pcc_header, pchan->shmem,
> > > +		      sizeof(pcc_header));
> > > +	data_len = pcc_header.length - sizeof(u32) + sizeof(pcc_header);
> > Why are you adding the header size to the length above ?
> 
> Because the PCC spec is wonky.
> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html#extended-pcc-subspace-shared-memory-region
> 
> "Length of payload being transmitted including command field."  Thus in
> order to copy all of the data, including  the PCC header, I need to drop the
> length (- sizeof(u32) ) and then add the entire header. Having all the PCC
> data in the buffer allows us to see it in networking tools. It is also
> parallel with how the messages are sent, where the PCC header is written by
> the driver and then the whole message is mem-copies in one io/read or write.
> 

No you have misread this part.
Communication subspace(only part and last entry in shared memory at offset of
16 bytes) - "Memory region for reading/writing PCC data. The maximum size of
this region is 16 bytes smaller than the size of the shared memory region
(specified in the Master slave Communications Subspace structure). When a
command is sent to or received from the platform, the size of the data in
this space will be Length (expressed above) minus the 4 bytes taken up by
the command."

The keyword is "this space/region" which refers to only the communication
subspace which is at offset 16 bytes in the shmem.

It should be just length - sizeof(command) i.e. length - 4

> > 
> > > +	return data_len;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pcc_mbox_query_bytes_available);
> > > +
> > > +/**
> > > + * pcc_mbox_read_from_buffer - Copy bytes from shared buffer into data
> > > + *
> > > + * @pchan - channel associated with the shared buffer
> > > + * @len - number of bytes to read
> > > + * @data - pointer to memory in which to write the data from the
> > > + *         shared buffer
> > > + *
> > > + * Return: number of bytes read and written into daa
> > > + */
> > > +int pcc_mbox_read_from_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
> > > +{
> > > +	struct pcc_chan_info *pinfo = pchan->mchan->con_priv;
> > > +	int data_len;
> > > +	u64 val;
> > > +
> > > +	pcc_chan_reg_read(&pinfo->cmd_complete, &val);
> > > +	if (val) {
> > > +		pr_info("%s buffer not enabled for reading", __func__);
> > > +		return -1;
> > > +	}
> > Ditto as above, why is this check necessary ?
> 
> Possibly just paranoia. I think this is vestige of older code that did
> polling instead of getting an interrupt.  But it seems correct in keeping
> with the letter of the PCC protocol.

Not needed IMO, lets add when we find the need for it, not for paranoia
reasons please.

> 
> > 
> > > +	data_len  = pcc_mbox_query_bytes_available(pchan);
> > > +	if (len < data_len)
> > > +		data_len = len;
> > > +	memcpy_fromio(data, pchan->shmem, len);
> > > +	return len;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pcc_mbox_read_from_buffer);
> > > +
> > > +/**
> > > + * pcc_mbox_write_to_buffer, copy the contents of the data
> > > + * pointer to the shared buffer.  Confirms that the command
> > > + * flag has been set prior to writing.  Data should be a
> > > + * properly formatted extended data buffer.
> > > + * pcc_mbox_write_to_buffer
> > > + * @pchan: channel
> > > + * @len: Length of the overall buffer passed in, including the
> > > + *       Entire header. The length value in the shared buffer header
> > > + *       Will be calculated from len.
> > > + * @data: Client specific data to be written to the shared buffer.
> > > + * Return: number of bytes written to the buffer.
> > > + */
> > > +int pcc_mbox_write_to_buffer(struct pcc_mbox_chan *pchan, int len, void *data)
> > > +{
> > > +	struct pcc_extended_header *pcc_header = data;
> > > +	struct mbox_chan *mbox_chan = pchan->mchan;
> > > +
> > > +	/*
> > > +	 * The PCC header length includes the command field
> > > +	 * but not the other values from the header.
> > > +	 */
> > > +	pcc_header->length = len - sizeof(struct pcc_extended_header) + sizeof(u32);
> > > +
> > > +	if (!pcc_last_tx_done(mbox_chan)) {
> > > +		pr_info("%s pchan->cmd_complete not set.", __func__);
> > > +		return 0;
> > > +	}
> > The mailbox moves to next message only if the last tx is done. Why is
> > this check necessary ?
> 
> I think you are  right, and  these three checks are redundant now.
> 

Thanks for confirming my understanding, was just worried if there is
anything that I am not considering.

> 
> > 
> > > +	memcpy_toio(pchan->shmem,  data, len);
> > > +
> > > +	return len;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pcc_mbox_write_to_buffer);
> > > +
> > > 
> > I am thinking if reading and writing to shmem can be made inline helper.
> > Let me try to hack up something add see how that would look like.
> 
> That would be a good optimization.
> 

Thanks, I did try to write to buffer part but I am still not decided on
the exact formating yet to share it. I will try to share something in
next couple of days if possible.

-- 
Regards,
Sudeep

