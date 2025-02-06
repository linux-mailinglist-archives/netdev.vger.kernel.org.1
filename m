Return-Path: <netdev+bounces-163505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63111A2A71B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 12:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3C907A4EBE
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 11:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2A8228CA9;
	Thu,  6 Feb 2025 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OtLs3PS0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B47A22687B
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738840357; cv=none; b=st72g3o+X4FkJF9+6eMu+8bHNhxTyoKFEnSovawh1qhg1oTfDTF4n+xh/sZumhJmC3cU6DOsxzYTLjWO+CtE/7jOSzBDmX0TZslxXWbwR2PlPWtLIfIIHEZtkHbDsdOQmk3etZsSI5G40PXe3lHqBIepVmYnGXuRssC0uQVlYLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738840357; c=relaxed/simple;
	bh=5PdoUKp8sDUkFBopWK086WpaKYpFta5+chXQ5K9Um/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9HxSr5cMAFVMX+Xv6uJiK+UeBg+EhbdpLgzBDEtHVT4MzRry2P5vPnA2RR2tjGOwrkREcZ/GQP8ikDa7vYjlB41957iVLrvyU2sWtUYGLLerr1smZRI0JfZNevPO0ujB7VkEu3IRLG1ODwi8+cHkFEYl3PdzNTPw+gs06maDS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OtLs3PS0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38db0146117so319456f8f.3
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 03:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738840353; x=1739445153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=05pulSuSE99qxkmEMmiSEJZyQjWQQwPFcROHf49vxwM=;
        b=OtLs3PS0Fpz8OfTTO/wXpwpLfA7seCHTYl3/Iri3K1XEYa+M3GTzjWm62O2HIw7XZP
         yqODTvVD5Qc0LIMT3s58BMNaJVO2IermbogE+uqWMYx02Y5RsENYVBDf6eJrCz4z5Rq5
         o3EkqciUjj5k7OP2NtVr06hHZKW92W5EKwvRAoxH8eOVsryneMRKUKrGPDUJhX1ghSSK
         vmQpXX4jSrFQI8lP7cLrgx6gG69pPMLoZSchjP1XVndNdSV2548ZT6K6hrJ5yQpPzfO/
         hz1CPYItSvW356yMRYrelfAQ1SLzhnHKdpQXlEeKCkzWozpfoIF1wVZ5uk5AXs9Vl5zt
         qQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738840353; x=1739445153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05pulSuSE99qxkmEMmiSEJZyQjWQQwPFcROHf49vxwM=;
        b=CkTbtLgi/8ox3OKEQ+m9uh5j4L0bxBmo1ZJofcKf1+qsQmpQuy7cH4GPiIxuSZUIK7
         D1dp/Mg0cDjmWuEjusb0fZUh1XikRhpY3NIJf8rP2vnLWlqo/3QyYMZZfAYAm3Osccun
         nnCNwIdAD2UtuFMH1jKmYj0oOmRwpPwNQxhMhOvduj8mf1Hm4C47BsOP+Q9DD07Y68Mn
         uIopnmrzmq+wE/sLZfynXEIxdtaiUe/Tsfu6de2mIjQ2e+wNAa7bfi7c3JVT3PwbYjzW
         lN1gxmq/fhZNWzexbXumVU1Rq5oXL4jEgh/WZudyCTxPbahlp0ezcpJC71pHHPG9DEB6
         OfJQ==
X-Gm-Message-State: AOJu0YwA3FfYzjkwVMkTFKgqnzkpqXAS7XMmtGrl/4KdaVTerzoUnt/P
	63hkgBrIwTfuHEma9Tx/OIdhOdZs4hv2jKNnpBS+LpRqm0ncjiOuP4cfOqyhNkc=
