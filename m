Return-Path: <netdev+bounces-253553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI9yD1ijd2mWjgEAu9opvQ
	(envelope-from <netdev+bounces-253553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:24:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EEE8B6C5
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4181B300462A
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E933D33EB1A;
	Mon, 26 Jan 2026 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoTfdpiO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BFE2D73A0
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448276; cv=none; b=ugKo5I/bk9Qgfvi1a0CqAx2NilAP5klUHrbZ19Y3L0Afsmj2e77CPEzKwueg+9LYY/UzAjrCTn+LQ5t9jtjhsQfDsH3BglLb4lGSNRok26rc15KRTZu0lHtxxg4G6oGEjQAbIpj1DJLH0ArjGP1qY1LqL1Hs+s0j5CWfP997OiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448276; c=relaxed/simple;
	bh=db0Y63NF2/I/BUVLcuSFr48EWi2vxNEgYDdbUYjM70U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mftY+lvnLy17MDPDjSVBrMiNU6z6+ZM9YqmRlsOBBBq2hb8HnhWDSfge/rUti7FepZfy22D7JwDxxq4b/Hk6GzDi1Td1/3i+CpgJ4yF5XzZmAQg/2hcaTK5g2gTDuHfgZ1mDs0JJyayv/+Y8wMV9w3+cWDIEa47DUwuhpQbP0hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoTfdpiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DD3C116C6;
	Mon, 26 Jan 2026 17:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769448276;
	bh=db0Y63NF2/I/BUVLcuSFr48EWi2vxNEgYDdbUYjM70U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BoTfdpiOBWoTUYkmAPm3PVAuIIQwjaQLr9PZVT8KK96NKNV5jt2sa7x3I3C/rPrJI
	 KdsIHMoXrDE1trIHzlbhJcQqGoEafRx8KH880u1K+ZT9MbzXjZjWaFcxv6Uzggj5bc
	 Ei8sNE3/e4HhFN7Q1wa20QCyoXLOdJCXLFpqF9AkqfFIZ74HREw0WMiBJiIm/E/LUY
	 hNvHL8RKnripq1DexjieDa3ubHd2sRWC6BlMAqkNwxDKe7+YGNTtHiMPUCdLL9IS4p
	 suGLelcfbKUrvhyJteOlTOko2buePFdohcisGvyeOVvgbAefCbKIIxT42qPPN4TLd5
	 jWhtt6LNM8xrQ==
Date: Mon, 26 Jan 2026 17:24:32 +0000
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	syzbot+f2d245f1d76bbfa50e4c@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net] nfc: llcp: Fix memleak in
 nfc_llcp_send_ui_frame().
Message-ID: <aXejUMWyl51mlr5Q@horms.kernel.org>
References: <20260125010214.1572439-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125010214.1572439-1-kuniyu@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,linux.intel.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-253553-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev,f2d245f1d76bbfa50e4c];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1EEE8B6C5
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 12:59:28AM +0000, Kuniyuki Iwashima wrote:
> syzbot reported various memory leaks related to NFC, struct
> nfc_llcp_sock, sk_buff, nfc_dev, etc. [0]
> 
> The leading log hinted that nfc_llcp_send_ui_frame() failed
> to allocate skb due to sock_error(sk) being -ENXIO.
> 
> ENXIO is set by nfc_llcp_socket_release() when struct
> nfc_llcp_local is destroyed by local_cleanup().
> 
> The problem is that there is no synchronisation between
> nfc_llcp_send_ui_frame() and local_cleanup(), and skb
> could be put into local->tx_queue after it was purged in
> local_cleanup():
> 
>   CPU1                          CPU2
>   ----                          ----
>   nfc_llcp_send_ui_frame()      local_cleanup()
>   |- do {                       '
>      |- pdu = nfc_alloc_send_skb(..., &err)
>      |                          .
>      |                          |- nfc_llcp_socket_release(local, false, ENXIO);
>      |                          |- skb_queue_purge(&local->tx_queue);      |
>      |                          '                                          |
>      |- skb_queue_tail(&local->tx_queue, pdu);                             |
>     ...                                                                    |
>      |- pdu = nfc_alloc_send_skb(..., &err)                                |
>                                        ^._________________________________.'
> 
> local_cleanup() is called for struct nfc_llcp_local only
> after nfc_llcp_remove_local() unlinks it from llcp_devices.
> 
> If we hold local->tx_queue.lock then, we can synchronise
> the thread and nfc_llcp_send_ui_frame().
> 
> Let's do that and check list_empty(&local->list) before
> queuing skb to local->tx_queue in nfc_llcp_send_ui_frame().

...

> Fixes: 94f418a20664 ("NFC: UI frame sending routine implementation")
> Reported-by: syzbot+f2d245f1d76bbfa50e4c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/697569c7.a00a0220.33ccc7.0014.GAE@google.com/T/#u
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


