Return-Path: <netdev+bounces-304524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +3pnDRakR2oQcwAAu9opvQ
	(envelope-from <netdev+bounces-304524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:59:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B0C7021C1
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:59:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Edpl+wxp;
	dkim=pass header.d=redhat.com header.s=google header.b=MBYHe8Xt;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304524-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304524-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5160C3006159
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 11:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BC13CC33C;
	Fri,  3 Jul 2026 11:55:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC133C416B
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 11:55:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079747; cv=none; b=GqR/iwfCqAU7ZllLW4deJ21o0SKWo2oj/dTg+1vnrmB7WffpovePT4U0BvELkjHeo5NIPDS5jE3VX+LbED1R8CIfGTFw+7WqHB0UtCZ/50Yf7C8Cmf0BQAA37t9yrc/8jFTMLhj9GZrm+iR66pTLfYo1UaQ496k0IruuGNpQPI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079747; c=relaxed/simple;
	bh=gx+Opbiuesxxetpo+OTPT6kTeiBuIGRqPbf2vmcAhMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cf8pwOdtmfgdpqfPDZi4WS+ABSnVF9OjBbcmhQweErdAVLgp4a6ZsDcnTCxyChLOs0BFqAgDc2rlypGYtr92ZNTYnU67vLDQVg3guXBAvqlT8RdfHcatzBo4YmOtbxsBokbmhzPuvdQWmIUYofjIjOG0QLluiIKc1jPcjLRFG/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Edpl+wxp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MBYHe8Xt; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783079745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EMUE4aQBQf5gDaVLs1aXgAur2VD1yy3m5vYBxXEcv0k=;
	b=Edpl+wxp9O6va3oEv7Z+utPNstnyuTZ5Dhtlzrj3D3XNLUf1IRTmH3t93pCLgdqzd/xa+i
	mYv7aVIJ8UTnD2BXK5QwsES+baXN3fEGehSy6rvo4x78/FhDu2CjMmCYQ6VtgpFmuNcOyj
	+3vhciew1QZkb+mymRQxXwrNnX8wk+w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-ZXZY7VDyOpy7xVcOpjTLGQ-1; Fri, 03 Jul 2026 07:55:44 -0400
X-MC-Unique: ZXZY7VDyOpy7xVcOpjTLGQ-1
X-Mimecast-MFC-AGG-ID: ZXZY7VDyOpy7xVcOpjTLGQ_1783079743
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490c56e2576so3959845e9.3
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 04:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783079743; x=1783684543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EMUE4aQBQf5gDaVLs1aXgAur2VD1yy3m5vYBxXEcv0k=;
        b=MBYHe8Xt2bbqaLZz48NtXYHazuVWJa9vJHh2uFzpIqclMf3zzXiroBsrPIMwTEvO19
         ysQPk3JPeaoGQUgVutfkeA4arKf7mxgCpl7v4dSYbmYiQCGVotI+zfZPU/7iGpveSUhO
         catdr7r8TRJJC2zWSl/qkP3PVHnGZI4eLSftMs7ZwMpojIfZsM1JoSp1TN8+Ud/bHRh6
         +4c7G+KxfHJx8sLY5vXlNpuQQTOTOrKhHi/dHjX++/AjgE7lxoM49HRsKVISkh0Nfa4w
         8Ncgl2KU6k1P30s8UUJiErsaiXtf8YP4MnJockReCCY9Ob5ZGr4rqruhrpCZci+RM49u
         eQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783079743; x=1783684543;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EMUE4aQBQf5gDaVLs1aXgAur2VD1yy3m5vYBxXEcv0k=;
        b=OO2fPkrBlvAKGyEG676+jSHLfn6jyFIF5+Zk9d75fifjjWEkSavyr+81QWGojB6oBq
         idgWhdOmXVeZ7jtWTx7cT8/Bh78waaQNcli7gkJogc51fs7Ue/Rgx4W02phUQ2ULLJMY
         +Lj3/RZZy7NLybbdwtiaPO9ehJfXbzxoT/1i5BPfkLLcEX0AHjOs7WNVlmihL3cEGevI
         P4scvIfo0DaGSscc/EUAtkXiKg38TFT6xxFE4NjTekeGFOIjMPhfkMRQLrO+Mczo4xAR
         gE1n8Q/tjYtruqjX8lgUXkEfe5C6kf/UL+KwnJBSUORwZMuHqW2VT19p2pKfrd2Xd3hh
         m+SQ==
X-Forwarded-Encrypted: i=1; AFNElJ95k6icWr84qPTfbp6lMJhAN07WURMCxFmf3QQJXm1FWN0UmRAEgrkPfSTtfPxe3qIx+B2v5Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzexUoqwAGOvzWC8fQ9FoaX3eEOfrglQKYn9bRMOjdaHaSQFKOg
	M3E92pPlaU3zUWzbzq0bcnJlorr1T0Lwv0kWwcDxSaefxtRhPXfY3sf8oj+0higKLf0PruHBZXB
	0Kn1v5dm3X+JcOj8+CcYpGtpgHHqgaRBygA9Yno03tWK14Bwk/cesLrmmuQ==
X-Gm-Gg: AfdE7cmB+sZlEWnv8+qM3loxV4HJPL98lF0Mf1TNvjIJXji51l1MQGy3u8Eq4ZQy91f
	OJyKyqWebb1I0swNj0/IO6fdUtJqc0vBw1gar0RPZMFp7+M5Bt45PXCibSoxMjYrzAUSw5a8z5j
	l94TGyMnd/A5u9mgTRX3mefEKigaA6qIT3yG90qt8vKASoCEG88Lh3CcPMLhb5YbmEXNFmUjNrO
	NoF/j+0KVLPkFP3i/a/OZz1qrqSABOtXg+wR85GF0l28Us+G+5iHrnb0d+vwBm8Y/pA1LdJhrwo
	UO3jFeusCSYYeEm5HjWdr+fO+TJ4io8vCPLxIbRoJIoxC6HzGJQarXlbLPHPyiprBPiOtW5PIHk
	c0eTpkbTubvwazUJ6DWf6fcjs4f+SNtYz
X-Received: by 2002:a05:600c:8b05:b0:492:5145:f054 with SMTP id 5b1f17b1804b1-493c3cf8c29mr127465345e9.26.1783079742858;
        Fri, 03 Jul 2026 04:55:42 -0700 (PDT)
X-Received: by 2002:a05:600c:8b05:b0:492:5145:f054 with SMTP id 5b1f17b1804b1-493c3cf8c29mr127465055e9.26.1783079742456;
        Fri, 03 Jul 2026 04:55:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccd9d607sm60793295e9.2.2026.07.03.04.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:55:41 -0700 (PDT)
Date: Fri, 3 Jul 2026 07:55:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Brett Sheffield <bacs@librecast.net>,
	regressions@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] tun/tap & vhost-net: multi-threaded
 network performance
