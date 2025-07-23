Return-Path: <netdev+bounces-209548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A82FB0FD1D
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 00:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 158947A0542
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0529207E03;
	Wed, 23 Jul 2025 22:48:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailhost.m5p.com (mailhost.m5p.com [74.104.188.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F66238C23
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.104.188.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753310894; cv=none; b=e4Eg1OGfwN9/xN2ntz7xo3Vt0pkHloUvuVWIno8ntbx5eX9heYyLuaVvuL1dzhW0odo3n9RRDEZykwIgW5JsEjxA/sHYNnKfOajsol0pc8nTDfbWyMjNDfhVtUKrf69QVlruuLq8td6oRGLMp6yye2CQC3RDwe42D6XcUDEcMn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753310894; c=relaxed/simple;
	bh=dRaPk3sWONgPrGB9tTFvtZH4lss8wtSNuaTHZT9I79Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=donlDCghF9uy0rppZP6wbf6Nz0+LyP6Ju3/70yHl2IBp90FUPUk4Z57J6LJVWuVNJll+ig+EW3lRTxYbc0Kw1/zP0T86pRwRDRJahZTbvgcIrzOngckKe02uOLzm2Cm2ukQQDslqFoA2Au7OF8lol6KFek+tn8ymIX/t7D+TjyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m5p.com; spf=pass smtp.mailfrom=m5p.com; arc=none smtp.client-ip=74.104.188.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m5p.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m5p.com
Received: from m5p.com (mailhost.m5p.com [IPv6:2001:470:8ac4:0:0:0:0:f7])
	by mailhost.m5p.com (8.18.1/8.17.1) with ESMTPS id 56NMNxcg026016
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 23 Jul 2025 18:24:05 -0400 (EDT)
	(envelope-from ehem@m5p.com)
Received: (from ehem@localhost)
	by m5p.com (8.18.1/8.15.2/Submit) id 56NMNxDL026015;
	Wed, 23 Jul 2025 15:23:59 -0700 (PDT)
	(envelope-from ehem)
Date: Wed, 23 Jul 2025 15:23:59 -0700
From: Elliott Mitchell <ehem+xen@m5p.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Anthoine Bourgeois <anthoine.bourgeois@vates.tech>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] xen/netfront: Fix TX response spurious interrupts
Message-ID: <aIFg_yNVqTvrV6-k@mattapan.m5p.com>
References: <20250715160902.578844-2-anthoine.bourgeois@vates.tech>
 <20250717072951.3bc2122c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717072951.3bc2122c@kernel.org>

On Thu, Jul 17, 2025 at 07:29:51AM -0700, Jakub Kicinski wrote:
> On Tue, 15 Jul 2025 16:11:29 +0000 Anthoine Bourgeois wrote:
> > Fixes: b27d47950e48 ("xen/netfront: harden netfront against event channel storms")
> 
> Not entirely sure who you expect to apply this patch, but if networking
> then I wouldn't classify this is a fix. The "regression" happened 4
> years ago. And this patch doesn't seem to be tuning the logic added by
> the cited commit. I think this is an optimization, -next material, and
> therefore there should be no Fixes tag here. You can refer to the commit
> without the tag.

Sometimes the line between bugfix and optimization can be unclear.  To
me this qualifies as a bugfix since it results in non-zero values in
/sys/devices/vif-*/xenbus/spurious_events.  Spurious interrupts should
never occur, as such I would classify this as bug.

I do though think "Fixes: 0d160211965b" is more appropriate since that is
where the bug originates.  Commit b27d47950e48 merely caused the bug to
result in performance loss and trigger bug/attack detection flags.


-- 
(\___(\___(\______          --=> 8-) EHM <=--          ______/)___/)___/)
 \BS (    |         ehem+sigmsg@m5p.com  PGP 87145445         |    )   /
  \_CS\   |  _____  -O #include <stddisclaimer.h> O-   _____  |   /  _/
8A19\___\_|_/58D2 7E3D DDF4 7BA6 <-PGP-> 41D1 B375 37D0 8714\_|_/___/5445



