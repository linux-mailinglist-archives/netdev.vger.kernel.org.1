Return-Path: <netdev+bounces-86404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C992089EA5D
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 08:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2F81F226BA
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 06:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BB2200D9;
	Wed, 10 Apr 2024 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJLM5oMU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40223C129
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729364; cv=none; b=cPDjZlyigJu3AMlUucZzsaGIo6vmkhLS2evxPkSI0eUh2n7GXUNQk7dm8J8lDRyRMVyQL3oUpiMaD6Gv+3+L6P5hAyy0swCbsaK/3JeM6RodxGKJXszeg6eP2xWS/55BvLTaizlrSdPOUpjPXE4ey13Gf5EViuaZpRIe2/5WyMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729364; c=relaxed/simple;
	bh=pdL+Y7ykVNlw9tRl/D3HqOcFigRQwSpgo5w487bNlaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3ArSFbSvDfuEBNIpavl7gENUoBT3rfPrUkl61uriJEecKPQPEuwaLQZhjgpg4bMEyw+QFOwcr1j3D0ADhAoMGbkd/hPmNtJMdW8yglz4ecKVG1h2vgag7/AnFXokpdjknXkU7dTepyVzmavZiwEzXw4M3cMq1dvAvAb+BU9viA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJLM5oMU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712729362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdL+Y7ykVNlw9tRl/D3HqOcFigRQwSpgo5w487bNlaM=;
	b=dJLM5oMUkCUFDXCjCuTf0mWTjQtKFu7RP/kKUjRPDg663N2iWcRAU+dtW/9ZhvG0KCzhM8
	NCu5A9UmSmLRntS+XbFB1p5SD1TuMCZ71zSyzjENMay374dEpy7umMxNDgnPba3siRBmOJ
	fndvdRSZePfb4uN1YTIv55CpmQkSfUo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-SYbw_RvEO4K1jJFJEqQqwg-1; Wed, 10 Apr 2024 02:09:20 -0400
X-MC-Unique: SYbw_RvEO4K1jJFJEqQqwg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5dcbb769a71so5968573a12.3
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 23:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712729359; x=1713334159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdL+Y7ykVNlw9tRl/D3HqOcFigRQwSpgo5w487bNlaM=;
        b=bfskdo4+dwBvcM/AZGC3370guhQvREXtQEZeDluoW8PpJAEvEO2t65dr1QQiGtVhHt
         M5EFvfxKOFhxCWqYTWTHuZd+E1O2GUBnLns+VvZTxRRUAlMzfHw4UQ79Yi/weMCO+WqD
         IPX4ur9S7aZKAtMpV8OdpiWa3dtJbDbEYjGOblgg+hUa+avGLDusdIB2kw0KDFXtXiQL
         J5EAOA7+FTPxrQFhGBZZ39MWwZGlFTV+PD78LLko20TNWV6L7cJFijmMZKks4kcK1hzv
         JBixXLC9XOXFb6xwozzhHDA7OO3MoJu959TYYW1UWRyivvItYzyVAIp6eW5oMXHgee0S
         eNXA==
X-Gm-Message-State: AOJu0YylE5HHXW3t20QH2/uIvSqR1KXoeZWYlUkgFzck2qX6S/SIYH6M
	9CxeOrhcDFv+3nJp3fZsm4mcYvGpAgT549+O3uDqNqTnk9mCE8UuPR2ZxlQ641t762DbVYvIbRv
	1+eydoAbdECFIAy+QpDkuN6+3XMrt1T86IHSygoOwfW8agPyBfZ7sxGojgT/MPWkg05VhKJXQPe
	cOXkwbyTlQ3Hxelr7Et9EXLoH5EIdK
X-Received: by 2002:a05:6a21:1707:b0:1a7:af88:486 with SMTP id nv7-20020a056a21170700b001a7af880486mr1953119pzb.9.1712729359650;
        Tue, 09 Apr 2024 23:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExWA7dtfa6ijnoDUCu1UfmNatwKbyCe84k67lqsG0ruoxaZc3zh2CUgoM4nLptDf+SMRE8btzrFCMB+Gqw878=
X-Received: by 2002:a05:6a21:1707:b0:1a7:af88:486 with SMTP id
 nv7-20020a056a21170700b001a7af880486mr1953106pzb.9.1712729359357; Tue, 09 Apr
 2024 23:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com> <20240318110602.37166-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240318110602.37166-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Apr 2024 14:09:08 +0800
Message-ID: <CACGkMEsVeCS0ABNeDfSvRa0GVqFN9EhrB-47LJG0_NnsDN_mpg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/9] virtio_net: introduce device stats
 feature and structures
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The virtio-net device stats spec:
>
> https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd=
243291ab0064f82
>
> We introduce the relative feature and structures.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


