Return-Path: <netdev+bounces-27128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9DB77A6FF
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 16:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77718280FA7
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 14:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF2C5395;
	Sun, 13 Aug 2023 14:38:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211C03D7A
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 14:38:38 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352CC10DE
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 07:38:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0EE5A1F8C2;
	Sun, 13 Aug 2023 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691937515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XG77WwgrbqNAtRpiCA9zFnnIvUyShu4BoNdctPor2wE=;
	b=Bg/qQOqZ16DQASt5PLdWIG883y/1UYlTRzdcUTK3KTNwsltZUhdmF+5frxlNsNCi+h3qBD
	dA24fBX+9VuRSJNULZIoTY5jWxSOX/7h8lLhkqAvd3XQm2/bUVIl9ywJJxJFuclhPlRaxg
	Uub35h9LLG0s39+ZvFiIh9A2PKZxF1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691937515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XG77WwgrbqNAtRpiCA9zFnnIvUyShu4BoNdctPor2wE=;
	b=FWueex4DGXdIEKQISY/F2VuXT0F0EzMIBl4Spw4qs01qVYCmHh3jsw0J4s6OCm2U228qlM
	20ILG2j/LsYKX9BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC7351322C;
	Sun, 13 Aug 2023 14:38:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id VD3FLOrq2GSzEAAAMHmgww
	(envelope-from <hare@suse.de>); Sun, 13 Aug 2023 14:38:34 +0000
Message-ID: <fe971baa-e009-2388-dc0b-54eb4788eb3f@suse.de>
Date: Sun, 13 Aug 2023 16:38:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 14/17] nvmet-tcp: reference counting for queues
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230811121755.24715-1-hare@suse.de>
 <20230811121755.24715-15-hare@suse.de>
 <6aa77bb8-8d22-3e40-c8fe-654b5c094b10@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <6aa77bb8-8d22-3e40-c8fe-654b5c094b10@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/13/23 16:01, Sagi Grimberg wrote:
> 
> 
> On 8/11/23 15:17, Hannes Reinecke wrote:
>> The 'queue' structure is referenced from various places and
>> used as an argument of asynchronous functions, so it's really
>> hard to figure out if the queue is still valid when the
>> asynchronous function triggers.
>> So add reference counting to validate the queue structure.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/target/tcp.c | 74 ++++++++++++++++++++++++++++++---------
>>   1 file changed, 57 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index f19ea9d923fd..84b726dfc1c4 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -127,6 +127,7 @@ enum nvmet_tcp_queue_state {
>>   };
>>   struct nvmet_tcp_queue {
>> +    struct kref        kref;
>>       struct socket        *sock;
>>       struct nvmet_tcp_port    *port;
>>       struct work_struct    io_work;
>> @@ -192,6 +193,9 @@ static struct workqueue_struct *nvmet_tcp_wq;
>>   static const struct nvmet_fabrics_ops nvmet_tcp_ops;
>>   static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>>   static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
>> +static int nvmet_tcp_get_queue(struct nvmet_tcp_queue *queue);
>> +static void nvmet_tcp_put_queue(struct nvmet_tcp_queue *queue);
>> +static void nvmet_tcp_data_ready(struct sock *sk);
>>   static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
>>           struct nvmet_tcp_cmd *cmd)
>> @@ -1437,11 +1441,21 @@ static void 
>> nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
>>       struct socket *sock = queue->sock;
>>       write_lock_bh(&sock->sk->sk_callback_lock);
>> +    /*
>> +     * Check if nvmet_tcp_set_queue_sock() has been called;
>> +     * if not the queue reference has not been increased
>> +     * and we're getting an refcount error on exit.
>> +     */
>> +    if (sock->sk->sk_data_ready != nvmet_tcp_data_ready) {
>> +        write_unlock_bh(&sock->sk->sk_callback_lock);
>> +        return;
>> +    }
> 
> This is really ugly I think.
> 
Me too, but what would be the alternative?

