Return-Path: <netdev+bounces-106914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD4B9180F0
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC522282180
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F6B181BA0;
	Wed, 26 Jun 2024 12:27:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C001D15698B;
	Wed, 26 Jun 2024 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719404839; cv=none; b=dsIbZlMCjUyE+H2nR1b/150cqgMGRBG+bOwaoVg0b2KIWb9OO7PccCOV639zY4a3sOIKZzfTBPBLoqnfRPUsAysZ/8skMg/EH7+xB7+IZftgEN3vDsNrpdsXgtqFxnZHLLD42EsB/Sp/3bq9g2EmItCIj7IienN73P+As67/7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719404839; c=relaxed/simple;
	bh=q+WDEOaAeedKX/+xIGLVKfTqoWhp9npRvixWm1Rkhrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEOkBUjUlF6XRZCm+djFQTQoloH5SZaSmSn9odcjANEt4NozC3SJguRHwY4ZlwGtCOojvnlvkoVVTKLbUtbJHt150iiFZgx/TzFzvGvD2YriDAQlPycepFi9soqz4pP7UocThVcyAz1sCPCAIt9E+J+wnuVpKTJj1uBeaNZv/cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA70A339;
	Wed, 26 Jun 2024 05:27:40 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD2503F73B;
	Wed, 26 Jun 2024 05:27:13 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:27:11 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: admiyo@os.amperecomputing.com
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v3 1/3] mctp pcc: Check before sending MCTP PCC response
 ACK
Message-ID: <ZnwJH5lJpefkzaWg@bogus>
References: <20240625185333.23211-1-admiyo@os.amperecomputing.com>
 <20240625185333.23211-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625185333.23211-2-admiyo@os.amperecomputing.com>

On Tue, Jun 25, 2024 at 02:53:31PM -0400, admiyo@os.amperecomputing.com wrote:
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

Next time when you post new series, I prefer to be cc-ed in all the patches.
So far I ignored v1 and v2 thinking it has landed in my mbox my mistake and
deleted them. But just checked the series on lore, sorry for that.

> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>  drivers/mailbox/pcc.c | 6 +++++-
>  include/acpi/pcc.h    | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 94885e411085..5cf792700d79 100644
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

Indeed, default must be false. You need to do this conditionally at runtime
otherwise I see no need for this patch as it doesn't change anything as it
stands. It needs to be fixed to get this change merged.

Also we should set any such flag once at the boot, IRQ handler is not
the right place for sure.

-- 
Regards,
Sudeep

