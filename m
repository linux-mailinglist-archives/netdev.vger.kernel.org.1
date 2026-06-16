Return-Path: <netdev+bounces-299867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id moZaEoVeMWrEiAUAu9opvQ
	(envelope-from <netdev+bounces-299867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:32:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB2D690881
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:32:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=cUxQmFk3;
	dkim=pass header.d=redhat.com header.s=google header.b=r84Afdb+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299867-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299867-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4077307BFFD
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4177376A19;
	Tue, 16 Jun 2026 14:18:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DA036CE10
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 14:18:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619528; cv=none; b=Pf3TeKDyARSgzXjXlzW3yv5Dm4fTIYU00BK7vc8nwUCtSd2eqKhPrUYOfu4UvWCrqzNLpTkItcD37G4QNOTOvvp9tO0TLOSnb336mNgE7Q2Qb6SayLtzDAdphfraY9oGt+HnZWudWHSMB6XV6hRXvD0rZ9NgG2f02fm+b+dnX2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619528; c=relaxed/simple;
	bh=vJqyvxeaNxfW6LxXVQpl4/4cnJSjsoFuDMk8hGTaUXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMSTJHJD1UDzm9cw9YzglV2Nm7U997YkJCH06Mq/CpfHeHZUhWee3vwGcCTXsSL3UzeFD2oBbX5v7EL52pBzWWGR4/scqjn3rE2R3FwlpitBwZr6OO1DPvqi526j8cCK6lpF7p9e631CQnYDLU30ss+ArQ/mnP4kQcfgFeAjFyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cUxQmFk3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r84Afdb+; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781619526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DWdtjwkPY2KPVnS0hOnG6u0xNpB/3YtZXJSrw+UYGyY=;
	b=cUxQmFk3vY+94t7a2vGtuioJWzqfCqgcP4Q+ZcREkPVq/St9qFGuUeWopUkXFfVqx4PpM+
	XbNI5gkZOCsvwaHfHZspp3u4JW5qWrX+Mywyq9BG1gnqS0oISy4n3hAR5fo2FlUVf61etd
	YmHp1bDDfTRtXycDL50uPBeKuJ6+nT4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-eGjsOaa1P4CH9Yrvj0mS5Q-1; Tue, 16 Jun 2026 10:18:45 -0400
X-MC-Unique: eGjsOaa1P4CH9Yrvj0mS5Q-1
X-Mimecast-MFC-AGG-ID: eGjsOaa1P4CH9Yrvj0mS5Q_1781619524
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b9318944so29558995e9.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 07:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781619524; x=1782224324; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DWdtjwkPY2KPVnS0hOnG6u0xNpB/3YtZXJSrw+UYGyY=;
        b=r84Afdb+ras7xvbCSGAiKhBQ6uMwsyZ2vB+Y959Jtah5IxdTopR9g7lEBhX3vMqqe8
         63TkAe5UR5I6jdLO3pNoibMQVPL9YQfA2V2ufrR+cXegxt1xGDrYnCgN+0nLkbs2aikm
         L7oMt+CrvwXhSUd4oR++1EwGRdGSsGVYbQ7YQ8AWF4w9+KIEgVNvN6Z/Q3+40xKvN4qw
         nTfKw4AyJ+K3saK5AQjIunr3IOm8OmdY4YqN8udW7uZUhhbBOWHpkI9JMQknM29GplpB
         C1TuGQ6pD5cpn0/b7oaUCjNapF4prgBMAWMxjV5OPlBfjg5cZzhslwru4wsJm+KiDHst
         d+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619524; x=1782224324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWdtjwkPY2KPVnS0hOnG6u0xNpB/3YtZXJSrw+UYGyY=;
        b=RXo3hX/ygaaVp04nRJ9B0HslfEtZZrkCbdUW42lbeD4TkEmL0Pdv4grhf6DlOZWfwn
         1KxlwYB0+d2ks7j+JH33jXxzLotJUzQ6PHNhv53SmDirXq2dnyh3tVj2M2RNx95isizb
         RrltIRvohpPzjI3TQhD1fLJ7LfzQiud5KmPsKHvQUgtR3gkQPT+CXcCi9Z/vO+597KAG
         E36wrx4509wX8xD3G1n7NYXrwKGtIHG9HUz/zGc9EXo6AtADTjNQ0d2bPwSGKCLa5y/T
         Y6EjZiZ2Z3PBz8cXnzdtbhOI158jmhFY6BdacJqn6YxVRPh0CwmBOzQdCnjt4Y4GfhnW
         clDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8uEW+sOwoa+KtWBk5CIAaKAiU4KyIWp02m0TnDmxUPBnZbCqU4yBmlBPoJMq8OJct65NnE8d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzILhKoZbhvcxDbAjwbCBz1fBIOJqCCOkj7YF9+mUnIFzPYqw/
	ITHjnapMMnKeiN0oTf8qhKA86Xfm+DBZxVDCDzHrvb89BWe9zQMwXX+VVK4JrHkW29Cb7RD5l6p
	cmlBGSMhLM6R8hZOI9DCq8lroY6yvxcwYStyEMPpvHYeB++kAzlrwRhGq0g==
X-Gm-Gg: Acq92OFnbKNi/gM7N8+uPH5P+YTqP0iIZAht2lPNh190KTh5BtqMdh70GJGvsw+M/DK
	nmmVBwrWmev4TEj13SSTdIZP5hUKsqCZxbzaaCEblKePfoZj4YkxXvURPG3N+tXj6/EyTmjgBK5
	aJdD4glEyiooLeFgbJdWUNqIgOZaFtyeCPsAQP1MVzswOjzJaKAg+/ILtD3ovMzAr4cnNw9uDs1
	VmqWaVLYoYULy6bHcje0Kc6c3nVbrKHu5KqH+nuRwsheHAY70G2oxSdDNP5MQEVp+yKWq7dqLRz
	kDCL/MY8/ZJ/pGj0RbouH9pdmC3G8hTEhLmT/9tbPqfO8+Ebzhd+UPrXea1bdKDX2dYAoSeZGb3
	70m1IcOZGCIts5WoVi8ne0zGT7XPojY1hbsGYYce91SPshWitZMO7EHev++t5dwANWkENKgI=
X-Received: by 2002:a05:600c:810b:b0:490:9df1:f0d5 with SMTP id 5b1f17b1804b1-4922ffb82d9mr60188395e9.28.1781619523772;
        Tue, 16 Jun 2026 07:18:43 -0700 (PDT)
X-Received: by 2002:a05:600c:810b:b0:490:9df1:f0d5 with SMTP id 5b1f17b1804b1-4922ffb82d9mr60187355e9.28.1781619523017;
        Tue, 16 Jun 2026 07:18:43 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a96b47sm56484875e9.13.2026.06.16.07.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:18:42 -0700 (PDT)
Date: Tue, 16 Jun 2026 16:18:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 3/4] vhost/vsock: suppress EHOSTUNREACH fast-fail during
 CPR pause
