Return-Path: <netdev+bounces-303158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b8jROeu5Q2qQfwoAu9opvQ
	(envelope-from <netdev+bounces-303158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:43:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4715E6E4521
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:43:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=GFKEZmiV;
	dkim=pass header.d=redhat.com header.s=google header.b=McXhK1yN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303158-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303158-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F30D130C97E9
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A64140802C;
	Tue, 30 Jun 2026 12:39:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932A407593
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:39:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823165; cv=none; b=cYjAaLDDgYqeXjoh+9Sy/bZnUZjxhkM01O9zuPHwp/aAdwroglTnwnbRTVJnMQwKrE7jnN3T+SxcauLeOw8QdTLBhBMRaBbfhizHlPnGwkCnW2pz8PvA55ExoDRWIfk3Z9ZfF/fxFnFRIHCd5k0+vxoKrKzRUHk/xzN63Ql6lmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823165; c=relaxed/simple;
	bh=VwYiaIOctNoh585NIztzC6xWPLmQ71URx+DbYZxb5Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKzEECvz1cjWhMIquUAqzFO3q9OcTjtUqK7jB5BHQhcWlJKUG/DXPD8C3I2GyyRsx/YMdd72ZH6T+lzUrcCgE/V+whnSjluNPgizNTgRur8f/V0w1EDgWw9fxlslHQDrebED4J38v5LDl+Wiqg1R4tGAbf94LqD4Q9osxnFjDPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GFKEZmiV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=McXhK1yN; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782823163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DhYoswPadKQqsKhwI9bNhjFKctjkWor2chy9aJkH7jQ=;
	b=GFKEZmiVch3JgF2GTh712RH1hMLgxtp6oXLYEpjWI7jK7YdNO8A/QPRjTyRAL9Kpjn83Qd
	FUWQyxWKS/G25zV33IxlZ5rxLruskNfD1XCywdBNUtEb7Pddu5c2XlxbdJXpqd4eVt6Ich
	6S48uyfqpTP5GwlP8fticT4o2ejhEyQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-8WHryH6VOaKHkLlptM-unA-1; Tue, 30 Jun 2026 08:39:19 -0400
X-MC-Unique: 8WHryH6VOaKHkLlptM-unA-1
X-Mimecast-MFC-AGG-ID: 8WHryH6VOaKHkLlptM-unA_1782823158
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4924725bec9so27197775e9.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 05:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782823158; x=1783427958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DhYoswPadKQqsKhwI9bNhjFKctjkWor2chy9aJkH7jQ=;
        b=McXhK1yNAOvan4mzbfUpRI+osHx1xroLtonszHSf4aPkBNjqKN+gHd21FuZ8UjBRrX
         rgWm5IClSTD6Paogj+RsfrL7kA/09TWEt8knVVOA4uhqBbPeFrsUt2a71SDhyhoGBVb6
         StNqNIGw9UF8XKqEW35/TEDnteJfflpPwcBoq+dD1ax5cbgJReG/iZzdTnbf5/jaunIr
         BP1Us38XKX/fjkFrtXwfeSkf47FSRY1ivI1boXxjWd6Xnk0X8oRFpMVYjTkjJKwGoxgd
         jTDSm7UvgFR+hD8EiL+ZOvIMqkw3Dt/csx+Hz+vOBawNc5yfJRSa43VtlKkObQtOv8JJ
         fzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823158; x=1783427958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhYoswPadKQqsKhwI9bNhjFKctjkWor2chy9aJkH7jQ=;
        b=OzC3NuKgpsxOhDo5pYXLClvEXtVTATb6bcINl29SbrTGfa3kz7Q3Nx1sktWMSgY5IE
         eWaAoW6ATA3jPDRvi95IeYseqhahKK/YvV510cbj4K9OaB5opJ2Ie9MCGSu8SiZJKM8c
         S2z68ukRBBb0h8PJVRAMZ0+odsqeEARqk76OVH03T+l+P5G/7RIdeoTCoSRh7ToaNwjo
         DgsZD6l6UF6+kOSrHv2xcMtJDXonSjI14wRcrW7CNgX+mq5ULoCVPudtr4O2IsSUVWSt
         AVIQwRf41dbdCdUx31BmcUngJ04+Yru37Ve43tSbyuw1mmMNYHWJYetuppmebI/9esE8
         1j+g==
X-Forwarded-Encrypted: i=1; AFNElJ/Mv8NQUtrexcr5t/IOl+0xJMZs0zcKscbkx3XPd290ttaekkXBJysfMO7xNtai3PT6ru2oEe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1X2G8j8RB/KEd9LuB/VlcaF++bbhGhszsRASVRVKHoGQObUhr
	4es5pTFWeqFdOrTztW3sw6mvqSO1ckfpsYXJuPgif6VLLVQot5Dr+fkFIADVbyMvAkMtgfHA0yL
	lrjqvF4SLZieDE7dqXageaKg7Tv4XqFqvSNkwdZAHOgKJnSZVOkgnINQ/jD8W4tnUeg==
X-Gm-Gg: AfdE7claqzkGnd0/YtJ9SmN+ZPOZKY4cHINtlEDMiQazeCm2A+zKta2DHFO5Ix8H9sZ
	3bRorS5BPXM7LR89WXkbRafDdrnD6Cr32aH3vMY5JVqAETDbm8Hjs9XKm8kcJK+OtHTgGhmwfYG
	c7TRBC4bB/hZoNnERb277IT7mjC0QZsySCQFJK3i8nDqNnDGkTIQZyO694j30DXYBEkkR3xrWbZ
	YQH5aCtrFHmv4/d3nZgXjKy1sekO4JL7W+uKLfn92seN4ui5apZ+MxvB8ysnEelOnURgL+KKdXp
	s9IuuPZ1k3hsCE5crbIcTROeNkPJhBj6xKXID8h7G2ZnysZLyXVFaRqyYETC56nnlJEDGsyCrPd
	emP9JwtC/vMy65YwLegtwA9b9XUqo7WiLt+w0HWMk7Z63dL05BLB06MTZahZE
X-Received: by 2002:a05:600c:c493:b0:493:b61c:72c3 with SMTP id 5b1f17b1804b1-493b82b6360mr51871255e9.32.1782823157951;
        Tue, 30 Jun 2026 05:39:17 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:493:b61c:72c3 with SMTP id 5b1f17b1804b1-493b82b6360mr51870825e9.32.1782823157370;
        Tue, 30 Jun 2026 05:39:17 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8c8d92dsm71175085e9.0.2026.06.30.05.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 05:39:16 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:39:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v3 2/4] vhost/vsock: suppress EHOSTUNREACH fast-fail
 during CPR pause
