Return-Path: <netdev+bounces-228025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEA5BBF1F3
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 21:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CFB6189B32A
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 19:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C36253B40;
	Mon,  6 Oct 2025 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2dAtET+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F411A4F12
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779953; cv=none; b=RLpbbio+D2zkCUOs8v7nx0IyeVEBM1tZNYcmGQbixhWOPXXnbdWnHz7ZdHNj0A1otU/vWL0HbnUhlRiGEybep5U6hrE4uul0fxlkjKTfD4e0GV6/GJUP3/3WQytcik/3ex8KlpLH7GAe1ctaVmtGx2PyG1HvxAym86UQtn/7w0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779953; c=relaxed/simple;
	bh=x+ftkWY5fwkw39EHN2Kyi0GJJnaTzx3hijkVj7JP2MY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HuyGyyAvA1BRxkbS0Qlff6wkFh3hvHGzFaVcZoEfaQZnLGIhzE3eT6gJfoT6A2AFuyS8eb8ll//K44X4yWhmEvRvrC3WRzGPlNNFYojMLzDdMVvedNaeE7x8/04E7EzVNIKBFTFrhsKfwlHMuEb4IhcOaPfR+lPa7kQti7mp1i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2dAtET+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759779950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bww/a9+3wdLbRI/iBMrrt7lr6xjDvm4RQk8ELkL6obs=;
	b=f2dAtET+41bKdgS56/rKt9e6pQVacBrpFtZgNHV+PpO3rfoufDIbwMFtOwe60IFw2Kphpj
	s1e8iGALXFhVU3zMEcOhxs2v2dajDsROm5WH7ihx1viBdrJetOybhu4M4zb5I9kdppcgYX
	CX5LLgQt6UtaMIRA85F5Dsq4qcxaFyY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349--0teK6r2OXeHuegdUJxoyg-1; Mon, 06 Oct 2025 15:45:49 -0400
X-MC-Unique: -0teK6r2OXeHuegdUJxoyg-1
X-Mimecast-MFC-AGG-ID: -0teK6r2OXeHuegdUJxoyg_1759779949
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78f3a8ee4d8so100565466d6.1
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 12:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759779949; x=1760384749;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bww/a9+3wdLbRI/iBMrrt7lr6xjDvm4RQk8ELkL6obs=;
        b=ihxR1hW1GEGhJ1AZv9j+hRkR1gnegkOMZ0RB6vfR4MUarfzWardG/lj4evqwjlfnsB
         pfflcRngjllEa0IoJZ6YcE8xIv+wD2s4PJdler2hGyeiVyWLJiab0zgh7O4hkza7d7x0
         xN+kqUV3eKBD+1ePtSLkbuqes9fAGCiuEl/g6URGGarHAls+sRTYrkvDWlYukKObH3jd
         TarnLadPjgFIJDHuWfOdxl3iKF0YOFHPg3MD19pMOu4TPmGlybW0puonJDd0FZdMuan8
         Vao9uD5kLdZKXX8ssbNvELg8MAupjaQnKHeISggROYtWhdmc7hTqRJFN3KALrcA/o13J
         Pdiw==
X-Forwarded-Encrypted: i=1; AJvYcCV/PAELZGPQGaUQ1wpeT7/zqby5MXN/82QCtBapYx0Rrj1jEVDDrmLqq1DqN5b+I5A1IZM9BUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1KiswCC9oiIoF0EMr1aajS/+82Mj2F2CgTokX6/AJZnKRbnIp
	RRP1gWMrLOoIYhVU6Yn9wbjQcrbHlRq4C+7fwCb+OJ4XuqskVED+zWx3oa+CRK1NKzvyGJNuz1M
	X05e1klv7JwtFzeZpxPKDgNe9IGJeWkwZ61oV7R4K5xmC4ZHaE4d8ra931Q==
