Return-Path: <netdev+bounces-171135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6117CA4BA79
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42EB07A3C86
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3762B1F03D9;
	Mon,  3 Mar 2025 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7XGE3v6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765F51F03E1
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993147; cv=none; b=VRoaKSPeAqU00SOixXFiPLaiCCQmxLmGCGOpflsKE5HO+6kqhEg/KorPgO2Smxx5owYW0jxRtgscDlxwxzD0i6iCLs42xcE/4Uf1cX3aeh5IA7R7tDjDx+RNVuwwZVzi1CEbcOijpslKkuaNXDe5w7oxSIVEYpkLRrX73VltBkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993147; c=relaxed/simple;
	bh=geG++AXD09rWCrdjxBMlqbjlj7UuYkL2iv00OIpXTMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jp51M/mA6nz33EpPXoX9zvxbgD4OnK3uCedpeC6rqBEPjF+6DaGIY1umU0yJ8ZLJ6UE2tVErer/+r7f+mnsdUY71U5h/pA7XCKQ5dBAoj5/I1+Du4SM8vIKdaUFakEhz82wZoPAA/kO0GFpYoT31X4x4JYEAIXW5l+Trof8j/4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7XGE3v6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740993144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YjVRjv35fHjv7RLlPVFkOhvXHHHtnF0rtq1Tf6M4yK4=;
	b=O7XGE3v65/orgFkBZUZoX631V8/e/RfphwLfsbi4WnIzhPNVycd7SWrGGnT0npuYgtP1UX
	YgVickcdYaHPsmPfVvaaQCNZ50wCuIXQicFQwLXQuxPDAFxrk16JIUTE7ryCZY0vtkK8bL
	Wx8x/WQ/rZaKxRGZtbClNVaL/QXSyxQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536--7796hQnP-eLl56wIsayOg-1; Mon, 03 Mar 2025 04:12:13 -0500
X-MC-Unique: -7796hQnP-eLl56wIsayOg-1
X-Mimecast-MFC-AGG-ID: -7796hQnP-eLl56wIsayOg_1740993132
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e4cf414a6fso3380713a12.1
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 01:12:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740993132; x=1741597932;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjVRjv35fHjv7RLlPVFkOhvXHHHtnF0rtq1Tf6M4yK4=;
        b=fOL30FlW+UsMLe9mj7m2myQ2vdwI5zmsit3seL9zv7OhPbXrJ3pxceHj64VMVTqXZN
         PracAEDNjdBRsldVWkhkRwpD9sGnb/bSl855S8av/3nqBRSWlWYFqiwUn4eRoBxo5boX
         kvG/24APLq9iWARX/KK1lyJZqYUY2qewCWzHHhJEtqrZyECGZiAfYHAtqRceRQXW0Hg2
         NXpoUjGxaG78yml4HGKHE2XPMynv1yUp8zD7qP/FbhpgiwoJgcghZ0oKW+5NCOYleXBK
         wWwXFaQDrNXaTrtZ4eLJVoEv6waSrrJ03DYqvH03h46dfTNhivpCGPP7Ap+qN91Dk5CD
         Cg8A==
X-Forwarded-Encrypted: i=1; AJvYcCVTMgHTFXe5z6zPcoTJkInpHFEZ2vAtFlym5nsWOmVBqlda1R2bDC7XDhkG4Y0iou3jHGki2mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjCbYRdz1yU5JUpm3CgDZEoqtT4uCvZkQMmWKQBLFzS04GIqMg
	4J+6qQ2JD709poeD4vXDhxIWO/NVEMZK2XF1MIpAh1gRHTfjtUFHUlQq7tdvRaWdX3GGc7tb+ag
	5qmPh0sBauCOtflGbC93xC10w5N/0HZHehz2lJaDY5uq2juXescfypA==
X-Gm-Gg: ASbGncvwDppuvz6OcvM1UGIMZMJUUyjfFKG37ONGsyv18w01dFVibSDobSEmIp0G8GQ
	iadJXw1I/beaVR2Wlzh9EOc62E0KhFrzgzM0Ccpa+xB3FnkOofHXoLrjEwrazUP1EvCWgw4pxZp
	s6P34j10pWfOB7kld1+4dyv6OODMPTpiGZkqAnVHhKEN57MBcKxKoV0w3tWkMmgHOjC9yevQOtK
	GFBpJ5mYmCxPJiTe/J6f6QvdjYdsdZjpfg8kHz8o82QWYU8GkB91f+oF4631cHoYcBMkm9JuzTY
	+NMbtMFkdSBi6uquKIKS2ZsfLWyTrFcnhOUv1/g5yqQXvYMEDMXfXqmQzBvr/XDp
