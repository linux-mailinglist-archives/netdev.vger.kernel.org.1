Return-Path: <netdev+bounces-36701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE1C7B155D
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 09:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 41BF1B2089F
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 07:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D45A31A83;
	Thu, 28 Sep 2023 07:51:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCA030FAE
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 07:51:24 +0000 (UTC)
Received: from out-191.mta1.migadu.com (out-191.mta1.migadu.com [95.215.58.191])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01C18F
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 00:51:22 -0700 (PDT)
Message-ID: <6bb95279-156d-220c-c294-891c92ca5fd4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695887480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/o4DvQF5+P1asWm9khV9BxT4OLKo5uZtNGVN8+1BhuA=;
	b=SBXAHMQFpNJOJD/ZrXu0NhrMON5nSjA2S1zQeRvBQHaDR3BeAFonw6NdlqApzVRgyB42Zn
	MA3DvA3rSXCQTW+Hhj0dqq3JXjKMvv6zpmLCmJkT0xgdscGmURCPEmoNB3sssP7U2VAJ6U
	UXs37AxME4vtW6mSwC6IlboDJF0sKuA=
Date: Thu, 28 Sep 2023 08:51:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] net: qualcomm: rmnet: Add side band flow
 control support
Content-Language: en-US
To: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, lkp@intel.com
Cc: Sean Tranchetti <quic_stranche@quicinc.com>
References: <20230926182407.964671-1-quic_subashab@quicinc.com>
 <8cbd0969-0c1f-3c19-778b-4af9b3ad6417@linux.dev>
 <1f0069a7-8581-acc0-1ab8-bd5dd95cdb49@quicinc.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <1f0069a7-8581-acc0-1ab8-bd5dd95cdb49@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 28.09.2023 04:31, Subash Abhinov Kasiviswanathan (KS) wrote:
> 
> 
> On 9/27/2023 6:12 PM, Vadim Fedorenko wrote:
>> On 26/09/2023 19:24, Subash Abhinov Kasiviswanathan wrote:
>>> Individual rmnet devices map to specific network types such as internet,
>>> multimedia messaging services, IP multimedia subsystem etc. Each of
>>> these network types may support varying quality of service for different
>>> bearers or traffic types.
>>>
>>
>>> +static u16 rmnet_vnd_select_queue(struct net_device *dev,
>>> +                  struct sk_buff *skb,
>>> +                  struct net_device *sb_dev)
>>> +{
>>> +    struct rmnet_priv *priv = netdev_priv(dev);
>>> +    void *p = xa_load(&priv->queue_map, skb->mark);
>>
>> Reverse X-mas tree, please.
> 
> We need to get priv first though. Alternatively, i could do the following but it 
> is just more verbose for the sake of the formatting.
> 
>      struct rmnet_priv *priv;
>      void *p;
> 
>      priv = netdev_priv(dev);
>      p = xa_load(&priv->queue_map, skb->mark);

I think you can move xa_load only.

> 
>>
>>> +    u8 txq;
>>> +
>>> +    if (!p || !xa_is_value(p))
>>> +        return 0;
>>> +
>>> +    txq = xa_to_value(p);
>>> +
>>> +    netdev_dbg(dev, "mark %08x -> txq %02x\n", skb->mark, txq);
>>> +    return txq;
>>> +}
>>> +
>>
>>


