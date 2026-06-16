Return-Path: <netdev+bounces-299854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PtLyOlNSMWongwUAu9opvQ
	(envelope-from <netdev+bounces-299854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:40:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF6E690044
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:40:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=FMYWd2db;
	dkim=pass header.d=redhat.com header.s=google header.b=ZUfREJWM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299854-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299854-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DEC930CE36B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE57130B501;
	Tue, 16 Jun 2026 13:35:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875A930595B
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:35:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616944; cv=none; b=eniGwR5AYYxA3CYho1qciw8QdRZwTehQncD02lwx/tuxND1lv+ADgLma0nWfi8ThSbmniDnwTeQ5PLOjOa8z67WNXzmixd1wOP9CwZ1dI51CLEmbwrtf7DW/0HC+qc6UhuMRrSQ0WGIwYImwRPjfpoymM9cMHszbrQBiNy15Ib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616944; c=relaxed/simple;
	bh=floBdjdCkfcczlUBmvJASMGyf5DyrXJjY+5qz4ctWNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pczfxUt1N47Oig2mu2gx1Ec0iRr3CH7VkffQ8xBxWNaN+J8mbPX7ZEcvdviTrY2ooGeD0WQ6HDlATWX9vrVJJ6S8lz0MFH7T5kUwmR97Yj4PpGw+HfAn3SZJmmdfAMSTTAJkAdMEv5OeMOJtL/SOEV+1hCZROrVNecJTne82N0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMYWd2db; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUfREJWM; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781616942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMvcIb0SSmVD5ZpReBVCmF4OYpfrO6nfm5qCtnbjlbs=;
	b=FMYWd2dbyaF/Va9FGSYFHxAKCpEQHWhprGgrHpCcHqHgEBrrYZ03HnCkjv1VqnxxSZT/9A
	7aKqRhDynZ8vaUFxSLlNGprgb7hC7TPs6cEh7DnJlma+lMDbxomqYKx2zBYFHPacHRMN2K
	DYKj/Yc9vkotE9fFmxShGkDgrCYPOyw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-SzaYzVCXPiKjTZPGTrMqHg-1; Tue, 16 Jun 2026 09:35:40 -0400
X-MC-Unique: SzaYzVCXPiKjTZPGTrMqHg-1
X-Mimecast-MFC-AGG-ID: SzaYzVCXPiKjTZPGTrMqHg_1781616939
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b9cd54f3so26947695e9.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781616939; x=1782221739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gMvcIb0SSmVD5ZpReBVCmF4OYpfrO6nfm5qCtnbjlbs=;
        b=ZUfREJWMTRBR+l9QwYwt523KzP1Ce/Xm7LU6xVo66PB/zEXnZfqcBWnuBhTcAgSGnB
         HlrxdCWDSK8Px0MsRp9dJ+Kdi5bIFZks7P5xtHJ7T2AxgO/LTXTs6wd9aMBCTxWlm0ch
         wf5qpamywY4zJLvdVCUh1ULSjeGcxnBIpoRYlwafLK83n5uTl3x+G5fCemsu/0KSqht6
         HY5mD3IjwECSYZTUE79KHCxb8ONqukNS2Motq5TWdTKQ/WRhhkndPVtelXs8x5avGX+a
         ppT5aqeCQ1Jjk/+1AiktNmluvXgKh+L7rDhWpXk+gXLgh6FGskEEG8iSSEmFnm6CDF15
         z4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616939; x=1782221739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMvcIb0SSmVD5ZpReBVCmF4OYpfrO6nfm5qCtnbjlbs=;
        b=dU2FLJhBnGDvctgPbnPBrFLUqp7UuPRnUNVNBn1edrU5x79lHL3MJZ63okIv8Z0yj3
         59vADTgzv3OPm8A39KPYyCIJBQfkZz7QZXwGKz2/QEmN14kqWl65vDU3QYbRimAiTCUU
         VmZM3Lu17U4UC0QsLuYUYyTyctL4O4Cfl+mNZnJFDz/j0MkzTJBGvsI7pkgypJFLSTpG
         vtL+n9CjXoLDH74ACbam5PJJ7g1OVNd7U5mMkywbygp7JjDmOy0fcabQ1cmUw7YfWSAM
         G/lFgDwuHWYZD/4lcuK/8aL4sxpe5+oGY+S+W7nr2wi/0u+8Taxf1Zc5Du1a4WN+ENWz
         ILwg==
X-Forwarded-Encrypted: i=1; AFNElJ/FQYsYr7pndJ53QjEICZg5a6PYWSdDw5qIVrbB7lhmmpSzWd95UjYtjKybSWzn2UUROuIQCP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrUEqC7J0qVqmFdXE0YPc0TjOeL6JHxLTD6Bit1Dk/r8GnGa36
	lo4nofKJnCDgDBvfQhK8ZEI392sN3z+YTEmpzSYy7H911DzVDN/cmbDA/FLO3McIkFdnAglbbHL
	aIBpJBj5hFXEpsJuTNCifieFAOHvu5p+3qhbvHKJs1BqlMKnmHZWezVP/qQ==
X-Gm-Gg: Acq92OFRf3LzQNXU2WDu0VTO5H6yg1llHBUoQZqos5iEesuEUY8E5EFo7kKywTb5b8b
	xmbe/agINQtrc7PbjPs2yaZ2yERuOxTrEdX9HEvABLqNy6zngC5dKKe3NOyvcYvvCSeipNDa3e9
	HJyWnWO4hZvziP6HTbpfWDCgzqRkNtzw/iehNNHpdTMup9tV4ythv+ff12S3LWgkbI1OQz/cdEM
	fCc3mt+XdNQlO8rSkD7TIvKk5S1Cv6LWIzI77i33UaMjKs5fa5+qP37dwvPnsDlA/LBOqyOFqcT
	YoI4tdjpjuC85ja0zMiBmOCjkTB0564kNjYYUgtMaG75q3gPKzDoWLqlOf5EaKr0l4m24FZxrbb
	lWHac1BEKod0Br7vJAeaUTqRnOTF41Tq1ZvpC+dNrCmixWZjDop7MC3xLkk/yZr5chKY5fF0=
X-Received: by 2002:a05:600c:c0c3:10b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-4921fcb3ffemr168841305e9.0.1781616938927;
        Tue, 16 Jun 2026 06:35:38 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c3:10b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-4921fcb3ffemr168840785e9.0.1781616938426;
        Tue, 16 Jun 2026 06:35:38 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa890d8sm89760905e9.10.2026.06.16.06.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:35:37 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:35:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 0/4] vhost/vsock: add support for VHOST_RESET_OWNER and
 CPR migration
