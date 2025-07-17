Return-Path: <netdev+bounces-207948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C758B0921B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 18:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161781C4557A
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2452FBFE9;
	Thu, 17 Jul 2025 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO9ID6yS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690F52F8C58;
	Thu, 17 Jul 2025 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770581; cv=none; b=WCqwRxyH9VcaYBLxMaDE9L/bbd4yBbjGDFqYLKDglyjqEPywm6Ypf8DHDFYX5JcCUFpd3mplenmIdLk5sivvvX3SbeJ0d/usryP/Nfee/fsLlO5aXT8hsuJFnWmTrBWthVgrmmZKbTg2N1N76tJ5FVflWMQzB82yruEPA8gNf30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770581; c=relaxed/simple;
	bh=Od7dkk3jph1mm3CmcokvqbDrt6thd/QGd4Fs6LayE6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAUehQCtcGjyHcdRC86UztNJWs+Bf8JEDTgugwfr7Mr4kLUn1hF6df09wvAziFk/r2FqOolCmzgwKZI9briVLGLgPPMio50VYP8kk9GlNb5TzUYUt2ob78UxBiFma+3byqT1eFz84ZdSRz4JKOzO5IDWa7bb6qfs5iiTek1Bsxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO9ID6yS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32f2947ab0cso10210431fa.2;
        Thu, 17 Jul 2025 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752770577; x=1753375377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzt6ApCXuVfe8L4Nz2o7HCiquyz/+D9Ml7+p/z8zd9E=;
        b=TO9ID6ySo3JXMfTjuepLTcFVQqKUp5sWkU1j8byk6PnxEIadLklchqrdWDcL8ju1Hc
         q4QP2R5ADNyySPupEkV7suueW+ozT8zurRFA5fMu7wwtOVtYXCWjJzVJ8vlCkjqcb3og
         kgZg3Ffht+TAvKvJ1zXacg7Dl8jK6H3BugoJ+kiJP4UirbV6OU6KUaR1v+RDii8STQ5c
         tKkapMOYgySVs4cAAKWqz//zuat9uio5Vnym6pUWjMCseQRNLjfy5Q51stlalJc8Zft6
         4r1SkjpHZjhWJBfEs/YeBnNL10xZ3jTSzEOL5ZVcvVgulCZDt7ayBus3D0Qw99eMYQvN
         5qeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770577; x=1753375377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzt6ApCXuVfe8L4Nz2o7HCiquyz/+D9Ml7+p/z8zd9E=;
        b=prt+IYKmOQVUPyt/fQvtmL0QJdORMkSak9Zip/Zcy9XT6WkUSDODNNhywZ3MhkgCTd
         Qb30O78fSpAeOYTG9MU/LXr/+blZjrYro0KC7/UekC2bzv3DODGQco5a9aUfOHN4Nu4T
         3DjUf+nYOZyHxyBld8zCLDqVIZ1Kqc2t7n9617HCD8uLJ5TLf9hpfPuv8HWqEcso6vIT
         jcroOREbfD3rCyLdG3JYvCjIQvkL3xiRQcmXVbRSFZJoJNEfVGx+CXXKB2zKZJNBOjC7
         +/xwjNVT4xfb37LyxSM+C6nuGmvxyRI3eb2E4JHTjSsawWlFJEs6XN8a49tud6yB3cHp
         OImQ==
X-Forwarded-Encrypted: i=1; AJvYcCWibv5FN+PzteEAhy6wxExGDAd1xtemrSaKMICozbqZ+JupNR3fFZ/IFOVJ1WdIV13H9X2i5Z2p@vger.kernel.org, AJvYcCXwljX8IFyA878gMcxJhIPdf/fim//k/v4c8oLwhYABkd+rHOVZU9Sv9hP1PqjZ9kwu3fLwlgOQjNGYJ4Obmu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6mFp7wQxheZAuSEFm2IdNmdQj+Wb1Jwq94O5GDWWImr5RPqsK
	6nPdL5AsyOjVUTSgAgnnqx0tuJ3z6/S1VbDWZUXW4G0ZmHx63Nn5ffYZH2eDCSiieO5cHI/WGye
	mBvcOEyQuovdnZdWTSc00+G/wTj7v3CFidjBJ0Kk=
X-Gm-Gg: ASbGnctnSEXUCqK84DhUHXGlornBOYz57onsOOK/kmKWota7VQow5emfHFFNHXZ12sX
	Or93APGcKxrD51X5isQH4CEwb7/kt4FwjzoxeblFUT2VobSAhO/rOpTSbaEnH13dOH9/Fx91ikH
	J8EjbAsP4M7OpuPwtJRSH5FJzpcrClV0IjM0zz2uw0Ao1p2me1TqkFNFoKzYKJcxkpCmxYZ7w8i
	k3TNw==
X-Google-Smtp-Source: AGHT+IFPcLHKH6vXZpIDES/q1M+9SWlwibLXgDw7CTD6OowyzG7aAC/7jounxEGSkqExXGA3ts66IEtPP+VP4YkJlac=
X-Received: by 2002:a2e:bc28:0:b0:32a:8764:ecf1 with SMTP id
 38308e7fff4ca-3308f4c5ea7mr21078661fa.4.1752770577112; Thu, 17 Jul 2025
 09:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717142849.537425-1-luiz.dentz@gmail.com> <20250717083857.15b8913a@kernel.org>
 <CABBYNZKW8aG=sJP+iwk44ozvJwiv0wPkrPrOBrnFZ=39rA7-CA@mail.gmail.com> <20250717085444.2847ac02@kernel.org>
In-Reply-To: <20250717085444.2847ac02@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 17 Jul 2025 12:42:44 -0400
X-Gm-Features: Ac12FXxHLkJ7cUVSgc_6_0vYPp3vFBxUFqMxykJtDXDHtqt6a-Op2qdEGpD0Fn8
Message-ID: <CABBYNZLRcX_tAupW0BB-7ykioXF96M2wHXMSRv+189gQSffR1w@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2025-07-17
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Thu, Jul 17, 2025 at 11:54=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 17 Jul 2025 11:47:49 -0400 Luiz Augusto von Dentz wrote:
> > > On Thu, 17 Jul 2025 10:28:49 -0400 Luiz Augusto von Dentz wrote:
> > > >       Bluetooth: hci_dev: replace 'quirks' integer by 'quirk_flags'=
 bitmap
> > >
> > > FTR this rename and adding the helpers does not seem to be very
> > > necessary for the fix? I know Greg says that we shouldn't intentional=
ly
> > > try to make fixes small, but there's a fine line between following th=
at
> > > and coincidental code refactoring.
> >
> > I should have reworded that commit, it is actually a fix, not just
> > renaming, we run out of bits on a 32 bits system due to usage of int
> > as storage.
>
> Right, but I think if the new bitmap was called quirks the existing
> set_bit / test_bit call sites would have been just fine, right?
> The bit ops operate on single ulong and bitmaps all the same.

I guess you are talking about the likes of hci_set_quirk vs using
set_bit directly? hci_set_quirk is just a macro that does use set_bit:

#define hci_set_quirk(hdev, nr) set_bit((nr), (hdev)->quirk_flags)

I guess we didn't have to introduce it at the same time and calling it
just quirks would be fine by me, but I find it cleaner this way even
though we had to fix all the drivers in the process, that said maybe
it won't be that easy to backport and may affect out of the tree
drivers just because we change its name.

--=20
Luiz Augusto von Dentz

