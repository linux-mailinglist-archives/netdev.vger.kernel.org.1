Return-Path: <netdev+bounces-29520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B37839CD
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 08:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455C31C20A06
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 06:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21263FE0;
	Tue, 22 Aug 2023 06:16:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2EB257D
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 06:16:26 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6999A1A7
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 23:16:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2032322C41;
	Tue, 22 Aug 2023 06:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692684982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/C+6di8h/P7X0rLbIDXCNqtr5/RVOLTGEl70C0Eb3o=;
	b=zJ4OlTTQuKqW53U4P+L3Y/BZTad4UgpHY2JoV1xzEHRmPd+fdYO7C3GlcMFpCiqPSIzWsf
	Z1FJlx66opW6rVh1vzVsTjbpMFKgo5MSVOX6qmWfWn4oLAktYeM0GpteokmCbM/28xGxhj
	j5YllGha3xlYqsH0nm/uU+Ov7Rzy3L4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692684982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/C+6di8h/P7X0rLbIDXCNqtr5/RVOLTGEl70C0Eb3o=;
	b=4jFKy+TqF7rOsNO11uoml23ClwXbC8jwjAzGmnEpx/FzOYCbWamw32Ua26HsQbLaHaDeJu
	VjjQdwVG3On9WyAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CFE0132B9;
	Tue, 22 Aug 2023 06:16:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id daHkN7RS5GSxPAAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 22 Aug 2023 06:16:20 +0000
Message-ID: <d1964667-79f6-52a2-d303-4c50cf2b9327@suse.de>
Date: Tue, 22 Aug 2023 08:16:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 16/18] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230816120608.37135-1-hare@suse.de>
 <20230816120608.37135-17-hare@suse.de>
 <87d71462-cadd-f572-c007-1909430fe4ab@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <87d71462-cadd-f572-c007-1909430fe4ab@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/20/23 16:55, Sagi Grimberg wrote:
> 
> 
> On 8/16/23 15:06, Hannes Reinecke wrote:
>> TLS handshake is handled in userspace with the
>> netlink tls handshake protocol.
>> The patch adds a function to start the TLS handshake
>> upcall for any incoming network connections if
>> the TCP TSAS sectype is set to 'tls1.3'.
>> A config option NVME_TARGET_TCP_TLS selects whether
>> the TLS handshake upcall should be compiled in.
>> The patch also adds reference counting to
>> struct nvmet_tcp_queue to ensure the queue is
>> always valid when the the TLS handshake completes.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/target/Kconfig    |  15 ++++
>>   drivers/nvme/target/configfs.c |  21 +++++
>>   drivers/nvme/target/nvmet.h    |   1 +
>>   drivers/nvme/target/tcp.c      | 145 ++++++++++++++++++++++++++++++++-
>>   4 files changed, 178 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
>> index 79fc64035ee3..c56cb1005327 100644
>> --- a/drivers/nvme/target/Kconfig
>> +++ b/drivers/nvme/target/Kconfig
>> @@ -84,6 +84,21 @@ config NVME_TARGET_TCP
>>         If unsure, say N.
>> +config NVME_TARGET_TCP_TLS
>> +    bool "NVMe over Fabrics TCP target TLS encryption support"
>> +    depends on NVME_TARGET_TCP
>> +    select NVME_COMMON
>> +    select NVME_KEYRING
>> +    select NET_HANDSHAKE
>> +    select KEYS
>> +    help
>> +      Enables TLS encryption for the NVMe TCP target using the 
>> netlink handshake API.
>> +
>> +      The TLS handshake daemon is available at
>> +      https://github.com/oracle/ktls-utils.
>> +
>> +      If unsure, say N.
>> +
>>   config NVME_TARGET_AUTH
>>       bool "NVMe over Fabrics In-band Authentication support"
>>       depends on NVME_TARGET
>> diff --git a/drivers/nvme/target/configfs.c 
>> b/drivers/nvme/target/configfs.c
>> index 483569c3f622..b780ce049163 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -15,6 +15,7 @@
>>   #ifdef CONFIG_NVME_TARGET_AUTH
>>   #include <linux/nvme-auth.h>
>>   #endif
>> +#include <linux/nvme-keyring.h>
>>   #include <crypto/hash.h>
>>   #include <crypto/kpp.h>
>> @@ -396,6 +397,17 @@ static ssize_t nvmet_addr_tsas_store(struct 
>> config_item *item,
>>       return -EINVAL;
>>   found:
>> +    if (sectype == NVMF_TCP_SECTYPE_TLS13) {
>> +        if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS)) {
>> +            pr_err("TLS is not supported\n");
>> +            return -EINVAL;
>> +        }
>> +        if (!port->keyring) {
>> +            pr_err("TLS keyring not configured\n");
>> +            return -EINVAL;
>> +        }
>> +    }
>> +
>>       nvmet_port_init_tsas_tcp(port, sectype);
>>       /*
>>        * The TLS implementation currently does not support
>> @@ -1814,6 +1826,7 @@ static void nvmet_port_release(struct 
>> config_item *item)
>>       flush_workqueue(nvmet_wq);
>>       list_del(&port->global_entry);
>> +    key_put(port->keyring);
>>       kfree(port->ana_state);
>>       kfree(port);
>>   }
>> @@ -1863,6 +1876,14 @@ static struct config_group 
>> *nvmet_ports_make(struct config_group *group,
>>           return ERR_PTR(-ENOMEM);
>>       }
>> +    if (nvme_keyring_id()) {
>> +        port->keyring = key_lookup(nvme_keyring_id());
>> +        if (IS_ERR(port->keyring)) {
>> +            pr_warn("NVMe keyring not available, disabling TLS\n");
>> +            port->keyring = NULL;
>> +        }
>> +    }
>> +
>>       for (i = 1; i <= NVMET_MAX_ANAGRPS; i++) {
>>           if (i == NVMET_DEFAULT_ANA_GRPID)
>>               port->ana_state[1] = NVME_ANA_OPTIMIZED;
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index 87da62e4b743..e35a03260f45 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -158,6 +158,7 @@ struct nvmet_port {
>>       struct config_group        ana_groups_group;
>>       struct nvmet_ana_group        ana_default_group;
>>       enum nvme_ana_state        *ana_state;
>> +    struct key            *keyring;
>>       void                *priv;
>>       bool                enabled;
>>       int                inline_data_size;
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index f19ea9d923fd..3e447593ea72 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -8,9 +8,13 @@
>>   #include <linux/init.h>
>>   #include <linux/slab.h>
>>   #include <linux/err.h>
>> +#include <linux/key.h>
>>   #include <linux/nvme-tcp.h>
>> +#include <linux/nvme-keyring.h>
>>   #include <net/sock.h>
>>   #include <net/tcp.h>
>> +#include <net/tls.h>
>> +#include <net/handshake.h>
>>   #include <linux/inet.h>
>>   #include <linux/llist.h>
>>   #include <crypto/hash.h>
>> @@ -66,6 +70,16 @@ device_param_cb(idle_poll_period_usecs, 
>> &set_param_ops,
>>   MODULE_PARM_DESC(idle_poll_period_usecs,
>>           "nvmet tcp io_work poll till idle time period in usecs: 
>> Default 0");
>> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
>> +/*
>> + * TLS handshake timeout
>> + */
>> +static int tls_handshake_timeout = 10;
>> +module_param(tls_handshake_timeout, int, 0644);
>> +MODULE_PARM_DESC(tls_handshake_timeout,
>> +         "nvme TLS handshake timeout in seconds (default 10)");
>> +#endif
>> +
>>   #define NVMET_TCP_RECV_BUDGET        8
>>   #define NVMET_TCP_SEND_BUDGET        8
>>   #define NVMET_TCP_IO_WORK_BUDGET    64
>> @@ -122,6 +136,7 @@ struct nvmet_tcp_cmd {
>>   enum nvmet_tcp_queue_state {
>>       NVMET_TCP_Q_CONNECTING,
>> +    NVMET_TCP_Q_TLS_HANDSHAKE,
>>       NVMET_TCP_Q_LIVE,
>>       NVMET_TCP_Q_DISCONNECTING,
>>   };
>> @@ -132,6 +147,7 @@ struct nvmet_tcp_queue {
>>       struct work_struct    io_work;
>>       struct nvmet_cq        nvme_cq;
>>       struct nvmet_sq        nvme_sq;
>> +    struct kref        kref;
>>       /* send state */
>>       struct nvmet_tcp_cmd    *cmds;
>> @@ -155,6 +171,10 @@ struct nvmet_tcp_queue {
>>       struct ahash_request    *snd_hash;
>>       struct ahash_request    *rcv_hash;
>> +    /* TLS state */
>> +    key_serial_t        tls_pskid;
>> +    struct delayed_work    tls_handshake_tmo_work;
>> +
>>       unsigned long           poll_end;
>>       spinlock_t        state_lock;
>> @@ -1283,12 +1303,26 @@ static int nvmet_tcp_try_recv(struct 
>> nvmet_tcp_queue *queue,
>>       return ret;
>>   }
>> +static void nvmet_tcp_release_queue(struct kref *kref)
>> +{
>> +    struct nvmet_tcp_queue *queue =
>> +        container_of(kref, struct nvmet_tcp_queue, kref);
>> +
>> +    WARN_ON(queue->state != NVMET_TCP_Q_DISCONNECTING);
>> +    queue_work(nvmet_wq, &queue->release_work);
>> +}
>> +
>>   static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue 
>> *queue)
>>   {
>>       spin_lock_bh(&queue->state_lock);
>> +    if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
>> +        /* Socket closed during handshake */
>> +        tls_handshake_cancel(queue->sock->sk);
> 
> Can you call this under a spinlock?
I guess, but I'll check.

> I think you want the handshake cancel inside the release_work
> no?
> 
Rather not, as that will prolong the race window during which
the handshake can run in parallel to the kernel code.

>> +        queue->state = NVMET_TCP_Q_CONNECTING;
> 
> This state transition is weird.
> 
Yes. Thing is, we don't have a 'Q_CONNECTION_FAILED' state,
and hence I need to move to 'CONNECTING' even though the connection
is failed.
Hmm. Might be worth a shot to introduce 'Q_CONNECTION FAILED' ...

>> +    }
>>       if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
>>           queue->state = NVMET_TCP_Q_DISCONNECTING;
>> -        queue_work(nvmet_wq, &queue->release_work);
>> +        kref_put(&queue->kref, nvmet_tcp_release_queue);
> 
> This change makes sense, but I think its the only one in this
> function.
> 
I do grant that the state transistions are not great.
Will be working on that.

>>       }
>>       spin_unlock_bh(&queue->state_lock);
>>   }
>> @@ -1485,6 +1519,7 @@ static void nvmet_tcp_release_queue_work(struct 
>> work_struct *w)
>>       mutex_unlock(&nvmet_tcp_queue_mutex);
>>       nvmet_tcp_restore_socket_callbacks(queue);
>> +    cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
>>       cancel_work_sync(&queue->io_work);
>>       /* stop accepting incoming data */
>>       queue->rcv_state = NVMET_TCP_RECV_ERR;
>> @@ -1512,8 +1547,13 @@ static void nvmet_tcp_data_ready(struct sock *sk)
>>       read_lock_bh(&sk->sk_callback_lock);
>>       queue = sk->sk_user_data;
>> -    if (likely(queue))
>> -        queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
>> +    if (likely(queue)) {
>> +        if (queue->data_ready)
>> +            queue->data_ready(sk);
>> +        if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
>> +            queue_work_on(queue_cpu(queue), nvmet_tcp_wq,
>> +                      &queue->io_work);
>> +    }
>>       read_unlock_bh(&sk->sk_callback_lock);
>>   }
>> @@ -1621,6 +1661,79 @@ static int nvmet_tcp_set_queue_sock(struct 
>> nvmet_tcp_queue *queue)
>>       return ret;
>>   }
>> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
>> +static void nvmet_tcp_tls_handshake_done(void *data, int status,
>> +                     key_serial_t peerid)
>> +{
>> +    struct nvmet_tcp_queue *queue = data;
>> +
>> +    pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
>> +         queue->idx, peerid, status);
>> +    spin_lock_bh(&queue->state_lock);
>> +    WARN_ON(queue->state != NVMET_TCP_Q_TLS_HANDSHAKE);
> 
> If this happens, you probably need to return without doing anything
> else...
> 
Okay.

