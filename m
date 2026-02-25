Return-Path: <netdev+bounces-260886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qE5AIxDYnmkTXgQAu9opvQ
	(envelope-from <netdev+bounces-260886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:08:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A6B196415
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5509301F9A3
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7AC393DE2;
	Wed, 25 Feb 2026 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7a7tTXF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sGFnE+4m"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402AF39281C
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772017451; cv=none; b=tackIpqj+xj3qVqtN7PepTtfdclVursSHBzxFCKY9mHQ7UJQC0020lomVqtOtVK+WvddhHKMm5zP3F+WzTMBjoPbDYQy6Y00xLSc9M/DcuuOGSuUi5/DkWVy38DwkJAoh1T7PwyDiAwnlEhdXHiDk/aSECytgvr38IZUjrZT/fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772017451; c=relaxed/simple;
	bh=oVSQEEzCSa3CkJ0Q9yq/S9YoldK7hxGgwFsLTCf0tDc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fhnok+/dMOTWIF1Pn6BSYk3IiuefPvR8GGi1dO8BtR3mR6+qhXTtkdDBwxUIUG7wlHnujiPZpQAz0/k0NE7ovanj/tdefkw9NkUVee00M5QuU1+UhHbBr8wTi4lF0S/F6Hcgg3SLKSqVLzHl/pKie5nTbzIJ/fwr/ZrOB2v0oRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7a7tTXF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sGFnE+4m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772017448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fnXyv9FeSh66PWrhFp1PqKYS+k12gdJjAyfugiwsSHI=;
	b=a7a7tTXFiADgIHr11xSzh2IBZgfDYthqH4t/nfpLM/Sl92H1riNzeq5Vh0/Ts+mkB22KfS
	YxCHpOLuFv7WNEOIuSiGrLuQOUyswHuXX5MhDtrJynasDgMNpfHO1+0j5+Vx+mkI9MRac4
	9dqDkY4FbnrCL1ITrZuUzGrHLTDNwaI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-YaxTr_cMMoyDmV_HBNUbbA-1; Wed, 25 Feb 2026 06:04:06 -0500
X-MC-Unique: YaxTr_cMMoyDmV_HBNUbbA-1
X-Mimecast-MFC-AGG-ID: YaxTr_cMMoyDmV_HBNUbbA_1772017445
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837a718f41so33084745e9.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 03:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772017445; x=1772622245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fnXyv9FeSh66PWrhFp1PqKYS+k12gdJjAyfugiwsSHI=;
        b=sGFnE+4m8gn1GzpxBKKUWGOSLPPw/wPF/c3mpl4O3t5/99QFUTKi1BSjV+knkJJMqx
         dDr4/aBBCmro0oLVsDrDPjpNBi+fSeYemC/+rwLTBwaWP2DMPWcRKwe5VDP+O7ROAkQa
         K+DkqSthg6dHoxxSzDZdTM89fcBZrr5ettYa0ShFuVykatmTWxM7MPASUUYppc5bh8K7
         xZ4BDL8sLyd2Qvgjs6fflPIwTK9oGMm4fBWf41S8BjJWb30hLwMg0VXMdX6HRkoO+pvf
         jzE4rmS8JxHW1nFAF9novYirNbqrPFNnrQNFQ+R3hC6Njo2Rmabk0X7iYaI3LdKrYzNt
         CG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772017445; x=1772622245;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnXyv9FeSh66PWrhFp1PqKYS+k12gdJjAyfugiwsSHI=;
        b=jDzvQNV7c5C7Z/lp/LPGBiOqU/szcgzr+rmtixX93CFkYd9/bEkc3XCTx1RGfT1fVI
         70JJRR048qQCjOkeyRTEE87QDnsmxZwc9uSmC3AHIadbOfDuDYOguHX1COPjv/r0jU6g
         IHsG9GhW5eaA9suBoXcYMtjmRt56+TxJnRTZ+1Pc4d3TxnClAFvDdClDvTNjDO2xw6fb
         I/S8YHUrqcBKDUd3t7Ev7Qlf3lGSvEccKK18m6JPi7WD9+m22wgnRl42RIE8fELmtYbb
         QL4M0T22dSy34fwEb3I7jw4CFWfcb5tCPnbma7Mte30dLd1DceUy6xMJUpsf101q12m6
         xIJg==
X-Forwarded-Encrypted: i=1; AJvYcCWzi77kar+Y5BIDuIsKkBaa1rGToAEk4oRYZfoLRP0vtLVNJaLB33UScQnkd1q+NNEdJCPGMwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfjV16zv5gm+0jdVNXp2JDqHJHk8rzkWwWEaGCeSG+hAaU5D3M
	uCAan5QT7UzIBLI1LCLKbfEE6I9V/v8NPcR14s4FvjfoWPvQrYJawoyjYPemmAxojR4tvpBjZ5/
	UNc1shX6+4c786jb3rdYydyZm2b1HDMEjS+romYUjqKI/UdSUeOwmGfAutA==
X-Gm-Gg: ATEYQzxJ3yERjrbOm3K1jwYHdp7xpT6IuAhNufUG0CNnkMA47xA9gwAWvLl7fAWolsw
	2PvtTfhFQJxE49cUiJgWODBuY8ro9snPsNVhDaz1XDfS+OfGomwdVdVPOP8fSmAn7bS1LvYVAfx
	PXlRFfMXPlGf+OELm+6t4wog7Zj/YNNB42GMhS2QSgyk+lOAI3SwLy/Q+6lZkNokLIyUMwyDnBt
	LxTSVmJWJTGnyurvBCE28DX5sw3awGXfg2EftM2Mna5Jn8S1yFK3oD9WBQGSrFAe/6BpV4p9fme
	U0M+Xtj9UsTxodt7f3t7OfjHHs/7omZ3yI1/hmndRbpt/XTa1p9ZR0c1Ne6KfiuvD48JAs43Fg1
	k027vzZWR26htWS5fZi8S4EbOKnrQpMbmAu9m5kJysMgs60cr8HRPrVwrBulRui/Z3VpV7/l0LI
	hRGbrtQydOSwFDOz22iY5R7yhpD9/aqqlwPTRon7/jamQwCKPPzUO6UnLQ
X-Received: by 2002:a05:600c:4692:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-483bef53c1amr35967475e9.17.1772017445008;
        Wed, 25 Feb 2026 03:04:05 -0800 (PST)
X-Received: by 2002:a05:600c:4692:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-483bef53c1amr35966775e9.17.1772017444439;
        Wed, 25 Feb 2026 03:04:04 -0800 (PST)
Received: from ?IPV6:2a01:cb00:8ef9:5300:877b:aaab:2ea7:8695? (2a01cb008ef95300877baaab2ea78695.ipv6.abo.wanadoo.fr. [2a01:cb00:8ef9:5300:877b:aaab:2ea7:8695])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4398fefa3f8sm3573108f8f.36.2026.02.25.03.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 03:04:04 -0800 (PST)
Message-ID: <9c187cb6-6ab1-40f1-a1d8-d47012e3835b@redhat.com>
Date: Wed, 25 Feb 2026 12:04:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: commit 662dc80a5e86 breaks rmnet over usb
From: Laurent Vivier <lvivier@redhat.com>
To: Daniele Palmas <dnlplm@gmail.com>
Cc: Koen Vandeputte <koen.vandeputte@citymesh.com>, oneukum@suse.com,
 andrew+netdev@lunn.ch, Eric Dumazet <edumazet@google.com>, kuba@kernel.org,
 pabeni@redhat.com, netdev <netdev@vger.kernel.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAPh3n803k8JcBPV5qEzUB-oKzWkAs-D5CU7z=Vd_nLRCr5ZqQg@mail.gmail.com>
 <95ccf5a6-975b-4543-80a3-595f1ee20543@redhat.com>
 <CAGRyCJE85fLOahUR3PAUnS_jH4+qpBq37qpged=nvObbg1m+Qw@mail.gmail.com>
 <28cd2d03-6491-490d-89e2-19f81e9bad69@redhat.com>
Content-Language: en-US
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <28cd2d03-6491-490d-89e2-19f81e9bad69@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260886-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lvivier@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9A6B196415
X-Rspamd-Action: no action

On 2/25/26 08:48, Laurent Vivier wrote:
> On 2/25/26 08:19, Daniele Palmas wrote:
>> Hello,
> 
> Hello Daniele,
> 
>>
>> Il giorno lun 23 feb 2026 alle ore 15:08 Laurent Vivier
>> <lvivier@redhat.com> ha scritto:
>>>
>>> On 2/23/26 13:04, Koen Vandeputte wrote:
>>>> Hi Laurent,
>>>
>>> Hi Koen,
>>>
>>>> I'm testing the latest openwrt state and found an issue probably
>>>> caused by your usb mtu limit patch :-)
>>>>
>>>> I'm talking about this one:
>>>> 662dc80a5e86 ("usbnet: limit max_mtu based on device's hard_mtu")
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/? 
>>>> h=v6.12.74&id=662dc80a5e86b35bbf339e0b87b7cc3f07c09de1
>>>>
>>>>
>>>> When using wwan0 iface normally, this makes sense, but the problem is
>>>> when using QMI modems combined with the rmnet driver and aggregated
>>>> frames.
>>>>
>>>> - The modem is configured to frame sizes of 16383 or 32767 using QMI
>>>> - wwan0 (using qmi_wwan) is configured to match this frame size by
>>>> setting it's MTU to the same value
>>>> - Frames of this size are sent over to qmi_wwan driver (containing
>>>> multiple data packets)
>>>> - Frames are then forwarded to the rmnet driver
>>>> - Frames get de-aggregated here and sent to the network stack for processing.
>>>>
>>>> The reason here is to reduce USB transfers heavily.
>>>>
>>>>
>>>> As you see, it's perfectly possible here to use very large MTU sizes
>>>> as the aggregation feature by rmnet relies on this.
>>>> Also the modem can be perfectly configured to send very large aggregated frames.
>>>>
>>>> After your patch, wwan0 is limited to 1500 bytes it seems, effectively
>>>> breaking aggregation.
>>>>
>>>> On my tests, download speeds are reduced from >300Mbps to ~.8Mbps
>>>>
>>>> I also made a build reverting this patch and all works well again.
>>>>
>>>>
>>>> Is there any other solution to fix this?
>>>> I guess it should be reverted otherwise :-)
>>>
>>> It's weird to be able to set an MTU that is not supported by the hardware.
>>>
>>> To restore performance I think the rx_usb_size should be decoupled from MTU max in 
>>> qmi_wwan.
>>>
>>> Could you try something like:
>>>
>>> diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
>>> index 3a4985b582cb..6b4796fac692 100644
>>> --- a/drivers/net/usb/qmi_wwan.c
>>> +++ b/drivers/net/usb/qmi_wwan.c
>>> @@ -788,6 +788,8 @@ static int qmi_wwan_bind(struct usbnet *dev, struct usb_interface 
>>> *intf)
>>>                   usbnet_get_ethernet_addr(dev, cdc_ether->iMACAddress);
>>>           }
>>>
>>> +       dev->rx_urb_size = 32768;
>>> +
>>
>> So far userspace tools (e.g. also the most important one which is
>> ModemManager) rely on changing the rx_urb_size by changing the MTU: I
>> know this is ugly, but it is a behavior that has been there since a
>> lot of time, not sure how many tools based on this assumption could
>> break.
>>
>> There's also the chance that there are modems which require a higher
>> rx_urb_size, so having this fixed could not work well.
>>
>> Unfortunately usbnet serves many drivers, I agree with Koen that a
>> revert is the safest option.
> 
> And there is no intermediate driver (qmi_wwan or rmnet) that can define a max_mtu higher 
> than that defined by usbnet?

