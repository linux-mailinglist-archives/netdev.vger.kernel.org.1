Return-Path: <netdev+bounces-194319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9430AC882A
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 08:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEDFD7A9344
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 06:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE271EE010;
	Fri, 30 May 2025 06:19:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67CC17A305;
	Fri, 30 May 2025 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748585989; cv=none; b=FWuGykD5oPkDgidadINPOdS7gcATbqYGy5xaRRIlwslA93p+2jFS6gMCHT5JZK3zBF4zr9hnzi6DRZMi3mmEHD6im8dLnyjPvM1+fwBL++yU9vl7Mq8mtq4oYlhAmJff4Ec9bikAihSsOvxtKIz6KeGvUeCFLxnDdFAyU6TZSLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748585989; c=relaxed/simple;
	bh=ptYiFD/YRKki+0ESE/ZaJnoJsK9/EwJhWPx+kScJSVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uxY9JspAA1uBMLUdm+LQpU3nHuN9PIYp6ltXtDAOyFCYl3L98Bm5PZ1MCfM24Vu8V+Sq9iX4TQpwvqQMcv94HOA6glxP/1qiXEORkuDDJeo1yWpffkB7fmLCAUSWBRDc0y1tw0eXoL7R3p+JprTTwZXxIWlJY8ENkZjPA7CLPRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4b7tK85gxMz2Cf8H;
	Fri, 30 May 2025 14:15:56 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 99E5A1A016C;
	Fri, 30 May 2025 14:19:42 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 May 2025 14:19:42 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 May
 2025 14:19:41 +0800
Message-ID: <807e5ea9-ed04-4203-b4a6-bf90952e7934@huawei.com>
Date: Fri, 30 May 2025 14:19:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<admiyo@os.amperecomputing.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jeremy Kerr <jk@codeconstruct.com.au>,
	"Eric Dumazet" <edumazet@google.com>, Matt Johnston
	<matt@codeconstruct.com.au>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>
References: <20250423220142.635223-1-admiyo@os.amperecomputing.com>
 <20250423220142.635223-2-admiyo@os.amperecomputing.com>
 <497a60df-c97e-48b7-bf0f-decbee6ed732@huawei.com>
 <a9f67a55-3471-46b3-bd02-757b0796658a@amperemail.onmicrosoft.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <a9f67a55-3471-46b3-bd02-757b0796658a@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/4/29 2:48, Adam Young 写道:
>
> On 4/24/25 09:03, lihuisong (C) wrote:
>>> +    rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
>>> +                     context.inbox_index);
>>> +    if (rc)
>>> +        goto free_netdev;
>>> +    mctp_pcc_ndev->inbox.client.rx_callback = 
>>> mctp_pcc_client_rx_callback;
>> It is good to move the assignemnt of  rx_callback pointer to 
>> initialize inbox mailbox.
>
>
> The other changes are fine, but this one I do not agree with.
>
> The rx callback only makes sense for one of the two mailboxes, and 
> thus is not appropriate for a generic function.
>
> Either  initialize_mailbox needs more complex logic, or would blindly 
> assign the callback to both mailboxes, neither of which simplifies or 
> streamlines the code.  That function emerged as a way to reduce 
> duplication.  Lets keep it that way.
>
It depends on you. But please reply my below comment. I didn't see any 
change about it in next version.

-->

> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device 
> *ndev)
> +{
> +    struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
> +    struct mctp_pcc_hdr *mctp_pcc_header;
> +    void __iomem *buffer;
> +    unsigned long flags;
> +    int len = skb->len;
> +    int rc;
> +
> +    rc = skb_cow_head(skb, sizeof(struct mctp_pcc_hdr));
> +    if (rc)
> +        goto err_drop;
> +
> +    mctp_pcc_header = skb_push(skb, sizeof(struct mctp_pcc_hdr));
> +    mctp_pcc_header->signature = cpu_to_le32(PCC_MAGIC | 
> mpnd->outbox.index);
> +    mctp_pcc_header->flags = cpu_to_le32(PCC_HEADER_FLAGS);
> +    memcpy(mctp_pcc_header->mctp_signature, MCTP_SIGNATURE,
> +           MCTP_SIGNATURE_LENGTH);
> +    mctp_pcc_header->length = cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
> +
> +    spin_lock_irqsave(&mpnd->lock, flags);
> +    buffer = mpnd->outbox.chan->shmem;
> +    memcpy_toio(buffer, skb->data, skb->len);
> + mpnd->outbox.chan->mchan->mbox->ops->send_data(mpnd->outbox.chan->mchan,
> +                            NULL);
> +    spin_unlock_irqrestore(&mpnd->lock, flags);
> +
Why does it not need to know if the packet is sent successfully?
It's possible for the platform not to finish to send the packet after 
executing this unlock.
In this moment, the previous packet may be modified by the new packet to 
be sent.

