Return-Path: <netdev+bounces-245276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B40CCA281
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 04:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C24E530019E2
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 03:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB8527F732;
	Thu, 18 Dec 2025 03:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXEPt/gr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D3923314B
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766027698; cv=none; b=h7+DTtAcTyNvCUkageLfitoxWFYKPJ9eMfo/QqmYcG7nsUfoiaoPFw3UzOrur0JMsidwjYDZZ0hDNzy/XKu3XzShkoafat6RGdx4ZOfJFXBsgI2GL+1rOlpRyNDzaOBJHoCXf1H5nAbr1omD/scupXBxPJSODziyveFszEaHvdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766027698; c=relaxed/simple;
	bh=aMmDsg6PeqY3yDJKla0eomYe6OESw8tJFHAPUF0WDJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyZ1VWDlkMIX/M7IInd/7BaqFzB4Dii1qUhQGOetYRFXN7/5r1MXa8rg0cqbKvnoU8vMZlAf9Ly1dIy/l46G0L1PYS2npvWQB9qHAQ53ULZgUJqCnxV8dE4pnAV24GhV5ZRllNrJ+MI8prR9gkrQuZoHUfr0GWDHO/wH+bXhHsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXEPt/gr; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-34c902f6845so249773a91.2
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 19:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766027696; x=1766632496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aMmDsg6PeqY3yDJKla0eomYe6OESw8tJFHAPUF0WDJQ=;
        b=QXEPt/grP1RxRSJs74ehc+MGsdQwN+PTKJtkgEmF6rzpHk9j7YsWbDK43KCa6v10/b
         zHSWNU865ZcdamHE4xXK2yrwc0G6rb5cEnAr/NImt/ec0G/O6Nz7RQICiLeILzfNFnUx
         6yylT4RgkSLrsDGhxmGn7Jii5Kjiw/xvAFbH5avxoVTBmoyP7VNhq4WO/CfPAnmJiwi9
         NKCkUxjL3ML4N1dwzBCdLnr8q/cvgA0pgnOHqRHX6iwhcvw6on0y0fO8l4m0r7dDJFYZ
         DdVXOtY1JIUC3LPglQIHZAzyA6oKP0+e4uLtMsDzFqGLbMbtZwDbxvwmQxOzCDwdLHKM
         s7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766027696; x=1766632496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMmDsg6PeqY3yDJKla0eomYe6OESw8tJFHAPUF0WDJQ=;
        b=dcxgb9s/u+vc2yrUOZ8cbsRugQPKuq+waDrj6Ojft5dkatmskI4eQhx8fXYLVcK+M+
         0efkAl8rqe/COIrihP8Cu+2wQ1wZhNAtkvtEs2boy9gKOP4bwnsCIkVBlRiB9/W855lT
         IqBUbPQF/IdMLbU5CwnvrL1q0FFpoCspoz3crW/ZIhfD2wbePY6Onhioo5EyAhQLNMfi
         tQHl5WUpyZyMjrnw7/hx5ga50OVpLKprg6lSJ2EHAkYYqQalTXsR61F0459O4BCHpj17
         M1orenLduATpPifHV2A5mPZQRJQN2AZvVGr1NNvXwGmgM1v7czpYB+H8FiNtza9GJSN3
         ZiUg==
X-Forwarded-Encrypted: i=1; AJvYcCXN2QKJdxpS2ugAKLxKlIn0LOhKYXHjfyHkmaN7/T+eYBXwPEqGnEnrdZ8XQhlyh8BNv6BuVBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy61CY/T8gpZKPZ5o4jOqZxFv94JZVih+PB+nOGpxv41nFgzICW
	1t211QQ2eHYabVC/QJb/6P4cDTfPPYKzmoqV0Ekb3g7hLfP778mVTQuc
