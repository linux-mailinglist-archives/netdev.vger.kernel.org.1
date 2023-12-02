Return-Path: <netdev+bounces-53290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C21801E8A
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 21:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DAA280E3D
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 20:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462592110F;
	Sat,  2 Dec 2023 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTWhzANr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2803D82
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 20:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CE6C433C9;
	Sat,  2 Dec 2023 20:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701549909;
	bh=NFeaS5T2wFsp0L7IWjsUyNr7LFqRLWSu5xRNDY0AG4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sTWhzANrPE+RGAo2lEnFsFR58d3GQvTxnrODEI5UJS9PscgNmrYl9HZ7tLsmwK3/c
	 2c14hY3JaZILOqBv4L2ZDvpJMNWN5gdXEsgRFuHMHeltmL8qymRup/fX102aGIIf3W
	 54QgrOFQ4PDgrwFBaAkTeTZjkRh90eiLv/5HNUuNHEH9HZZ384hGb37UZW4GWDiVyc
	 GEMIlYXca3iGwQk4A1TmGw3WO1vUzE4nxPdrfxmKEE2xqm2NpPruaPs3d/lSXFSpZ2
	 h9mH/L1gQ7uvkr34t58KNtlY63i2JfTY2p8Py0WnIFyAmtcvvNUzaYgzupOosiXV9w
	 JIv64rdNPObMQ==
Date: Sat, 2 Dec 2023 12:45:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: mvmdio: Avoid excessive sleeps in
 polled mode
Message-ID: <20231202124508.3ac34fcf@kernel.org>
In-Reply-To: <20231201173545.1215940-3-tobias@waldekranz.com>
References: <20231201173545.1215940-1-tobias@waldekranz.com>
	<20231201173545.1215940-3-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Dec 2023 18:35:44 +0100 Tobias Waldekranz wrote:
> @@ -94,23 +88,24 @@ static int orion_mdio_wait_ready(const struct orion_mdio_ops *ops,
>  				 struct mii_bus *bus)
>  {
>  	struct orion_mdio_dev *dev = bus->priv;
> -	unsigned long timeout = usecs_to_jiffies(MVMDIO_SMI_TIMEOUT);
> -	unsigned long end = jiffies + timeout;
> -	int timedout = 0;
> +	unsigned long end, timeout;
> +	int done, timedout;
>  
> -	while (1) {
> -	        if (ops->is_done(dev))
> +	if (dev->err_interrupt <= 0) {
> +		if (!read_poll_timeout_atomic(ops->is_done, done, done, 2,
> +					      MVMDIO_SMI_TIMEOUT, false, dev))
>  			return 0;
> -	        else if (timedout)
> -			break;
> -
> -	        if (dev->err_interrupt <= 0) {
> -			usleep_range(ops->poll_interval_min,
> -				     ops->poll_interval_max);
> +	} else {
> +		timeout = usecs_to_jiffies(MVMDIO_SMI_TIMEOUT);
> +		end = jiffies + timeout;
> +		timedout = 0;
> +
> +		while (1) {
> +			if (ops->is_done(dev))
> +				return 0;
> +			else if (timedout)
> +				break;
>  
> -			if (time_is_before_jiffies(end))
> -				++timedout;
> -	        } else {
>  			/* wait_event_timeout does not guarantee a delay of at
>  			 * least one whole jiffie, so timeout must be no less
>  			 * than two.

drivers/net/ethernet/marvell/mvmdio.c:91:16: warning: variable 'end' set but not used [-Wunused-but-set-variable]
   91 |         unsigned long end, timeout;
      |                       ^
-- 
pw-bot: cr

