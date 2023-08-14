Return-Path: <netdev+bounces-27250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC45977B286
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 09:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C3D28101C
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 07:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3448834;
	Mon, 14 Aug 2023 07:32:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0CB1842
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 07:32:31 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31501E75
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 00:32:29 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3177b6bd875so534202f8f.0
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 00:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691998347; x=1692603147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JZhJnxLl5/hxwRD6RcnqAJV9VSz0s93qZ3zTgomAZw=;
        b=IPvHYDLJiC15Ze3/Y355vrq+Evpc0PciKdqAF+6zmxGdmc7wY2eFs1E6FcKc64nLom
         CQeQigSGnJAAMaeid8NnM5rY5fmcbJkohhyqdrIJgwncxvmY5O5QYexzUwkJ2vPZai83
         aWAvL7QA4D8cxy/M/h1pD/0fUiRQePZw2sHH80ABxmJ44zhZWRPwjEL5j+hTWDLOqmTo
         3zPKuwBY4SVr9eMFR3SVtrQFUUJce1ZmQdtI+gaWlImJPEs73qlmYiG/V0iWBOXYm2hp
         nIVPEmfbouBCVE/ROIbnjFq8jKbtw5eND+KDoOSGph0mwYvT8TGNAV1STYOhMvXX3U1s
         oLYw==
X-Gm-Message-State: AOJu0Ywio8j/H4rNtkhDlvdjdouIiaWSWmxAzpPyvDaCOEljv7+O2kA9
	UZPXh4ruFo/nT7cgoSTrhdg=
X-Google-Smtp-Source: AGHT+IFIuDKzN57buPIfzHNzuN7jnsdw/924uPh1ka2T9FPgyq9fOkvIYzoBbf4tyJArdlbSuLSxbw==
X-Received: by 2002:a5d:4dce:0:b0:317:6c66:bdc3 with SMTP id f14-20020a5d4dce000000b003176c66bdc3mr5716541wru.7.1691998347302;
        Mon, 14 Aug 2023 00:32:27 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003fbaade0735sm16352384wmd.19.2023.08.14.00.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 00:32:26 -0700 (PDT)
Message-ID: <9bd285d7-78cd-ff13-4e89-eb36ad478780@grimberg.me>
Date: Mon, 14 Aug 2023 10:32:25 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 14/17] nvmet-tcp: reference counting for queues
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230811121755.24715-1-hare@suse.de>
 <20230811121755.24715-15-hare@suse.de>
 <6aa77bb8-8d22-3e40-c8fe-654b5c094b10@grimberg.me>
 <fe971baa-e009-2388-dc0b-54eb4788eb3f@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <fe971baa-e009-2388-dc0b-54eb4788eb3f@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/13/23 17:38, Hannes Reinecke wrote:
