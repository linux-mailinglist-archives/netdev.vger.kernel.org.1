Return-Path: <netdev+bounces-178577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C35A77A1A
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF78164F68
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9251FBC92;
	Tue,  1 Apr 2025 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GovLrEPw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4969476
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508379; cv=none; b=KpayUTZPtEPNjUZkYfifAV1cMNOwApgo0hUKlKdxW/WZt9AEC13il5290+PuNDm5rTcPLtkA5D1OBrOjkWUI4joHC9eXZ2UjrGXolKm5MKHrc452KKjws8bII+pFdg+Jpcb7n/8fOImjqSZL4IgBiU4H3GvzT5WFva3fz9LaeJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508379; c=relaxed/simple;
	bh=20Pgp79nL82axSyJe+vfX4v3UQ7qyPuScvWjFFoN0IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkNXWBQYy4RnbsN5auOUtag9jGH4BB5FYdE4Rm2LeQH1fRt2SbfMt2H4A90xrGLeY+6Qan04PKbi4A6rIqdGjhyKSXYmtWODgT5fAcftm095wbqQgJdgnCvWtuGcIC6W91nlYpeUXsFEbamd8ENcsUZB9/Aal8MD7mznJD+6ai4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GovLrEPw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743508376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkH9MDM8OgZyTlbT0rSNsiuPV2xBPqaeIED0uLLAzGU=;
	b=GovLrEPwm/wS+xDUxEXfmu8UcgZntfMO86tvgDcmo3tBsZroz+gXdpP/gHmkGfZOFTagXK
	agzYRPVu9LN7waK2IlpUyk26yjE8TWm53lPSnBbQQ/JwFh98KidQi+oWbLZr/ofjdr6aEv
	nTW2fPrKKk7UWAskQaGz5FzjDpN5zQQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-dTpOn4lQMnuMsLzzxpcVBQ-1; Tue, 01 Apr 2025 07:52:55 -0400
X-MC-Unique: dTpOn4lQMnuMsLzzxpcVBQ-1
X-Mimecast-MFC-AGG-ID: dTpOn4lQMnuMsLzzxpcVBQ_1743508374
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3913aaf1e32so3149341f8f.0
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 04:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743508374; x=1744113174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkH9MDM8OgZyTlbT0rSNsiuPV2xBPqaeIED0uLLAzGU=;
        b=LpOe4M4Aj0T9DJeoGQ1f15T2DGc0yNJgiw9d5NsDXOmmAumBaIVNSM6OCNy9qD//B8
         hctoNyny79Atj/x4Sk4r/OvaPk41f4+gP+F+w0BX3DHlNSYEwKEOnYNDt/gaY4riCPad
         OIPxfkH/Dv86K0QA1SFm4Cf1iUMJPc+SlIn51Xe6sj3kJtfqgjnxL0AbIwsLjXgJPciR
         fgCqVembS+DEucSM9hSMXaHlYckEmJwtWBgG8fI5spmClp78UzYt/b77YrgMVc7LMD1Q
         VsAfmgbfhfo/N3eBn/8jmQRJFseNYCXPsUAvVJ6AewdaK/Lxq7gvkQKfDObvautGqH2q
         pf8g==
X-Forwarded-Encrypted: i=1; AJvYcCUzqeEoh/Aug2eU+vtxfJb0EVW0SWU2QdpSCIispvx7569K7vgSHPXnD4UlAq3oEL7HxmB/4Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPrv8iRGAk7b9uLoOJmv7bqfjVUTMfgBsjGMVsWzKWe24fZlWJ
	EORVCKkfczg/EI0BfVBRSmJZ0eKy6avyWzuUzh+QzUK9jhRj5T7Bpo+axh9qxl+NdQDVILgR7Bp
	waYMzo5Fei3uXNbLmfkj9C1w5WcNuNM/7vEGvdlkXmVkuvuU2hunkDr65E/edLQ==
X-Gm-Gg: ASbGncswnrlrqaoHIGYjk0WHq1rORuRn8xv5BesjmO3MJaL4FW5cmjWGd8LHtl1LEsl
	ij540mJldQd3NyBJQeYbCoZ+Uc2MuneJ64tkFhvYW3D7BJ5E8GIyBNteFdWqnstNaVVMGnmZ1+7
	Xxqev+pjJ7z/R39tbypIk6IM6C9AqPrw5TxnwzolLHXURRnBwwvkrQMEsWgz2z1Wcq2EpMcXUgX
	GltJ3BqbdTSbppcGEBoqaUnNUiK1/0seOmJShGvwYTfYsHaNg7+3x1Y35UOCsBLC7TbC9/xOkoS
	3mNUoiPA86du5SGOJYVU6cguPjOz2BNQqa8mlcWIpYg4Rw==
