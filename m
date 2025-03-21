Return-Path: <netdev+bounces-176674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78A8A6B475
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 07:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FAE3B8F98
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 06:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405771EB19D;
	Fri, 21 Mar 2025 06:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="DahfNvnQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781481EA7C8
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 06:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742538899; cv=none; b=aEtLpAq/axnouEEidSWwlJDpzPTSaCJTdAXOJOSJspuoLTwK+4nXl9PCE5WyIujzsvyq88Mq/bAgWKgq8X1rI5UP+rF3AIqiamlQAq3wDc5iPmzKQXS3UZVnMvWB3cgh9QALZ8tfj/zTDNE6zczV7jRiQk9zNaVLo6NS17IwVJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742538899; c=relaxed/simple;
	bh=y882Rtbh0gclCFUkunekfew1pkcBtCjli262lS87qMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqzt7f0in60v+q1lQ/s2cj8BFmcqK7TnB1sroQp+TsF26kT4BR6NYzG5fSQEF7dRdaCiGW1/ozO9LUfl8BT9BLfw1zZ+znZIcctq0OfLLfbgOev9Q5tbS25Tbv9o9R7MgAttjMJRmULMqzjq/9gLgtuANjAqgD02VUbXmkpYqmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=DahfNvnQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3018f827c9bso2422708a91.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 23:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742538896; x=1743143696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uafTKOsaCIikV+c8UvWUp6BwtWloI140yiuOWUXgKTA=;
        b=DahfNvnQ0JAT40LBM7j/HR29rtGlucDTOrMwX8t+ohPzUV8/REsJat2Kr/MVszwm6r
         hPu92AzfPEVvpEgriwLeCRSkkywCBv7qGHsPIg2OAIx8zia9vTYmYJ4NDPz5OnhUjQgT
         jCyUts0e0L5xj3FlL1VuPORfVwET1m5sS1O7e7EW5KLojAAYAPwmRNbYa/evy/rxDw7k
         wkvM9ipgTRqcP3+sRdrTbYlLriJ8FnV0iRIK1JBV56fV/UqyhckvQRTPqEj2VPI8EfYH
         Y/uErLMPAFNfLH6DC+TUT19Hxi/ZGPfwFOKeZ5cwL3hrNZjfHYrJX+kxs8fpYXZ9Xo3v
         Cpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742538896; x=1743143696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uafTKOsaCIikV+c8UvWUp6BwtWloI140yiuOWUXgKTA=;
        b=aSGX/ogFs5ea1sJ3qwv1oYeANpsc5THYxJcM+9HHP/aFy/FueI8y+kGmKtzq3SZ+rN
         yGA1ybjhGfp9BOB6D4cZRhdQFqgzJL5FOVCPFn153To6DSaJwN/EB3X2ORv6JK4Dewtx
         06jOHBmrLP2XChoRRbD8IzjHp97jdSWsZMM85Zrei+2tPIOl9xXy5qB5ggZ8JAnnKHeU
         R3yK6JycJrZZXWpyyCq/bc7Enp+mqaXGIlVVvdw3qUPEdKaCAnP6h7MSoYo4/vmLQiuT
         2nYfWTy2jgO3o/tMa7J0jHxfMzDYV71bYYGJzJlPYHUI6CKscCyEN8w0d52kdwPDmL08
         OOiA==
X-Forwarded-Encrypted: i=1; AJvYcCWZNnY0pawlYEOj+Fec8ELGvqJp48VLUMazZU5fu/HMC34twSRVYCuIaVsP8r6wiXT8GBb2MoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLO6IB5mFeLeBl2oQsrN71Cyd5lxMePdTNK1V0ECHRC7d42RDY
	ZHnOgGUJjWI6AMt3IzizblAxWnkG2vropaDf5qLa4+gQXQ3G1qE/UEoV31/FP4s=
X-Gm-Gg: ASbGnctoeGGjrTqQRmZRFQJHL3FeVsnCWrcr7rqK43lwHHqBhUb5DV3uUL5tEA/dLl+
	KCG+bnwQy0GE9iY4cCMsMdSoXl424fMv0xX8cS0w63RCuXf5v5vQpUoBa6wFVrJup6HzXAhdVxZ
	+9o+leWE7Z38A5RQrku0il6ChDt2XOtY4dxo7YGlyg513+j11vVFL+MHrsBXxoPCV2tuKBk1Diw
	02qMtlMe5Mr1MqHd8UQ8WN/ECAnfC6Az470G/cf8qBnmP+hbFOgplstyid36FIZxxCaIoug67kt
	933ynqNbtRoofEbiiaa+SUn6Z0GPktZrH6UVCL8nolPrMnJoz1eIbp0NHA==
