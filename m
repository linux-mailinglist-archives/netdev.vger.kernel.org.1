Return-Path: <netdev+bounces-111815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C93C9331D7
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 21:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76AB1C21F26
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 19:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085551A01D5;
	Tue, 16 Jul 2024 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="jJdfsX3Z"
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2375419F49D
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158090; cv=none; b=pr00wsKvmRTqkM87NpbFCUEIavf4RCw8aD47v/VBYgqJrrb2L5pyxTnATSLlprBFDOUcHG6VJfCtN6v2RRsmA+AoEBRL5kKekn5d7wGfw3RIbWAmnGKWQtFeZt0miBDPMQrMrrerBBxdF4DYhLyCuwv13VHfKOfvxzb2Excxn0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158090; c=relaxed/simple;
	bh=Ygw1YCI4FrNNIFN2ejQviKt2q6IdYCHyUHmFYwY/BgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tjXXGFoq6xtvgZ04WRYteLMxJQvW0HJjLh7vehSNcodERs2VjT8uwLikqJ7Cuaw0cgQNGlTMADY59fNAD98NHCM1aqJ8XxeqgSOV2U65acfSFnL+Cz4iRAqdDKmkMMeuG0mSOcEMIZ2ZtT1thAw5tP9Wcol+1B3zAnHu8RN2oCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=jJdfsX3Z; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 3845 invoked from network); 16 Jul 2024 21:27:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1721158078; bh=mqI4WkJLO0SZdBlyKqtx7TFzSQ+QeKWzatQeSw9Tnbk=;
          h=Subject:To:From;
          b=jJdfsX3ZBtrpnx58MMSfTjTiJ+jgjrSjOPdzUKDNJXf31ySFeS/iCjoZN6Lx15sts
           +Plt3UYAgcZzBkfOrkLO/EDAnBBc9BzrUt4CE9m05d8hX7z+FgoElz2oRJeYYPmJde
           v/s+ROc9AbAXxItPRdlEzE+AHkAXmps9f4g1kJXU=
Received: from 83.24.148.52.ipv4.supernova.orange.pl (HELO [192.168.3.181]) (olek2@wp.pl@[83.24.148.52])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <pabeni@redhat.com>; 16 Jul 2024 21:27:58 +0200
Message-ID: <f198e784-119e-448c-8c72-a02075623809@wp.pl>
Date: Tue, 16 Jul 2024 21:27:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: lantiq_etop: fix memory disclosure
To: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, shannon.nelson@amd.com,
 sd@queasysnail.net, u.kleine-koenig@pengutronix.de, john@phrozen.org,
 ralf@linux-mips.org, ralph.hempel@lantiq.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240713223357.2911169-1-olek2@wp.pl>
 <b5a2f43e-790f-475c-bb63-539af91513ac@redhat.com>
Content-Language: en-US
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <b5a2f43e-790f-475c-bb63-539af91513ac@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: 59113f08fb7a744de72e5dd56bc95d41
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [kcPU]                               

Hi Paolo,

On 16.07.2024 11:46, Paolo Abeni wrote:
> On 7/14/24 00:33, Aleksander Jan Bajkowski wrote:
>> diff --git a/drivers/net/ethernet/lantiq_etop.c 
>> b/drivers/net/ethernet/lantiq_etop.c
>> index 0b9982804370..196715d9ea43 100644
>> --- a/drivers/net/ethernet/lantiq_etop.c
>> +++ b/drivers/net/ethernet/lantiq_etop.c
>> @@ -478,11 +478,11 @@ ltq_etop_tx(struct sk_buff *skb, struct 
>> net_device *dev)
>>       struct ltq_etop_priv *priv = netdev_priv(dev);
>>       struct ltq_etop_chan *ch = &priv->ch[(queue << 1) | 1];
>>       struct ltq_dma_desc *desc = &ch->dma.desc_base[ch->dma.desc];
>> -    int len;
>>       unsigned long flags;
>>       u32 byte_offset;
>>   -    len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
>> +    if (skb_put_padto(skb, ETH_ZLEN))
>
> You may want to increment tx drop stats here.

Statistics are on my TODO list. The current version of this driver
does not support statistics, so I will add them then. I would first
prefer to fix all the bugs present in the current version of the driver
and then add new features.


>
> Thanks,
>
> Paolo
>
Best regards,
Aleksander



