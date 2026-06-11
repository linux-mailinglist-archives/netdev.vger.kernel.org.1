Return-Path: <netdev+bounces-298005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iRl/GQhyKmrTpQMAu9opvQ
	(envelope-from <netdev+bounces-298005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:30:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4BB66FDF5
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:29:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=IpvJw4CU;
	dkim=pass header.d=redhat.com header.s=google header.b=uEgRhSR6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298005-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298005-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86A9430234C3
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28A3377544;
	Thu, 11 Jun 2026 08:27:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5890030E82D
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:27:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166475; cv=none; b=XZM6A5MOlzIiFtxn4Hcr8pZt1JtryaDAU5O12vOtWCr1Bezwdn9F8VTrYnRtpi337qLsfEOHhaeFe9gMvJ4M4wgwJI9YjvS2dSgTAh44zCh/Mm55NCSTWdz6yqZEvgXApSWkmiNGo6HXHziTwooq/OoJPSkf0Vy8vd8dRQUv2Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166475; c=relaxed/simple;
	bh=kBt55AKLdN/Bknuph/LjwlWldLn4H1BQhQl5mweCLDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdPMGvlrxoj0twbQdrroixWFQrAh32qxPQPc8fA5R+S94yLc2F7jxdPk6Qyqfi1auTL+D0ydC4Y3Muox9PG1myM8esijXm4qy1VEDtuhw+N8qXuwf/FX+gyKzS05zM2JQDnKOvVgL+XeKTVauBJGA75bWLMFtE4DFLOO1zpZQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IpvJw4CU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uEgRhSR6; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781166473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aujw3NhVPNaL0F+ZI/pIj4L4TzWfBaiAg20ONNwBnUk=;
	b=IpvJw4CUttsE/H9CCb+EiDVPOMNoG5mawFU7C7gs669AA9ZXINlRPnLI7qEcku3IEdZcVt
	fY5/TkT4RyeD6/+rC8U06G6ERPnkAi7fHt3HsWfjW2LUslBfV4muTF9Rlq2UvR8swPqu9I
	t24CNbNSwm6caXYbQ/MIaQ1qmBsqUh4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-4_g2R1MIMTC4FFqyrTNRBQ-1; Thu, 11 Jun 2026 04:27:52 -0400
X-MC-Unique: 4_g2R1MIMTC4FFqyrTNRBQ-1
X-Mimecast-MFC-AGG-ID: 4_g2R1MIMTC4FFqyrTNRBQ_1781166471
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490cc1ae292so5454765e9.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 01:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781166471; x=1781771271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aujw3NhVPNaL0F+ZI/pIj4L4TzWfBaiAg20ONNwBnUk=;
        b=uEgRhSR6wgi9v7Q8eB8PHsdd9Tp1IxBWyBujITzRHMUS3ZR3QjnDGAu90M5T2rmHpb
         LLBzTIqQrCK70s98R5cfOGq/sRa595bRlZKShYNb/j78fYuIWWHwonw8Zd0c64oZJGDy
         1uTeNYk3kJTh599LnAZLAtZlYlvU/Ft7O20YVmhihaiWgRTWdvRvGxYvgIfreJfBz5gV
         IazEpacH7EBSPd0ssZle3oHJ1lOwZfEW/CR/5J/FgGryYZmxyBzWecHaHmnmOc9lDPVR
         vwBRaBNqd51ftWUxnk6qysRy2OU+71h5wzd90K1YhjIUi8JvCv2ROiv+2vTN98Yn8N9x
         JCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781166471; x=1781771271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aujw3NhVPNaL0F+ZI/pIj4L4TzWfBaiAg20ONNwBnUk=;
        b=UoCIBq2DK42AAAY9MqTGjwyXxL9XqSFf0b02eZMM50BRhMT4Cfn9veM9e9hHREEWzI
         WRGZbF4RY3izSbd4vjlFK2+2NwLXwreuUAlmv/A2FkGsY+guGDCGyVs9E9XuTeOcXSsq
         QZi7LA7l2ezMEr7BzqGJKns1OP2P94oznfOg0PM03Mn/PBvnY5qfhfcdRA5AzCO7o3RD
         phfOegovCYfF9LQPwavSeM8qMMeL84RUu1GwcJYodCsF0jdtW1usNSzchNxlgM/RSCsg
         7QJLARAcN6/80iXHPJcfv8suXD3lqoAeuH//Re/XZIg4/ydsh99QMplYm0medVwiKrRQ
         T/uA==
X-Gm-Message-State: AOJu0YyF9HfWy+D4rrU2b+Am9Osf5biHyURcIm23EPSdKiKRdEb7rEw3
	NwJV0AOeGxAg5wrhoG2UegzbTLCaySAKUtPVKIX1VpBBYG6qKhk/aIuKMb/f5ueGwi5WGY7smDJ
	UvnT/NN9BcH2j1gIk3PWb3S/fPwGb9SYpsMjNV4CtPjOYy22T5uqz1fE/pQ==
X-Gm-Gg: Acq92OG1/1m6sCZRlwORt+dWS4F4J5xWJJutsovCC5LzcVtb/WluPZwqNhXN2QB8nu7
	6KRyj+8naTy4ouZDGe674tZEGTa53DrbC/XL0njFMZt0ducxq3T990ptsVZzAdRckJ5aPRGOsMd
	VuPID2F+fH65IJiXtFNd0+4fEqXOD8H0YcVgbC0PV9zfAmfgZh8Ot2X8cZXptO2qs46FGHWt+64
	4BXrfnKwofAOF29UN5CKL6UMYIO8QYqkjj84brOcchHG1WDtAPOMPiZ3yrIDDiaDJXNk8OI5MsF
	+qll4BYlMY6dwPOEeTld07AXoU6pvd3efFrfzyIHGRSmRtjcm32MEbrYluOBkNiT7FVIgj+mhzb
	jIXMUAw5XOwefRXOaO6cbFGSajLKy6YvA+cs1+qd17KFxyUYaQiRij4r0fqmZdQVQRyOUjZKSDe
	tw5kd1IA==
X-Received: by 2002:a05:600c:3ba7:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-490e52cad04mr18100865e9.2.1781166470838;
        Thu, 11 Jun 2026 01:27:50 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba7:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-490e52cad04mr18100565e9.2.1781166470435;
        Thu, 11 Jun 2026 01:27:50 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e5329d3asm28397365e9.13.2026.06.11.01.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:27:49 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:27:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v2 1/2] vsock: fold sk_acceptq_added() into
 vsock_enqueue_accept()
