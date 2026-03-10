Return-Path: <netdev+bounces-265927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPUwMJrYr2kLdAIAu9opvQ
	(envelope-from <netdev+bounces-265927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:38:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7D42476C0
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 331FE3016D28
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 08:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C1A426D2E;
	Tue, 10 Mar 2026 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1af9Z+Q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJToW0IM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CA4426688
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773131927; cv=none; b=dHob/rhGpOKCFuj224k+2+Y199Dei9QzkpQWUFJPS5c0iLKErfU4TqUS9QrN6tQo+pWsVZ0zZDFc0wtIiScwrjYIn3VqSaQ3YGPIm3uje4mC26Sv0hIcOyEbX8az0wM7AAU37D1awKfeok7JlWSGAUj8AyWooQfM/2Rla2n0M90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773131927; c=relaxed/simple;
	bh=/rgrFSztcoY371xizkvx6svBI2c3admzJK3fic/tp4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JonwSJfrjsHpJuSCoNfgW19TNWotuSJfaoylSN1i4vo0qPn0qBlLOQjIqCZe6Zd7Ej0jwnsBX09vdvXTY0UGZ1FD14Qid5FCTakNDVyKH2sKKQns7OyWSI0Hspd4BGd+eBO3TpgVpWQziCcD4NHVk9cU2w7EH15MD3k+c3FMh44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1af9Z+Q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJToW0IM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773131922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QP4ahpcv5MGsgEHxoMenfjfsEJ72JSZI5ys4UwjgpQA=;
	b=S1af9Z+QNDeXgcq314WdlFoJXpmrrJXGT064q8pduDhf3fXjrupX+L44X3y1REaMw10tzX
	C39MWhAPI3oMlphkyMOuHtOMnymU54ZuSh8hPGlJCSlfnv1Rx/SdGYNlS2/6e6+664UpdM
	xRH6Tqj5DQOsJi5cWmjihWtd1L/PlDo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-64hREknwMdS0oFR0T_sxbw-1; Tue, 10 Mar 2026 04:38:41 -0400
X-MC-Unique: 64hREknwMdS0oFR0T_sxbw-1
X-Mimecast-MFC-AGG-ID: 64hREknwMdS0oFR0T_sxbw_1773131920
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439c12269f3so4432699f8f.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 01:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773131920; x=1773736720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QP4ahpcv5MGsgEHxoMenfjfsEJ72JSZI5ys4UwjgpQA=;
        b=DJToW0IMkk1iCXGlY+i+J6KeuFwI+ek8B4jM6vktJdK9P2jVbkqAGnKiekJkGl5Zln
         2ZXXL5rNQ2iYtpwNu6K3+qLLcEh6N9rItR12ILkD/Qf28kMz5ZD+TncleN/vHI81Olg8
         oyyJIJDEwPcrRUXhga2wcuhFQ1zPMCJF3PuzWkb5e15SuDXCEyvTG+ntWENYzFN734BA
         EbeBuFy089Ey4SUrosBoYugBPoSQIBH/g1NxsBszR2uOGer2H95Ady7c2yO0I00UXBGm
         Iqr2CD5iHcMrkiynYyVB61BfrD061ahscEaRyHG/C8lqhS+qvSpkyC1OH942RYl1uhXD
         aDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773131920; x=1773736720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QP4ahpcv5MGsgEHxoMenfjfsEJ72JSZI5ys4UwjgpQA=;
        b=O7He1nSFysaeg6gL5tp0qs7FHlC3LqL4enNyRS2vmgs4xEdNPeJC3eNtLVAwEayEAz
         lsijXaQuy54+lQBrvotAAELzJ5JBOF6Z0DYxzowJ51Hl+w6ahfNrnDbrWYtPeD8RydGQ
         OqSB4GuuOUvS5l5PpGraxGBpd6dj5EuapHw7ns6/K9ub6L8D/rqxribpsCiyEaM/PWJO
         em30f0cWly7tgNOdGCGc9L8s5d4rd3C1eufu/e3MNGBjvxcwwyi3VPY+qfxep4hgmY+D
         A8lzg4BTPsRg+KWMvyQSvzbyTKoD/PfQsrlwOS8ZBUJhFhftQBAKYO57D8+fo2PTUrPO
         FZWA==
X-Forwarded-Encrypted: i=1; AJvYcCUk6BbCqoHMxogY5OaisIXo+fTs2SqOoB760LKKgA1KhTmAZ498sjtsiJlDdOnX+NYFA7bi8d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdNgA7CujbZWECxdGSp6fQUv+TMZ6QfLsFzOSmiUpdPS80sLvJ
	3XMU2lQz7n4sps7GJiI3Rgvf93h1t+lDt9oEGL5eNPMU/uWuZFm+RosdwMf2etU1nFdu5G5+qH3
	QoCGMw8nJ3S8uBvIZJvod7sqn+wjp2pSNlkLIqfmoKwML+/KW5ElJAQk82Q==
X-Gm-Gg: ATEYQzz1xK5M+EmPq/1lvcho/BQGmr5McxsEN6fvGCK6ximVliOk23yNFxR0cI0mJRu
	iji80whik+rOo3s4z2uuMPprRdwTC8aze/+vjet5hrxFukoe19/mEjp2PloAzKHdMejIu7qJq27
	dRmcy2Bs6GGkF0NAhA2YP5arF4QLVJov+kIHzokh4HUUAWe8KMqIKP8kR4wnC0H90Vjg7lIPmUz
	ZUvmv7gEcL1/MKqPdz4KLzNBUtJJbdEFcSXSKMrQtsgrCrX90YUi8q/fsCM0kKLcy8/7tz6GcyR
	7X/8N+yFyALCU50mTmNMLAHVqakk1nVH9+78AznnEt//EOBHT3bS1jqU2ecbk1cpJT+XytuVzUu
	uHs74VpwRTCL7+wTV7ZSqYHuk6s0MKRbk/MzjomTNTofyuMwkYvodfWc6
X-Received: by 2002:a05:6000:2403:b0:439:ac6b:dd38 with SMTP id ffacd0b85a97d-439da885d40mr25411029f8f.31.1773131920048;
        Tue, 10 Mar 2026 01:38:40 -0700 (PDT)
X-Received: by 2002:a05:6000:2403:b0:439:ac6b:dd38 with SMTP id ffacd0b85a97d-439da885d40mr25410968f8f.31.1773131919472;
        Tue, 10 Mar 2026 01:38:39 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae46353sm39446362f8f.33.2026.03.10.01.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 01:38:38 -0700 (PDT)
Message-ID: <9599a3fb-0c6f-4f60-be88-ceb65acad2b8@redhat.com>
Date: Tue, 10 Mar 2026 09:38:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v28 4/8] eea: create/destroy rx,tx queues for
 netdevice open and stop
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Dong Yibo <dong100@mucse.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>, Dust Li
 <dust.li@linux.alibaba.com>, netdev@vger.kernel.org