Message-ID: <ajFUk7quPhbI7Te-@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-4-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260612165718.433546-4-andrey.drobyshev@virtuozzo.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299867-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:andrey.drobyshev@virtuozzo.com,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:mst@redhat.com,m:stefanha@redhat.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,openvz.org:email,sgarzare-redhat:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFB2D690881

On Fri, Jun 12, 2026 at 07:57:17PM +0300, Andrey Drobyshev wrote:
>From: "Denis V. Lunev" <den@openvz.org>
>
>Earlier commit ("ms/vhost/vsock: Refuse the connection immediately when

Please follow 
https://docs.kernel.org/process/submitting-patches.html#describe-your-changes 
on how to refer to a commit.

>guest isn't ready") added a fast-fail in vhost_transport_send_pkt().  It
>rejects every host send with -EHOSTUNREACH until the destination calls
>SET_RUNNING(1).  The fast-fail condition checks whether device's backends
>are dropped, and if they're, the guest is considered to be not ready.

Okay, so it's not a regression, I mean without this series that patch is 
not adding any regression, no?

If it's the case, I'll change the wording in the cover letter.

>
>However, there might be other reasons for backends to be nulled.  In
>particular, when QEMU is performing CPR (checkpoint-restore) migration,
>device ownership is being RESET and SET again, which leads to backends
>drop and reattach.  If we end up connecting during this window, an
>AF_VSOCK client gets -EHOSTUNREACH, which is wrong.

Please add this change before starting to support VHOST_RESET_OWNER 
ioctl in vhost-vsock, otherwise we are breaking the bisectability.

>
>Add a cpr_paused flag set inside vhost_vsock_drop_backends() when the
>backend was previously live, cleared by vhost_vsock_start(). When set,
>vhost_transport_send_pkt() queues the skb instead of fast-failing; the
>existing kick of send_pkt_work in vhost_vsock_start() drains it on
>resume. A device that has never run keeps cpr_paused == false and the
>boot-time fast-fail behaviour is preserved.
>
>Pair the cpr_paused store with the backend store using an
>smp_wmb()/smp_rmb() pair so a concurrent sender on a weakly-ordered
>architecture never observes (NULL backend, !paused):
>
>Signed-off-by: Denis V. Lunev <den@openvz.org>
>---
> drivers/vhost/vsock.c | 22 +++++++++++++++++++---
> 1 file changed, 19 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index e629886e5cf8..bcaba36becd7 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -61,6 +61,7 @@ struct vhost_vsock {
>
> 	u32 guest_cid;
> 	bool seqpacket_allow;
>+	bool cpr_paused;	/* between stop and next start */
> };
>
> static u32 vhost_transport_get_local_cid(void)
>@@ -311,11 +312,17 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
> 	 * the mutex would be too expensive in this hot path, and we already have
> 	 * all the outcomes covered: if the backend becomes NULL right after the check,
> 	 * vhost_transport_do_send_pkt() will check it under the mutex anyway.
>+	 *
>+	 * Don't fast-fail if cpr_paused is set, keep queueing skbs instead.
>+	 * The kick in vhost_vsock_start() will drain them on resume.
> 	 */
> 	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))) {
>-		rcu_read_unlock();
>-		kfree_skb(skb);
>-		return -EHOSTUNREACH;
>+		smp_rmb();	/* pairs with smp_wmb() in start/drop_backends */
>+		if (!READ_ONCE(vsock->cpr_paused)) {

Can we avoid this which is not really readable and maybe add a single 
variable to control the fast-fail at all?

I mean replacing both cpr_paused + backend-pointer with a single 
`started` flag: set it to false at open, true on start via 
smp_store_release(), back to false on normal stop, and leave it true 
during CPR pause.

The reader in send_pkt can do just:

     if (!smp_load_acquire(&vsock->started))
         return -EHOSTUNREACH;

WDYT?

>+			rcu_read_unlock();
>+			kfree_skb(skb);
>+			return -EHOSTUNREACH;
>+		}


That said claude here is reporting a potential issue that I think we 
should consider:
     After VHOST_RESET_OWNER, the guest CID stays in the hash, so 
     vhost_transport_send_pkt() can still find the vsock, skip the 
     fast-fail (cpr_paused=true), and call vhost_vq_work_queue() while 
     vhost_workers_free() is freeing workers without a synchronize_rcu() 
     — risking a use-after-free. Also, any send_pkt_work queued between 
     the last flush and worker teardown gets its VHOST_WORK_QUEUED bit 
     stuck (the vhost task exits without draining), deadlocking 
     host→guest traffic after restart.

     A synchronize_rcu() in vhost_workers_free() between the 
     rcu_assign_pointer(NULL) loop and the destroy loop would close the 
     use-after-free, and reinitializing send_pkt_work via 
     vhost_work_init() after vhost_dev_reset_owner() returns would clear 
     the stuck QUEUED bit.


> 	}
>
> 	if (virtio_vsock_skb_reply(skb))
>@@ -640,6 +647,9 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
> 		mutex_unlock(&vq->mutex);
> 	}
>
>+	smp_wmb();	/* pairs with smp_rmb() in send_pkt */
>+	WRITE_ONCE(vsock->cpr_paused, false);
>+
> 	/* Some packets may have been queued before the device was started,
> 	 * let's kick the send worker to send them.
> 	 */
>@@ -671,6 +681,11 @@ static void vhost_vsock_drop_backends(struct vhost_vsock *vsock)
>
> 	lockdep_assert_held(&vsock->dev.mutex);
>
>+	if (vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])) {
>+		WRITE_ONCE(vsock->cpr_paused, true);
>+		smp_wmb();	/* pairs with smp_rmb() in send_pkt */
>+	}

Why here and not in vhost_vsock_reset_owner()?

Also having this here will set it to true also with 
VHOST_VSOCK_SET_RUNNING(0), is that right?

Thanks,
Stefano

>+
> 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
> 		vq = &vsock->vqs[i];
>
>@@ -728,6 +743,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>
> 	vsock->guest_cid = 0; /* no CID assigned yet */
> 	vsock->seqpacket_allow = false;
>+	vsock->cpr_paused = false;
>
> 	atomic_set(&vsock->queued_replies, 0);
>
>-- 
>2.47.1
>


