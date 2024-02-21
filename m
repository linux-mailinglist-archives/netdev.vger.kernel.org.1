Return-Path: <netdev+bounces-73803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E709485E739
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 20:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52D6EB27DE3
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 19:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B168185C69;
	Wed, 21 Feb 2024 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTQRUynX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058F17FBBC
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543541; cv=none; b=ubbfaX7u+pXNNeBMFDpchgGZ8X6PBWPbhjlId+YJ+UKXz81dpHDAMaa6p8KX41oA98Ll9s4DlkHMwYrbSGeKZ/ZriYDAHBquILda10eSxoIewwR1hH6w24q0nNigcoOu5oo9cz2N9ofX6lgYE6oIJ7akftbJ/I1AZOl/34A6LSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543541; c=relaxed/simple;
	bh=2Djs9szs5Ofk1BJwv5+KNW44by/NjoWPT8KOFUi6a38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnjyrPserbud48f0kgL3YiiCAhr6BIIfdSZEYh6jHZF2f9dOVaSXVD5D7UounkRMdNQgCe8Gk68z2jV0ACgFDEzGmh9Bqfaz8yK2sVa7tDODJ5pjOLa3VMkyzDsvcxibidkmRG/gzaLB30R4rSrTkhv61bYWZQMLbGDZ/BtmJwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mTQRUynX; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso1781a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 11:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708543538; x=1709148338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Djs9szs5Ofk1BJwv5+KNW44by/NjoWPT8KOFUi6a38=;
        b=mTQRUynXywSy5DGwHMQ9cYVgWe1AnCp6+X7s/VI1il7jnHlUegQd2dICFU1txFAqtJ
         9XOuvRIhh2b3ow8NJ6u7plRr0BeR6KqdGnHJeI69IfV2GQVX23X2Xc0xSENjn91lIyqY
         V+CTXqk7L/2ugqHYMf87iyYRLolXvG3IZ7drtY9zAwwc0ZvBS/IMT5sgW8lUn2mz7cXv
         smbW9GzqyPhtPYcTFdWX8ZtJdVJXW4g0oF9MXg7cXkCKFnVaolaR7E59kpgEfgtZFqeX
         BkeJXFjoN+tfh1S4zGu8GhyzpmlSi753izDmYdnUGetbGg5JT8nMJFsVlP0yd4+4RZuy
         H2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708543538; x=1709148338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Djs9szs5Ofk1BJwv5+KNW44by/NjoWPT8KOFUi6a38=;
        b=KkzLp2RBqHayIM/8pTNxFuu7mN/F/Lvs8zLVXFG0UHJSU1zWYaFmUT1PYdjwdU7lDo
         +uWQVLL9VWDU6aaOgZnGNgm564Aa0b5GB4Wcg07xMoO5YMMP6mD3dURkhXohJ9/XdAkQ
         N+bNldZ//F+eoDmzvpNYTaT8ZqSdAWU6sDxV1+ljHaWpEW/kXnv5kVSmiHl78vglqqki
         Y4OGoYwy6MDh/PP/A/0QkPEcc4v9on2CVoBZbwFxyl8mmoIwIkVnIgyWahafL4fa4zHZ
         cXKy67I7UK4TLoULnd1UHwDuAqlZ5Fa43BabyNw64YL3XTf72VorT3JSIRlZ3czqqtEI
         i1cw==
X-Forwarded-Encrypted: i=1; AJvYcCV+6EaSBLNx7QPmmqLgD3cIpqdMF/UliiU/1kpxItimA01m28tOtH36qH85WIHk1RY8w5REy8q4iObPT6miO8X8IuKtm42g
X-Gm-Message-State: AOJu0YyNn8uZ+ni/CNSSp9B8KLzNUciSqILaUgVXoDxH7EwAG9yYMP1X
	k6O4Bk8/sRhvVrhd/3btmVZ3S2B8wN3OfPyZPGBUP9gHKQ9JlY2/PLm4foOj3JS7rDfeiSVLF7G
	cJPOrQ2FoV4vywBcGpgr1RpF+vfgTjxaK1dgi
X-Google-Smtp-Source: AGHT+IHMzmqN4PdpbCrxDUwvOVEtaYXpxHfoyNcPoJhklxll0HONqfGQfyiKVoWBSGii0vXTtUEh+qEipSvTj/D6VpU=
X-Received: by 2002:a50:a408:0:b0:565:123a:ccec with SMTP id
 u8-20020a50a408000000b00565123accecmr138037edb.3.1708543538101; Wed, 21 Feb
 2024 11:25:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220194244.2056384-1-jannh@google.com> <20240221112309.7d526047@kernel.org>
In-Reply-To: <20240221112309.7d526047@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 21 Feb 2024 20:25:00 +0100
Message-ID: <CAG48ez2tr8k0BqM_Lq4VAMRfrEdYhWudK1Fx6HwOEb0TBPDd-g@mail.gmail.com>
Subject: Re: [PATCH] net: ethtool: avoid rebuilds on UTS_RELEASE change
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Garry <john.g.garry@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 8:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 20 Feb 2024 20:42:44 +0100 Jann Horn wrote:
> > Currently, when you switch between branches or something like that and
> > rebuild, net/ethtool/ioctl.c has to be built again because it depends
> > on UTS_RELEASE.
> >
> > By instead referencing a string variable stored in another object file,
> > this can be avoided.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > (alternatively we could also use the utsname info from the current UTS
> > namespace, but that'd be a bit of a behavior change, and I wanted to
> > keep this change a no-op)
>
> Is this related to John's work from:
> https://lore.kernel.org/all/20240131104851.2311358-1-john.g.garry@oracle.=
com/
> ?

Ah, I didn't see his patch, but that seems like he had the same idea
(but implemented it less sloppily). You can drop this one then...

