Return-Path: <netdev+bounces-243974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3666BCABF24
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 04:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2985E301785C
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 03:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5D52EC56E;
	Mon,  8 Dec 2025 03:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFge7lBX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4721FF25
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 03:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765163253; cv=none; b=TI+5nl1S62aS6JpYmMRrQia2SMkgLUyOx7BXSg0EGxPuLHJGJpde4ObZoqkJ40C3DdazCMLf4AzmDer/Z31rHjL6dMDHxsYUz+VPGCyVPopY2NauW8zRd7YEKSR0vIV/+yGGX0kSjtffHwqAFKoMC38Fs6edNXDayY9tZaqlYpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765163253; c=relaxed/simple;
	bh=cWQlXLg2oAF75NLRYyi4rsXiifU/frpwJu+/Rp1ZA2k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b7ia0QhenX3agdnnVVU0FGdJPEfm7hMpZhuEvILgOiR179D4uMKOmxJh2gUSAEtZXD1q2nGgvzKk+UfJSURHQk5Kmo7uw+lKFtASXjd/Y/JlaFUlC9rEVhB4wPAa4sJFZRehMhwbhluTEoGjq3afiL7lPM56sMt8CA3DFiuv20s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFge7lBX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2984dfae0acso75233055ad.0
        for <netdev@vger.kernel.org>; Sun, 07 Dec 2025 19:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765163251; x=1765768051; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cWQlXLg2oAF75NLRYyi4rsXiifU/frpwJu+/Rp1ZA2k=;
        b=NFge7lBXRkH4WqTxCxH3rkPJ44Zpu2Ec6lOdcIFmvEwq8S/nPkIDgJelFwewtVVBP4
         kXPF0AejEiwaWEuS/la2dL1zGTb5Xx1Qopo2Pg4W10hF7S9bNj/H6vkaZmdLNH61VpTG
         32bq4Sxg3lZ7AKCdA4ahjjTBdsE99G+diQwEY7jBo4+eBCgRX+i44mqcf6ijuLpXpBst
         wATJ4qG5Y3jI6VtBDF/yzfCDtGyezrmFzpIs4khmY2zD38zSPyaSZLxu7Y57eYxW3A1K
         hW6vZFJ6MdwiXLdwpNKf1iTAoUQIcnXY6meRwlM6dnA63KgM62+VDa0z9jjDZEEZWjpx
         DzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765163251; x=1765768051;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWQlXLg2oAF75NLRYyi4rsXiifU/frpwJu+/Rp1ZA2k=;
        b=lcabAGgTaEhKgxzPhYR6jr0n5lBnSoYDiWTm6ELMtlO8Fd7gg/zprLnjK2kpzAx8Rf
         0IccZ7RSQT7jQlJOOLrptTV30mBN9K+uT9V4Cw/u44ywo9U6pPpvMqg+Pnkbn/qZ1Q78
         Y1XFNp/NgngRxW5PGVVDIM8xozsjLxlh1XzgRALHSZc1Uqt9FAXxhn+BI6kPNXF3avOV
         XNKSFrWMw1aQdd4Naqz/8nK456PCsIjSw3F4KJzJN2e3W75LXxA+kh4W2Yf30/4VHVPK
         /Pq3CZ8SQRDM24pr4RmRyyXbanDMw9qmZs9rSU09KTJs0/A64J70W8k8ZW3QlFeBRwiE
         kWiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDuj5ph25/RJ/H8wcS+PqBaoYAciprzFwdKp6dHfjTyIMphil/vMNZFVdJYPMnSbkkmoj6xiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzErswZdW5Xce0X1yvjYRWo7yF+aOsTh0IPeg4cNX2jbQcRjJoU
	dT7Wq7uun/u/5A8jzmi7qfM8SwahDiBLTTJe7rTcglw/32jGwpMyxL+6
X-Gm-Gg: ASbGnctdgBIG2QxR7H9DK1u3Qaj9AR/f9TUe2wIsTKYKv8zLTzg12wtIwG0HsmSZhWv
	lTES4KasBJPd2QgUxDSKLRhCvdjoDKJCnGjhE1SvER49sedFgjtn+brs//FAhG+mATnZD+ntPGd
	Dmv/LCHEBz1mVyBZg6YHWtwlaT/d1eKpxt3lEtpmSNhUBVWiDkIPUGfiYQdVDObaOr7D3UA/SI2
	68SX6F4PxNaEAo9VYcudEh0aB3RLrmUC3Y4FndECD9EMucn2s/xTst8dG6FZBlIOxlWq9pW3A4V
	owtrJ2xwod/yyoKgW5Wy9amy9+IqMbXIt4Yw7aDfVPdT4f/zwZFb9Qto+JNGJNe03bY52DvewBh
	FA7COZ6GkLmcCIwCqqkCvlE9mBEzA27woV7gcQU4Sxp8X7qM2e/pwmyQsWIR0Fey7a6BsjaPZz+
	2rJZnb6QRJIh39VECJj72FYINt5v+5FXGuHBZjnpZiSzA18FePWA==
