Return-Path: <netdev+bounces-301789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id biMxFlxTPGq2mggAu9opvQ
	(envelope-from <netdev+bounces-301789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:59:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 158846C1A87
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:59:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="JFh2/LLl";
	dkim=pass header.d=redhat.com header.s=google header.b=FGFDqDwr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301789-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301789-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B05CC3014348
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F652F5474;
	Wed, 24 Jun 2026 21:59:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899802BEC45
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 21:59:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338386; cv=none; b=p554x+FPEDfsDEluTdi+rBPYhp19mkilCRB3z5TzCCBVRfIF6ytbTmDSdys7lxUF6DVk8Z1AdJR38qhRh9wl6OlvQNUw9+8z5g44oUahv2fEgfeZd3fRY7rVXb3S2RRwBcCn8dxxASEnFFq2PNYmikcchQyKWv9t7QhztllQ1vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338386; c=relaxed/simple;
	bh=1XTIFRs028W9ICgbgP9xwvBCqmmM/TabDzaJ5qzi1VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf4d/OyQcNHYp26APhj/Tqym1j7qZdLOzmGCJsju/FK7mIJl6gs7PLHyjkRbdOHvJVOY6QHPIw7WNv6xbPGX4ezU8YYgXo1sD5zsFLCrpL3gsMOZN8fuIxg1xVMjy4/a9FHph5JMDNYIk532j9VT+muPYlq8tDaVBDzs0VWOsMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JFh2/LLl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGFDqDwr; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782338383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6VcXuaFqUMqouxDur1YGdBLHaZZe+1Bi3XCCiBAengQ=;
	b=JFh2/LLlgFoOA3YaRds0/vXw44PzwwgF5i6ykQfJFX8c0bW8+yaC4hA/Q5u1RYV38S+M2x
	nDz+twHX3q/5D8tA77HFT8FYixSrSBCT4fEdC219FtX5ZIhbWX6w82Wv8W193B5GWI/3Kl
	C2isOo+5tuo5is6Tjre5qDKbM7Xm7Aw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-r5oxso4FNEOkVpQVwFGKMQ-1; Wed, 24 Jun 2026 17:59:42 -0400
X-MC-Unique: r5oxso4FNEOkVpQVwFGKMQ-1
X-Mimecast-MFC-AGG-ID: r5oxso4FNEOkVpQVwFGKMQ_1782338381
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b37e1f48so10037205e9.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 14:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782338381; x=1782943181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6VcXuaFqUMqouxDur1YGdBLHaZZe+1Bi3XCCiBAengQ=;
        b=FGFDqDwr8km9wVYze3EShtzYHiLy62CuxxdmKXO4KSIJsPjw7PrCEEaFlg7VL4mG9z
         ogSuPNuYIdNKiK7IEq692zTZ+5rHx07V65cDO2JbXVdQRjKUoRRSyXwrEIt6Zr0MJPGi
         maSRifXJpJC8AqyPOF2FQ9pLTKxI4GOD74DzX5k3Y4TdE+5DHj/2Q55xJ4+YVyowHKp2
         JIF8HB3DCgVgc3NJyOynm1e01KrqfeVdpev6L3Su/PF0u1mXp6xJbiul6nH3s1Ri8BoS
         4yH/3sIWBWH3egtrq0hG3cpU66+6m9MSs9uPIkqSz8SxVftqzFXUgkr9Zc9Zfpf2km6C
         4aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338381; x=1782943181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VcXuaFqUMqouxDur1YGdBLHaZZe+1Bi3XCCiBAengQ=;
        b=WfCC1JVC7olgA0qydjQbd4dfVu/864bZ192RhGaH+XNsreYdwlI6rYBhU7YQKN9V3a
         acXgknJQASY8I4DBZtwBXiwZg1NLZi7ZzoPF/kgOb3sDkmUolxlbEhVlfas8gLP4PUpc
         fbqcK/D8H6cwCzCpU7ePNQGxCBtzcwWPCIe+BuxqlnOBcK6b38tYKXE0LEi1Lf3DP9hf
         Zy8BrGkQ3MLe8G70SLuoBv4n+JaDHt2YeEAbKuPdUCNjDO+1po3PUbj9qgJ51XkkEIfz
         n/97+gHNOrrJkENqtQQd3NbSEdMoz8Rs7x94tB6CB9OVi1UXVe2KSrHLK2kSAPg91Ry/
         2wUg==
X-Forwarded-Encrypted: i=1; AFNElJ8d2gJE04Xyu/zjhC0HkAaZLULZ3iuhQ5GQn8iQ4EIG8sZHLd6FQJkvG5qPGA/ZQUho61/BTBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+B50gASoB0FpvYV149D8F24Yx+1I3Bt+qDvkpQkv9Uk3CPDnp
	MBTIWIL9F2fWDY8nVm7xCXEjJGy/UqEbD5gPViW26pxLXMOZv0801X7xJMLBdVlcfrq4Aa6tq8e
	YcQPdMDL9HDd7UBKDQNcPlylGgbBmtgpWzIBDVxWvkd18IWEXkV7A1/v3YA==
X-Gm-Gg: AfdE7cmeZmcAjOKkYEqva1Uq4zo1h4ZMMCgF4DlSW3bCmBk3BsFxLTFBExFCaCgW4FP
	i0aHfInV1oFnXbLYejE+nS7r4Qrix+XDdu5AWfSuB2oy8rs9Gp+DWrdOMBvDdWdFeYG76C3fs7R
	THI52brV6acf0yarEwfTeCW/lo9b4Ee5UrEl9wcMbTRJBIFIDHZ+iPRzVxY+u5yqSA0LQagzgt3
	DY8nTpyMSHjQGm2KZHIdbUIrF+oK7HESMKvvG36fkyMTEurMmiB+e5COn7iNlCsFfN7VPcaaeJo
	wfMB60p86+tbAu6586iG7E6bAoG3TMRWXGm9i2Z/E7unwiXXFwuDdYeqmNIVR1FsZfOmwfbKJuv
	YQ4akBPgxhAMlXj0GwUO8PavpDQlfdnDN
X-Received: by 2002:a7b:c8d1:0:b0:492:48dc:3d0d with SMTP id 5b1f17b1804b1-492608480aamr49420655e9.12.1782338381034;
        Wed, 24 Jun 2026 14:59:41 -0700 (PDT)
X-Received: by 2002:a7b:c8d1:0:b0:492:48dc:3d0d with SMTP id 5b1f17b1804b1-492608480aamr49420405e9.12.1782338380511;
        Wed, 24 Jun 2026 14:59:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926543be74sm5120715e9.1.2026.06.24.14.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:59:40 -0700 (PDT)
Date: Wed, 24 Jun 2026 17:59:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vhost/vdpa: reject overflowing PA map page counts on
 32-bit
Message-ID: <20260624175855-mutt-send-email-mst@kernel.org>
References: <CAMuQ4bV8OeSTOVnAPRh6ygKdogFjqEiDNj1Vbh623KBBkZgxiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuQ4bV8OeSTOVnAPRh6ygKdogFjqEiDNj1Vbh623KBBkZgxiw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301789-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:jasowang@redhat.com,m:eperezma@redhat.com,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 158846C1A87

On Wed, Jun 24, 2026 at 02:56:20PM -0700, Yousef Alhouseen wrote:
> vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
> size before computing the number of pages to pin. On 32-bit systems,
> where unsigned long is narrower than u64, that addition can overflow and
> the code can pin and map fewer pages than the requested IOTLB range.
> 
> Reject sizes that overflow the unsigned long page-count calculation.
> 
> Fixes: 22af48cf91aa ("vdpa: factor out vhost_vdpa_pa_map() and
> vhost_vdpa_pa_unmap()")

weirdly wrapped. will likely break some tools.

> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes in v3:
> - Add the Fixes tag.
> 
> Changes in v2:
> - Clarify that the overflow is on 32-bit systems.
> - Drop the unrelated memlock check change.
> 
>  drivers/vhost/vdpa.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ac55275fa..38b28ed3d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1102,6 +1102,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	unsigned int gup_flags = FOLL_LONGTERM;
>  	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
>  	unsigned long lock_limit, sz2pin, nchunks, i;
> +	unsigned long page_offset;
>  	u64 start = iova;
>  	long pinned;
>  	int ret = 0;
> @@ -1114,7 +1115,13 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	if (perm & VHOST_ACCESS_WO)
>  		gup_flags |= FOLL_WRITE;
> 
> -	npages = PFN_UP(size + (iova & ~PAGE_MASK));
> +	page_offset = iova & ~PAGE_MASK;
> +	if (size > ULONG_MAX - page_offset) {
> +		ret = -EINVAL;
> +		goto free;
> +	}
> +
> +	npages = PFN_UP(size + page_offset);
>  	if (!npages) {
>  		ret = -EINVAL;
>  		goto free;
> -- 
> 2.54.0


