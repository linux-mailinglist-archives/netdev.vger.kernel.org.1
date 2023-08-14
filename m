Return-Path: <netdev+bounces-27450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0386677C070
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267AF1C20B45
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 19:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5532CA6D;
	Mon, 14 Aug 2023 19:12:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB060C2CE
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 19:12:25 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C611715
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:12:21 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5230963f636so1433792a12.0
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692040340; x=1692645140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYZDzpDhPpUu+V/D6Iom0HMlkeGtrJCPzmM64j8kbtE=;
        b=cC1YbBaay0QCengLZUF2d8XZ45I7+KRbkB2ferFhlhaIjdFYKRDDcJttUG58UFEpVM
         QWNkcsvswKZAxrvsEqxzvS1k3R9L/ovhkW/tO9vfYfxa+/3Xj901swgbZZqIijahGFvY
         sal4wSBfzd++GIBUgRclJHlKSJvnxsOG/KK5nTXG1OrHUrp9WizILs4Q8DpVDB1njH+S
         ck8JwWVkkegN9Opd9i9H72imfv1j9+95EtvVsSnaYKkYjsw02spySX1Yd8yRUUXdKtM6
         JfCkxk219XZwL/GtX+2vMHWgc3iEZaj5aTx8IpHwQXDPuOtALeHyjTZu170Lp603jfXM
         SESw==
X-Gm-Message-State: AOJu0YwtJMeG7x0d4Hn54frVCLrioNdCyvGz+tbodhgDWTCwqY5GaV6Z
	LbYAaG71nn5VDNLLad0azwbpHuhqDic=
X-Google-Smtp-Source: AGHT+IErgcbz/hR+TLPLKyCV4srVgY9c5gHs09OFSnnnRxqYVHGz7HwbbnM6fh5lgPuKvo+wNJVGVg==
X-Received: by 2002:a17:906:21c:b0:99c:c178:cef9 with SMTP id 28-20020a170906021c00b0099cc178cef9mr8072805ejd.2.1692040339460;
        Mon, 14 Aug 2023 12:12:19 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id ke10-20020a17090798ea00b00982a352f078sm5951999ejc.124.2023.08.14.12.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:12:18 -0700 (PDT)
Message-ID: <a7e01b78-52ba-9576-6d71-6d1f81aecd44@grimberg.me>
Date: Mon, 14 Aug 2023 22:12:16 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/17] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-16-hare@suse.de>
 <cf21000c-177e-c882-ac30-fe3190748bae@grimberg.me>
 <bebf00fb-be2d-d6da-bd7f-4e610095decc@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bebf00fb-be2d-d6da-bd7f-4e610095decc@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>>> @@ -1864,6 +1877,14 @@ static struct config_group 
