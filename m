Return-Path: <netdev+bounces-278742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADjwDhxo32lSSgAAu9opvQ
	(envelope-from <netdev+bounces-278742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:27:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A194240347E
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88EF7302FEB5
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D69C329C6B;
	Wed, 15 Apr 2026 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyYGHAEj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8862AF1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B1C146A66
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248856; cv=none; b=prXuQMbpad8YUFqFxMDpPHeFAV6q6/i9mdRHdIHMAVskJU0FdxeG6jyWNHmR8uqXuwudIRORbyHuguR9Lgdfi9FZ/LWmOgIn1pYzMRMd1bzHXNveew9sdG1M33Hm4Uq9aCiXbDQZUXmnxHVG/B6lTMQYct2BTv5dL2w0lTH6Chg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248856; c=relaxed/simple;
	bh=qpmmJkNYBy4XAOH2rFRHIMtgRTplbw4eKxOGO5WgsoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iop2XTvdKtN6t5aLTrSTqqZKoXcHwmlTTFoXjqZzw8YG6S9tfxPJvhnrWieTzdUF/FP8QlLuxpycDDZIr9OhI3PbFE5MUJsOIMervIhZV9V+ZMaivqJ4onLJnAg70yZCTIsWTEcl33UGTu8e9Pa2OQfGaEjAKGrxmJxj/mbuXrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyYGHAEj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8862AF1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776248853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qpmmJkNYBy4XAOH2rFRHIMtgRTplbw4eKxOGO5WgsoU=;
	b=SyYGHAEj4ELnnCV9/gTogzFhj93SaZq7aHfyG3glwI1+fadONypAltTyrDOpQPO/ZFfdeS
	4YgtUWBb21KxlO96+Svv3cNrCmBQnTbqb0WUEMfybpnOTaOO0wht0I3/sEty4XKq2ImG5e
	c7FelXWZEYVJNil4YRJN6EnWriAeSgY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-n5t7uNmJNcaajaa131AkfQ-1; Wed, 15 Apr 2026 06:27:32 -0400
X-MC-Unique: n5t7uNmJNcaajaa131AkfQ-1
X-Mimecast-MFC-AGG-ID: n5t7uNmJNcaajaa131AkfQ_1776248851
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488d4ac6ff9so37682415e9.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 03:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776248851; x=1776853651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qpmmJkNYBy4XAOH2rFRHIMtgRTplbw4eKxOGO5WgsoU=;
        b=Y8862AF1eIeW1drnB6Anpvyu1cFGHBpwUmErAu1TSYIrfhch0nZxfMVclsvwTxxGmY
         6QLwKfWDA4eQvoGyGrTU/v0AvLfXPQWMclgL5uSjmyglXqqn8ocYPc5IkI/uRNyXbeOS
         vOI592hocABRUEiv+EVoBAXbDRbe1boUt/Ttg2QQaI1EYipflL8mmkLlQa9hIZJSVvEi
         murOqwx6ClCOI/fyXbqaHBTTEwhiglvFOhNfUNo4HBzrJ6vE24Qm1TIIt1A5bCrOGPf0
         EUCucOMj0FdLHBM4FHAVAMMkTsOkjqh+60rvn2gTLEX1AatymlPq87pXwO/UPkxmLIny
         bACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776248851; x=1776853651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpmmJkNYBy4XAOH2rFRHIMtgRTplbw4eKxOGO5WgsoU=;
        b=CmHWywfJSZwSsN0KuKXnMUuzh1mvWEOc7B7roOw53MBFa8WD6T57W3RWiTAJqjhOIJ
         UQRb1Csopf6BFUIB3hL3qk9LbtbaJZyIqivEgzaJtlCUXgI78qcvxNLKd7FfpXUrkYHH
         /T82Byhsib0IKrQNEC4vDFNsdspMV5z5bVt3LL0bmSRgEAXRyXWX2SM4AorgmkPaP39Z
         dCzxg6D2nTcR2FCymdrVvdurd+pIeQGCdnriz4S3z4WX36JII6aHmTcpFsxRc9ZOng1w
         qLSTS2JHojNty7S9Ud08BUyfFvr2lV6lwIEQwYlLNHobXx0jJVkhyZS3nWc8qfPcQPHx
         kAmQ==
X-Gm-Message-State: AOJu0YzS+55p1C3Q1Ng+DgGvaa4DafFbx1reo5hPsFO6vXjAuuxGBO+v
	/8nkIsEIW34EYBLsqpRHWF2C3UwUcdYZvQraQPBH/49hNQzvOzyFeezjG6hVLBsVHGXTPqw1HoB
	4t1OKLhUAuCpoBpv7rdTJbdxYMyE00xr7AMH0hWNyNvcPEIxHbaoRXo6sCw==
X-Gm-Gg: AeBDiesJBJyWJ5KYv8P1oV+4HGBx/OqDrcBPFRQe9BgWTrKtnCuE0zx/dITXjbwV/YH
	IV0c/1Ayz4nFb1c0Q4jvK58n/82IfVE+RB8z0br6q1QSnHVQ76TkNCjG0ht22p9a/k5GXRzhoDN
	MCyeUkNX84qt3NliOLBLMxNe80MrZUjwubOOL3ud2vByIbLM0kNa4Uz3hiYQnygFE411OBoiWyT
	gk00d8Vh94kzP06OQCin2d2YZRQM0Gvs5eeCUynHxrmI/H8L1T6KsXPsut5eallTWbBsklaOPxY
	uLqvuolM2xJyd2NPmi7mbc8J6joiwgG1FNQyDyswwuoqtJFgHigX9Mosm4EBVAJ/jVGYuM+E9Td
	ste/oBVd1uaJNYiw1gFhpGkH0mLGDxne8uQveX7ocU2LaP3lQCFMHYgfLJ6fQFsghUeOLSzEK6S
	z9SPj6oA==
X-Received: by 2002:a05:600c:c0da:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-488d685b577mr245346155e9.21.1776248851143;
        Wed, 15 Apr 2026 03:27:31 -0700 (PDT)
X-Received: by 2002:a05:600c:c0da:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-488d685b577mr245345765e9.21.1776248850685;
        Wed, 15 Apr 2026 03:27:30 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5ea9sm4221555f8f.21.2026.04.15.03.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:27:30 -0700 (PDT)
Date: Wed, 15 Apr 2026 12:27:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dudu Lu <phx0fer@gmail.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, mst@redhat.com, 
	jasowang@redhat.com
Subject: Re: [PATCH v2] vsock/virtio: fix accept queue count leak on
 transport mismatch
Message-ID: <ad9ntDa0nI92Ase5@sgarzare-redhat>
References: <20260413131409.19022-1-phx0fer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260413131409.19022-1-phx0fer@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278742-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A194240347E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 09:14:09PM +0800, Dudu Lu wrote:
>virtio_transport_recv_listen() calls sk_acceptq_added() before
>vsock_assign_transport(). If vsock_assign_transport() fails or
>selects a different transport, the error path returns without
>calling sk_acceptq_removed(), permanently incrementing
>sk_ack_backlog.
>
>After approximately backlog+1 such failures, sk_acceptq_is_full()
>returns true, causing the listener to reject all new connections.
>
>Fix by moving sk_acceptq_added() to after the transport validation,
>matching the pattern used by vmci_transport and hyperv_transport.
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Signed-off-by: Dudu Lu <phx0fer@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