Message-ID: <aiptrtQIC5ivKjem@sgarzare-redhat>
References: <20260611021317.69362-1-rafdog35@gmail.com>
 <20260611021317.69362-2-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260611021317.69362-2-rafdog35@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298005-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,broadcom.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:bobbyeshleman@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sgarzare-redhat:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD4BB66FDF5

On Thu, Jun 11, 2026 at 02:13:16AM +0000, Raf Dickson wrote:
>virtio and hyperv call sk_acceptq_added() immediately before
>vsock_enqueue_accept(). Move the call into vsock_enqueue_accept()
>itself so callers cannot forget it and the accounting is consistent.
>
>vmci is left unchanged as sk_acceptq_added() there pairs with

I'm confused, vmci is also calling vsock_enqueue_accept(), are we 
calling sk_acceptq_added() twice?

Aaaah, vmci is calling vsock_enqueue_accept() after 
vsock_remove_pending(), so IIUC with the next patch we fix this, so 
should we reverse the order of the patches?

Also, should we avoid this?
Maybe adding a new function that moves a socket from the pending queue 
to the accept queue avoiding also sock_put/sock_hold dance and 
sk_acceptq_removed()/sk_acceptq_added().

I mean something like this (untested):

void vsock_pending_to_accept(struct sock *listener, struct sock *pending)
{
	struct vsock_sock *vpending = vsock_sk(pending);
	struct vsock_sock *vlistener = vsock_sk(listener);

	list_del_init(&vpending->pending_links);
	list_add_tail(&vpending->accept_queue, &vlistener->accept_queue);
}

To be called in vmci_transport_recv_connecting_server().

WDYT?

>vsock_add_pending(), not vsock_enqueue_accept(), since connections

So can we move sk_acceptq_added() also in vsock_add_pending()?
(with another patch I guess)

Thanks,
Stefano

>can be cleaned up by the pending work timer before ever reaching
>vsock_enqueue_accept().
>
>Suggested-by: Paolo Abeni <pabeni@redhat.com>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/af_vsock.c                | 1 +
> net/vmw_vsock/hyperv_transport.c        | 1 -
> net/vmw_vsock/virtio_transport_common.c | 1 -
> 3 files changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2ce1063d4a..73e6416ee9 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -507,6 +507,7 @@ void vsock_enqueue_accept(struct sock *listener, struct sock *connected)
> 	sock_hold(connected);
> 	sock_hold(listener);
> 	list_add_tail(&vconnected->accept_queue, &vlistener->accept_queue);
>+	sk_acceptq_added(listener);
> }
> EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index b3394946b2..0de8148877 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -410,7 +410,6 @@ static void hvs_open_connection(struct vmbus_channel *chan)
>
> 	if (conn_from_host) {
> 		new->sk_state = TCP_ESTABLISHED;
>-		sk_acceptq_added(sk);
>
> 		hvs_new->vm_srv_id = *if_type;
> 		hvs_new->host_srv_id = *if_instance;
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index b10666937c..4a39d48db9 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1582,7 +1582,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 		return ret;
> 	}
>
>-	sk_acceptq_added(sk);
> 	if (virtio_transport_space_update(child, skb))
> 		child->sk_write_space(child);
>
>-- 
>2.54.0
>


