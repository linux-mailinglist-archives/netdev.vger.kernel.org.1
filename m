Return-Path: <netdev+bounces-191574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B242ABC34A
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03E14A1156
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D592857DF;
	Mon, 19 May 2025 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oFHywqdb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1952857C0
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670189; cv=none; b=fviwivsJ7ETm13RVWnCfhL4mz/gxJPmLtp0qJwQhk7sh6poQmf/DXWhJ/HNoEy6uR6h/Iok09dyTDXtIhaxlS9IEWcykezRmcrS5xersEAjcWQyvIjmE7ASbog+ikITCwWP0z7LZVcWlOgAVz8uGXVGRq4Z5ruzvWUJjs/YuKv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670189; c=relaxed/simple;
	bh=9oQ6h491+glloo+kJA6CCzkU/QdsIc986KaJV6xvVIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peB186Vv3fiuPKtDeJ4aK8+Wnqi+uy9XFVhTx0FQ3vcUm3LhJQEjD8Hj0BzYoxZuwbeR6rNd+0cu/6IeFPjXN8SdqlgpRE3taFcIcWFNkabhnuzS0AK8dymeWAPaRumPxc5/JOYGiuYVldBw3+ugpKid1pb9FRqwh8MUksYnckA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oFHywqdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C55C4CEE4;
	Mon, 19 May 2025 15:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747670188;
	bh=9oQ6h491+glloo+kJA6CCzkU/QdsIc986KaJV6xvVIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFHywqdbYK1CytSgJmUTg7uiBrpXtufnbxCibFBX7i7mjIqSeYBnLYeAja5/bOwn1
	 D+FYi4zFxFh0Db7Mb/z/t1DOLpzfzI0/W33YATvP51hEKMXLx1x0K2bsSDhsDvgkdn
	 ucItpHADLKJ/r4jqLdM55vXUC2RutrqRTd1Lbrb8=
Date: Mon, 19 May 2025 17:56:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wojtek Wasko <wwasko@nvidia.com>
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
	andrew@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH v2] ptp: Add sysfs attribute to show PTP device is safe
 to open RO
Message-ID: <2025051956-pawing-defrost-9af3@gregkh>
References: <20250519153032.655953-1-wwasko@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519153032.655953-1-wwasko@nvidia.com>

On Mon, May 19, 2025 at 06:30:32PM +0300, Wojtek Wasko wrote:
> Recent patches introduced in 6.15 implement permissions checks for PTP
> clocks [1]. Prior to those, a process with readonly access could modify
> the state of PTP devices, in particular the generation and consumption
> of PPS signals. This security hole was not widely exposed as userspace
> managing the ownership and permissions of PTP device nodes (e.g. udev)
> typically disabled unprivileged access entirely as a stopgap workaround.
> 
> Although the security vulnerability has been fixed in the kernel,
> userspace has no reliable way to detect whether the necessary
> permissions checks are actually in place. As a result, it must continue
> restricting PTP device permissions, even though unprivileged users can
> now be granted readonly access.
> 
> There is little precedent for fixing device permissions security hole
> covered by a long-standing userspace workaround. In previous cases where
> device permission checks were tightened [2-4], there were no userspace
> workarounds to remove/disable and so kernel fixes were applied silently
> without notifying the userspace.
> 
> A possible solution that would not require new ABI is for userspace to
> check the kernel version to detect whether the fix is in place. However,
> this approach is unreliable and error-prone, especially if backports are
> considered [5].
> 
> Add a readonly sysfs attribute to PTP clocks, "ro_safe", backed by a
> static string.
> 
> [1] https://lore.kernel.org/netdev/20250303161345.3053496-1-wwasko@nvidia.com/
> [2] https://lore.kernel.org/lkml/20070723145105.01b3acc3@the-village.bc.nu/
> [3] https://lore.kernel.org/linux-mtd/20200716115346.GA1667288@kroah.com/
> [4] https://lore.kernel.org/linux-mtd/20210303155735.25887-1-michael@walle.cc/
> [5] https://github.com/systemd/systemd/pull/37302#issuecomment-2850510329
> 
> Changes in v2:
> - Document the new sysfs node
> 
> Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>
> ---
>  Documentation/ABI/testing/sysfs-ptp | 8 ++++++++
>  drivers/ptp/ptp_sysfs.c             | 3 +++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-ptp b/Documentation/ABI/testing/sysfs-ptp
> index 9c317ac7c47a..1968199dcf1c 100644
> --- a/Documentation/ABI/testing/sysfs-ptp
> +++ b/Documentation/ABI/testing/sysfs-ptp
> @@ -140,3 +140,11 @@ Description:
>  		PPS events to the Linux PPS subsystem. To enable PPS
>  		events, write a "1" into the file. To disable events,
>  		write a "0" into the file.
> +
> +What:		/sys/class/ptp/ptp<N>/ro_safe
> +Date:		May 2025
> +Contact:	Wojtek Wasko <wwasko@nvidia.com>
> +Description:
> +        This read-only file conveys whether the kernel
> +        implements necessary permissions checks to allow
> +        safe readonly access to PTP devices.
> diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
> index 6b1b8f57cd95..763fc54cf267 100644
> --- a/drivers/ptp/ptp_sysfs.c
> +++ b/drivers/ptp/ptp_sysfs.c
> @@ -28,6 +28,8 @@ static ssize_t max_phase_adjustment_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(max_phase_adjustment);
>  
> +static DEVICE_STRING_ATTR_RO(ro_safe, 0444, "1\n");

This is not how to use sysfs, sorry.  We do NOT use it for "feature
flags" like this.

Userspace should do something else to determine if the feature is there
or not, or just default to "do not allow" if it can not figure it out.

sorry, but this change is not ok.

greg k-h

