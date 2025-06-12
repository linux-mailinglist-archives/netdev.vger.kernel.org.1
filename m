Return-Path: <netdev+bounces-197147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48884AD7AAD
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 21:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399CD17F49D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 19:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48E82D8DC0;
	Thu, 12 Jun 2025 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A4L79eJ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E872D8DB3
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749754862; cv=none; b=ZEg1+yWEkqEiP7LaxqQWJW9cpa7un+4sfrNdj6vLiZfGcvdsmlFk0v0rHszuRTfHJsHGr9QNIiwAixadBrTtyJb5lRPua/UUPwcz/9lHIfG0+xaucU5BGbFU7lhsb1NL6jLxfi4gdbdrVwCfY9MDL7nTFOBjeSvG+PgwiZ/p9wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749754862; c=relaxed/simple;
	bh=ZwlMsaTHjZOtEXv/YqtnnEPbYBwwh6k+wD4c3F2kUr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ba5XxZpDFgmhb8OfdG+ZoidbDUe43wxP/wQzr93g1lJU99McyT9AjT12qQDxfsSHCbNHZi9ml44Ux/Iig32zPZ82TUw3zz8qARdRypxuaaDVRPyKSOHE05n4nRqgWsDVen1qJrkhOazlyHJOahv6zNb+Hf99iUmM3wAQNBisyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A4L79eJ5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2357c61cda7so30785ad.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749754860; x=1750359660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwlMsaTHjZOtEXv/YqtnnEPbYBwwh6k+wD4c3F2kUr0=;
        b=A4L79eJ54S8X/R6hdBRCGJERy7H+zrEjPyMVVBDEq73jX4tDGzH3TXGyFFeViSYU5x
         IGzAXqwuH26ZZPVqh2BTD5c3EpOFjYyeo1I9HO28R5rcfjJlc2TAXXEdCVOvI8HMDWfp
         M7wJn59bo/R0KEjXzu89S81WRPMoZVOOhkc21AJp4jsxBc+Z1Ovope1S+Euh07I4obrz
         XE0AA8khB6StZ406/4PRkf1tmhWHpT5xPcwwyRiaVgrHj8YsHyvkoiansK9tWjlLAHxI
         FYIg/BMQu0jDDqJ66Tbft8Y7n2iHJ/TnY54dW18edX+W/DKljg8uhbbwI+IRKCUqSyD8
         Ja2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749754860; x=1750359660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwlMsaTHjZOtEXv/YqtnnEPbYBwwh6k+wD4c3F2kUr0=;
        b=sD17HqyzfmeCa1fBeGBnIclp2lXcwGhzP2g7HeIDJpMGhWZuAxVup7kHibdSeN90uC
         +oP3J/3mJzcAOisNIyWhEW6xeyA+UvsSuEBbn0/BifK1zFe/d7/XXtG8fy7Fs7nmVDc3
         f+OrvSuYj7kJsFCflFPGDhM0sgv+5+jPV/pRtQZIgQpFw2mlRRkRiEp+ifr45HvEgOek
         NlFpHX9H69xhS7YdQru2dez4bWS47n6IkUxF0JOTIz7og8AI3ZJyV7BXIpr4ja53KOlk
         6L7l10KxN6RO13X+bWJvkUMp6gadF4qyONrpPvdQj7uf2OsY7anVCDurR2vjXtjEoJb1
         SEAg==
X-Forwarded-Encrypted: i=1; AJvYcCXVTnjfWdkuJFwZSiex5s5X1KHVj9dxJSOWp7GiZG2mHdPiiFbkbpjZ7Ej6Kt7DADhrz4a8Fm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytEE6M+R0yTmWwzj94AiBD9oFNY4dMPvTIshjzE8ZcX1jbQQTB
	UgzZyYBE/w7rr7HXPf/vbUe2tLKBdHhf6NgvUEOFVtKktTHdjoeEwDqUIOcYFPHsGk8797cHkCK
	jTQ0XcsbZ4qX8MTFvx1mo8ShpDSwfWI0t/XBvsKPd
X-Gm-Gg: ASbGncuEWXTM3g9TFM0DR1AsWUVC+N9+WixAtNg1VxkwkXZmTMkdwthcVM8EYF0+1Ae
	WtUCjF/bRBNspgBVhLgCt9cnfhhwTm0dMR0IH4acQFTpYQ/blOntH6dMcoXRwl5u0rSFWpQruHT
	1b1/wHXKA7ktKAyPU54RA6mtijDRD/CeDmwldCmx6v2j9AEv0bLh8lfqfXs3w529t6nqKPfgHzM
	Q==
X-Google-Smtp-Source: AGHT+IF+DrhTdw1EVP33Lsxs8pEmeKyxPiFeWCjxcFQq5i+dtpZuy+WTSh+WvsQ3zeAWf1tAffKMVahMPLgaOisNCFA=
X-Received: by 2002:a17:902:d54a:b0:235:e1d6:5339 with SMTP id
 d9443c01a7336-2365e950001mr97625ad.26.1749754859927; Thu, 12 Jun 2025
 12:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612154648.1161201-1-mbloch@nvidia.com> <20250612154648.1161201-4-mbloch@nvidia.com>
In-Reply-To: <20250612154648.1161201-4-mbloch@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Jun 2025 12:00:45 -0700
X-Gm-Features: AX0GCFs8bIh3dxPetT87B5xeJSISXmwVqrXxvRLSdCTJ2AOZNbM701RU8f8TtdA
Message-ID: <CAHS8izNe_g9o92C0RbOe6vtbSfBMbJJJc4K1HubpozN4xwrcuA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 03/12] page_pool: Add page_pool_dev_alloc_netmems
 helper
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, saeedm@nvidia.com, 
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com, 
	Leon Romanovsky <leon@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 8:52=E2=80=AFAM Mark Bloch <mbloch@nvidia.com> wrot=
e:
>
> From: Dragos Tatulea <dtatulea@nvidia.com>
>
> This is the netmem counterpart of page_pool_dev_alloc_pages() which
> uses the default GFP flags for RX.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Thank you!

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

