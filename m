Return-Path: <netdev+bounces-142898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AEC9C0ACF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40CC01C22607
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53E4185B56;
	Thu,  7 Nov 2024 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QtyxmC85"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC331E04AF
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995661; cv=none; b=p33/5Rsm+2EmemDGF4gRLTPQD1v75fnjSpEul3f9TaZYmWKPaA7Y/FtZ87vtOaHJ9XM2jS9zAvWnBThH8JiQBZk2yLLEZU9x2swS6TfMxd3hjhMTNMUjXAC42IRq9dfsaQ67+/KxUkPq28LKYtOijTDIOrw/X9Cm1BWLVZGfses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995661; c=relaxed/simple;
	bh=7So9DPQN+Q9ETl4ZBd8+QbeYu0An3iblPG1/iVpsrs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpnUQOljFRoyRBmO8rsEfMoXuoereM032Ol8ZDUGi5ExklbC7fsvJqdzO025UfhccLXBEdn6TjcjvQW8mO9T+8mA34aC+UzI3mnbPwhMLaLMK9d9J/hwMCJJICZcyX234V8Ng1pOPVyTRIfTJ84XwSuWglvpzRnyBl9y6aDdR3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QtyxmC85; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c948c41edeso1464237a12.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 08:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730995658; x=1731600458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9KELAMVL3eMJjSDijDKjCx4Qbn6HYZAnLt6XdeiTyM=;
        b=QtyxmC85HIsHXtHsbXDLk4Pf8rYNJv/scNIsErNtK3AifwM1ankuUZd7Dv5bLvwVT7
         jyUFFn5o23eyDPKyxyixW2UbrESB4euS37nIden9DZFsJ/IMeaiZcSCYrtoVSR/2UfHE
         cvnq6zWgIZyp9V0RkmxbNOernRu/b/wDXYpjZApzveO0uoMGpWVpV8gu+pW+QqCVlJEp
         Dwqg8PUG+5S3hUwHEbwXizDI2HryRmC54PzHh1bRAe7tKCY55oSGrDma1JQhn//r/HD7
         9pY+KXi6E9HJon4m0H8KPRPAmJfHpDsHnv/eRSrQVpy7PpBPapkKVskCP2krGy3g6Gxy
         XwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730995658; x=1731600458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9KELAMVL3eMJjSDijDKjCx4Qbn6HYZAnLt6XdeiTyM=;
        b=pnZ9tRx4TviKq1fEwW12pz97ugGdoULM151yKowOvZNBUbcgLkkbhL3+onnkYjklib
         aAWfZi4BqwnGlRgOBTgsd5lN+cPx3Aimrccz4s2ZsehKxhLf+Eh8pMCXyJYsVfpOEVUp
         UeavvVUsqM4SK8BL2dtto3uwtQ1wyMHE3xVwUkjWEeZ5UCqW5tOLMmogPGNi1ZdDSbsj
         ZQTKPh6SG5a47NRKw0U85fRKpeOloYckAegiRA1e2tz5b54FWcQGLbpBi3OewPdw+H6l
         gDqB1hZxSEmqMXvdMat88KTSksJdsNpotG8vyLeUcRjNFec48mB1uSJOG7sO53y2CvIz
         byig==
X-Gm-Message-State: AOJu0YyLrnSWD4fiFYwJNeF8GVKsJRddyc1c9cmWVUe+X6RIJAlOmula
	zd53y4h/XPkmYN2nW8R11gspn/OKzAX8SKFpAoZ0Pa3AhpyyV6R2/7A+qBlBtM7cnGaKfZMNWp6
	OI2CTZ+iR0GdOsz+48AOOLHK4EF7u9p/a3IS5
X-Google-Smtp-Source: AGHT+IFySGjdfswCSK8im0KKgb1efVizWrpOrxVWxDBcSwGFHQgNZgYl5hs1adtCv7FhnWpUxwgyoANLwF/N5TQ/6qw=
X-Received: by 2002:a05:6402:1489:b0:5c9:5c40:6d9a with SMTP id
 4fb4d7f45d1cf-5cf08c723f6mr390544a12.34.1730995658071; Thu, 07 Nov 2024
 08:07:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107160444.2913124-1-gnaaman@drivenets.com> <20241107160444.2913124-2-gnaaman@drivenets.com>
In-Reply-To: <20241107160444.2913124-2-gnaaman@drivenets.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 17:07:26 +0100
Message-ID: <CANn89i+uc8s5LDGcgW4Nr2O2ig-cZWkw=0cG4tz1CO27U4Qz=Q@mail.gmail.com>
Subject: Re: [PATCH net-next v9 1/6] neighbour: Add hlist_node to struct neighbour
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 5:05=E2=80=AFPM Gilad Naaman <gnaaman@drivenets.com>=
 wrote:
>
> Add a doubly-linked node to neighbours, so that they
> can be deleted without iterating the entire bucket they're in.
>
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/neighbour.h |  2 ++
>  net/core/neighbour.c    | 20 +++++++++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)

Reviewed-by: Eric Dumazet <edumazet@google.com>

