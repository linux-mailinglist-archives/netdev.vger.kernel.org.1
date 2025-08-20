Return-Path: <netdev+bounces-215150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64359B2D42C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 08:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC85588063
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 06:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8552E2C21C0;
	Wed, 20 Aug 2025 06:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7lV1/Ib"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF952C11DB
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 06:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755672177; cv=none; b=t4Zg2wMIweY6UuxEe0X8MN1Jo7NH6xbUTXufK1AK0hqda0G9BU3zOolEWrGsKf0pptyAuu3u1WP1+10t/ePDm0w0OpuMrMNyedA6u327DRmO/sCZLO2kp/NysuoNHpdaL/pbkzZgEGkKtb/1DcQIab6Nj0lgYp6E5SdD6g2obvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755672177; c=relaxed/simple;
	bh=kDL/Idwe3t8gh4wpRKhxN1+hNKjitofyF+BnAdqiTh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSbpAH385RUHaS3mcnghfD3QkaU+pvxSXA3/spdmEV8QbE2bQxgZjxhWVep294M7mbI8uBpk2lFC/zk6+oOoFRX4RR6daFm8riP7yXQ6ok4M3RkfA57OWt+RV0Glyhi3PmyG8RGa8YhNCakUznBONNMFROoyPiM9lVIUQa1dVGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E7lV1/Ib; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755672174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kDL/Idwe3t8gh4wpRKhxN1+hNKjitofyF+BnAdqiTh8=;
	b=E7lV1/Ib42Xh+2TSD5F3rKr/mvgjEffNsMMfIne8cbpIFa0fKssb0lkjFrSoIa6LbWHpLY
	OcKMVpxp85pEqiIXuLPvctR3XHn75NfdmmTt/NTbwkv8VFdxkJ8JUOzr4aO7KZKMm95VDp
	n9KJjLtzRIjLyr8gcdNTSQ/aP+qNJmc=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-bof-5_FwMAWnkvy5gcJ8OA-1; Wed, 20 Aug 2025 02:42:53 -0400
X-MC-Unique: bof-5_FwMAWnkvy5gcJ8OA-1
X-Mimecast-MFC-AGG-ID: bof-5_FwMAWnkvy5gcJ8OA_1755672172
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-30ccebf87ecso3298133fac.3
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 23:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755672172; x=1756276972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDL/Idwe3t8gh4wpRKhxN1+hNKjitofyF+BnAdqiTh8=;
        b=Kt9tDvCmIR5cgz95ZbfiitY7URHgh5y3D+1V5oEX2lSGcIMNvURZ2qRbCs8mUe3egq
         ONd/0PKLdm7te7srGqrS5/y+9iXZ9AemN6D4XoHHjShkoOpvKCgyLhGBmHEmpXPeBPL6
         /Cn1J/mRTxZS+4PER3khh6TROHjSQ90Q5v0PDKk2DPLxC3IdGJyZkK9fXbkrbBlpyWTD
         tUpsC/ERWerjMW1LiielCTV26W2hEI+irs6vpO8pNIOQFIQ5x4Rl0cXjpy9xWW0n/23u
         n8QuaMYiC2BgOjRdUk2huMAAeXT426A9E+5B+RnRzq2dbemzEEVQBzZNJ1kLWCYGOixF
         qa0Q==
X-Gm-Message-State: AOJu0YzYGk98ty5bW8V13Rocsukgf46AqNi71B5cgag5hl33ru6vLX+1
	BcDIfSt7e+sRryiW0NJW1VCisY+i5UxjvYRr+QiCekKIpepJqo2qvOD7D3PAsLEP2HYe/X+cVSq
	UQykYB9rGa3GQeU55YmSrEpG23VR4dySDNCRjHJVAD+Y9q5HeXs3lONM8WupFLc+KjrnWIl6BIc
	HpwWRkBtfRz1PUy1p4ee/0rQpWSgsrt7u6lZEA1a50
X-Gm-Gg: ASbGncvaWX3U5QbifoxDFhtLCLa20HN3RsvUA7bu5+ij1HdcRsvla4+XYUwsmyGz0G0
	UjTLbbkj4lvEz89mzaVhcFFaRMr4nElUEJxXXESoHWKvbbwaXRTfW11rqZjGRzMTKuI5/lR7oik
	8xCi4QxnYkgEi9OcPh6qKS
X-Received: by 2002:a05:6870:c1d1:b0:30b:9344:3e55 with SMTP id 586e51a60fabf-31122747e63mr394752fac.2.1755672171752;
        Tue, 19 Aug 2025 23:42:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmLsvhdtdNVk6JDmwRGF8bGjSFVPu98lgSRJzbf3timmOPy0qWyeyxDg9OJD2L6uQ8lFu4Sls5RfCV9HwHwHY=
X-Received: by 2002:a05:6870:c1d1:b0:30b:9344:3e55 with SMTP id
 586e51a60fabf-31122747e63mr394737fac.2.1755672171431; Tue, 19 Aug 2025
 23:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
In-Reply-To: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Wed, 20 Aug 2025 08:42:39 +0200
X-Gm-Features: Ac12FXxTDI61-OFqLUbUeEfxXMo9_2gsYELc-tIYCgHs3iI0oJh3Tnjv-MNggJ4
Message-ID: <CADEbmW100menFu3KACm4p72yPSjbnQwnYumDCGRw+GxpgXeMJA@mail.gmail.com>
Subject: Re: [PATCH net] i40e: Prevent unwanted interface name changes
To: Calvin Owens <calvin@wbinvd.org>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 6:30=E2=80=AFAM Calvin Owens <calvin@wbinvd.org> wr=
ote:
> The same naming regression which was reported in ixgbe and fixed in
> commit e67a0bc3ed4f ("ixgbe: prevent from unwanted interface name
> changes") still exists in i40e.
>
> Fix i40e by setting the same flag, added in commit c5ec7f49b480
> ("devlink: let driver opt out of automatic phys_port_name generation").
>
> Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")

But this one's almost two years old. By now, there may be more users
relying on the new name than on the old one.
Michal


