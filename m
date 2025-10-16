Return-Path: <netdev+bounces-230064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D366BE37B8
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C5819C65BC
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF5B3314A1;
	Thu, 16 Oct 2025 12:50:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169252E6106;
	Thu, 16 Oct 2025 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619053; cv=none; b=Ge5LluXuNZsLM+DJvzEzib6HOTTJK+gRhWizXEFbeqIhuW8CWEo8jlDtpsStzSk7H4HXTRQTC2IFWonXXzLCtamx94d8vqj9JJYOgZTapxiHpZVUQ5pN4K1jqb9mZLKa9hqNp/1MUsHfPkdgBrxEO6fb6RKONlNGhDXgAVaottY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619053; c=relaxed/simple;
	bh=RbKXxJipkxv3szJ7ubKMKmJKkxHW5F5FH0QrFfAjvq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoP28UwQpmzRTB2ltlAHYrNwpIvMGCsBPgAjG/LFX6bM8FwLClvRElJYlOqjXGGkeFk8Obllay+X92mktYMYOEtu23yunw7FWXyPWYyRTO3ne8yFMOS2vYt+K3w4paqPFSn70DnPgIy5qxzNidtCwn8p2++MsfZpwP87e0yQAPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 343CE1688;
	Thu, 16 Oct 2025 05:50:42 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19DB33F738;
	Thu, 16 Oct 2025 05:50:48 -0700 (PDT)
Date: Thu, 16 Oct 2025 13:50:46 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] Revert "mailbox/pcc: support mailbox management of the
 shared buffer"
Message-ID: <20251016-swift-of-unmatched-luck-dfdebe@sudeepholla>
References: <20250926153311.2202648-1-sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926153311.2202648-1-sudeep.holla@arm.com>

On Fri, Sep 26, 2025 at 04:33:11PM +0100, Sudeep Holla wrote:
> This reverts commit 5378bdf6a611a32500fccf13d14156f219bb0c85.
> 
> Commit 5378bdf6a611 ("mailbox/pcc: support mailbox management of the shared buffer")
> attempted to introduce generic helpers for managing the PCC shared memory,
> but it largely duplicates functionality already provided by the mailbox
> core and leaves gaps:
> 
> 1. TX preparation: The mailbox framework already supports this via
>   ->tx_prepare callback for mailbox clients. The patch adds
>   pcc_write_to_buffer() and expects clients to toggle pchan->chan.manage_writes,
>   but no drivers set manage_writes, so pcc_write_to_buffer() has no users.
> 
> 2. RX handling: Data reception is already delivered through
>    mbox_chan_received_data() and client ->rx_callback. The patch adds an
>    optional pchan->chan.rx_alloc, which again has no users and duplicates
>    the existing path.
> 
> 3. Completion handling: While adding last_tx_done is directionally useful,
>    the implementation only covers Type 3/4 and fails to handle the absence
>    of a command_complete register, so it is incomplete for other types.
> 
> Given the duplication and incomplete coverage, revert this change. Any new
> requirements should be addressed in focused follow-ups rather than bundling
> multiple behavioral changes together.
> 

The discussion on this revert stopped and I am not sure if we agreed to
revert it or not.

> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/mailbox/pcc.c | 102 ++----------------------------------------
>  include/acpi/pcc.h    |  29 ------------
>  2 files changed, 4 insertions(+), 127 deletions(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 0a00719b2482..f6714c233f5a 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -306,22 +306,6 @@ static void pcc_chan_acknowledge(struct pcc_chan_info *pchan)
>  		pcc_chan_reg_read_modify_write(&pchan->db);
>  }
>  
> -static void *write_response(struct pcc_chan_info *pchan)
> -{
> -	struct pcc_header pcc_header;
> -	void *buffer;
> -	int data_len;
> -
> -	memcpy_fromio(&pcc_header, pchan->chan.shmem,
> -		      sizeof(pcc_header));
> -	data_len = pcc_header.length - sizeof(u32) + sizeof(struct pcc_header);
> -
> -	buffer = pchan->chan.rx_alloc(pchan->chan.mchan->cl, data_len);
> -	if (buffer != NULL)
> -		memcpy_fromio(buffer, pchan->chan.shmem, data_len);
> -	return buffer;
> -}
> -
>  /**
>   * pcc_mbox_irq - PCC mailbox interrupt handler
>   * @irq:	interrupt number
> @@ -333,8 +317,6 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>  {
>  	struct pcc_chan_info *pchan;
>  	struct mbox_chan *chan = p;
> -	struct pcc_header *pcc_header = chan->active_req;
> -	void *handle = NULL;
>  
>  	pchan = chan->con_priv;
>  
> @@ -358,17 +340,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>  	 * required to avoid any possible race in updatation of this flag.
>  	 */
>  	pchan->chan_in_use = false;
> -
> -	if (pchan->chan.rx_alloc)
> -		handle = write_response(pchan);
> -
> -	if (chan->active_req) {
> -		pcc_header = chan->active_req;
> -		if (pcc_header->flags & PCC_CMD_COMPLETION_NOTIFY)
> -			mbox_chan_txdone(chan, 0);

The above change in the original patch has introduced race on my platform
where the mbox_chan_txdone() kicks the Tx while the response to the
command is read in the below mbox_chan_received_data().

So I am going to repost/resend this revert as a fix now.

-- 
Regards,
Sudeep

