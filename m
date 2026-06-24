Return-Path: <netdev+bounces-301793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oyXCGO1VPGpsmwgAu9opvQ
	(envelope-from <netdev+bounces-301793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:10:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5206C1B12
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:10:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=eJj+dsGe;
	dkim=pass header.d=redhat.com header.s=google header.b=CDQYGdeo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301793-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301793-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47BEF3046E82
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 22:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F8F2F7EE3;
	Wed, 24 Jun 2026 22:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2105B288C30
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 22:10:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339033; cv=none; b=G0T8Ln9SLsRqmOOXfZ6EJ1Qlhcphs/enaAI49lxDRecFSmMJkbSb20KqD8Wt5bJhdrQvyK05SQ7Sab6JwoCsGr10tcwI+X2uQVNTCJL203jqhoLOy/nFLAD+JELwgAiZy5uPjaM9+Nhw2IWM2n6pY5KcrqLmHwaOkeyMzgQX3uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339033; c=relaxed/simple;
	bh=SctI5nL9w6nD1CkeTPygc0eg5Cq42shMYT/8E3NzTw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeQ7CCkGV6vd59e7JyDQLW2XyBEtgy8bjU4ZE7NjsvnV7w/lljZefArnQbOceIBU9TrguyOtz7/aFO6KJYw3DCy69P1NQXucQLtkc0o6SeOrVUagPny7VMjtk12P+CwFd/etO3l/8pEUuyNwz5sqB6UfjWWbg/G5NlcMNztx8rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJj+dsGe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDQYGdeo; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782339030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rLK07udfOGaPeFwrW6OYgWQxt14q957X4zDxurj3Eis=;
	b=eJj+dsGeZ4n/4+C8HMMbzG6z5mqxZbhACGe21nACm3qqMC92BikdcD2zoL6ujoy1h6pfRq
	xGQIrBiMxA1n+CqUEFB5l4y1b9vKCJwPpIpZ0r0hAN5NqCsrFQYC7Oa79TSYnbLIiUrlCi
	8Uz5OIRj6qv4CNuxjgNdMYnvwFwdBVE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-iKAOY7PFMgSWgbI67HIoUw-1; Wed, 24 Jun 2026 18:10:28 -0400
X-MC-Unique: iKAOY7PFMgSWgbI67HIoUw-1
X-Mimecast-MFC-AGG-ID: iKAOY7PFMgSWgbI67HIoUw_1782339027
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45f3d008865so259989f8f.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782339027; x=1782943827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rLK07udfOGaPeFwrW6OYgWQxt14q957X4zDxurj3Eis=;
        b=CDQYGdeolXbwC8tN8EF+YbxP5RCPddjmgJFYuMmNthUwOAMGTiXcX55MwPW7IheIcX
         w9MYGRENHhAE3IQUIiBaDKrOTStu1EjhTNxaoiNbmEaH1uzSh/KNXz2n5YKk7UTYfZME
         VbLb0YOXs1w1+Jqt8U4ZCQnClYc9cxyrrAFj4cIN7hu5iHL9Ffytl1R1kshonSGlR0Qb
         C7lKnswrmf/dwcQZz3LCYhJD+bLXTQzGlr1RQ0mOGVn8HUJk4KzRnTE7PaFnZlq0YYSg
         LHS7pCuKmrgUKHcdp7+pvhorMDlxz+e+znSNSI3rT3HsR4UI+Q8m219UnakFnOpnlId2
         prCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782339027; x=1782943827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLK07udfOGaPeFwrW6OYgWQxt14q957X4zDxurj3Eis=;
        b=hQrVA46tzjYXoWf9pknCItNoa2A15cicIXx3q7G/IRk6650MMxOJIv1vzPRJAC+p1r
         ePteBJrfeaoXjDQHbhiG+c46ZpkHIpeeI7CyNDzrwvRc81hV7B00C4tOL9DPktyoNBkO
         47OVXMCcajhr98QiqE8BChiKORo1Gz0zT9Wy+7ZzhO2curwE8iE4AL08XZgd4ha/cj55
         +0+RCj8qyTPxN1Wqte514+j4J+2uJfyZZNIohPZVIqsIscWcI7JoAnTWAvVhqHI6Ov98
         JHQEtUmeGKbjHJEkzHSJk7wcRXrK/98/rh4xZrpADmnC+0EOG+dvYR/2HBtduAMSkmlQ
         22Ug==
X-Forwarded-Encrypted: i=1; AHgh+Ro3bbYcCuJekACAEvIqRKRjFzlgV/6M/uzj2rwnstA2Pe5k2KyJzjfYYmpSqzBCeDo4g5UEk/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPiOfoGLM7mX15jcF3zuh0W0Y8sYbv0rZ32rhAKOVRKRd5o5O8
	+ojP+0uAx3ZpMAPQav1j7eQDZY5BLapBnJY85nGS0Kw3rLPfMv8EdHmmDR5LlbAiJ6r4sORSc60
	4+t8R0EnR41DutK2zYCs2k7R28lLo0NgGYDAtm/y8oxvo6Q3slBd4Q2oxGw==
X-Gm-Gg: AfdE7cmamRb6pxcE/L40m8MdXuvMfDUw2hM3Kpg2iBCUbw9hgSIYREwneAnxfA1tqoc
	L3xd6Aq4YUd0BlggmP8TvN5m/wnt+7GeHjX0Ex6mOdu4+ikRtUhO75LvrOEg4O09shaCL5purx2
	vLf+terOqKJe+oLS99D0poyyTZDIC1cf0+OGmISEmebHXAZW9qdWs6ml1EQpyMncanFUmjTcvFD
	ne8WGoJ5XOAaACpd7Td6nFx2joxwgLA+cKjZPYpgLNr0cLirW/e+GPnk8FQzAr8896BFvR+wdMT
	NRw3e1F9td9gFb+d0eZ1892K1GWiZROCZVepDh39le39Tz1arH3/JS4litvcg8q7WWw0YUwSKKa
	k/gZdmfxA2D+TZy1Kl/1s24NouPerw/yN
X-Received: by 2002:a05:6000:2887:b0:463:1d06:ab33 with SMTP id ffacd0b85a97d-46a80f5c6edmr17065685f8f.27.1782339027399;
        Wed, 24 Jun 2026 15:10:27 -0700 (PDT)
X-Received: by 2002:a05:6000:2887:b0:463:1d06:ab33 with SMTP id ffacd0b85a97d-46a80f5c6edmr17065639f8f.27.1782339026847;
        Wed, 24 Jun 2026 15:10:26 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c22c680fasm10122841f8f.34.2026.06.24.15.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 15:10:26 -0700 (PDT)
Date: Wed, 24 Jun 2026 18:10:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vhost/vdpa: reject overflowing PA map page counts on
 32-bit
Message-ID: <20260624181012-mutt-send-email-mst@kernel.org>
References: <CAMuQ4bX-iDvcUOPPY+NLz95tkRJYwWqvzAr=U48uNaub_HZLGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuQ4bX-iDvcUOPPY+NLz95tkRJYwWqvzAr=U48uNaub_HZLGw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301793-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF5206C1B12

On Wed, Jun 24, 2026 at 03:02:02PM -0700, Yousef Alhouseen wrote:
> vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
> size before computing the number of pages to pin. On 32-bit systems,
> where unsigned long is narrower than u64, that addition can overflow and
> the code can pin and map fewer pages than the requested IOTLB range.
> 
> Reject sizes that overflow the unsigned long page-count calculation.
> 
> Fixes: 22af48cf91aa ("vdpa: factor out vhost_vdpa_pa_map() and
> vhost_vdpa_pa_unmap()")

still 2 lines?

> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
> Changes in v4:
> - Keep the Fixes tag on one line.
> - Add Michael's Acked-by tag.
> 
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


