Return-Path: <netdev+bounces-299868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uDdVNmVfMWrniAUAu9opvQ
	(envelope-from <netdev+bounces-299868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:36:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39401690901
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:36:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=a5fV6wOl;
	dkim=pass header.d=redhat.com header.s=google header.b=kg+lf2TS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299868-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299868-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7966031AC268
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4DD36E483;
	Tue, 16 Jun 2026 14:23:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F40E3624C1
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 14:23:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619812; cv=none; b=h2otU9dzDixu2ab5gFhdO9UYZoqTDWEX4uKrL7+fUme/ccy5QjzMRHvYbo01+DM8dNHGHvvYJZWJfeBdXCW8P2Famwe33wuKEulvPrJDzUkWSvsF5EbnE7f2dB97N/t5mG+LiJP3vb4UwcUil9IO88D3IvAie1/JxAE0TqIgwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619812; c=relaxed/simple;
	bh=Q/s4cDWwwN/dicrkzT22yRozV+e/TzvwUha5L7N8yA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1AzsvqzrlKsqcUzKyTMVOVgLaKoza5Onup9n6tWjnaTzzjLIdwifWXbe9AZ6ky+SxB0bRQhi8bZBbgovhXQpo7jyOrVhNq2H2Kcjty/pVDcMJw2IzCHiZfLQOZoV5Ut7/CK6BxkzYynPXYaOzLvAGtCe5Gq656AZ0zScXXfrI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5fV6wOl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kg+lf2TS; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781619810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7mn5V4o1TPXbSAVtdGS76DREOft6jWX1FbZbmYVpiyU=;
	b=a5fV6wOlAnUvq9OcNiADJjYWaC/RfuuE8MXZYvqzxk3Ob++cp+2IYDs2Rxl/AZ6mXldtjk
	wJ+ojCJ6hFfasuac7wvGb6zIZuAmWV+1edHWe3FGrt0C0ImPYg48Gd4cZJsZt76y5S282L
	DJWirJ2GvsUam41qZa6ZtZsvzNssOfo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-H4tUhGXzMCejRjuJWK4GVQ-1; Tue, 16 Jun 2026 10:23:29 -0400
X-MC-Unique: H4tUhGXzMCejRjuJWK4GVQ-1
X-Mimecast-MFC-AGG-ID: H4tUhGXzMCejRjuJWK4GVQ_1781619808
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490afe64f26so21406255e9.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781619808; x=1782224608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7mn5V4o1TPXbSAVtdGS76DREOft6jWX1FbZbmYVpiyU=;
        b=kg+lf2TSjV3/MHWhd4dmf31HVzOWM+Bn0fiiZh1UEe/SG5xV25UImuctwwThSbcWI1
         qEIVbEWHDHGGrjCffLAyLuW5G1SUoJM+Cr/sz1+lLl2YsqPvsxCQiamxU73P6Wf+0bzH
         g7H5wYdutvFfkp0O7SOfvncYkLX3ZVdu/FkeAtUjviEW8OGcfNyAcuDPPJRadO6L/ThN
         cS+MU2SVoAkF7P/pFofzUKUiqkYVJ4D+K+RCMkxYWcpk13BDXTR0yXFk30QL/vnyAwSI
         uskDoWvqrGTyyj4twOedg+VuCiXHPpZBM3kb+BCOHgsZKQKQpo0UKW2zLYSF2eVVTbl3
         8Y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619808; x=1782224608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mn5V4o1TPXbSAVtdGS76DREOft6jWX1FbZbmYVpiyU=;
        b=WmSw34cWcWlPqNYIQIeo0xt65qrIW2FaJ/IIj/m68nu84F1Vx3+/oyUvtPdIZzsgvK
         S1UFbiNqtPspLg6pTlq9RBjtt7ad/pdsk+Ney09n+XhDYkOcxIIRm9o8WS/1BdDpB539
         jqnljZQxqEkGOIIbeUs8UqB4v4npFdgWsalXOjoer1fVe2gEWEj27qD/1Q3x8ARLwOhy
         vJkBMSn2dkcRvK52gY+YfCGa5ZAkF4NnLKfcQZGh9UkXuY7bYVbHevuWzBSqT8X5rALz
         iPRHzcjP6PYK+k9uoSD677zX8N4o1krxlcoeCR6/iAnQFNAhkPjiGO0zXKED5Q7ZBfUV
         n1MQ==
X-Forwarded-Encrypted: i=1; AFNElJ/YZkCeP4yV4cZ+spHWGftpdCH3z28NQSkuQbGegOCbhui5cXD3V+4TnXRQqg+iXhOc4lpAtck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ClyQWcfW+7EBoyrc8XHljPkLmVNOJP1jHhGXZPD4ScrOrvm1
	VkxgyZjFJxYOlFq7i+Qq6G0iuZ93whHGVVa2w4QX51lZkAzmBf/ztpDsAd0OY7wFBeI84Ftz+OL
	BHdeXLgTwRUgjulx8Rla1zzhuqoS8j11f4/Qepvlg5hGZ1N3mkmdMbinYsA==
X-Gm-Gg: Acq92OGHz108VgcKChKr1V5aFTDijtVdA03bWpFzXCM4kYPgmJ4CK1rmxcJRsMdBNDw
	nqpFw2JoaZLIUMXwrhrWr8N8OKQ9S/uQKJn6hN5TZ7jibyVEGcG+l2coa58tOVtg0dDWSiMyokU
	qOm8wZr3VRTv8rUfNa9FCg/Cd3UJwlmWdtYNB0xeBy6TRuMae5VhoJ02btMfGl0XIZJymHi8y07
	mCS1On1GLDOAIzaj0qS447jk3zzRzxsAUJcUb9Sd26ox8yCqT4tOhRAyf59Y0xTTyusTrunMubi
	b5kGoOVM1NsAhQrnq7FIbQ6HZn0dekRoHTTXcsXhl6/ropyjMVGeNSVYxTFcDSIejDidK9vkYlI
	EExoWlMMKk5DvkMmqldx9uBVVFLvmRYQ4shbeOO+P+bagjZNmxdm3++BDbn/TwCCr2FasBqw=
X-Received: by 2002:a05:600c:6215:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-4922fab22c9mr58482905e9.3.1781619807804;
        Tue, 16 Jun 2026 07:23:27 -0700 (PDT)
X-Received: by 2002:a05:600c:6215:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-4922fab22c9mr58482265e9.3.1781619807299;
        Tue, 16 Jun 2026 07:23:27 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea95c512sm243782055e9.2.2026.06.16.07.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:23:26 -0700 (PDT)
Date: Tue, 16 Jun 2026 16:23:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 4/4] vhost/vsock: re-scan TX virtqueue on device start
Message-ID: <ajFbT6sDESh9FDOl@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-5-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612165718.433546-5-andrey.drobyshev@virtuozzo.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299868-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sgarzare-redhat:mid,virtuozzo.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39401690901

