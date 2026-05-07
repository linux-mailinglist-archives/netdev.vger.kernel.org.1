Return-Path: <netdev+bounces-285353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIiDKZSh/Gn2SAAAu9opvQ
	(envelope-from <netdev+bounces-285353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:28:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA77C4EA2B2
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BAE83001A60
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 14:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13B23E928B;
	Thu,  7 May 2026 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPKV//HD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oq37BxOo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60298387569
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163909; cv=none; b=UXaQ/wdqAym2lrMS/xS33wC+pGsbQNy0f9DdC3pJYP6c2ABkcgkKK+QDy/YaHy1WWJgC+ECJ3S2NtYh8yqZRwuvlb0XvhjOUvkX3qIdUHdg21ipwqur99N5ZJdjLUb+kqEdy2dKW8wBfvmu0dAoVG543KHT1A04UWP1ZHz9l6/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163909; c=relaxed/simple;
	bh=rpONTYyBHvb3/ty0Cn6LLhwjJ8jU8C2TLAGIYKpBTSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBPrJe925w9WsJws86zjHR7sx+GNI250nUuxomqLwAJqRADN0w+xcVYDrU2yb4970w30RSOGj6Tajb9JNHiMcm2R1WCIgVIy0ZrEjcI3QODjiX9HX1HAwJ3DwAroqDoHuEIF0G2M2QAGrqw4eXEVblo2gVM+rAbXsBIe6XEeAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPKV//HD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oq37BxOo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778163907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiqZW49hh0OIaoHIFoPmjirkZjGaDDvaDEv00sXgKKg=;
	b=MPKV//HDArlNv4OP63nWkWxWWmKmhCKOYY62QOJOIxZOd8S9JSCGJef7upIlJiPAvs5TI1
	aLqLtkwZ7yaL75WVnrfeMCdheDbQ1+1hRRNr1AaIkSPxJG81y7Ku9uF7u1W7Xx6AjUIovO
	K6ByjUZbYy12WUPw4iw/eEuqLSYHZVA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-OO1dPZgOP9Km2FNCtvSPOQ-1; Thu, 07 May 2026 10:25:05 -0400
X-MC-Unique: OO1dPZgOP9Km2FNCtvSPOQ-1
X-Mimecast-MFC-AGG-ID: OO1dPZgOP9Km2FNCtvSPOQ_1778163904
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44b186b715aso641948f8f.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 07:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778163904; x=1778768704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IiqZW49hh0OIaoHIFoPmjirkZjGaDDvaDEv00sXgKKg=;
        b=Oq37BxOoOHbOceTyj5i2vZVt5/WcPJG7tWmpXNCEdAOz9hT9C6oTHLBEEuSi6/G4qi
         D2Bs/T7gvtHgapM4sfsrZ4PqmIxjGLer30oNPWlYJ0X/D5ZgDEAJd0y/TMcMRPYzD9Sj
         gMv4vgGb8hMcfxyHnk6oGRjuvtkCuz0FSa6swGhWI9pYp+ezGycJnFwZdpTEMPPE7n/J
         Ns0Cj0e3TQfCMsIr1wzxhjZ1fYgGRX8vkaM9eBnHMYAgmMip0Z3mOG2DMlC2bGfIeFqy
         yobOSluxGTjeleTgJORYLaMl1Ad/wmmz+oHrlu9IWW7p61VYKYMG2+NXM7Oe+fjW0QDk
         GJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778163904; x=1778768704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IiqZW49hh0OIaoHIFoPmjirkZjGaDDvaDEv00sXgKKg=;
        b=fNYJ5gOxV9UC5JYVkJzsgPVrGwha2bcIiUf71bnylq1FbdUox8ODR9UlDyEZJKgOZl
         jE7dGPuufppDs1jAjOCsN6idb6pgm481mH24F5bTKKrlUKtNGOxf+UJuR14K5BxlAY5N
         iYm3i++K5PaAyFuKqZfesy8YwqHSoHbaPVkZlm7dZf7YypBp259n/3fK3fmofMb5ABwP
         h4gx38xXjz/GemuY3SU9jeu+G8Ck48SR7ucmZeYeG7t4UgvhApLChkkHGV6xwNxLiwuN
         JkKAlrbjnpOBsnlSuhyQnhyTTUEn8A+YvyvPNIua1x6+BSqzpubDax+zrFWE7B00Q4F8
         DpVw==
X-Forwarded-Encrypted: i=1; AFNElJ8JDFyi0616waJ1fDtKYcaf7Jo1SVL7fvNkMRgWx0vwvv3fiO8CHFhDMPWh2P3BK6in77wTLgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd6n05tMs7AuVkSTA9nCvhfOemlLciSJZk++P0kArOeOnHQqdY
	R4qiy5VUGjFkCH59dUMHAoJHZ1OCFJF1a3pE83ixBzt9GCLJ1mAIXPdFuhV1LmdSmAv60WfS8I5
	bmPGmNYMi/jVLlhzL0m8e88Q3R6WYbdzaYW8YYg7nknWKgyO9MClWn632hw==
X-Gm-Gg: AeBDiet4E3A7haHMSODe0HGkumKnNEVYxOo5M/quve892JCtIwKdYWWZBdntlp0THoC
	qVcAO8SorwMxn/r9PLq/rrocRPbYzae2AYiUqdyhIoIubYQvIaQlkFllI3+QfSzsRwh2Y9Atr5K
	HYcp2ACSYpONRzOrvKs4idaTjUVStzhjrNrd4m1QKpx46HN7p2gootRgpPNS1aDRCV/4xXp9KxI
	hUNHj0gG6HPrecfkexfD39JaQohJ5wkzdW56/ZxjvRvvbxvmtxE23E6SKJ6vDisXBg1OPySBpFk
	wnfo7V3mjVohpuEt6iDd6Jy0nXOCUDS9d1GrDnEkpuU1eCa/QAmL34P77ONfVpVKE9zaDbr0wc1
	eQXM+ia6tioTL0caHZ30eaZ9sH7S7+W/dYf0Xx6+tTKTXskxkY38oRqP1P3Tehn+n0Q==
X-Received: by 2002:a05:6000:2304:b0:44a:52d5:e4f1 with SMTP id ffacd0b85a97d-4515b057373mr13747087f8f.5.1778163903196;
        Thu, 07 May 2026 07:25:03 -0700 (PDT)
X-Received: by 2002:a05:6000:2304:b0:44a:52d5:e4f1 with SMTP id ffacd0b85a97d-4515b057373mr13746976f8f.5.1778163902357;
        Thu, 07 May 2026 07:25:02 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960022sm21167533f8f.26.2026.05.07.07.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 07:25:01 -0700 (PDT)
Message-ID: <295255d8-ef21-4d0e-b651-74ec1d21f51c@redhat.com>
Date: Thu, 7 May 2026 16:25:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/5] veth: fix OOB txq access in veth_poll()
 with asymmetric queue counts
