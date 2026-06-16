Return-Path: <netdev+bounces-299858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7LoBFtNSMWo3gwUAu9opvQ
	(envelope-from <netdev+bounces-299858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:42:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F4A690075
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:42:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=R1qMP1fu;
	dkim=pass header.d=redhat.com header.s=google header.b=rLO5DiaB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299858-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299858-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 701C8302817C
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5331E3271FD;
	Tue, 16 Jun 2026 13:42:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C10212D7C
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:42:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617360; cv=none; b=EpBZvsQ1c02zjL4Fw5JG0cv2KwEaU3kU+kIAenDCkFPGrJNBxXTRe6dlsoVG1E22qwwGNyychdOyP9OinR/WMmYAiA4AFv2GApy3N5Fma+DkL6J+JkoxXf2jQxN6VQZVjQYpFchdwBZJ8IJHDXVEQXlpG1fwdUS2oT4P9Xa//W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617360; c=relaxed/simple;
	bh=tc2x14jzytwc/9908NmOW1OURlK/VDWDQ8I16o2NBns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ED6v9DOjoOrPSW3uEZpUmrrJe1KgFYxXA96HgZkV8/4mxdlUUXiFiPegL65yRgdDGZ4nqYRjmME7uGQQnKr6QTlJdxMy7ZZXPuX2J39xyJ12TFufVPMWK5IV3+dJ76T/+q527mCa83875gRFC3893UwmkAt66o8qlrKqLwULGMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1qMP1fu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rLO5DiaB; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781617357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMMzkYgDyxgPnpqnDrhKhTR3oBCFllCmFxdRzsYDtQk=;
	b=R1qMP1fuHgVDJ7oNG/MBggBoeKraweyJrWouA99jDWITlhk7Wzig8FLnCf4n0RpOREKGDA
	Dy1bBbAxlfu6Ay4ts9VcaIwWkXM7S49M0/WeuXsTlYTdgMJOW6exFDgKgTFmlU1RBX4hA4
	d2pEcW5DVfNMKyciCz5iRX4/LOsgieM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-oKz00sELPtesEgV0nibPEQ-1; Tue, 16 Jun 2026 09:42:36 -0400
X-MC-Unique: oKz00sELPtesEgV0nibPEQ-1
X-Mimecast-MFC-AGG-ID: oKz00sELPtesEgV0nibPEQ_1781617355
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-461a15b716fso408792f8f.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781617355; x=1782222155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TMMzkYgDyxgPnpqnDrhKhTR3oBCFllCmFxdRzsYDtQk=;
        b=rLO5DiaBMVBY8a5rIfDpeha8mMgsaypWW1nvTjLIMSE2gSS1TzS4BOn3MmkWszPBf/
         QMDdcf1oFoOZBMDVKr1hKPIAxn+VGewUJGTCFI5lEiBgjYEAfBD3Y1R1AbHoNvTDf4gG
         C6Ixw0vsLkV5+x3/ySMI7rGtOeG775U5a3WPZagq+5IfCHBVj1C9eFnMggvNV09N//G7
         h3freBePDe1TGRFAQnP4YEATg+ZPRabCbSk1c4lAF3X2bn+ZzcAbyKflaxLhnWyNg15Q
         qFMr0qhaRHD2u25jHPyPa8BSdtRma48QfnpGyRiLBJyH3IcIfuCm/xKcEmURZDw4JCeK
         Sp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617355; x=1782222155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMMzkYgDyxgPnpqnDrhKhTR3oBCFllCmFxdRzsYDtQk=;
        b=PWdEnguSUN12jXLCtodI1UTJZwdmNWM6qMb48vi/L0mm++STqWWhYocst35xGS/c2a
         E9jgmZHuI+W3mdBGUbkqkvrUfmPszVkqRIb8MJrwPUULgvILCfDz71CaIiYQeEypNa1Q
         pOt5f/GuFC8YIxjGYgFnxoFpOxscFxTae9BDhnGmHnnJR9S6FFD4SoK4wqxZ5UH7LvFB
         0kCkWA9oH7PveZq1vwDQIq1DbgbpXzzkZuFk7PGDI5o/LfQmpaWMdwGHn8axm5xHV5eI
         bh7NyewCu0hEwM82wG08LLvYW9y3+yXDF0jnKeSdJbXG76ijywCFY8wNHk/3ec8NZPJL
         khcQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Dv4HoJXRwBji+XjMA/8EBWNcM16eZXbdaOJx1YoQ4WE3I/kP1J5Td4Ch8Yd0i8pPRFTv53Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlvePCOt3uskkD89QafFkQ9R5WBQz227cHNRdqBdKUm73Lhoty
	w5jKJLb6UanIcN0ffrzZtjco3dn3a8nuhuJ4dIvKoAFOjrN1N1/VG+MGKBGE41LL/w90BdNMuwQ
	/D77Cl/an4zIFEEsInFGgtUkIlDCYx7Je6Go32HlN2ORtOXH/cunUz474wA==
X-Gm-Gg: Acq92OH+bWrjWIJMmVDjwvCvWdv1I0XivheYXZW/mfRFltKVaf2kLUjsVhGoKBuCVhg
	WJvqf5pZOrXlf1MI71ZmEx9ZAd3f1/tc2Ji/Jif62iVkIw7UMNuk4P3E99umIWD+0VvuSXNlHKk
	s+PoiUpCpfzCoQ2zxfqff8+mtCCIyu+7fspPJPmEW/ivS+wCwzW7wwp4KgKRNZfQZYgG2kiFEx8
	9miplFsFh9EFdMBNazsuHFaCHNpNSDvdSQgKkTyOVE0C6HdSYaSsh5JeKxasAAU/kUlaVtbnTWP
	IQtsBHmNJGiATsPxgiFuW2Su3xFJQy170175D1D0/0oPegH2RAE1bs2gu4j05/Tqm032XibZe9I
	65Qv9OHuasx5xRxGfK1P8PsTM/vnXcJCAiVAObhqvXwwNtVdnR2JHPYwVwuKt1/fghQ23C1g=
X-Received: by 2002:a05:6000:40e1:b0:461:fc84:dbee with SMTP id ffacd0b85a97d-461fc84dc91mr1007018f8f.16.1781617355145;
        Tue, 16 Jun 2026 06:42:35 -0700 (PDT)
X-Received: by 2002:a05:6000:40e1:b0:461:fc84:dbee with SMTP id ffacd0b85a97d-461fc84dc91mr1006943f8f.16.1781617354664;
        Tue, 16 Jun 2026 06:42:34 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c5266sm51242208f8f.29.2026.06.16.06.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:42:34 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:42:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 1/4] vhost/vsock: split out vhost_vsock_drop_backends
 helper
