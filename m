Return-Path: <netdev+bounces-158056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B7DA1047B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 11:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EA6168E47
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 10:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EA41ADC88;
	Tue, 14 Jan 2025 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jt0ZRjQT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C306229603
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736851310; cv=none; b=EDmWx6YOt3wIdNQgN4+0SqIvkr+JvZ4G5hQqQbMBbr8cxrukeLiYMCgvjEt+xLULkCq+yDkcaXncxZPgfXFsebjUbPNmIW7d8+gnVLjMK9Rrwx8ar0/Y+rcYmqutLeV1szGn1tdYQ6rSY7Tf4WJEXxVw25pbVQfNkb1/IyYilM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736851310; c=relaxed/simple;
	bh=wcEFphIjxnw5Q2XGWbpoCAd4fCnTIzkN9hi0YaN8r0I=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=qZ14iedzMhB0q2csPUXGaJSP3xf8tiUycwVVCoHHV4ce3m18+1H6zTkxFSOINf3EduFTIp49IysdKNCBY34b/TwxH9dOIwrAi12FlsbGVGQM/NiJJrT9462Npl5SEXoSCSHyT+vdj1a+7eUVnUfjC1XiSXugHH5aMkNo9k+DAn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jt0ZRjQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA9DC4CEDD;
	Tue, 14 Jan 2025 10:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736851310;
	bh=wcEFphIjxnw5Q2XGWbpoCAd4fCnTIzkN9hi0YaN8r0I=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jt0ZRjQTxUud9krtklbUHGacZv4PsrA30vEChfK9keJ+zCfD8nONL5YVQKhBDsQEA
	 ut8jJQ96l+tZVMZLeO/XFE1QPTDUHgg8U6SLbF+ZODAFbeynaKL89G3mWQ5SQb/Tnc
	 GALWEwlAY+VZUe9N5Yd3pkVm9xrWa2IMi0IjEaFnQajOohoovOfiZr80yAlp4Dw/hg
	 DJMcZpuDZDDP4LBIRcQjvb+0XXwMNw/M9kEf8m9We5GmLw4fC7hdSEnCspA2sC80zH
	 FbaPt6NNBVrGrwYTMfACaz9m+z2hj8bKo4BKW4tsUWSfxtkMgWJmp5UKhMVEXeuwtX
	 3d+DXagUUXPGw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8a1835db-b72c-4e9d-64e8-0bfffae2d8c8@gmail.com>
References: <20250113161842.134350-1-atenart@kernel.org> <8a1835db-b72c-4e9d-64e8-0bfffae2d8c8@gmail.com>
Subject: Re: [PATCH net] net: avoid race between device unregistration and set_channels
From: Antoine Tenart <atenart@kernel.org>
Cc: netdev@vger.kernel.org
To: Edward Cree <ecree.xilinx@gmail.com>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Tue, 14 Jan 2025 11:41:46 +0100
Message-ID: <173685130626.5893.2031391323809340270@kwain>

Quoting Edward Cree (2025-01-14 11:09:07)
> On 13/01/2025 16:18, Antoine Tenart wrote:
> > This is because unregister_netdevice_many_notify might run before
> > set_channels (both are under rtnl). When that happens, the rss lock is
> > being destroyed before being used again. Fix this by destroying the rss
> > lock in run_todo, outside an rtnl lock section and after all references
> > to net devices are gone.
>=20
> The latter (refs gone) being the important part?  Doesn't seem
>  particularly relevant that we've dropped rtnl, this wording had me
>  confused for a little while as to why this closed the race.

Both are important as being outside the rtnl lock section means
set_channels had a chance to run, and waiting for refs that it
completed. Well, otherwise there would be a deadlock, so maybe this is a
superfluous detail after all.

> > Note that allowing to run set_channels after the rtnl section of the
> > unregistration path should be fine as it still runs before the
> > destructors (thanks to refcount). This patch does not change that.
> >=20
> > Fixes: 87925151191b ("net: ethtool: add a mutex protecting RSS contexts=
")
> > Cc: Edward Cree <ecree.xilinx@gmail.com>
> > Signed-off-by: Antoine Tenart <atenart@kernel.org>
>=20
> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

Thanks!

