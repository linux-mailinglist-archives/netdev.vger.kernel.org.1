Return-Path: <netdev+bounces-273538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIwmAy2Ty2nMJAYAu9opvQ
	(envelope-from <netdev+bounces-273538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:26:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF4A36708C
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC0D230ABD6A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C1F3ED12E;
	Tue, 31 Mar 2026 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLuUGM81";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAMSBnH2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290EB3ED124
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948859; cv=none; b=kKRYe97HAUxcAZ2u9qm6gcmIJDQGkWHzsGT+MgnIXi3Vf0OHQPWXR1m6c+WIU5lklbDMh2b3bxDDM3IJv1fl6ffp+61f++wKxYXBOIPCqkPr0eJppZbX1woB4nyBU7MpPyAoHun67KOk+ZFUJbgd1sMtecp8QfJA5rsv9QiGLK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948859; c=relaxed/simple;
	bh=npAzXkJWcAEQdybp4dELF99mAn10Mr9vx71ipcJ4toI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxP5IJQPUfz25k02ExIfjhw2j7VDipvUyQ4Wv5NgrxlVb3rlOjwCXpCFUQ2oaNxhtv4c6nXpWjYzAYUCUX+yFe3aq99pA/jZ0sEVac8JWoPOatkbP0FfCuu4CRUbVJo51uUyC1fri+DDCH1AtV7ftFAFpZ83ABx7rZiFu0VW53E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XLuUGM81; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DAMSBnH2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774948857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEFy+ly0SyOy8YL/S4CPl+fJ88M+Cfc8bAbwXPfI46s=;
	b=XLuUGM81hZ1SVPPR0NetU+07TJDRr7HQw6Ims4DJm70cSqqffiqZt5/CQg7/vOxxSLqYs9
	mlYZnA1LMKkw0UJHGC1k9gUFFKAF0OFHs/kg1TIpl+eNzwv1nV0kqb2TgR/UFAy/GuoFpM
	4djh6/L1i6OeJSGrqe0BYyjeGbOo2SM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-x3K5mjtrPIa_72k3WUKosA-1; Tue, 31 Mar 2026 05:20:55 -0400
X-MC-Unique: x3K5mjtrPIa_72k3WUKosA-1
X-Mimecast-MFC-AGG-ID: x3K5mjtrPIa_72k3WUKosA_1774948854
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-487219e0800so37513425e9.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 02:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774948854; x=1775553654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jEFy+ly0SyOy8YL/S4CPl+fJ88M+Cfc8bAbwXPfI46s=;
        b=DAMSBnH2nsWpXjc79WnLI56SFR38U4+5rjlaaRxjMXkLG/n+HdvqlLo7a0zLOq0U6r
         R4p5ZvKZxeNaoLVXNDYOxsluKNRG3LtXQSRwrQStaE/kMGmsJBom2ghX+OH6z7jY1ccK
         o2D1ccti+P2s4nBPCAmOfAAQ58dYWZ5p8K5sOPXGe3Zizmz7Yff5ez1ZHsVL6z5ctEsg
         bXJHJVm+EPLxUhMOzpq/iUSbDo6W4vlSC4CgMwYg48P+sd31d4rGWp+1lDPP6osBxUnW
         WZHUpEVmKttCbVj/UUNaBF+WlOWATN/sHddCr1ypYZ8zUrQoH5o95ZOfe/vfAKmNziQb
         dOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774948854; x=1775553654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEFy+ly0SyOy8YL/S4CPl+fJ88M+Cfc8bAbwXPfI46s=;
        b=qXIohjENfP80mlia47U7ARhkgibc3XSF6L6LrRSgnTZS6L/fr1+kkhxkZ2DbxZBdJj
         StOd7ogvlmZ17/SdPIsH2hQmUgck50f1HbsN/byGiVPpvpaZBf/8HnE/ZMFr4m0MNlFx
         ZGF1F8qJd8gr+7/pIhmmXHMrYA7E7KOZI+n0I4X7IOBC5yxj26nD8LiZp7Ve7gvGchg1
         59iKgtWIP3HlceZaRv4iKAbIE40x3k7nLK0oBduodbUX/1hPtUHP4Us0pmN4hNhssS4H
         o7VBnwY6qSbCuQGOCEBXMCTPM0rB7wIvXPBxRj2HYRPNBtPzLN69DtpEGKEtLnjVJ6Du
         KLQA==
X-Forwarded-Encrypted: i=1; AJvYcCVeptgNNiGQ20Rsl2KezxGVK6LYpaHPRICdc+nXjcoDF5IJ0pdYqmdlJKi9wT+UMLzgR6IXzvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLOx1KHo3yjAkFyfTufDVJvS+Lg2HxDtz0rdm3LslmcF8Vd/cm
	U/0/WyRHuI6C9sFNFOe6CzY6gjWb90l7NwEzFeobmE8DKVDnlRNGi8sYBSJNRjnEVlGuUQ1qFsm
	i2/0E8JkQzxqxxDMh4TVhlvevuc410M5satMVWCkKpdbS69wa9JUQBqJ27Q==
X-Gm-Gg: ATEYQzyXFerFF9Jq68ZUbc7LwawDt9RsztNMyTk08vuLVKt8Vyn/x199vbRAYxtnmAO
	qwa0zDukwS1Mf/sGsF9xCaWrbuc9I3K0HNXVhBBKGEYehnKb1yLohoP76uxGcB93eibzGHknV+R
	jLIZQQxu29gINoZaFDJa81X0jB1sLA1Tpx78DJW6gIBZxVCiPWyI/x7OtSeFG3u6fv0nmKSi+R6
	2rh/2N9ShjLq7V2o05D6Uu9Hm2E6wITkmco7dKa+js+BPLUm4CarrpRBMGgv3xH0OpCjoJ3ULFx
	g8Bo7uU1R4Pt8sYzcTXXebVzyUq8f2kLnVZXD7/roRoGLoreS5Rvqo1BYydeZhhDbIIgviR38SM
	8yuUI8KEqXm+2VTB812XCw4rZn6V0QYjQYqGE5z78W01oEDpiR5K6ABwV
X-Received: by 2002:a05:600c:83c4:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-48727d87b56mr262108805e9.11.1774948854117;
        Tue, 31 Mar 2026 02:20:54 -0700 (PDT)
X-Received: by 2002:a05:600c:83c4:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-48727d87b56mr262108175e9.11.1774948853631;
        Tue, 31 Mar 2026 02:20:53 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80148csm23480185e9.5.2026.03.31.02.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 02:20:52 -0700 (PDT)
Message-ID: <ba027306-e5e0-4d4d-8357-f6080441167d@redhat.com>
Date: Tue, 31 Mar 2026 11:20:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v5] virtio_net: clamp rss_max_key_size to
 NETDEV_RSS_KEY_LEN