X-Google-Smtp-Source: AGHT+IGclfbgYDV+2PprDNhoMS/qASDyleKSKZkgks8aJAQqaFHDlkmA3RGKrzkqi7Tvl94BT/sCTA==
X-Received: by 2002:a17:903:2287:b0:264:70da:7a3b with SMTP id d9443c01a7336-29df5dec918mr73703385ad.49.1765163250925;
        Sun, 07 Dec 2025 19:07:30 -0800 (PST)
Received: from ?IPv6:2401:4900:8fcc:9f:1de4:3838:6ac:e885? ([2401:4900:8fcc:9f:1de4:3838:6ac:e885])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaabf7csm107759555ad.79.2025.12.07.19.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 19:07:30 -0800 (PST)
Message-ID: <a137d0a4f3479b6164307a49b9193746db95fba9.camel@gmail.com>
Subject: Re: [Intel-wired-lan] [RFT net-next PATCH RESEND 0/2] ethernet:
 intel: fix freeing uninitialized pointers with __free
From: ally heev <allyheev@gmail.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Tony Nguyen	
 <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	 <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet	 <edumazet@google.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>,  Simon Horman <horms@kernel.org>
Date: Mon, 08 Dec 2025 08:37:24 +0530
In-Reply-To: <df193ddb-4591-417d-8d62-42d99d6d468f@intel.com>
References: 
	<20251124-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-a03fcd1937c0@gmail.com>
	 <81053279-f2da-420c-b7a1-9a81615cd7ca@intel.com>
	 <ec570c6f8c041f60f1de0b002e61e5a2971633c5.camel@gmail.com>
	 <eaf30e67-ce1a-47ce-8207-b973ea260bf5@intel.com>
	 <f34adbc99606c1f9157112123b7039d2a5bb589e.camel@gmail.com>
	 <df193ddb-4591-417d-8d62-42d99d6d468f@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-03 at 09:45 +0100, Przemek Kitszel wrote:
> On 12/3/25 09:09, ally heev wrote:
> > On Tue, 2025-12-02 at 10:17 -0800, Tony Nguyen wrote:
> > >=20
> > > On 12/2/2025 11:47 AM, ally heev wrote:
> > > > On Mon, 2025-12-01 at 13:40 -0800, Tony Nguyen wrote:
> > > > >=20
> > > > > On 11/23/2025 11:40 PM, Ally Heev wrote:
> > > > > > Uninitialized pointers with `__free` attribute can cause undefi=
ned
> > > > > > behavior as the memory assigned randomly to the pointer is free=
d
> > > > > > automatically when the pointer goes out of scope.
> > > > > >=20
> > > > > > We could just fix it by initializing the pointer to NULL, but, =
as usage of
> > > > > > cleanup attributes is discouraged in net [1], trying to achieve=
 cleanup
> > > > > > using goto
> > > > >=20
> > > > > These two drivers already have multiple other usages of this. All=
 the
> > > > > other instances initialize to NULL; I'd prefer to see this do the=
 same
> > > > > over changing this single instance.
> > > > >=20
> > > >=20
> > > > Other usages are slightly complicated to be refactored and might ne=
ed
> > > > good testing. Do you want me to do it in a different series?
> > >=20
> > > Hi Ally,
> > >=20
> > > Sorry, I think I was unclear. I'd prefer these two initialized to NUL=
L,
> > > to match the other usages, over removing the __free() from them.
> >=20
> > I had a patch for that already, but, isn't using __free discouraged in
> > networking drivers [1]? Simon was against it [2]
>=20
> you see, the construct is discouraged, so we don't use it everywhere,
> but cleaning up just a little would not change the state of the matter
> (IOW we will still be in "driver has some __free() usage" state).
>=20

But still we can just fix the uninitialized ones the right way [1]
right? since we have to fix them anyway. There already a patch [2] for
that

[1]
https://lore.kernel.org/lkml/CAHk-=3DwiCOTW5UftUrAnvJkr6769D29tF7Of79gUjdQH=
S_TkF5A@mail.gmail.com/
[2]
https://lore.kernel.org/all/20251106-aheev-uninitialized-free-attr-net-ethe=
rnet-v3-1-ef2220f4f476@gmail.com/

> TBH, I would not spent my time "undoing" all of the __free() that we
> have already, especially the testing part sounds not fun.

+1

>=20
> Turning all usage points to "=3D NULL" is orthogonal, and would be great.
>=20
> >=20
> > [2] https://lore.kernel.org/all/aQ9xp9pchMwml30P@horms.kernel.org/
> > [1] https://docs.kernel.org/process/maintainer-netdev.html#using-device=
-managed-and-cleanup-h-constructs
> >=20
> > Regards,
> > Ally
> >=20