X-Gm-Gg: ASbGncstTNnsveADHFDfKDaWSJs+v2hXv/rQ1U5S8E2V/oiR5Ue84QzqOwQTaY9nqvb
	APeHGYUZ91hC6QNmEZR2cJ7BctDkSqB6n30XbqcPkfioSArw4yx5nxqmIhHxS6AtNAJwx2qWrJd
	NjZI0mfLluPUpX5kMs/kodCF9q0Qh6uPvvLXozWoNdpeE57XgqPUqkVvDIlfwiWCE5TXY8kgOvv
	Gr70BrC4UvulUC0+oVZzhCTfxRkhlbFZLvH2rfR6bvL9f0d29ZB8Lqx59zyKRhgqZHvxOcFo4lP
	kaFg4gdnuTLjGzUoATD03JL4ZDxwR4UEFVPHUORa
X-Received: by 2002:a05:6214:2465:b0:820:a83:eb04 with SMTP id 6a1803df08f44-879dc799aa2mr132540616d6.20.1759779948793;
        Mon, 06 Oct 2025 12:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY1TaTfi2eevE1f8zq7Sc6pe4IW7SS1PPzrteUKIgFuyF3z0hFZTwxqNXjqadsyaHbu1ADIw==
X-Received: by 2002:a05:6214:2465:b0:820:a83:eb04 with SMTP id 6a1803df08f44-879dc799aa2mr132540316d6.20.1759779948323;
        Mon, 06 Oct 2025 12:45:48 -0700 (PDT)
Received: from m8.users.ipa.redhat.com ([2603:7000:9400:fe80::318])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bd783bb7sm125065946d6.41.2025.10.06.12.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:45:47 -0700 (PDT)
Message-ID: <0acd44b257938b927515034dd3954e2d36fc65ac.camel@redhat.com>
Subject: Re: 6.17 crashes in ipv6 code when booted fips=1 [was: [GIT PULL]
 Crypto Update for 6.17]
From: Simo Sorce <simo@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>, Vegard Nossum
 <vegard.nossum@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby	
 <jirislaby@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S.
 Miller" <davem@davemloft.net>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Crypto Mailing List
 <linux-crypto@vger.kernel.org>, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Theodore Ts'o	 <tytso@mit.edu>, "nstange@suse.de"
 <nstange@suse.de>, "Wang, Jay"	 <wanjay@amazon.com>
Date: Mon, 06 Oct 2025 15:45:46 -0400
In-Reply-To: <20251006192622.GA1546808@google.com>
References: <562363e8-ea90-4458-9f97-1b1cb433c863@kernel.org>
	 <8bb5a196-7d55-4bdb-b890-709f918abad0@kernel.org>
	 <1a71398e-637f-4aa5-b4c6-0d3502a62a0c@kernel.org>
	 <f31dbb22-0add-481c-aee0-e337a7731f8e@oracle.com>
	 <20251002172310.GC1697@sol>
	 <2981dc1d-287f-44fc-9f6f-a9357fb62dbf@oracle.com>
	 <CAHk-=wjcXn+uPu8h554YFyZqfkoF=K4+tFFtXHsWNzqftShdbQ@mail.gmail.com>
	 <3b1ff093-2578-4186-969a-3c70530e57b7@oracle.com>
	 <CAHk-=whzJ1Bcx5Yi5JC57pLsJYuApTwpC=WjNi28GLUv7HPCOQ@mail.gmail.com>
	 <e1dc974a-eb36-4090-8d5f-debcb546ccb7@oracle.com>
	 <20251006192622.GA1546808@google.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-06 at 19:26 +0000, Eric Biggers wrote:
> On Mon, Oct 06, 2025 at 09:11:41PM +0200, Vegard Nossum wrote:
> > The fact is that fips=3D1 is not useful if it doesn't actually result
> > something that complies with the standard; the only purpose of fips=3D1=
 is
> > to allow the kernel to be used and certified as a FIPS module.
>=20
> Don't all the distros doing this actually carry out-of-tree patches to
> fix up some things required for certification that upstream has never
> done?  So that puts the upstream fips=3D1 support in an awkward place,
> where it's always been an unfinished (and undocumented) feature.

FWIW downstream patching, at least until recently, has been minimal.
The upstream behavior has been good enough to be representative of the
behavior you would expect from a certified binary.

Note: this may change going forward, but I am confident that as issues
arise people will propose upstream patches to keep it as close as
possible within acceptable parameters for upstream behavior.

--=20
Simo Sorce
Distinguished Engineer
RHEL Crypto Team
Red Hat, Inc