To: Srujana Challa <schalla@marvell.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, ndabilpuram@marvell.com, kshankar@marvell.com,
 stable@vger.kernel.org
References: <20260326142344.1171317-1-schalla@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260326142344.1171317-1-schalla@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-273538-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: 5DF4A36708C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 3:23 PM, Srujana Challa wrote:
> rss_max_key_size in the virtio spec is the maximum key size supported by
> the device, not a mandatory size the driver must use. Also the value 40
> is a spec minimum, not a spec maximum.
> 
> The current code rejects RSS and can fail probe when the device reports a
> larger rss_max_key_size than the driver buffer limit. Instead, clamp the
> effective key length to min(device rss_max_key_size, NETDEV_RSS_KEY_LEN)
> and keep RSS enabled.
> 
> This keeps probe working on devices that advertise larger maximum key sizes
> while respecting the netdev RSS key buffer size limit.
> 
> Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
> Cc: stable@vger.kernel.org
> Signed-off-by: Srujana Challa <schalla@marvell.com>
> ---
> v3:
> - Moved RSS key validation checks to virtnet_validate.
> - Add fixes: tag and CC -stable
> v4:
> - Use NETDEV_RSS_KEY_LEN instead of type_max for the maximum rss key size.
> v5:
> - Interpret rss_max_key_size as a maximum and clamp it to NETDEV_RSS_KEY_LEN.
> - Do not disable RSS/HASH_REPORT when device rss_max_key_size exceeds NETDEV_RSS_KEY_LEN.
> - Drop the separate patch that replaced the runtime check with BUILD_BUG_ON.
> 
>  drivers/net/virtio_net.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 022f60728721..b241c8dbb4e1 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -373,8 +373,6 @@ struct receive_queue {
>  	struct xdp_buff **xsk_buffs;
>  };
>  
> -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> -
>  /* Control VQ buffers: protected by the rtnl lock */
>  struct control_buf {
>  	struct virtio_net_ctrl_hdr hdr;
> @@ -478,7 +476,7 @@ struct virtnet_info {
>  
>  	/* Must be last as it ends in a flexible-array member. */
>  	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
> -		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
>  	);
>  };
>  static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
> @@ -6717,6 +6715,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	struct virtnet_info *vi;
>  	u16 max_queue_pairs;
>  	int mtu = 0;
> +	u16 key_sz;
>  
>  	/* Find if host supports multiqueue/rss virtio_net device */
>  	max_queue_pairs = 1;
> @@ -6851,14 +6850,13 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  
>  	if (vi->has_rss || vi->has_rss_hash_report) {
> -		vi->rss_key_size =
> -			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
> -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
> -				vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
> -			err = -EINVAL;
> -			goto free;
> -		}
> +		key_sz = virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
> +
> +		vi->rss_key_size = min_t(u16, key_sz, NETDEV_RSS_KEY_LEN);
> +		if (key_sz > vi->rss_key_size)
> +			dev_warn(&vdev->dev,
> +				 "rss_max_key_size=%u exceeds driver limit %u, clamping\n",
> +				 key_sz, vi->rss_key_size);

NETDEV_RSS_KEY_LEN is 256 and virtio_cread8() returns a u8. The check is
not needed, and the warning will never be printed. I think that the
BUILD_BUG_ON() you used in v4 would be better than the above chunk.

/P


