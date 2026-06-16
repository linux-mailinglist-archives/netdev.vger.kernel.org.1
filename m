Return-Path: <netdev+bounces-299860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /L9SIPNUMWrggwUAu9opvQ
	(envelope-from <netdev+bounces-299860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:51:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C51D76901EA
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:51:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="Ray/TiNe";
	dkim=pass header.d=redhat.com header.s=google header.b=bKM3dCZW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299860-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299860-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F41D3205E5D
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41C5349CD1;
	Tue, 16 Jun 2026 13:49:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5C7347535
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:48:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617740; cv=none; b=EbJHIK+GAXWY7qzSHdGliWnrxKONBvxUP4lSHjbj9fAa9y/ggyD2eUzQsmhphN6aeZHcV3eX+2uuw10sykaud1SunWaIKgUGaYs88VzlMj3o3uDyHTOhLQYeAdzmNyEZ/8Xuihebg/eXcvhGb5u80aPXEAPnlgMn54wIEpNkxpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617740; c=relaxed/simple;
	bh=5CR0/gNeuOc2zkbAwEj3QpPxqk48E1/i/BCv28UFb7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o86jcUf1BtQ3j/YKWmfWSLoXFH9HgQ2a6/4BvwPXxxqCvjrtNhPB5jH3as5BnKzUK8jql9KIIOYGvV+tMba80mr4gfpXAmaSGwvnRhC+T7YJpLlCH8zDS1BvNlUFPj3KBEqN5U8c/CoqAHLqEEuSKtgq3CSHETApfk4ElI2t6+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ray/TiNe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bKM3dCZW; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781617738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPZnF8IEm/lwUVIdQCh7bqnFf280e66Awhk1O9lMvHM=;
	b=Ray/TiNeXu0QitpH3JdZ7496Xu3iqxlX5dSijw8L7PeWSfyl/QYBUpZJcShLaWduAps/te
	zARtOLF3y/RcgFIi3v35gOsPn1+7nsh00oWIIggsoYuSRLsfPyD1ERIAHho6Du2UVebMZz
	+YOeYRu1R7q/UElC8Mi/YvUeKzbElQ8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-H8Azy7xaO8OKU6O-lzd2hg-1; Tue, 16 Jun 2026 09:48:55 -0400
X-MC-Unique: H8Azy7xaO8OKU6O-lzd2hg-1
X-Mimecast-MFC-AGG-ID: H8Azy7xaO8OKU6O-lzd2hg_1781617734
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490bde3d239so30795745e9.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781617734; x=1782222534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hPZnF8IEm/lwUVIdQCh7bqnFf280e66Awhk1O9lMvHM=;
        b=bKM3dCZW5Ul9xW0SN/q3t97OLCk/qxY49gGAm/hGCx+UMSY9V+Bmave47lOB+kfFcS
         Nj9a51geEC6o+UkLd9EPcffiqgdcIaQUkHCXkcWTfeO7FKkZBpOeFSe5EoQyoyBcTi/Q
         ZzOY+F95A5JBcxMM8p8H6PGVK2pfHgqK+VmpKEWg3V6AxGMinbaU2PiIhLzuXgtnLjfW
         EWCmp3XbMD8Vtz2ydGS6axrmw7v0olLKExcrlYB2Wk+ea86sPAhKnl0vwcKf92iBDc2o
         nlGzfHUVuWL/nv9BGf5O81SowjZv6XFzi/F/mb/KC2gmLyvx/PzrfsbyHWSWueVuiSP2
         PerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617734; x=1782222534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPZnF8IEm/lwUVIdQCh7bqnFf280e66Awhk1O9lMvHM=;
        b=pH9tILs506NQgZYrT/w1anoXh2Vf0OaywWS36pnGzVNXHaeioqB5ulZdOb+rMx7p1f
         zdMOBj4eM6Kmw/TNj0efmoi+Dvh6zSa8IhhiHn12h72qXmL0H1qWo4QlynaiSbEEmxs8
         2L9V0NLH1GDWyg9aeLR3UNTdqPLAHVcPsjmN8lD3QyrI1t/Zgt5zxfOBvyQiymkkzRa5
         YJHPVp2eS3uFb2orbEViV6YefPWkmhLAelxTnGk0pwS1cl5O9boyWF6jO4kFfm44A94U
         Dc1rqAR7yoCBXwwyyUkwSAFQDRm8LEEzp6z65ddCsCRnFAJsRKCePGeruqP+JdPiLrlJ
         VLSQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QpmASURXcbmHvqMXX7GjIbc3I0x6xiPkfSdG+7hLus1SMkmP+uUR/GUt4Ce7M7en3RYKx/+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJEq1VskIkJBNVpi8/BTtuU8Y3uestrT4GMF3xnd0i7OT5V1iD
	IX8HTjm/MGl13YLasLjYn+ulzg82QdIp0IysVp3qIKdGcFSKVbRAgXZpGTJmUp0UkQ+VkqlvmBT
	PcWHpu37/ZTgJCeRZRHcD8Y56ojPziF+s3g4neNf1rLXV/W90joGjgmpzQA==
X-Gm-Gg: Acq92OEwFx4SFKWRS3jd8IxKhkjg7e9kVAnjtxXH6WcEd4AUKkTS16QWYMaDiKdp19J
	Y4i/jc2KOWMVem+J8WGGHQZGri8mGln52Vy6SDP+d4q9Vq34sjvgqE+4TiyV3hB6mPTvxZrvHG0
	B4lHXZJUo/Jj91iOteFtaJ+bSfhdH0/Lsqx7meygRZpl1L9JpyL3aX7JjEAJg7PAG3eHcssXrKy
	rCEy2OSgd7xGr9HDjQiYMN21kLpO5RsmxweMDJGh/gEYjkdlZoX8u41jNIRsnRNXoBvfD5e/zf6
	kMBTXDxOHXqJeX0q0yMye0xv4cktUVbXNrn8PUcAF4n5oP4qdKTv9eI6m3cG40flMVfLgL/dedX
	4dHCt8chkjJT1bbgAgPyNXkwHfPreEw3XzBd2MlgiBa+FYhqcTemKMWmT46t+RjXcVE9Us7M=
X-Received: by 2002:a05:600c:4e01:b0:490:bd1d:472a with SMTP id 5b1f17b1804b1-4922ff992ffmr58825665e9.15.1781617734145;
        Tue, 16 Jun 2026 06:48:54 -0700 (PDT)
X-Received: by 2002:a05:600c:4e01:b0:490:bd1d:472a with SMTP id 5b1f17b1804b1-4922ff992ffmr58824915e9.15.1781617733491;
        Tue, 16 Jun 2026 06:48:53 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a58becsm60905695e9.7.2026.06.16.06.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:48:52 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:48:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 2/4] vhost/vsock: add VHOST_RESET_OWNER ioctl