Message-ID: <akOUbsbSdNzfNnSR@sgarzare-redhat>
References: <20260625155416.480669-1-andrey.drobyshev@virtuozzo.com>
 <20260625155416.480669-3-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260625155416.480669-3-andrey.drobyshev@virtuozzo.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303158-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:andrey.drobyshev@virtuozzo.com,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:mst@redhat.com,m:stefanha@redhat.com,m:dongli.zhang@oracle.com,m:maciej.szmigiero@oracle.com,m:bchaney@akamai.com,m:mark.kanda@oracle.com,m:ptikhomirov@virtuozzo.com,m:den@openvz.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvz.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,virtuozzo.com:email,sgarzare-redhat:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4715E6E4521

On Thu, Jun 25, 2026 at 06:54:14PM +0300, Andrey Drobyshev wrote:
>Earlier commit bb26ed5f3a8b ("vhost/vsock: Refuse the connection
>immediately when guest isn't ready") added a fast-fail in
>vhost_transport_send_pkt().  It rejects every host send with -EHOSTUNREACH
>until the destination calls SET_RUNNING(1).  The fast-fail condition checks
>whether device's backends are dropped, and if they're, the guest is
>considered to be not ready.
>
>However, there might be other reasons for backends to be nulled.  In
>particular, when QEMU is performing CPR (checkpoint-restore) migration,
>device ownership is being RESET and SET again, which leads to backends
>drop and reattach.  If we end up connecting during this window, an
>AF_VSOCK client gets -EHOSTUNREACH, which is wrong.

nit: IMO we should make it clear that this behavior has not yet been 
implemented, so this patch is a preparation patch to support RESET. In 
this way it is clear that it is not a fix to be backported.

>
>Add a 'started' flag which is set once in vhost_vsock_start() and is
>never cleared.  The behaviour changes to:
>
>  * When device was never started -> flag is unset -> no listener can
>    exist yet -> fast-fail;
>  * Once the device starts -> flag is set -> we don't fast-fail ->
>    we queue and preserve during any later stop / CPR pause.
>
>Important caveat: after the first start, a connect during any stopped
>window is queued instead of fast-failed.  That was the behaviour before
>the patch bb26ed5f3a8b, and we're restoring it now.  However we still
>keep the behaviour originally intended by that commit (i.e. fast-fail if
>there's no real listener yet) while fixing the CPR path.
>

Suggested-by tag is nice to use in this case.

>Signed-off-by: Denis V. Lunev <den@openvz.org>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 22 ++++++++++++----------
> 1 file changed, 12 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index b12221ce6faf..bec6bcfd885f 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -61,6 +61,7 @@ struct vhost_vsock {
>
> 	u32 guest_cid;
> 	bool seqpacket_allow;
>+	bool started;		/* set on first SET_RUNNING(1); never cleared */

`started` was my initial proposal when I was thiking we should have to
set it to false when the device is stopped.

Now I think this name is confusing, so what about `ever_started` to be
reused in the future, or just `fast_fail` since this is what that
variable is controlloing right now.

The rest LGTM.

Thanks,
Stefano

> };
>
> static u32 vhost_transport_get_local_cid(void)
>@@ -302,17 +303,12 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
> 		return -ENODEV;
> 	}
>
>-	/* Fast-fail if the guest hasn't enabled the RX vq yet. Queuing the packet
>-	 * and making the caller wait is pointless: even if the guest manages to init
>-	 * within the timeout, it'll immediately reply with RST, because there's no
>-	 * listener on the port yet.
>-	 *
>-	 * vhost_vq_get_backend() without vq->mutex is acceptable here: locking
>-	 * the mutex would be too expensive in this hot path, and we already have
>-	 * all the outcomes covered: if the backend becomes NULL right after the check,
>-	 * vhost_transport_do_send_pkt() will check it under the mutex anyway.
>+	/* Fast-fail until the guest first enables the device (SET_RUNNING(1)).
>+	 * Before that there is no listener, so queuing is pointless. 'started'
>+	 * is never cleared, so once we're up we keep queuing across later
>+	 * stop / CPR-pause windows.
> 	 */
>-	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))) {
>+	if (unlikely(!READ_ONCE(vsock->started))) {
> 		rcu_read_unlock();
> 		kfree_skb(skb);
> 		return -EHOSTUNREACH;
>@@ -640,6 +636,11 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
> 		mutex_unlock(&vq->mutex);
> 	}
>
>+	/* Set 'started' flag on the first start; never cleared, so send_pkt
>+	 * keeps queuing (instead of fast-failing) on later stop / CPR pauses.
>+	 */
>+	WRITE_ONCE(vsock->started, true);
>+
> 	/* Some packets may have been queued before the device was started,
> 	 * let's kick the send worker to send them.
> 	 */
>@@ -728,6 +729,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>
> 	vsock->guest_cid = 0; /* no CID assigned yet */
> 	vsock->seqpacket_allow = false;
>+	vsock->started = false;
>
> 	atomic_set(&vsock->queued_replies, 0);
>
>-- 
>2.47.1
>