> On 8/13/23 16:01, Sagi Grimberg wrote:
>>
>>
>> On 8/11/23 15:17, Hannes Reinecke wrote:
>>> The 'queue' structure is referenced from various places and
>>> used as an argument of asynchronous functions, so it's really
>>> hard to figure out if the queue is still valid when the
>>> asynchronous function triggers.
>>> So add reference counting to validate the queue structure.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/target/tcp.c | 74 ++++++++++++++++++++++++++++++---------
>>>   1 file changed, 57 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>> index f19ea9d923fd..84b726dfc1c4 100644
>>> --- a/drivers/nvme/target/tcp.c
>>> +++ b/drivers/nvme/target/tcp.c
>>> @@ -127,6 +127,7 @@ enum nvmet_tcp_queue_state {
>>>   };
>>>   struct nvmet_tcp_queue {
>>> +    struct kref        kref;
>>>       struct socket        *sock;
>>>       struct nvmet_tcp_port    *port;
>>>       struct work_struct    io_work;
>>> @@ -192,6 +193,9 @@ static struct workqueue_struct *nvmet_tcp_wq;
>>>   static const struct nvmet_fabrics_ops nvmet_tcp_ops;
>>>   static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>>>   static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
>>> +static int nvmet_tcp_get_queue(struct nvmet_tcp_queue *queue);
>>> +static void nvmet_tcp_put_queue(struct nvmet_tcp_queue *queue);
>>> +static void nvmet_tcp_data_ready(struct sock *sk);
>>>   static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
>>>           struct nvmet_tcp_cmd *cmd)
>>> @@ -1437,11 +1441,21 @@ static void 
>>> nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
>>>       struct socket *sock = queue->sock;
>>>       write_lock_bh(&sock->sk->sk_callback_lock);
>>> +    /*
>>> +     * Check if nvmet_tcp_set_queue_sock() has been called;
>>> +     * if not the queue reference has not been increased
>>> +     * and we're getting an refcount error on exit.
>>> +     */
>>> +    if (sock->sk->sk_data_ready != nvmet_tcp_data_ready) {
>>> +        write_unlock_bh(&sock->sk->sk_callback_lock);
>>> +        return;
>>> +    }
>>
>> This is really ugly I think.
>>
> Me too, but what would be the alternative?
> 
>>>       sock->sk->sk_data_ready =  queue->data_ready;
>>>       sock->sk->sk_state_change = queue->state_change;
>>>       sock->sk->sk_write_space = queue->write_space;
>>>       sock->sk->sk_user_data = NULL;
>>>       write_unlock_bh(&sock->sk->sk_callback_lock);
>>> +    nvmet_tcp_put_queue(queue);
>>>   }
>>>   static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue 
>>> *queue)
>>> @@ -1474,6 +1488,30 @@ static void 
>>> nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
>>>           nvmet_tcp_free_cmd_buffers(&queue->connect);
>>>   }
>>> +static void nvmet_tcp_release_queue_final(struct kref *kref)
>>> +{
>>> +    struct nvmet_tcp_queue *queue = container_of(kref, struct 
>>> nvmet_tcp_queue, kref);
>>> +
>>> +    WARN_ON(queue->state != NVMET_TCP_Q_DISCONNECTING);
>>> +    nvmet_tcp_free_cmds(queue);
>>> +    ida_free(&nvmet_tcp_queue_ida, queue->idx);
>>> +    /* ->sock will be released by fput() */
>>> +    fput(queue->sock->file);
>>> +    kfree(queue);
>>> +}
>>> +
>>> +static int nvmet_tcp_get_queue(struct nvmet_tcp_queue *queue)
>>> +{
>>> +    if (!queue)
>>> +        return 0;
>>> +    return kref_get_unless_zero(&queue->kref);
>>> +}
>>> +
>>> +static void nvmet_tcp_put_queue(struct nvmet_tcp_queue *queue)
>>> +{
>>> +    kref_put(&queue->kref, nvmet_tcp_release_queue_final);
>>> +}
>>> +
>>>   static void nvmet_tcp_release_queue_work(struct work_struct *w)
>>>   {
>>>       struct page *page;
>>> @@ -1493,15 +1531,11 @@ static void 
>>> nvmet_tcp_release_queue_work(struct work_struct *w)
>>>       nvmet_sq_destroy(&queue->nvme_sq);
>>>       cancel_work_sync(&queue->io_work);
>>>       nvmet_tcp_free_cmd_data_in_buffers(queue);
>>> -    /* ->sock will be released by fput() */
>>> -    fput(queue->sock->file);
>>> -    nvmet_tcp_free_cmds(queue);
>>>       if (queue->hdr_digest || queue->data_digest)
>>>           nvmet_tcp_free_crypto(queue);
>>> -    ida_free(&nvmet_tcp_queue_ida, queue->idx);
>>>       page = virt_to_head_page(queue->pf_cache.va);
>>>       __page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
>>> -    kfree(queue);
>>> +    nvmet_tcp_put_queue(queue);
>>
>> What made you pick these vs. the others for before/after the
>> final reference?
>>
> I wanted to call 'nvmet_tcp_put_queue()' for a failed allocation
> in nvmet_tcp_alloc_queue(), and at that time the queue itself
> is not live.
> nvmet_tcp_release_queue() is only called on a live queue, so using
> that as the kref ->release() function would either limit it's
> usefulness or would require me to ensure that all calls in there
> can be made with a non-initialized argument.
> 
>>>   }
>>>   static void nvmet_tcp_data_ready(struct sock *sk)
>>> @@ -1512,8 +1546,10 @@ static void nvmet_tcp_data_ready(struct sock *sk)
>>>       read_lock_bh(&sk->sk_callback_lock);
>>>       queue = sk->sk_user_data;
>>> -    if (likely(queue))
>>> +    if (likely(nvmet_tcp_get_queue(queue))) {
>>>           queue_work_on(queue_cpu(queue), nvmet_tcp_wq, 
>>> &queue->io_work);
>>> +        nvmet_tcp_put_queue(queue);
>>> +    }
>>
>> No... Why?
>>
>> The shutdown code should serialize perfectly without this. Why add
>> a kref to the normal I/O path?
>>
>> I thought we'd simply move release_work to do a kref_put and take
>> an extra reference when we fire the tls handshake...
>>
> Because I feel ever so slightly unsure about using the sk_user_data
> argument. This function is completely asynchronous, and I can't really
> see how we can ensure that sk_user_data references a valid object.
> (If it were valid, why would we need to check for !queue ?)
> 
> If you have lifetime guarantees that the kref isn't required, by all
> means, please tell me, and we can drop the kref thing here.
> But I guess that would imply to _not_ having to check for (!queue)
> which is fine by me, too.

Something doesn't add up here.
What I think you need to do, is add another reference just for the
tls handshake.

Then in the timeout handler you call tls_handshake_cancel():
- if you got %true back, you drop the reference and schedule
a release work
- if you got %false back, you simply ignore the timeout because
the .ta_done() was already triggered.
- in .ta_done() you drop the reference, cancel the timeout work
   and then continue or remove based on the status.

btw in the queue release you should call tls_handshake_cancel() as well.

