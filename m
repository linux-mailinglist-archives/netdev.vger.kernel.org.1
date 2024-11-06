Return-Path: <netdev+bounces-142244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E9C9BDF84
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 08:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE391F237A0
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 07:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDB61D079F;
	Wed,  6 Nov 2024 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZImp/SN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D031CCB2B
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 07:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878730; cv=none; b=Q2pBJXHkABxNopnexoHsmYQJ9Z89TXl/uE2ZSWMKikWFeT41t4ui23WBrUorIVD60J3yoUaAJoM7eK/DVzoaR834+sCy6xfXCRpx3M6LSGVoOJv0bokjO9j+HwFUcfzSpbiY/Nh8rvDNdL+TVB+2/zbK2GugQJXTyPMtp8irPsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878730; c=relaxed/simple;
	bh=jmzYajqzGnCHIswgRvH4vFvbIZh0jM098WbwOYZyUjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Je/R4PLjC1lzz4s8tnT4ZNRXb24BFuBFLImnnaQGZ01ZGLQX6DZjYUWaaCA4kVK/KlyStpZM6MzT7mRPhBmUyIJolDGeZZCHZUARS8xu6NQ73a09SiZ0Pp/OO7DAeiqpA/4Cq6KuO8PCQR2elDhlJ+mFJFfUhJiW9iDj64mQGGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZImp/SN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730878727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S1SjNuHqdKwYbOTS0VAZLoIA4ArI3wWYlQCLHNMfK6c=;
	b=CZImp/SNO9QlWvdwWC+w+QsN1zwj3owbNLLxkLWKmrkI98nZEvGDvGukInuBiWfK2ix21k
	Snhx5mxd4NmrVeJU23i6R/85dKJg9s2XvGkc+HJhmMyvsongxdgSheCiiK+g3op/2A2Amb
	JyQX7Hcg3vN6gOMfdxD3Yj8t0+YSjJU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-nbxJExERO7ywmlFB1TOEjQ-1; Wed, 06 Nov 2024 02:38:46 -0500
X-MC-Unique: nbxJExERO7ywmlFB1TOEjQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5016d21eso2993108f8f.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 23:38:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730878725; x=1731483525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1SjNuHqdKwYbOTS0VAZLoIA4ArI3wWYlQCLHNMfK6c=;
        b=NHk0DsMvjBIX8TgMWrjnBAFKUiQkn2CO0zuu045itviQ0pyd9PmD6HKaDQSrgSKkmA
         th0vK4r29SLeisEbrSloVHIpql9DnbRSOTAifuyXH4wwSLXxSamlB686lq2N9M+BB63r
         6QvtOpJ/SMlJFvGb9nKOcVeJ4I7oKwrxPHaLkbGhfaS8fRb9xumkRccBEtW0lHfXiqRO
         ZtHaV8WTCRxOytywA/v4xht1sAMxl0Ni5ABbCSIOf0hkIN1BRmQ80rs66lo2dIhc2WAc
         hHHg15M5/6XJOILH++OUHuziteMAWJrtLvU+uKxHK/pJ9Qo0kzu1UZ9gn8XRzrP6niWF
         g2Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXFi4DDBJhDXXyf4OOQnAcPhY4Viy8wAlrygRv7KZf6l81SsNlnQGDTSP22f7tBrO7ld17Zju8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtuuu2l5xM3pZfVQB7jGsq+j1LAS7tFNoxWgt+zXxa93qzxMiY
	mrPScl2TNMeqmoet/pVII4z1UuVnEjypdYHknCrJANJt0RfwWTs9pyADy5OZxTFN9J0ZRWKk1B1
	5UQhutqu/7v6dBbtylRfCJiIZCDLAGPOStuqG0FFuw0k4bS3AsNAxyQ==
X-Received: by 2002:a5d:4a11:0:b0:374:c92e:f6b1 with SMTP id ffacd0b85a97d-380611585f8mr27888375f8f.23.1730878724609;
        Tue, 05 Nov 2024 23:38:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmgzM/arur25sAUmIdHuEPwiRsmw/IhtglQbWAZMOkmhbFcCtsJAcCgXz/JPvXUfIrj4BoSQ==
X-Received: by 2002:a5d:4a11:0:b0:374:c92e:f6b1 with SMTP id ffacd0b85a97d-380611585f8mr27888362f8f.23.1730878724290;
        Tue, 05 Nov 2024 23:38:44 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7c08sm18317626f8f.17.2024.11.05.23.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:38:43 -0800 (PST)
Date: Wed, 6 Nov 2024 02:38:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v1 0/4] virtio_net: enable premapped mode by
 default
Message-ID: <20241106023803-mutt-send-email-mst@kernel.org>
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
 <20241104184641.525f8cdf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104184641.525f8cdf@kernel.org>

On Mon, Nov 04, 2024 at 06:46:41PM -0800, Jakub Kicinski wrote:
> On Tue, 29 Oct 2024 16:46:11 +0800 Xuan Zhuo wrote:
> > In the last linux version, we disabled this feature to fix the
> > regress[1].
> > 
> > The patch set is try to fix the problem and re-enable it.
> > 
> > More info: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> 
> Sorry to ping, Michael, Jason we're waiting to hear from you on 
> this one.

Can patch 1 be applied on net as well? Or I can take it through
my tree. It's a bugfix, just for an uncommon configuration.


