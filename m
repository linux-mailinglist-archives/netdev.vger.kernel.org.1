Return-Path: <netdev+bounces-301784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g8L0KhBSPGppmggAu9opvQ
	(envelope-from <netdev+bounces-301784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:54:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A79E6C19EE
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:54:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=FRQ6UBDJ;
	dkim=pass header.d=redhat.com header.s=google header.b=l3GdObX1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301784-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301784-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B11FD300CDA5
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F75279DB6;
	Wed, 24 Jun 2026 21:54:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823E6322A
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 21:54:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338061; cv=none; b=CeP2WMbXVWflAcSWWA517IS+HDcy+xG19Jcuv0G6/4NKdz8L2Z0FX6QoYl/rFhrkf6RGw5+ACrqqFebj0pqONkgZF6A3D30KWc/6UNcFQtdcPL1yDCOvcFHcOtR2PB+V3l0H06yYWZr2Eaj8f1gzdIdjmC4wfHkQZJat9y96Xes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338061; c=relaxed/simple;
	bh=YEH0ivn6OIsDyjtX0rImX+2K0Q3ZGkW8hP4mvHsm9Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jm5+S9C7cPz+mvAQvV+2w89uHXzECLoX6tmW16nvyQiU/9ClswaO0EBOrwc4PV5O5KltV6jyQC6eeFJR8hnwQWvtfADzLkkVvjnMpg++55jPkd6+krEjeSyg3l6+OOgX668wwYTAI9P9I4rbxAzDlYObnnKYhxBmGlWtm37KO7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRQ6UBDJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l3GdObX1; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782338059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BDvcN2LNdN+d8LE14HUcEEpxSiVmThGnJVY9yWwMAdc=;
	b=FRQ6UBDJye1UsaXQoZdBBv1Tj3gEI1GXvWtAFjvTq35RjnUCOGyRPmm9LfMYoj3q6LUMDa
	zjHYoCQC8NLcg3gWlaID/jUAyVfwMqRyA602HBhSq7iDmCWHekc1vTktHOMkE+UPxnYbCy
	paDWkf4Nu0fg4Hx1sfwem0ck4QX3iV8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-4utwDeNRP5SQfI6VsgiJ_g-1; Wed, 24 Jun 2026 17:54:18 -0400
X-MC-Unique: 4utwDeNRP5SQfI6VsgiJ_g-1
X-Mimecast-MFC-AGG-ID: 4utwDeNRP5SQfI6VsgiJ_g_1782338057
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-492488f8583so14371065e9.2
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 14:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782338057; x=1782942857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BDvcN2LNdN+d8LE14HUcEEpxSiVmThGnJVY9yWwMAdc=;
        b=l3GdObX1EoUvKKOs4VWNHMbRfzft0eV/O+13SRmEQ1UA9hWg+G0WUScPOtLbhJczef
         z+kXkHDFROjMZcatGd/skN9y5ztfJ5a3x4OtNoPHnpwr/yc//QUzLQgP/M46hkpYgkN0
         fj1Ui0MaLep3jsDkffnwbfSnOs6Xz/7Bnr4ddT7HZPBYGtF+MIsGUvDY+ZVnN9d7+tSU
         v6Ct6s6MHylyXXzmj5Meg9csElVc34ZIQaZF8GGud1UbLFLq7156s9FsVIQEARv1HFGp
         hwZ6MeBk8ZW62J/kid/KF2+/jNCTvHlU9RjBGn0JIA5shgkIHRFMiGAH7h9B4JWDzmIF
         eYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338057; x=1782942857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDvcN2LNdN+d8LE14HUcEEpxSiVmThGnJVY9yWwMAdc=;
        b=DY3aXVDOYNanwBrUEAoAVewsDTS6+rHQmAZWgEdaeQkBoqCyTd+M70VA5lSeOOC9Py
         M6uN1IXbIjrcXjeB1ry4dlMLH2FX4W7X2BuyGjN+o7uDyuJHHTTglgNbml1AxRs059It
         /o31FyFbYPY4gb7y3U6bPd9JPICGEleCv0yDgDbnCGwYBZmVhF0Rgew6R6su51X0M4KH
         m6m8AEncd1AdbwQR4O21JLNmaxUrXOWUa46diLQz/InuvUhCCB2OWz3wsogx7Id29P53
         eUP6peiSyuC0akZCl4dwHz8VnBATq+UFbYDX25F1jSLVzdClSDWVwOZIkvgTT0nr1FKm
         zVuA==
X-Forwarded-Encrypted: i=1; AFNElJ/gmvvnunnST4w0m5FjJHCxUpdS32Ki6GTCM7tJ2DHbEKVd9zs/MDUVJNfKPg0U3ogn3DRez84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzadii1uHQKNPDWldMiD1l9vkq9ldD8FhZYNSvDnsnjKcIVycae
	Sdbrrmzp2/fR0nJxe3UPnKrLBkhN3tVukcXE3iE1YeBaVjBrvwdonz9/7tAxvqP9Sfm+wFEvxC/
	yNOnKiVjPmc6RgLFdi5ZnKdbTxi9qFz7fKBHDfMFvYlUeh/uHdJNEEJ2DAw==
X-Gm-Gg: AfdE7cnYoPemwJyoA9Xn7R9WhQjcerBk8WTZ2NzC8GxtOCqIfHHtIcm7LCRCkXv0zRO
	ViNAJjKrvhc2UIEW/NPgG15v9GgV2nFwAhVf2P1eCJvSwgcc7qUEzVUTbdW+Bgx877wvWM4biRk
	Hqy++M8g3yw0zvMnBRGnWTA+kdpLsPTnXFDhIjyO7SgoxBlEJaTnbEaBPrOhyLVB75Y2jHcgnDL
	WpZEgjM4OreSWuxYNyxzYwlonzY2BkHxV0pGdqOtchVe4PACSXURsxAl8tF3KkeMDmoHWUEDkN5
	bfb6Pu5/i9HnNhFfocHECpP1FgppzEPxlo37VShs7QnNBhNSDrnijl0wvSQPbNLWKcJFNc3kzdN
	3y8X5nmWgm8XtPaUx4uZQmp7MPbi+Xy/O
X-Received: by 2002:a05:600c:c118:b0:492:63ff:d577 with SMTP id 5b1f17b1804b1-49263ffd59bmr15123335e9.27.1782338057084;
        Wed, 24 Jun 2026 14:54:17 -0700 (PDT)
X-Received: by 2002:a05:600c:c118:b0:492:63ff:d577 with SMTP id 5b1f17b1804b1-49263ffd59bmr15123165e9.27.1782338056620;
        Wed, 24 Jun 2026 14:54:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d93d8sm17353516f8f.23.2026.06.24.14.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:54:15 -0700 (PDT)
Date: Wed, 24 Jun 2026 17:54:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vhost/vdpa: reject overflowing PA map page counts on
 32-bit
Message-ID: <20260624175356-mutt-send-email-mst@kernel.org>
References: <CAMuQ4bURwyoJtKUskzXpbUtrxXT1vBZZxpKpnnJY6qWsLtTBMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuQ4bURwyoJtKUskzXpbUtrxXT1vBZZxpKpnnJY6qWsLtTBMA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301784-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A79E6C19EE

On Wed, Jun 24, 2026 at 02:51:53PM -0700, Yousef Alhouseen wrote:
> vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
> size before computing the number of pages to pin. On 32-bit systems,
> where unsigned long is narrower than u64, that addition can overflow and
> the code can pin and map fewer pages than the requested IOTLB range.
> 
> Reject sizes that overflow the unsigned long page-count calculation.
> 


And a Fixes: tag, please.

> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
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


