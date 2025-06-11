Return-Path: <netdev+bounces-196711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33741AD6067
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE2A1BC1A7C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F183C288C0C;
	Wed, 11 Jun 2025 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8SLhoe2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C4223338
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675245; cv=none; b=slZg6vXeR4ZmkvXhJrQgab/eOZ7y7JSIZ50vA31MDKU2Upv7m2J6V0mswUdeNMQHUagvlutSs/v0vp6/xLF01Oe1iNGerdctFtiqOEDUEhMlLrU5lMt+++BIyiubZXdocvIonrWITfso+GcahDgUV/1z3WxfHM06SiAUx7mLp0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675245; c=relaxed/simple;
	bh=AYq8n/v+tXT+VUaqslKMjVLnkmeNw2RH4xUUmbvnOTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftRkF8a6EZ+yl2XxF3piP3N3tOKBsIkPdA7ZbaX425aUgc0INp9WW4ZpR28yNd65mN5x4wc4oD6pjwQIgqvXWEmFYT1Y5cIqnQ149RC/dIVhWreZyBIioqqpOph4jtvMGDQ8pJLSucMVoHalN+cywB4WsR0OoOThHEoScolRD0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O8SLhoe2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2357c61cda7so13775ad.1
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 13:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749675244; x=1750280044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9ODZSh8S7aCPsxn2p/L7r5lbam9F8rTMEAJ1T+T72E=;
        b=O8SLhoe2xdpv1TU4IcPMtxP24QwZe9fL667FTUvmw2Rx6aF65AsfHenEAOX3DMeOl1
         CbysfEvve6rnPfDTFXzMENge1ywPBti1NOvNRMKWN7rlhSDlaxqa3CYc26H14XZAl3/h
         7CfOT9cqDOvXMVWaMk1beKr4vbbWdyK8Vy1Elzb7ShqnM4X7vB0g5DaWrsrsIPhzorY+
         +7YE1XQ86uMn8EAJS+po9NIpsfFIQgBMXKKChuGEHwwdAbQoUfwkhY5w61V7dYIbsL6n
         hxmkhYTPKm/JYH2rD95qJ/A3pedYP5LAf8Nt8UjbtlaDXJjHt7+TSXmzAF8sgwExkiOU
         9YVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675244; x=1750280044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9ODZSh8S7aCPsxn2p/L7r5lbam9F8rTMEAJ1T+T72E=;
        b=N45D4qP2ara7FHfFnI2pPowWJ7cxjW3iOA2n6iZJ8rLTZRUWOHagogC8bxn2GKE/Vy
         aQ9cLtfBt7vz8bn3pZ5gkH4j18Dkckqbhq5rssOUMcQdsCJLnWhbGmiaci82GHapllG3
         eV9M6oQ+Yq+jSRCpEWpQ18+rHykPONvxMQLL3NHTBKB9V2exEWX8ey3yc6cFPA6mm0WU
         MeBMGI0TiYYYydUWlpR0q2F0Im6KCaGlKk5WEGc9nuPXWzb/rEuj5ywQq2Ff2k+mVjLq
         tq+auTWKMosFCxzOnh2Fx2P8R/4G35enm7bWJvC7DXzWRK7o7XA6gCCqXrjpbtc3pJCs
         XQ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBL8N3w4KYDMYBz10SLpKyM9RyV4hTmbsMunfgw8mEXAFDj1mFGnLjOaf6/5Q42UE6lc5NZMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza9JVRrlRffPAgjFhYJB55CNlKaSugI1Qrngtu/5royRlwLZXk
	o31/s+X0aIlA7mlgIxHv/f0rvCzRINY50jVKUC2F3RI60R6L0iToD6c4jN+quOoQP03jNPrp1DY
	3zxh/IyuPAJ9FPhKgdIIhLXrDnGvus+wM41g7qZVG
X-Gm-Gg: ASbGncusCIx3DGeL3vcxhlg5WYnUH3A5Auxu4xxgnMLrm9SNLqIcg9xKgiYEeRUYA1s
	unQhpHfHo2wUktOu58ejQPRcQEzcmgzLTfauE2B/n/PqzC1W/phpO5SfV6FhJhy49lQoU9743g3
	2R1uO2rLH++4r+G2MuRdY1ObRXp/9xNDsGlrsZJ9CFq4Pq5N9K5gK6UR4LbqP2eDKO7gzC920C
X-Google-Smtp-Source: AGHT+IGNxlwvOT/63E8WfH8fOvLo/kbNgZNIZ0H/0cRMTD73xz3o38k6hHpr4p4XXDFuDJGxNZhFeuEoTw2UanOyEww=
X-Received: by 2002:a17:903:4b03:b0:224:6c8:8d84 with SMTP id
 d9443c01a7336-2364dc4e0d5mr581215ad.4.1749675243498; Wed, 11 Jun 2025
 13:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609043225.77229-1-byungchul@sk.com> <20250609043225.77229-2-byungchul@sk.com>
 <20250609123255.18f14000@kernel.org>
In-Reply-To: <20250609123255.18f14000@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 11 Jun 2025 13:53:51 -0700
X-Gm-Features: AX0GCFs86j-gs5jhCZgm2IbPRLCZG610-Y9bqwTkXzjafc_yCgYbSIAlkglSp4o
Message-ID: <CAHS8izP2Y4FMfHyTU6u5NRT45raM9isXJZPY4LMC8c03dGUPJQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] netmem: introduce struct netmem_desc
 mirroring struct page
To: Jakub Kicinski <kuba@kernel.org>, David Howells <dhowells@redhat.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 12:32=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon,  9 Jun 2025 13:32:17 +0900 Byungchul Park wrote:
> > To simplify struct page, the page pool members of struct page should be
> > moved to other, allowing these members to be removed from struct page.
> >
> > Introduce a network memory descriptor to store the members, struct
> > netmem_desc, and make it union'ed with the existing fields in struct
> > net_iov, allowing to organize the fields of struct net_iov.
>
> What's the intended relation between the types?
>
> netmem_ref exists to clearly indicate that memory may not be readable.
> Majority of memory we expect to allocate from page pool must be
> kernel-readable. What's the plan for reading the "single pointer"
> memory within the kernel?
>
> I think you're approaching this problem from the easiest and least
> relevant direction. Are you coordinating with David Howells?

FWIW I did point David to this work in a tangentially related thread:

https://lore.kernel.org/netdev/CAHS8izMMU8QZrvXRiDjqwsBg_34s+dhvSyrU7XGMBuP=
F6eWyTA@mail.gmail.com/

I think yes it would be good to get a reviewed-by or acked-by from
Matthew or David to show that this approach is in line with their
plans?

From my end I tried to review to:

1. Make sure the changes are compatible with net_iov/netmem_ref.
2. Make sure what's implemented here is in line with the memdesc
effort Matthew lists here[1]. In particular the netmem_desc struct
introduced here is very similar to the zpdesc and ptdesc structs
mentioned as an example in [1].

[1] https://kernelnewbies.org/MatthewWilcox/Memdescs/Path

--=20
Thanks,
Mina

