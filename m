Return-Path: <netdev+bounces-303164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dsNqMei7Q2pbgAoAu9opvQ
	(envelope-from <netdev+bounces-303164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:51:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C66E4768
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:51:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=JaPIdxH6;
	dkim=pass header.d=redhat.com header.s=google header.b=GjgA53JE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303164-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303164-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E71C300441E
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED6140E8DD;
	Tue, 30 Jun 2026 12:45:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6871E40E8D8
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:45:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823557; cv=none; b=rkZNYQNehqE0e5nw383uxsEuq2t59CHCnFhmouNrBmCN31CgjV9OPZfoXv983d2aj7kd29tmFWZLj76/MINIrcyyCe3YRGn5umLmhgQVBoWw8CBRE3tOyJapxn7vU+oM1SM/QpgOjnI7sJGhVod5+WRvG7MMvf4Pf+R6y8rS3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823557; c=relaxed/simple;
	bh=rnqTc9VcuxQmrucqXv/X4rxwWBjO4aintFdu4oYQwos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4Qje/I9OGhdUeL7qf0+GBzqwmjV0gwPnc056g8CFJpT+r6uHImaDCtK6FIF4Dxq/YS12M37WQBTjnPPECwfNMlAHh3sg75VTdpOfPOww5bRnyFaYxooxgisHhSYElzYZ75iOmHaZSz9B+KoKgVUgaKkOtYu2qiMIhe1WjuTdfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaPIdxH6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GjgA53JE; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782823555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9xE5wahl+eqalpRYfV0fnyzHdxALUWLBp0RetJPvoas=;
	b=JaPIdxH62TmbcFmcKDr3zI6riSzqBULhGp0rvTKjXe09gTN/fODNhzN+2pEZAVz+b9eniz
	REPoi1CaM5jW6e+NS8aTegZDLpUU1rTZXMnyQWa1cKt8lBmI4/Pn9xqByb2P11RP0jiV0N
	JekKZ6EfeSuawTqDHmxxMqvvJa1iCmQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-DI7RUeXhO0Ku199yqOlqiA-1; Tue, 30 Jun 2026 08:45:53 -0400
X-MC-Unique: DI7RUeXhO0Ku199yqOlqiA-1
X-Mimecast-MFC-AGG-ID: DI7RUeXhO0Ku199yqOlqiA_1782823552
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bd52dae6so1974285e9.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782823552; x=1783428352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9xE5wahl+eqalpRYfV0fnyzHdxALUWLBp0RetJPvoas=;
        b=GjgA53JEaOxRxXvEbWfsLIh911fN+VQiRIkSEYvjTE2X8Vj8w2T58/KUOigDNP3oV3
         1epjt84uggneblWryK+nNIagp+6pxuEjBRW9oqIJq9cZEmDozsvBT1g/m2iyc8tKuD3w
         m4lZ3QSK26RiNmXNjZhAFnPMarYsG1NzDG/vCfs9z8Q8Kkntbb5/TI3JJM08/mR8WCCB
         K8YIaaa7JYmLV62Ptqtdd5DtiZM1Rciu9A5C0JrxvsUTlJ7nzjPUuvkZJwinulqBkfAC
         bQ/pFvV25CNriBBN0xtBwmYlkWxUyrmg15OXoYDUnFymWhyM/J5JeKTT0RpTsQafJhss
         F9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823552; x=1783428352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xE5wahl+eqalpRYfV0fnyzHdxALUWLBp0RetJPvoas=;
        b=fnjyGDV3SQXunRlkYs8yN97i5NGEoUmWR/U+OpRrUFqWA+wH/bZS2PRnj5R9wonpW+
         DqJ/v+ojIrp2B7F68crx3mSXKLXHsdPx/zoyUJbHLwZAZ4+Rln/K036IoK73YnouCd4h
         A2T9TuWSEzIUuNwQdvLd4ZAmqJ8vzWT6CQLP8E69B7pShrL+BhBOFEK9hme2B35k93vb
         WhCMay3u+eoAHWkWld2R8vN7OV7FwtZ/Z+jSNAYd0CnInbb3wFWcG7NSQ1h0fN41+ck7
         J8KliDU0YKM+Z/l2FnUie5/NxyGT45q2XhOaiKPeOD7aSuCKYTcKgeUCsGQ3qx+GDUS4
         3kNA==
X-Forwarded-Encrypted: i=1; AFNElJ8gu2dNBF8stY8SJp1gvdxypAjkLHxjrGSS5FsdXsHkBpUM98q4XvEzuBwvVreyiWMssApwjlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgP74dF0hwHKFQc1RpIDUqBQ0T+mv6GaD7kHRi20JmBdYxC7Wj
	nNg8hskvpCOhwlti8VDX2vN8vuSIvpDr0hWIRSxdDtGL0QX7Nvr7Ro8ZtZD4C91Ty0UJTwmP93r
	vkwVphBb7cjx9lj3A3qOERX37ajvkwcyWYRfaYWYseO55lxVSqoy1vaqGcQ==
X-Gm-Gg: AfdE7cnPq4BM5AoYzHj8KefH4N1j+okQCx/09aFoc/RpN1PKtqdogfowD8rejmpWoe2
	6HHyB5MEyWqI+RWIYlf4AjD3xDO3z+73VeD0302IQRLhlHHUdZyhZiugIFgo4ErssekjrOu+mVg
	X0Y/c2RcyktAjNCLLUTKavpTtzNtXf5D6E6jj7EQc6K7M5U8Dk/Q27fco3eOIn+NGl1NoZULbgD
	FnoaDbkrVhXA/3AkzZko+B8d/TXN/VaEg5DaGCqIrXSUW7+azI0FeI4xL5dbbY18F9AqCCnRxgR
	XkuQW5BEseyu5v9YomehcdOW7L4myttSbSVWGQ4MJt7kRI2UaYipwsvqJGjTU3UFsVRgYhu1zcL
	uUjjOAlS0yDaTzFKvprLu89TuvS/IbnVc1GXhSBsD8zvRucQRVkjgzCEBxFq2
X-Received: by 2002:a05:600c:a086:b0:490:b0e0:3de2 with SMTP id 5b1f17b1804b1-493bda874famr6557625e9.33.1782823552458;
        Tue, 30 Jun 2026 05:45:52 -0700 (PDT)
X-Received: by 2002:a05:600c:a086:b0:490:b0e0:3de2 with SMTP id 5b1f17b1804b1-493bda874famr6556975e9.33.1782823551880;
        Tue, 30 Jun 2026 05:45:51 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bb1bf712sm30233055e9.2.2026.06.30.05.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 05:45:51 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:45:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v3 3/4] vhost/vsock: re-scan TX virtqueue on device start
