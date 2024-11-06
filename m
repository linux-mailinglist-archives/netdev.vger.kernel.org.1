Return-Path: <netdev+bounces-142249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FEA9BDFA0
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 08:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7432B1C20E09
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 07:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83611D043D;
	Wed,  6 Nov 2024 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+hJUMs0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489A7190470
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878959; cv=none; b=Nl7MnkI84t9CimqlmFpQYG847wVcfwBQo0BPQyhbyC8cpWbuRQCYDWe1TJtBBu4kQuA1YneHEw7ybQYZ/kJC3CEugTme7JhPZLjsH19vuhXZGE2CMXwfQOmuPmu78nOn/kL/uHz73HDVgJqrI1OSAPzRbxLTGoKZ2+Ll1Jh2jOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878959; c=relaxed/simple;
	bh=87naFhcpflzvVNi4oKK41OMWqAcB7NuYDDSruv3y9lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SikaDkVnBllH1SwVySjRknyUTws9/Tqef10v7UvSLBA8MkNtwFQfEGOPeOLPMkhyV7JAooNgKdn6WQfml1qyglZlxOxMGqLSylGyP3MZllpA/1Ol8zRUp4SqyMlHTr7VEhnq7+xWT0TY924TRd7B2YAyZlOFWKCLTudvOxeGmlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+hJUMs0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730878957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VWR9zcSGFhCX887b0B/GPsWncKD7+3L6Qhwgrepk+0M=;
	b=Y+hJUMs0/xVR377H1SWJapVAkNDqjYRutHl8a37QvpW+rKpB56Ca5VacJDOLIoeUF8kQ+4
	xJ+M8il/9Bm1bdgCUS7PIJPsBpDUjxyVJVdN3EzYmy3xFHfoqygVvLO5opEM3Ehx/Fhfhc
	8TdNc9QNerIH2U2BelTbGk/3cIp97xM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-Z-2QaSdUOEaI9LfuMWVkVw-1; Wed, 06 Nov 2024 02:42:36 -0500
X-MC-Unique: Z-2QaSdUOEaI9LfuMWVkVw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-381d0582ad3so3070968f8f.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 23:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730878955; x=1731483755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWR9zcSGFhCX887b0B/GPsWncKD7+3L6Qhwgrepk+0M=;
        b=gZALn3UIpG1nSzfBW1/i0PYw0tgvhm1wTOWGtnaeedlX7xBRD3MYM0PpSyKYRquRtD
         +sM105g+/MmzWkP8BD5K36L30MmsjnIQJM8gkbZDsQyKY6gv8e2h2dg0DeLzUu+Xj6OT
         K2eleYxZzf/sm/n4mpghVDnaqJKMlLIClFGypvZLF0daefXtsaLmc7UqUrCjL3bnaFva
         UFkA6VVuS6MVhxddeoEehJlFISvuxfscfAnpcUHbUiFzgO6z33kA55Asq2JHRJ0Nki5R
         hioXSSilXG1ggkUVzp8nLCirt9tci6YtjDMgD67DvG5LzhKwlNMU1tqbc/vM38n13ZGq
         rB7g==
X-Forwarded-Encrypted: i=1; AJvYcCVuWiA4ZDMsriuxjCuHxMf/XAiu5yMdIfl1w/SUbzZVzx62wr31rPeIC38+iKAoLTz1Viz5FMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaW+M2SCFIwrW4seY15HIXgR/B7RydrboTw8cOv/wGyB4DdXnQ
	QE4IXXcpY/+ImNh63Z2CLL8hxyWtExXpKdGGAEN4rfLUfCM+Rio6SVdFUit9cTKdB1KxG+b7n0i
	OuomGKSSNrUsR64pBLdBVEo2QekzFsCdKQAirz5g6refK9jCx8W8Mhw==
X-Received: by 2002:a05:6000:1885:b0:37d:332e:d6ab with SMTP id ffacd0b85a97d-381c7ac4120mr17584465f8f.43.1730878954814;
        Tue, 05 Nov 2024 23:42:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgNtqpF0tJni5pYGtoHDDU6pOi20AGMmYrQIEMtMqT7zuCSRaMIZpdZQj9fUZ5DU6Gb1R3xw==
X-Received: by 2002:a05:6000:1885:b0:37d:332e:d6ab with SMTP id ffacd0b85a97d-381c7ac4120mr17584441f8f.43.1730878954464;
        Tue, 05 Nov 2024 23:42:34 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d49dfsm18389413f8f.46.2024.11.05.23.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:42:33 -0800 (PST)
Date: Wed, 6 Nov 2024 02:42:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 02/13] virtio_ring: split: record extras for
 indirect buffers
Message-ID: <20241106024153-mutt-send-email-mst@kernel.org>
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
 <20241030082453.97310-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEtP7tdxxLOtDArNCqO5b=A=a7X2NimK8be2aWuaKG6Xfw@mail.gmail.com>
 <1730789499.0809722-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEt4HfEAyUGe8CL3eLJmbrcz9Uz1rhCo7_j4aShzLa4iEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEt4HfEAyUGe8CL3eLJmbrcz9Uz1rhCo7_j4aShzLa4iEQ@mail.gmail.com>

On Wed, Nov 06, 2024 at 09:44:39AM +0800, Jason Wang wrote:
> > > >         while (vq->split.vring.desc[i].flags & nextflag) {
> > > > -               vring_unmap_one_split(vq, i);
> > > > +               vring_unmap_one_split(vq, &extra[i]);
> > >
> > > Not sure if I've asked this before. But this part seems to deserve an
> > > independent fix for -stable.
> >
> > What fix?
> 
> I meant for hardening we need to check the flags stored in the extra
> instead of the descriptor itself as it could be mangled by the device.
> 
> Thanks

Good point. Jason, want to cook up a patch?

-- 
MST


