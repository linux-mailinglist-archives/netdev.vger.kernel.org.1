Return-Path: <netdev+bounces-276335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLtqAVgL1mlnAwgAu9opvQ
	(envelope-from <netdev+bounces-276335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:01:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE333B8ABB
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B47B3005768
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EC839B962;
	Wed,  8 Apr 2026 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4YhCt08";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ch0ViUVq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C537F749
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635279; cv=none; b=QgAWt+igkGmbbLvQbS2qHLQcecpWYLo7YtsSSc8AGuu1VCBjPOxf7HQ8a/XV5ZPql/r8q27Vs8y4RS/oVFU8ORCj2Auxo0s4SGA2CFm6BvVgmTlRnDpJYwYlMi+N4V7gGYB6sFX4mSNGaEp7bta+J+3i+5ioxjibYQYMZEV7q1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635279; c=relaxed/simple;
	bh=VNtmdeyD8ks5WGqCaRVQj9tbrSu1bGMKSPQMorgZx2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZB8YVXvYZoJUL5bMfukFLqKoUPfIbhfgSf4iaQcpHkwhWTsVWyBdV7mY6A4QoFc7FF5LcLrHts1IbBCS1zs68EshsS4MVXEy+ffEDecL/celaaR8x8ddrqWbvrSfcZEFH4zV9h3kgFEJPOh1jHmCWf4ysbUAb24i89HEutm+Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4YhCt08; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ch0ViUVq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775635276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vv/PNE06UTD9uwqSDBv6GwqwhwLSI3Ze0AfZPOM3Rjw=;
	b=N4YhCt08WxrtYpqJ+PGXGePVKFdrliycyP1IxZRFm+dw7kgeDsSpn18U4LuQnBWSkjWJbt
	8aYL5ZhVpoWAhwEQLKa79BnR5GOeQM+A18VspsnUhjb5M919wwNHF3Q3lw/JeHlUxse4pi
	DyyVt3chvkzdxRN7/QcJKeFQG1TX9hk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-ZCGXpsinOFWHLA9B0cKQ5A-1; Wed, 08 Apr 2026 04:01:15 -0400
X-MC-Unique: ZCGXpsinOFWHLA9B0cKQ5A-1
X-Mimecast-MFC-AGG-ID: ZCGXpsinOFWHLA9B0cKQ5A_1775635274
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488be6ab870so11473085e9.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 01:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775635274; x=1776240074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vv/PNE06UTD9uwqSDBv6GwqwhwLSI3Ze0AfZPOM3Rjw=;
        b=Ch0ViUVqviotazvWKXu1RmQ3E4r6JS7i8MgGCkHHl9qN69e/5oRiCDWnrKfWvwKowI
         GqGd5x/3xvBCDz7Z+pxLfhMQ5HAnt2Ctr0j3r1opSdDgC3Flh1NnuevySwKbwG0LEHnG
         HjMHISjAVfh7m3f7JQ+auREX9MqiuwwChEmAPmTk+e/pzcz0aYjpF11txbIasizWalmY
         BhXTGYu0puBEge1ToQHfBNFNCueThfRdmxr29nloRbUBumiYWkNB34v45gWz89YdcWiU
         9PFS+ujW1YNqKu1Uq5P6Hip3wVQf6zQGPzFp5wyY7iVzzADH7PpC10OnSh8yMyxDWa2A
         VD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775635274; x=1776240074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vv/PNE06UTD9uwqSDBv6GwqwhwLSI3Ze0AfZPOM3Rjw=;
        b=hEO6cZ22quHn7JfGYUvfYY7MdtX3gNhVHGoAnIox9mLNpf8CGYC3MDRY634fUj52tX
         FcHy/8bqmFJDIhpNDQSZZz73RnAr+9TDEyK32AYxyb6ob/pJ1xz/JDazdxJ/F+2L3W2I
         Z7RfYruoKyPXRtfUd0fBGW8kdUy1NHpCeA0Q1Bu5dQxYtHHal8gwcfyEh0xPn70jBg7P
         PniAbJ9BIgZuz1DjkFJPZQ0M3NnT7qrbf1+Vgj6vRPOYdMteI89hgwtzO5XVQsUy8Anv
         NqJCVnKqhbC0It1VXj2R1R+YISC39c8sa+entcroxjmC7p6Xzk6szHfAmnwIJYsD8M1g
         6Skg==
X-Forwarded-Encrypted: i=1; AJvYcCWvJu1qTY3dSa6Li+xyYYtnJ2t/mBNCTOaJ3gN8mS1xs/FC9tvVVS2sh+0bcectQj8bnqKNHpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG3f85gi8vx7t0SJRvsOCXIdbJSm9OB8NQ7bP8RDOUbJHzSGBq
	FkCUoL2rmR5kSH/ZwT6ad/kw20+uh93mwKjW/QrSHYsNZKE0HEebx7y8//lWjVTGJPsGn4faucE
	j8VhQ4HCwT88qD/12vy5+LWljdFWfUM0waYtThtx9jZl/UhfHjw03Em3gZw==
X-Gm-Gg: AeBDiessWuwmimw7URSanHvoEJs5sHeXJH/Y8TvHKSVmw1iXVEYk/cSw3qaIFBQoZ7Q
	li7j50mlda/3KQb25d7uAKOsptcl020XFr3//zNVZDgqqkbsJXCDdKfuigY2R9X6t95u4axkl5E
	7kyogLr/GzHDRtcx2pcUcPOX/EAeeRO+zK5HglIX6WGUTKHX4Ql/i+34pRpyFVzwu0cT+5QgpRA
	o+Z3Z2u34OpJmZAtLSLrLs5d4tqhOjWcFldRoYfqA4+PqgnJwWWsZngdurk+o2y85D1wXp+/cEl
	ObFCow1hUjSgQ40GZUKzdm2dpLj81tFghMPU/QldXJAEOBRopJWWLGEeKqi5g2XymKWl/XOnlC6
	iL8pgVNBVVyBPursxzouPeTkqx8dokCyYnO63xj/kmbczGpzANZ45O/VtXslNjvEbEjPn5R9OPQ
	==
X-Received: by 2002:a05:600c:5292:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-488996d2309mr295098745e9.5.1775635273738;
        Wed, 08 Apr 2026 01:01:13 -0700 (PDT)
X-Received: by 2002:a05:600c:5292:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-488996d2309mr295097975e9.5.1775635273101;
        Wed, 08 Apr 2026 01:01:13 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a91686f9sm352031205e9.10.2026.04.08.01.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 01:01:12 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:01:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, John Villamil <john@doyensec.com>
Subject: Re: [BUG] vsock: refcount_t saturation and OOM via buffer size
 invariant inversion
Message-ID: <adYKERRYwzMIhZAl@sgarzare-redhat>
References: <523A8D3C-F4D9-43DD-A3A6-01C9EC335656@doyensec.com>
 <acuKUpZQq6z1DY_n@sgarzare-redhat>
 <C918071D-C036-4FD3-BD64-16C8E143479F@doyensec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <C918071D-C036-4FD3-BD64-16C8E143479F@doyensec.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276335-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[doyensec.com:query timed out];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[norbert.doyensec.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AE333B8ABB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 08:36:16PM +0200, Norbert Szetei wrote:
>Hi Stefano,
>
>I like option 1 the most, as it is the most straightforward way to fix
>the issue. I am including the patch below. This fixes the clamping
>mismatch, but as you pointed out, it won't solve the root problem
>regarding the issue to arbitrarily set a maximum buffer value.
>
>Since VSOCK uses a unified buffer size rather than separating read and
>write buffers like the core stack, introducing a vsock-specific sysctl
>(e.g., net.vmw_vsock.buffer_max_size) seems the cleanest approach to me.
>I was also considering net.core.wmem_max/rmem_max, but mapping to those
>feels less natural.

I would prefer to stop to add custom sysctl/sockopt for vsock and start 
to reuse the common ones, so if net.core.wmem_max/rmem_max can be used 
in some way, maybe we can try that path first and fallback to a custom 
one if we see it isn't doable.

>
>If you agree with the vsock-specific sysctl, or have a different
>suggestion, let me know and I will send a follow-up patch for that.
>Thanks.
>
>Best, Norbert
>
>-- >8 --
>From f5d160167c862c7f2ad6e6a1d4181d01997b683a Mon Sep 17 00:00:00 2001
>From: Norbert Szetei <norbert@doyensec.com>
>Date: Mon, 6 Apr 2026 19:52:52 +0200
>Subject: [PATCH] vsock: fix buffer size clamping order
>
>In vsock_update_buffer_size(), the buffer size was being clamped to the
>maximum first, and then to the minimum. If a user sets a minimum buffer
>size larger than the maximum, the minimum check overrides the maximum
>check, inverting the constraint.
>
>This breaks the intended socket memory boundaries by allowing the
>vsk->buffer_size to grow beyond the configured vsk->buffer_max_size.
>
>Fix this by checking the minimum first, and then the maximum. This
>ensures the buffer size never exceeds the buffer_max_size.

Please add a Fixes tag here, that should be:

Fixes: b9f2b0ffde0c ("vsock: handle buffer_size sockopts in the core")

For virtio transport it was pre-existing of that commit IIUC, but 
doesn't metter since these changes will not apply without that commit, 
so should be fine.

Please add also a Suggested-by.

>
>Signed-off-by: Norbert Szetei <norbert@doyensec.com>
>---
> net/vmw_vsock/af_vsock.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d912ed2f012a..08f4dfb9782c 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1951,12 +1951,12 @@ static void vsock_update_buffer_size(struct vsock_sock *vsk,
> 				    const struct vsock_transport *transport,
> 				    u64 val)
> {
>-	if (val > vsk->buffer_max_size)
>-		val = vsk->buffer_max_size;
>-
> 	if (val < vsk->buffer_min_size)
> 		val = vsk->buffer_min_size;
>
>+	if (val > vsk->buffer_max_size)
>+		val = vsk->buffer_max_size;
>+

The patch itself LGTM!

Thanks,
Stefano