>>       sock->sk->sk_data_ready =  queue->data_ready;
>>       sock->sk->sk_state_change = queue->state_change;
>>       sock->sk->sk_write_space = queue->write_space;
>>       sock->sk->sk_user_data = NULL;
>>       write_unlock_bh(&sock->sk->sk_callback_lock);
>> +    nvmet_tcp_put_queue(queue);
>>   }
>>   static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue 
>> *queue)
>> @@ -1474,6 +1488,30 @@ static void 
>> nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
>>           nvmet_tcp_free_cmd_buffers(&queue->connect);
>>   }
>> +static void nvmet_tcp_release_queue_final(struct kref *kref)
>> +{
>> +    struct nvmet_tcp_queue *queue = container_of(kref, struct 
>> nvmet_tcp_queue, kref);
>> +
>> +    WARN_ON(queue->state != NVMET_TCP_Q_DISCONNECTING);
>> +    nvmet_tcp_free_cmds(queue);
>> +    ida_free(&nvmet_tcp_queue_ida, queue->idx);
>> +    /* ->sock will be released by fput() */
>> +    fput(queue->sock->file);
>> +    kfree(queue);
>> +}
>> +
>> +static int nvmet_tcp_get_queue(struct nvmet_tcp_queue *queue)
>> +{
>> +    if (!queue)
>> +        return 0;
>> +    return kref_get_unless_zero(&queue->kref);
>> +}
>> +
>> +static void nvmet_tcp_put_queue(struct nvmet_tcp_queue *queue)
>> +{
>> +    kref_put(&queue->kref, nvmet_tcp_release_queue_final);
>> +}
>> +
>>   static void nvmet_tcp_release_queue_work(struct work_struct *w)
>>   {
>>       struct page *page;
>> @@ -1493,15 +1531,11 @@ static void 
>> nvmet_tcp_release_queue_work(struct work_struct *w)
>>       nvmet_sq_destroy(&queue->nvme_sq);
>>       cancel_work_sync(&queue->io_work);
>>       nvmet_tcp_free_cmd_data_in_buffers(queue);
>> -    /* ->sock will be released by fput() */
>> -    fput(queue->sock->file);
>> -    nvmet_tcp_free_cmds(queue);
>>       if (queue->hdr_digest || queue->data_digest)
>>           nvmet_tcp_free_crypto(queue);
>> -    ida_free(&nvmet_tcp_queue_ida, queue->idx);
>>       page = virt_to_head_page(queue->pf_cache.va);
>>       __page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
>> -    kfree(queue);
>> +    nvmet_tcp_put_queue(queue);
> 
> What made you pick these vs. the others for before/after the
> final reference?
> 
I wanted to call 'nvmet_tcp_put_queue()' for a failed allocation
in nvmet_tcp_alloc_queue(), and at that time the queue itself
is not live.
nvmet_tcp_release_queue() is only called on a live queue, so using
that as the kref ->release() function would either limit it's
usefulness or would require me to ensure that all calls in there
can be made with a non-initialized argument.

>>   }
>>   static void nvmet_tcp_data_ready(struct sock *sk)
>> @@ -1512,8 +1546,10 @@ static void nvmet_tcp_data_ready(struct sock *sk)
>>       read_lock_bh(&sk->sk_callback_lock);
>>       queue = sk->sk_user_data;
>> -    if (likely(queue))
>> +    if (likely(nvmet_tcp_get_queue(queue))) {
>>           queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
>> +        nvmet_tcp_put_queue(queue);
>> +    }
> 
> No... Why?
> 
> The shutdown code should serialize perfectly without this. Why add
> a kref to the normal I/O path?
> 
> I thought we'd simply move release_work to do a kref_put and take
> an extra reference when we fire the tls handshake...
> 
Because I feel ever so slightly unsure about using the sk_user_data
argument. This function is completely asynchronous, and I can't really
see how we can ensure that sk_user_data references a valid object.
(If it were valid, why would we need to check for !queue ?)

If you have lifetime guarantees that the kref isn't required, by all
means, please tell me, and we can drop the kref thing here.
But I guess that would imply to _not_ having to check for (!queue)
which is fine by me, too.

