Return-Path: <netdev+bounces-43811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2D97D4E2F
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325D1281939
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A741579C7;
	Tue, 24 Oct 2023 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="crzkkKK9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D468923A7
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:45:06 +0000 (UTC)
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9BCE5
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:45:04 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id E93D3176A0D;
	Tue, 24 Oct 2023 12:44:59 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1698144300; bh=Y1aIWSgGtygvtDkXdBYmCHvtBgAzdfjU/bA7G6eAls0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=crzkkKK9Ld6sw0zQ6fw5+sqpMhfGnK5CjYaiGxlnF+8da/O1Zzo4SFMNnqiJ/kBFB
	 FrhFW4Xj2361L9YyCQrHL4movNovK/Ba60pGt7Z0wG91ZAriE0mn51eDE9HKPyvRgE
	 0/cuyZysxOzxTOgQzfxALPElVPLqm6ExOki1Q62EZ5b81Wu4KVT7l03YmNZOePhd6C
	 NzknKgvOUJHxLg7hTfoUuesLJApau/aKEbrDEP063KRjK6kcE/l3xF02Dd6Q0YzIDk
	 dmbYIoUe5XbFXkrPNdSUYyAdbrU+moP1uMKqQcWusVXnemQ7pdCIHnDOdmTb6cljLp
	 +421wq59u1dRQ==
Date: Tue, 24 Oct 2023 12:44:57 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ben Greear <greearb@candelatech.com>, netdev <netdev@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: Re: swiotlb dyn alloc WARNING splat in wireless-next.
Message-ID: <20231024124457.2a8fdf23@meshulam.tesarici.cz>
In-Reply-To: <96efddab-7a50-4fb3-a0e1-186b9339a53a@gmail.com>
References: <4f173dd2-324a-0240-ff8d-abf5c191be18@candelatech.com>
	<96efddab-7a50-4fb3-a0e1-186b9339a53a@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Florian,

thank you for your report!

On Mon, 23 Oct 2023 18:01:46 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> +Christoph, Petr
>=20
> On 10/22/2023 11:48 AM, Ben Greear wrote:
> > Hello,
> >=20
> > I saw this in a system with 16GB of RAM running a lot of wifi traffic
> > on 16 radios.=C2=A0 System appears to mostly be working OK, so not sure=
 if it is
> > a real problem or not.
> >=20
> > [76171.488627] WARNING: CPU: 2 PID: 30169 at mm/page_alloc.c:4402=20
> > __alloc_pages+0x19c/0x200

This is a WARN_ON_ONCE_GFP(order > MAX_ORDER, gfp), and the allocation
fails. The dynamic SWIOTLB pool allocator will then reduce the requested
size by half until allocation succeeds (or fails even for minimum size).
That's why your system behaves normally.

However, starting with a request that is larger than MAX_ORDER is
silly, especially since this is the default if you build your kernel
with CONFIG_SWIOTLB_DYNAMIC=3Dy and boot it without any swiotlb=3D
parameter. It makes sense to clamp the requested size to MAX_ORDER
before the first loop iteration.

I'm going to send a patch.

Petr T

