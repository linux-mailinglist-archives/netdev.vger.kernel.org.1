Return-Path: <netdev+bounces-202177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D991EAEC887
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 18:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51AC9189E8B9
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0762512EF;
	Sat, 28 Jun 2025 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="VK1gFjsN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DDE253941
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751126730; cv=none; b=OylTiqpN7o7q5UGL6tRnUM1G37ilzdPi1I41iFZqvbBLmgIYjgbbkWkfOsFqDrp4BkfIcHsaj7GLUTaBgMKHebQxpU7hZn0VjRTMNrrbD/iswmNw4Xe/i+0/85ijtmZbGQS09hOKamgGhaQrpt3ML2yZwaXu+ftZ8QdlNbVPyG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751126730; c=relaxed/simple;
	bh=IYQnZ0xX+BmakKQBYlECXS9SG5XXZLN/8mo9eMtZm7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d74MYFHK4voJ/ITPLC6XNFwcaJZA2rVUs4rRHvVzdZhZGdXhwntK8bDmwtm7CoGM094zFndmigy+wnm50jMgaTyqy0bOgwG+hqs3kM6o0t9oDoCi5mjCQPQZeuVDhsIR3kmhc8KgCbxhRIZWa71EDxG2ZZTLRq3zIJkZhjzTiPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=VK1gFjsN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-312f53d0609so384471a91.1
        for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751126728; x=1751731528; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6aezSHN45uDXxhfwLny8MywH/f96jqDnbUNyp4IJzeo=;
        b=VK1gFjsN03MgAsOAuDi+0tOTbBLRbPYjfZQ7Ye/zLcbRMpnG2VFdmt0zD6UnrfYiMf
         +gp9Wjdnv/6wt6Z4enmdLdOOYsJ1CR3c6kfB0VQU47gnStONZBdf81AXbFBLAAs1k2sm
         F+ZIeG+zBjLyJaC7URuXjE+rg5NhoZMBomYfzR0CjzlM1ytmNe3uWsDGnSIunDJ7vEu3
         Vbt8JL6+IXV669/3fW2/pqCuWrKneHclaHNuxlLBekkxtrJXfu0bqO02ZFBtCkXR5tWI
         ER5BsHiZnEaeMpYJQSBTrTCRU2EIPI67CMCfcHpKWFhSnVangkcP3cbei10Q6D+EhsO1
         lCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751126728; x=1751731528;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6aezSHN45uDXxhfwLny8MywH/f96jqDnbUNyp4IJzeo=;
        b=nt4myhO5Yl8eG1oizjK0NGtSfPZhdG9tGEVA8h48/PUIZcIQBrhGjGNdJTRY+RxqkY
         fUCVMd1rPk/s8vjVByw544e7cYKQ+52MCyFv0/KgLz6D27le2+z5EULfidgkvzqFXgyv
         j+9dl0QPZkKWwMYQbdQ8vdr0xU1CCNKI/hOKeZB+5Z+JS5h3UMYh3FVCSZGDIjITNynl
         KZY6wwZkXfxlaIVFG/2fTkRYcFtMztZXCmO/B12F3V1ytnJSS03c0+cldfo+kS+pUIt0
         v4MzlI7bY4jmcYCCg05nq+y+NSFX69oBsLDov+VqllIeCAg5ANsRSRjO7nTfC4/Yo8hU
         CMSw==
X-Forwarded-Encrypted: i=1; AJvYcCUsLIoH6IZv0oQE8HQxPKP/37AlEPBJJN0G6XRC1FR1yrzK7or3n5Wd+HbgH17v5tSatuSu18s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXAAOIwebORFfTWD5Ie1cYRxoDT2WfhdAn7on7xhabcSsOVgMY
	3rX9t0LDTTBbVrIiuO2CGbnhR4CIKI169uKi5/DJV4YA9eTFXxQ2SKKRIYGsU6kN1Ss=
