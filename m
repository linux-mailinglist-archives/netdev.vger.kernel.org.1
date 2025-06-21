Return-Path: <netdev+bounces-200002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB451AE2AFF
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 20:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E7F3B22E1
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 18:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E34265CC9;
	Sat, 21 Jun 2025 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1BkUFFy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997817736;
	Sat, 21 Jun 2025 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750529411; cv=none; b=J8LS+xpoRb4UopUppVCHRX9IWI5KYhI7ptFSYF5wVBbFhG2NN4ZGGkOc0IUmoNvE7vZnePoHo/oRMT6eInrOyV+dtFyrM+YXpGPIcKWrs0g4FFUUFBxQ/dOEgeRRolsV2hUuR6jpgMhkNCZWbuHvFZ9dvIYzMBBKYlKHnIz0P2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750529411; c=relaxed/simple;
	bh=wTNYiG61KbGanukYQezT3m/T+uZtYtfau85/Ayhj85Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI9DaxDcRwAlK3IAWHv8quO3oTKvofmvolRSrdgbbBwsoSMC5uSvAWfWKSF45vEMjKEN1khndCRvQKU/+ZkmHgK+csWDr1Tzv8egyWNXsWvyZj0a+JETqI3esF9Z4EoBSACEWqZ9km3/vq9ElhpABcXewx5/GsO2PN1ryasucVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1BkUFFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BA6C4CEE7;
	Sat, 21 Jun 2025 18:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750529410;
	bh=wTNYiG61KbGanukYQezT3m/T+uZtYtfau85/Ayhj85Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1BkUFFyeEjb0zdbQ7qInFp2RZJj7m5C6g8wq/fbNMJS5zEG7Aft1H0p0e4MF+gvd
	 QtKxCqoH/kZrOmdHiXCBbZX86v8GZ0pmMiN+dnUo2VQuclNIZDsaR/nABFiBoLY+S7
	 zITWLKZl9GfhJelv6VbAPGzdyGWOST7HSShXsnOsqM6GXIAgJp8lilXUHGg3idLSlG
	 riouGMioga4ow9exGIe7eYCd1PxkaVzfRS/RkYmJX59t6O/pbuNdoIxAjje48YbxhU
	 OOSf1xEze/aSOv4E7U7WAPrpn06R+pnGrQ8IhsDpTKiR1bPLRGxqaVRHaRCwpT6NOK
	 DNoIXUsWSW7Jw==
Date: Sat, 21 Jun 2025 19:10:05 +0100
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Netdev <netdev@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] myri10ge: avoid uninitialized variable use
Message-ID: <20250621181005.GF71935@horms.kernel.org>
References: <20250620112633.3505634-1-arnd@kernel.org>
 <20250621074915.GG9190@horms.kernel.org>
 <75623e39-14da-4e4d-8129-790ed08b66ae@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75623e39-14da-4e4d-8129-790ed08b66ae@app.fastmail.com>

On Sat, Jun 21, 2025 at 11:21:09AM +0200, Arnd Bergmann wrote:
> On Sat, Jun 21, 2025, at 09:49, Simon Horman wrote:
> > On Fri, Jun 20, 2025 at 01:26:28PM +0200, Arnd Bergmann wrote:
> >> 
> >> It would be nice to understand how to make other compilers catch this as
> >> well, but for the moment I'll just shut up the warning by fixing the
> >> undefined behavior in this driver.
> >> 
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Hi Arnd,
> >
> > That is a lovely mess.
> >
> > Curiously I was not able to reproduce this on s390 with gcc 10.5.0.
> > Perhaps I needed to try harder. Or perhaps the detection is specific to a
> > very narrow set of GCC versions.
> 
> I was using my gcc binaries from
> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/arm64/10.5.0/
> but more likely this is kernel configuration specific than the exact
> toolchain version.
> 
> The warning clearly depends on the myri10ge_send_cmd() function getting
> inlined into the caller, and inlining is highly configuration specific.
> 
> See https://pastebin.com/T23wHkCx for the .config I used to produce
> this.

Thanks Arnd.

FWIIW, I was also using the above mentioned toolchain. But with allmodconfig.
Now I'm using the config at the link above I see the warnings too.

In any case, it seems pretty clear to me from looking at the code that your
analysis is correct. The mystery to me is why it isn't more widely
detected by tooling.

> 
> > Regardless I agree with your analysis, but I wonder if the following is
> > also needed so that .data0, 1 and 2 are always initialised when used.
> 
> Right, I stopped adding initializations when all the warnings were
> gone, so I missed the ones you found. ;-)

I thought that might have happened :)

> I've integrated your changes now, let me know if I should resend it
> right away, or you want to play around with that .config some more
> first and reproduce the warning.

Feel free to post whenever you are ready.