X-Gm-Gg: ASbGncucz6Vw51CY9jqNjtU5YgfXjiQsd10uSoGFDYNGGSnwqaBK3+E0/d1E3RiHyb0
	3p3fPiVtOlu2hcSIJRUyK+sG58p+UeL78HnBS2daeA5JgBfOuJ1IWQOivsXeD+w7zx+j/sHMI4N
	jhEYvPwcVHvz/Knq9M7c9RE2amFFT3bU8XIBHeA5VNQo2uQvgZw7uZl3vu3Kn3hSjVAKhXuyd1u
	G5jGvrPny/nUl0uv620Xg7kf+TlCT6I5e+seUmJWnFAIyUEdzRoUPQO5CCJHjLgTi9t7W4lstnN
	BOUZ+wL2ZRUmFM3z62GD1O748kZxveuXXi6F+nwoPMz5u9RzsGBn3Q4=
X-Google-Smtp-Source: AGHT+IFMZs9f3ZpCYf49DKZBu3JvAGOtaYOxNomlj0FH/GVBeAlf7NL4aYMnUcimyY7i5fPFrFC/Kg==
X-Received: by 2002:a05:6000:1aca:b0:388:da10:ff13 with SMTP id ffacd0b85a97d-38db488173fmr4923459f8f.21.1738840353331;
        Thu, 06 Feb 2025 03:12:33 -0800 (PST)
