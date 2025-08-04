Return-Path: <netdev+bounces-211550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2BBB1A0E3
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6C4C7AB9A0
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 12:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45552550D0;
	Mon,  4 Aug 2025 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="JTWZJXoX"
X-Original-To: netdev@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D914EC62;
	Mon,  4 Aug 2025 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309488; cv=none; b=MNg9PT2pOVZ64cRQV2X/XBdKnxxa5mXrX04lTN8NkGIiDLjyf5Y5893itXSwJhLUYD7fvYu22cfASZtAh8KryxFXVa53QxQm7zHyCu0i/uqPIyQ3b3ULz5/USrb9rSfAohH8wMcPUDAvSbinIoyM7COZYFd7xdfv3im+2N9G2q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309488; c=relaxed/simple;
	bh=YozG6mEOkKlwR8zGGPhdu3m0vp2+uyk6f8GTDTU8/1Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ggNm8MTgKb5GDew6wCc3Ax8T89y0qmYVVayG5GoqaD4sF4Zl5/5WbAiudv92Od0NySQE+Ee8fLLEP0LZdJEUQHb2rPNpRPgCfaORRNuTRbDMsgT/iatgT8M2hIZgCptxuVug1nDP5DhD+zt4XNmRoE5BUNR3ESu6hiToEaBnJ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=JTWZJXoX; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=r+sFWZsYp3owZfeTAxKfIpJrMKc9GV8YM3WJhCJkKiY=;
  b=JTWZJXoXcBi8Sxht9tS03XL6m0k1Kz5NiBp6IYO6BlFe42Zfsb9CF6hF
   vSNRs6XxY9auBooSV4TempgWPbtZsO3t4SoPe0wilRRLKuXJGkXDsePtQ
   sQb81BI5Eht6EJurhuUa9r+AInLetw/cyvG+PcMheRESvjBU/cm8e4/mS
   s=;
X-CSE-ConnectionGUID: FCqmenQoSmuYigrwtWF8Lg==
X-CSE-MsgGUID: WQWXpB40QBCjo9Ax58RjoQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="234106081"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 14:10:15 +0200
Date: Mon, 4 Aug 2025 14:10:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Jakub Kicinski <kuba@kernel.org>
cc: MD Danish Anwar <danishanwar@ti.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
    Andrew Lunn <andrew+netdev@lunn.ch>, 
    Mengyuan Lou <mengyuanlou@net-swift.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, Fan Gong <gongfan1@huawei.com>, 
    Lee Trager <lee@trager.us>, Lorenzo Bianconi <lorenzo@kernel.org>, 
    Geert Uytterhoeven <geert+renesas@glider.be>, 
    Lukas Bulwahn <lukas.bulwahn@redhat.com>, 
    Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
    netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, cocci@inria.fr, 
    Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [cocci] [PATCH net-next 1/5] net: rpmsg-eth: Add Documentation
 for RPMSG-ETH Driver
In-Reply-To: <20250723064901.0b7ec997@kernel.org>
Message-ID: <1bf7c9-d394-7519-795b-c8d455ee9d0@inria.fr>
References: <20250723080322.3047826-1-danishanwar@ti.com> <20250723080322.3047826-2-danishanwar@ti.com> <20250723064901.0b7ec997@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 23 Jul 2025, Jakub Kicinski wrote:

> On Wed, 23 Jul 2025 13:33:18 +0530 MD Danish Anwar wrote:
> > +   - Vendors must ensure the magic number matches the value expected by the
> > +     Linux driver (see the `RPMSG_ETH_SHM_MAGIC_NUM` macro in the driver
> > +     source).
>
> For some reason this trips up make coccicheck:
>
> EXN: Failure("unexpected paren order") in /home/cocci/testing/Documentation/networking/device_drivers/ethernet/rpmsg_eth.rst
>
> If I replace the brackets with a comma it works:
>
>    - Vendors must ensure the magic number matches the value expected by the
>      Linux driver, see the `RPMSG_ETH_SHM_MAGIC_NUM` macro in the driver
>      source.
>
> Could you make that change in the next revision to avoid the problem?
>
> Julia, is there an easy way to make coccinelle ignore files which
> don't end with .c or .h when using --use-patch-diff ?

Perhaps not.  I can adjust it.

julia

