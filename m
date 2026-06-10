Return-Path: <netdev+bounces-297857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EaTJG23vKWpYfwMAu9opvQ
	(envelope-from <netdev+bounces-297857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:12:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F267F66D52A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:12:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kJWCCL+t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297857-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297857-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49E023012218
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 23:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3E7233954;
	Wed, 10 Jun 2026 23:12:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9F715746F
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:12:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781133162; cv=none; b=WX/P8sujXDVLMlixpRBNHor0LnDVCyOdlyKYdpOAZxmQsBxrTF4CzfJak9tlJm3tqPwYLRLkdSTP5gkM9jHuYR0O1vluV3obnpjjzMbqfGGfFI50dHareS8zYk8R0JRmi7mhIGqnvM/LL7A3/FixFcrerYn+vqICpT+ohC9ZJi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781133162; c=relaxed/simple;
	bh=2OLiIqVkhj3ggpwre3HAy5E5W5ZI0nG/3TV62WY1E5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAETTXBJ5EBMx+V7ma3HtYW3cAFf9KsXoY2eW3dr8qzryuXpdvpLfbHysKxaCl6AmZF4f0idZil1XZYdsbwDkS24WLga/73RI7u76ULkvj5jEiMiHbNhZqFqRDjctAif+87QyeFb0ufdy3371OqSr6EV7PRFhbQ5WRElv+r2Z7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJWCCL+t; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf30d530bdso72894695ad.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781133160; x=1781737960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQLCg81en/xiSDiPUo9OAx2p+vBmXiFBiAm/qA8ZaPM=;
        b=kJWCCL+t2YpqYZCmCYati94fkrbY63YX3RB2IYeMNT9eAHl42nS/1ncpbiQmX1bHfo
         pzdE9Dl2CXUUDnXYrEkS47wZ/ILGdUgkEociLk/eZ4HDWsALP8KBFOGXn7tHKu1odwCL
         aE/U3tDA7BJByFjy6t1ZBBysAVOYhj+oBlfxKawiVAtOaHGNAQXmBKmg8WdRh01OgDoX
         0xngnAiWdUBn4MUNnSxNAvwsJKQoj62WhMMfwxlciev0/AT2Qe1rbOD8qFqxYXXC4GqQ
         2I4892wB3XMRtc+SnFwfvD+CtyK4vZ3PJrm1G4luRswiXUc4DY3EmWH240vOEEDcDjYA
         HaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781133160; x=1781737960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQLCg81en/xiSDiPUo9OAx2p+vBmXiFBiAm/qA8ZaPM=;
        b=BFwMDq7S0iNsf+AIayN0L2mt6wG3rT5HZOopp+zd9rrpYoXCccyt+oJrUrlHIO41C7
         z3g9pZ5Fq50bcUZ0ecRsAr5dM4bDkHGEJ3VoApooDPXsHu2DQo2vwkSaBP981gHQnzWF
         2PFYtdtSqas+pG2Qs8T7/Bhn910jRMfB4UwxBUX2pj8iG9lKAFSZ3gNvFa7+Zwnx6uIx
         m5mvuNPncSlXRFerq6ibFeBGEcyQKwbX7gGS1RU3CIhyxKS0By7AjQQOShEcDn52ZXAy
         jrPSV0q397qR/MQDFIvn8c15MWzd9q4LyJIEiPP3vVoxNUTLMRh5zvXpqN9tKbBkfSpU
         r1hg==
X-Gm-Message-State: AOJu0YzUlcNjv6J2X2rMnl14kiZ9gMZW8d3YM3jAOSC1/1z7bt1uJCaQ
	b0xOovofaI5Gi/Ev7jQEF1dbo956Y07gvbV47vl6Ym1yOBZwt8Hc8kcs
X-Gm-Gg: Acq92OHLymx3b7ACWf+hCjrcI4HIBFmeGzLnko1vSHfyVzzSw7oD/WYmXZMeKSPLp7F
	PLk7u9ozZ06Vm59GdKtlti1cz4uHfky1J3fmAdIO3mIGF72mUWzB65DJT8YTLMvukCb+bRUfxsZ
	HREgIA6WIjlX5Mtd+sC7EQPvp5rFIPeDdPw30zl28s2E+Q3XYtvi7J+gI3uz5JoOmo4yM2h81f7
	hVTuXQjM1thTFHXK0eBXJoETukUhyvN2MygpocIpNAMXBSIdXbOUZVLKKMGw7xabau6i5oLeTR9
	oESVV1Ql1b+y04fQGR/vGaV25NTZpOg9zok4RgFQO4SGPbhm8LCFU7e7C5iPOl/ZY0Xt/JtCgq2
	/ywvkDHLZ24CJRV710xgei5DJlMCnVdMXy5B2ld3yI/hJ4gYWmdFfW4J+WWOutDWPH0XZKOuqPR
	6dKeg8urpYR2TFK4a7vGZ3BjyRK0NddGty2Q1AG8ssUkYEkrG/IUg5gdI=
X-Received: by 2002:a17:902:c408:b0:2c1:d49c:8396 with SMTP id d9443c01a7336-2c2f20a9792mr985115ad.1.1781133159786;
        Wed, 10 Jun 2026 16:12:39 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609ed97sm276399455ad.41.2026.06.10.16.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:12:39 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:12:37 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next 1/2] vsock: fold sk_acceptq_added() into
 vsock_enqueue_accept()
