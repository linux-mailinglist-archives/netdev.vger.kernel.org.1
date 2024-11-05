Return-Path: <netdev+bounces-141742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1571E9BC2AD
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B179F280938
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 01:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE421CD02;
	Tue,  5 Nov 2024 01:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbGa0iId"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008E11CA9;
	Tue,  5 Nov 2024 01:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730770522; cv=none; b=JSNGB1BReeMXHkgG/J1OQ91zEh6nlCpQ71kc4DD9bQZlJQJ/kN336FujyhXxZBPeW018rvD5QzhqeRJJTCN2/pqRax+PgTSIsoXKk4NDPUTb9Q3wpx+RWxwu36FLn79u03DdJPUmtyb87EIG1w4MNDRXHmJS4mUjweCoXIjUgF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730770522; c=relaxed/simple;
	bh=ingfrncuikx6qWtZpzFjp3opkDa65j5kzqOYQ6LoTlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzxq1riunehXs/7ERE7yYsghK5/Zas+hwjZwrdtmFk53tN4NYcYoRMNJxuiICn3mfZIVT8mNXU96IekOahpunRaXztLw/Ehysoe80kSxz/phbcHO3sbor7HET/oNzF4YMibDtmZBkfR2hzIvSFcZqSv4CBMu9rw0L6fQ1VOAr0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbGa0iId; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e5cec98cceso39009947b3.2;
        Mon, 04 Nov 2024 17:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730770519; x=1731375319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1olVdcYdpbzAU58yRsPEPtreJytP/ErwpPoWbC/4Weo=;
        b=RbGa0iIdwmWET/R6U548KIJHPbPitgXrLssTqjWw1JBDwgJIDCZDBEsNSNMCI1unWJ
         IXYfSgPUhflW6+GmLDN0AxGls0oDlGnz+RMbsoVb6QOxKwQhJHXdub/VQ7bDPAofVRmJ
         EJ0R99qnqPkx0/MbhaoeZnAvDYMSKN69B0xkeTpcxn2eouI1zai6cDKdUdvis6vh32oT
         6V4r502rnsuRhYfusSp1ATaDupvfg0kW1gqvuYy0EGW0Q3R358VwZMG0LgFaQ/j2oOnl
         3LUJGNWeJk4eUOxajn16DBH0LullYyHId3KrSi3awXbUijZyH2J85ZekzXD2D5vezf5B
         zLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730770519; x=1731375319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1olVdcYdpbzAU58yRsPEPtreJytP/ErwpPoWbC/4Weo=;
        b=uHrQr+5btkMRY5XH+cSMTPTjPJpl+4NZTk/AkC/aPdPOQ5lJfDCJREGQauT5Q4W4as
         pBlWbU+kDk0iKHKRMGGgANhYs/9e0EN/wLSE/8W/UUoAXb2uiZQZ1tyO8w2Bo0R5aE6m
         pGBZYBC5nsSnOggXfkMuDykRk5spB7ytSOOjnjlbLrPBlGdEVW/UC96hoNtAv+dBJGiu
         vPCmhx/o1pNWLZKvsKCPJo5a+51vRmouiY6Yy656nxbsIMXPCGZNBiM2Bfxh1n5Qn4sa
         3A2hfGEv40qs2eChQq/Wm3+A2tCl424fh9B3zht2jWPoCKNGGJvsq6CdGsIzOb+Xv4PX
         mXoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAhjLNpdKpC+FfCWY/fxtt71omfeBH8c9nq6vr2jIuQGX0Bf06fAp9p3UDBZXel7Mxq7yariOr/9+SUPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkc84mMtx2QxupOD1FZ2naXBl/UxdIotWyen5xBB3mwao0SWYV
	iP9yX2Sq0FUKdqX827nvxEdDCCRkgKgD0udV7NJxkvtSJ/VXZ8hFTQF3xq9mvSug1rHLoOu+3O0
	uKyxh+O9f7fJiK92fefTrDtGuaRX5ljnwr5w=
X-Google-Smtp-Source: AGHT+IHumg29ZCvANUFmdwzLHDkWQb+pLrpZmept1M1Rh2XLyhWlPjqmDFclS/BZdxG49yfm/f+VICBmuMl/EwbpAlM=
X-Received: by 2002:a05:690c:64c6:b0:6e2:1a56:bff8 with SMTP id
 00721157ae682-6ea52525bb1mr153943557b3.36.1730770519634; Mon, 04 Nov 2024
 17:35:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104210127.307420-1-rosenp@gmail.com>
In-Reply-To: <20241104210127.307420-1-rosenp@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 4 Nov 2024 17:35:08 -0800
Message-ID: <CAKxU2N_wxh+31VkZAAczVUUVt5duLv=yBj9zyLMDfoYGPq=G5Q@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] net: ucc_geth: devm cleanups
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, maxime.chevallier@bootlin.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 1:01=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrote=
:
>
> Also added a small fix for NVMEM mac addresses.
>
> This was tested as working on a Watchguard T10 device.
>
> Rosen Penev (4):
>   net: ucc_geth: use devm for kmemdup
>   net: ucc_geth: use devm for alloc_etherdev
>   net: ucc_geth: use devm for register_netdev
>   net: ucc_geth: fix usage with NVMEM MAC address
oh this is interesting

_remove calls platform_get_drvdata but platform_set_drvdata never gets
called. I believe that means _remove is operating on a NULL pointer.
>
>  drivers/net/ethernet/freescale/ucc_geth.c | 34 ++++++++++-------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
>
> --
> 2.47.0
>