Perhaps we can remove the change from usbnet and move it to the device bind function?

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index a032c1ded406..836915e4abad 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -235,6 +235,8 @@ int usbnet_generic_cdc_bind(struct usbnet *dev, struct usb_interface 
*intf)

  	if (header.usb_cdc_ether_desc && info->ether->wMaxSegmentSize) {
  		dev->hard_mtu = le16_to_cpu(info->ether->wMaxSegmentSize);
+		if (dev->net->max_mtu > (dev->hard_mtu - dev->net->hard_header_len))
+			dev->net->max_mtu = dev->hard_mtu - dev->net->hard_header_len;
  		/* because of Zaurus, we may be ignoring the host
  		 * side link address we were given.
  		 */
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index ed86ba87ca4e..295c3614878b 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1829,11 +1829,9 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id 
*prod)
  		if ((dev->driver_info->flags & FLAG_NOARP) != 0)
  			net->flags |= IFF_NOARP;

-		if (net->max_mtu > (dev->hard_mtu - net->hard_header_len))
-			net->max_mtu = dev->hard_mtu - net->hard_header_len;
-
-		if (net->mtu > net->max_mtu)
-			net->mtu = net->max_mtu;
+		/* maybe the remote can't receive an Ethernet MTU */
+		if (net->mtu > (dev->hard_mtu - net->hard_header_len))
+			net->mtu = dev->hard_mtu - net->hard_header_len;

  	} else if (!info->in || !info->out)
  		status = usbnet_get_endpoints(dev, udev);

An other solution would be to add a FLAG_NOMAXMTU in qmi_wwan driver_info->flags to 
disable the setting of max_mtu in usbnet_probe() to keep the change generic and qmi_wwan 
the exception.

Thanks,
Laurent


