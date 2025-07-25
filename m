Return-Path: <netdev+bounces-210009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2A3B11E69
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 14:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360121703AC
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 12:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED2E243364;
	Fri, 25 Jul 2025 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJXfQzNT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CB823F405
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446214; cv=none; b=DrcTsXGVZqmEWf0IxlGzMo7oZdoTP0UHJTuFW4TGqus4VDroUv0q4s0O5Xpnl2zfRAQAVFqclXfXqV0Y0u7TbRkNq8yP/w0SlnyyKezJTyhDwoUy27Eqhc1S7nBBQ0UpXaOxA8wohi4+6+nuetUlaqnE3p+F8I5NDgM5UXe2tQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446214; c=relaxed/simple;
	bh=jvCtt4R18tjLNbRTUQm9+GSfCS59sAgzXb9yEqGGJkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqU+tS5f+fi/YtYeS7TdMciY2qagelmirtH28zQ0LCmZaCG+2mZTW72wqkX5CuuG/1Ntzy3dWNQgUBvcYaDK9DZt9/edRK6+FN5ho9tgu3W61pLcAVHt0VRvscfYMC+Jx5dUg3fZAMtgVO/FA39J1ZNSkQ7pHGBC7PQJwc5Rbfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJXfQzNT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753446211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oE2sFN7go6Vy2a4QIRBJZ6B2jfXbEMiT0hznx8PJc5s=;
	b=UJXfQzNTuKYj2tj3HpjghltNdOHMFVJkxWhqlT5CeXSzj7IJpVD5PifyLgti5UEEE8v21x
	jWUViNLJSN3/pbSi/nBKU7S29cABv4KPPS5VB+pYBrFE1V6PHBMt+L0Na0919EF/RYeAg7
	Q5qZpraeNV0OxWGedITuD0oiB/bjh5g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-FJMS1PELMSalp7eK1NZzLQ-1; Fri, 25 Jul 2025 08:23:30 -0400
X-MC-Unique: FJMS1PELMSalp7eK1NZzLQ-1
X-Mimecast-MFC-AGG-ID: FJMS1PELMSalp7eK1NZzLQ_1753446209
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45639e6a320so11613465e9.3
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 05:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753446209; x=1754051009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oE2sFN7go6Vy2a4QIRBJZ6B2jfXbEMiT0hznx8PJc5s=;
        b=gxeHMvlanV9dlOG8CzCbP9j29uVhaXGQXC4rW4X/P7/wX3C/nklro1WT/gfb+xaH7a
         if0Zb2zpYZFKuAFD2YSA/GBNP3auJ1pzStKwtu4NOTOreJx31GZZAmWaayWKU3+1QN5+
         5mA4XnNfLT4jcxdGC7oF8XOft4M5x5wUMktVW7D92BJ2oy8YsIDYJbt12PZZ89OB0hab
         OMbmOa3SHcxFfBNq8nwGVMunBrfANG/YIJZrW59/UXU+iUQpv/I4Kfcc7bYSBNbzW8MG
         tY+a1KqM1KrdrasNBLzxyDOD1zMw3k3VXvq/++06lPQWixw+6zV5Z8qJ/oqvB0uWB14u
         s9RA==
X-Gm-Message-State: AOJu0Ywr65BrmHsyAu2hiSEJW8zOv62BcAis9Aif1CnxatUbSPcfmwFL
	D4kl/yOhRasplFJwUzSG4sinwFPnITgRu8FQ4a9G0DvjRN1162b/ggzcdBkwg6EKYjWBNGmj/oq
	su/HHFbN5KXRx4H5uvYgJkYoBGzfSJzAup+56iiSj14TQqEsOrABtd9WZNA==
X-Gm-Gg: ASbGnculCkxrldjBuVhzdmi1aFiuGPT3LhnhlZlKEAmAqB2DmYYXnMH2nbNsM9jEBro
	0pduxZ10KXXIam/4Ouns2FeQPcY/qIYuSaLGRlp9FHcYU8cMLCz3lYqvC3KxbdWXhFMPEKcMhSO
	XW+g8PNFCEFT3ZqM8Vr1b8Bx/fyYoal4TaOG0lIWNgQf9px/3ZWplogL7UnClBpIgQfzVfOdJM2
	H1AUzythdWz5dueOn2XhajEaDf9RJ9boyZGAvAof6ScJSPBNnjSo37RDy7Rfgm4BVFgNWombdEh
	TXZEePKxORmbkzzhSIDpkYiryF29o9tMbwDKA3FyxixAmDvlT8abdDj/YJcpGjvdXWkjCd6Nujk
	Js+3qcU5Rx2Y=