To: hawk@kernel.org, netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com, Sashiko <sashiko-bot@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Toshiaki Makita <toshiaki.makita1@gmail.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260505132159.241305-1-hawk@kernel.org>
 <20260505132159.241305-2-hawk@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260505132159.241305-2-hawk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AA77C4EA2B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cloudflare.com,kernel.org,lunn.ch,davemloft.net,google.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285353-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/5/26 3:21 PM, hawk@kernel.org wrote:
> From: Jesper Dangaard Brouer <hawk@kernel.org>
> 
> XDP redirect into a veth device (via bpf_redirect()) calls
> veth_xdp_xmit(), which enqueues frames into the peer's ptr_ring using
>   smp_processor_id() % peer->real_num_rx_queues
> as the ring index.  With an asymmetric veth pair where the peer has
> fewer TX queues than RX queues, that index can exceed
> peer->real_num_tx_queues.
> 
> veth_poll() then resolves peer_txq for the ring via:
> 
>   peer_txq = peer_dev ? netdev_get_tx_queue(peer_dev, queue_idx) : NULL;
> 
> where queue_idx = rq->xdp_rxq.queue_index.  When queue_idx exceeds
> peer_dev->real_num_tx_queues this is an out-of-bounds (OOB) access
> into the peer's netdev_queue array, triggering DEBUG_NET_WARN_ON_ONCE
> in netdev_get_tx_queue().
> 
> The normal ndo_start_xmit path is not affected: the stack clamps
> skb->queue_mapping via netdev_cap_txqueue() before invoking
> ndo_start_xmit, so rxq in veth_xmit() never exceeds real_num_tx_queues.
> 
> Fix veth_poll() by clamping: only dereference peer_txq when queue_idx is
> within bounds, otherwise set it to NULL.  The out-of-range rings are fed
> exclusively via XDP redirect (veth_xdp_xmit), never via ndo_start_xmit
> (veth_xmit), so the peer txq was never stopped and there is nothing to
> wake; NULL is the correct fallback.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260502071828.616C3C19425@smtp.kernel.org/
> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

This looks fairly uncontroversial, but it's IMHO net material. Let me
apply it there.

/P


