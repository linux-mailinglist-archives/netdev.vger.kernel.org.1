Return-Path: <netdev+bounces-297357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TpCbBbirKGqeHwMAu9opvQ
	(envelope-from <netdev+bounces-297357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:11:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E41B664E7B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:11:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="LUXJqJW/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297357-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297357-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2CBE301DE18
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8049B26ACC;
	Wed, 10 Jun 2026 00:07:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD152110E
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 00:07:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781050050; cv=none; b=Eb7jdRUshRPfIrSaxYjy9dRwIOQkHR5XEiw4nM4wQQfo1u6P+eYutDCnH8p0etRC19bUn/uEL3eaN5a9eWhNGLV14lvEMMKKN0CKKp2QSuTPYx0RVbyLwg97FzePmQpwwuu0xaIeWGcsQSU6dgavf9iPpRWvDOx5USp4ttzUC1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781050050; c=relaxed/simple;
	bh=R6wTFJerY4zHzLwR6/5A/fKdajgXueZUllJW2IW4pb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDpI18VVn0+pIYe2SMZGGvpaqHER4yI5hO3cpbL3YM8GOwTuZtk3+SJQ5ZiuEL/tzQQKqBFP2qwZyNwxRY+SPpqm4glGqb1b47zun5cAH/0o9HemlC8AtWH+UmEr4RgRtRUP0ZWw6IGoXV2wY3I1rt8XD06t4ygaoRhld8ODFpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUXJqJW/; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0c3315c5dso64479145ad.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 17:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781050048; x=1781654848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4V1HBHg1t0TYFtJtz4MVUwS8GXsguTkqaJWA9cR8iwg=;
        b=LUXJqJW/zJMmtqHla46wwCltY/O9sJyysTPur+yTk4KUVTWS16mbn5apLUifTXDK2K
         NU9ulYmC8+rIFPFLeECiw+JSG4GVNoYmGXMgWE9ce1P+Pf8DhozOBV4gh2O4Z23KGgqU
         ikBl0nDlZ3333Tnw9RIsLOIBwCUCPefASzM/i5DB6fSKepE4X+ReFxURBiv+3dsWgb1H
         LTWylh1h4onDFhQG0t3USVlnz1tXxKYjetvCyt0EJZC8oOlbwB4PTT3mr/C+8D4URuYY
         ngnyphwY937F1Qz1k7mnYqauNg2bXYaIsuAFF+QcVEzs3VLBdMj3C4Y7AvM4ZnJ9Kfy4
         LHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781050048; x=1781654848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4V1HBHg1t0TYFtJtz4MVUwS8GXsguTkqaJWA9cR8iwg=;
        b=l1pGl1qZSQXvgSi9BQD06JQVJbVxbbtAS+q+zbt8CeBqZC43Tqp6Dz0xDB3zX3BDmw
         3JY1dwVPoYrI4fgl2cy9a0iZSwcOplN7qnZmfYvoz2T36LecpNHZmhxWknwKXo725nRE
         tWHc1ROMwAE0mtTg2dsY0AoeJTPIWECRLxMzu1hqcOhKG79CreA9FAHcUNjDIDUeo4a7
         o2I5m1J8atPATNH5p413CSRN3kuBZOnYAyYfaci9Xr7qSWwlmzLsbpQlVCE2eFaPsH2S
         7Oj8tZTHTODVaa0byx0EVWCSE51N/m3HtfNKqa0B/fdWTq52eyJnL9tIBGFvKG6XnNPT
         Q2ww==
X-Forwarded-Encrypted: i=1; AFNElJ+EjzW46RAM7Uvuy2bXuMtnVtcxORP2V6PeSACJvytMQze6RVYxiSitHcwKfAAkGv3drM/HAjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfiUIBjU6VEUMltIBacL1FlYENaUp6h/u2X3ujGgdFlkyCfW9J
	rOzktyED+466US4dn0CCYPBmpfswRQYEmy/yniddTfUI10aFFRc2QFTc4BuuJuDA
X-Gm-Gg: Acq92OEkR1mXoyT+0UCltFIYzsOop8FFTBvgUVkgPoJ8w9WqB/tKTwM4T5ZWJWJHPDT
	FcPdgEyvKSX3BbNiPr6kuE4vWvFo99UlPIlpfNRYnTbbC4P5o6zE+ylkQ/UuRaT+Dym80ZLQxiQ
	EHW9tFZ6RItg/R6WRBEf6gNC5HabF+0cDq62ErZquiG+hXFwbDWzHwxC64penGtxWxHArukgdwh
	iiYD76JGrgzZEbKlDOoWJ2U1T2xCaMDdv64MW1XobYf2u4vBP1UNLmkRZ//oGnzcD/LimW5UPiX
	bYs8jh0dH1NrOJnUSxFUXnpAO/XcX9n22gdGn4bV4GkT9F2vN5hf72jMEOd3dKRkeJ/kyna7U9k
	UiPxto8k+L9/mWFC3TKu5kSBuoxUzKtC5N5DAgmYfq//zN+LtKZSfNnCOwomK0l3nHguS9wA+/q
	scPfnlIhrYnISWs6RsZNQ8hbXlZFDfauHuyx9ZLMqHRQwu7g/Sj3ZxEn0=
X-Received: by 2002:a17:903:3885:b0:2c2:27be:39a9 with SMTP id d9443c01a7336-2c227be3b30mr225016415ad.9.1781050048350;
        Tue, 09 Jun 2026 17:07:28 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm294792295ad.9.2026.06.09.17.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 17:07:28 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:07:26 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, razor@blackwall.org, ahmedabdelmoumen05@gmail.com,
	netdev@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next] net: Stop leased rxq before uninstalling its
 memory provider
