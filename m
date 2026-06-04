Return-Path: <netdev+bounces-295102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HgFOHd45IWqeBQEAu9opvQ
	(envelope-from <netdev+bounces-295102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:39:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFD163E0D8
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:39:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=UD+liWiU;
	dkim=pass header.d=redhat.com header.s=google header.b=ebhXAAJO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295102-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295102-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2F72304FC80
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1A43A641C;
	Thu,  4 Jun 2026 08:30:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DE03803D2
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 08:30:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561858; cv=none; b=Br/IuMa8gy1jK7Mr1NqBxrtjaPS3fsPjos3BVXJExfKOccfUr29NDF2YcoHg5qpGstHVcvMD2VGDN19Gek5Nbu9/s5zaaBmAKdYQOfWzHlbOxIlspmben2ofxppgk2TAyY55mZLy2R6kUznxQFRGhH3QIQcUOKN8B4yCxEk4oyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561858; c=relaxed/simple;
	bh=Z8OVP16ejdIREmaWRl+L2yDU+RGvvMKUI+ywOyOT+Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTf9QmneUmUTyAa5uremGp1pkWZCmjnoMtls8//BxrUUxyoCjSEUZJldnLXVvxBBX9kY72n7ERdQJxLO7UZCKTRGJFvFlqSKfboirDbhQ+xdAhLQcLdaekAx4IXMZ+GJstbBvr1EbZZJn6sk20ouNTOYZ5opnMekNvfFSr8mSZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UD+liWiU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ebhXAAJO; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780561854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zfG24Fn7ZF6pSbC0Um/66jIGY3WmDN4xCLgytW1z1jY=;
	b=UD+liWiUdumWgI82Sin9aF50Ki4tBRxzVKrhCF3+A6WPX1Fe7YXyd3d5mKHUUebneTT24m
	hBKu25QjSOWXqj8G9gHqkUofX4f1PQFU+wQh5udUqsK9QWXG8iqvmUDBBd0csv+N76953K
	8edV/Kkr+ypLUuEXtBMFFGGagM2mL58=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-CKu41FVmMRGrGcQhU5ecdg-1; Thu, 04 Jun 2026 04:30:52 -0400
X-MC-Unique: CKu41FVmMRGrGcQhU5ecdg-1
X-Mimecast-MFC-AGG-ID: CKu41FVmMRGrGcQhU5ecdg_1780561851
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-bec23d0e9dcso37697166b.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 01:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780561851; x=1781166651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zfG24Fn7ZF6pSbC0Um/66jIGY3WmDN4xCLgytW1z1jY=;
        b=ebhXAAJOxPuYUCm2E+Z4/MnGMbPsbrcllRKVD3X8qYICrtHb2fn87aGtR3Q0SWeES5
         xzAFHDQ/hMUrIXb0/Jl5ZezTSgwLssVIsqJ0wB5XJTzU60djQ07AdrhfR4aLCj7mVvlb
         8KKjSo53B2lG1CwNhw9V2qaDpGl4EhBLZh4zVxeydMQQV6rW2k0EdMplmQ9xJeJwI4WL
         HuPHgv0ty0/oUW8KNilhfj0KA/3y5j3wmem9Mp5lNaXCPXL4JUoC3/FJL+zfGU6ocwYF
         piSigVdiGf07hJf9s+BYSEc6TbfK4KO3bONkPCKhM9uE4csMKsuE2Qeiun54wnrvBdqV
         4Hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780561851; x=1781166651;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfG24Fn7ZF6pSbC0Um/66jIGY3WmDN4xCLgytW1z1jY=;
        b=mAGi3dqdmvNtj37c8aDQ2cZ1Q0Rdsqfxvs8gPxnU6Mxybku8RhbuuDNJ3EhwKIj8Px
         haRU5WeQMUjx7PRdKYTny8FLVSVVmvTEA3Yw9UZtj49lR5sPqcuJaibHSJ0m3Qc+YpLN
         SbfuCIHuy+LINCnPT0bqP/CU5k5dKS/EbQ8nE0qXQ7mW/QkgLz3KOyOwaFsz+lHdch3U
         7SMDyBpRd1bi46/PKLyUj/xpJGcp1aNPthe7Suqp3SDhPPYIKyrxEEngHPnHCymToXkP
         h0/81IZXSwvYt/xMCduLJGGFdb55Z2KjInCv7uPgTTObr0PNX64NY/zg22jif4XtsTll
         oPxA==
X-Forwarded-Encrypted: i=1; AFNElJ96K0mUt5OF9f1TF0te90Vug0QX75bvDYUgI3jqn0dIa327a64435PTqYWBb4tgCAXyAVLNty4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOE079rBahOay7+KAibnEJodoW2lrjQ1RWHAzUKRBih2QjKvOa
	fhqZxDaz0cDTVzx4Yc1nAL22uzKvBi6dWg3FgtriQ/zP3/RpXRzLUCoahtC3lWDDLr3BldrFW7q
	KnO0E+O370iLYX2kC91fD16IkONTovWSpsb68XBVe1lt2N3Wv5X14YpZsbyP6jFpcxA==
X-Gm-Gg: Acq92OFnKCcmrk4jDKMa3ojQGaH+/BiHP5izbtGJpJ0pFLDRVRoKgpXxVN81lw6amxD
	lKJIhhcwzM5JMST6eWKbwWGPrXmGIirX5cmj/VW1FtcFW9GQ0bhrJdbvwERlzDwbVxaLr0TbpTm
	QQNftRJ9LHAAGDtqhkgTBO9ZhS/eFRewUE/3v8uQkxLtKjxZIQJ3KeL4XHAiPm5wB5UvtMsptpL
	Djz8oWOzHGhQLBKTtpXWiOALfkku0WClWCB8W/ElFHfjSdn5AJBMrOHn3ctrraoo3VsRxhrvtNc
	fFCFqZ+GYfqJQN16TPAZkCximrcwuRzcIWSemLPt5I3x4vifOJPBRqsGrx2iRgy8bidUNpv7Wdn
	x6xRIEx5ui11xo0H3K+zVUiXs+wi+2n5r/QUymHoPLpHlfKdKRpsVJMu2iHbPtAVVOls=
X-Received: by 2002:a17:907:2668:b0:bed:6e53:bb16 with SMTP id a640c23a62f3a-bf0af3019camr239312666b.43.1780561850910;
        Thu, 04 Jun 2026 01:30:50 -0700 (PDT)
X-Received: by 2002:a17:907:2668:b0:bed:6e53:bb16 with SMTP id a640c23a62f3a-bf0af3019camr239311266b.43.1780561850384;
        Thu, 04 Jun 2026 01:30:50 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0517721c2sm261120066b.3.2026.06.04.01.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 01:30:49 -0700 (PDT)
Message-ID: <3f73e314-756e-494e-a1aa-0bc39c14f41b@redhat.com>
Date: Thu, 4 Jun 2026 10:30:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/5] net: sched: add timeout count to NETDEV
 WATCHDOG message
