Return-Path: <netdev+bounces-100109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0428D7E21
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4F91C226CB
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117B07F7FB;
	Mon,  3 Jun 2024 09:08:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C5E7E79F;
	Mon,  3 Jun 2024 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405684; cv=none; b=LzaHCRZgrqXfMfQfQE5G4oBSqq7ygvmedboAHXmgHkJJv0tXlAdV9GR8jqWOsS1xuzaeGr+J6rUvLthcAhBBJSGSkWFMyABeDisXHeaFEBSIostLccLYDuKlUGelAkiGBR1e+UeVPfuKEwCDuLWmAyqp7rb6rsx5wtYDz8Ptpxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405684; c=relaxed/simple;
	bh=LYGMtMXJ4+xgoBe7UhVjgwM1rB/tgrzSyhDMb9CnrCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ix0OOZgAS6xNQXXmflEW6u6flGV3sIoChvO+3bOenvdAW23JUWTW9d3wqacqIT1Q8arey8pjkGm797aVGS5BCFnrUut78NrslgXU5G7lM0g7OVKMKxndSva6RTsbmC7b6nWst7poVcTLFjsKRK4JMGZQ2/iBWDSW5tyvnHB2xWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B29A51042;
	Mon,  3 Jun 2024 02:08:25 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4761C3F762;
	Mon,  3 Jun 2024 02:08:00 -0700 (PDT)
Date: Mon, 3 Jun 2024 10:07:57 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: admiyo@os.amperecomputing.com
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mctp pcc: Check before sending MCTP PCC response
 ACK
Message-ID: <Zl2H7QVuu0WDlFOS@bogus>
References: <20240513173546.679061-1-admiyo@os.amperecomputing.com>
 <20240528191823.17775-1-admiyo@os.amperecomputing.com>
 <20240528191823.17775-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528191823.17775-2-admiyo@os.amperecomputing.com>

On Tue, May 28, 2024 at 03:18:21PM -0400, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@amperecomputing.com>
> 
> Type 4 PCC channels have an option to send back a response
> to the platform when they are done processing the request.
> The flag to indicate whether or not to respond is inside
> the message body, and thus is not available to the pcc
> mailbox.  Since only one message can be processed at once per
> channel, the value of this flag is checked during message processing
> and passed back via the channels global structure.
> 
> Ideally, the mailbox callback function would return a value
> indicating whether the message requires an ACK, but that
> would be a change to the mailbox API.  That would involve
> some change to all (about 12) of the mailbox based drivers,
> and the majority of them would not need to know about the
> ACK call.
>

I don't have all the 3 patches. Is this sent by error or am I expected
to just review this patch while other 2 are not mailbox related ?

> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>  drivers/mailbox/pcc.c | 5 ++++-
>  include/acpi/pcc.h    | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 94885e411085..774727b89693 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -280,6 +280,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>  {
>  	struct pcc_chan_info *pchan;
>  	struct mbox_chan *chan = p;
> +	struct pcc_mbox_chan *pmchan;
>  	u64 val;
>  	int ret;
>  
> @@ -304,6 +305,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>  	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
>  		return IRQ_NONE;
>  
> +	pmchan = &pchan->chan;
> +	pmchan->ack_rx = true;  //TODO default to False

We need to remove this and detect when it can be true if the default expected
is false.

-- 
Regards,
Sudeep

