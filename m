Return-Path: <netdev+bounces-107364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 074E991AADE
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D261C22160
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFA71990D0;
	Thu, 27 Jun 2024 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nXb4liCy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C771990A7
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501293; cv=none; b=FbZNlOvULO6Jy2wk+Vrb31mq6Q/lGKNjuxqSC0OHq7B0Qut8nk2tg16ve04hdyFDf5QfyZaKjv1qM6/tUZxWpP8jGaawg7QhOE/n+dXJbSmwWv9qoJbEcr9AokLv8HDqydETZBi2akxG0XSHuojTB5DMr8oeBv+9axjGTxUjgWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501293; c=relaxed/simple;
	bh=rGwL3oMyBb3esjkbQG2SLNs/71kl3ZLcQYipiJeoMdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQhpEL0vZ1ecTOJb23qqMvpfRIz8s56ENgo3kMNPODfRFD67hDkdoih9jPmhh7n1lhqo1iiwTTgLQUqKU2/tVJe19Hy9JT2h8KoyVAjJGeIlvIr6CIdmoaS2B/z+yIv9JxMrCkrIrP4QTEKv0aZ748tgWa0JA6prwS18Ik2zmFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nXb4liCy; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-445022f78e1so350491cf.1
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 08:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719501290; x=1720106090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njsiEYZh4Sli3Cm/k6NxQxG6P6Xq3Ur/tZttYJMCHME=;
        b=nXb4liCybd5cx0mJqq+bW/u8dng6cdamxIHca7YyTEGOY4kDG2arTyKx2wud7s7GZM
         P2P7cYTNAHy7c5AtDGZaK90zNOZxOo7FaWACp0azV+BZBGeIwbag/JLE8wiTs+A5cr9V
         XHPhdqE6fT0G1GptnidJIin7JxH4Li8EthwSi3YPJ3QnQoa2eku4i6wH4aPIzuNVqgiG
         SAQ9Y+dwOddhHUzGkiOvKBG6qRdi+sIn6sA94VG1g42/iMGVPW1whpGhuWFxWzyINtcy
         jhjIhAhZxgi+WWMJsWVW7scxIQ/dRCog8L5FuyHAzmN9ENOBJLHdd0S/K9XWJ/jk+OGh
         TTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719501290; x=1720106090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njsiEYZh4Sli3Cm/k6NxQxG6P6Xq3Ur/tZttYJMCHME=;
        b=k2NauZQmjvAxCNS6yiEHdjnwCzzc3U4hBYFm9pXrtwilFcTQki0OMIPufT2sXj2QGF
         dY4xE41BKIhoH0IfoBv03xH48qbg6Uc+qU1LbG2jBIC9tBsA34XpbC9Ul94trWh5nST7
         YVAwJnDul7qS/zDPJFQ7oAYSsEFr9OJkKeMKjA3awAmDdBne8AZjsqBKOgvrK9mKZoLP
         EstTwoSXlpQqahj8f8/x4GIKYqhk+Svud27m3MW6C8S+4VcDeMtwhtmwX6T4x57S0bpK
         MpltBtKO+Rth3hqg2uwu+s4KBSqJ23DG8kdD5/D2UdACRl9+7ctihNHBx0HWAwMVph02
         9gag==
X-Forwarded-Encrypted: i=1; AJvYcCXy/2SfUp2CvVvnxhkISnDdWTew3ylRiOz0tjI9pIJYkilmPV+VpK51CDqnQs/RNuM3ue9v3Ww48FqrxV8FhyfU/5oQ0/Vb
X-Gm-Message-State: AOJu0Yz9+0UHj5FFhDGKhyBIf0Ywxo9lNWxQ0PEa/GMjSHSXV0spVRSa
	yqK3yMXgbbo/RflEvn4oGDf+qb9fK3g75zmtWUH+8IbaCwORUCfsMKHOfivQh2NHDTo01z3hImS
	IsTXCMTngp8qgKoz9V5kvBAVmYMMNCjBTqeQ=
X-Google-Smtp-Source: AGHT+IHS1TuY7dvnpX6GE/4uYi/aWshvrFhe44/iHrizTckAFbFuAbHuT7w1crcLqp2xVr1WjTpcwAUm9T/vdkKbez0=
X-Received: by 2002:a05:622a:5488:b0:444:e9b9:708f with SMTP id
 d75a77b69052e-4463fe43488mr4287961cf.21.1719501290480; Thu, 27 Jun 2024
 08:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510030435.120935-1-kuba@kernel.org> <20240510030435.120935-2-kuba@kernel.org>
 <66416bc7b2d10_1d6c6729475@willemb.c.googlers.com.notmuch> <20240529103505.601872ea@kernel.org>
In-Reply-To: <20240529103505.601872ea@kernel.org>
From: Lance Richardson <rlance@google.com>
Date: Thu, 27 Jun 2024 11:14:39 -0400
Message-ID: <CAHWOjVJ2pMWdQSRK_DJkx7Q9zAzLx6mjE-Xr3ZqGzZFUi5PrMw@mail.gmail.com>
Subject: Re: [RFC net-next 01/15] psp: add documentation
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	pabeni@redhat.com, borisp@nvidia.com, gal@nvidia.com, cratiu@nvidia.com, 
	rrameshbabu@nvidia.com, steffen.klassert@secunet.com, tariqt@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 1:35=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 12 May 2024 21:24:23 -0400 Willem de Bruijn wrote:

... snip ...

> > Connection key rotation is not supported? I did notice that tx key
> > insertion fails if a key is already present, so this does appear to be
> > the behavior.
>
> Correct, for now connections need to be re-established once a day.
> Rx should be easy, Tx we can make easy by only supporting rotation
> when there's no data queued.
>

Could you elaborate on why updating the Tx key should only be allowed when
no data is queued? At the point rekeying is being done, the receiver should
accept both the new and previous key:spi.

The lack of support for rekeying existing connections is a significant gap.=
 At
a minimum the API for notifying the application that a rotation has occurre=
d
should be defined, and the implementation should allow the configuration
of a new Tx key:spi for rekeying. A tiny bit logic would also be needed on =
the
Rx side to track the current and previous SPI, if the hardware supports key=
s
indescriptors then nothing more should be needed on the Tx side. If the NIC
maintains an SA database and doesn't allow existing entries to be updated,
a small amount of additional logic would be needed, but perhaps that could
be (waving hands a bit) the responsibility of the driver.

   - Lance

