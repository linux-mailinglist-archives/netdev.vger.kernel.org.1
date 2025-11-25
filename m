Return-Path: <netdev+bounces-241601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F60C86627
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 19:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4E43B7AB6
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BE132C949;
	Tue, 25 Nov 2025 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV/7qJcu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsefA0c7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3732BF51
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093552; cv=none; b=ne1tZrZHD4kqyoXcKcw4chVH4fVlBm86bM7d0/cT8Iso72QoUfXi0n3tCexXQPF+g11jmCWJItLtqpAD6f98NZpgisolI0VUJH7YTixL7hDPO/t7HFA+IPvtQ/c/Mx5QgvmdNZUJGCdbxok+M5fREzgx9CGcsw+BpmT1AzGVra4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093552; c=relaxed/simple;
	bh=RyhNmS2vGG3hvmsd5fJ7DzAZ9Xaj+bN/VVH47DtsSNk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ezN/YpNbH1a3Ja8K45tK3T6bPp5OW4GPXLCbnywGIy9SWgMUFu4m2Ew+J4dYWYX6gPrYPztvKobTJlSeBKfEvv0mS6XCEzUTdDuKS+pcHHwhVd1a4WR8swZ8wxyNK/qnEk9zkkT6QE19UdspLrQMrpdKMPc0MMXR0m6O3zrTxcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LV/7qJcu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GsefA0c7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764093549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ggRdSNkElU+a399plx+DRkCBhOmqAokOxhar5O5tK68=;
	b=LV/7qJcuw2i65oqxO9Zu7e1e/IY/UxMsoC0FZ+u9W+QPYNtJOgDt1jMYxXjFQO7lFb0P/4
	4g/9vE9Eju2mtL9U/UgPMVZPE7qWhghhCRTCz0NNM5wWVZcxXncjopSBgmZC+TypXuIS3M
	Lt2Pps4H1fSLxmiBeMjXf/ifvmB9XkI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-xsMThsgMOLqgGXX1fbJH5g-1; Tue, 25 Nov 2025 12:59:06 -0500
X-MC-Unique: xsMThsgMOLqgGXX1fbJH5g-1
X-Mimecast-MFC-AGG-ID: xsMThsgMOLqgGXX1fbJH5g_1764093545
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso59199765e9.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 09:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764093545; x=1764698345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ggRdSNkElU+a399plx+DRkCBhOmqAokOxhar5O5tK68=;
        b=GsefA0c7tsKLzxKIXbCKZH+0eVBI7EiSpPW4QX+mwwgYVBgumGFXDNrnNh1D7qxVCW
         ui+aVTXOtTZRP+QoDM19upoQAIVyPk3mhvY824tf2NmsYi/2R9x1fawiASrLTZZ8ZwhF
         JRSlkMPU//KbQqeEK5UmbTF7EoWRIDlr3qSgT6e8rW3MFlATL6SK+haITfLa3sdx+VqE
         Nx3lAdaZYb0vA6nWWFAv0JqvU3fTFP62dIGEiWAAoTugreOSSTaELXUcSDceecjOkpJO
         sOaA64g32gtO/YXDxACOFgDA0XhVIw3Ims5roSlyjILEQY74yq3UxnwKthcg28j9pkoM
         1ZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764093545; x=1764698345;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggRdSNkElU+a399plx+DRkCBhOmqAokOxhar5O5tK68=;
        b=Lemavw5zCU9idgEjkxonr6Zg/lHw0f3ZFy3LCCBugTVEitJp/g3NZFmgmGzKHnfxrU
         CYxbrxApELE5YklX52hZf4n8pHddjE/NhJIWUc0fJcQLkfntqyF56S/kdrHPn7agwGtr
         k6qL/lNL+cbCbpiokEn7wyUUlggTI3yfwJDmo22tU7KgrrkzvJc7Og51whLPhRZmEcfw
         wKJEvyW03Ehvo1WWtstBiK5Xma2PPILqfbjYN/okmGFr9lP4CrmjhD/gUHjdec9Mncrr
         aRMVDyWRzmm7ESxhc5IWJvBw6zvM2itdjzI5VTBQKjxahBpvEQWfCP8aiW8C7tqSXodI
         FRVw==
X-Gm-Message-State: AOJu0YwdgyAJwF1KZizNkC2baNkOTnHL1MBiccfZ+3lYWV6dHZrtz/2Y
	UheseWsTSbr6YMtF3Dqp+e+u+yQsXwzjxHyq0qpIXWrporjPL6TWCmSBxEfyZonONmD+TlUQFlL
	/+yv5YCKJY+tJXO3IOZGtt9dP+BFThO/JARDglfvdR3ckoPU2biWJjJDfMg==