References: <20260302024604.25354-1-xuanzhuo@linux.alibaba.com>
 <20260302024604.25354-5-xuanzhuo@linux.alibaba.com>
 <e6c3b053-75d7-46b5-9fd0-ac6de498456f@redhat.com>
 <1773046268.140821-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1773046268.140821-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3B7D42476C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,linux.alibaba.com,linux.dev,mucse.com,gmail.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-265927-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/9/26 9:51 AM, Xuan Zhuo wrote:
> On Thu, 5 Mar 2026 11:16:32 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
>> On 3/2/26 3:46 AM, Xuan Zhuo wrote:
>>> +static int eea_netdev_open(struct net_device *netdev)
>>> +{
>>> +	struct eea_net *enet = netdev_priv(netdev);
>>> +	struct eea_net_init_ctx ctx;
>>> +	int err;
>>> +
>>> +	if (enet->link_err) {
>>> +		netdev_err(netdev, "netdev open err, because link error: %d\n",
>>> +			   enet->link_err);
>>> +		return -EBUSY;
>>> +	}
>>> +
>>> +	eea_init_ctx(enet, &ctx);
>>> +
>>> +	err = eea_alloc_rxtx_q_mem(&ctx);
>>> +	if (err)
>>> +		goto err_done;
>>> +
>>> +	eea_bind_q_and_cfg(enet, &ctx);
>>> +
>>> +	err = eea_update_queues(enet);
>>> +	if (err)
>>> +		goto err_free_q;
>>> +
>>> +	err = eea_hw_active_ring(enet);
>>> +	if (err)
>>> +		goto err_free_q;
>>> +
>>> +	eea_start_rxtx(enet);
>>> +
>>> +	return 0;
>>> +
>>> +err_free_q:
>>> +	eea_unbind_q_and_cfg(enet, &ctx);
>>> +	eea_free_rxtx_q_mem(&ctx);
>>> +
>>> +err_done:
>>> +	return err;
>>> +}
>>> +
>>> +/* resources: ring, buffers, irq */
>>> +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx)
>>> +{
>>> +	struct eea_net_init_ctx ctx_old = {0};
>>> +	int err, error;
>>> +
>>> +	if (!netif_running(enet->netdev) || !enet->started) {
>>> +		enet->cfg = ctx->cfg;
>>> +		return 0;
>>> +	}
>>> +
>>> +	err = eea_alloc_rxtx_q_mem(ctx);
>>> +	if (err) {
>>> +		netdev_warn(enet->netdev,
>>> +			    "eea reset: alloc q failed. stop reset. err %d\n",
>>> +			    err);
>>> +		return err;
>>> +	}
>>> +
>>> +	eea_stop_rxtx(enet->netdev);
>>> +	eea_hw_unactive_ring(enet);
>>> +
>>> +	eea_unbind_q_and_cfg(enet, &ctx_old);
>>> +	eea_bind_q_and_cfg(enet, ctx);
>>> +
>>> +	err = eea_update_queues(enet);
>>> +	if (err) {
>>> +		netdev_err(enet->netdev,
>>> +			   "eea reset: set real num queues failed. err %d\n",
>>> +			   err);
>>> +		goto err_bind_old;
>>> +	}
>>> +
>>> +	err = eea_hw_active_ring(enet);
>>
>> AFAICS the need for admins queue destroy and recreation on cfg change is
>> what prevents a safe configuration swap (together with irq allocation,
>> see below). Could you instead keep the admin queue always alive i.e.
>> with maximum number of erings configured, and just enable/them as needded?
>>
>> If not, please document explicitly the constraint in the commit message.
> 
> Generally, during I/O queue reconstruction, the admin queue is not rebuilt.
> However, in HA scenarios—which represent a special case—
> the DPU notifies the driver to request re-initialization. In this specific
> situation, the admin queue will also be rebuilt.

The above means that in HA scenarios the driver can't ensure to restore
the status correctly right?

At very least this info should be explicitly mentioned in the commit
message.

> 
>>
>> [...]
>>> @@ -140,14 +591,65 @@ static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
>>>  	enet->edev = edev;
>>>  	edev->enet = enet;
>>>
>>> +	err = eea_alloc_irq_blks(enet, pairs);
>>> +	if (err) {
>>
>> I'm likely lost, but AFAICS eea_alloc_irq_blks() is invoked only here,
>> and allocates edev->rx_num interrupts. rx_num is the number of RX
>> channel at device probe time.
>>
>> set_channels can later change such value, i.e. increasing it. But I
>> don't see other irqs allocated.
> 
> 
> No, set_channels just change enet.cfg.rx_num, edev->rx_num is readonly.

Ah, I (now) see that set_channel max is cfg_hw.rx_ring_num, which in
turn is equal to edev->rx_num.

It would be useful to explicitly mention in the commit message or in the
init code that the driver always per allocate the max possible number of
IRQs handlers.

/P


