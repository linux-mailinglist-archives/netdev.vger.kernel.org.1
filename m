Return-Path: <netdev+bounces-166383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D65DA35CAA
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 12:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED701890806
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 11:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485D8263C60;
	Fri, 14 Feb 2025 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a4/0cF2W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC35B2627ED;
	Fri, 14 Feb 2025 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533037; cv=none; b=jJmAdgRbC2+sIP7dv60yqOPTAc8xn15aaEQAMbEHVCEI56nadnQgpwplKAc4qr6DU0kQrkiPTC1zc+h/2q7iZHq6iP5MQiILdAp35/tVJGZeUg8zhm2WfRlOFDRI6B4Jr+4GaAfu4NtAQsMx+3E2ei9Y9fhKHctxlsfk8WDfHYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533037; c=relaxed/simple;
	bh=I74jwEEgdzAlIhSsbE1frYKB0EsoLIVW5+jBpBwQJUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+QmpyKRoO55EIposq6Xmb8qBW5MD2qUvzGOiL/POm7IfnUQEMa+XH9at7ayDIMigh98nG34CSMF5Z5JJziDSBzJuGQFnvH31TWDWemjyE7CV95fkfzKdNkXrkiWEBsulqICoJTuK4p7KY7ljA1SFa4LNHOyDNe0gzYzM+yIiLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a4/0cF2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F716C4CED1;
	Fri, 14 Feb 2025 11:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739533036;
	bh=I74jwEEgdzAlIhSsbE1frYKB0EsoLIVW5+jBpBwQJUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a4/0cF2WRNCjsiaf6pKoUGpuI4u49rX9/YkGi91TzB2R3464I2CurlUIzxZF60Zd5
	 +hHbnBr43gc5Sj95+g2iGDRUWmzYOwtYxbxNtOsyTSFIbJdA3OPSQnGShbzkyQ/Ywx
	 4TlmJhAiiV+AV9dwhx9z59IW9RLlmigZgC428enc=
Date: Fri, 14 Feb 2025 12:37:12 +0100
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
Subject: Re: [PATCH v5] Bluetooth: Fix possible race with userspace of sysfs
 isoc_alt
Message-ID: <2025021425-surgical-wackiness-0940@gregkh>
References: <20250214191615.v5.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214191615.v5.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>

On Fri, Feb 14, 2025 at 07:16:17PM +0800, Hsin-chen Chuang wrote:
> From: Hsin-chen Chuang <chharry@chromium.org>
> 
> Expose the isoc_alt attr with device group to avoid the racing.
> 
> Now we create a dev node for btusb. The isoc_alt attr belongs to it and
> it also becomes the parent device of hci dev.
> 
> Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")

Wait, step back, why is this commit needed if you can change the alt
setting already today through usbfs/libusb without needing to mess with
the bluetooth stack at all?

> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
> 
> Changes in v5:
> - Merge the ABI doc into this patch
> - Manage the driver data with device
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
> Changes in v2:
> - The patch has been removed from series
> 
>  .../ABI/stable/sysfs-class-bluetooth          |  13 ++
>  drivers/bluetooth/btusb.c                     | 111 ++++++++++++++----
>  include/net/bluetooth/hci_core.h              |   1 +
>  net/bluetooth/hci_sysfs.c                     |   3 +-
>  4 files changed, 102 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documentation/ABI/stable/sysfs-class-bluetooth
> index 36be02471174..c1024c7c4634 100644
> --- a/Documentation/ABI/stable/sysfs-class-bluetooth
> +++ b/Documentation/ABI/stable/sysfs-class-bluetooth
> @@ -7,3 +7,16 @@ Description: 	This write-only attribute allows users to trigger the vendor reset
>  		The reset may or may not be done through the device transport
>  		(e.g., UART/USB), and can also be done through an out-of-band
>  		approach such as GPIO.
> +
> +What:		/sys/class/bluetooth/btusb<usb-intf>/isoc_alt
> +Date:		13-Feb-2025
> +KernelVersion:	6.13
> +Contact:	linux-bluetooth@vger.kernel.org
> +Description:	This attribute allows users to configure the USB Alternate setting
> +		for the specific HCI device. Reading this attribute returns the
> +		current setting, and writing any supported numbers would change
> +		the setting. See the USB Alternate setting definition in Bluetooth
> +		core spec 5, vol 4, part B, table 2.1.
> +		If the HCI device is not yet init-ed, the write fails with -ENODEV.
> +		If the data is not a valid number, the write fails with -EINVAL.
> +		The other failures are vendor specific.