X-Received: by 2002:a05:600c:3b19:b0:442:dc6f:2f11 with SMTP id 5b1f17b1804b1-4587654e312mr16354015e9.25.1753446209078;
        Fri, 25 Jul 2025 05:23:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8ENmNYoPN7Z3gkcm2yH8f9BkTobgJbMkC4b4AYupd8QzMA28FL8N2WqdWjd0IoiEJg7qakg==
X-Received: by 2002:a05:600c:3b19:b0:442:dc6f:2f11 with SMTP id 5b1f17b1804b1-4587654e312mr16353635e9.25.1753446208543;
        Fri, 25 Jul 2025 05:23:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705bcbe8sm55213915e9.17.2025.07.25.05.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 05:23:27 -0700 (PDT)
Message-ID: <837ee1c6-a7c8-490b-84ae-6c24fdd48e4e@redhat.com>
Date: Fri, 25 Jul 2025 14:23:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netpoll: prevent hanging NAPI when netcons gets
 enabled
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, Jason Wang <jasowang@redhat.com>,
 Zigit Zo <zuozhijie@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, leitao@debian.org, sdf@fomichev.me
References: <20250725024454.690517-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250725024454.690517-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/25/25 4:44 AM, Jakub Kicinski wrote:
> Paolo spotted hangs in NIPA running driver tests against virtio.
> The tests hang in virtnet_close() -> virtnet_napi_tx_disable().
> 
> The problem is only reproducible if running multiple of our tests
> in sequence (I used TEST_PROGS="xdp.py ping.py netcons_basic.sh \
> netpoll_basic.py stats.py"). Initial suspicion was that this is
> a simple case of double-disable of NAPI, but instrumenting the
> code reveals:
> 
>  Deadlocked on NAPI ffff888007cd82c0 (virtnet_poll_tx):
>    state: 0x37, disabled: false, owner: 0, listed: false, weight: 64
> 
> The NAPI was not in fact disabled, owner is 0 (rather than -1),
> so the NAPI "thinks" it's scheduled for CPU 0 but it's not listed
> (!list_empty(&n->poll_list)). It seems odd that normal NAPI
> processing would wedge itself like this.
> 
> My suspicion is that netpoll gets enabled while NAPI is polling,
> and also grab the NAPI instance. This confuses napi_complete_done():
> 
>   [netpoll]                                   [normal NAPI]
>                                         napi_poll()
>                                           have = netpoll_poll_lock()
>                                             rcu_access_pointer(dev->npinfo)
>                                               return NULL # no netpoll
>                                           __napi_poll()
> 					    ->poll(->weight)
>   poll_napi()
>     cmpxchg(->poll_owner, -1, cpu)
>       poll_one_napi()
>         set_bit(NAPI_STATE_NPSVC, ->state)
>                                               napi_complete_done()
>                                                 if (NAPIF_STATE_NPSVC)
>                                                   return false
>                                            # exit without clearing SCHED
> 
> This seems very unlikely, but perhaps virtio has some interactions
> with the hypervisor in the NAPI -> poll that makes the race window
> large?
> 
> Best I could to to prove the theory was to add and trigger this
> warning in napi_poll (just before netpoll_poll_unlock()):
> 
>       WARN_ONCE(!have && rcu_access_pointer(n->dev->npinfo) &&
>                 napi_is_scheduled(n) && list_empty(&n->poll_list),
>                 "NAPI race with netpoll %px", n);
> 
> If this warning hits the next virtio_close() will hang.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Link: https://lore.kernel.org/c5a93ed1-9abe-4880-a3bb-8d1678018b1d@redhat.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

It's not clear to me if you have been able to validate the patch into
NIPA already?


> ---
> Looks like this is not a new bug, rather Breno's tests now put
> enough pressure on netpoll + virtio to trigger it.
> 
> CC: Jason Wang <jasowang@redhat.com>
> CC: Zigit Zo <zuozhijie@bytedance.com>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> CC: Eugenio Pérez <eperezma@redhat.com>
> 
> CC: leitao@debian.org
> CC: sdf@fomichev.me
> ---
>  drivers/net/netconsole.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index e3722de08ea9..9bc748ff5752 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -256,6 +256,24 @@ static struct netconsole_target *alloc_and_init(void)
>  	return nt;
>  }
>  
> +static int netconsole_setup_and_enable(struct netconsole_target *nt)
> +{
> +	int ret;
> +
> +	ret = netpoll_setup(&nt->np);
> +	if (ret)
> +		return ret;
> +
> +	/* Make sure all NAPI polls which started before dev->npinfo
> +	 * was visible have exited before we start calling NAPI poll.
> +	 * NAPI skips locking if dev->npinfo is NULL.
> +	 */
> +	synchronize_rcu();

I'm wondering if it would make any sense to move the above in
netpoll_setup(), make the exposed symbol safe.

In any case, AFAICS this at very least addresses a real race.

Acked-by: Paolo Abeni <pabeni@redhat.com>


