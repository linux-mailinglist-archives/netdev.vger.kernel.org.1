Return-Path: <netdev+bounces-201154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17356AE84D6
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797031884DA8
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B2A1B4248;
	Wed, 25 Jun 2025 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsNWRZch"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A82126BFA
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858344; cv=none; b=Fs3FHvEe5Lqv4XhSHboYMUyfd8VtPakwrNXrapXbc4sBB34J4sfWZIxlVMxOWj7wWtocONj8+4pjo9ddp1hqxKEFoz7QKRmrt4MRBWwtwyHERw2l+kdVVpqMwIR/rxnDkPdmcMtcrVqRruOHNOsMPSVYhe75Ns9yqk3I7s1BjCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858344; c=relaxed/simple;
	bh=tgyI93DqO+iceJu24PzG+d1oFJs9Iucz7h4dqyH8ohU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+eKaAHilTjXG7m9mAyuja5lbI6nbqEY3JBestc5KjXHZmPaFQsBbLT3aWo0PBWXL+ger5D9N4mHfI36XS75tkqBgtekEnjgQdJLJmSBVxSmzLNy6tqxmdGovuxonSOvqrIm9gLgxgUIa7bW4RoXiGPTZXULuCpcvMJtA7frgYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsNWRZch; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750858341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Fwu8mDntzdWYt27Qd6IJlpVfWUrdOeVJ2HfrSFGosU=;
	b=LsNWRZchiyBVgMaxE4dB6l6MEYVKQiJ/wDLXQv2b0TRAlQRaXRMePEBAjgrjKVb2dRRdRR
	dkVCoaZvgX6Fy7LqgehR5UwgPYZfBu0Y4LEV9EknUxLyvrOBR2ZcrK8bls9WsbOc5k1CAq
	a54Dz6pQ0q5DqhIdBGMZP7O9rT7rE50=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-N3hBFdo3N625_i7A3JLxUg-1; Wed, 25 Jun 2025 09:32:19 -0400
X-MC-Unique: N3hBFdo3N625_i7A3JLxUg-1
X-Mimecast-MFC-AGG-ID: N3hBFdo3N625_i7A3JLxUg_1750858339
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so8857335e9.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 06:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750858338; x=1751463138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Fwu8mDntzdWYt27Qd6IJlpVfWUrdOeVJ2HfrSFGosU=;
        b=QKNtqBByaEheN9SKv7gTX9V6agACqjW9Dx8+wug8LNDtn5KqBlFdDuza5BvIIk14cb
         shkG+my3625wJqNgwaimDPcksS6G0azT2Rpl+dhxCGM1wVjxYHWnC/rDNiQK3xTeyOGb
         PTkGdGKPQ/L85JZ9uJskItVzWASOg2dENtAnLy7wNB+mSJVrbNR/9oX4dqrm6lPTBjEg
         quwsBrNciCQi2JGpWKfhqc4kFVWD2+jC+hJr24FnEovJsc/Oy2M+IccB9kwhINSJgGO/
         3b/+wrpzV6gr54EqR8A3d2Ty9wnSoNgvVEY8TFDVptqQB/ThQ0pjx73b6JU8oSaxUs5d
         B47A==
X-Forwarded-Encrypted: i=1; AJvYcCVoA8xqWXjVhjbBzJyjohQzBMtd+z4SHlrEoNNQ8DMbQXFzt6f//h02BkKEJinSmyDO/ZvKf5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGO8OLyk3BG3GOF0+v3mSLtXYeKsTJyzR8BCvfo81SWVCgSflr
	RKNZNtdkmhHtCZsWI0hBD9NhpFRPc1ufI/TUiSTVU1mRzqdilLCf11i2YL84fENSzlM/8u/IXUs
	Mam9qsyemLFvp84BZaTeIO9acNmLofQb7BGBNpgUNWM1fUwKRTOuSAABfuw==
X-Gm-Gg: ASbGncsfrMBh0ZTrddo0wcDsm+OPS/xnmrKvKhbZYTXx0H9foQUuTn3lMZQ0XZMgWl9
	K5tVuPxaXrHyMwno6f972OTcOdIZ8AORlgBYQLCDuZEAsEu49WEwaF/wR/l0F0dO7JusMBvleNq
	6oTn+tYKJOL8GoaOv4joPhXU7Xr7j7/0oid37fsXKHiOHLB2BSyanG45N+LiwgDMKi1D6H6NbAq
	aJKWeD0fwJSY5raMDskHkHLGPLK+VJCeB77A76TB2855ImXuAuZLRGHFZRPyYQoWM3FaK3Kljwx
	17tHYKazA8X/8WwajS5hTqCuX5Gx
X-Received: by 2002:a05:600c:3b95:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-453879e27acmr3103715e9.6.1750858338477;
        Wed, 25 Jun 2025 06:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY//pCRPoC2EFYGzFZ4umPjaocK1G0vDEhyvr5hVoQgUAHwK1E7Yy9rAocwNi9NP80rjw6AQ==
X-Received: by 2002:a05:600c:3b95:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-453879e27acmr3101355e9.6.1750858336283;
        Wed, 25 Jun 2025 06:32:16 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.218.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f2a4csm4708245f8f.65.2025.06.25.06.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:32:15 -0700 (PDT)