Again, what's wrong with libusb/usbfs to do this today?


> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 1caf7a071a73..e2fb3d08a5ed 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -920,6 +920,8 @@ struct btusb_data {
>  	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
>  
>  	struct qca_dump_info qca_dump;
> +
> +	struct device dev;

Ah, so now this structure's lifecycle is determined by the device you
just embedded in it?  Are you sure you got this right?

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
> @@ -3702,6 +3707,36 @@ static ssize_t isoc_alt_store(struct device *dev,
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
> +	struct btusb_data *data = dev_get_drvdata(dev);

That feels wrong, it's embedded in the device, not pointed to by the
device.  So this should be a container_of() call, right?

> +
> +	kfree(data);
> +}
> +
> +static const struct device_type btusb_sysfs = {
> +	.name    = "btusb",
> +	.release = btusb_sysfs_release,
> +	.groups  = btusb_sysfs_groups,
> +};
> +
> +static struct attribute *btusb_sysfs_isoc_alt_attrs[] = {
> +	&dev_attr_isoc_alt.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(btusb_sysfs_isoc_alt);
> +
> +static const struct device_type btusb_sysfs_isoc_alt = {
> +	.name    = "btusb",
> +	.release = btusb_sysfs_release,
> +	.groups  = btusb_sysfs_isoc_alt_groups,
> +};
> +
>  static int btusb_probe(struct usb_interface *intf,
>  		       const struct usb_device_id *id)
>  {
> @@ -3743,7 +3778,7 @@ static int btusb_probe(struct usb_interface *intf,
>  			return -ENODEV;
>  	}
>  
> -	data = devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> @@ -3766,8 +3801,10 @@ static int btusb_probe(struct usb_interface *intf,
>  		}
>  	}
>  
> -	if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep)
> -		return -ENODEV;
> +	if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep) {
> +		err = -ENODEV;
> +		goto out_free_data;
> +	}
>  
>  	if (id->driver_info & BTUSB_AMP) {
>  		data->cmdreq_type = USB_TYPE_CLASS | 0x01;
> @@ -3821,16 +3858,47 @@ static int btusb_probe(struct usb_interface *intf,
>  
>  	data->recv_acl = hci_recv_frame;
>  
> +	if (id->driver_info & BTUSB_AMP) {
> +		/* AMP controllers do not support SCO packets */
> +		data->isoc = NULL;
> +	} else {
> +		/* Interface orders are hardcoded in the specification */
> +		data->isoc = usb_ifnum_to_if(data->udev, ifnum_base + 1);
> +		data->isoc_ifnum = ifnum_base + 1;
> +	}
> +
> +	if (id->driver_info & BTUSB_BROKEN_ISOC)
> +		data->isoc = NULL;
> +
> +	/* Init a dev for btusb. The attr depends on the support of isoc. */
> +	if (data->isoc)
> +		data->dev.type = &btusb_sysfs_isoc_alt;
> +	else
> +		data->dev.type = &btusb_sysfs;

When walking the class, are you sure you check for the proper types now?
Does anyone walk all of the class devices anywhere?

> +	data->dev.class = &bt_class;
> +	data->dev.parent = &intf->dev;
> +
> +	err = dev_set_name(&data->dev, "btusb%s", dev_name(&intf->dev));

what does this name look like in a real system?  squashing them together
feels wrong, why is 'btusb' needed here at all?

> +	if (err)
> +		goto out_free_data;
> +
> +	dev_set_drvdata(&data->dev, data);
> +	err = device_register(&data->dev);
> +	if (err < 0)
> +		goto out_put_sysfs;
> +
>  	hdev = hci_alloc_dev_priv(priv_size);
> -	if (!hdev)
> -		return -ENOMEM;
> +	if (!hdev) {
> +		err = -ENOMEM;
> +		goto out_free_sysfs;
> +	}
>  
>  	hdev->bus = HCI_USB;
>  	hci_set_drvdata(hdev, data);
>  
>  	data->hdev = hdev;
>  
> -	SET_HCIDEV_DEV(hdev, &intf->dev);
> +	SET_HCIDEV_DEV(hdev, &data->dev);
>  
>  	reset_gpio = gpiod_get_optional(&data->udev->dev, "reset",
>  					GPIOD_OUT_LOW);
> @@ -3969,15 +4037,6 @@ static int btusb_probe(struct usb_interface *intf,
>  		hci_set_msft_opcode(hdev, 0xFD70);
>  	}
>  
> -	if (id->driver_info & BTUSB_AMP) {
> -		/* AMP controllers do not support SCO packets */
> -		data->isoc = NULL;
> -	} else {
> -		/* Interface orders are hardcoded in the specification */
> -		data->isoc = usb_ifnum_to_if(data->udev, ifnum_base + 1);
> -		data->isoc_ifnum = ifnum_base + 1;
> -	}
> -
>  	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_RTL) &&
>  	    (id->driver_info & BTUSB_REALTEK)) {
>  		btrtl_set_driver_name(hdev, btusb_driver.name);
> @@ -4010,9 +4069,6 @@ static int btusb_probe(struct usb_interface *intf,
>  			set_bit(HCI_QUIRK_FIXUP_BUFFER_SIZE, &hdev->quirks);
>  	}
>  
> -	if (id->driver_info & BTUSB_BROKEN_ISOC)
> -		data->isoc = NULL;
> -
>  	if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
>  		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
>  
> @@ -4065,10 +4121,6 @@ static int btusb_probe(struct usb_interface *intf,
>  						 data->isoc, data);
>  		if (err < 0)
>  			goto out_free_dev;
> -
> -		err = device_create_file(&intf->dev, &dev_attr_isoc_alt);

You have now moved the file, are you sure you don't also need to update
the documentation?


> -		if (err)
> -			goto out_free_dev;
>  	}
>  
>  	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
> @@ -4099,6 +4151,16 @@ static int btusb_probe(struct usb_interface *intf,
>  	if (data->reset_gpio)
>  		gpiod_put(data->reset_gpio);
>  	hci_free_dev(hdev);
> +
> +out_free_sysfs:
> +	device_del(&data->dev);
> +
> +out_put_sysfs:
> +	put_device(&data->dev);
> +	return err;
> +
> +out_free_data:
> +	kfree(data);
>  	return err;
>  }
>  
> @@ -4115,10 +4177,8 @@ static void btusb_disconnect(struct usb_interface *intf)
>  	hdev = data->hdev;
>  	usb_set_intfdata(data->intf, NULL);
>  
> -	if (data->isoc) {
> -		device_remove_file(&intf->dev, &dev_attr_isoc_alt);
> +	if (data->isoc)
>  		usb_set_intfdata(data->isoc, NULL);
> -	}
>  
>  	if (data->diag)
>  		usb_set_intfdata(data->diag, NULL);
> @@ -4150,6 +4210,7 @@ static void btusb_disconnect(struct usb_interface *intf)
>  		gpiod_put(data->reset_gpio);
>  
>  	hci_free_dev(hdev);
> +	device_unregister(&data->dev);
>  }
>  
>  #ifdef CONFIG_PM
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 05919848ea95..776dd6183509 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1843,6 +1843,7 @@ int hci_get_adv_monitor_offload_ext(struct hci_dev *hdev);
>  
>  void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
>  
> +extern const struct class bt_class;
>  void hci_init_sysfs(struct hci_dev *hdev);
>  void hci_conn_init_sysfs(struct hci_conn *conn);
>  void hci_conn_add_sysfs(struct hci_conn *conn);
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 041ce9adc378..aab3ffaa264c 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -6,9 +6,10 @@
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>  
> -static const struct class bt_class = {
> +const struct class bt_class = {
>  	.name = "bluetooth",
>  };
> +EXPORT_SYMBOL(bt_class);

EXPORT_SYMBOL_GPL(), right?

thanks,

greg k-h

