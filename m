Return-Path: <netdev+bounces-287945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP77FMy5BWpZaAIAu9opvQ
	(envelope-from <netdev+bounces-287945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:02:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D4E54156E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36CD430566FD
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9263C583A;
	Thu, 14 May 2026 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RX0cCF8G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIkS460b"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A423C4B90
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778760094; cv=none; b=DnsFBY4K5XGLncjAuGzHbRQBjtuT/8B5ReiFJ9MaXxdlPS5hQg2WQr7W3sTGhL3osuSp+H9O4uecW2APlXYCAx8jAAbgJ9pNra+B+qBw3ZOplaf6qiUPkKq5aN122200kx+xi2CHPkPoTQS7LxKs6o6n/BBo7t+bg9y+UFizXBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778760094; c=relaxed/simple;
	bh=mte9RB+0BoOJGWH3O59vk3r7TztS11NXPHpFBvDXs3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0O8t40+2CYAHB5m6oS4dBwoFg407+lDDu0QRq6ZPskE33zYRdka9htv5IDvXRrWKH9QfrvDYslCnZQ2jf/SFEc+72IYCafPW+XTBwpQM+u9zrbqAWwfbVvrQvEhLQk5JoM4U2d/KHzGohBEsyQptOT797EPoScE5vnkoDL5hZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RX0cCF8G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eIkS460b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778760090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Z56KOps0AG32fICJVPwzpfDBem2tIGZoRzP5xP0mtM=;
	b=RX0cCF8G0SKw0ZjC4eyn7mBpqrSQlHvw4h2fNwpcFx+Sag/NJjRfdlj2rc7zckJBhhmS91
	4kXEYJ6qp+JE7imyRcW0QMu1zaiv0PDAKgwIthwBsiPa8Coy9b/jMJfLXZVfd+kMTqJJuT
	AhNsJIybregwmL/IdvwHY6mjJTaPcjY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-a97v4srWPnqTu-X1zpKtOQ-1; Thu, 14 May 2026 08:01:23 -0400
X-MC-Unique: a97v4srWPnqTu-X1zpKtOQ-1
X-Mimecast-MFC-AGG-ID: a97v4srWPnqTu-X1zpKtOQ_1778760083
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48fdacf2616so4263955e9.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 05:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778760083; x=1779364883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Z56KOps0AG32fICJVPwzpfDBem2tIGZoRzP5xP0mtM=;
        b=eIkS460bSAdD9f0kvhVhm3P92UEK1dw+nuO+nP7f0OyktMqz9RWywCzXrDlN2IUU+C
         gcwewrqhTc7yCxZZ/ppnbPCu5Wr08UQBMV+YK7SftEwd2gcJ6eCLAIT5EAG0aZpeTy34
         7Oh+6vi6CNU6i28zbEVTJjjhc7bSrT5OdDpSVP7C2w5tWoEEWRYEqQhilXxbCo1xbsJ4
         Tg2BinWSwevoF0ezk2Vliypj9PbrBSxQ8LdvTJLwkDZNPyywWN48/54TTMGfO7yIa3+k
         YWG8XpTQns1t39a/wNM+Ay70bt2omBS0g/IpGa5Wdma0cbQkMvZYUmhp5FbzQYsCDrHT
         QdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778760083; x=1779364883;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Z56KOps0AG32fICJVPwzpfDBem2tIGZoRzP5xP0mtM=;
        b=k8I6qVuIC3QIJUM7R87FHiC6c/zqq+f78nSbvb41FgHfZD6KChhz/u7WdskGib2NUu
         E8I3V2kgdbMiTD+VJ27QMIXpkUuQ5PWAXSXSajigTvPLf8LRvK7Y1c2DObeg2LVGpfSs
         sAbfkX1TLkvH7oJJ2yuLkmY+CyZ4ueMgrtU0MWSK4CPdvpU0r5aZ/ihYdoapdmTYY+vJ
         FwtvwgHtlltWN4dI2eLjI2k3saQQ76d4HCyqzsj7P1URchcZx3a2xeTll5Q1QPmpGCrW
         i0h/HMxBsA2Sl2910JDcDBl50suMRVi13/tNPEeOXZ5RFzYNiWuW4H71xBEQrlv4cOnJ
         9GoA==
X-Forwarded-Encrypted: i=1; AFNElJ+POxbqRNl+2RL+fFvEoPnvsk620ashFuRCWyGHlAX6cJEWAHUTatG++QfBClDxFKSR3EAywcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh+IUq6cVQYAs/zKp6sS630wfvyWxelHhOLBXYTl22DTwAz5iZ
	3XEWOJ7PzMQOot26vdhg4oOy22Q5Hy3q2KlqtFXvgKrEuzZ+jf38YtiPpuydukRhyBU6gH3aQ3e
	KR6TNBx5dpKwpb0F8jLzPNpUWb49B4WfrJDgo9mse/uSOOLbj5OVbOBvwwg==
X-Gm-Gg: Acq92OFMlMRT+KTRNJvb2gtToic00Fj8xE5+Uy0qd2tr9JxiwuhL7qIlid8XvxPNe0d
	OszJTBAQ9g9stEwCi6Pa/vd1ex8Sxz2qN1044BpYw8U/qcMQ8d0gZLd6RBByJ2MAb90nGKthuQe
	nSl0LvaJHbhbEpnWHvH4K2GjH6z7SB+H+8Kxqjv1Ir6FHEDY2vJ2Z4whHUafXTknwDfpN4jd6tZ
	IjbskYwAt/7HAXk7WMRkDhXcPZlan+bPYJiVgn3H05tK+MWZMndtyPx6SyegbhIV+eb589GR5+e
	ud+CBgGYLnmXRHgvaFfuFBl2jYp9TZM72J+vXUV7HCbNGbjyJhn7rh+kp+P5ny7kJpHQdPusnmi
	cjGfl06j8jFl+VirjMPfkg3akUdaRZaIhwmRpMnY6iqbIrU+rk2tcSdI=
X-Received: by 2002:a05:600c:19ce:b0:48e:7f1c:8778 with SMTP id 5b1f17b1804b1-48fc9a34577mr102348245e9.17.1778760082596;
        Thu, 14 May 2026 05:01:22 -0700 (PDT)
X-Received: by 2002:a05:600c:19ce:b0:48e:7f1c:8778 with SMTP id 5b1f17b1804b1-48fc9a34577mr102347405e9.17.1778760082064;
        Thu, 14 May 2026 05:01:22 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd64cebaasm59995375e9.11.2026.05.14.05.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 05:01:21 -0700 (PDT)
Message-ID: <4ca19ae1-6606-433b-9860-0a8cce12f80f@redhat.com>
Date: Thu, 14 May 2026 14:01:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/stmmac: Fix free-after-use panic when interface
 goes does with XDP
To: Jakub Raczynski <j.raczynski@samsung.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, k.domagalski@samsung.com,
 k.tegowski@samsung.com, Chang-Sub Lee <cs0617.lee@samsung.com>
References: <CGME20260511165107eucas1p1882391435991ffc19670a60a43bbde01@eucas1p1.samsung.com>
 <20260511165045.3091475-1-j.raczynski@samsung.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260511165045.3091475-1-j.raczynski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B9D4E54156E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,foss.st.com,samsung.com];
	TAGGED_FROM(0.00)[bounces-287945-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/11/26 6:50 PM, Jakub Raczynski wrote:
> When running XDP forwarding and interface gets shut down, kernel might panic
> or show SLUB "poison overwritten" errors due to a race condition between
> NAPI polling and resource freeing.
> 
> Observed error is one of following:
> - Poison overwrriten
> [ 1889.547746] eth1: Link is Down
> [ 1889.549940] =============================================================================
> [ 1889.549954] BUG kmalloc-4k (Tainted: G    B             ): Poison overwritten
> [ 1889.549959] -----------------------------------------------------------------------------
> [ 1889.549963] 0xffffff882dcc4d80-0xffffff882dcc4da7 @offset=19840. First byte 0x0 instead of 0x6b
> [ 1889.549969] Allocated in __alloc_dma_tx_desc_resources+0x60/0x10c [stmmac] age=169 cpu=7 pid=27759
> [ 1889.550020]  __kmem_cache_alloc_node+0x100/0x2e8
> [ 1889.550032]  __kmalloc+0x58/0x1a0
> [ 1889.550039]  __alloc_dma_tx_desc_resources+0x60/0x10c [stmmac]
> [ 1889.550052]  alloc_dma_desc_resources+0xec/0x164 [stmmac]
> [ 1889.550064]  stmmac_setup_dma_desc+0xec/0x1e4 [stmmac]
> [ 1889.550076]  stmmac_open+0x28/0x94 [stmmac]
> [...]
> 
> - Wrong memory address
> [ 1901.546692] Unable to handle kernel paging request at virtual address dead000000000122
> [...]
> [ 1902.964068] Call trace:
> [ 1902.967193]  free_to_partial_list+0x560/0x600
> [ 1902.972227]  __slab_free+0x1a8/0x420
> [ 1902.976480]  __kmem_cache_free+0x204/0x218
> [ 1902.981254]  kfree+0x6c/0x128
> [ 1902.984900]  kvfree+0x3c/0x4c
> [ 1902.988545]  page_pool_release+0x234/0x27c
> [ 1902.993320]  page_pool_destroy+0xcc/0x190
> [ 1902.998006]  __free_dma_rx_desc_resources+0x100/0x360 [stmmac]
> [ 1903.004516]  free_dma_desc_resources+0x8c/0xac [stmmac]
> [ 1903.010419]  stmmac_release+0x1c0/0x2b4 [stmmac]
> [...]
> 
> Root cause is stmmac_release() stops DMA and frees TX/RX ring buffers and
> page pools while NAPI/XDP could still be accessing these resources in the
> background.
> 
> Fix this by following:
> - Set STMMAC_DOWN flag before stopping DMA to signal XDP to stop
> - Call synchronize_rcu() after stopping DMA but before freeing resources to
>   ensure all ongoing NAPI operations complete
> - Add STMMAC_DOWN flag checks in XDP code paths (XDP_TX and XDP_REDIRECT) to
>   drop packets when interface is going down. This has already been done for
>   stmmac_xdp_xmit() so make it consistent
> - Clear STMMAC_DOWN flag in __stmmac_open() to restore normal operation.
>   This was only done for stmmac_reset_subtask() during abnormal operation,
>   which is not enough. This does not affect normal operation as this flag is
>   used only for XDP apps

The above looks racy. I think instead you should just use
napi_synchronize() in __stmmac_release.


> @@ -5267,6 +5279,9 @@ static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
>  	if (unlikely(!xdpf))
>  		return STMMAC_XDP_CONSUMED;
>  
> +	if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
> +		return -ENETDOWN;

Sashiko noted here you should return STMMAC_XDP_CONSUMED

/P


