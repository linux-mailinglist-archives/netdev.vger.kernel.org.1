Return-Path: <netdev+bounces-142761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 145229C0450
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919DC1F21ACE
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B0620EA3A;
	Thu,  7 Nov 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gG+DmtcU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4840820EA2C
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979602; cv=none; b=j8+4f7FR9+Egm/GQIE0mH59MqVHPvjoEjhYuMsfZ51t60jaMEdTymj5XXwh/avgya4pKku2fHsqp1IjbDDPL3vyoVu37flvusK1kXRyYwEkSsGYbhpb1as/lOByqH/IRdF3+vreZ1Ym8gg5BIIXIwfPyfljbdGXqhfXKiaYkPMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979602; c=relaxed/simple;
	bh=Dr1wnbMAcJ85mpqEQLLTPIf5QuKyNUdsjtKtaj8po5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sQILp1HZUQuVkroV/PvFE3im9zpL+lBJsXRHIVCnM5okxi6Jrf9qf40CDm1eH5T3rOfhiPxET5r4092pWlmqJuMBBFHOoJKqrmxrrsz3QQlXzA61qCKG/Fcw80fhZuPaE+RD+Mkv+ovALkd/OyB2E0gpUQvu7nleyxUHMRv8NXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gG+DmtcU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730979599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sU82hUgjAkYityCy1/Sw+2BlAMEi+LklRUiq4lsDGRk=;
	b=gG+DmtcUeVBgKP7GCruSWKAcPZaCPcq0SWNfjhigFS7qBcRmZ2PgXp2dCfb0n7lg6g+A/V
	gvgB41mOUyem2eFH9JTWNNMBsLT6xKmKJPFG44WFB5ypZRbbstyansDklz8oYgalzRvwmQ
	LtuFNnX62ML+tu6Hynh8uUJbsGFOdto=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-hVX_m7slMxST4gXtiOgNtA-1; Thu, 07 Nov 2024 06:39:58 -0500
X-MC-Unique: hVX_m7slMxST4gXtiOgNtA-1
X-Mimecast-MFC-AGG-ID: hVX_m7slMxST4gXtiOgNtA
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-288543b7a16so1232791fac.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 03:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730979597; x=1731584397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sU82hUgjAkYityCy1/Sw+2BlAMEi+LklRUiq4lsDGRk=;
        b=kvTR4l3MARnRMgm0birwoKZK0DbHzg8Wl7YyhMnq3xVx0BwxQ+bxOCvv+Bo6i3bqYT
         iZW+HNcDZDn3aEOvUqc32DR+9GXF3tkr/KLMpGIZel4is+E4QL389cnFvt4MOcn/RTTP
         1MPNxAGLQL485VqWP6y3egibHNf8y+I77KQ851fyJShowjxdaof2eECZd4BHI7W2GYOs
         xDA4s9xwjocEd5y3u7OkYtTKVQo6yBIz0XmG1wcnSm/BgUqECgInRPb+zqRMQj3ZiGq7
         +zxJRn4jRhGNHCFi2fierR95LJCAZqKeFVddMXQyJAVVO8ocn3Xgb1woOMRek+NZpLLQ
         ZJwA==
X-Forwarded-Encrypted: i=1; AJvYcCV6Lj++CsCl+UW7uOnmULeobAfhRROTunDnsn8KS7bxGFkoAJTmToy7BRopGtfFjYJnfPKuDW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNhUXL9JZ9m76RN41hSSRwtT5IQXugmaVFG27Z40aZa4S9kY3a
	FGRaY06HWxymhHMGnJKl2yyX4dwSPwVP1TTETycwYN1sqmsp7GEIzqOvnDJp/u8I8mLtPeQTJpL
	UIVRVonIdBqtsShNDnWjk7VDQY7RJuaw+qD7qrgCACI6rAX0LgoTKBQ==
