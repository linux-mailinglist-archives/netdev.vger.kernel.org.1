Return-Path: <netdev+bounces-241898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE4AC89C76
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 13:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 036964EC0A6
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ACD328611;
	Wed, 26 Nov 2025 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/6/I5MP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pgJy0UKa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F064327201
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160250; cv=none; b=hOgNi8o2FmFMI46yeH0KUjD2OVw7QJEqeCPi2R/x/ER+THHyDa3keKag86wzpnbZ+i2ucRcDHCfj8OXOjUnuJm8u0j4RQK9w8HMFv8QjZKsfB9f8dlQ+gr0iHxpbi6V+mNbrM2GNShKE6FJicm3jZzXusM3cAydFvHGq4uuJdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160250; c=relaxed/simple;
	bh=TgihVCzdHkhlFl7XJgdzny7+kp/vV44ySjol3tn7/k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbWsJHZTYzj9a33fA0jl0ke+nhmkULepxIj+/LpnMwKyWSIOPbkJhts2ciNzfbcYs0ksdlw0KF9QW6E3DscjagK/Ngl9T+YsWrQJK+MtphSEyM6vyuOPHZe+zFvRtkRK32NPwARnsL+dViBCpyZj6p5SbKWRtqyAS8EKNp99vpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/6/I5MP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pgJy0UKa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764160247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2M8hirVbY5OIpSvxcWUFbxShnVmyIWY2UihN4VUkME=;
	b=T/6/I5MPr5yLpAJdPGXt8IJfxs3G+uVDXAjdMJJDck4PSxxhnP0g6h+4c+ORmTFfQuzILk
	Ux8wcQJF93U6YlC3kvC7IvkjMBECYAtLLznDYsdvFMlTJ/kplxUftkaoAU7w1twXAy8nFe
	gHcz5V8+h1o+Lsp1WGIK6VMUcTUdRa0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-XOPquHZiOt-V3No3ALyYHg-1; Wed, 26 Nov 2025 07:30:45 -0500
X-MC-Unique: XOPquHZiOt-V3No3ALyYHg-1
X-Mimecast-MFC-AGG-ID: XOPquHZiOt-V3No3ALyYHg_1764160245
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429cce847c4so4407417f8f.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 04:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764160244; x=1764765044; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N2M8hirVbY5OIpSvxcWUFbxShnVmyIWY2UihN4VUkME=;
        b=pgJy0UKa4eD5QF7aD4rG1yHFLARTTG3hANwBvlfhgrLY2AU7fR9FR36jDVpUFS97Xv
         w9yG/q+ntxIePoPOPvVP5l2lq1buk2/Q6m3YNN08zeNL/ESU4l4BKGT0eWhUtPLyk/0f
         4WpzMUWcQDY9t+7oiBDstpl6MBPHE8sfqtyLmc4f5WLOTf58H/VRysvsMaAWDO6FqwJY
         GrwCgGK0FlGPPXtdZTr7bAU2s4i8FMwnsuZUf/oXkI+kQBGuiVBlJuRlGl0/cjeYxYxD
         YNvWm6nwgNVeGzQF4lnuk0dT40vMq52R04SF1HQ7BRrSLVpwkOdne5YvZQ+lU4E+KW8a
         uk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764160244; x=1764765044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2M8hirVbY5OIpSvxcWUFbxShnVmyIWY2UihN4VUkME=;
        b=qvy4T37zL4R64Kc02wd7kEzuiMPDHqvHQHkB4lLiN0VdXd8w1PE6o8CoJRVmw9f71a
         f5DLBY92q7Z+r3654B3FxvE2I+JptzfxMIqW6DxCF4ln196q2jzAEE8zXe//Y8hltF0U
         zQpH33mfe8jQcHbqIHRdAzVzbJ1kpcLZwY0nF36P1W17Zf4tEwtTOm7Nnz+dzUiZNeV0
         98IeGvht08E7A17yuDX9P+uyUQ9DHxiUz8KHY3g5f3yPKWdhPLi6h5pfRDCatOupswjb
         fial/uGLBZVHvzQEGCzfOZviz842gfHD0iMLScXzwL4csAoCfq6nP0qh+IQklL/4zcW3
         vIOw==
X-Forwarded-Encrypted: i=1; AJvYcCWpqeS31NmI73ks4qeGDSUQtMoeWVL8x+Ow1wjhGmak6CAExz2bMU9bQaa4s63NNSyL8WbiV2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDv4AD8mb56Pr5JwWSGPckb1SPBjE9lGnf0zJirDPKLT8hKJcH
	e3hhA2dVcsTmbwurjPwMoFlCaZro2SlvMIfcWCRT+kHPmVun8K1sKm5tuhyPAv5AjsWuhFpiUr1
	S82VfcxzDdGBEIZ51ALqcqQjgKV5dIlDQQqszZuEZHh3tmV33wu6iLnACB1dCJz1/wA==