X-Received: by 2002:a17:907:da2:b0:abf:777d:fb7a with SMTP id a640c23a62f3a-abf777dfd1amr339933066b.46.1740993131904;
        Mon, 03 Mar 2025 01:12:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtqN1qqtRWL94TvBz+1bpSPX8FaHG0oLP1oFMSS8+5uidcrPRyW31eyU/Z3YzkjO4tPcIZtw==
X-Received: by 2002:a17:907:da2:b0:abf:777d:fb7a with SMTP id a640c23a62f3a-abf777dfd1amr339929466b.46.1740993131263;
        Mon, 03 Mar 2025 01:12:11 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf78023d7esm172842966b.34.2025.03.03.01.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 01:12:10 -0800 (PST)
Date: Mon, 3 Mar 2025 10:12:06 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, mst@redhat.com, 
	michael.christie@oracle.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <svi5ui3ea55mor5cav7jirrttd6lkv4xkjnjj57tnjdyiwmr5c@p2hhfwuokyv5>
References: <20250302143259.1221569-1-lulu@redhat.com>
 <20250302143259.1221569-9-lulu@redhat.com>
 <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>

On Mon, Mar 03, 2025 at 01:52:06PM +0800, Jason Wang wrote:
>On Sun, Mar 2, 2025 at 10:34 PM Cindy Lu <lulu@redhat.com> wrote:
>>
>> Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
>> to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
>> When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
>> is disabled, and any attempt to use it will result in failure.
>>
>> Signed-off-by: Cindy Lu <lulu@redhat.com>
>> ---
>>  drivers/vhost/Kconfig | 15 +++++++++++++++
>>  drivers/vhost/vhost.c | 11 +++++++++++
>>  2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
>> index b455d9ab6f3d..e5b9dcbf31b6 100644
>> --- a/drivers/vhost/Kconfig
>> +++ b/drivers/vhost/Kconfig
>> @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
>>           If unsure, say "N".
>>
>>  endif
>> +
>> +config VHOST_ENABLE_FORK_OWNER_IOCTL
>> +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
>> +       default n
>> +       help
>> +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allows
>> +         userspace applications to modify the thread mode for vhost devices.
>> +
>> +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `n`,
>> +          meaning the ioctl is disabled and any operation using this ioctl
>> +          will fail.
>> +          When the configuration is enabled (y), the ioctl becomes
>> +          available, allowing users to set the mode if needed.
>> +
>> +         If unsure, say "N".
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index fb0c7fb43f78..09e5e44dc516 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>>                 r = vhost_dev_set_owner(d);
>>                 goto done;
>>         }
>> +
>> +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
>>         if (ioctl == VHOST_FORK_FROM_OWNER) {
>>                 u8 inherit_owner;
>>                 /*inherit_owner can only be modified before owner is set*/
>> @@ -2313,6 +2315,15 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>>                 r = 0;
>>                 goto done;
>>         }
>> +

nit: this empyt line is not needed

>> +#else
>> +       if (ioctl == VHOST_FORK_FROM_OWNER) {
>> +               /* When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is 'n', return error */
>> +               r = -ENOTTY;
>> +               goto done;
>> +       }
>> +#endif
>> +
>>         /* You must be the owner to do anything else */
>>         r = vhost_dev_check_owner(d);
>>         if (r)
>> --
>> 2.45.0
>
>Do we need to change the default value of the inhert_owner? For example:
>
>#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
>inherit_owner = false;
>#else
>inherit_onwer = true;
>#endif
>
>?

I'm not sure about this honestly, the user space has no way to figure 
out the default value and still has to do the IOCTL.
So IMHO better to have a default value that is independent of the kernel 
configuration and consistent with the current behavior.

Thanks,
Stefano

>
>Other patches look good to me.
>
>Thanks
>
>>
>