Message-ID: <ajFRRmA9req1muX6@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-3-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612165718.433546-3-andrey.drobyshev@virtuozzo.com>
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
	TAGGED_FROM(0.00)[bounces-299860-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:email,sgarzare-redhat:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C51D76901EA

On Fri, Jun 12, 2026 at 07:57:16PM +0300, Andrey Drobyshev wrote:
>From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>
>This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
>the guest with vhost-vsock device.  For this to work, we need to reset
>the device ownership on the source side by calling RESET_OWNER, and then
>claim it on the dest side by calling SET_OWNER.  We expect not to lose any
>AF_VSOCK connection while this happens.
>
>Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 28 ++++++++++++++++++++++++++++
> 1 file changed, 28 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index b12221ce6faf..e629886e5cf8 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -894,6 +894,32 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 	return -EFAULT;
> }
>
>+static int vhost_vsock_reset_owner(struct vhost_vsock *vsock)
>+{
>+	struct vhost_iotlb *umem;
>+	long err;
>+
>+	mutex_lock(&vsock->dev.mutex);
>+	err = vhost_dev_check_owner(&vsock->dev);
>+	if (err)
>+		goto done;
>+	umem = vhost_dev_reset_owner_prepare();
>+	if (!umem) {
>+		err = -ENOMEM;
>+		goto done;
>+	}
>+	/* Follows vhost_vsock_dev_release closely except for guest_cid drop */
>+	vsock_for_each_connected_socket(&vhost_transport.transport,
>+					vhost_vsock_reset_orphans);

In vhost_vsock_reset_orphans() we have:

	rcu_read_lock();

	/* If the peer is still valid, no need to reset connection */
	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk))) {
		rcu_read_unlock();
		return;
	}

IIUC we are not removing the guest cid from the hash table, so this 
check will be always true, and nothing is done.

So, is this call really useful?

>+	vhost_vsock_drop_backends(vsock);
>+	vhost_vsock_flush(vsock);
>+	vhost_dev_stop(&vsock->dev);
>+	vhost_dev_reset_owner(&vsock->dev, umem);
>+done:
>+	mutex_unlock(&vsock->dev.mutex);
>+	return err;
>+}
>+
> static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
> 				  unsigned long arg)
> {
>@@ -937,6 +963,8 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
> 			return -EOPNOTSUPP;
> 		vhost_set_backend_features(&vsock->dev, features);
> 		return 0;
>+	case VHOST_RESET_OWNER:
>+		return vhost_vsock_reset_owner(vsock);
> 	default:
> 		mutex_lock(&vsock->dev.mutex);
> 		r = vhost_dev_ioctl(&vsock->dev, ioctl, argp);
>-- 
>2.47.1
>