>>> *nvmet_ports_make(struct config_group *group,
>>>           return ERR_PTR(-ENOMEM);
>>>       }
>>> +    if (nvme_keyring_id()) {
>>> +        port->keyring = key_lookup(nvme_keyring_id());
>>> +        if (IS_ERR(port->keyring)) {
>>> +            pr_warn("NVMe keyring not available, disabling TLS\n");
>>> +            port->keyring = NULL;
>>
>> why setting this to NULL?
>>
> It's check when changing TSAS; we can only enable TLS if the nvme 
> keyring is available.

ok

> 
>>> +        }
>>> +    }
>>> +
>>>       for (i = 1; i <= NVMET_MAX_ANAGRPS; i++) {
>>>           if (i == NVMET_DEFAULT_ANA_GRPID)
>>>               port->ana_state[1] = NVME_ANA_OPTIMIZED;
>>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>>> index 8cfd60f3b564..7f9ae53c1df5 100644
>>> --- a/drivers/nvme/target/nvmet.h
>>> +++ b/drivers/nvme/target/nvmet.h
>>> @@ -158,6 +158,7 @@ struct nvmet_port {
>>>       struct config_group        ana_groups_group;
>>>       struct nvmet_ana_group        ana_default_group;
>>>       enum nvme_ana_state        *ana_state;
>>> +    struct key            *keyring;
>>>       void                *priv;
>>>       bool                enabled;
>>>       int                inline_data_size;
>>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>>> index f19ea9d923fd..77fa339008e1 100644
>>> --- a/drivers/nvme/target/tcp.c
>>> +++ b/drivers/nvme/target/tcp.c
>>> @@ -8,9 +8,13 @@
>>>   #include <linux/init.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/err.h>
>>> +#include <linux/key.h>
>>>   #include <linux/nvme-tcp.h>
>>> +#include <linux/nvme-keyring.h>
>>>   #include <net/sock.h>
>>>   #include <net/tcp.h>
>>> +#include <net/tls.h>
>>> +#include <net/handshake.h>
>>>   #include <linux/inet.h>
>>>   #include <linux/llist.h>
>>>   #include <crypto/hash.h>
>>> @@ -66,6 +70,16 @@ device_param_cb(idle_poll_period_usecs, 
>>> &set_param_ops,
>>>   MODULE_PARM_DESC(idle_poll_period_usecs,
>>>           "nvmet tcp io_work poll till idle time period in usecs: 
>>> Default 0");
>>> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
>>> +/*
>>> + * TLS handshake timeout
>>> + */
>>> +static int tls_handshake_timeout = 10;
>>> +module_param(tls_handshake_timeout, int, 0644);
>>> +MODULE_PARM_DESC(tls_handshake_timeout,
>>> +         "nvme TLS handshake timeout in seconds (default 10)");
>>> +#endif
>>> +
>>>   #define NVMET_TCP_RECV_BUDGET        8
>>>   #define NVMET_TCP_SEND_BUDGET        8
>>>   #define NVMET_TCP_IO_WORK_BUDGET    64
>>> @@ -122,11 +136,13 @@ struct nvmet_tcp_cmd {
>>>   enum nvmet_tcp_queue_state {
>>>       NVMET_TCP_Q_CONNECTING,
>>> +    NVMET_TCP_Q_TLS_HANDSHAKE,
>>>       NVMET_TCP_Q_LIVE,
>>>       NVMET_TCP_Q_DISCONNECTING,
>>>   };
>>>   struct nvmet_tcp_queue {
>>> +    struct kref        kref;
>>
>> Why is kref the first member of the struct?
>>
> Habit.
> I don't mind where it'll end up.

Move it to the back together with the tls section.

> 
>>>       struct socket        *sock;
>>>       struct nvmet_tcp_port    *port;
>>>       struct work_struct    io_work;
>>> @@ -155,6 +171,10 @@ struct nvmet_tcp_queue {
>>>       struct ahash_request    *snd_hash;
>>>       struct ahash_request    *rcv_hash;
>>> +    /* TLS state */
>>> +    key_serial_t        tls_pskid;
>>> +    struct delayed_work    tls_handshake_work;
>>> +
>>>       unsigned long           poll_end;
>>>       spinlock_t        state_lock;
>>> @@ -1283,12 +1303,21 @@ static int nvmet_tcp_try_recv(struct 
>>> nvmet_tcp_queue *queue,
>>>       return ret;
>>>   }
>>> +static void nvmet_tcp_release_queue(struct kref *kref)
>>> +{
>>> +    struct nvmet_tcp_queue *queue =
>>> +        container_of(kref, struct nvmet_tcp_queue, kref);
>>> +
>>> +    WARN_ON(queue->state != NVMET_TCP_Q_DISCONNECTING);
>>> +    queue_work(nvmet_wq, &queue->release_work);
>>> +}
>>> +
>>>   static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue 
>>> *queue)
>>>   {
>>>       spin_lock_bh(&queue->state_lock);
>>>       if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
>>>           queue->state = NVMET_TCP_Q_DISCONNECTING;
>>> -        queue_work(nvmet_wq, &queue->release_work);
>>> +        kref_put(&queue->kref, nvmet_tcp_release_queue);
>>>       }
>>>       spin_unlock_bh(&queue->state_lock);
>>>   }
>>> @@ -1485,6 +1514,8 @@ static void nvmet_tcp_release_queue_work(struct 
>>> work_struct *w)
>>>       mutex_unlock(&nvmet_tcp_queue_mutex);
>>>       nvmet_tcp_restore_socket_callbacks(queue);
>>> +    tls_handshake_cancel(queue->sock->sk);
>>> +    cancel_delayed_work_sync(&queue->tls_handshake_work);
>>
>> We should call it tls_handshake_tmo_work or something to make it
>> clear it is a timeout work.
>>
> Okay.
> 
>>>       cancel_work_sync(&queue->io_work);
>>>       /* stop accepting incoming data */
>>>       queue->rcv_state = NVMET_TCP_RECV_ERR;
>>> @@ -1512,8 +1543,13 @@ static void nvmet_tcp_data_ready(struct sock *sk)
>>>       read_lock_bh(&sk->sk_callback_lock);
>>>       queue = sk->sk_user_data;
>>> -    if (likely(queue))
>>> -        queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
>>> +    if (likely(queue)) {
>>> +        if (queue->data_ready)
>>> +            queue->data_ready(sk);
>>> +        if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
>>> +            queue_work_on(queue_cpu(queue), nvmet_tcp_wq,
>>> +                      &queue->io_work);
>>> +    }
>>>       read_unlock_bh(&sk->sk_callback_lock);
>>>   }
>>> @@ -1621,6 +1657,83 @@ static int nvmet_tcp_set_queue_sock(struct 
>>> nvmet_tcp_queue *queue)
>>>       return ret;
>>>   }
>>> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
>>> +static void nvmet_tcp_tls_handshake_done(void *data, int status,
>>> +                     key_serial_t peerid)
>>> +{
>>> +    struct nvmet_tcp_queue *queue = data;
>>> +
>>> +    pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
>>> +         queue->idx, peerid, status);
>>> +    spin_lock_bh(&queue->state_lock);
>>> +    if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
>>
>> Is this even possible?
>>
> I guess it can happen when the socket closes during handshake; the 
> daemon might still be sending a 'done' event but 
> nvmet_tcp_schedule_release_queue() has been called.

Umm, if the socket closes during the handshake then the state
is NVMET_TCP_Q_TLS_HANDSHAKE.

p.s. you call handshake cancel in the release flow so you should be
fenced properly no?