X-Gm-Gg: ASbGncs/RQu+MGfFws59EPB7Yx/+W8Y/n/HDPu5QwvVDloCiOc81+RUA3nxOglSpAAh
	rSSqW3rZzb7g+iouWwZw7blOmQYEKyfKK1UY3eqRzWl7Zu/zy6mf5DKGcWTvDbWCECfF6sCnjAT
	zITCeAjKA+p1gWpcGGtY97wOz1c9SCveg21QZ8Fc5et7zsbD/2Q/9wTYpnBqT02JlnGZH173l9t
	KgjcCJJw2hgqTbOz//X0p6wUQJ/kyhrxcZOxtMK9fiV24KbC6uZwgMWIA7Nz2Aoq1kRxKxteyoh
	+n9avrTvXahs8wGMm2VXLF8epuiBc5j0koZGFU5vP47VLF+yiXJ56D24qV2WOodc4VwsqbXACMo
	=
X-Received: by 2002:a05:600c:354e:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-47904b12eb0mr32984045e9.17.1764093544982;
        Tue, 25 Nov 2025 09:59:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7KQT3sUoiUAmwtj+59LzZJLLFJ+8j4a0ieDuHCTy3Ekk0Z4pUbgQyJD2REcyJfcjeD9yfHA==
X-Received: by 2002:a05:600c:354e:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-47904b12eb0mr32983845e9.17.1764093544552;
        Tue, 25 Nov 2025 09:59:04 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363b0sm36115430f8f.13.2025.11.25.09.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 09:59:04 -0800 (PST)
Message-ID: <8492bf2b-0fbc-4819-ab7a-dfe860cca412@redhat.com>
Date: Tue, 25 Nov 2025 18:59:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] virtio-net: avoid unnecessary checksum
 calculation on guest RX
From: Paolo Abeni <pabeni@redhat.com>
To: Jon Kohler <jon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20251125175117.995179-1-jon@nutanix.com>
 <276828c5-72cb-4f5c-bc6f-7937aa6b6303@redhat.com>
Content-Language: en-US
In-Reply-To: <276828c5-72cb-4f5c-bc6f-7937aa6b6303@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/25 6:57 PM, Paolo Abeni wrote:
> On 11/25/25 6:51 PM, Jon Kohler wrote:
>> Commit a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP
>> GSO tunneling.") inadvertently altered checksum offload behavior
>> for guests not using UDP GSO tunneling.
>>
>> Before, tun_put_user called tun_vnet_hdr_from_skb, which passed
>> has_data_valid = true to virtio_net_hdr_from_skb.
>>
>> After, tun_put_user began calling tun_vnet_hdr_tnl_from_skb instead,
>> which passes has_data_valid = false into both call sites.
>>
>> This caused virtio hdr flags to not include VIRTIO_NET_HDR_F_DATA_VALID
>> for SKBs where skb->ip_summed == CHECKSUM_UNNECESSARY. As a result,
>> guests are forced to recalculate checksums unnecessarily.
>>
>> Restore the previous behavior by ensuring has_data_valid = true is
>> passed in the !tnl_gso_type case.
>>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
>> Signed-off-by: Jon Kohler <jon@nutanix.com>
>> ---
>>  include/linux/virtio_net.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>> index b673c31569f3..570c6dd1666d 100644
>> --- a/include/linux/virtio_net.h
>> +++ b/include/linux/virtio_net.h
>> @@ -394,7 +394,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>>  	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
>>  						    SKB_GSO_UDP_TUNNEL_CSUM);
>>  	if (!tnl_gso_type)
>> -		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
>> +		return virtio_net_hdr_from_skb(skb, hdr, little_endian, true,
>>  					       vlan_hlen);
>>  
>>  	/* Tunnel support not negotiated but skb ask for it. */
> 
> virtio_net_hdr_tnl_from_skb() is used also by the virtio_net driver,
> which in turn must not use VIRTIO_NET_HDR_F_DATA_VALID on tx.
> 
> I think you need to add another argument to
> virtio_net_hdr_tnl_from_skb(), or possibly implement a separate helper
> to take care of csum offload - the symmetric of
> virtio_net_handle_csum_offload().
> 
> Also you need to CC netdev, otherwise the patch will not be processed by
> patchwork.

whoops... I almost forgot... this is 'net' material, the subj prefix
should be adjusted accordingly.

Thanks,

Paolo


