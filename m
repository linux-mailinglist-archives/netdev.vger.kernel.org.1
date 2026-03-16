Return-Path: <netdev+bounces-268136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI9nGHXyt2mfXQEAu9opvQ
	(envelope-from <netdev+bounces-268136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:07:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF65E29925F
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60F42300576C
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94343939AB;
	Mon, 16 Mar 2026 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6qk/CCO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="se7ezDlR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF3F3909A0
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773662691; cv=none; b=IGlDGolDtt3H/OTy07WwueMwOJhunkyHHZ81k+OflVygCXAsWQ9YHol3aPUIwzNCSDBvAd9CaVwaoOc0Fe58hWteHxsI1a+4aUReVU+GoGo8QIWR/Jxq0LAQVayEQKxk3O7yfe9DZ3HOhfD/Ymtu/42LClhcO9Cy7UKKPx7SfIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773662691; c=relaxed/simple;
	bh=CN3BB8jMqtpHX9v247an8eQx/ZrNnfSh/VbSD9NzPqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqpSG6PUrXBn8A8ZRt3rVkLEtvVD4bhf9yqMq2/vUr4BPBSesKAEas6Ot5T7ZNGNwPE8UqErYAsP2/1osLyhucND7b3mfkLvpAAt5plv9OX1HgLOHADbvGJlgFE3eZ16QM28xIt8ir5e0MLasD/mLiuoJpeohoZNZ0ENnvr79Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6qk/CCO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=se7ezDlR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773662689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1ThxgnukPZdnVsAXkBiIHRauBYKnXhO8ujaThY4wrs=;
	b=B6qk/CCOIDDu4d5C2GaX7UJl2f6iHespLdxQx8qAMfnYPIBR3gOmHIF20o64nh9t27Hx+y
	hXbgyrO5CN80v6ZPTLQ03FO1qRn2FkRC+pmG3UzRotTzsWwTHptYjuk/iASyqep6E9G5nY
	fhME/5CpAoHS6Fkv8pFGdNshpqMfwsc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-Og2Ndrv6ODeYtTSZvmza9g-1; Mon, 16 Mar 2026 08:04:48 -0400
X-MC-Unique: Og2Ndrv6ODeYtTSZvmza9g-1
X-Mimecast-MFC-AGG-ID: Og2Ndrv6ODeYtTSZvmza9g_1773662687
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b4454b459so498948f8f.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 05:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773662687; x=1774267487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T1ThxgnukPZdnVsAXkBiIHRauBYKnXhO8ujaThY4wrs=;
        b=se7ezDlRaUu4aJvrOrGEQkKwfWQSAZNbKwnjEXPDfNjBEjK3Chm5gLzEIdw7ttUecR
         JS3g5mDgA+XApXfR4Xr0pcB2HeCUNch32EXvSeyzIfGuo5dCAoazC1uPm8FzmjXH0tyK
         s2LhJ0yhfUixMgkw1FDM+paag6aTSOmcpeoqybVVm7lZUgbhVFVyt7P/5ub8zVNU57md
         w6g7zqES2nN3V/VoKZ4V+wEIJOCW8QYD/sa+aMXKjHnIEBcJAui46QA7k8dVTWpGEGgL
         AdGwQjAiDQeeJbgu3tWW/jyX7XSAiXUxLPiCGDwKspPF2ID9ppKColFVGCcYqwKYNDqQ
         9UyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773662687; x=1774267487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1ThxgnukPZdnVsAXkBiIHRauBYKnXhO8ujaThY4wrs=;
        b=RLbPOylkn74kk4NzAu6WwDirhY4IrnWOx+dHtPuRGCZt7nbI7f9DGhvlrYZ3CgtEQ+
         KFUeP2YEbN/09HDH4El07Hjbu3M03G+oDI6rplR2djjvg13gzKQde3yTKqbAqDI5ShgT
         MtJRMMYTSdJj2USetwlxfQD1730W4I6hDHtNE9uW6FQv+/azm6QUK2+l1peoUbCsb7ep
         eplVwzkgyIzbmBbtKB0BnO2Src+XXYS5WNdh99+7LSOnX2/tzz5DGWzxH+dyyOY1kWRb
         QGicnHAw3sOtf6Paa+pPsKmCx+n48yke3xHPLQHIje0VnRXrjwNtTQuQdefFyPy0TTkO
         P3tQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1cNc0bW+kcbau+Q7cms5KAkeT73iqmJ91O1otA0IXFeGor94Mt9G1i+41Y4QOlAljE8J6fZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNusBriQBzzgz2kW7fGnFmgxdFcwWCKbT7dIHrfXK2/QtT4ZHV
	jGSx9sJb8Mnuu/43KoA/B+j6GtgsmMdkQOGnyIklJyjdDLwbV9plVVluKE5WDVp0iUEEQqKuvVQ
	7bmkK7CDChGnZFeR3fxYoKoAkNcdDfQCrVU9ai0y8PlvGlZZT8DOK9Gm4MA==
X-Gm-Gg: ATEYQzwE5u4s3Qn2XZrvAe837CEbm/ZbCxo8la710tg75h6LAJbEzIQhR0SOBuMILus
	1cDszQSK+Qa/WAuOiOTgB7ncu+vyQnVr68VIg+DI0SWPXBBjZuAcZE0JRNPmQ9VsS2XBSF9vbzc
	6JbDZWIiGjdv0gw0xJhSGYowL5i1DPGsYuYN9GSHIjiXGYJqsgSgN2PaFC43h+U4MgDkfB1PkhV
	+vxokf+uXxug1qFzVIvt5kSndjSjuWkTmZ9h94K198jlgz4Vz16wLm1yv0/SAWz7IU2xD4Z5Z/8
	Jd7V2r7//FYL8aVCYGcy39BpB/HXKNf8pSmYfoXfoSYg5miqLqujGzPEPYcFB/+JqSLYLsox/9F
	NHQN1cUgjprKo/ixXky1W5lBWssIXveYEdxVDkR6d7LY+JA==
X-Received: by 2002:a05:6000:2383:b0:43b:41b5:e02e with SMTP id ffacd0b85a97d-43b41b5e19emr8017946f8f.4.1773662687006;
        Mon, 16 Mar 2026 05:04:47 -0700 (PDT)
X-Received: by 2002:a05:6000:2383:b0:43b:41b5:e02e with SMTP id ffacd0b85a97d-43b41b5e19emr8017848f8f.4.1773662686464;
        Mon, 16 Mar 2026 05:04:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b45e5c233sm6464487f8f.33.2026.03.16.05.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 05:04:45 -0700 (PDT)
Date: Mon, 16 Mar 2026 08:04:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for
 buffer allocation
Message-ID: <20260316080419-mutt-send-email-mst@kernel.org>
References: <20260310183107.2822016-1-vishs@meta.com>
 <20260316054232-mutt-send-email-mst@kernel.org>
 <20260316064256-mutt-send-email-mst@kernel.org>
 <6d43dbbb-7d04-4442-8743-3963b61195cd@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d43dbbb-7d04-4442-8743-3963b61195cd@meta.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268136-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF65E29925F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 05:27:57PM +0530, Vishwanath Seshagiri wrote:
> On 3/16/26 4:13 PM, Michael S. Tsirkin wrote:
> > On Mon, Mar 16, 2026 at 05:56:20AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Mar 10, 2026 at 11:31:04AM -0700, Vishwanath Seshagiri wrote:
> > > > @@ -5857,7 +5863,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
> > > >   	/* In big_packets mode, xdp cannot work, so there is no need to
> > > >   	 * initialize xsk of rq.
> > > >   	 */
> > > > -	if (vi->big_packets && !vi->mergeable_rx_bufs)
> > > > +	if (!vi->rq[qid].page_pool)
> > > >   		return -ENOENT;
> > > >   	if (qid >= vi->curr_queue_pairs)
> > > 
> > > 
> > > 
> > > It seems that a qid that exceeds curr_queue_pairs would previously get
> > > -EINVAL and now gets -ENOENT.
> > 
> > Or maybe this if (qid >= vi->curr_queue_pairs) is dead code?
> > I looked at it some more and I can't find a path where this
> > triggers.
> > 
> > > Maybe reorder the checks:
> > > 
> > >          if (qid >= vi->curr_queue_pairs)
> > >                  return -EINVAL;
> > > 
> > >          /* In big_packets mode, xdp cannot work, so there is no need to
> > >           * initialize xsk of rq.
> > >           */
> > >         if (!vi->rq[qid].page_pool)
> > >                 return -ENOENT;
> > > 
> > > 
> > > Alternatively I think we can completely drop this chunk: we already seem
> > > to init page_pull at all times except for big packets mode, so the
> > > current code is fine I think.
> 
> Yes, I agree qid >= curr_queue_pairs appears to be dead code.
> xsk_reg_pool_at_qid() in the XSK core already validates
> queue_id < max(real_num_rx_queues, real_num_tx_queues) before
> ndo_bpf is called, and real_num_rx_queues == curr_queue_pairs is an
> invariant in virtio_net. Both paths hold rtnl_lock so no race is
> possible. That said, I'll adopt your suggested reorder for v12 to ensure
> vi->rq[qid] isn't accessed before a bounds check, even if the check
> is currently redundant.

I think we can just take this as-is, and do more cleanups on top.
Acked-by: Michael S. Tsirkin <mst@redhat.com>


> > > 
> > > 
> > > -- 
> > > MST
> > 


