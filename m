Return-Path: <netdev+bounces-285155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFHcNGwv/GmNMgAAu9opvQ
	(envelope-from <netdev+bounces-285155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 08:21:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 541634E3606
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 08:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0D183017539
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 06:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED0B3254A8;
	Thu,  7 May 2026 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="IS6LkxaL"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D96031A06C;
	Thu,  7 May 2026 06:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778134890; cv=none; b=LhahVKFEx34v36FG1uwqQVcMPo1xVfyl3FfVI4mVMEkWLOpuRRsDYTRSgpu1lgfmXkt+lnaefPTsvZfeRJAwFY+q/QofWhAA1V2vGnyg8ZztePVNnZ0ffy/nFUmlS1LV/FF4jHden2h/9ogmC5SwwPxf21MoVO333I5jXVmoEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778134890; c=relaxed/simple;
	bh=bAfRx8MTP4otvqLdq24l/rWBQ+12/mrECjVG4Qcyxy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvYi3jlNvkP+jsNakAS4NL99ymVSsG11RV2NHuLXVslwwyDmwndAc61h/8QYwnyDMPmngCKC2Hmw91AUQSdPv0iT6uMggfVqv0aX7O3tY/HviWekUgy+4NENjNOorgvYzv4F52EKOHu/ZrMPeidoywSCUGnOUNQfE2QgpfyNkJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=IS6LkxaL; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1778134875;
	bh=bAfRx8MTP4otvqLdq24l/rWBQ+12/mrECjVG4Qcyxy4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IS6LkxaL9dUFmma2OMHGlnWRRRRbJPORdRGQDZS5ZQx3KgJ8BkWGXxmuZ9hcLTKy5
	 q/kBtemCpgmkfh/+a7jiBAkOqReyVTgrMKnI1Ca05ST2b/v2eWydaorxcLLB/sM6e1
	 sUyG2zzhNMj60z74+50gBNXVKgKAWumm+E+Jb++w=
Received: from [129.217.186.46] ([129.217.186.46])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 6476LEwj008340
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 7 May 2026 08:21:14 +0200 (CEST)
Message-ID: <98090610-e389-4b4f-b1a9-6dceadedd372@tu-dortmund.de>
Date: Thu, 7 May 2026 08:21:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 1/4] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
        leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
        tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
References: <20260506141033.180450-1-simon.schippers@tu-dortmund.de>
 <20260506141033.180450-2-simon.schippers@tu-dortmund.de>
 <20260506181556-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260506181556-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 541634E3606
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285155-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tu-dortmund.de:email,tu-dortmund.de:mid,tu-dortmund.de:dkim]
X-Rspamd-Action: no action