Message-ID: <ajFSurS_piyfFvjM@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-2-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612165718.433546-2-andrey.drobyshev@virtuozzo.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299858-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sgarzare-redhat:mid,virtuozzo.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2F4A690075

On Fri, Jun 12, 2026 at 07:57:15PM +0300, Andrey Drobyshev wrote:
>From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>
>Split the actual backend dropping part from vhost_vsock_stop.  We're
>going to need it for the VHOST_RESET_OWNER implementation in the
>following patch, when vsock->dev.mutex is already taken and owner is
>checked.
>
>Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 26 +++++++++++++++++---------
> 1 file changed, 17 insertions(+), 9 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 9aaab6bb8061..b12221ce6faf 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -664,9 +664,24 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
> 	return ret;
> }
>
>-static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
>+static void vhost_vsock_drop_backends(struct vhost_vsock *vsock)
> {
>+	struct vhost_virtqueue *vq;
> 	size_t i;
>+
>+	lockdep_assert_held(&vsock->dev.mutex);
>+
>+	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>+		vq = &vsock->vqs[i];
>+
>+		mutex_lock(&vq->mutex);
>+		vhost_vq_set_backend(vq, NULL);
>+		mutex_unlock(&vq->mutex);
>+	}
>+}
>+
>+static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
>+{
> 	int ret = 0;
>
> 	mutex_lock(&vsock->dev.mutex);
>@@ -677,14 +692,7 @@ static int vhost_vsock_stop(struct vhost_vsock *vsock, bool check_owner)
> 			goto err;
> 	}
>
>-	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
>-		struct vhost_virtqueue *vq = &vsock->vqs[i];
>-
>-		mutex_lock(&vq->mutex);
>-		vhost_vq_set_backend(vq, NULL);
>-		mutex_unlock(&vq->mutex);
>-	}
>-
>+	vhost_vsock_drop_backends(vsock);
> err:
> 	mutex_unlock(&vsock->dev.mutex);
> 	return ret;
>-- 
>2.47.1
>


