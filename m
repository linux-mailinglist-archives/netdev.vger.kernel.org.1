Return-Path: <netdev+bounces-298701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5OPkNQwdLGqLLgQAu9opvQ
	(envelope-from <netdev+bounces-298701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:51:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAD767A581
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:51:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=O4NtSD36;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298701-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298701-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44F8D30F0F41
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 14:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55D238CFFE;
	Fri, 12 Jun 2026 14:50:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C23222582
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 14:50:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275853; cv=none; b=eqUes8bfCL01mEMgtSDttDwUBlSeKnLZe4nqIqVzreS8LqDotRSkNEt18AUa0e7gJHoL1sFnAOs5p9odbMeoufa8mlmCSel/s32MVmu2nftQzYsvneoo8v4IYKeWRBpvv+aLXHUkqhjr/hxVbomNVwr6FLhoXfSuUzYm0GLAf/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275853; c=relaxed/simple;
	bh=kWlqJdzwUmprV1aSxqcZKGIM8ovHj3K8M8iLohg+Xpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOw4M5JCl6lh1ZUGug23e2uylacGrq1DKfJvRdviz9fboHrYoVUE6P1g2J+YS7XgLkDJc1rN7mymh0pEpK7OU7FMGxKJPhvSPnDI7ZVeWTJmvHwUwk7f+G25+EXiRjgLResa7hjqvvAE0ppaJiPMEpy76uAj/NivwcqY9bvk8+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4NtSD36; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c35980fdso10101245ad.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781275849; x=1781880649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w241YD07yboAYZVQiGTMi7+NJEDMiJb3z/8kHuKGMKE=;
        b=O4NtSD364MfPP6okfMOAMe61yJla1vUsvO0eIoc4ospQDfZJutvt4TllYTLBtMEwPO
         4coyOH1xtz4utgRberzWbY/vr4J6p31J9anyQ4+aIN8Fxg++riqFtdz6rg3PdmE4KYBM
         OstrOcM8H+q+rYRVGWZrH4nVBT5vdA64S/JuCCjLEmyvj+TaQJ06M2eIB/jpNJe6rg75
         c17QxGBNM3HapY3iZcWJ2l+3U9Oq1plcp1ehRpD6XsENX9onBGwRnOEaj1UEE/0NKhCe
         RxF0pTPy9VGZcm0m6Ka11xUUwhcvA/vcvrOlU/0A/cY0PDRPr5/0/54zY7qNOaxJ9aLS
         /2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781275849; x=1781880649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w241YD07yboAYZVQiGTMi7+NJEDMiJb3z/8kHuKGMKE=;
        b=a0WdiTAEOw3NVZHPaOUlBxFmbBfLapw73UVsH8e1CugGmkQPVx9kbXsqc/1Jb8bM9h
         Qpybi6BgQWQn6H0P0i+J4vecC7HIWFN8WcGrtb9rtuTDaRFnB0wfHvJAuKVWMyAe44ZS
         KtmeN0UsF4eEeKjjgKX+VPyZBVASIC5coEb17snz7jA6huoL6r64OVfNH6OzL63HLZqb
         zf+88VVWsr7zxDVmpTUkqnp0Vm4px0IcFy24crd+vlgQiQcWAkgtPdlBvlrJNchkIIjd
         3drdSXfXL8pMga+oJoguTSjYqbLchH3zL9mj5GCD+zukAnjUpwx09ncgFRuIM8YGItFQ
         CcFA==
X-Gm-Message-State: AOJu0Yzvwfyz7EfhT2ILOE09oKSm8EHbtkBl09UYEzfv8nnNGyn4TMmD
	GQEUMSZ/S57twjl8MEW9TvkEUY6WFWFManeht1Uag2wdJr3qIPtPbLLm
X-Gm-Gg: Acq92OH762y1UeK1BllPtEvvsZQ3ACkfB2ayW8o3GOU+mv9ZawfCPd0POWLAh0uuJYR
	wpYJNRJe3NBp8wiD8AVnuib0uAcprr52fCo9yPGITo6wP0FGlwDil15faRA5BPI25B4pDL++p5Y
	T2JhAADosFo1e9NevhHeiCDiM1B8uJkjUzLT7qhwhXqp7zCQjcjDjISNaQjloUOoFrYRnR30hRA
	vc+s/I8i70i71fzUWTYiPNf9lhSMaJUmPWDz6RmZPs8twUgB4lKYAd71Z1UyCKKaoTCC+gqSf2e
	bc4b+G/LTesVQXBto0yRDsNSP3fmNeZ0yZodAfjFzW2BvZfQ5f09iYpjCRqZy82iwzyebC4DevX
	+IvoaW51VXna/75GFiFcMvLNJHY3Bd45kKT5kgVqsL+mDsWPI6ID78jCRvcUA2nJH/p4b/4G+qz
	82YGbqCdu7j8WP/vffg0CB8YGYDRvmmEVHaScTMTo40g1k
X-Received: by 2002:a17:902:e742:b0:2c2:4ce4:c5d4 with SMTP id d9443c01a7336-2c41235e5cbmr40486225ad.17.1781275849291;
        Fri, 12 Jun 2026 07:50:49 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:5d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm25637165ad.38.2026.06.12.07.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:50:48 -0700 (PDT)
Date: Fri, 12 Jun 2026 07:50:44 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, leonardi@redhat.com,
	horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 1/4] vsock: introduce
 vsock_pending_to_accept() helper