On 5/7/26 00:18, Michael S. Tsirkin wrote:
> On Wed, May 06, 2026 at 04:10:30PM +0200, Simon Schippers wrote:
>> Introduce tun_ring_consume() that wraps ptr_ring_consume() and calls
>> __tun_wake_queue(). The latter wakes the stopped netdev subqueue once
>> half of the ring capacity has been consumed, tracked via the new
>> cons_cnt field in tun_file. cons_cnt is updated while holding the ring
>> consumer lock, avoiding races. As a safety net, the queue is also woken
>> when the ring becomes empty. The point is to allow the queue to be
>> stopped when it gets full, which is required for traffic shaping -
>> implemented by the following "avoid ptr_ring tail-drop when a qdisc
>> is present". That patch also explains the pairing of the smp_mb()
>> of __tun_wake_queue().
>>
>> Without the corresponding queue stopping, this patch alone causes no
>> regression for a tap setup sending to a qemu VM: 1.132 Mpps
>> to 1.144 Mpps.
>>
>> Details: AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU
>> threads, pktgen sender; Avg over 50 runs @ 100,000,000 packets;
>> SRSO and spectre v2 mitigations disabled.
>>
>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>> ---
>>  drivers/net/tun.c | 54 +++++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 50 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index b183189f1853..00ecf128fe8e 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -145,6 +145,7 @@ struct tun_file {
>>  	struct list_head next;
>>  	struct tun_struct *detached;
>>  	struct ptr_ring tx_ring;
>> +	int cons_cnt;
>>  	struct xdp_rxq_info xdp_rxq;
>>  };
>>  
>> @@ -557,6 +558,13 @@ void tun_ptr_free(void *ptr)
>>  }
>>  EXPORT_SYMBOL_GPL(tun_ptr_free);
>>  
>> +static void tun_reset_cons_cnt(struct tun_file *tfile)
>> +{
>> +	spin_lock(&tfile->tx_ring.consumer_lock);
>> +	tfile->cons_cnt = 0;
>> +	spin_unlock(&tfile->tx_ring.consumer_lock);
>> +}
>> +
>>  static void tun_queue_purge(struct tun_file *tfile)
>>  {
>>  	void *ptr;
>> @@ -564,6 +572,7 @@ static void tun_queue_purge(struct tun_file *tfile)
>>  	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
>>  		tun_ptr_free(ptr);
>>  
>> +	tun_reset_cons_cnt(tfile);
>>  	skb_queue_purge(&tfile->sk.sk_write_queue);
>>  	skb_queue_purge(&tfile->sk.sk_error_queue);
>>  }
>> @@ -730,6 +739,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>>  		goto out;
>>  	}
>>  
>> +	tun_reset_cons_cnt(tfile);
>>  	tfile->queue_index = tun->numqueues;
>>  	tfile->socket.sk->sk_shutdown &= ~RCV_SHUTDOWN;
>>  
>> @@ -2115,13 +2125,46 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>>  	return total;
>>  }
>>  
>> -static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
>> +/* Callers must hold ring.consumer_lock */
>> +static void __tun_wake_queue(struct tun_struct *tun,
>> +			     struct tun_file *tfile, int consumed)
>> +{
>> +	struct netdev_queue *txq = netdev_get_tx_queue(tun->dev,
>> +						tfile->queue_index);
>> +
>> +	/* Paired with smp_mb__after_atomic() in tun_net_xmit() */
>> +	smp_mb();
>> +	if (netif_tx_queue_stopped(txq)) {
>> +		tfile->cons_cnt += consumed;
>> +		if (tfile->cons_cnt >= tfile->tx_ring.size / 2 ||
>> +		    __ptr_ring_empty(&tfile->tx_ring)) {
>> +			netif_tx_wake_queue(txq);
>> +			tfile->cons_cnt = 0;
>> +		}
>> +	}
>> +}
>> +
>> +static void *tun_ring_consume(struct tun_struct *tun, struct tun_file *tfile)
>> +{
>> +	void *ptr;
>> +
>> +	spin_lock(&tfile->tx_ring.consumer_lock);
>> +	ptr = __ptr_ring_consume(&tfile->tx_ring);
>> +	if (ptr)
>> +		__tun_wake_queue(tun, tfile, 1);
>> +
>> +	spin_unlock(&tfile->tx_ring.consumer_lock);
>> +	return ptr;
>> +}
>> +
>> +static void *tun_ring_recv(struct tun_struct *tun, struct tun_file *tfile,
>> +			   int noblock, int *err)
>>  {
>>  	DECLARE_WAITQUEUE(wait, current);
>>  	void *ptr = NULL;
>>  	int error = 0;
>>  
>> -	ptr = ptr_ring_consume(&tfile->tx_ring);
>> +	ptr = tun_ring_consume(tun, tfile);
>>  	if (ptr)
>>  		goto out;
>>  	if (noblock) {
>> @@ -2133,7 +2176,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
>>  
>>  	while (1) {
>>  		set_current_state(TASK_INTERRUPTIBLE);
>> -		ptr = ptr_ring_consume(&tfile->tx_ring);
>> +		ptr = tun_ring_consume(tun, tfile);
>>  		if (ptr)
>>  			break;
>>  		if (signal_pending(current)) {
> 
> 
> So based on commit log I expected all calls to ptr_ring_consume to
> be replaced with tun_ring_consume, but it looks like tun_queue_purge
> still calls ptr_ring_consume.
> I suspect that together with patch 4 it can sometimes leave us stuck
> with a stopped queue and an empty ring, forever.
> 

I see. I will replace ptr_ring_consume() with tun_ring_consume().

> 
> 
> 
> 
>> @@ -2170,7 +2213,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
>>  
>>  	if (!ptr) {
>>  		/* Read frames from ring */
>> -		ptr = tun_ring_recv(tfile, noblock, &err);
>> +		ptr = tun_ring_recv(tun, tfile, noblock, &err);
>>  		if (!ptr)
>>  			return err;
>>  	}
>> @@ -3406,6 +3449,8 @@ static int tun_chr_open(struct inode *inode, struct file * file)
>>  		return -ENOMEM;
>>  	}
>>  
>> +	tun_reset_cons_cnt(tfile);
>> +
>>  	mutex_init(&tfile->napi_mutex);
>>  	RCU_INIT_POINTER(tfile->tun, NULL);
>>  	tfile->flags = 0;
>> @@ -3614,6 +3659,7 @@ static int tun_queue_resize(struct tun_struct *tun)
>>  	for (i = 0; i < tun->numqueues; i++) {
>>  		tfile = rtnl_dereference(tun->tfiles[i]);
>>  		rings[i] = &tfile->tx_ring;
>> +		tun_reset_cons_cnt(tfile);
>>  	}
>>  	list_for_each_entry(tfile, &tun->disabled, next)
>>  		rings[i++] = &tfile->tx_ring;
>> -- 
>> 2.43.0
> 