Received: from ?IPV6:2001:a61:13fe:9601:597e:3e98:d02:6bc5? ([2001:a61:13fe:9601:597e:3e98:d02:6bc5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbdd1afcdsm1464978f8f.14.2025.02.06.03.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 03:12:33 -0800 (PST)
Message-ID: <b78d0e25-f8cc-43af-90d8-2c7344895d55@suse.com>
Date: Thu, 6 Feb 2025 12:12:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: mctp: Add MCTP USB transport driver
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 Santosh Puranik <spuranik@nvidia.com>
References: <20250206-dev-mctp-usb-v1-0-81453fe26a61@codeconstruct.com.au>
 <20250206-dev-mctp-usb-v1-2-81453fe26a61@codeconstruct.com.au>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250206-dev-mctp-usb-v1-2-81453fe26a61@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.02.25 07:48, Jeremy Kerr wrote:

Hi,

remarks inline.

	Regards
		Oliver

> +static void mctp_usb_in_complete(struct urb *urb)
> +{
> +	struct sk_buff *skb = urb->context;
> +	struct net_device *netdev = skb->dev;
> +	struct pcpu_dstats *dstats = this_cpu_ptr(netdev->dstats);
> +	struct mctp_usb *mctp_usb = netdev_priv(netdev);
> +	struct mctp_skb_cb *cb;
> +	unsigned int len;
> +	int status;
> +
> +	status = urb->status;
> +
> +	switch (status) {
> +	case -ENOENT:
> +	case -ECONNRESET:
> +	case -ESHUTDOWN:
> +	case -EPROTO:
> +		kfree_skb(skb);
> +		return;
> +	case 0:
> +		break;
> +	default:
> +		dev_err(&mctp_usb->usbdev->dev, "%s: urb status: %d\n",
> +			__func__, status);
> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	len = urb->actual_length;
> +	__skb_put(skb, len);
> +
> +	while (skb) {
> +		struct sk_buff *skb2 = NULL;
> +		struct mctp_usb_hdr *hdr;
> +		u8 pkt_len; /* length of MCTP packet, no USB header */
> +
> +		hdr = skb_pull_data(skb, sizeof(*hdr));
> +		if (!hdr)
> +			break;
> +
> +		if (be16_to_cpu(hdr->id) != MCTP_USB_DMTF_ID) {

It would be more efficient to do the conversion on the constant

> +			dev_dbg(&mctp_usb->usbdev->dev, "%s: invalid id %04x\n",
> +				__func__, be16_to_cpu(hdr->id));
> +			break;
> +		}
> +
> +		if (hdr->len <
> +		    sizeof(struct mctp_hdr) + sizeof(struct mctp_usb_hdr)) {
> +			dev_dbg(&mctp_usb->usbdev->dev,
> +				"%s: short packet (hdr) %d\n",
> +				__func__, hdr->len);
> +			break;
> +		}
> +
> +		/* we know we have at least sizeof(struct mctp_usb_hdr) here */
> +		pkt_len = hdr->len - sizeof(struct mctp_usb_hdr);
> +		if (pkt_len > skb->len) {
> +			dev_dbg(&mctp_usb->usbdev->dev,
> +				"%s: short packet (xfer) %d, actual %d\n",
> +				__func__, hdr->len, skb->len);
> +			break;
> +		}
> +
> +		if (pkt_len < skb->len) {
> +			/* more packets may follow - clone to a new
> +			 * skb to use on the next iteration
> +			 */
> +			skb2 = skb_clone(skb, GFP_ATOMIC);
> +			if (skb2) {
> +				if (!skb_pull(skb2, pkt_len)) {
> +					kfree_skb(skb2);
> +					skb2 = NULL;
> +				}
> +			}
> +			skb_trim(skb, pkt_len);

This is functional. Though in terms of algorithm you are copying
the same data multiple times.

> +		}
> +
> +		skb->protocol = htons(ETH_P_MCTP);
> +		skb_reset_network_header(skb);
> +		cb = __mctp_cb(skb);
> +		cb->halen = 0;
> +		netif_rx(skb);
> +
> +		u64_stats_update_begin(&dstats->syncp);
> +		u64_stats_inc(&dstats->rx_packets);
> +		u64_stats_add(&dstats->rx_bytes, skb->len);
> +		u64_stats_update_end(&dstats->syncp);
> +
> +		skb = skb2;
> +	}
> +
> +	if (skb)
> +		kfree_skb(skb);
> +
> +	mctp_usb_rx_queue(mctp_usb);
> +}
> +
> +static int mctp_usb_open(struct net_device *dev)
> +{
> +	struct mctp_usb *mctp_usb = netdev_priv(dev);
> +
> +	return mctp_usb_rx_queue(mctp_usb);

This will needlessly use GFP_ATOMIC

> +}

[..]

> +static int mctp_usb_probe(struct usb_interface *intf,
> +			  const struct usb_device_id *id)
> +{
> +	struct usb_endpoint_descriptor *ep_in, *ep_out;
> +	struct usb_host_interface *iface_desc;
> +	struct net_device *netdev;
> +	struct mctp_usb *dev;
> +	int rc;
> +
> +	/* only one alternate */
> +	iface_desc = intf->cur_altsetting;
> +
> +	rc = usb_find_common_endpoints(iface_desc, &ep_in, &ep_out, NULL, NULL);
> +	if (rc) {
> +		dev_err(&intf->dev, "invalid endpoints on device?\n");
> +		return rc;
> +	}
> +
> +	netdev = alloc_netdev(sizeof(*dev), "mctpusb%d", NET_NAME_ENUM,
> +			      mctp_usb_netdev_setup);
> +	if (!netdev)
> +		return -ENOMEM;
> +
> +	SET_NETDEV_DEV(netdev, &intf->dev);
> +	dev = netdev_priv(netdev);
> +	dev->netdev = netdev;
> +	dev->usbdev = usb_get_dev(interface_to_usbdev(intf));

Taking a reference.
Where is the corresponding put?

> +	dev->intf = intf;
> +	usb_set_intfdata(intf, dev);
> +
> +	dev->ep_in = ep_in->bEndpointAddress;
> +	dev->ep_out = ep_out->bEndpointAddress;
> +
> +	dev->tx_urb = usb_alloc_urb(0, GFP_KERNEL);
> +	dev->rx_urb = usb_alloc_urb(0, GFP_KERNEL);
> +	if (!dev->tx_urb || !dev->rx_urb) {
> +		rc = -ENOMEM;
> +		goto err_free_urbs;
> +	}
> +
> +	rc = register_netdev(netdev);
> +	if (rc)
> +		goto err_free_urbs;
> +
> +	return 0;
> +
> +err_free_urbs:
> +	usb_free_urb(dev->tx_urb);
> +	usb_free_urb(dev->rx_urb);
> +	free_netdev(netdev);
> +	return rc;
> +}