Message-ID: <akO5DNoEsjukV5az@sgarzare-redhat>
References: <20260625155416.480669-1-andrey.drobyshev@virtuozzo.com>
 <20260625155416.480669-4-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260625155416.480669-4-andrey.drobyshev@virtuozzo.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303164-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sgarzare-redhat:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,virtuozzo.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE2C66E4768

On Thu, Jun 25, 2026 at 06:54:15PM +0300, Andrey Drobyshev wrote:
>During QEMU CPR live-update (and VHOST_RESET_OWNER in general) the guest
>keeps running while the host drops and later re-attaches vhost backends.
>If the guest adds a buffer to the TX virtqueue (guest->host) and kicks
>while the backend is temporarily NULL (between vhost_vsock_drop_backends()
>and the next vhost_vsock_start()), then the kick is delivered to the
>vhost worker, handle_tx_kick() sees a NULL backend and returns, and the
>kick signal is consumed.  The buffer is then left in the ring.
>
>Then upon device start vhost_vsock_start() only re-kicks the RX send
>worker, never the TX VQ, so the buffer is processed only if the guest
>happens to kick again.  But if the guest itself is now waiting for data
>from the host, it will never kick TX VQ again, and we end up in a
>deadlock.
>
>The issue itself is pre-existing, but it only manifests during a brief

Why "brief"? I mean, there's no limit, and the user process could stay
there forever, right?

>pause caused by VHOST_RESET_OWNER.  Namely, the deadlock is reproduced

Again, please make it clear that VHOST_RESET_OWNER support will come
later, so this is in prepartion for it.

>during active host->guest socat data transfer under multiple consecutive
>CPR live-update's.
>
>To fix this, in vhost_vsock_start(), after kicking the RX send worker, also
>queue the TX vq poll so any buffers the guest enqueued while we were paused
>get scanned.
>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index bec6bcfd885f..81d4f7209719 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -646,6 +646,13 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
> 	 */
> 	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
>
>+	/*
>+	 * Some packets might've also been queued in TX VQ.  That is the case
>+	 * during the brief device pause caused by VHOST_RESET_OWNER.  Re-scan

Ditto about "brief", I don't think is adding anything.

BTW the code LGTM.

Thanks,
Stefano

>+	 * the TX VQ here, mirroring the RX send-worker kick above.
>+	 */
>+	vhost_poll_queue(&vsock->vqs[VSOCK_VQ_TX].poll);
>+
> 	mutex_unlock(&vsock->dev.mutex);
> 	return 0;
>
>-- 
>2.47.1
>