X-Google-Smtp-Source: AGHT+IGQVN3o4Y3JQIGLvpNGSXsqiPjZVz0H6qn9ptgw9m9KV/akv0pTHLxtLksgFN+CcPsxV/ptcQ==
X-Received: by 2002:a17:90b:2647:b0:2fe:8902:9ecd with SMTP id 98e67ed59e1d1-3030fe7223bmr3129925a91.1.1742538895628;
        Thu, 20 Mar 2025 23:34:55 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f806fb9sm1052012a91.45.2025.03.20.23.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 23:34:55 -0700 (PDT)
Message-ID: <764ca4a4-3587-4dd4-93a4-23542b32dbf9@daynix.com>
Date: Fri, 21 Mar 2025 15:34:50 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] virtio_net: Use new RSS config structs
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>,
 Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
 <20250318-virtio-v1-3-344caf336ddd@daynix.com>
 <CACGkMEv1TTXHd_JGb_vyN8pfTAMLbsTE6oU9_phrdpaZBrE97Q@mail.gmail.com>
 <b6eec81d-618f-4a59-8680-8e22f1a798bf@daynix.com>
 <CACGkMEsEaUzAeEaBzX6zQC-gVMjS_0tSegBKUrhX4R6c3MW2hQ@mail.gmail.com>
 <83a5ab7b-7b29-413e-a854-31c7893f3c4a@daynix.com>
 <CACGkMEvbs9NnHhjaiiD4hc-bOAm9+-ry3xfdZET3HqJ=_1k6Lg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEvbs9NnHhjaiiD4hc-bOAm9+-ry3xfdZET3HqJ=_1k6Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/21 9:35, Jason Wang wrote:
> On Thu, Mar 20, 2025 at 1:36 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/03/20 10:50, Jason Wang wrote:
>>> On Wed, Mar 19, 2025 at 12:48 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/03/19 10:43, Jason Wang wrote:
>>>>> On Tue, Mar 18, 2025 at 5:57 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> The new RSS configuration structures allow easily constructing data for
>>>>>> VIRTIO_NET_CTRL_MQ_RSS_CONFIG as they strictly follow the order of data
>>>>>> for the command.
>>>>>>
>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>> ---
>>>>>>     drivers/net/virtio_net.c | 117 +++++++++++++++++------------------------------
>>>>>>     1 file changed, 43 insertions(+), 74 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>>> index d1ed544ba03a..4153a0a5f278 100644
>>>>>> --- a/drivers/net/virtio_net.c
>>>>>> +++ b/drivers/net/virtio_net.c
>>>>>> @@ -360,24 +360,7 @@ struct receive_queue {
>>>>>>            struct xdp_buff **xsk_buffs;
>>>>>>     };
>>>>>>
>>>>>> -/* This structure can contain rss message with maximum settings for indirection table and keysize
>>>>>> - * Note, that default structure that describes RSS configuration virtio_net_rss_config
>>>>>> - * contains same info but can't handle table values.
>>>>>> - * In any case, structure would be passed to virtio hw through sg_buf split by parts
>>>>>> - * because table sizes may be differ according to the device configuration.
>>>>>> - */
>>>>>>     #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
>>>>>> -struct virtio_net_ctrl_rss {
>>>>>> -       __le32 hash_types;
>>>>>> -       __le16 indirection_table_mask;
>>>>>> -       __le16 unclassified_queue;
>>>>>> -       __le16 hash_cfg_reserved; /* for HASH_CONFIG (see virtio_net_hash_config for details) */
>>>>>> -       __le16 max_tx_vq;
>>>>>> -       u8 hash_key_length;
>>>>>> -       u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>>>>>> -
>>>>>> -       __le16 *indirection_table;
>>>>>> -};
>>>>>>
>>>>>>     /* Control VQ buffers: protected by the rtnl lock */
>>>>>>     struct control_buf {
>>>>>> @@ -421,7 +404,9 @@ struct virtnet_info {
>>>>>>            u16 rss_indir_table_size;
>>>>>>            u32 rss_hash_types_supported;
>>>>>>            u32 rss_hash_types_saved;
>>>>>> -       struct virtio_net_ctrl_rss rss;
>>>>>> +       struct virtio_net_rss_config_hdr *rss_hdr;
>>>>>> +       struct virtio_net_rss_config_trailer rss_trailer;
>>>>>> +       u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>>>>>>
>>>>>>            /* Has control virtqueue */
>>>>>>            bool has_cvq;
>>>>>> @@ -523,23 +508,16 @@ enum virtnet_xmit_type {
>>>>>>            VIRTNET_XMIT_TYPE_XSK,
>>>>>>     };
>>>>>>
>>>>>> -static int rss_indirection_table_alloc(struct virtio_net_ctrl_rss *rss, u16 indir_table_size)
>>>>>> +static size_t virtnet_rss_hdr_size(const struct virtnet_info *vi)
>>>>>>     {
>>>>>> -       if (!indir_table_size) {
>>>>>> -               rss->indirection_table = NULL;
>>>>>> -               return 0;
>>>>>> -       }
>>>>>> +       u16 indir_table_size = vi->has_rss ? vi->rss_indir_table_size : 1;
>>>>>>
>>>>>> -       rss->indirection_table = kmalloc_array(indir_table_size, sizeof(u16), GFP_KERNEL);
>>>>>> -       if (!rss->indirection_table)
>>>>>> -               return -ENOMEM;
>>>>>> -
>>>>>> -       return 0;
>>>>>> +       return struct_size(vi->rss_hdr, indirection_table, indir_table_size);
>>>>>>     }
>>>>>>
>>>>>> -static void rss_indirection_table_free(struct virtio_net_ctrl_rss *rss)
>>>>>> +static size_t virtnet_rss_trailer_size(const struct virtnet_info *vi)
>>>>>>     {
>>>>>> -       kfree(rss->indirection_table);
>>>>>> +       return struct_size(&vi->rss_trailer, hash_key_data, vi->rss_key_size);
>>>>>>     }
>>>>>>
>>>>>>     /* We use the last two bits of the pointer to distinguish the xmit type. */
>>>>>> @@ -3576,15 +3554,16 @@ static void virtnet_rss_update_by_qpairs(struct virtnet_info *vi, u16 queue_pair
>>>>>>
>>>>>>            for (; i < vi->rss_indir_table_size; ++i) {
>>>>>>                    indir_val = ethtool_rxfh_indir_default(i, queue_pairs);
>>>>>> -               vi->rss.indirection_table[i] = cpu_to_le16(indir_val);
>>>>>> +               vi->rss_hdr->indirection_table[i] = cpu_to_le16(indir_val);
>>>>>>            }
>>>>>> -       vi->rss.max_tx_vq = cpu_to_le16(queue_pairs);
>>>>>> +       vi->rss_trailer.max_tx_vq = cpu_to_le16(queue_pairs);
>>>>>>     }
>>>>>>
>>>>>>     static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>>>>>     {
>>>>>>            struct virtio_net_ctrl_mq *mq __free(kfree) = NULL;
>>>>>> -       struct virtio_net_ctrl_rss old_rss;
>>>>>> +       struct virtio_net_rss_config_hdr *old_rss_hdr;
>>>>>> +       struct virtio_net_rss_config_trailer old_rss_trailer;
>>>>>>            struct net_device *dev = vi->dev;
>>>>>>            struct scatterlist sg;
>>>>>>
>>>>>> @@ -3599,24 +3578,28 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>>>>>             * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.
>>>>>>             */
>>>>>>            if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
>>>>>> -               memcpy(&old_rss, &vi->rss, sizeof(old_rss));
>>>>>> -               if (rss_indirection_table_alloc(&vi->rss, vi->rss_indir_table_size)) {
>>>>>> -                       vi->rss.indirection_table = old_rss.indirection_table;
>>>>>> +               old_rss_hdr = vi->rss_hdr;
>>>>>> +               old_rss_trailer = vi->rss_trailer;
>>>>>> +               vi->rss_hdr = kmalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
>>>>>> +               if (!vi->rss_hdr) {
>>>>>> +                       vi->rss_hdr = old_rss_hdr;
>>>>>>                            return -ENOMEM;
>>>>>>                    }
>>>>>>
>>>>>> +               *vi->rss_hdr = *old_rss_hdr;
>>>>>>                    virtnet_rss_update_by_qpairs(vi, queue_pairs);
>>>>>>
>>>>>>                    if (!virtnet_commit_rss_command(vi)) {
>>>>>>                            /* restore ctrl_rss if commit_rss_command failed */
>>>>>> -                       rss_indirection_table_free(&vi->rss);
>>>>>> -                       memcpy(&vi->rss, &old_rss, sizeof(old_rss));
>>>>>> +                       kfree(vi->rss_hdr);
>>>>>> +                       vi->rss_hdr = old_rss_hdr;
>>>>>> +                       vi->rss_trailer = old_rss_trailer;
>>>>>>
>>>>>>                            dev_warn(&dev->dev, "Fail to set num of queue pairs to %d, because committing RSS failed\n",
>>>>>>                                     queue_pairs);
>>>>>>                            return -EINVAL;
>>>>>>                    }
>>>>>> -               rss_indirection_table_free(&old_rss);
>>>>>> +               kfree(old_rss_hdr);
>>>>>>                    goto succ;
>>>>>>            }
>>>>>>
>>>>>> @@ -4059,28 +4042,12 @@ static int virtnet_set_ringparam(struct net_device *dev,
>>>>>>     static bool virtnet_commit_rss_command(struct virtnet_info *vi)
>>>>>>     {
>>>>>>            struct net_device *dev = vi->dev;
>>>>>> -       struct scatterlist sgs[4];
>>>>>> -       unsigned int sg_buf_size;
>>>>>> +       struct scatterlist sgs[2];
>>>>>>
>>>>>>            /* prepare sgs */
>>>>>> -       sg_init_table(sgs, 4);
>>>>>> -
>>>>>> -       sg_buf_size = offsetof(struct virtio_net_ctrl_rss, hash_cfg_reserved);
>>>>>> -       sg_set_buf(&sgs[0], &vi->rss, sg_buf_size);
>>>>>> -
>>>>>> -       if (vi->has_rss) {
>>>>>> -               sg_buf_size = sizeof(uint16_t) * vi->rss_indir_table_size;
>>>>>> -               sg_set_buf(&sgs[1], vi->rss.indirection_table, sg_buf_size);
>>>>>> -       } else {
>>>>>> -               sg_set_buf(&sgs[1], &vi->rss.hash_cfg_reserved, sizeof(uint16_t));
>>>>>> -       }
>>>>>> -
>>>>>> -       sg_buf_size = offsetof(struct virtio_net_ctrl_rss, key)
>>>>>> -                       - offsetof(struct virtio_net_ctrl_rss, max_tx_vq);
>>>>>> -       sg_set_buf(&sgs[2], &vi->rss.max_tx_vq, sg_buf_size);
>>>>>> -
>>>>>> -       sg_buf_size = vi->rss_key_size;
>>>>>> -       sg_set_buf(&sgs[3], vi->rss.key, sg_buf_size);
>>>>>> +       sg_init_table(sgs, 2);
>>>>>> +       sg_set_buf(&sgs[0], vi->rss_hdr, virtnet_rss_hdr_size(vi));
>>>>>> +       sg_set_buf(&sgs[1], &vi->rss_trailer, virtnet_rss_trailer_size(vi));
>>>>>
>>>>> So I still see this:
>>>>>
>>>>>            if (vi->has_rss || vi->has_rss_hash_report) {
>>>>>                    if (!virtnet_commit_rss_command(vi)) {
>>>>>
>>>>> Should we introduce a hash config helper instead?
>>>>
>>>> I think it's fine to use virtnet_commit_rss_command() for hash
>>>> reporting. struct virtio_net_hash_config and struct
>>>> virtio_net_rss_config are defined to have a common layout to allow
>>>> sharing this kind of logic.
>>>
>>> Well, this trick won't work if the reserved field in hash_config is
>>> used in the future.
>>
>> Right, but we can add a hash config helper when that happens. It will
>> only result in a duplication of logic for now.
>>
>> Regards,
>> Akihiko Odaki
> 
> That's tricky as the cvq commands were designed to be used separately.
> Let's use a separate helper and virtio_net_hash_config uAPIs now.

It's not tricky but is explicitly stated in the spec. 5.1.6.5.6.4 "Hash 
calculation" says:
 > Field reserved MUST contain zeroes. It is defined to make the
 > structure to match the layout of virtio_net_rss_config structure,
 > defined in 5.1.6.5.7.

By the way, I found it says field reserved MUST contain zeros but we do 
nothing to ensure that. I'll write a fix for that.

Regards,
Akihiko Odaki

> 
> Thanks
> 
>>
>>>
>>> Thanks
>>>
>>>>
>>>> Regards,
>>>> Akihiko Odaki
>>>>
>>>>>
>>>>> Thanks
>>>>>
>>>>
>>>
>>
> 


