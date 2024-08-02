Return-Path: <netdev+bounces-115176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3F09455DA
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 03:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8621C229C3
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 01:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6351DB64E;
	Fri,  2 Aug 2024 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwZ6KwkE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ADB79F0;
	Fri,  2 Aug 2024 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722560757; cv=none; b=M70XKADiFaowSgRh+WFf6Qe+2sR3R9Ad+ir0fAV8pgzlbFMTffnjgIMGptKXzruoC9iCm9nFKpsC+iWZ/s31erOpFj3JmuJy3Ccu1WwZE1bOrUG8hTQhU0c8wWv7sW61B7Tc11Poz1Ft5mcqj/UVZq2RgkyWTFmJ1oomf87/9L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722560757; c=relaxed/simple;
	bh=2mwYyhkU30rp319Zf+mdK+V+198EOpziGcGwd9FpZRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uiQAz/Aa+sPpjF76f+ObS5Sur2noywGQgavhum1AHjoXZ2Jb/TESn7izvZq/paxQ/fJCfnVS7LYrVp8z9ncvhHzzcoXarNYG0n4h/4Sfc/5OIVdAmmHbwIsx+s4d5WGRKj2TYpwP1KqbnMhG3Yrz+Y4AH7AdXTwX3TC8sXIIbE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwZ6KwkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3145C32786;
	Fri,  2 Aug 2024 01:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722560757;
	bh=2mwYyhkU30rp319Zf+mdK+V+198EOpziGcGwd9FpZRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZwZ6KwkEKg48Ul5i5Yp5BLPMub/MqhQy+GX9pssrM1hPK7Ba/4R+9KRPRa05Dv9b2
	 7ym9TrgBAJmcxcdMFsSa1LuFJbMfuA6J2mRjP6tSm6+6jcvUTY8Sbpz5PWKu11qAa+
	 36f1Bvfh4E+AYUgP404PTbnmxcU0Xll1thHDnZ5j5Lu3ATlaZv5DRe9jVQa4XFZOkO
	 J3gKW8FHyEBvX9QfyaRT1jIEC3ovCefdchzAsYaxyq7ti8FxjAIJHUC/vnNam/CDPN
	 M0z3vXEuIIG88P2kGkG3c8FOL8LcYW3BVn1VwIBRGzCYkB5ud2OIA6/PITOPlZNq4S
	 kWUa4GTPySvpA==
Date: Thu, 1 Aug 2024 18:05:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>, John Wang
 <wangzq.jn@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mctp: Consistent peer address handling
 in ioctl tag allocation
Message-ID: <20240801180555.0a72859e@kernel.org>
In-Reply-To: <2fde081adb2352e613ae33536363f284f1b46f32.camel@codeconstruct.com.au>
References: <20240730084636.184140-1-wangzhiqiang02@ieisystem.com>
	<20240801085744.1713e8b5@kernel.org>
	<2fde081adb2352e613ae33536363f284f1b46f32.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 Aug 2024 08:21:46 +0800 Jeremy Kerr wrote:
> > Looks sane. Jeremy? Matt?  
> 
> All looks good to me!
> 
> Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>

Thanks!

> (John had already discussed the change with us, so no surprises on my
> side)
> 
> > In netdev we try to review patches within 24-48 hours.
> > You have willingly boarded this crazy train.. :)  
> 
> Yeah we bought express tickets to netdev town! I just saw that there
> were nipa warnings on patchwork, so was waiting on a v3. If it's okay
> as-is, I'm happy for a merge.

It has quite a few false-positives (especially from the in-tree tools
like checkpatch and get_maintainer).

