Return-Path: <netdev+bounces-299587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pn0QDjhXMGpoRwUAu9opvQ
	(envelope-from <netdev+bounces-299587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:49:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA4D6898E2
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:49:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gbJcuINd;
	dkim=pass header.d=redhat.com header.s=google header.b=mAIyE5Je;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299587-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299587-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFB41300BD43
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C253B6BEB;
	Mon, 15 Jun 2026 19:48:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614263B5E19
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 19:48:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552927; cv=none; b=lSAr2qFPrAHzqbAuqS2xtNtw5k0HslVx7chMKTEQN+sME07dikY55opVHsUs6VmeuxY8Bb8hJOc6uhRXENJ9w3718xGTfnhsqVFYi12el+0nspUlFjrXjJPXutWukT/5lFVtm9Ozb/6wmr8pOY19LfOEYDdYYJ+5q5hOBpD/um8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552927; c=relaxed/simple;
	bh=HywRkiOpkQuCnAiRcy1+1nGB0pyzOVqxgczZaqgqCr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2bN0y+xY5mSKddUX0kLb2vSd0/upSGVrf3nhbQT9h2+beH80PnqV/3Lq+gRF4PsLna1GHcfEXcq2ZcfxnXe9CbJMPb1vmP/SaDJE8rlpOvQ5adZVPODbdoi7jmCOg0Yo8DHImVfPQsppAn3tfE/DA6RV8MyGhG1cvwJALaQ3UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbJcuINd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mAIyE5Je; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781552923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nhU6+tUSSRwqgOUkAhL3IQec07W//7LlZKU9ysLcGq0=;
	b=gbJcuINdCEDyQFAi3wvcsqAclZg2zxw3WaqYtLoHGjIJAswaJyFZL9jwF0noNAKq00Su/j
	XL1eIOv3nPZ6w+tuS0KPkL0lOqXUuJB/HpZRhmmxDGXnVYQeLY2jhKaCMgEH4Ey2aGRq/C
	a1O+XN2VWaSnl9+K8Y5TXJ+sojW/ZTY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-CC7o8d9YO8iFbUuh3srgXQ-1; Mon, 15 Jun 2026 15:48:42 -0400
X-MC-Unique: CC7o8d9YO8iFbUuh3srgXQ-1
X-Mimecast-MFC-AGG-ID: CC7o8d9YO8iFbUuh3srgXQ_1781552921
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46067399d5dso1682959f8f.2
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781552921; x=1782157721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhU6+tUSSRwqgOUkAhL3IQec07W//7LlZKU9ysLcGq0=;
        b=mAIyE5JeEujnTY2QcHz2rk53WzH5gW8ATzl1nJSJsw86LoGhm6w3K/MUmHALSrcVFi
         i9knH0/bgeldvuraP+R3sg+gnXhs4uemTtIRECaaoK8PnK9cMc9ENbjWo+gr92Y3S6w0
         lXCVvMRr6eHiK7ur8VSCkaGAOHj0TSkSrhutYR0p+D96qez+pVP1fPAJkq97UitUmkGK
         cO6J2dearHn4wZyM58VGfwTFlNtWRUALcgtC1NLpV+jIKBwn/KJZBl5JG9+RHl3o3ZhZ
         8cAzRhCtkqXX+674/03VmAADakZB0H+Hm8YU9RhAbdivnsL9dTVXhkx0qSX6m/Ve6u/j
         /+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781552921; x=1782157721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhU6+tUSSRwqgOUkAhL3IQec07W//7LlZKU9ysLcGq0=;
        b=KugkYAeFosy+6IK3EXJd5wmjyklUK2pp6ROH2GlLPhqWgXPWEMOKfBOSTrf2EJSA42
         B5KAO2JJPZ6Uvc79NWewxvlTLXIRv11pM3QqjInWZngQulgJMCFm0GLrn5OUTIgy2rFN
         3cqNrsOsarQ9i2fLi4SlbAjxzYW80+tCJwH2b0rQENGgHMA/P7YoNOZDgYoiAKAsmaMV
         RYpUXZPiUIDxYLE09IAern+d2abukMHi6B0E5m42vxp1hVeQhVh9KACcmVlsRImU/Sie
         F8+ZBtIT0ONCPTME98JtzscUsCQoP0qAO199pfLIlQyxfxISIpxh1BXxFbuhVTpTKkIu
         Ar6w==
X-Forwarded-Encrypted: i=1; AFNElJ9t/TCvbPlJ+C9L/+l5Bsx0W6buLAKG6vAlcblM+abzO6uuJD+IlEJ0sYf5oge58kiZX9mUqwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUn40rNqQePD95rCZdGV+CJQBfSbAc+mLyaOXN0qh3sVuTnqDT
	U5bvbJRUZyuya6Gl4dO3OEwD/9k9kQJyXvIE6+BM1KMK7rCEpNodzbc5rTLY75HeHIQnVQrCdOK
	dgpNrYwUw83GmsCl8ZQ0uZRD8jMHMc0Wu4RPbqLQ3W9z53L8PMg/urQAXPA==
X-Gm-Gg: Acq92OGSfQ+QxGQ/fQNUIBqMIxDIDXN+B4DVZeUlxdVCxIqkA8Cas686TDO0lFbrdSR
	H23vJDECKaBMW+l+JO/+VPFVixqUXWVfaW6oifKze/7m6wx/oczW5WQ6zBiMbxM9aE1DTu132+O
	Ju5sz3E66Y8jiz/AZS6qvAvaRX1KI4JK8456+6a1V16jGlaOqZ/C9pQyewguBy+Z8j/pruqC8SH
	uEY8xZbn9AbwNJ5p/TuJe1XMgDSNwWd9rs2M6x+UpfGYVdKxFOGqP7VnnlrgXRjf+mLkOokHZSX
	bDFfovemSo05++DZA2/anW7MemXx116DAhxwCj66k+3ocOKY5+nw5CqZx/miy2iJ75/OZLUPPjq
	mmIzCdN9HxgYDCQRQ1o1isflnqU8Nuo3OqOrxOCQK2fU=
X-Received: by 2002:a05:600c:820c:b0:490:4b89:5361 with SMTP id 5b1f17b1804b1-490ec4c5984mr208652865e9.7.1781552920865;
        Mon, 15 Jun 2026 12:48:40 -0700 (PDT)
X-Received: by 2002:a05:600c:820c:b0:490:4b89:5361 with SMTP id 5b1f17b1804b1-490ec4c5984mr208652615e9.7.1781552920426;
        Mon, 15 Jun 2026 12:48:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2d933esm35788998f8f.33.2026.06.15.12.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 12:48:39 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:48:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] vsock/virtio: fix MSG_PEEK calculation on bytes
 to copy
Message-ID: <20260615154828-mutt-send-email-mst@kernel.org>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299587-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leonardi@redhat.com,m:stefanha@redhat.com,m:sgarzare@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:avkrasnov@salutedevices.com,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EA4D6898E2

On Thu, Apr 02, 2026 at 10:18:00AM +0200, Luigi Leonardi wrote:
> `virtio_transport_stream_do_peek`, when calculating the number of bytes to copy,
> didn't consider the `offset`, caused by partial reads that happend before.
> This might cause out-of-bounds read that lead to an EFAULT.
> More details in the commit.
> 
> Commit 1 introduces the fix
> Commit 2 introduces a test that checks for this bug to avoid future
> regressions.
> 
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Luigi Leonardi (2):
>       vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy
>       vsock/test: add MSG_PEEK after partial recv test
> 
>  net/vmw_vsock/virtio_transport_common.c |  5 ++-
>  tools/testing/vsock/vsock_test.c        | 64 +++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 3 deletions(-)
> ---
> base-commit: 9147566d801602c9e7fc7f85e989735735bf38ba
> change-id: 20260401-fix_peek-6837b83469e3
> 
> Best regards,
> -- 
> Luigi Leonardi <leonardi@redhat.com>