X-Received: by 2002:a05:6000:4203:b0:38f:2ddd:a1bb with SMTP id ffacd0b85a97d-39c120c8e66mr10278910f8f.8.1743508373871;
        Tue, 01 Apr 2025 04:52:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVyFMvMMFyiAxtgXRX3AjletpHTEVLtTxo7DaN41Y9GMmZ+nYfrUoc4eH5cPS4yTs3hMsIfw==
X-Received: by 2002:a05:6000:4203:b0:38f:2ddd:a1bb with SMTP id ffacd0b85a97d-39c120c8e66mr10278895f8f.8.1743508373446;
        Tue, 01 Apr 2025 04:52:53 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e311sm14029473f8f.78.2025.04.01.04.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 04:52:53 -0700 (PDT)
Message-ID: <9d90b5e4-bd6d-4d78-a1c5-044621c06c96@redhat.com>
Date: Tue, 1 Apr 2025 13:52:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ibmveth: make veth_pool_store stop hanging
To: davemarq@linux.ibm.com, netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Nick Child <nnac123@linux.ibm.com>
References: <20250331212328.109496-1-davemarq@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250331212328.109496-1-davemarq@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/25 11:23 PM, davemarq@linux.ibm.com wrote:
> From: Dave Marquardt <davemarq@linux.ibm.com>
> 
> Use rtnl_mutex to synchronize veth_pool_store with itself,
> ibmveth_close and ibmveth_open, preventing multiple calls in a row to
> napi_disable.
> 
> Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
> Fixes: 860f242eb534 ("[PATCH] ibmveth change buffer pools dynamically")
> Reviewed-by: Nick Child <nnac123@linux.ibm.com>
> ---
> In working on removing BUG_ON calls from ibmveth, I realized that 2
> threads could call veth_pool_store through writing to
> /sys/devices/vio/30000002/pool*/*. You can do this easily with a little
> shell script.
> 
> Running on a 6.14 kernel, I saw a hang:
> 
>     [  243.683282][  T108] INFO: task stress.sh:5829 blocked for more than 122 seconds.
>     [  243.683300][  T108]       Not tainted 6.14.0-01103-g2df0c02dab82 #3
>     [  243.683303][  T108] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>     [  366.563278][  T108] INFO: task stress.sh:5829 blocked for more than 245 seconds.
>     [  366.563297][  T108]       Not tainted 6.14.0-01103-g2df0c02dab82 #3
>     [  366.563301][  T108] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 
> I configured LOCKDEP, compiled ibmveth.c with DEBUG, and built a new
> kernel. I ran the test again and saw:
> 
>     Setting pool0/active to 0
>     Setting pool1/active to 1
>     [   73.911067][ T4365] ibmveth 30000002 eth0: close starting
>     Setting pool1/active to 1
>     Setting pool1/active to 0
>     [   73.911367][ T4366] ibmveth 30000002 eth0: close starting
>     [   73.916056][ T4365] ibmveth 30000002 eth0: close complete
>     [   73.916064][ T4365] ibmveth 30000002 eth0: open starting
>     [  110.808564][  T712] systemd-journald[712]: Sent WATCHDOG=1 notification.
>     [  230.808495][  T712] systemd-journald[712]: Sent WATCHDOG=1 notification.
>     [  243.683786][  T123] INFO: task stress.sh:4365 blocked for more than 122 seconds.
>     [  243.683827][  T123]       Not tainted 6.14.0-01103-g2df0c02dab82-dirty #8
>     [  243.683833][  T123] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>     [  243.683838][  T123] task:stress.sh       state:D stack:28096 pid:4365  tgid:4365  ppid:4364   task_flags:0x400040 flags:0x00042000
>     [  243.683852][  T123] Call Trace:
>     [  243.683857][  T123] [c00000000c38f690] [0000000000000001] 0x1 (unreliable)
>     [  243.683868][  T123] [c00000000c38f840] [c00000000001f908] __switch_to+0x318/0x4e0
>     [  243.683878][  T123] [c00000000c38f8a0] [c000000001549a70] __schedule+0x500/0x12a0
>     [  243.683888][  T123] [c00000000c38f9a0] [c00000000154a878] schedule+0x68/0x210
>     [  243.683896][  T123] [c00000000c38f9d0] [c00000000154ac80] schedule_preempt_disabled+0x30/0x50
>     [  243.683904][  T123] [c00000000c38fa00] [c00000000154dbb0] __mutex_lock+0x730/0x10f0
>     [  243.683913][  T123] [c00000000c38fb10] [c000000001154d40] napi_enable+0x30/0x60
>     [  243.683921][  T123] [c00000000c38fb40] [c000000000f4ae94] ibmveth_open+0x68/0x5dc
>     [  243.683928][  T123] [c00000000c38fbe0] [c000000000f4aa20] veth_pool_store+0x220/0x270
>     [  243.683936][  T123] [c00000000c38fc70] [c000000000826278] sysfs_kf_write+0x68/0xb0
>     [  243.683944][  T123] [c00000000c38fcb0] [c0000000008240b8] kernfs_fop_write_iter+0x198/0x2d0
>     [  243.683951][  T123] [c00000000c38fd00] [c00000000071b9ac] vfs_write+0x34c/0x650
>     [  243.683958][  T123] [c00000000c38fdc0] [c00000000071bea8] ksys_write+0x88/0x150
>     [  243.683966][  T123] [c00000000c38fe10] [c0000000000317f4] system_call_exception+0x124/0x340
>     [  243.683973][  T123] [c00000000c38fe50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
>     ...
>     [  243.684087][  T123] Showing all locks held in the system:
>     [  243.684095][  T123] 1 lock held by khungtaskd/123:
>     [  243.684099][  T123]  #0: c00000000278e370 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x50/0x248
>     [  243.684114][  T123] 4 locks held by stress.sh/4365:
>     [  243.684119][  T123]  #0: c00000003a4cd3f8 (sb_writers#3){.+.+}-{0:0}, at: ksys_write+0x88/0x150
>     [  243.684132][  T123]  #1: c000000041aea888 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x154/0x2d0
>     [  243.684143][  T123]  #2: c0000000366fb9a8 (kn->active#64){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x160/0x2d0
>     [  243.684155][  T123]  #3: c000000035ff4cb8 (&dev->lock){+.+.}-{3:3}, at: napi_enable+0x30/0x60
>     [  243.684166][  T123] 5 locks held by stress.sh/4366:
>     [  243.684170][  T123]  #0: c00000003a4cd3f8 (sb_writers#3){.+.+}-{0:0}, at: ksys_write+0x88/0x150
>     [  243.684183][  T123]  #1: c00000000aee2288 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x154/0x2d0
>     [  243.684194][  T123]  #2: c0000000366f4ba8 (kn->active#64){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x160/0x2d0
>     [  243.684205][  T123]  #3: c000000035ff4cb8 (&dev->lock){+.+.}-{3:3}, at: napi_disable+0x30/0x60
>     [  243.684216][  T123]  #4: c0000003ff9bbf18 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x138/0x12a0
> 
> From the ibmveth debug, two threads are calling veth_pool_store, which
> calls ibmveth_close and ibmveth_open. Here's the sequence:
> 
>   T4365             T4366             
>   ----------------- ----------------- ---------
>   veth_pool_store   veth_pool_store   
>                     ibmveth_close     
>   ibmveth_close                       
>   napi_disable                        
>                     napi_disable      
>   ibmveth_open                        
>   napi_enable                         <- HANG
> 
> ibmveth_close calls napi_disable at the top and ibmveth_open calls
> napi_enable at the top.
> 
> https://docs.kernel.org/networking/napi.html]] says
> 
>   The control APIs are not idempotent. Control API calls are safe
>   against concurrent use of datapath APIs but an incorrect sequence of
>   control API calls may result in crashes, deadlocks, or race
>   conditions. For example, calling napi_disable() multiple times in a
>   row will deadlock.
> 
> In the normal open and close paths, rtnl_mutex is acquired to prevent
> other callers. This is missing from veth_pool_store. Use rtnl_mutex in
> veth_pool_store fixes these hangs.

Some/most of the above should actually land into the commit message,
please rewrite it accordingly.

>  drivers/net/ethernet/ibm/ibmveth.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index b619a3ec245b..77ef19a53e72 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1802,18 +1802,24 @@ static ssize_t veth_pool_store(struct kobject *kobj, struct attribute *attr,
>  	long value = simple_strtol(buf, NULL, 10);
>  	long rc;
>  
> +	rtnl_lock();
> +
>  	if (attr == &veth_active_attr) {
>  		if (value && !pool->active) {
>  			if (netif_running(netdev)) {
>  				if (ibmveth_alloc_buffer_pool(pool)) {
>  					netdev_err(netdev,
>  						   "unable to alloc pool\n");
> +					rtnl_unlock();
>  					return -ENOMEM;
>  				}
>  				pool->active = 1;
>  				ibmveth_close(netdev);
> -				if ((rc = ibmveth_open(netdev)))
> +				rc = ibmveth_open(netdev);
> +				if (rc) {
> +					rtnl_unlock();
>  					return rc;

If you avoid a bit of duplicate code with
					goto unlock_err;

// at the end of the function
unlock_err:
	rtnl_unlock();
	return rc;


Cheers,

Paolo