On Fri, Jun 12, 2026 at 07:57:18PM +0300, Andrey Drobyshev wrote:
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
>The deadlock is reproduced during active host->guest socat data transfer
>under multiple consecutive CPR live-update's.
>
>To fix this, in vhost_vsock_start(), after kicking the RX send worker, also
>queue the TX vq poll so any buffers the guest enqueued while we were paused
>get scanned.

Again, it seems like we're fixing an issue that existed before this 
series, but IIUC without support for VHOST_RESET_OWNER, this could never 
have happened, so the wording should be changed to make it clear that 
this is can happen only with the new VHOST_RESET_OWNER support.

In addition, this patch must also be applied before the 
VHOST_RESET_OWNER support or merged into it.

>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index bcaba36becd7..1fcfe71d18be 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -655,6 +655,12 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
> 	 */
> 	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
>
>+	/*
>+	 * Some packets might've also been queued in TX VQ.  Re-scan it here,
>+	 * mirroring the RX send-worker kick above.
>+	 */

Can we also mention that this is related to VHOST_RESET_OWNER?

Thanks,
Stefano

>+	vhost_poll_queue(&vsock->vqs[VSOCK_VQ_TX].poll);
>+
> 	mutex_unlock(&vsock->dev.mutex);
> 	return 0;
>
>-- 
>2.47.1
>