To: hawk@kernel.org, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
 =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-5-hawk@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260527135418.1166665-5-hawk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295102-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:hawk@kernel.org,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:j.koeppeler@tu-berlin.de,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DFD163E0D8

On 5/27/26 3:54 PM, hawk@kernel.org wrote:
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 237ee1cd0136..2aebab985c00 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -533,13 +533,12 @@ static void dev_watchdog(struct timer_list *t)
>  		    netif_running(dev) &&
>  		    netif_carrier_ok(dev)) {
>  			unsigned int timedout_ms = 0;
> +			struct netdev_queue *txq;
>  			unsigned int i;
>  			unsigned long trans_start;
>  			unsigned long oldest_start = jiffies;
>  
>  			for (i = 0; i < dev->num_tx_queues; i++) {
> -				struct netdev_queue *txq;
> -
>  				txq = netdev_get_tx_queue(dev, i);
>  				if (!netif_xmit_stopped(txq))
>  					continue;
> @@ -561,9 +560,10 @@ static void dev_watchdog(struct timer_list *t)
>  
>  			if (unlikely(timedout_ms)) {
>  				trace_net_dev_xmit_timeout(dev, i);
> -				netdev_crit(dev, "NETDEV WATCHDOG: CPU: %d: transmit queue %u timed out %u ms\n",
> +				netdev_crit(dev, "NETDEV WATCHDOG: CPU: %d: transmit queue %u timed out %u ms (n:%ld)\n",
>  					    raw_smp_processor_id(),
> -					    i, timedout_ms);
> +					    i, timedout_ms,
> +					    atomic_long_read(&txq->trans_timeout));

It looks like txq could be uninitialized here if num_tx_queues is 0. I'm
unsure if some weird/buggy device driver could actually hit that case,
but grep '->num_tx_queues = 0;' has more than 0 hits in the current tree
and I would err on the safe side.

/P