X-Gm-Gg: AY/fxX7n3AIjcovCjnvVd5vS6GMuPWJX3hAfXD4KF+s28sI1p4ikDh0jWE6DJrB2uc0
	kutX+rjcMdu2FV4j3fON/9gkgO0biQsPNS5PhJ6VShAJrq0Ozf2Z/OWAe4tBOwOib6swLZ1FMTQ
	MsdMdTXDEBvtNPrs9HJKeHypLaYqFhCY0ZCWegwv8LxYMyNk0SIf7yBwBVNPQszk8iKNlyJU1FX
	HjcHkIeZ1+mjziJSWADIZBmTh7I157EU4N78t2qvvNICJRkakZX6CUHDL+vL7Hz3LUCOzhDQI0P
	JxLvWOGarp3iGksnx2Y1hbqgBTrXU+1XexChGgih/SA1+l6tf9oOOMr+g0iFBaB1WmLiMOKofZI
	4eoi9XnWPaeJXMH2nmbOTFuuZ4skYo6NrLwqifYMAqCPMZ1gVzzobMFV5rndw/6RzIOUB4ehqTH
	2zMryA5qwdriRU5Mq+lEnWiQ==
X-Google-Smtp-Source: AGHT+IHSjhEce/oXMOW5vM6ZF5lLLUz2/oBcTOMxDFFo21mOBhpjs2cfzbOckN+Zo7VcHVKH3Yx+8g==
X-Received: by 2002:a17:90b:2ccf:b0:340:cb18:922 with SMTP id 98e67ed59e1d1-34abd71f7e6mr19045388a91.14.1766027695922;
        Wed, 17 Dec 2025 19:14:55 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1d2d9ae134sm730773a12.1.2025.12.17.19.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 19:14:55 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 75FB1420A930; Thu, 18 Dec 2025 10:14:51 +0700 (WIB)
Date: Thu, 18 Dec 2025 10:14:51 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
	Linux Media <linux-media@vger.kernel.org>,
	linaro-mm-sig@lists.linaro.org, kasan-dev@googlegroups.com,
	Linux Virtualization <virtualization@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Network Bridge <bridge@lists.linux.dev>,
	Linux Networking <netdev@vger.kernel.org>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Dillon Varone <Dillon.Varone@amd.com>,
	George Shen <george.shen@amd.com>, Aric Cyr <aric.cyr@amd.com>,
	Cruise Hung <Cruise.Hung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Dominik Kaszewski <dominik.kaszewski@amd.com>,
	David Hildenbrand <david@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	"Nysal Jan K.A." <nysal@linux.ibm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexey Skidanov <alexey.skidanov@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Vitaly Wool <vitaly.wool@konsulko.se>,
	Harry Yoo <harry.yoo@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>,
	NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Ivan Lipski <ivan.lipski@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Lyude Paul <lyude@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Luben Tuikov <luben.tuikov@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Roopa Prabhu <roopa@cumulusnetworks.com>,
	Mao Zhu <zhumao001@208suo.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Jilin Yuan <yuanjilin@cdjrlc.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	George Anthony Vernon <contact@gvernon.com>
Subject: Re: [PATCH 00/14] Assorted kernel-doc fixes
Message-ID: <aUNxq6Xk2bGzeBVO@archie.me>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
 <20251216140857.77cf0fb3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V23DYTy9ofvlaB8B"
Content-Disposition: inline
In-Reply-To: <20251216140857.77cf0fb3@kernel.org>


--V23DYTy9ofvlaB8B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 02:08:57PM -0800, Jakub Kicinski wrote:
> On Mon, 15 Dec 2025 18:38:48 +0700 Bagas Sanjaya wrote:
> > Here are assorted kernel-doc fixes for 6.19 cycle. As the name
> > implies, for the merging strategy, the patches can be taken by
> > respective maintainers to appropriate fixes branches (targetting
> > 6.19 of course) (e.g. for mm it will be mm-hotfixes).
>=20
> Please submit just the relevant changes directly to respective
> subsystems. Maintainers don't have time to sort patches for you.
> You should know better.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--V23DYTy9ofvlaB8B
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaUNxpwAKCRD2uYlJVVFO
o1nDAP9D8xQeBKhU5vgUY1uZdEmdnOr8lzFR748Q3fszwHYA2AD+Lmk5pycZlTp2
pDdOJDlTqJohju9NNAPmvm1zT37zzwE=
=Ar/g
-----END PGP SIGNATURE-----

--V23DYTy9ofvlaB8B--