Message-ID: <20260703075438-mutt-send-email-mst@kernel.org>
References: <akVnoOYQOrt8k-Gu@karahi.librecast.net>
 <a1bae349-61a1-4c65-a531-179850576642@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1bae349-61a1-4c65-a531-179850576642@tu-dortmund.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304524-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:simon.schippers@tu-dortmund.de,m:kuba@kernel.org,m:tim.gebauer@tu-dortmund.de,m:willemdebruijn.kernel@gmail.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:bacs@librecast.net,m:regressions@lists.linux.dev,m:netdev@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,tu-dortmund.de,gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,vger.kernel.org,librecast.net,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80B0C7021C1

On Fri, Jul 03, 2026 at 12:41:19PM +0200, Simon Schippers wrote:
> On 7/1/26 21:16, Brett Sheffield wrote:
> > TL;DR - Commit 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3 causes
> > significant performance regressions with TAP interfaces and multithreaded
> > network code. Please revert.
> 
> Micheal, I am convinced that netdev_tx_stop_queue() and
> netdev_tx_wake_queue() are too slow. The communication between the CPUs
> is just too slow. We already spent *a lot* of time speeding it up, the
> patchset was only merged at v12...
> 
> Yes, I would *love* to have qdisc backpressure on by default but I do
> not see how anything could speed it up.
> 
> 
> *Is there any issue if we introduce IFF_BACKPRESSURE?*
> I implemented it and it is a simple patch that only executes the
> stopping / waking  if ((tun->flags & IFF_BACKPRESSURE)).
> I could submit that to [net] very soon.
> 
> Thank you,
> Simon

Pls go ahead.

-- 
MST


