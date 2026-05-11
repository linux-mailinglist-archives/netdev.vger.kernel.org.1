Return-Path: <netdev+bounces-286731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFcJMn78AWomnAEAu9opvQ
	(envelope-from <netdev+bounces-286731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:57:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73334511ADA
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A09A330229D1
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964F040FDB1;
	Mon, 11 May 2026 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNnkr7R4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qzW4s5wn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E26406264
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515017; cv=none; b=h24FH7V1EzyqVLB6UVBCLSsosw0V3LZO9kzD5n/LoqdwdNdOk45nC43xa3qO13ceAYYxz7WpHfMQW8nkcpuDODz4ZshLmdKVeNLsbG36B6SecJNqXHCAZ2yj96AFQlYphp6gUCQYf/2F+qmTmZINB/r9S3bvnO2jT0VyMelVbqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515017; c=relaxed/simple;
	bh=t7ET0rqXtYU0UPQXZE9zBjWgK/qB8ssf7YiQJM1pUe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4apDXE96XMQJRIYzeieOTEzseirONIXDTBW3SBX6TDAVWbxfHRHzV3TB1YBHCuukYXd9sqxH/OE04UbXk4Ji5cL3uR1OKFK215eZAPqoD05Hr2XOvzaibC60sZiHyjJ3JHqcqhs+/m8yZqcZDj9tTs1hdLUWKMTARb119+vKas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNnkr7R4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qzW4s5wn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778515015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mqh8HANASsg1dE58rfi+aWvc9+OWR8qHCZSV5rhehOc=;
	b=ZNnkr7R4Xv7+hmqGjPhucsvV2xvhDukqZZNPEZ5CZhL/ZPICFTO5btrp9ZOAxjPGzPPo56
	GcoVosrzTZIU/4+H6hr0c6hfaoEg82MQNPaHj0dvzP0FmDcnUet9KVQqr5ckaLQIPXTIiL
	IHjMHfihSF/jNfsWnlxMtDJ5NBoecxE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-oVFS5sIJORWIw5tfSRCS3w-1; Mon, 11 May 2026 11:56:53 -0400
X-MC-Unique: oVFS5sIJORWIw5tfSRCS3w-1
X-Mimecast-MFC-AGG-ID: oVFS5sIJORWIw5tfSRCS3w_1778515013
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a55de6fb0so30850505e9.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778515013; x=1779119813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mqh8HANASsg1dE58rfi+aWvc9+OWR8qHCZSV5rhehOc=;
        b=qzW4s5wnUwhQ30VLWLHFtq5hINYu6kplsupgMOvEnLS/YYGmWg9P9QbXtnw78pcg6d
         hczTl6HOxC2G4aj1nj1Omq7eOExJzG1f4e6QpwuLcfRFUEWjjEkh2huQd7Bx+KjkH+51
         7KINkTu2nKjDi3C0Il+W6bXlDZQvU18vGP3CcIZcZUtXWv6g5SPTAIYfqAmHSs7yse4R
         M1xdPh3FKDaVYYUULayLN5qc1Oswx3emVQKA2BffDiE3hZAwNbaLDDWoWkkBiBF5llm1
         /dbDlKAG4+kaWU9r55dz/7+8liA5/R8CbaRjhZOOsDleRnocSizCv0CxwwXw+oEPQOyd
         pe6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778515013; x=1779119813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mqh8HANASsg1dE58rfi+aWvc9+OWR8qHCZSV5rhehOc=;
        b=n5v/ydWSWFm1kECsxNT6rVmcG8QHUZPrnd6610bRMQ69KinsGV8WRtvh/vjePPEQ2i
         mvb2pw9Gk0LpxNYDRsyF4B2tUkX9YMNZjhD31tEV+R0a8ps7ujXp5oLqXKRg3wiSLhG+
         m1/NHswSBG36cKkzAq2OZWJ9tEe6YNfEqZia9OwkT+3OYRw9FXCRXa/Kl3Wjwfz/wjfg
         8dOF34+BnqxPm3xpIQ1DrK9/dgoY/H7b9XqOdvYsbAsxZrWR2wd9ID9l0C8Fk652uNbT
         lv+tDpc4zVpq1wqRJYfJlmqVVKiZwSAS2dYkkVOEy4ttvfOJ4fpFX11XOT6EIOgt+eBo
         JP3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+KA4N+ITNSeS4wrGzxGwREIQmr/Y4TVo0B4DPEWIykQ1qeRtgeMcsKJKtNqUhenQL0Q1zYlQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV2IBsA2+jw+n5QAqDmjXh1dwa0EjpMIrUytKVDju9M/d2TgTd
	bgSm+h1bzKYxX8gV8FjdnHT1pH3yTzcBFvyY0Zzf2A9Jlru+nqH8lqeDjCi+SSilnjBhbMBFTDH
	UD5RABpwi4g8gswXsaxhZK74Da1hWJ1Yy1eBYamDQHoeIxVLvLSVH+VOHkA==
X-Gm-Gg: Acq92OFn5oURJDxA9ml0QvhKVV+f31Be8A/+GuawW36QdZX4z6k2FBpw+7khUNseMSh
	YT1ws3DQlOK3jR91fdSiUDCY+vIDxIYiUPg1pL6pLq+gU8tx9rwBXZlbNz9duXHM+LW3NrtIUX9
	uBT64nMZ5CoT323/+QdlWMpe8FqmsSNvArbnf5XlR9rHOyWvUH8AFmQHhAOvUyFMwzWaGHvBQth
	OHCB//RgLpRPW2xft3cbWUWELKUYp+f2IXHKHbo22KQX8S9T+huuXg5A8KkNr2EQigxxs2pCbsn
	UxpoBeMNCnQanF9B2u/Sy0o5ULtLyUHV8EAekntPQAM30x237rn8iuEXKRBqWJpkLKtpMRb4mEm
	sLJ30Vg9s9pMiXG0bbRxpiJvCWHVmbdx9qF9E0py73sMaq7RLuyREcBlNyA616sOvSvmF1iiAYH
	jVIPqzA93u
X-Received: by 2002:a05:600c:47d3:b0:48d:c0a:3813 with SMTP id 5b1f17b1804b1-48e51e0bb62mr256258115e9.3.1778515012654;
        Mon, 11 May 2026 08:56:52 -0700 (PDT)
X-Received: by 2002:a05:600c:47d3:b0:48d:c0a:3813 with SMTP id 5b1f17b1804b1-48e51e0bb62mr256257845e9.3.1778515012100;
        Mon, 11 May 2026 08:56:52 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6daf911asm100865105e9.5.2026.05.11.08.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:56:51 -0700 (PDT)
Date: Mon, 11 May 2026 17:56:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Polina Vishneva <polina.vishneva@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Denis V . Lunev" <den@openvz.org>
Subject: Re: [PATCH] vhost/vsock: Refuse the connection immediately when
 guest isn't ready
Message-ID: <agH3WvJtAsQ_5zx4@sgarzare-redhat>
References: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>
X-Rspamd-Queue-Id: 73334511ADA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286731-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,virtuozzo.com:email,openvz.org:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 04:56:10PM +0200, Polina Vishneva wrote:
>From: "Denis V. Lunev" <den@openvz.org>
>
>When the host initiates an AF_VSOCK connect() to a guest that has not
>yet loaded the virtio-vsock transport (i.e. still booting), the caller
>blocks for VSOCK_DEFAULT_CONNECT_TIMEOUT (2 seconds), because
>vhost_transport_do_send_pkt() silently exits when
>vhost_vq_get_backend(vq) returns NULL.

Can SO_VM_SOCKETS_CONNECT_TIMEOUT helps on this?

>
>If the guest doesn't start listening within this timeout, connect()
>returns ETIMEDOUT.
>
>This delay is usually pointless and it doesn't well align with our
>behavior at other initialization stages: for example, if a connection is
>attempted when the guest driver is already loaded, but when nothing is
>listening yet, it returns ECONNRESET immediately without any wait.
>
>Fix this by checking the RX virtqueue backend in
>vhost_transport_send_pkt() before queuing. If the backend is NULL,
>return -ECONNREFUSED immediately.
>
>Signed-off-by: Denis V. Lunev <den@openvz.org>
>Co-developed-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 1d8ec6bed53e..a3f218292c3a 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -302,6 +302,16 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
> 		return -ENODEV;
> 	}
>
>+	/* Fast-fail if the guest hasn't enabled the RX vq yet. Reading
>+	 * private_data without vq->mutex is deliberate: even if the backend becomes
>+	 * NULL right after that check, do_send_pkt() checks it under the mutex.
>+	 */
>+	if (!data_race(READ_ONCE(vsock->vqs[VSOCK_VQ_RX].private_data))) 

Why not using vhost_vq_get_backend() ?

Also is READ_ONCE() okay without WRITE_ONCE() where it is set ?

>{
>+		rcu_read_unlock();
>+		kfree_skb(skb);
>+		return -ECONNREFUSED;

This is a generic send_pkt, is it okay to return ECONNREFUSED in any 
case?

Thanks,
Stefano

>+	}
>+
> 	if (virtio_vsock_skb_reply(skb))
> 		atomic_inc(&vsock->queued_replies);
>
>
>base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
>-- 
>2.53.0
>


