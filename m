Return-Path: <netdev+bounces-142174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC399BDB28
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1933AB2166D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0F2188920;
	Wed,  6 Nov 2024 01:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EUbxvRTn"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE67710E5;
	Wed,  6 Nov 2024 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730856488; cv=none; b=Be2o2kWoFP5VFxPmBF/EnO26U8OOZylBAXg8XS+z/8Ymdm9b7iOjryYLZypKObENgpId6hLBFW2hT4M65T6I/PS3QIu6QgT2yqfWtbAQnJY+nk9qTafRPon9OmFb9HXJ9B3EpYeR/BHRsmGvMbjCPL4efRHhtNxo5MP8rCCBo+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730856488; c=relaxed/simple;
	bh=6rRLuoCkyirYKH6QU9Cfg2hcU0erJdtH7MonQT/EvP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RC+sa0Hz6lrrq8QD7GkfjT8m3rXdtpxqLAl+bUPZwY6A29vJmcamMqdb1pRAzfAjL1ukWjuH85N5paJg1O4/lUmqNEvD03Y0px/5KeyMT3kVlBhn6RJeM5lacxDHE3Fj4SHrYkv9F4MqKSDwo2xl5aziZmOOGFIzXL2OM0VgfAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EUbxvRTn; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730856483; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EOPQLCJ0U/I35sZO8/7VXVQOHxamPyOdJc+BysgSvqA=;
	b=EUbxvRTnN8tWmfzfNpZTZ0Ps94MrDnok2yPyDoZwi305XLgaWQJEGfsk5frAoHRPZV4mYqHoB8KKbLZwrqOjMVczli8kDnrOajzcYlB8b0TMat14dxMKjvzT/2GqjT2fsKMav3nY0MaxrdrQ1qJOo0/BAtAE0x7qh3FqcSdUtkE=
Received: from 30.221.128.108(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WIoEygd_1730856481 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 09:28:02 +0800
Message-ID: <a10d6eda-d03f-42ea-af89-be0d798b5608@linux.alibaba.com>
Date: Wed, 6 Nov 2024 09:28:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] virtio_net: Update rss when set queue
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@daynix.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
 <20241104085706.13872-5-lulie@linux.alibaba.com>
 <ZyqAovoIOYkNvtys@LQ3V64L9R2>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <ZyqAovoIOYkNvtys@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/6 04:31, Joe Damato wrote:
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
>>   drivers/net/virtio_net.c | 65 +++++++++++++++++++++++++++++++---------
>>   1 file changed, 51 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 59d9fdf562e0..189afad3ffaa 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3394,15 +3394,59 @@ static void virtnet_ack_link_announce(struct virtnet_info *vi)
>>   		dev_warn(&vi->dev->dev, "Failed to ack link announce.\n");
>>   }
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
>>   static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>   {
>>   	struct virtio_net_ctrl_mq *mq __free(kfree) = NULL;
>> -	struct scatterlist sg;
>> +	struct virtio_net_ctrl_rss old_rss;
>>   	struct net_device *dev = vi->dev;
>> +	struct scatterlist sg;
>>   
>>   	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>>   		return 0;
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
> 

In fact, there are 2 possible cases if users have adjusted rss, 
depending on the total queue pairs used in the indirection table (x), 
and the requested new queue count (y).

Case A: If y < x, it's illegal and will be rejected by
         ethtool_check_max_channel().
Case B: If x <= y, we only adjust the queue number without touching the
         rss configuration set by users.

So I don't think it necessary to add the check (if the above processing 
is agreed).

Thanks for your review, Joe.

-- 
Philo