Message-ID: <aiiqvvjwas6i+LeA@devvm29614.prn0.facebook.com>
References: <20260609212240.677889-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609212240.677889-1-daniel@iogearbox.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297357-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,blackwall.org,gmail.com,vger.kernel.org,meta.com,davidwei.uk];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:kuba@kernel.org,m:razor@blackwall.org,m:ahmedabdelmoumen05@gmail.com,m:netdev@vger.kernel.org,m:bobbyeshleman@meta.com,m:dw@davidwei.uk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,davidwei.uk:email,nk_qlease.py:url,iogearbox.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E41B664E7B

On Tue, Jun 09, 2026 at 11:22:40PM +0200, Daniel Borkmann wrote:
> netif_rxq_cleanup_unlease() tears down the memory provider that was
> installed on a physical RX queue through a netkit queue lease. It
> currently revokes the provider's DMA mappings before stopping the
> physical queue:
> 
>   __netif_mp_uninstall_rxq(virt_rxq, p);            /* DMA unmap */
>   __netif_mp_close_rxq(phys_rxq->dev, rxq_idx, p);  /* queue stop */
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
>  net/core/netdev_rx_queue.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index de4dac4c88b3..00a7011eb4d5 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -338,12 +338,12 @@ void __netif_mp_uninstall_rxq(struct netdev_rx_queue *rxq,
>  void netif_rxq_cleanup_unlease(struct netdev_rx_queue *phys_rxq,
>  			       struct netdev_rx_queue *virt_rxq)
>  {
> -	struct pp_memory_provider_params *p = &phys_rxq->mp_params;
>  	unsigned int rxq_idx = get_netdev_rx_queue_index(phys_rxq);
> +	struct pp_memory_provider_params p = phys_rxq->mp_params;
>  
> -	if (!p->mp_ops)
> +	if (!p.mp_ops)
>  		return;
>  
> -	__netif_mp_uninstall_rxq(virt_rxq, p);
> -	__netif_mp_close_rxq(phys_rxq->dev, rxq_idx, p);
> +	__netif_mp_close_rxq(phys_rxq->dev, rxq_idx, &p);
> +	__netif_mp_uninstall_rxq(virt_rxq, &p);
>  }
> -- 
> 2.43.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