Date: Wed, 25 Jun 2025 15:32:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: Xuewei Niu <niuxuewei97@gmail.com>, KY Srinivasan <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "stefanha@redhat.com" <stefanha@redhat.com>, 
	"leonardi@redhat.com" <leonardi@redhat.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "fupan.lfp@antgroup.com" <fupan.lfp@antgroup.com>, 
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [EXTERNAL] Re: [PATCH net-next v3 1/3] vsock: Add support for
 SIOCINQ ioctl
Message-ID: <wgyxcpcsnpsta65q4n7pekw2hbedrbzqgtevkzqaqkjrqfjlyo@6jod5pw75lyf>
References: <20250617045347.1233128-1-niuxuewei.nxw@antgroup.com>
 <20250617045347.1233128-2-niuxuewei.nxw@antgroup.com>
 <y465uw5phymt3gbgdxsxlopeyhcbbherjri6b6etl64qhsc4ud@vc2c45mo5zxw>
 <BL1PR21MB31158AE6980AF18E769A4E65BF7BA@BL1PR21MB3115.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <BL1PR21MB31158AE6980AF18E769A4E65BF7BA@BL1PR21MB3115.namprd21.prod.outlook.com>

On Wed, Jun 25, 2025 at 08:03:00AM +0000, Dexuan Cui wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>> Sent: Tuesday, June 17, 2025 7:39 AM
>>  ...
>> Now looks better to me, I just checked transports: vmci and virtio/vhost
>> returns what we want, but for hyperv we have:
>>
>> 	static s64 hvs_stream_has_data(struct vsock_sock *vsk)
>> 	{
>> 		struct hvsock *hvs = vsk->trans;
>> 		s64 ret;
>>
>> 		if (hvs->recv_data_len > 0)
>> 			return 1;
>>
>> @Hyper-v maintainers: do you know why we don't return `recv_data_len`?
>
>Sorry for the late response!  This is the complete code of the function:
>
>static s64 hvs_stream_has_data(struct vsock_sock *vsk)
>{
>        struct hvsock *hvs = vsk->trans;
>        s64 ret;
>
>        if (hvs->recv_data_len > 0)
>                return 1;
>
>        switch (hvs_channel_readable_payload(hvs->chan)) {
>        case 1:
>                ret = 1;
>                break;
>        case 0:
>                vsk->peer_shutdown |= SEND_SHUTDOWN;
>                ret = 0;
>                break;
>        default: /* -1 */
>                ret = 0;
>                break;
>        }
>
>        return ret;
>}
>
>If (hvs->recv_data_len > 0), I think we can return hvs->recv_data_len here.
>
>If hvs->recv_data_len is 0, and hvs_channel_readable_payload(hvs->chan)
>returns 1, we should not return hvs->recv_data_len (which is 0 here), 
>and it's
>not very easy to find how many bytes of payload in total is available right now:
>each host-to-guest "packet" in the VMBus channel ringbuffer has a header
>(which is not part of the payload data) and a trailing padding field, and we
>would have to iterate on all the "packets" (or at least the next
>"packet"?) to find the exact bytes of pending payload. Please see
>hvs_stream_dequeue() for details.
>
>Ideally hvs_stream_has_data() should return the exact length of pending
>readable payload, but when the hv_sock code was written in 2017,
>vsock_stream_has_data() -> ... -> hvs_stream_has_data() basically only needs
>to know whether there is any data or not, i.e. it's kind of a boolean variable, so
>hvs_stream_has_data() was written to return 1 or 0 for simplicity. :-)

Yeah, I see, thanks for the details! :-)

>
>I can post the patch below (not tested yet) to fix hvs_stream_has_data() by
>returning the payload length of the next single "packet".  Does it look good
>to you?

Yep, LGTM! Can be a best effort IMO.

Maybe when you have it tested, post it here as proper patch, and Xuewei 
can include it in the next version of this series (of course with you as 
author, etc.). In this way will be easy to test/merge, since they are 
related.

@Xuewei @Dexuan Is it okay for you?

Thanks,
Stefano

>
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -694,15 +694,25 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
> static s64 hvs_stream_has_data(struct vsock_sock *vsk)
> {
>        struct hvsock *hvs = vsk->trans;
>+       bool need_refill = !hvs->recv_desc;
>        s64 ret;
>
>        if (hvs->recv_data_len > 0)
>-               return 1;
>+               return hvs->recv_data_len;
>
>        switch (hvs_channel_readable_payload(hvs->chan)) {
>        case 1:
>-               ret = 1;
>-               break;
>+               if (!need_refill)
>+                       return -EIO;
>+
>+               hvs->recv_desc = hv_pkt_iter_first(hvs->chan);
>+               if (!hvs->recv_desc)
>+                       return -ENOBUFS;
>+
>+               ret = hvs_update_recv_data(hvs);
>+               if (ret)
>+                       return ret;
>+               return hvs->recv_data_len;
>        case 0:
>                vsk->peer_shutdown |= SEND_SHUTDOWN;
>                ret = 0;
>
>Thanks,
>Dexuan
>


