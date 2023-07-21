Return-Path: <netdev+bounces-19878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7089375CA31
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01BB1C2167D
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA9127F12;
	Fri, 21 Jul 2023 14:37:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1F119BC5
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:37:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFED01710
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689950228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLNuEjjJSH2cAZnyzcFuA7aAFU5mhK6ZDDwKxW6aTN4=;
	b=aol08VwgQ/8FLgKIEIA/7lJDpZI/rK5ywZwfPpjS3URQAMgEFcPWPe1qiHYHFY6ms+v0+W
	G1wPEsR0hXCd0R27KCJY2JhkfNFEP1BF0p9QTVuWtQP6GMa5qZW9tEzjCbaUvYooC74sso
	Ed+vXNBCiR2+bhqUklRHPBFWiOSE2o0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-gXQpZz0fONycshKwShFp3w-1; Fri, 21 Jul 2023 10:37:04 -0400
X-MC-Unique: gXQpZz0fONycshKwShFp3w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6127E3C0D847;
	Fri, 21 Jul 2023 14:37:04 +0000 (UTC)
Received: from [10.39.208.41] (unknown [10.39.208.41])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CC0D492B02;
	Fri, 21 Jul 2023 14:37:02 +0000 (UTC)
Message-ID: <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
Date: Fri, 21 Jul 2023 16:37:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Shannon Nelson <shannon.nelson@amd.com>
Cc: Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20230720170001-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/20/23 23:02, Michael S. Tsirkin wrote:
> On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
>> On 7/20/23 1:38 AM, Jason Wang wrote:
>>>
>>> Adding cond_resched() to the command waiting loop for a better
>>> co-operation with the scheduler. This allows to give CPU a breath to
>>> run other task(workqueue) instead of busy looping when preemption is
>>> not allowed on a device whose CVQ might be slow.
>>>
>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>
>> This still leaves hung processes, but at least it doesn't pin the CPU any
>> more.  Thanks.
>> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
>>
> 
> I'd like to see a full solution
> 1- block until interrupt

Would it make sense to also have a timeout?
And when timeout expires, set FAILED bit in device status?

> 2- still handle surprise removal correctly by waking in that case
> 
> 
> 
>>> ---
>>>    drivers/net/virtio_net.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index 9f3b1d6ac33d..e7533f29b219 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>>>            * into the hypervisor, so the request should be handled immediately.
>>>            */
>>>           while (!virtqueue_get_buf(vi->cvq, &tmp) &&
>>> -              !virtqueue_is_broken(vi->cvq))
>>> +              !virtqueue_is_broken(vi->cvq)) {
>>> +               cond_resched();
>>>                   cpu_relax();
>>> +       }
>>>
>>>           return vi->ctrl->status == VIRTIO_NET_OK;
>>>    }
>>> --
>>> 2.39.3
>>>
>>> _______________________________________________
>>> Virtualization mailing list
>>> Virtualization@lists.linux-foundation.org
>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 


