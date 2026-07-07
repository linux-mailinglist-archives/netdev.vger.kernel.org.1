Return-Path: <netdev+bounces-305389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5JQTGlbMTGqmpwEAu9opvQ
	(envelope-from <netdev+bounces-305389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:52:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9292719FB7
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:52:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.s=20251104 header.b=WmmDCAQc;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=riscstar.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305389-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305389-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75F80302C915
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 09:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED003D75B1;
	Tue,  7 Jul 2026 09:48:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3CB3D6CA0
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 09:48:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417736; cv=none; b=u9Kd8sGqshZNaNKQ0CQvc1OzCTHD/wJscKzMyPna6y6iVAFAqFPhzoUAWmzeIgWGFXNItLiTzfnvYOWc9wZdSmmrKfwQ2G0rYJ2DBZ/xmTsL4JJKYQ53oAD3BNup1i33yJa22NW5LiymUx268DoZPKCusIaRrWzIJIoMcYbjQ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417736; c=relaxed/simple;
	bh=dxErGz/gtuJMMd0ZCUwsU0QRw3tKi/SSEtrZ2mEv2ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHWd4dQx9sKcc/vCfFtnNNoKrZJtmHJCovGontJJSw4/2PYU5N7iV3AJ0+Jx5JhrgYJxbyv+tEqZroYYfh5ofbXodlzle66w0F0zNM36iu90nZoqKRTAcxPVai8uWdsLeY/rIAFtUjGsMJL4TBc+mIM/esHhjx3XqUMEzVAA6qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=WmmDCAQc; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b7612475so37121065e9.3
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 02:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783417733; x=1784022533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs3A+LONAtni+h8Qp1wmlltG03uWEkxp59/Fd3Ox+rE=;
        b=WmmDCAQcONqxk8QJsEcXqFwhg5sYGEf8xrpamiqLkwYdRbxOBRrJN/i29BzoAXcTgS
         k5hXvOuvttmuf2y7ZHOViUajJuhaMkyUBDWR8eg537kXOx/1jz3tuhX0ifR88nk2tJ+b
         l9WQNxWWuUIv3OFmvIrIpcqAo5LyInMH1s0WBaSzBD9/UMuiTDXrF40U7uP3FpFT4bLI
         AHSp0whB9b9JMnJW4L7eYN4Xgmh6NdnDe73jLVji6bS6JBMlSMQh04uNMmuverWCfw99
         JXr8HgmQOS6ah49YklfN+e0+QNbBDQuVpHn2e4hprBvTK+1iHWg1gEJy5vjEdHG9Q3i7
         aQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783417733; x=1784022533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qs3A+LONAtni+h8Qp1wmlltG03uWEkxp59/Fd3Ox+rE=;
        b=e0szrRqBCVLA3Jxq+zpWPQRGeRKifsTmuuCqvrlwEoIEjWN39THJb4WI72wCyxbllD
         jjT78hOhy8hWnOcUcTeb//vh1nkyGnT4I8iQbDm9MgR8cFFhGs83yMTTiFdoDNGuGD9E
         /79kSgOOjSnNhXlBkZZP/Qxn1GTicXxHQwwa7IvPtXkGh/p93VmGqFrCm8JD528FBqN0
         aK2hIdZdoNPM76M3QHZEclMebNWZOm0Z35PfdZA0VhYM0Jj/cw6pziia3o+LFOg0PCLo
         DiIzBrwMeDJ2AnKOQ7ryWGWunrFGOWpY74lF3hDoCVp1mIkSmURwLtz5d4wVmO2wLAkd
         FNKQ==
X-Forwarded-Encrypted: i=1; AHgh+RpORuj21rsGK/ZCPRP/gpC6C655UtVp4e5DDvVRzIHG3f1vXlgSAw7PV4X2peD0A2se4P7zedM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuO1t6iks4TY29oIXjQlraSKq+io5xc7MEDO3N4zGnVw31FuHJ
	4UB87vJF71gGEjy0PLCcHqCRO8bqy2XeCFE/DgH1Mg39oxqqxF2IdtXy8fQkAoL6swk=
X-Gm-Gg: AfdE7ckWvqEhAHk83LrKgJ4F0nl8JNq9ZkZL5Gs8yx9HPooflKDHGoa1917d4SEpcRq
	6yB+xXz7Kl1HhegWUByxU30OqeBfIEWaqcvJOxuSZTHNX3V6FVvmiCZOoZieAFRrdp1kcPdjYPa
	laeAQ1aJG+s6A2LAbmEO68mRYNR8wXXtVNGid74VeibNs2bPVwb6yQ0TAlu0weD+D7VB2DCO0ej
	vGifoEeSZhVAOsc9pQnlXk8NyRu9NT/P3GOeWOmv0QkZERimn7VDB0qIPV4vFvYiP0kjPRG+X1Z
	IFu5gK+aPazezcO6kIb7hJVw8w1/YBbLIP1U7/e4LdKjc72L6M0m4ruq0aHs6/+sWOYNTfksPUL
	BBHFwGlfw90j3GjLvATAY0A/KchhQvCIUlv2OCtfec6o/CzLBkaQnJZbmcMAKFkk/im24cJJJmM
	b4JGu9rypZriYLqNfC0MAxtntBW37MdYDXUskpK5+EaadGUXcT2X7/2GllW459XtQ3G1x/XpNq3
	gKzzKC60+qtr8spIzJzRUD25fRkOfWEEfZ6OzZ1rCZdq3lzZnHk33tRcXRSH5N7ctowerJSVg==
X-Received: by 2002:a05:600c:8b67:b0:493:bd2f:c5dd with SMTP id 5b1f17b1804b1-493df08c35dmr46181645e9.21.1783417733495;
        Tue, 07 Jul 2026 02:48:53 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0078d49sm47904175e9.0.2026.07.07.02.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:48:52 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:48:50 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: Alex Elder <elder@riscstar.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Avoid freeing and re-requesting IRQ during
 XDP set prog
Message-ID: <akzLgrzsw4xYmnLH@aspen.lan>
References: <20260706-tc956x-stmmac-no_irq_teardown-v1-1-df009d0272bf@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-tc956x-stmmac-no_irq_teardown-v1-1-df009d0272bf@riscstar.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:elder@riscstar.com,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,iogearbox.net,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[daniel@riscstar.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305389-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@riscstar.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[riscstar-com.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp,aspen.lan:mid,riscstar.com:from_mime,riscstar.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9292719FB7

On Mon, Jul 06, 2026 at 05:17:58PM +0100, Daniel Thompson wrote:
> Currently stmmac will run a full cycle of IRQ tear down and setup when
> setting up a new XDP program. This makes tuning TSN systems difficult
> because whenever a new XDP program is installed then the irq threads will
> be stopped and restarted which will undo any thread tuning.
>
> The problem is avoided by removing stmmac_free_irq()/stmmac_request_irq()
> from stmmac_xdp_release()/stmmac_xdp_open().
>
> stmmac_free_irq() implicitly synchronizes interrupts and, with that
> removed, I was unable to prove that later actions in
> stmmac_xdp_release() are safe when there are concurrent interrupts. To
> avoid problems let's also move the code to disable DMA interrupts earlier
> in the sequence and explicitly sync the interrupts handler(s).
>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> <snip>
> @@ -7156,10 +7201,8 @@ int stmmac_xdp_open(struct net_device *dev)
>  	stmmac_reset_queues_param(priv);
>
>  	/* DMA CSR Channel configuration */
> -	for (chan = 0; chan < dma_csr_ch; chan++) {
> +	for (chan = 0; chan < dma_csr_ch; chan++)
>  		stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, chan);
> -		stmmac_disable_dma_irq(priv, priv->ioaddr, chan, 1, 1);
> -	}

Sashiko picked up that stmmac_init_chan() has the effect of enabling DMA
irqs, making this code unsafe.

Given stmmac_xdp_open() can only be called on a running interface (and that
stmmac_xdp_open() explicitly sets sph) then re-initializing with stmmac_init_chan()
should have no effect and we can drop that as well.

I'll double check with a code review across all the dwmac versions
before pushing out a v2!


Daniel.

