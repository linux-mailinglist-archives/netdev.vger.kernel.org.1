Return-Path: <netdev+bounces-211691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C49B1B3D1
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 14:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD390188FD7F
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 12:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DFC271448;
	Tue,  5 Aug 2025 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRU/vd5N"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D30238177
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398340; cv=none; b=kqSKQ64y9Zunm4LAh5K1pmiOIB1Vdh53cX7KQa7qdelHG0Zjo7lCcDKmyLT1S3Ws8/+XSafng2NFzX5Bs3usOJ/vx07/drvoTmMWwGqM5YEIiTMj2AbRiMeuT96FRKw46mlhJOLnoVJuHFcbig+/v2UxE6CG0BE26tmXaUNGxRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398340; c=relaxed/simple;
	bh=Ogfilpy1+Aw2fyYDbAnv8ueBhzY263nV1cV6pqFK6YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhqWijjKQOiTaZJ3XH5YUD+DF2Imz9oYK8CTjFqctIyvKYkG8aHsX83EMgdxPDsLqWXs6QYHU/m6WU5G+GgDsZ9N0BDk8gIKQE0IL2eJPPXRysmmoYsGr5eSLAU5CZ7ZvUqVQs9Dz9utwhJffCux9+GLUJp3oFqC4grYqrzfyQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRU/vd5N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754398336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgB0AQxdVl7C2PQ18hWglhquCvWS8wfXLwal+sVZVI4=;
	b=BRU/vd5NApolZ688atsYj4lk4o8RY3ZUyjRslTOIRcr5MXk7MUJahX9tIpQ4D5IpIOv/80
	+rGZOO4oPiun70jvHZlmmzbfCqTmMxL1JlvuAFwOoaZpMv3++spu27l5Emd+Qpik+ek/IB
	4QQCT8Nxcjbc7DqtfvNyYewUVl/orAI=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-SKlO9zcaOeKfu1jFWQrH0A-1; Tue, 05 Aug 2025 08:52:15 -0400
X-MC-Unique: SKlO9zcaOeKfu1jFWQrH0A-1
X-Mimecast-MFC-AGG-ID: SKlO9zcaOeKfu1jFWQrH0A_1754398334
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-30b88ff732bso1007671fac.2
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 05:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754398334; x=1755003134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgB0AQxdVl7C2PQ18hWglhquCvWS8wfXLwal+sVZVI4=;
        b=BNNkKfJmhdHzLmQOBpOWzkOFmM4+yOT2fGw8N9OZucuJHVq2aYXumrluQ3n7wUS8H8
         eSRtiCqtmoZsmrGf1BBvEre24M3yuI4YIHeppCurFg3s6fKMGlrjlv5SRXJW/UBxV5qw
         BZYpPpY5e4WrBiwn9jeraPEOsoHdORiVWtUoABCpa/Hs3TN1URUhrSZa7p5DzdkgiWtL
         uK2Dd76g3ntwIYDJQVbYEdArcQKtccDFXqv3nMv5q5mVXixM5DOacw8TweRxp+G22hnj
         UFqXu3wUcXfM9awefqZOdiP01RMlhFWfgxVlZyoUow+zPqTCu9J2GTmU/uDBmRgOGplF
         TAlw==
X-Forwarded-Encrypted: i=1; AJvYcCXWBLwVe2I8y0K5fm7BP/eCH8qOFHyztoYeVrdCR5mQl71lYBMemKSFzyb5IqWotf3qCbtlnkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRDTLrCPRhXylf5dHdwxapVJ1FfA0SVg3YDrwOIcTlUAODI6h
	ZbUkIF+CHBAr9sb/m+LK6ccKoGThOlewh7aztT0HWTWkv2c/fADVtBVe4ch6fXJ9pcKXBoXSQ1d
	RXqwMFVTPpRWDLrUAyHJYbenwIiylYn6lFf323YEGwOlUm0oLB/4gVxXkiIiu6xiah81jg9U/Rz
	Wqd/jtOYy1V21pjQhnYRF1+EFuCMl2RlLo
X-Gm-Gg: ASbGncs+8nhmsF3GfQ8fM0RPdlDciSGs0XKiybHG/j4e2l6t+g8wWrVAEuDKn1y1geK
	5u3XcWFL2qFnT/egbGBHGBZ3fP4NDLAmFzXL/hIGlzGe/AzdKCGwjERsOLH9+TZyqxU8ynWf/Sv
	RTAcGYSVin7MZwiKzd1Ho8
X-Received: by 2002:a05:6871:9c20:b0:2ea:9827:84a8 with SMTP id 586e51a60fabf-30b67946621mr3175552fac.7.1754398334473;
        Tue, 05 Aug 2025 05:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHinHajgoHUmWGj94cAaH6a+7G7OE4HbqLOK7S+uUkO6MBS9l7AWmZGl1jdJNZFDhjpN4LGqm+iBpUkdsLIkyk=
X-Received: by 2002:a05:6871:9c20:b0:2ea:9827:84a8 with SMTP id
 586e51a60fabf-30b67946621mr3175542fac.7.1754398334152; Tue, 05 Aug 2025
 05:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801101338.72502-1-mschmidt@redhat.com> <20250804172055.0b865696@kernel.org>
In-Reply-To: <20250804172055.0b865696@kernel.org>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Tue, 5 Aug 2025 14:52:02 +0200
X-Gm-Features: Ac12FXzEAuZrErgHW_y4fs26VWeae3kHl9WKIW6RmRdQXXMRv1Ftpe_4M2qDXtQ
Message-ID: <CADEbmW0yx1_JL1mExOp0Kwdy7sUDQdG3CU_bHON1nJ-ikQur5w@mail.gmail.com>
Subject: Re: [PATCH net] benet: fix BUG when creating VFs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 2:21=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
> On Fri,  1 Aug 2025 12:13:37 +0200 Michal Schmidt wrote:
> > benet crashes as soon as SRIOV VFs are created:
>
> >  err:
> > -     dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma)=
;
> >       spin_unlock_bh(&adapter->mcc_lock);
> > +     dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma)=
;
> >       return status;
> >  }
> >
>
> Quick grep reveals an identical problem in be_cmd_get_phy_info() ?
> Or is this bug size-sensitive ? I don't see the vunmap call..

The call chain to the vunmap is:
dma_free_coherent -> dma_free_attrs -> iommu_dma_free ->
__iommu_dma_free -> dma_common_free_remap -> vunmap

I think the reason be_cmd_get_phy_info() does not cause a problem is
it uses dma_alloc_coherent(..., GFP_ATOMIC).
Then iommu_dma_alloc() does not go into the iommu_dma_alloc_remap() path.
The corresponding dma_free_coherent() then does not go into the
is_vmalloc_addr() branch in __iommu_dma_free().

Michal


