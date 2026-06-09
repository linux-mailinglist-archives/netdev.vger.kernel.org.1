Return-Path: <netdev+bounces-297056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gzB0OjsbKGo7+AIAu9opvQ
	(envelope-from <netdev+bounces-297056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 15:55:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB13660C5C
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 15:55:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=GaePByQ2;
	dkim=pass header.d=redhat.com header.s=google header.b=jK9aVJGT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297056-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297056-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D12E302E900
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 13:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8DD4279FD;
	Tue,  9 Jun 2026 13:49:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1A4183C0
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 13:49:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012973; cv=none; b=B1ZBKJ9Nr63QexQCgP0eq3c2cGArvB3nsJH3i1rmSY5jJuQ6YV1k2iTj/2+Y6T3k6sXUoZZFShUD8oZwVEryT6lv7y+ARwjm5c7lS6ztpfYD2qv7+o64Kpa1yHYo23NJ2kKWc5mjbNg33zkNslCrJ0XhUfNIwYsxCzZCJmm1MwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012973; c=relaxed/simple;
	bh=52hnpEEgmB0qWOhFXmQimr5kmQmV0hK1rKA90td2mpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pu5BlEnYxATiOleK95thi4YwDTM9Jx0YHkgGgWsfF2y5ChPlaPeUEJbs9l9z9PvOI9dsBcbK0I+OxT6WqPkFwqk1bAQnwq/WYfQzeOQU0V2RATdHVeR+ileZ04d0nFYng7q/Z8Eo9CyclSlj79H2A9olacENIKAsx+/uw8F/QWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GaePByQ2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jK9aVJGT; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781012971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6ZyLSFW2ZGo0KhUw8PJ3xCFPCwEjsrRdGcTeemtK0Q=;
	b=GaePByQ2vg2sG8WhPP2DNlvjf0+G0scmuaIf/0VGDxLxvfUXcMjthGV8aXN9fF08gTqDul
	UVAkGzSMo6X4apAM4A4lj7ZUYdvGXJKKpJppqRYgtS2UvMWr7QXyUDuNI5ruVSOuQYKzfu
	lqDVCksW0DYHnub9kKdDmPiXZciWEQA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-5JBwRf0INRa7Hr0NTJwOTQ-1; Tue, 09 Jun 2026 09:49:30 -0400
X-MC-Unique: 5JBwRf0INRa7Hr0NTJwOTQ-1
X-Mimecast-MFC-AGG-ID: 5JBwRf0INRa7Hr0NTJwOTQ_1781012969
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b37e1f47so49268035e9.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781012969; x=1781617769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s6ZyLSFW2ZGo0KhUw8PJ3xCFPCwEjsrRdGcTeemtK0Q=;
        b=jK9aVJGTxv8be1+tKzicU7/AOu5CStC3IF11kDiUoOs5TCuXNHt70oGKCJ/NXnuWnq
         Qrp0SI4A9Q1W/D0+Y/KagkERSITlruDORdL/XEBHrCeg9HyhO+QK2X3MLgPjbQj8neef
         m5520zjbb7S8hL7CgC3V8K8UgsZF57KOPiD6ysud22c2m7BgoR7nhPfTh4RV43a7DLfL
         o004DPFsvYEnrgUY6xylZUuulPdq8fffA9QEExifr/5GemmYWurs5vb3WXvtC21jdOJ7
         9wxDHoLMLYfNCuIqrXPLClxM3AeJHcZQ2NoUMp2I8YtnweyQtcdCdyciOa2/sJ/6R+NR
         X3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012969; x=1781617769;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6ZyLSFW2ZGo0KhUw8PJ3xCFPCwEjsrRdGcTeemtK0Q=;
        b=h1SY6n0YIzK16r2dcDNc05HdFBFERfsu4Ff99C9R9H0Gs9h966XwvK94LXdKHId+a5
         sA13AfDplEV4nlq6TiRZci3Gm5QyWjmeclqwp20IHb+MvM/1wxGqBP2CK7Xy5ijS4EYk
         +JQoLUwviOX3ItlDCM0u5iMNn2bXyp1WNOzu4mfLljwVRw2LLJGgyqg95PMTNypxzXa8
         HrkGV/yKR3J3cpY050MStC3mJnTopYafO1/fBqDXBw2z/bxJZkb+O1Bv6LATQiRFdq9E
         amogpEaMnVDa18Z/00DmQdlJtD3oNhsNOIceHOr7pzWR4DX525xsU9vX1bCPRGpLPaBT
         Vbyw==
X-Forwarded-Encrypted: i=1; AFNElJ9On6WLka0t3QkWTpufhuas6bA8lPG+PPJZ9NUbbKLjJ9JUCuO6usB88UNMYX1J2Tthf57mzCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyABQPYA4b0yWRrnZWyq1wEtbD0Oqrtf33xaLhKyfXB60RKxuNm
	gEwAEnPytHP6jo2K8EqN4z/7s6GjPL0bSGGqPoYNijo4E9CWWphtd1YZaJb8EfdFKPGTa+UlSCK
	GTGhjABV4ZltuxnytqFwF6kos/xcag1de94uUrpSgjQAOYKtlrQ2nI6cSFg==
X-Gm-Gg: Acq92OEIumlhSv2psuJpdWtU3/hI0PfX1fUZx8MSFIbXe8T2Lw3FzxFSKzI8FCy+N5S
	gRo5uDxlxnqnMJb3c8SsfOLZ/TnrEECpfyofjHVHH+wHCvXB1yB1w//rbfO25r7vd/SvZ2Gbd1p
	d953zhZnjdTbI+6HWrxnrNkZAbIT/cpLBynP/IsX0JwNa9PRXInzj1kiPdGj/eyZM7oWmHY23Be
	d445TPJ0Ts2f8IikvC9CTXgee2V2+oMZoXhgPnaoygURRRWLUu/x3b7DxFZou3ZO52BpMBbkc80
	YyOaqgQd+jPJYR/XsfaHYBgbVsgg/25YL8Icx/32oQdQ+vy5J9b+KAHhNCzu6moDsw7tjkB/xw7
	swaL267I2DkMBpH8s5N6OyCbJD2zUJncLlRa50PNeEXEvdu4j/IplucjqRNx5id6NoA==
X-Received: by 2002:a05:600c:198d:b0:490:9d1b:f086 with SMTP id 5b1f17b1804b1-490c25baa0bmr347625725e9.14.1781012969038;
        Tue, 09 Jun 2026 06:49:29 -0700 (PDT)
X-Received: by 2002:a05:600c:198d:b0:490:9d1b:f086 with SMTP id 5b1f17b1804b1-490c25baa0bmr347625035e9.14.1781012968602;
        Tue, 09 Jun 2026 06:49:28 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc23394asm480555685e9.0.2026.06.09.06.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 06:49:28 -0700 (PDT)
Message-ID: <dcd35c42-3aae-4ba2-bd84-4af08467b2fc@redhat.com>
Date: Tue, 9 Jun 2026 15:49:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: mana: Add Interrupt Moderation support
To: Haiyang Zhang <haiyangz@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Konstantin Taranov <kotaranov@microsoft.com>, Simon Horman
 <horms@kernel.org>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
 Dipayaan Roy <dipayanroy@linux.microsoft.com>,
 Aditya Garg <gargaditya@linux.microsoft.com>, Kees Cook <kees@kernel.org>,
 Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: paulros@microsoft.com
References: <20260604234211.2056341-1-haiyangz@linux.microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260604234211.2056341-1-haiyangz@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297056-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:haiyangz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:kotaranov@microsoft.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:kees@kernel.org,m:leitao@debian.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:paulros@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EB13660C5C

On 6/5/26 1:41 AM, Haiyang Zhang wrote:
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index db14357d3732..b1e0c444f414 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1551,6 +1551,9 @@ int mana_create_wq_obj(struct mana_port_context *apc,
>  
>  	mana_gd_init_req_hdr(&req.hdr, MANA_CREATE_WQ_OBJ,
>  			     sizeof(req), sizeof(resp));
> +
> +	req.hdr.req.msg_version = GDMA_MESSAGE_V3;
> +	req.hdr.resp.msg_version = GDMA_MESSAGE_V2;

Sashiko noted the above cold break initialization on older firmware:

https://sashiko.dev/#/patchset/20260604234211.2056341-1-haiyangz%40linux.microsoft.com

[...]
> +static void mana_update_rx_dim(struct mana_cq *cq)
> +{
> +	struct mana_port_context *apc = netdev_priv(cq->rxq->ndev);
> +	struct mana_rxq *rxq = cq->rxq;
> +	struct dim_sample dim_sample = {};

Minor nit: please fix the variable declaration order above. Other
occurrences below.

[...]
> @@ -440,17 +474,94 @@ static int mana_set_coalesce(struct net_device *ndev,
>  		return -EINVAL;
>  	}
>  
> -	saved_cqe_coalescing_enable = apc->cqe_coalescing_enable;
> +	if (ec->rx_coalesce_usecs > MANA_INTR_MODR_USEC_MAX ||
> +	    ec->tx_coalesce_usecs > MANA_INTR_MODR_USEC_MAX) {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "coalesce usecs must be <= %lu",
> +				   MANA_INTR_MODR_USEC_MAX);
> +		return -EINVAL;
> +	}
> +
> +	if (ec->rx_max_coalesced_frames > MANA_INTR_MODR_COMP_MAX ||
> +	    ec->tx_max_coalesced_frames > MANA_INTR_MODR_COMP_MAX) {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "coalesce frames must be <= %lu",
> +				   MANA_INTR_MODR_COMP_MAX);
> +		return -EINVAL;
> +	}
> +
> +	if (ec->rx_coalesce_usecs != apc->intr_modr_rx_usec ||
> +	    ec->rx_max_coalesced_frames != apc->intr_modr_rx_comp ||
> +	    ec->tx_coalesce_usecs != apc->intr_modr_tx_usec ||
> +	    ec->tx_max_coalesced_frames != apc->intr_modr_tx_comp)
> +		modr_changed = true;
> +
> +	saved.intr_modr_rx_usec = apc->intr_modr_rx_usec;
> +	saved.intr_modr_rx_comp = apc->intr_modr_rx_comp;
> +	saved.intr_modr_tx_usec = apc->intr_modr_tx_usec;
> +	saved.intr_modr_tx_comp = apc->intr_modr_tx_comp;
> +
> +	apc->intr_modr_rx_usec = ec->rx_coalesce_usecs;
> +	apc->intr_modr_rx_comp = ec->rx_max_coalesced_frames;
> +	apc->intr_modr_tx_usec = ec->tx_coalesce_usecs;
> +	apc->intr_modr_tx_comp = ec->tx_max_coalesced_frames;
> +
> +	if (!!ec->use_adaptive_rx_coalesce != apc->rx_dim_enabled ||
> +	    !!ec->use_adaptive_tx_coalesce != apc->tx_dim_enabled)
> +		dim_changed = true;
> +
> +	saved.rx_dim_enabled = apc->rx_dim_enabled;
> +	saved.tx_dim_enabled = apc->tx_dim_enabled;
> +	apc->rx_dim_enabled = !!ec->use_adaptive_rx_coalesce;
> +	apc->tx_dim_enabled = !!ec->use_adaptive_tx_coalesce;
> +
> +	saved.cqe_coalescing_enable = apc->cqe_coalescing_enable;
>  	apc->cqe_coalescing_enable =
>  		kernel_coal->rx_cqe_frames == MANA_RXCOMP_OOB_NUM_PPI;
>  
>  	if (!apc->port_is_up)
>  		return 0;
>  
> -	err = mana_config_rss(apc, TRI_STATE_TRUE, false, false);
> -	if (err)
> -		apc->cqe_coalescing_enable = saved_cqe_coalescing_enable;
> +	if (apc->cqe_coalescing_enable != saved.cqe_coalescing_enable &&
> +	    !modr_changed && !dim_changed) {
> +		/* If only CQE coalescing setting is changed, we can just update
> +		 * RSS configuration.
> +		 */
> +		err = mana_config_rss(apc, TRI_STATE_TRUE, false, false);
> +		if (err) {
> +			netdev_err(ndev, "Change CQE coalescing failed: %d\n",
> +				   err);
> +			apc->cqe_coalescing_enable =
> +				saved.cqe_coalescing_enable;
> +			return err;
> +		}
> +		return 0;
> +	}
> +
> +	if (modr_changed || dim_changed) {
> +		err = mana_detach(ndev, false);
> +		if (err) {
> +			netdev_err(ndev, "mana_detach failed: %d\n", err);
> +			goto restore_modr;
> +		}
> +
> +		err = mana_attach(ndev);
> +		if (err) {
> +			netdev_err(ndev, "mana_attach failed: %d\n", err);
> +			goto restore_modr;
> +		}

You should try hard to avoid this sequence: if mana_attach fails,
mana_set_coalesce() will leave the NIC unexpectedly down.

/P


