Return-Path: <netdev+bounces-303083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tw8sBvupQ2oiegoAu9opvQ
	(envelope-from <netdev+bounces-303083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:35:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 630746E3AA8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:35:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Z+IQL+6Z;
	dkim=pass header.d=redhat.com header.s=google header.b=pz8it7xA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303083-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303083-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D37273324231
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 10:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCD03FE66F;
	Tue, 30 Jun 2026 10:55:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803943CAE7F
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:55:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816923; cv=none; b=UGI87JM8B5F7IWt9I6jIhiA2slcDJUhzvIwpO3QudJuKw4tqPb7Z0ec8e6KAcojQamQc7G0nZsyQHZEgaZ7gYGwjAepq+HkoKu9NiL8L3Y7Pr7D+tNtptph6/zvQqgUrfTB5urV0kSqB2yxEJ95b1/sOL55pRXiDrARMAdM0xYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816923; c=relaxed/simple;
	bh=5+6M4SD1m0bo35rZmYLB35FeQPUsHt4pVQU8CY3X/mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFQFvtKkpHucRZ1JFVyHzBujhTy2KcmY5IGmjTsysbpzc8Xk4FPHVLkP54KbaP42XVkyeeanxJ50Fl2rzTq6EW+qsevWCAw5IJ85mcR0Jsns19PhOcT7RXQrlMTMQXtUZ5s88IIv+dYveZg8FBhQxrrW4IDyqgNKm5cxMw4iy3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+IQL+6Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pz8it7xA; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782816917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hMKiXFK0pfNTOQ9DCFZIRhDUF8Wl7Qfuw9O2ocILSG4=;
	b=Z+IQL+6ZQQjlLVRzcaClAzGyZitfp2olCP+7nJPioz3inYY18YU5dm6RXG+5ScxTZoTSmE
	h/crKEG+6BS2D+HbfGEofKfLvUahiCjw4AiHp4unTrrYf9Hgw8dIOdTl935tFgpBm+9ABA
	1N9gvCcGUiUin2ueHcoY/K0x8OEEEi0=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-9Q1yMArrMwyG4UFzcgX_rQ-1; Tue, 30 Jun 2026 06:55:15 -0400
X-MC-Unique: 9Q1yMArrMwyG4UFzcgX_rQ-1
X-Mimecast-MFC-AGG-ID: 9Q1yMArrMwyG4UFzcgX_rQ_1782816915
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-664dbd02ff1so2597537d50.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 03:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782816915; x=1783421715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMKiXFK0pfNTOQ9DCFZIRhDUF8Wl7Qfuw9O2ocILSG4=;
        b=pz8it7xA1NvBmF4mkG5SoLVAl1UI7NudgcLJE0Gvk+kMMPYFZjxFEILh6t6Niv1znL
         hv0RaN5XCsInL4c/2eCnM0wY6egBe3wNt4glFAwNWcca/VGyvWnP9mFS0Q9sEucUuCQ8
         EaKSvFC9UH6wdxmHE24+UJdFjH4A2ZCb741atv+AxqIUrDk2f61NRQ1yqTiB30ilIZvR
         DYS79iidxgnG4qB6JcSr0iewYoY2UsvaaeSY+ZuKTP5mNRXQiBvFNI9zg3fg+4FhK2rn
         RlUnEhRpJZS8Df23SBDPvkr9sQaTST+2+w5JhvOxlXAHr7riOCr0YC3Kv80rDjROxVuz
         1R4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782816915; x=1783421715;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMKiXFK0pfNTOQ9DCFZIRhDUF8Wl7Qfuw9O2ocILSG4=;
        b=IJgtUJsUVP4+f6y1rEmgrWMV/mT55DHAz+PayCtWWNnS6en+jvnxE208mV600kyNUK
         Ro+ZbwBE54ewakf9r2w0KLuQvmOmnHqk/tYDEaQK1i10FQrtRXrtWI84A7Ky09YpJKAg
         OaxJ/lQuaf/dzbXjzoJYRQShTQr8PbkSM6hAUPRSR40akeD3dQoM/WHXjIe9yM648lWZ
         x+PIm1trUMhm6NfVclwAZZ46M0TOYU5/NXk2y/+RqECEhZFaoigLX+YtYHbnVq99kv8O
         KPOdvIjLFtbA31NfttGpb9jEGOKYRStCKtIFiEXoc97Z+7P0PXzJE9efb85R0cGB0xdG
         O9NQ==
X-Forwarded-Encrypted: i=1; AHgh+Roh8fVCOlGooYKuUZ3VFSm+2RuWkSGMiOsWEkCWjDSZzamMwyWWJFJG7x1/1wvIho6++E/e5wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx988HPB2s+lXbt7QRyWiEl7cEveDW7fZ6LqUE2RNpVtIZCALUl
	npUJ2M+UymP27gtiin59dxtxhxTFoLUWBbqTeDkku7dE5C01nRFLv/ZOLPdZs5UhFuEV7EHshOT
	SJQQy6ix4yPwOCjDNhoC9UizUGEMbf8PAlcoNbw0yd6+DpnOpmmzcy6FZfQ==
X-Gm-Gg: AfdE7clpOrgyTtpkQrsabSzWGc6wO+2BYS4LESJWX37Q/PvJfyAGP8jsLpYGEdnQuAp
	HKEah6iEyyCUYBQwQlQj68X1ZuK9EQqxE5VH2EODvPw2a6TrtgQpfvtZdHDUKD8+EDhNM7Q7NMX
	GtrAD47n5SIKbX4YY8ZXK9liQf+lxfftdE2ZfUc+nfAHcFBcpLPsWsp5rolTFUDJWNO4dDAAOP+
	XNkc5gsgE42HfqurB7zpG83m5VsWAFEZC086zFD4Wpis6BcYJqxCTUf96grPTAD8c5NfOSKyGM3
	696B2p1KyklRIaSlirYvqNqMUSNl9EDt8mPXIqv+UFDEshAfcNBQ9FwVFB1Od7ccS6nU8GBfrrL
	fjzR0yQKg62z19lqioW06keK243SywyT+NhzsfCOQlFH6XC2d6Q/9a5CujURsa6XnHPLzr8U6RJ
	wwll44C/XJlA==
X-Received: by 2002:a05:690e:419b:b0:662:e26f:cd10 with SMTP id 956f58d0204a3-664f98cfe16mr2737873d50.51.1782816915001;
        Tue, 30 Jun 2026 03:55:15 -0700 (PDT)
X-Received: by 2002:a05:690e:419b:b0:662:e26f:cd10 with SMTP id 956f58d0204a3-664f98cfe16mr2737836d50.51.1782816914353;
        Tue, 30 Jun 2026 03:55:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66500666305sm757620d50.5.2026.06.30.03.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 03:55:13 -0700 (PDT)
Message-ID: <b42c9095-aa2a-4e2f-b65e-11adbd2dbec6@redhat.com>
Date: Tue, 30 Jun 2026 12:55:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] net: stmmac: fix fatal bus error on resume by
 reinitializing RX buffers