Message-ID: <ainvZQppoc7LfPRs@devvm29614.prn0.facebook.com>
References: <20260610091121.213324-1-rafdog35@gmail.com>
 <20260610091121.213324-2-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610091121.213324-2-rafdog35@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297857-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F267F66D52A

On Wed, Jun 10, 2026 at 09:11:20AM +0000, Raf Dickson wrote:
> All three transports (vmci, virtio, hyperv) call sk_acceptq_added()
> immediately before vsock_enqueue_accept(). Move the call into
> vsock_enqueue_accept() itself so callers cannot forget it and the
> accounting is always consistent.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Signed-off-by: Raf Dickson <rafdog35@gmail.com>
> ---
>  net/vmw_vsock/af_vsock.c                | 1 +
>  net/vmw_vsock/hyperv_transport.c        | 1 -
>  net/vmw_vsock/virtio_transport_common.c | 1 -
>  net/vmw_vsock/vmci_transport.c          | 1 -
>  4 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 2ce1063d4a..73e6416ee9 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -507,6 +507,7 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
>  	sock_hold(connected);
>  	sock_hold(listener);
>  	list_add_tail(&vconnected->accept_queue, &vlistener->accept_queue);
> +	sk_acceptq_added(listener);
>  }
>  EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
>  
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index b3394946b2..0de8148877 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -410,7 +410,6 @@ static void hvs_open_connection(struct vmbus_channel *chan)
>  
>  	if (conn_from_host) {
>  		new->sk_state = TCP_ESTABLISHED;
> -		sk_acceptq_added(sk);
>  
>  		hvs_new->vm_srv_id = *if_type;
>  		hvs_new->host_srv_id = *if_instance;
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index b10666937c..4a39d48db9 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1582,7 +1582,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>  		return ret;
>  	}
>  
> -	sk_acceptq_added(sk);
>  	if (virtio_transport_space_update(child, skb))
>  		child->sk_write_space(child);
>  
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 91516488a7..4ce6660c11 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -1109,7 +1109,6 @@ static int vmci_transport_recv_listen(struct sock *sk,
>  	}
>  
>  	vsock_add_pending(sk, pending);
> -	sk_acceptq_added(sk);

It looks like vmci might be an odd duck here, where sk_acceptq_added
actually pairs with vsock_add_pending(), instead of
vsock_enqueue_accept()...

For example, if the pending work timer below fires, vsock_pending_work()
will see vsock_is_pending() is true, and then hit sk_acceptq_removed()
and underflow the zero backlog counter?

Best,
Bobby

