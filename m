Return-Path: <netdev+bounces-224753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA5CB892DF
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 13:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70564188FE61
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DF230BF71;
	Fri, 19 Sep 2025 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mSAkDwth"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C4030B516
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279820; cv=none; b=jNj7SeYiD6mHY7Dr7A5RDFRaM/igZ5CTdQnkkQKhjahn1K2EsQFqLS5yJW0yp/1BO2lrDNtaCtjkOGcq5hrKWUegSsPD10VhicgoQKwHIXX2qZuXRlwcgrvvljGPWMSZCLiW3fxNXoBp6wzRCdzmDBU9OUIecUmddsK65G67kKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279820; c=relaxed/simple;
	bh=obw3ashUlqPk4FkMTpBpd5Bd5mRdWlEF53ttd7z3Vpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuXdDuWvB86C3El55nRbBzOLBOndrMhWnnZ5yIL8OmI2bOQhBAV9GOOdmwxdsn2z+pOHqTRiLmUjz/phCrRbeaCrQXJuWuoQCI2pwg8+uZ/U8LmbMPEJhCcVnExADoRRYRyEw+JPnjGI+cLsxE1UJch1DbwEOM9Va0p9EOGc7AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mSAkDwth; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fedb5429-2e8d-42df-8080-9a8706407ad2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758279816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8TlZFBQd/L7DGLy8SikgtOTjeISh9OICFpRvOtXwTw=;
	b=mSAkDwthkxKTt/LIWXKtni05eWiAobQe3tInsCCE6sdrwoqFL6DzV9d/FvHTTGsutJl1zz
	IWE7GPWS/yDMMv3o29j3ZF3NKUZoxvyV43pcju5Vc+ZrIjqcgfCiDYS1cA+uCYd0oztUsG
	+Lwc4hdZWRkxIMGPl3BAw3uFjKrxgp0=
Date: Fri, 19 Sep 2025 12:03:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 2/3] broadcom: fix support for PTP_EXTTS_REQUEST2
 ioctl
To: Jacob Keller <jacob.e.keller@intel.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kory Maincent <kory.maincent@bootlin.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Yaroslav Kolomiiets <yrk@meta.com>, James Clark <jjc@jclark.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>
 <20250918-jk-fix-bcm-phy-supported-flags-v1-2-747b60407c9c@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250918-jk-fix-bcm-phy-supported-flags-v1-2-747b60407c9c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/09/2025 01:33, Jacob Keller wrote:
> Commit 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to
> ptp_clock_info") modified the PTP core kernel logic to validate the
> supported flags for the PTP_EXTTS_REQUEST ioctls, rather than relying on
> each individual driver correctly checking its flags.
> 
> The bcm_ptp_enable() function implements support for PTP_CLK_REQ_EXTTS, but
> does not check the flags, and does not forward the request structure into
> bcm_ptp_extts_locked().
> 
> When originally converting the bcm-phy-ptp.c code, it was unclear what
> edges the hardware actually timestamped. Thus, no flags were initialized in
> the .supported_extts_flags field. This results in the kernel automatically
> rejecting all userspace requests for the PTP_EXTTS_REQUEST2 ioctl.
> 
> This occurs because the PTP_STRICT_FLAGS is always assumed when operating
> under PTP_EXTTS_REQUEST2. This has been the case since the flags
> introduction by commit 6138e687c7b6 ("ptp: Introduce strict checking of
> external time stamp options.").
> 
> The bcm-phy-ptp.c logic never properly supported strict flag validation,
> as it previously ignored all flags including both PTP_STRICT_FLAGS and the
> PTP_FALLING_EDGE and PTP_RISING_EDGE flags.
> 
> Reports from users in the field prove that the hardware timestamps the
> rising edge. Encode this in the .supported_extts_flags field. This
> re-enables support for the PTP_EXTTS_REQUEST2 ioctl.
> 
> Reported-by: James Clark <jjc@jclark.com>
> Fixes: 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_clock_info")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   drivers/net/phy/bcm-phy-ptp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/phy/bcm-phy-ptp.c b/drivers/net/phy/bcm-phy-ptp.c
> index 1cf695ac73cc..d3501f8487d9 100644
> --- a/drivers/net/phy/bcm-phy-ptp.c
> +++ b/drivers/net/phy/bcm-phy-ptp.c
> @@ -738,6 +738,7 @@ static const struct ptp_clock_info bcm_ptp_clock_info = {
>   	.n_per_out	= 1,
>   	.n_ext_ts	= 1,
>   	.supported_perout_flags = PTP_PEROUT_DUTY_CYCLE,
> +	.supported_extts_flags = PTP_STRICT_FLAGS | PTP_RISING_EDGE,
>   };
>   
>   static void bcm_ptp_txtstamp(struct mii_timestamper *mii_ts,
> 

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

