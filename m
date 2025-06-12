Return-Path: <netdev+bounces-196822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F68AD680F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07ED71BC0887
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 06:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984911F3BA4;
	Thu, 12 Jun 2025 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avg0BXW1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5F31F0E39
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749710039; cv=none; b=Xi6+AOa4sqtsi16o4O1ins38WA7B8eKA4mYqoVGvTkyabuPjzM82Dvq4kHfFgemybPYboR0591AjTuRrNrDZ8H2858TgGol01RdqYlCufPltf/6SMXmzkLBY9ZU3SaCFZj70speC3k5oKEh5p0FxL4HF6ORnvLqrFP0cycbEeKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749710039; c=relaxed/simple;
	bh=0RFsYK4/bVTOu8PeXbzz5JHWzOqZR66/rgr6E+bl00g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIoZ01UYLhMBN32nKITJBiS0+NRpno4tCJcZtjFVaFtvgZzwDQKFneNIFIJ2OT5pSbOASJCnDe/1dKiwS/7Sty3/UQUjtvM5FgTSBiJcdQLW5cO6a5zphtfaOmuheTIEc57KBcL1sTuL7FGsQx3C6lzA5su40f9EUN9MafDSF38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avg0BXW1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749710036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nm9TV6R7Y41QOfPJ6MP5oIIesRRVBP6gVfG7mX/j6mc=;
	b=avg0BXW1Wj8YIj1/GYcqQiMPFmU0kil0TwY8JNZINeE8zdqJ2pGe3w6bKGFNYYs8VOD6S4
	lPp4+Ap7wr3/KydRxE9fUNmSJ8rG0qfMWXtcRdEEVtpSA5C2ZOPk/84Li8NsiaaC4z7r09
	tc+WqfSpF19sDren8aqyT31QXDInrCA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-vzX9WlngPFWxLBuMBW1OVg-1; Thu, 12 Jun 2025 02:33:54 -0400
X-MC-Unique: vzX9WlngPFWxLBuMBW1OVg-1
X-Mimecast-MFC-AGG-ID: vzX9WlngPFWxLBuMBW1OVg_1749710033
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso2929985e9.0
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 23:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749710033; x=1750314833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nm9TV6R7Y41QOfPJ6MP5oIIesRRVBP6gVfG7mX/j6mc=;
        b=Td+I7TO/mf3SVvgtJKK3HIaBmQZPN3sdbrI2KKQH5iSbn3XoN0u9LuRGT/Eci/cp+x
         oYelsYVP0hIZ906/9gmmYxAVVVH7np2xHzpOmlh3id2YA1B6mJj4FblOC4v6gjzrT0wE
         UlZ8J80bk3C5D/WQbxKNB+aJF2wHIWy17vux90LAoHVjNBUxXhWNna3y3nyHN/1uTjFP
         YPGwsZgSl0Gm2ZjzFuv1rDWrECMtHN1psfGBYDcBAN2+NpuZmRzzFyR3uDzfl/QanCEC
         pfraVmvaAwbqeNJJGzsSN50N7rAk7NvI86c00j5cWjRM1GnvMYYMvCCuNZAmhadH1GpP
         HbjA==
X-Forwarded-Encrypted: i=1; AJvYcCWK1zoQ6UlJKv6wGRpkszyWxq88u3+oCi8PuCetpJKqRcuJXifUE30IqwUrBfFgEd0NKkDaKxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAgY3wuU1GxwZ3CIhQQ7L59cDEDq7y/JAulIy4a67HJ/fFnoFl
	xVfFXOcbTASMDdypjo3YiDccaeQXU04UuLzR+kC/cX9lXuTqQNo73L3G+F0yS+5Oj4is1v5SIv5
	GLTc6Dkr5ecejIFHRa9wL07Ab9Vh3kKhfcFVb2W1oDPBLdfUNwUGSxygCZw==
X-Gm-Gg: ASbGncu91dJqxTlYJk/vt0UJ1Q9TBwZK/2JiW2NtbLUjETE/7STCbRcsuNSz3sKOhFt
	WcmykUVvrZLnclz4sgDYP6ApFWy8FhCIxgMKHzJav7RxmXRpQmuVfXJDERyPdrXMu7djKbu3+mL
	OIB5H+DdAhn8JrwSBeFt4S50sFyPrIJsJLfdZjYZb1n25EmPq6jnIs7V+IFVHPMCV9VcNXynavj
	WKBly/r52yqqvT2lf2aJS0D4hsvde+xs4B/yz7SkRNSXuRc2vIOtJZ8sk9o9M30/Q/KMzz8COMs
	UnXJ2Fwsw+s/JvAW
X-Received: by 2002:a05:600c:c162:b0:43c:fffc:786c with SMTP id 5b1f17b1804b1-4532d2f7108mr14039425e9.19.1749710033344;
        Wed, 11 Jun 2025 23:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUPXH7B83FgsgIbWOCFa8wLAry7d4eNcJALWMalXCx0ZQ4ODVUAv9DRXGbLvxZDae4zuYiyw==
X-Received: by 2002:a05:600c:c162:b0:43c:fffc:786c with SMTP id 5b1f17b1804b1-4532d2f7108mr14039215e9.19.1749710032990;
        Wed, 11 Jun 2025 23:33:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4531fe8526bsm43377245e9.0.2025.06.11.23.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 23:33:51 -0700 (PDT)
Date: Thu, 12 Jun 2025 02:33:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: sgarzare@redhat.com, Oxffffaa@gmail.com, avkrasnov@salutedevices.com,
	davem@davemloft.net, edumazet@google.com, eperezma@redhat.com,
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, stefanha@redhat.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH net] vsock/virtio: fix `rx_bytes` accounting for stream
 sockets
Message-ID: <20250612023334-mutt-send-email-mst@kernel.org>
References: <20250521121705.196379-1-sgarzare@redhat.com>
 <20250612053201.959017-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612053201.959017-1-niuxuewei.nxw@antgroup.com>

On Thu, Jun 12, 2025 at 01:32:01PM +0800, Xuewei Niu wrote:
> No comments since last month.
> 
> The patch [1], which adds SIOCINQ ioctl support for vsock, depends on this
> patch. Could I get more eyes on this one?
> 
> [1]: https://lore.kernel.org/lkml/bbn4lvdwh42m2zvi3rdyws66y5ulew32rchtz3kxirqlllkr63@7toa4tcepax3/#t
> 
> Thanks,
> Xuewei

it's been in net for two weeks now, no?