Message-ID: <aiwcxOVDB8Vc2RAA@devvm29614.prn0.facebook.com>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-2-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612045216.105796-2-rafdog35@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298701-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:leonardi@redhat.com,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DAD767A581

On Fri, Jun 12, 2026 at 04:52:13AM +0000, Raf Dickson wrote:
> Add vsock_pending_to_accept() to move a socket directly from the
> pending list to the accept queue in a single operation, avoiding
> the sock_put/sock_hold dance and the sk_acceptq_removed()/
> sk_acceptq_added() pair that would otherwise be needed when
> calling vsock_remove_pending() followed by vsock_enqueue_accept().
> 
> Use it in vmci_transport_recv_connecting_server() where a completed
> handshake transitions the socket from pending to accept queue.
> 
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Raf Dickson <rafdog35@gmail.com>
> ---
>  include/net/af_vsock.h         |  1 +
>  net/vmw_vsock/af_vsock.c       | 10 ++++++++++
>  net/vmw_vsock/vmci_transport.c |  3 +--
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index 4e40063ada..30046a3c20 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -220,6 +220,7 @@ static inline bool __vsock_in_connected_table(struct vsock_sock *vsk)
>  void vsock_add_pending(struct sock *listener, struct sock *pending);
>  void vsock_remove_pending(struct sock *listener, struct sock *pending);
>  void vsock_enqueue_accept(struct sock *listener, struct sock *connected);
> +void vsock_pending_to_accept(struct sock *listener, struct sock *pending);
>  void vsock_insert_connected(struct vsock_sock *vsk);
>  void vsock_remove_bound(struct vsock_sock *vsk);
>  void vsock_remove_connected(struct vsock_sock *vsk);
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 2ce1063d4a..1f94f0d44c 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -496,6 +496,16 @@ void vsock_remove_pending(struct sock *listener, struct sock *pending)
>  }
>  EXPORT_SYMBOL_GPL(vsock_remove_pending);
>  
> +void vsock_pending_to_accept(struct sock *listener, struct sock *pending)
> +{
> +	struct vsock_sock *vpending = vsock_sk(pending);
> +	struct vsock_sock *vlistener = vsock_sk(listener);
> +
> +	list_del_init(&vpending->pending_links);
> +	list_add_tail(&vpending->accept_queue, &vlistener->accept_queue);
> +}
> +EXPORT_SYMBOL_GPL(vsock_pending_to_accept);
> +
>  void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
>  {
>  	struct vsock_sock *vlistener;
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 91516488a7..635ebf9da4 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -1258,8 +1258,7 @@ vmci_transport_recv_connecting_server(struct sock *listener,
>  	 * listener's pending list to the accept queue so callers of accept()
>  	 * can find it.
>  	 */
> -	vsock_remove_pending(listener, pending);
> -	vsock_enqueue_accept(listener, pending);
> +	vsock_pending_to_accept(listener, pending);
>  
>  	/* Callers of accept() will be waiting on the listening socket, not
>  	 * the pending socket.
> -- 
> 2.54.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

