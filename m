Return-Path: <netdev+bounces-165930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49148A33BDB
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3BC3A7F5A
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385F20B21A;
	Thu, 13 Feb 2025 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CT80kOy+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E6541C6A;
	Thu, 13 Feb 2025 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440882; cv=none; b=sXe2YHJdpOkeIQRh1JB6uT52Vktzq3UNi3Nisz/0ss22ys0ZahIFk0jqvrrG61pBwGz812SA3EYxql4Tsg3/fEb7iNhKFZPhasIHR6Hub8v2Xz1pr7EaM3ONyqwNnF1/bu+DWnoLdcohxnqYajzEmTRIlZ2yRt7BXHNViG4NYmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440882; c=relaxed/simple;
	bh=ZIqYDH1BfJZcAkTWwvMK4oFyPuJrzrCNOnu8RYStqJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5bVCcDDZWL4dOEniVPSVDUrylL4882Kbq55NhTstweSSNeLQrLE7toUELhMLEV7qR96vN+xTB00+BGY0Am9t+5lxbizfKVqr8guuW6zKo/4UeEnnEZpu8lrnD/c0gzo4zvjm30YPjlXj4aVh4pWhEMZ153tdLkuycenMGXUIWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CT80kOy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE24CC4CED1;
	Thu, 13 Feb 2025 10:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739440881;
	bh=ZIqYDH1BfJZcAkTWwvMK4oFyPuJrzrCNOnu8RYStqJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CT80kOy+UBc1F93xZBALWXH0fBw+w/Wl/AbuBRUZ5RA9pmydy3NjIF+nI0Cs6gAyB
	 FaX6b6pwa36QQ5fOJUslSk9QaLd9e48+cI6/tJwSlRyRVa91hSeU11nCDDKuvkGhOQ
	 167EKf9CBvO0ISoqVdxpt9jKdIZnJATxTOLRlXiQ=
Date: Thu, 13 Feb 2025 11:01:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	chromeos-bluetooth-upstreaming@chromium.org,
	Hsin-chen Chuang <chharry@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/3] Bluetooth: Fix possible race with userspace of
 sysfs isoc_alt
Message-ID: <2025021352-dairy-whomever-f8bd@gregkh>
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>

On Thu, Feb 13, 2025 at 11:43:59AM +0800, Hsin-chen Chuang wrote:
> From: Hsin-chen Chuang <chharry@chromium.org>
> 
> Expose the isoc_alt attr with device group to avoid the racing.
> 
> Now we create a dev node for btusb. The isoc_alt attr belongs to it and
> it also becomes the parent device of hci dev.
> 
> Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
> 
> Changes in v4:
> - Create a dev node for btusb. It's now hci dev's parent and the
>   isoc_alt now belongs to it.
> - Since the changes is almost limitted in btusb, no need to add the
>   callbacks in hdev anymore.
> 
> Changes in v3:
> - Make the attribute exported only when the isoc_alt is available.
> - In btusb_probe, determine data->isoc before calling hci_alloc_dev_priv
>   (which calls hci_init_sysfs).
> - Since hci_init_sysfs is called before btusb could modify the hdev,
>   add new argument add_isoc_alt_attr for btusb to inform hci_init_sysfs.
> 
>  drivers/bluetooth/btusb.c        | 98 +++++++++++++++++++++++++-------
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_sysfs.c        |  3 +-
>  3 files changed, 79 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 1caf7a071a73..cb3db18bb72c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -920,6 +920,8 @@ struct btusb_data {
>  	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
>  
>  	struct qca_dump_info qca_dump;
> +
> +	struct device dev;
>  };
>  
>  static void btusb_reset(struct hci_dev *hdev)
> @@ -3693,6 +3695,9 @@ static ssize_t isoc_alt_store(struct device *dev,
>  	int alt;
>  	int ret;
>  
> +	if (!data->hdev)
> +		return -ENODEV;
> +
>  	if (kstrtoint(buf, 10, &alt))
>  		return -EINVAL;
>  
> @@ -3702,6 +3707,34 @@ static ssize_t isoc_alt_store(struct device *dev,
>  
>  static DEVICE_ATTR_RW(isoc_alt);
>  
> +static struct attribute *btusb_sysfs_attrs[] = {
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(btusb_sysfs);
> +
> +static void btusb_sysfs_release(struct device *dev)
> +{
> +	// Resource release is managed in btusb_disconnect

That is NOT how the driver model works, do NOT provide an empty
release() function just to silence the driver core from complaining
about it.

If for some reason the code thinks it is handling devices differently
than it should be, fix that instead.

thanks,

greg k-h

