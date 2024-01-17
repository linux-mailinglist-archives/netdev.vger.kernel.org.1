Return-Path: <netdev+bounces-63895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 537DD82FF5C
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 04:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41471F23764
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 03:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725D71C13;
	Wed, 17 Jan 2024 03:41:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AB74439
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 03:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705462877; cv=none; b=Fjd/ahtSLI/MQEDtbi164byADoJQ8Fcw2MlXwtXYGqmfrK4Rl8YYVpqwUZd+Eku+k2O5NZG397BjgTFbO3Mf5MD5+fIQAy7X3XMptRObXwDxtrpGrlMU7ERnmGoUocuP8xKumVHX/Al++slCIZIrEhQYRt0B3L81C8ihO382p74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705462877; c=relaxed/simple;
	bh=jnrIu1IKLPUHmtPpgR5WK4Kf5gOVXyIkmqS0l51MIxE=;
	h=X-Alimail-AntiSpam:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=UTLj4rfruZD297fyWF+f2VCCAMHTXeW83SZ8en6f7JAqS+Z1yUgL26B2bJ4gMf4Uygx5R6G5rS0kbsiI9X+AbI/lYDFr1dNW5qCxNQQoOUxhaBH+zTYpfxMPOH1b9Ji+wEPhF8xrshRBhZFWFZAGmo8MelLPZnxhoB8YEthHntE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W-o1spg_1705462865;
Received: from 30.221.149.120(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W-o1spg_1705462865)
          by smtp.aliyun-inc.com;
          Wed, 17 Jan 2024 11:41:06 +0800
Message-ID: <120c62f5-f1ae-4269-9933-a3ce62220af4@linux.alibaba.com>
Date: Wed, 17 Jan 2024 11:41:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] virtio-net: reduce the CPU consumption of
 dim worker
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>
 <1705410693-118895-4-git-send-email-hengqi@linux.alibaba.com>
 <20240116195646.GF588419@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240116195646.GF588419@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/1/17 上午3:56, Simon Horman 写道:
> On Tue, Jan 16, 2024 at 09:11:33PM +0800, Heng Qi wrote:
>> Accumulate multiple request commands to kick the device once,
>> and obtain the processing results of the corresponding commands
>> asynchronously. The batch command method is used to optimize the
>> CPU overhead of the DIM worker caused by the guest being busy
>> waiting for the command response result.
>>
>> On an 8-queue device, without this patch, the guest cpu overhead
>> due to waiting for cvq could be 10+% and above. With this patch,
>> the corresponding overhead is basically invisible.
>>
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ...
>
>> @@ -3520,22 +3568,99 @@ static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
>>   	return 0;
>>   }
>>   
>> +static bool virtnet_add_dim_command(struct virtnet_info *vi,
>> +				    struct virtnet_batch_coal *ctrl)
>> +{
>> +	struct scatterlist *sgs[4], hdr, stat, out;
>> +	unsigned out_num = 0;
>> +	int ret;
>> +
>> +	/* Caller should know better */
>> +	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
>> +
>> +	ctrl->hdr.class = VIRTIO_NET_CTRL_NOTF_COAL;
>> +	ctrl->hdr.cmd = VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET;
>> +
>> +	/* Add header */
>> +	sg_init_one(&hdr, &ctrl->hdr, sizeof(ctrl->hdr));
>> +	sgs[out_num++] = &hdr;
>> +
>> +	/* Add body */
>> +	sg_init_one(&out, &ctrl->num_entries, sizeof(ctrl->num_entries) +
>> +		    ctrl->num_entries * sizeof(struct virtnet_coal_entry));
> Hi Heng Qi,
>
> I am a bit confused.
> With this series applied on top of net-next
> struct virtnet_coal_entry doesn't seem to exist.

Hi Simon,

It should be struct virtio_net_ctrl_coal_vq.

Thanks.

>
>
>> +	sgs[out_num++] = &out;
>> +
>> +	/* Add return status. */
>> +	ctrl->status = VIRTIO_NET_OK;
>> +	sg_init_one(&stat, &ctrl->status, sizeof(ctrl->status));
>> +	sgs[out_num] = &stat;
>> +
>> +	BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
>> +	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, ctrl, GFP_ATOMIC);
>> +	if (ret < 0) {
>> +		dev_warn(&vi->vdev->dev, "Failed to add sgs for command vq: %d\n.", ret);
>> +		return false;
>> +	}
>> +
>> +	virtqueue_kick(vi->cvq);
>> +
>> +	ctrl->usable = false;
>> +	vi->cvq_cmd_nums++;
>> +
>> +	return true;
>> +}
> ...


