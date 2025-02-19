Return-Path: <netdev+bounces-167588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790BBA3AF8E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540BE169B9C
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BC235953;
	Wed, 19 Feb 2025 02:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNG06MU0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D8335D3
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 02:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931865; cv=none; b=FCxSnnCRmAAbJ8xoQNY1lJgBxnvBElgQfxM2iyKax/g2sFwK5YO8if05GYF15fkEuOP37Lx1Rvqjnr0HhdYPGQLARPXheB0L2kHc6G1I58B+IWLx7Zv44XUGJshnp3cIOJd6+9xlBQ+MSZR45w+6C+1KrmoiDeDeWRehECRWfgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931865; c=relaxed/simple;
	bh=o/wx4x0hlq6deKGiFD0YQ9nohTxcPfCijUJqOtZofys=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bkA/4CRL8jjH4lHYaUDpV8LabUkvb5Pn3/i4PNCFhgMXrpZ1v0aPUicRIlwqPLTNldv1STlhDbntd/5vTtHDFvZ4BCU5OWKy11xSAUmRUORHlywxpBsKv12ztnya/m5L9ME1bGtmbPQ7hmbppY6IRv1N2dPkldU33Gsxe6VpKgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNG06MU0; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-471f4909650so21721231cf.2
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 18:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739931863; x=1740536663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JVQIMUIeYRht9RNhb7wjktaj6RWm6o/vvJouTRRtaU=;
        b=DNG06MU0Y+LlfFo+TUtMmRBVATELwND/irTVezJM5UFkWzNw1uwOfhvHWROiIza8M4
         mFns8x81DFWT7f7ule7g5a8a53e7OR+cKRcwEoam7bpx6/tc+aVLuxNxbdHzuLbSdANS
         xo7ya8nwDJgvgfzge4Jbv67xA5FN3ruboS+mw/HMX/GfehaFdHuBLUWeUUgvBh0ja2a6
         KeZpPw8R6Gh1X6ekJ9o+mkyWsGvwU/zFbLz6U6IIbCYkbyfCVrUVqi5hEMiBIH/YIroD
         BhNvmyJBja+5HlIrlDbPfhZaHB4mZ8uzrv2EIh3b/Q31eDG7XR6qeDkih7aeeH9jGr6L
         SRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739931863; x=1740536663;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2JVQIMUIeYRht9RNhb7wjktaj6RWm6o/vvJouTRRtaU=;
        b=swvt3T8QFWC+2H4FAsZwtlcFWuqH1tAjlhJe4K6sU1PijBl78iVNCeeVdi2QeUMnev
         OHahsen/4uFO8KtHahciLcYt2OZmoqnZlH0Q8rls6J27AEswhTyco6n6MxPg++XeVO+E
         lSQJKDlb/S+BvV9vycj9fTm8YBEK+6v2R/QUId59igqBGtRBNotu6fHV3FpxloqrlBNH
         18GsdQUUm7NYX85lj8M0LZFN1NjXJIIzU+Y8lS0tkZCSbp/tlzj5nQoynYirqwpOyoa7
         GGWgmJ+f/ZwdBOzBMHq71uxFZlKhOxKREZ/eYom3w6US8ZVHqC2VhFGXb+6rKVM3ULgW
         Fc3A==
X-Gm-Message-State: AOJu0YyUmfkFi4Bt5OjO03EK2zR8lw5rKNhZht8QVQBbEPApV3JhSiLW
	B1/GZgMM4llW4UEVXfdxV1/6hFYk7DSkc5j5gzx4Qgf7G4HGAr3M
X-Gm-Gg: ASbGncuB1mkUR9qH8Kw/Dbez9G+mucoMHMLfTEKR3ZohQZ+6hMJUvjubqqBPLNc6L4c
	It6c5IfWoSNPvoqVzmdhQbZSuyole5e8SBsfrZiA9qvi5TluaCMml/yv3J9f8jsY+rB9NWwPsRC
	cf17S/1LDsjfogrSfHMJHEAOt56cjsUrpfe7ml1L5UzMA3KVBwUlx2ANhy/QGFIdIdxYTtATLU7
	bHMPPVb7w4mFYkWK983lufT52dIg/2m6OrF7XaOm8LgbhLNYdwag1+utkB6aA07brlDEm7zfMvi
	WS8+0UaNawsUo7QL3UflvKq+xZtKYE9+e4f5eSn/I39YPU1hUVAQQkRKv7l8vRA=
X-Google-Smtp-Source: AGHT+IHja0Hkjhf3cUzgsuFWsMIH2Ao40ofILhTVtkXWXxdhQ2Jaylsi9h/2DDA8P9ZCPIJJg18BCA==
X-Received: by 2002:a05:622a:1a88:b0:471:a693:591b with SMTP id d75a77b69052e-471dbe976c3mr205946331cf.51.1739931863208;
        Tue, 18 Feb 2025 18:24:23 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4720bc52905sm1206851cf.26.2025.02.18.18.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 18:24:22 -0800 (PST)
Date: Tue, 18 Feb 2025 21:24:22 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 petrm@nvidia.com, 
 gal@nvidia.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <67b540d633aa7_16921129421@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250218225426.77726-5-kuba@kernel.org>
References: <20250218225426.77726-1-kuba@kernel.org>
 <20250218225426.77726-5-kuba@kernel.org>
Subject: Re: [PATCH net-next v4 4/4] selftests: drv-net: add a simple TSO test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Add a simple test for TSO. Send a few MB of data and check device
> stats to verify that the device was performing segmentation.
> Do the same thing over a few tunnel types.
> 
> Injecting GSO packets directly would give us more ability to test
> corner cases, but perhaps starting simple is good enough?
> 
>   # ./ksft-net-drv/drivers/net/hw/tso.py
>   # Detected qstat for LSO wire-packets
>   KTAP version 1
>   1..14
>   ok 1 tso.ipv4 # SKIP Test requires IPv4 connectivity
>   ok 2 tso.vxlan4_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 3 tso.vxlan6_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 4 tso.vxlan_csum4_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 5 tso.vxlan_csum6_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 6 tso.gre4_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 7 tso.gre6_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 8 tso.ipv6
>   ok 9 tso.vxlan4_ipv6
>   ok 10 tso.vxlan6_ipv6
>   ok 11 tso.vxlan_csum4_ipv6
>   ok 12 tso.vxlan_csum6_ipv6
>   # Testing with mangleid enabled
>   ok 13 tso.gre4_ipv6
>   ok 14 tso.gre6_ipv6
>   # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:7 error:0
> 
> Note that the test currently depends on the driver reporting
> the LSO count via qstat, which appears to be relatively rare
> (virtio, cisco/enic, sfc/efc; but virtio needs host support).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