To: Ding Hui <dinghui1111@163.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Ding Hui <dinghui@lixiang.com>,
 "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: xiasanbo@lixiang.com, yangchen11@lixiang.com, liuxuanjun@lixiang.com
References: <20260627122533.1165324-1-dinghui1111@163.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260627122533.1165324-1-dinghui1111@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303083-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[163.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,lixiang.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS(0.00)[m:dinghui1111@163.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:dinghui@lixiang.com,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:xiasanbo@lixiang.com,m:yangchen11@lixiang.com,m:liuxuanjun@lixiang.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 630746E3AA8

On 6/27/26 2:25 PM, Ding Hui wrote:
> From: Ding Hui <dinghui@lixiang.com>
> 
> On suspend, stmmac_suspend() calls stmmac_disable_all_queues() which
> stops the RX NAPI, but the RX DMA engine may still be running for a
> short window before stmmac_stop_all_dma() takes effect. During that
> window the hardware can write incoming frames into the buffers pointed
> to by the RX descriptors and write back the descriptors (clearing the
> OWN bit and overwriting RDES0/1/2 with status/timestamp data). Because
> NAPI is already disabled, the driver never refills these descriptors,
> so the RX ring is left in a "consumed but not refilled" state with
> stale content in the descriptor buffer-address fields.
> 
> On resume, stmmac_clear_descriptors() only re-arms the OWN bit and
> does not repopulate the RX buffer address fields. When the DMA is
> restarted it dereferences these stale addresses and triggers a fatal
> bus error (not kernel panic, just a Fatal Bus Error interrupt and
> RX DMA engine halts).
> 
> Fix this by introducing stmmac_reinit_rx_descriptors(), called from
> stmmac_resume() immediately after stmmac_clear_descriptors(). The
> helper iterates every RX descriptor slot and re-programs its buffer
> address fields:
> 
>  - For normal (page_pool) queues: restore RDES0/1 from buf->addr and
>    RDES2 from buf->sec_addr. The DMA mapping has remained valid across
>    suspend/resume because no pages were freed. Slots left NULL by a
>    prior GFP_ATOMIC failure in stmmac_rx_refill() before suspend
>    are re-allocated here with GFP_KERNEL;
>    -ENOMEM is returned and resume is aborted if allocation fails.
>    The slots with null buffer are unacceptable, because they will
>    cause a DMA suspend dead lock problem by the condition of
>    Current Descriptor Pointer == Descriptor Tail Pointer.
> 
>  - For AF_XDP zero-copy queues: restore the DMA address from
>    xsk_buff_xdp_get_dma(buf->xdp). Slots with no xdp buffer
>    (e.g. TX-only socket, empty fill ring) attempt xsk_buff_alloc()
>    first; on failure the descriptor is zeroed so the DMA engine skips
>    the slot safely via an RBU event.
> 
>  - For chain mode: call stmmac_mode_init() to rebuild the des3 next-
>    descriptor pointer chain, which hardware may have overwritten with
>    a PTP timestamp value (as noted in chain_mode.c:refill_desc3()).
> 
> After reprogramming all address fields, a final pass restores OWN=1
> on every valid slot. This is necessary because set_sec_addr and
> chain-mode init unconditionally overwrite des3 (clearing the OWN bit
> set by stmmac_clear_descriptors()), and must run after all address
> writes are complete.
> 
> Also fix stmmac_init_rx_buffers() to actually use its gfp_t flags
> parameter instead of the hardcoded GFP_ATOMIC | __GFP_NOWARN.
> 
> Signed-off-by: Ding Hui <dinghui@lixiang.com>

This looks like 'net' material, it should specify 'net' into the subj
prefix and include a suitable Fixes tag.

> ---
> Changes in v4:
> - Just add description for return value of 'stmmac_reinit_rx_descriptors'.
> - Link to v3:
>   https://lore.kernel.org/netdev/20260604144557.3175399-1-dinghui1111@163.com/
> 
> Changes in v3:
> - Re-allocate page_pool NULL slots (from prior GFP_ATOMIC failures)
>   with GFP_KERNEL in stmmac_reinit_rx_descriptors(); return -ENOMEM and
>   abort resume.
> - For XSK NULL slots, attempt xsk_buff_alloc() first; fall back to
>   stmmac_clear_desc() only when allocation fails.
> - Add a re-arm loop at the end of stmmac_reinit_rx_descriptors() to
>   restore OWN=1 on all valid slots, since set_sec_addr and
>   chain-mode init both write des3 unconditionally.
> - stmmac_reinit_rx_descriptors() now returns int; stmmac_resume()
>   checks the return value and propagates -ENOMEM with mutex/rtnl cleanup.
> - Fix stmmac_init_rx_buffers() to use its flags parameter instead of
>   hardcoded GFP_ATOMIC | __GFP_NOWARN.
>   (884d2b845477 ("net: stmmac: Add GFP_DMA32 for rx buffers if no 64
>   capability"))
> - Run stmmac_reinit_rx_descriptors() after stmmac_clear_descriptors()
>   so that stmmac_clear_desc() on XSK NULL slots overrides the OWN
>   bit set by stmmac_clear_descriptors().
> - Update commit message.
> - Link to v2:
>   https://lore.kernel.org/netdev/20260526022620.501229-1-dinghui1111@163.com/
> 
> Changes in v2:
> - Introducing stmmac_reinit_rx_descriptors() to reinitializing rx
>   buffers without any allocation.
> - Modify commit log.
> - Link to v1:
>   https://lore.kernel.org/netdev/20260515053856.2310369-1-dinghui1111@163.com/
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 164 +++++++++++++++++-
>  1 file changed, 163 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3591755ea30b..c82f3d5dbd43 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1660,7 +1660,7 @@ static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
>  {
>  	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
>  	struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
> -	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
> +	gfp_t gfp = flags;

The above should go via a separate (net) patch.

>  
>  	if (priv->dma_cap.host_dma_width <= 32)
>  		gfp |= GFP_DMA32;
> @@ -1693,6 +1693,148 @@ static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
>  	return 0;
>  }
>  
> +/**
> + * stmmac_reinit_rx_descriptors - re-program RX descriptor buffer addresses
> + *				   after stmmac_clear_descriptors()
> + * @priv: driver private structure
> + * @dma_conf: structure holding the dma data
> + * @queue: RX queue index
> + *
> + * Description: Called in the resume path after stmmac_clear_descriptors()
> + * has re-armed the OWN bit on every descriptor.  Walk buf_pool[] and
> + * re-program the buffer-address fields of every RX descriptor from the
> + * buffers that are already attached to the queue.  Slots whose page was
> + * never allocated (GFP_ATOMIC failure before suspend) are re-allocated
> + * here with GFP_KERNEL; the resume path is in process context.
> + *
> + * Between suspend and resume the hardware may have written back status/
> + * length information into the descriptor address fields (RDESx are reused
> + * for status on completion for GMAC4/XGMAC), so the address fields must be
> + * repopulated before the DMA is restarted.
> + *
> + * For XSK slots that have no xdp buffer at suspend time (TX-only socket,
> + * empty fill ring for Rx), xsk_buff_alloc() is attempted but does not
> + * return an error on failure because we can't identify a real TX-only
> + * socket from an alloc error (same as stmmac_alloc_rx_buffers_zc() in
> + * __init_dma_rx_desc_rings); on failure the descriptor is zeroed so the DMA
> + * engine skips the slot safely.
> + *
> + * To avoid the DMA stall after resume in non-XSK mode, this function
> + * re-allocates pages for NULL slots using GFP_KERNEL (the resume path runs
> + * in process context). If allocation fails, -%ENOMEM is returned immediately
> + * and the resume is aborted; the caller should report the error.
> + *
> + * This helper must be called after stmmac_clear_descriptors() and before
> + * stmmac_hw_setup() in stmmac_resume() because we need to wipe the OWN bit
> + * set in stmmac_clear_descriptors() for NULL slots in XSK mode.

Please try to condense the above text in one or 2 paragraph.

> + *
> + * Returns: 0 on success, or a negative errno on allocation failure in
> + * non-XSK mode (e.g. -%ENOMEM).
> + */
> +static int stmmac_reinit_rx_descriptors(struct stmmac_priv *priv,
> +					struct stmmac_dma_conf *dma_conf,
> +					u32 queue)
> +{
> +	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
> +	struct stmmac_rx_buffer *buf;
> +	struct dma_desc *p;
> +	int i;
> +
> +	if (rx_q->xsk_pool) {
> +		for (i = 0; i < dma_conf->dma_rx_size; i++) {
> +			buf = &rx_q->buf_pool[i];
> +			p = stmmac_get_rx_desc(priv, rx_q, i);
> +
> +			/* The XSK pool may not be fully populated (e.g.
> +			 * xdpsock TX-only, empty fill ring).  Try to refill
> +			 * from the pool; on failure zero the descriptor so the
> +			 * DMA engine skips this slot safely.
> +			 */
> +			if (!buf->xdp) {
> +				buf->xdp = xsk_buff_alloc(rx_q->xsk_pool);
> +				if (!buf->xdp) {
> +					stmmac_clear_desc(priv, p);
> +					continue;
> +				}
> +			}
> +
> +			stmmac_set_desc_addr(priv, p,
> +					     xsk_buff_xdp_get_dma(buf->xdp));
> +			stmmac_set_desc_sec_addr(priv, p, 0, false);
> +		}
> +	} else {
> +		for (i = 0; i < dma_conf->dma_rx_size; i++) {
> +			buf = &rx_q->buf_pool[i];
> +			p = stmmac_get_rx_desc(priv, rx_q, i);
> +
> +			/* buf->page can be NULL when stmmac_rx_refill() hit a
> +			 * GFP_ATOMIC failure before suspend and left the slot
> +			 * without a buffer. The resume path runs in process
> +			 * context, so re-allocate with GFP_KERNEL. Allocation
> +			 * failure aborts the resume.
> +			 */
> +			if (!buf->page) {
> +				int err;
> +
> +				err = stmmac_init_rx_buffers(priv, dma_conf, p,
> +							     i, GFP_KERNEL,
> +							     queue);
> +				if (err)
> +					return err;
> +				/* stmmac_init_rx_buffers() already programmed
> +				 * the descriptor; skip the reprogramming below.
> +				 */
> +				continue;
> +			}
> +
> +			stmmac_set_desc_addr(priv, p, buf->addr);
> +			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr,
> +						 priv->sph_active &&
> +						 buf->sec_page);

AFAICS stmmac_rx_refill() can error out after successfully allocating
buf->page, but leaving a NULL sec_page, I think you should try to
realloc even the latter.

Finally this chunk shares quite a bit of code with stmmac_rx_refill()
and stmmac_rx_refill_zc() it would be better try to factor out common
helpers.

/P


