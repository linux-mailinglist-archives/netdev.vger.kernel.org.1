Return-Path: <netdev+bounces-263240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPRLKy/1pmmgawAAu9opvQ
	(envelope-from <netdev+bounces-263240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:50:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD451F1C95
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1795A315C37E
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D0243E9C5;
	Tue,  3 Mar 2026 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMP7UTWN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDD52DF144
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549103; cv=none; b=d9IPzdZGos2jQiom+6uyahEqX35yYqDIMkreSvlcNDgn3bip4r8VWwLEFROu6a0SgUa3xcl4rLmfv15v+0WbvfTLyk6OdWMMhFizjpJDmmqhpi0DGl8J6YCP9lWCPNbD6rU7yN3onD0CuZUdSGqEmcM2cDja2jVtPWfavcnmsVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549103; c=relaxed/simple;
	bh=et+NHrUN6S65x0cES6jWebxf6MM1u7PmMvpuO/NJb1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBX9K70aaDqkGv0+vOwS7A1bce1qet4xaG7TZEbZWhTwpVrdV64iQz3COpgufx6aADjwamb/BhICX8xKkfVQyawQfa2fkoXhFQ/4KDviYb144TNzdWbjoxz5Y+C91bIx2lQggxqXOHyCg9pBu+g1/yWN4F/cmzCCxe/B68LH+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMP7UTWN; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso2540087a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 06:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772549101; x=1773153901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJlXz4Gm3Iulh7PKjxbOyaJJ98URo0iEgHacDLY1vjg=;
        b=RMP7UTWNEb4/7QzTSXUpHgDVqvEKcIvdQLHIgahm60Qwy7lfooBe8uVZsccbdD0/a/
         fF1uqxCHb02wl224cEoId1lF4fgb4jTBjL6gcxUJKVVEa7XFPt+ITR9EtLJKPeNpJLX/
         ZfmzOXM4gEeFaNG2T6gdJT0hNJrEQjdomXvJjSJobGks+PmV+Bj/thdQ9rQWpbLSG9NZ
         HLZpInwsU2JIRHoruV+mPotciyWLUS6F8otPHephH8WFfLBR1xO2UGHK79ifuX5fsNyT
         LJHfLibWJrtVwyvK3zyBzVMa62mNmnfWaOKcaaGcdRu1zgUN2EeUk/q6YyljIRajIMRr
         nu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772549101; x=1773153901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJlXz4Gm3Iulh7PKjxbOyaJJ98URo0iEgHacDLY1vjg=;
        b=K3cp9Ip3RYHYNM7bAv1P6PsYmxfFh06o6dOpT/yMl4ktzNRXKBgwFLAZgMpZSiHmuN
         QB2sDui+AMmQBuA141f0r8EQX+dijvEk6huDune6eDr9N2VSxOIxVsXqDoCqTLvLleJ1
         iT6ZBqkIIEVqa4beV2cSZBBjL/gcySC5tttR61fj1Tr3BX15B9NS2LITPMMmOv1UhvRM
         oigwgIJEnvBQdxoKmuOnV0aWNYkA1qXzdjzZVy+mLi5nX5S7ziS3XQ+X/Hp6m7JSP/F9
         lX8ExSNbbGTpC4l8wh2oWbwzjpRKHwUYJOjMfTsQJgUq6xcQRYhzCiRBMKpawEPh1f/B
         thIQ==
X-Gm-Message-State: AOJu0Yzx4pMQ8MP5W1oaZ1xS2ziSIOxlibzHkBTv0Js53MWemsoN9Xbl
	4CoblIK857wUo7+HqA1Ww+j4hCmMhYEgH8ZuNBFjKJjEGImR+C6w4Y8q
X-Gm-Gg: ATEYQzwIQmrry56gyPq0GZiRON30kXriU2IK89oOHxDa0ZwahBFxngqskp/gmtfM9LG
	o22j3hPm92PCEJooVXwhGsvB9SuBEqFdqyC3d0BnYymtHQpl//ujo5nm3J+rFYwt4fYd7gEGfOW
	Pv701h+5GJjciWLp279rK2hxgFDmed5Q5kbDyMhf2Rryb6OLtTWHBrhIONuqq4PLSDfTimQCM9d
	JgiYQT1HzfbqRR3PI7Uwku39LKVQLbtpw2PQkt09aT82KdyA0E8PK7IEkNn3hyOqY5ZD6HOCkSu
	LDovgtOmCmFMK8zb4NdZoVx9I4+h2EH4m3EEm8s1sBi7wPE3Ry/lozqjQqdpUVtNhYSwxWNG5Fy
	ria0NvpmMtjc7dO6qEHr5amn2fRk+V2tWQ1Lf0+0vvJqXNkqYLbRw325lsKBa7zaXpfx0CZI+oo
	LwzRAYyli6zVMJHzWz1cqBQKLJ7/D5bfX2idkWp83bqil7Ca1WxlCcT9NCf2L0+5P5Q35NDI/Qe
	u9rdw==
X-Received: by 2002:a17:90b:51cc:b0:359:7906:d998 with SMTP id 98e67ed59e1d1-3597906df0bmr11388993a91.18.1772549100406;
        Tue, 03 Mar 2026 06:45:00 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f0f:b1d0:3f07:f8d8:f49b:c576? ([2001:ee0:4f0f:b1d0:3f07:f8d8:f49b:c576])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a03fbsm226689635ad.43.2026.03.03.06.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 06:45:00 -0800 (PST)
Message-ID: <935c773d-e6d5-4445-b5e3-ed8daf60001c@gmail.com>
Date: Tue, 3 Mar 2026 21:44:53 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] virtio-net: xsk: Support wakeup on RX side
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260302164158.4394-1-minhquangbui99@gmail.com>
 <20260302135032-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20260302135032-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4CD451F1C95
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263240-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minhquangbui99@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/3/26 01:53, Michael S. Tsirkin wrote:
> On Mon, Mar 02, 2026 at 11:41:58PM +0700, Bui Quang Minh wrote:
>> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
>> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
>> wasting CPU cycles on polling. Users will be notified and they need to
>> make a wakeup call after refilling the ring.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>> Changes in v2:
>> - Fix the flag check in virtnet_xsk_wakeup
>> - Link to v1: https://lore.kernel.org/netdev/20260227150949.13089-1-minhquangbui99@gmail.com/
>> ---
>>   drivers/net/virtio_net.c | 35 +++++++++++++++++++++++++++--------
>>   1 file changed, 27 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index db88dcaefb20..3614002fc87c 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -1454,8 +1454,19 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>>   	xsk_buffs = rq->xsk_buffs;
>>   
>>   	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
>> -	if (!num)
>> +	if (!num) {
>> +		if (xsk_uses_need_wakeup(pool)) {
>> +			xsk_set_rx_need_wakeup(pool);
>> +			/* Return 0 instead of -ENOMEM so that NAPI is
>> +			 * descheduled.
>> +			 */
>> +			return 0;
> With this change, try_fill_recv() can return true even though zero RX
> buffers were posted in need_wakeup mode, which contradicts its
> documentation ("Returns false if we couldn't fill entirely (OOM)").
>
> Methinks we need to at least update the comment near try_fill_recv.

I'll update the comment of try_fill_recv function.

Thanks,
Quang Minh.

>
>
>
>> +		}
>> +
>>   		return -ENOMEM;
>> +	} else {
>> +		xsk_clear_rx_need_wakeup(pool);
>> +	}
>>   
>>   	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
>>   
>> @@ -1588,20 +1599,19 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>>   	return sent;
>>   }
>>   
>> -static void xsk_wakeup(struct send_queue *sq)
>> +static void xsk_wakeup(struct napi_struct *napi, struct virtqueue *vq)
>>   {
>> -	if (napi_if_scheduled_mark_missed(&sq->napi))
>> +	if (napi_if_scheduled_mark_missed(napi))
>>   		return;
>>   
>>   	local_bh_disable();
>> -	virtqueue_napi_schedule(&sq->napi, sq->vq);
>> +	virtqueue_napi_schedule(napi, vq);
>>   	local_bh_enable();
>>   }
>>   
>>   static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>>   {
>>   	struct virtnet_info *vi = netdev_priv(dev);
>> -	struct send_queue *sq;
>>   
>>   	if (!netif_running(dev))
>>   		return -ENETDOWN;
>> @@ -1609,9 +1619,18 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>>   	if (qid >= vi->curr_queue_pairs)
>>   		return -EINVAL;
>>   
>> -	sq = &vi->sq[qid];
>> +	if (flag & XDP_WAKEUP_TX) {
>> +		struct send_queue *sq = &vi->sq[qid];
>> +
>> +		xsk_wakeup(&sq->napi, sq->vq);
>> +	}
>> +
>> +	if (flag & XDP_WAKEUP_RX) {
>> +		struct receive_queue *rq = &vi->rq[qid];
>> +
>> +		xsk_wakeup(&rq->napi, rq->vq);
>> +	}
>>   
>> -	xsk_wakeup(sq);
>>   	return 0;
>>   }
>>   
>> @@ -1623,7 +1642,7 @@ static void virtnet_xsk_completed(struct send_queue *sq, int num)
>>   	 * wakeup the tx napi to consume the xsk tx queue, because the tx
>>   	 * interrupt may not be triggered.
>>   	 */
>> -	xsk_wakeup(sq);
>> +	xsk_wakeup(&sq->napi, sq->vq);
>>   }
>>   
>>   static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
>> -- 
>> 2.43.0


