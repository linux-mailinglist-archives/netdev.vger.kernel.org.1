Return-Path: <netdev+bounces-297450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dsm+MUn+KGpIOgMAu9opvQ
	(envelope-from <netdev+bounces-297450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:03:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C936660E9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:03:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=bEZXHvEa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297450-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297450-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85B373044F3C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1C6282F30;
	Wed, 10 Jun 2026 06:01:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8799F175A6B
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:01:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071278; cv=none; b=dKTJcG2TTPKwGNvzakQivwgYjA1G5WANwCOjhz/fbFBSDx8+m4QizGeCzF73DssYSOPHlzKnvlSoWiD/G/9yJkZ3i/MJOYannn6fi7nRasZi4E0td8fIKFXM5s37ccDiuetojWzcU/5fbWKoM7Zv1YMkLi/Vbs6p6N3jQ8vMPz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071278; c=relaxed/simple;
	bh=d22dysJ9ul3imw15agwnp6CdqySU0ubk4ustNRb+gVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iovozk7YAjYCRF8LsZuZTftF/C+cd0FVSQfCqbP6NAEa3+tNG5iQ7CUsytXn5JgsXy+dEsL932NGS+fbrQ1KK/Mq36slyQtq1w+RjgXNBhixOZ4wnqwla557u53Twvk2wS8O272QAbXWsJ1/yJRsMMPksnqWsMU5fjr8Lrk95RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=bEZXHvEa; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so24773265e9.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 23:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1781071275; x=1781676075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KJOri1vVvgs1psxVjBImGebubNwTWt5B6RFAo7SJswM=;
        b=bEZXHvEaA2qHFz8HB9fIHtXYGSPCAcZYiUNfT4RLTXQ5uDPwMFSpcdkGNPLU1TXb3C
         KzSwyQ5SJl4SOVaTHmdDRZNSbBd79gCseh1GDvuFjgJNKIZvWzI5wEOxnEiLLXrIZkkm
         f9v+ioAkEgtOG+pqd/9eEcfJsHV+Bio1FJZZ3RzGMYghc8fuU1H8Yd6tQmrQdR+tvxbh
         EHHf5BXvw4aY3IB8l7RRdzmVQl6P5EwqH4oP52gvuaGe1tzPIlJeHsNWSO9+t9naS5ko
         OPcn1Q5DxFmBD9qvfzrNjAL8mGHhsI70XWngCpjH+hGuLreL1sEkNDYOkR5M9IMTa652
         9QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781071275; x=1781676075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJOri1vVvgs1psxVjBImGebubNwTWt5B6RFAo7SJswM=;
        b=U2p5Svb+afiMBgiLKfWBsrhS+DUCkkD3TyPCTwcXbl2+Ede01RjSrFnYYQ30R4tBbj
         mnp6ZEm8Gn7olW9JhZZn2wvTn4svpEo0997ZtVCCJHLVafR0LXXCsCqoJVhnEunKL/zu
         ISa+2ci4XN/3Uvg5hVb5QkX6HoU+2HFtlA4nIW0cIEzIAZJEoWbmN4uvo67MjPj26rUe
         18UuCt39WlNL059xOjTChIAnTFvY2qhbuUNvRkhyvU/JOI18Ge74DEzZOzB/1BYkpgJ9
         0D1l8EGjDh31Z5uYo1Q/DUcb1j21ck4Tc/Ms8jNvSgpBXGV/7FFl3Xdwd1Vp/A6i+lEK
         fI8Q==
X-Forwarded-Encrypted: i=1; AFNElJ93iTwj+CAZBN6FuHCVGfdR6iOdTk2xozcUoQs+94+uhnqClLVIIqjlrBtyOfK0M+5W2bJIfm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAzNyCoggLtZfJfynIGt7gv3C/BivRjLJwVBv8L3TOFdQFu8Hm
	KGmzXlRfvEHmhqWTVVnZnnVIyzrciprFbd7D7SRb6k1ikX/iQTTuc30QUYPtMqcztM8=
X-Gm-Gg: Acq92OFwij/AzQUUEivn6J2iWdMMGwZE23jR9/fVgMmip14VYjia9zKsJwD/3Oxx3A+
	3tb1aLGjrn3/XbWEWZ3hd89Osl8qpKiyJ20rw9IoSHy30hmorNR+R9PdmSeQbFgw9tUmnWUTzG7
	lpVXr/lYACLqz8CDl3jq+9OhnJcwRDyRMMJX5XGCa1rJZOu5BnWsbzz8jzJahv3ak3/BNW8uM9q
	Z5LlVmdF7RFvZLYjLBRuvq1d1T0BKPOMWwJ37zOj6/4SpYCzbwoIbT61IExYRtttHak1Vu9CwD3
	lhmtmfS4Xg11sD9Z5dYGtNf+QrBO5WUhesvKaN5jyNYd0QEkJsTLm4MytHMb7pEHikqI4h3wez7
	ni3RqDAqn/pZjCyMUrwsYptdkUAufrWmzVhn4zar+zx8c9EJiEy50pvIWdY1Ww/MZE6k4v+85CV
	Kq0u+hjAza/oMu1qGERc+HA3/ztqxJMdkIOTDB92APnmMT/tWcv03xbECK6bHVg78l
X-Received: by 2002:a05:600c:628e:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-490c2599ff8mr407460545e9.4.1781071274400;
        Tue, 09 Jun 2026 23:01:14 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fcf5bsm642743655e9.9.2026.06.09.23.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 23:01:13 -0700 (PDT)
Message-ID: <20eb0404-dd06-4845-aaaa-e157e120829a@blackwall.org>
Date: Wed, 10 Jun 2026 09:01:11 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Stop leased rxq before uninstalling its
 memory provider
Content-Language: en-US, bg
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: ahmedabdelmoumen05@gmail.com, netdev@vger.kernel.org,
 Bobby Eshleman <bobbyeshleman@meta.com>, David Wei <dw@davidwei.uk>
References: <20260609212240.677889-1-daniel@iogearbox.net>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260609212240.677889-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297450-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:kuba@kernel.org,m:ahmedabdelmoumen05@gmail.com,m:netdev@vger.kernel.org,m:bobbyeshleman@meta.com,m:dw@davidwei.uk,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,meta.com,davidwei.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20C936660E9

On 10/06/2026 00:22, Daniel Borkmann wrote:
> netif_rxq_cleanup_unlease() tears down the memory provider that was
> installed on a physical RX queue through a netkit queue lease. It
> currently revokes the provider's DMA mappings before stopping the
> physical queue:
> 
>    __netif_mp_uninstall_rxq(virt_rxq, p);            /* DMA unmap */
>    __netif_mp_close_rxq(phys_rxq->dev, rxq_idx, p);  /* queue stop */
> 
> This inverts the ordering used by the regular teardown paths (normal
> device unregister and the io_uring zcrx close path), which stop the
> queue before revoking the provider's mappings.
> 
> With the physical queue still live, its NAPI can keep consuming
> net_iov entries from the page_pool alloc cache after the
> __netif_mp_uninstall_rxq() has already cleared their dma_addr,
> opening a window for the device to DMA to a stale or zero address.
> 
> Fix it by swapping the two calls so the queue is stopped (and its
> NAPI quiesced) before the provider is uninstalled. No functional
> regression was observed across repeated runs of the nk_qlease.py
> HW selftest, which exercises the lease teardown path; this was
> tested against fbnic QEMU emulation.
> 
> Fixes: 5602ad61ebee ("net: Proxy netif_mp_{open,close}_rxq for leased queues")
> Reported-by: Ahmed Abdelmoemen <ahmedabdelmoumen05@gmail.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Bobby Eshleman <bobbyeshleman@meta.com>
> Cc: David Wei <dw@davidwei.uk>
> ---
>   net/core/netdev_rx_queue.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index de4dac4c88b3..00a7011eb4d5 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -338,12 +338,12 @@ void __netif_mp_uninstall_rxq(struct netdev_rx_queue *rxq,
>   void netif_rxq_cleanup_unlease(struct netdev_rx_queue *phys_rxq,
>   			       struct netdev_rx_queue *virt_rxq)
>   {
> -	struct pp_memory_provider_params *p = &phys_rxq->mp_params;
>   	unsigned int rxq_idx = get_netdev_rx_queue_index(phys_rxq);
> +	struct pp_memory_provider_params p = phys_rxq->mp_params;
>   
> -	if (!p->mp_ops)
> +	if (!p.mp_ops)
>   		return;
>   
> -	__netif_mp_uninstall_rxq(virt_rxq, p);
> -	__netif_mp_close_rxq(phys_rxq->dev, rxq_idx, p);
> +	__netif_mp_close_rxq(phys_rxq->dev, rxq_idx, &p);
> +	__netif_mp_uninstall_rxq(virt_rxq, &p);
>   }

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


