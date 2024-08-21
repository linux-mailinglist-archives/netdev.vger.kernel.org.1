Return-Path: <netdev+bounces-120631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7F795A0DE
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0786B21F02
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5517945C0B;
	Wed, 21 Aug 2024 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPQ/8Lxs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EFF1E522
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252716; cv=none; b=Gek8Holl1g48DzzQK1JXm3Rqfu5Bs8ofEpLwxdhNzu4449T28V9aFaMMebaQuj0IUUYgk63j2t369VgIrIuxLZfmVWPH8+gTUqAJBO/YNWbYOHm7gYwoPDzx54eRM/NWYmSMFHjlj0JT8jGDDuem+6vdU2QTGi4snxu5sk/euKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252716; c=relaxed/simple;
	bh=ZV76DnlRgRuVCMPNFKzemZfCcklx29bWsEEtGUWse5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCR+i78bRsh1kxJ0BcUhH4VMgSumICgpI7YyPANjBN2yuLeKLI3xmwGLfWtyPxxnbFgrYlT75FU/QqTS+nD/FPPsviH+6RjDIV2eBK9p+IgnSaf+WvMMzT67zNZHYCm3uhMUfk1NIrQTP3RDTRhpC+eAwUijNhC0t+msSBbBE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPQ/8Lxs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724252713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mtPyNhdXIXz4+vJglLOBphOc3sqQoJSYIIHv/Qiktbs=;
	b=jPQ/8Lxslc6DjWAqchNr3vnG+EjgOtm0nuRoQTgC+m0hLJEdd0ljxAqVA8ezPLCJvq7fKT
	/zyp3WK6xa5acvKIiFEWHVL1MVg7SvPoaEhexg+gPBemg2Kkg0sezhwRfQv5PU74CRh7OL
	dTA8m9urjpKGwUsYNx9yrJKiYI7sWRw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-GstlJcAtPlCA8_ptxCf_fA-1; Wed, 21 Aug 2024 11:05:12 -0400
X-MC-Unique: GstlJcAtPlCA8_ptxCf_fA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52efd58cc5dso6877341e87.1
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 08:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724252711; x=1724857511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtPyNhdXIXz4+vJglLOBphOc3sqQoJSYIIHv/Qiktbs=;
        b=GEtDQpqEbh0Hg0i/oeIZ7m9FurU1LJo7CgCeJCfhtF9ybkmJbLTI9yLmxXfgEPKbIY
         TLxF5uCpoLR+bwuKsXKELZHhHmQDXsGyP+M98LVboHc5wUY6fH5eeRVGEmCpdTO8qf6z
         7S+zJPDd8IDj1isMPfasrwjzvnnlNzQ7nxkJxz+1x+9x9cbuzIHpsb5rN1rgm4ZWK8XW
         6P4dj/zzXMPRYz+TeWhHgq8iN12R8yicgR8X+1KXvhZWTnqN50Y8RgTV4+FuCRWYfefs
         fw0eXM3Vg6LtB3y5G3bOc2HyDNoQI4PWAOFRzObOi++kDFn6SvIE9yGobDRVpofmksQc
         DUuA==
X-Gm-Message-State: AOJu0Yy6DzFDM1/sdNPYBiQ+lwWZon42XcrXgbQJC1NMonlo+iqOk9PG
	UoWorbfODjud1vQquGgPYe22rkmua8KJVxUf7HO4wevbeZ8CxMrlioZweY0XyUW7ruoBVygHp8N
	rpNNxlbi2qNdZVNOvpZ3L2RtMWIJHnSl/XLH1gb15zQfWNKRPOcHsOQ==
X-Received: by 2002:a05:6512:3da8:b0:52c:cc2e:1c45 with SMTP id 2adb3069b0e04-53348550ff0mr1593656e87.15.1724252710974;
        Wed, 21 Aug 2024 08:05:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6O4yAiGQzDHr19kMW1ONwMm7G4w+8mhSrKkiGWmZtlL6oFvJTyJGuNvSyfSkYEw1bs9fvxw==
X-Received: by 2002:a05:6512:3da8:b0:52c:cc2e:1c45 with SMTP id 2adb3069b0e04-53348550ff0mr1593598e87.15.1724252709931;
        Wed, 21 Aug 2024 08:05:09 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abed912c2sm28426245e9.5.2024.08.21.08.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 08:05:09 -0700 (PDT)
Date: Wed, 21 Aug 2024 17:05:07 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 06/12] ipv4: ipmr: Unmask upper DSCP bits in
 ipmr_rt_fib_lookup()
Message-ID: <ZsYCIwtVxvRhzJs/@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-7-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-7-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:45PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ipmr_fib_lookup() so that in the
> future it could perform the FIB lookup according to the full DSCP value.
> 
> Note that ipmr_fib_lookup() performs a FIB rule lookup (returning the
> relevant routing table) and that IPv4 multicast FIB rules do not support
> matching on TOS / DSCP. However, it is still worth unmasking the upper
> DSCP bits in case support for DSCP matching is ever added.

Indeed,

Reviewed-by: Guillaume Nault <gnault@redhat.com>