>> +    if (!status)
>> +        queue->tls_pskid = peerid;
>> +    queue->state = NVMET_TCP_Q_CONNECTING;
>> +    spin_unlock_bh(&queue->state_lock);
>> +
>> +    cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
>> +    if (status)
>> +        nvmet_tcp_schedule_release_queue(queue);
>> +    else
>> +        nvmet_tcp_set_queue_sock(queue);
>> +    kref_put(&queue->kref, nvmet_tcp_release_queue);
>> +}
>> +
>> +static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
>> +{
>> +    struct nvmet_tcp_queue *queue = container_of(to_delayed_work(w),
>> +            struct nvmet_tcp_queue, tls_handshake_tmo_work);
>> +
>> +    pr_warn("queue %d: TLS handshake timeout\n", queue->idx);
>> +    /*
>> +     * If tls_handshake_cancel() fails we've lost the race with
>> +     * nvmet_tcp_tls_handshake_done() */
>> +    if (!tls_handshake_cancel(queue->sock->sk))
>> +        return;
>> +    spin_lock_bh(&queue->state_lock);
>> +    WARN_ON(queue->state != NVMET_TCP_Q_TLS_HANDSHAKE);
>> +    queue->state = NVMET_TCP_Q_CONNECTING;
> 
> This state change is very weird, why?
> 
See above; currently we only have the state transition
connecting -> handshake -> connecting

Will need to introduce a 'failed' state here.

>> +    spin_unlock_bh(&queue->state_lock);
>> +    nvmet_tcp_schedule_release_queue(queue);
>> +    kref_put(&queue->kref, nvmet_tcp_release_queue);
>> +}
>> +
>> +static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
>> +{
>> +    int ret = -EOPNOTSUPP;
>> +    struct tls_handshake_args args;
>> +
>> +    if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
>> +        pr_warn("cannot start TLS in state %d\n", queue->state);
>> +        return -EINVAL;
>> +    }
>> +
>> +    kref_get(&queue->kref);
>> +    pr_debug("queue %d: TLS ServerHello\n", queue->idx);
>> +    memset(&args, 0, sizeof(args));
>> +    args.ta_sock = queue->sock;
>> +    args.ta_done = nvmet_tcp_tls_handshake_done;
>> +    args.ta_data = queue;
>> +    args.ta_keyring = key_serial(queue->port->nport->keyring);
>> +    args.ta_timeout_ms = tls_handshake_timeout * 1000;
>> +
>> +    ret = tls_server_hello_psk(&args, GFP_KERNEL);
>> +    if (ret) {
>> +        kref_put(&queue->kref, nvmet_tcp_release_queue);
>> +        pr_err("failed to start TLS, err=%d\n", ret);
>> +    } else {
>> +        queue_delayed_work(nvmet_wq, &queue->tls_handshake_tmo_work,
>> +                   tls_handshake_timeout * HZ);
>> +    }
>> +    return ret;
>> +}
>> +#endif
>> +
>>   static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>>           struct socket *newsock)
>>   {
>> @@ -1636,11 +1749,16 @@ static void nvmet_tcp_alloc_queue(struct 
>> nvmet_tcp_port *port,
>>       INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
>>       INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
>> +    kref_init(&queue->kref);
>>       queue->sock = newsock;
>>       queue->port = port;
>>       queue->nr_cmds = 0;
>>       spin_lock_init(&queue->state_lock);
>> -    queue->state = NVMET_TCP_Q_CONNECTING;
>> +    if (queue->port->nport->disc_addr.tsas.tcp.sectype ==
>> +        NVMF_TCP_SECTYPE_TLS13)
>> +        queue->state = NVMET_TCP_Q_TLS_HANDSHAKE;
>> +    else
>> +        queue->state = NVMET_TCP_Q_CONNECTING;
>>       INIT_LIST_HEAD(&queue->free_list);
>>       init_llist_head(&queue->resp_list);
>>       INIT_LIST_HEAD(&queue->resp_send_list);
>> @@ -1671,6 +1789,25 @@ static void nvmet_tcp_alloc_queue(struct 
>> nvmet_tcp_port *port,
>>       list_add_tail(&queue->queue_list, &nvmet_tcp_queue_list);
>>       mutex_unlock(&nvmet_tcp_queue_mutex);
>> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
>> +    INIT_DELAYED_WORK(&queue->tls_handshake_tmo_work,
>> +              nvmet_tcp_tls_handshake_timeout);
>> +    if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
>> +        struct sock *sk = queue->sock->sk;
>> +
>> +        /* Restore the default callbacks before starting upcall */
>> +        read_lock_bh(&sk->sk_callback_lock);
>> +        sk->sk_user_data = NULL;
>> +        sk->sk_data_ready = port->data_ready;
>> +        read_unlock_bh(&sk->sk_callback_lock);
>> +        if (!nvmet_tcp_tls_handshake(queue))
>> +            return;
>> +
>> +        /* TLS handshake failed, terminate the connection */
>> +        goto out_destroy_sq;
>> +    }
>> +#endif
>> +
>>       ret = nvmet_tcp_set_queue_sock(queue);
>>       if (ret)
>>           goto out_destroy_sq;

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