X-Received: by 2002:a05:6871:5308:b0:261:1f7d:cf71 with SMTP id 586e51a60fabf-2949effac5dmr21562500fac.34.1730979597368;
        Thu, 07 Nov 2024 03:39:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDq5fRIg01uNlVXiEtEZlPbiE6ggdZh6AZ5Ace6mGwQwi7O64CogCmEIHArE+Zd2OoFSmPhA==
X-Received: by 2002:a05:6871:5308:b0:261:1f7d:cf71 with SMTP id 586e51a60fabf-2949effac5dmr21562466fac.34.1730979596959;
        Thu, 07 Nov 2024 03:39:56 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546c3d9cdsm296879fac.1.2024.11.07.03.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 03:39:56 -0800 (PST)
Message-ID: <41b0155f-bec4-4563-a92c-b30b0f5f9997@redhat.com>
Date: Thu, 7 Nov 2024 12:39:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] virtio_net: Update rss when set queue
To: Joe Damato <jdamato@fastly.com>, Philo Lu <lulie@linux.alibaba.com>,
 netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 andrew@daynix.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
 <20241104085706.13872-5-lulie@linux.alibaba.com>
 <ZyqAovoIOYkNvtys@LQ3V64L9R2>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZyqAovoIOYkNvtys@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/24 21:31, Joe Damato wrote:
> On Mon, Nov 04, 2024 at 04:57:06PM +0800, Philo Lu wrote:
>> RSS configuration should be updated with queue number. In particular, it
>> should be updated when (1) rss enabled and (2) default rss configuration
>> is used without user modification.
>>
>> During rss command processing, device updates queue_pairs using
>> rss.max_tx_vq. That is, the device updates queue_pairs together with
>> rss, so we can skip the sperate queue_pairs update
>> (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.
>>
>> Also remove the `vi->has_rss ?` check when setting vi->rss.max_tx_vq,
>> because this is not used in the other hash_report case.
>>
>> Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> ---
>>  drivers/net/virtio_net.c | 65 +++++++++++++++++++++++++++++++---------
>>  1 file changed, 51 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 59d9fdf562e0..189afad3ffaa 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3394,15 +3394,59 @@ static void virtnet_ack_link_announce(struct virtnet_info *vi)
>>  		dev_warn(&vi->dev->dev, "Failed to ack link announce.\n");
>>  }
>>  
>> +static bool virtnet_commit_rss_command(struct virtnet_info *vi);
>> +
>> +static void virtnet_rss_update_by_qpairs(struct virtnet_info *vi, u16 queue_pairs)
>> +{
>> +	u32 indir_val = 0;
>> +	int i = 0;
>> +
>> +	for (; i < vi->rss_indir_table_size; ++i) {
>> +		indir_val = ethtool_rxfh_indir_default(i, queue_pairs);
>> +		vi->rss.indirection_table[i] = indir_val;
>> +	}
>> +	vi->rss.max_tx_vq = queue_pairs;
>> +}
>> +
>>  static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>  {
>>  	struct virtio_net_ctrl_mq *mq __free(kfree) = NULL;
>> -	struct scatterlist sg;
>> +	struct virtio_net_ctrl_rss old_rss;
>>  	struct net_device *dev = vi->dev;
>> +	struct scatterlist sg;
>>  
>>  	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>>  		return 0;
>>  
>> +	/* Firstly check if we need update rss. Do updating if both (1) rss enabled and
>> +	 * (2) no user configuration.
>> +	 *
>> +	 * During rss command processing, device updates queue_pairs using rss.max_tx_vq. That is,
>> +	 * the device updates queue_pairs together with rss, so we can skip the sperate queue_pairs
>> +	 * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.
>> +	 */
>> +	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
> 
> Does there need to be an error case when:
> 
> vi->has_rss && netif_is_rxfh_configured(dev)
> 
> to return EINVAL? I noted that other drivers don't let users adjust
> the queue count and return error in this case.

AFAICS the above is orthogonal to this patch - i.e. lack of check is
pre-existing and not introduced here. I'm not 110% sure the lack of
check is illegit, but I think it should eventually handled with a
separate patch/series.

Thanks,

Paolo


