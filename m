Return-Path: <netdev+bounces-226873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54049BA5BC7
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 11:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FEA54C3DCC
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 09:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23CE2D5A13;
	Sat, 27 Sep 2025 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dR6c4Dau"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146982D24B8
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758963745; cv=none; b=PHTOCOj0lREhk1xiK5D6L85ud6KS//lVfbr/4/DT9DoEJUsHNRQqUn7+0PXe8wZO9WXTy8qeAyx5InmFtZw6Yif/Vgp17g/t0Y1NE/0GorqKpf76OB8e29nwxaadavXMpapcrFUT86adPCY6B016QYwyi9J5b8xm0DMG1bdMpl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758963745; c=relaxed/simple;
	bh=0cVnGuREPBEousW3ICfS8xU9h5IzQoRJffkth/1/cRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeoL7JiHhBDslPpGGe06vS8tcgS4rzy21/DuZ4GCber3Rgrc7cLSkVi3aP0nYN6L3dAFePZ7QOX0gHVQE/GySEMKkG8K+tC7tM3HunvO2jdU+eHds3AZBy/basgoL1Ognmhvn6zfg9kzAg5zqGQGdbFoX5Gbxurrk/qYpt7FbWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dR6c4Dau; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758963742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Q29ePBvNLNX3RyQTzBYKbm0zTToczl37eoxUDzMUR8=;
	b=dR6c4DauYCoUh3p6SKzVoYaGHLnp/dZBcb1kyI1u0QklTxVc919V3YIyRcldceEnvdA+6b
	qhLiy9BSOPAPCuqgVY4VgTfa9JlYmOtgCRNlQydC5O3IZHf12oA66yxWmnFKOdJKfO7Zor
	ShVC/Bl3z1VByPlCokxyN2ourFqNcDk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-q-khmG-MO-qNLL0onkt_6w-1; Sat, 27 Sep 2025 05:02:20 -0400
X-MC-Unique: q-khmG-MO-qNLL0onkt_6w-1
X-Mimecast-MFC-AGG-ID: q-khmG-MO-qNLL0onkt_6w_1758963739
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f44000639fso2204401f8f.0
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 02:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758963739; x=1759568539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Q29ePBvNLNX3RyQTzBYKbm0zTToczl37eoxUDzMUR8=;
        b=bzmlqcfQCFAouuUY09rmYqoPnwFfOnWabTw2IPtDCZJPnlMyReD/W2/6ML0Zk9+k04
         1wn9vw0RJJNwIkbaP3P2X4wzg4roQnLgtMrtBVdd2+s9OPUXZR/SDexiCGCzicw85+Q/
         7S92oBwGhP5JB4bP2Aav5FCO4EJAq1vz/3j+IaUa3ZEOhXhYUuaf5ybvBP6SMPNFbiUn
         mL5+5HueG9AQVnIzHLvHiDWqj+zY3bKjd7/SzJdQRaCU3PrfEyvUZKptHL87cr89sE6B
         mHyRNz+q+vvGxh2aTHnc4wApisH6rSAayB1Iu+640QTjxuCciU7Mf9wBp7GVxg8I5ZNj
         IEnw==
X-Gm-Message-State: AOJu0Yy7QTr4UdkKHe2OvdHw9he5Pt1/Zpm8cSdnxcyf3jV+2UVY5y1+
	m4KJ7Ric59eRxo6A+kfDgvAro6suww6q2Kazd9NQXEvs+VQyIO+LAUHxOYkUwmdI1TAZwIt1DMv
	Grym3BMzi7sAlN/TXvdVRVnwcYuYgzSZ042RMJjwGzVkdRZawlnpm4/8icg==
X-Gm-Gg: ASbGncvYKjIbq0u6zgOHNw0ZPo30dEgAEwYGQoWnMPDBhwjH0B4Svkub6s+/yOTNxPE
	h4D9/JA7pc6Z13UZuhvf0CWTeUsFpVbhp7bdI/bgzUmp/2hp4E6tU9sdHo6mjRAayT/sIITysbr
	HHBB4Cpd8W1MkssNYg+gHFIgE7AYwT3cHRTvyHqqD3jeuot9Rjw179UYFd2Ww4+/k/qjXysAXHi
	AVpnLUmnJ3b4z4aDjYG4e8/ETBu/dn8TP7WpqJFDKQIsvGO2B4NyTL9yr/SWcAyCo5ne0BddLJW
	c0GuF1Zp4qstDlC2kqIgaJW+DTHVqzXQ0oE=
X-Received: by 2002:a05:6000:25c3:b0:3e0:e23f:c6d9 with SMTP id ffacd0b85a97d-40e43b08a91mr8457939f8f.17.1758963739144;
        Sat, 27 Sep 2025 02:02:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzfwp51UeRct/ixNCdhk7ku6um/ThtAGSfqA38FUWoj7+zrfA6BL0jhAYPeE5wtPhNAuqm9w==
X-Received: by 2002:a05:6000:25c3:b0:3e0:e23f:c6d9 with SMTP id ffacd0b85a97d-40e43b08a91mr8457901f8f.17.1758963738703;
        Sat, 27 Sep 2025 02:02:18 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e42eee0b6sm36103265e9.10.2025.09.27.02.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 02:02:18 -0700 (PDT)
Date: Sat, 27 Sep 2025 05:02:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 04/11] virtio_net: Query and set flow filter
 caps
Message-ID: <20250927050033-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-5-danielj@nvidia.com>
 <20250925170004-mutt-send-email-mst@kernel.org>
 <3097d7ee-b2e7-4232-9a80-fd7f33bb9fe2@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3097d7ee-b2e7-4232-9a80-fd7f33bb9fe2@nvidia.com>

On Thu, Sep 25, 2025 at 09:12:48PM -0500, Dan Jurgens wrote:
> On 9/25/25 4:01 PM, Michael S. Tsirkin wrote:
> > On Tue, Sep 23, 2025 at 09:19:13AM -0500, Daniel Jurgens wrote:
> >> When probing a virtnet device, attempt to read the flow filter
> >> capabilities. In order to use the feature the caps must also
> >> be set. For now setting what was read is sufficient.
> >>
> >> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> >> Reviewed-by: Parav Pandit <parav@nvidia.com>
> >> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> 
> >> +	ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
> >> +	sel = &ff->ff_mask->selectors[0];
> >> +
> >> +	for (int i = 0; i < ff->ff_mask->count; i++) {
> > 
> > 
> > I do not think kernel style allows this int inside loop.
> > I think you need to declare it at the beginning of the block.
> > 
> 
> checkpatch didn't mind and there are many other instances where it's done.

That's because checkpatch is kernel-wide. But netdev has some special rules:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

says:

"... is discouraged. Similar guidance applies to declaring variables mid-function."




