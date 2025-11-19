Return-Path: <netdev+bounces-239868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42781C6D51A
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 200B64FC097
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60F631ED89;
	Wed, 19 Nov 2025 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbvcAD14";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MizsWflJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3CA2EFD8C
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538929; cv=none; b=DA76RcTtrYMiLgK5RF45ZHBh2skw66zT/lgRs0i40/zGJf6M9reapJrCgKUkfCyRQGZB8UERZte04EhOADz/3nZ3bERejCqHmKXKwcqmUbaoPuLFxvhQzIBcjLD6QQmMXj1m2m1fEfM/4GSrhDHUDroFqwIe4tSGmmfY6dHpljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538929; c=relaxed/simple;
	bh=lgBjLI8m9ms1izIzzAa9bQR9euWWL9lpEKsMBynI9yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWRamDh2BQ1WZxbIQ1MFm++/oZNCwNeZ43TJMafBA3cjf5fNPGyOQFHCnzEdJn+Mk9uZ27ZDlVOtSVoUyv8fk4eVOIizzMsW+EZpJkzhbzEdrLsmNqsIIBESMqJZTGiHq1fl+FskqCigj9qRKlcuo9a/g4nWM6e90veRZyzbN8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbvcAD14; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MizsWflJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763538925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SR56Js+oycTgnA9YQo5Mfd0UB5A6sCWtJq2NsOrtgwg=;
	b=hbvcAD145eBB+XJZmDRGzI+ozgNgOIxfPxWQqnNw/g0/5upR+LVN4PNCxVXoFg47mMLPSS
	rlgKzx2wBZEUzo3V5ipMgu7zO6Wey1FeGj97+Srn6ciurBTIIOjlIG+gPvaGGME1IHPgkj
	r9bvg0uE5Nm5Ogl6rwJrl7jJ3xYl9Fg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-inhDDtHtMq6i76Zvb-7NHQ-1; Wed, 19 Nov 2025 02:55:23 -0500
X-MC-Unique: inhDDtHtMq6i76Zvb-7NHQ-1
X-Mimecast-MFC-AGG-ID: inhDDtHtMq6i76Zvb-7NHQ_1763538922
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b30184be7so1017291f8f.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763538922; x=1764143722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SR56Js+oycTgnA9YQo5Mfd0UB5A6sCWtJq2NsOrtgwg=;
        b=MizsWflJTojJQzDg5F6t4hBG7ka4lmEqQfVX2YATXOsoPwyEjSN/AAiRWKjHIfKzIU
         97Qw/6Mkq09iUSAG2G8lcNeI2rDuYVRV4A1WMuy0HbLYiAC3Or81HTRP0dxH8SNZwcQu
         iKk7VQAQIA3xfBLKC/emF1z+s3yC/XwgqeoQeWXn2YlphGBzUVzTcIvle9mLzopvpgsY
         rH8INomvENIQT4RK3RLzTQlLqL9scubQJLAYvWLeW71C5tjwgfKaoeXDk2T3R3eAhlvr
         jvfMTkfM06qqdZAzV+m89yEzP7YZuwvsKU2r5ut1DOdIejtX3eHWUVo7RfR63X0rp3m1
         eMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538922; x=1764143722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SR56Js+oycTgnA9YQo5Mfd0UB5A6sCWtJq2NsOrtgwg=;
        b=pMKSTnEtx7N60zy8CD9zkE4Uh7Om/pS3inz7vlszbpHpEeKPsmxpeUZEnfe/ubOUAT
         F/tFvOr2UQH+zmHmkTDI9fa7zzDo+Eu+1hL5orI/j4wgCEAlCwjAV/KgGDkMJD5JLGXV
         BEgZ1SAJslcAd/xtjOzbYoq0EXCofSoKrvUjtStyRNK61ff+/hs5XrCWIoJYlPBBdzas
         JCXw7QJZ/XxdrlUOP6Nsfxu6QCyDY9rtb3RE/H3OuXO4hDFpNf2Ws/oKdzjHfPrskbCE
         AiZqUFZ/5PXpHZNTOOQ1gZvMzmFC8Gl/QyHJjVAJSjNjolR+b2/mpZHvj9+kDZsSomhm
         uaAg==
X-Gm-Message-State: AOJu0YzB3VgLjX21bOiPx1sWBhRKAZx+47Q+4BwC2vIFZdVjcZJLokIx
	gBbFXN4inXXVyexqPDHG/k8OwFDRPwKTB8emZbVF1AnzX/TC8GCamFfNxO4UUmQHlpkayw4zuQh
	To5vBxRXBqo4iflko3VlF5hURE7QY2kyXRFJi4DiyKkVuzma6OyZHPeatUQ==
X-Gm-Gg: ASbGncv5R524BRYyPTdo4a+n6WHV+PSsPHH4vDrdtMHflafBkV7yjmnjPVQq+frepgK
	Pd8bI+oIX5h4NWJMINEvHGoHIEERTlv1K25Mt8WK0m+FvEaSu54pvyHPh7wzIqqBrTLC/dtphZJ
	BqTnZDi8pUV5tg1ACFnncrfDpmQr8m53dGjc4jx+BrwSClETZRanZMWtu6YtSLERufF7uwUWtVs
	VCyZQor4/6AmtbxAS2w01jJ5EkpygafwOEt/38S2ein1ULvG7UZgz6pAYWiIu9hbFeIfFtit3es
	qT+q5vcJnKFyV+Rx9DlH+soV1XJgxhejLlHJQKCd+5VgSeIJkuuduh+Lw9tebO78/k+urXAcyDd
	9gW6UKaovdbeAD58D5JU1QII1365Zsw==
X-Received: by 2002:a05:6000:2087:b0:42b:3ab7:b8b8 with SMTP id ffacd0b85a97d-42cb1f5d859mr1624236f8f.25.1763538922213;
        Tue, 18 Nov 2025 23:55:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAXZsZPpb6BnPnIDeZJ0idKcRG+zh5V+FkCL+0HBpxBjeSdEP6UJHLaM1iOkf6YKPLjuop1Q==
X-Received: by 2002:a05:6000:2087:b0:42b:3ab7:b8b8 with SMTP id ffacd0b85a97d-42cb1f5d859mr1624208f8f.25.1763538921625;
        Tue, 18 Nov 2025 23:55:21 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b62dsm36457979f8f.24.2025.11.18.23.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:55:21 -0800 (PST)
Date: Wed, 19 Nov 2025 02:55:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <20251119025445-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118143903.958844-6-danielj@nvidia.com>

On Tue, Nov 18, 2025 at 08:38:55AM -0600, Daniel Jurgens wrote:
> + * @selectors: array of supported selector descriptors

I would document their actual structure here.

> + */
> +struct virtio_net_ff_cap_mask_data {
> +	__u8 count;
> +	__u8 reserved[7];
> +	__u8 selectors[];
> +};


