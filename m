Return-Path: <netdev+bounces-223534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1C2B596DA
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 15:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7B03B4F29
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C23F2D73BD;
	Tue, 16 Sep 2025 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tHYL8Gle"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EA5248F7D
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027785; cv=none; b=jo9+ZCCLvOYOGNP8Jyv+hDBfD2iTcXfIQwfdqYCmNkNlT9tQ98a9Y/YVzMPkl80Tu4Kr4PXfnoxfMzZsYYTgNID0yFVndZuLgGftAyrm+NTCDKn/MTmBGyU8icOs9YCSEMJhOcIDJrSFvLh4HRcbbPEjAEm6nz6x6iGlDVnM27o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027785; c=relaxed/simple;
	bh=zkTIaovo86K2Fs3yp+tdXlVVJpsvXWwe9xrdORsXMjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXxiy18r363jmHB0BTzXi0ia5VtN33jhPFTcRe5xPCcGr2e2XKs/8DXJbQOEpaUPsBafRuiGkV2ntPAbn14nzOma+UceyUXoXrYWJUImo4xNjhN7II1vh1x5ckdjwxjUsoJ119mb0fm4L98vsCDnNWzVBgGIw9mpV8gYsnyqUgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tHYL8Gle; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9d197d92-3990-4e48-aa35-87a51eccb87a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758027779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0l51roOY8mL8wGeiKdL6Wccc2vrF+Htbvn0n+KqebS8=;
	b=tHYL8GleWD5V7BwWLOfrPL7qz1AtXq3AXJl174foyTg6BzxTK/CkPNuaq0/rFTdaGkQUxk
	0njfmoO40f97TADZBYEkJ4dgNlqJxxV6SSvBR5un61l0BVGf3iS9q1bhPznmmAFvj2glkT
	O+S16sH02+qwXyQY7iOG6fj/fSvN1VE=
Date: Tue, 16 Sep 2025 14:02:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/2] ptp: rework ptp_clock_unregister() to
 disable events
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Clark Wang <xiaoning.wang@nxp.com>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>, Eric Dumazet <edumazet@google.com>,
 imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, netdev@vger.kernel.org,
 Nick Shi <nick.shi@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Yangbo Lu <yangbo.lu@nxp.com>
References: <aMglp11mUGk9PAvu@shell.armlinux.org.uk>
 <E1uyAP7-00000005lGq-3FqI@rmk-PC.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <E1uyAP7-00000005lGq-3FqI@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/09/2025 15:42, Russell King (Oracle) wrote:
> the ordering of ptp_clock_unregister() is not ideal, as the chardev
> remains published while state is being torn down. There is also no
> cleanup of enabled pin settings, which means enabled events can
> still forward into the core.
> 
> Rework the ordering of cleanup in ptp_clock_unregister() so that we
> unpublish the posix clock (and user chardev), disable any pins that
> have events enabled, and then clean up the aux work and PPS source.
> 
> This avoids potential use-after-free and races in PTP clock driver
> teardown.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   drivers/ptp/ptp_chardev.c | 13 +++++++++++++
>   drivers/ptp/ptp_clock.c   | 17 ++++++++++++++++-
>   drivers/ptp/ptp_private.h |  2 ++
>   3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index eb4f6d1b1460..640a98f17739 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -47,6 +47,19 @@ static int ptp_disable_pinfunc(struct ptp_clock_info *ops,
>   	return err;
>   }
>   
> +void ptp_disable_all_pins(struct ptp_clock *ptp)
> +{
> +	struct ptp_clock_info *info = ptp->info;
> +	unsigned int i;
> +
> +	mutex_lock(&ptp->pincfg_mux);
> +	for (i = 0; i < info->n_pins; i++)
> +		if (info->pin_config[i].func != PTP_PF_NONE)
> +			ptp_disable_pinfunc(info, info->pin_config[i].func,
> +					    info->pin_config[i].chan);
> +	mutex_unlock(&ptp->pincfg_mux);
> +}
> +

This part is questionable. We do have devices which have PPS out enabled
by default. The driver reads pins configuration from the HW during PTP
init phase and sets up proper function for pin in ptp_info::pin_config.

With this patch applied these pins have PEROUT function disabled on
shutdown and in case of kexec'ing into a new kernel the PPS out feature
needs to be manually enabled, and it breaks expected behavior.

Why do you need to clear up configured PEROUT function?


