Return-Path: <netdev+bounces-48706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A23C7EF52E
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CAB280DF1
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AA71C692;
	Fri, 17 Nov 2023 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHakJntJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC1374C4
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DC6C433C7;
	Fri, 17 Nov 2023 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700234596;
	bh=R9gtMv1mlx1XFPa0IOyEngjAsd6b0IyS9o23nfyNy5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHakJntJ4U6+/sY3OR5jtcL31/W5aky14gC2LdV2cXi1ByaLLh4oSozqVSkeNANZN
	 ES+/AdEVl+hOLGwUIT1Xu4gP5xq7rNyoUIrBNa6aLXfmf5oUGTJhLjQJ1KlFuwwi4R
	 7f/1agrFIZ6FFFs6CsMuSaPe7UD0azOrM81brF+8g/JpaHOTe3xK0pgk+48xpT+RFD
	 +0DCo3oGKFtqExUSxpfD2RQB7Cqvp4y3HxnNV5tI0Rdc8b6RIy+pq13vOdBQKMjrvN
	 eyMIJF/DlDFmYpUqdoe+OGXBdcIiAis9HhP0n+mVBAaLgXA7mEw+QOjBKn6Fu0llrZ
	 YYurBOy/9+5Tw==
Date: Fri, 17 Nov 2023 15:23:11 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 08/14] PCI: Add debug print for device ready
 delay
Message-ID: <20231117152311.GC164483@vergenet.net>
References: <cover.1700047319.git.petrm@nvidia.com>
 <63fca173195f5a9d3a2b78da700650a29cf80f96.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63fca173195f5a9d3a2b78da700650a29cf80f96.1700047319.git.petrm@nvidia.com>

+ linux-pci@vger.kernel.org

On Wed, Nov 15, 2023 at 01:17:17PM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Currently, the time it took a PCI device to become ready after reset is
> only printed if it was longer than 1000ms ('PCI_RESET_WAIT'). However,
> for debugging purposes it is useful to know this time even if it was
> shorter. For example, with the device I am working on, hardware
> engineers asked to verify that it becomes ready on the first try (no
> delay).
> 
> To that end, add a debug level print that can be enabled using dynamic
> debug. Example:
> 
>  # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset
>  # dmesg -c | grep ready
>  # echo "file drivers/pci/pci.c +p" > /sys/kernel/debug/dynamic_debug/control
>  # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset
>  # dmesg -c | grep ready
>  [  396.060335] mlxsw_spectrum4 0000:01:00.0: ready 0ms after bus reset
>  # echo "file drivers/pci/pci.c -p" > /sys/kernel/debug/dynamic_debug/control
>  # echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset
>  # dmesg -c | grep ready
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/pci/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 55bc3576a985..69d20d585f88 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1219,6 +1219,9 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  	if (delay > PCI_RESET_WAIT)
>  		pci_info(dev, "ready %dms after %s\n", delay - 1,
>  			 reset_type);
> +	else
> +		pci_dbg(dev, "ready %dms after %s\n", delay - 1,
> +			reset_type);
>  
>  	return 0;
>  }
> -- 
> 2.41.0
> 