Message-ID: <ajFLvKcT-A0wvLYW@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
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
	TAGGED_FROM(0.00)[bounces-299854-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BF6E690044

Hi Andrey,
thanks for the series!

On Fri, Jun 12, 2026 at 07:57:14PM +0300, Andrey Drobyshev wrote:
>Host<-->guest connections via AF_VSOCK sockets aren't supposed to
>outlive VM migration, since VM is moving to another host.  However
>there's a special case, which is QEMU live-update, or CPR
>(checkpoint-restore) migration.  In this case, VM remains on the same
>host, and we'd like such connections to persist.

In the spec we have VIRTIO_VSOCK_EVENT_TRANSPORT_RESET which is usually 
sent by the device after a migration.

IIUC the specs don't say this has to be done all the time, so we don't 
need to change anything in the specs, right?

We just need to avoid sending it (which I think is what we're doing 
here... I still need to look at the patches).

>
>For this to work, we need to be able to transfer device ownership from
>source QEMU to dest QEMU.  Namely, source needs to reset ownership by
>issuing VHOST_RESET_OWNER ioctl, and then target has to claim it by
>calling VHOST_SET_OWNER.
>
>Since VHOST_RESET_OWNER isn't yet implemented for vhost-vsock, let's add
>such implementation (patches 1-2).  Also fix regression introduced by
>the earlier commit [1] (patch 3), and fix the deadlock bug (commit 4).

If it's a regression, should we fix it separately?

Or is it related to this series?

>
>There's a complementary series for QEMU [0] adding support of vhost-vsock
>devices during CPR migration.
>
>NOTE: this series needs to be applied on top of Michael's vhost/linux-next
>tree as it contains relevant commit [1], not yet present in master branch.
>
>I've tested this (patched QEMU + patched kernel) approximately as follows:
>
>  * Run listener in the guest:
>  socat -u VSOCK-LISTEN:9999 - >/tmp/recv.bin
>
>  * Run data transfer from host to guest:
>  socat -u FILE:/root/bigfile.bin VSOCK-CONNECT:CID:9999
>
>  * Perform CPR migration during transfer (either cpr-exec or cpr-transfer)
>  * Check that file hash sum matches
>
>[0] https://lore.kernel.org/qemu-devel/20260612165110.431376-1-andrey.drobyshev@virtuozzo.com
>[1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?id=bb26ed5f3a8b
>
>Andrey Drobyshev (1):
>  vhost/vsock: re-scan TX virtqueue on device start
>
>Denis V. Lunev (1):
>  vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
>
>Pavel Tikhomirov (2):
>  vhost/vsock: split out vhost_vsock_drop_backends helper
>  vhost/vsock: add VHOST_RESET_OWNER ioctl
>
> drivers/vhost/vsock.c | 80 +++++++++++++++++++++++++++++++++++++------
> 1 file changed, 69 insertions(+), 11 deletions(-)
>
>-- 
>2.47.1
>