>>       read_unlock_bh(&sk->sk_callback_lock);
>>   }
>> @@ -1523,18 +1559,16 @@ static void nvmet_tcp_write_space(struct sock 
>> *sk)
>>       read_lock_bh(&sk->sk_callback_lock);
>>       queue = sk->sk_user_data;
>> -    if (unlikely(!queue))
>> +    if (unlikely(!nvmet_tcp_get_queue(queue)))
>>           goto out;
>>       if (unlikely(queue->state == NVMET_TCP_Q_CONNECTING)) {
>>           queue->write_space(sk);
>> -        goto out;
>> -    }
>> -
>> -    if (sk_stream_is_writeable(sk)) {
>> +    } else if (sk_stream_is_writeable(sk)) {
>>           clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>>           queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
>>       }
>> +    nvmet_tcp_put_queue(queue);
> 
> Same here...
> 
> Why not simply exclude the kref get/put to the tls handshake where
> there is actually a race?
> 
It's not abot the handshake, it's about socket closing.
See above.

>>   out:
>>       read_unlock_bh(&sk->sk_callback_lock);
>>   }
>> @@ -1545,7 +1579,7 @@ static void nvmet_tcp_state_change(struct sock *sk)
>>       read_lock_bh(&sk->sk_callback_lock);
>>       queue = sk->sk_user_data;
>> -    if (!queue)
>> +    if (!nvmet_tcp_get_queue(queue))
>>           goto done;
>>       switch (sk->sk_state) {
>> @@ -1562,6 +1596,7 @@ static void nvmet_tcp_state_change(struct sock *sk)
>>           pr_warn("queue %d unhandled state %d\n",
>>               queue->idx, sk->sk_state);
>>       }
>> +    nvmet_tcp_put_queue(queue);
>>   done:
>>       read_unlock_bh(&sk->sk_callback_lock);
>>   }
>> @@ -1582,6 +1617,9 @@ static int nvmet_tcp_set_queue_sock(struct 
>> nvmet_tcp_queue *queue)
>>       if (ret < 0)
>>           return ret;
>> +    if (unlikely(!nvmet_tcp_get_queue(queue)))
>> +        return -ECONNRESET;
>> +
> 
> Can this actually fail?
> 
Yes. The socket might have been closed before this call.
Unlikely, I know, but still...

>>       /*
>>        * Cleanup whatever is sitting in the TCP transmit queue on socket
>>        * close. This is done to prevent stale data from being sent should
>> @@ -1603,6 +1641,7 @@ static int nvmet_tcp_set_queue_sock(struct 
>> nvmet_tcp_queue *queue)
>>            * If the socket is already closing, don't even start
>>            * consuming it
>>            */
>> +        nvmet_tcp_put_queue(queue);
>>           ret = -ENOTCONN;
>>       } else {
>>           sock->sk->sk_user_data = queue;
>> @@ -1636,6 +1675,7 @@ static void nvmet_tcp_alloc_queue(struct 
>> nvmet_tcp_port *port,
>>       INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
>>       INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
>> +    kref_init(&queue->kref);
>>       queue->sock = newsock;
>>       queue->port = port;
>>       queue->nr_cmds = 0;
>> @@ -1672,15 +1712,15 @@ static void nvmet_tcp_alloc_queue(struct 
>> nvmet_tcp_port *port,
>>       mutex_unlock(&nvmet_tcp_queue_mutex);
>>       ret = nvmet_tcp_set_queue_sock(queue);
>> -    if (ret)
>> -        goto out_destroy_sq;
>> +    if (!ret)
>> +        return;
>> -    return;
>> -out_destroy_sq:
>> +    queue->state = NVMET_TCP_Q_DISCONNECTING;
>>       mutex_lock(&nvmet_tcp_queue_mutex);
>>       list_del_init(&queue->queue_list);
>>       mutex_unlock(&nvmet_tcp_queue_mutex);
>> -    nvmet_sq_destroy(&queue->nvme_sq);
>> +    nvmet_tcp_put_queue(queue);
>> +    return;
>>   out_free_connect:
>>       nvmet_tcp_free_cmd(&queue->connect);
>>   out_ida_remove:

But thanks for the review!

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