X-Gm-Gg: ASbGncs3A5gTIvcH1HxFk1Xv3devvbOB6vUR4dYl8Xd+b5EhgK64qfEA/LyDBRDvF9e
	oYRfVg2Ad6Tqxy0A/AFrSpp7J9X+7djb2G48snvnLLkr3f88r1Y+90rWJ1DLZ9oWs2hkzM1VqaK
	rIRQOs+sf2bQTVBjZowwXvpjGsZYPu5d7Dd7oTNoQ2zaf6KjjXyei6kc+Uo/YhscP7wdARbJd8s
	vjZbm+HpICPauXSTuQaIdunVkCeM7Sfen+igjhfHN1ufh3EIqTFegxgjSdgQpx0vVSbpgxHJXFL
	ndeAU6sAyadU+Z9kbtGdSFYchoMOZpj0+oX6k7rqc0ZYp68gJp7m+zO5v9kauJEDNehlvPDIf9E
	MDMboqn2JeJPuOltwmJYtTqIZN06YRw==
X-Received: by 2002:a05:600c:450f:b0:46d:ba6d:65bb with SMTP id 5b1f17b1804b1-477c01eb9bdmr217492525e9.31.1764160244375;
        Wed, 26 Nov 2025 04:30:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzDOShduGdp9zc8mysLjLBhEjKzKDO88zCdk+Rqo9ljArnPM2e+3HscrIdh+6qslIZbPmv4Q==
X-Received: by 2002:a05:600c:450f:b0:46d:ba6d:65bb with SMTP id 5b1f17b1804b1-477c01eb9bdmr217492125e9.31.1764160243786;
        Wed, 26 Nov 2025 04:30:43 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e556sm39990416f8f.5.2025.11.26.04.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 04:30:43 -0800 (PST)
Date: Wed, 26 Nov 2025 07:30:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jon Kohler <jon@nutanix.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] virtio-net: avoid unnecessary checksum
 calculation on guest RX
Message-ID: <20251126073008-mutt-send-email-mst@kernel.org>
References: <20251125175117.995179-1-jon@nutanix.com>
 <276828c5-72cb-4f5c-bc6f-7937aa6b6303@redhat.com>
 <3ED1B031-7C20-45F9-AB47-8FCDB68B448E@nutanix.com>
 <abb04d29-1cd8-4bff-879d-116798487263@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abb04d29-1cd8-4bff-879d-116798487263@redhat.com>

On Wed, Nov 26, 2025 at 12:16:56PM +0100, Paolo Abeni wrote:
> On 11/25/25 9:00 PM, Jon Kohler wrote:
> >> On Nov 25, 2025, at 12:57 PM, Paolo Abeni <pabeni@redhat.com> wrote:
> >>
> >> CC netdev
> > 
> > Thats odd, I used git send-email --to-cmd='./scripts/get_maintainer.pl,
> > but it looks like in MAINTAINERS, that only would have hit
> > VIRTIO CORE AND NET DRIVERS, 
> 
> ?!? not here:
> 
> ./scripts/get_maintainer.pl drivers/net/virtio_net.c

yes but not include/linux/virtio_net.h


> "Michael S. Tsirkin" <mst@redhat.com> (maintainer:VIRTIO CORE AND NET
> DRIVERS)
> Jason Wang <jasowang@redhat.com> (maintainer:VIRTIO CORE AND NET DRIVERS)
> Xuan Zhuo <xuanzhuo@linux.alibaba.com> (reviewer:VIRTIO CORE AND NET
> DRIVERS)
> "Eugenio Pérez" <eperezma@redhat.com> (reviewer:VIRTIO CORE AND NET DRIVERS)
> Andrew Lunn <andrew+netdev@lunn.ch> (maintainer:NETWORKING DRIVERS)
> "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
> Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
> Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
> Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
> virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS)
> netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
> linux-kernel@vger.kernel.org (open list)
> 
> The "NETWORKING DRIVER" entry should catch even virtio_net. Something
> odd in your setup?!?
> 
> BTW, this is a bit too late, but you should wait at least 24h before
> reposting on netdev:
> 
> https://elixir.bootlin.com/linux/v6.17.9/source/Documentation/process/maintainer-netdev.rst#L422
> 
> /P