X-Gm-Gg: ASbGnctTzkUbwDZ6L5lXUHVvIB+oR77O/ZcVTWaSpfnGz2qp1DfYVMfeUOrEIms+gs0
	tnm5j7rs9MsK2S+TpD8+swbexYY5dmWU1Gf/k2n5wkwyof2a+kKPk9XkeaK8BEGrD1MQLuk82ue
	nMCZw3Owrc0RMjwvLOtpjNtZubMZ0om/y+iY3oSNyrOLMGJkjpBrRL98zggFCfyynTNb6qzOxdB
	mETberhl9TRl+IFKcVEA0kFMME6V5VG+OuhR5KQ95negItdUzR1lxw3TBQvt0SK81mqqpxhcoOT
	D6MJeB43uug8WF2tq59xA81UUueIrXTAMqIgnAWmZ7PpTXo=
X-Google-Smtp-Source: AGHT+IHYYhe26HLPNKoBVcnNOy6/jkpQn8WfKdz60I6/TVd500pn0InVU9KvudOTGbI9ixjvqF8axQ==
X-Received: by 2002:a05:6a20:258b:b0:1f0:d1b3:7b39 with SMTP id adf61e73a8af0-220b050049cmr2367369637.1.1751126728462;
        Sat, 28 Jun 2025 09:05:28 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:c6fe:2091:41f:3e3f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af55786efsm4894673b3a.82.2025.06.28.09.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 09:05:28 -0700 (PDT)
Date: Sat, 28 Jun 2025 09:05:24 -0700
From: Jordan Rife <jordan@jrife.io>
To: Kyle Evans <kevans@freebsd.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com, 
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RESEND PATCH v1 wireguard-tools] ipc: linux: Support
 incremental allowed ips updates
Message-ID: <hxqd4mhg6wir7oaatgtdshimtzdwkhlhdje2xet7mcj25g7zzt@jyhmin2ovram>
References: <20250517192955.594735-1-jordan@jrife.io>
 <aCzirk7xt3K-5_ql@zx2c4.com>
 <aCzvxmD5eHRTIoAF@zx2c4.com>
 <vq4hbaffjqdgdvzszf5j56mikssy2v2qtqn2s5vxap3q5gi4kz@ydrbhsdfeocr>
 <CAHmME9rbRpNZ1pP-y_=EzPxRMqBbPobjpBazec+swr+2wwDCWg@mail.gmail.com>
 <d309fd3a-daf1-4fd5-98aa-2920f50146fd@FreeBSD.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d309fd3a-daf1-4fd5-98aa-2920f50146fd@FreeBSD.org>

On Wed, Jun 25, 2025 at 10:37:55PM -0500, Kyle Evans wrote:
> On 5/21/25 18:51, Jason A. Donenfeld wrote:
> > On Thu, May 22, 2025 at 1:02 AM Jordan Rife <jordan@jrife.io> wrote:
> > > > > Merged here:
> > > > > https://git.zx2c4.com/wireguard-tools/commit/?id=0788f90810efde88cfa07ed96e7eca77c7f2eedd
> > > > > 
> > > > > With a followup here:
> > > > > https://git.zx2c4.com/wireguard-tools/commit/?id=dce8ac6e2fa30f8b07e84859f244f81b3c6b2353
> > > > 
> > > > Also,
> > > > https://git.zx2c4.com/wireguard-go/commit/?id=256bcbd70d5b4eaae2a9f21a9889498c0f89041c
> > > 
> > > Nice, cool to see this extended to wireguard-go as well. As a follow up,
> > > I was planning to also create a patch for golang.zx2c4.com/wireguard/wgctrl
> > > so the feature can be used from there too.
> > 
> > Wonderful, please do! Looking forward to merging that.
> > 
> > There's already an open PR in FreeBSD too.
> 
> FreeBSD support landed as of:
> 
> https://cgit.freebsd.org/src/commit/?id=f6d9e22982a
> 
> It will be available in FreeBSD 15.0 and probably 14.4 (to be released next
> year) as well.  I have pushed a branch, ke/fbsd_aip, to the wireguard-tools
> repository for your consideration.
> 
> Aside: this is a really neat feature.
> 
> Thanks!
> 
> Kyle Evans

That's great news. It's nice to see this feature percolating through
the WireGuard ecosystem.

I was working on adding support for direct IP removal to wgctrl-go too,
a Go library for controlling WireGuard devices:

https://github.com/WireGuard/wgctrl-go/pull/156

While I'm at it, I'll try to add native support for IP removal on
FreeBSD if I can get a dev build working with the latest and greatest
( I am a FreeBSD noob :) ).

Jordan


