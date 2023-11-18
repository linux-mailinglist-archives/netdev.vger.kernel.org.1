Return-Path: <netdev+bounces-48866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C636F7EFCA4
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 01:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EBC1C20AAD
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 00:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75999A38;
	Sat, 18 Nov 2023 00:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiRkNMZE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573B1809;
	Sat, 18 Nov 2023 00:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6F8C433C7;
	Sat, 18 Nov 2023 00:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700267981;
	bh=Je/ApF2K7SYvSPIxFVB5Me2FUgzHHhsUTSYdaPeNC2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IiRkNMZEHCZKk9mAEgz3XMwp/Kpr1kMZDf5cAY6rG5HeZZDPzixvMd8qR6Fj8xuFD
	 cZqwHUjLKhh2b1MGD4eETVLU/2Bchjyb1yqxJL0X4/cf16yqpnAN3AcaURv+uNDNNa
	 T/6M6T/aO9SSqKVhXMXSTjgy5BCB3CIRQut3i0KoAllyNEh+d6BhNb0dfKCGv+GbsF
	 r6Qp0qCQ7GaWaPnhc2x5B4L0eSzAT1mWQ1HIiAgGoN9AQRC4invZO4owDjYwXRSfpw
	 0JWb7TKjy3qlzWhfyvOxzr6FqW759agQIXUTWV0my+k4T2//Lx1iLWA66ymCW5pgx8
	 7djxeRIbw8KmQ==
Date: Fri, 17 Nov 2023 16:39:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: leit@meta.com
Cc: Jonathan Corbet <corbet@lwn.net>, Breno Leitao <leitao@debian.org>,
 netdev@vger.kernel.org, donald.hunter@gmail.com, linux-doc@vger.kernel.org,
 pabeni@redhat.com, edumazet@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Document each netlink family
Message-ID: <20231117163939.2de33e83@kernel.org>
In-Reply-To: <87y1ew6n4x.fsf@meer.lwn.net>
References: <20231113202936.242308-1-leitao@debian.org>
	<87y1ew6n4x.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Nov 2023 15:17:02 -0700 Jonathan Corbet wrote:
> In principle I like this approach better.  There is one problem, though:
> 
> - In current kernels, on my machine, "make htmldocs" when nothing has
>   changed takes about 6s to complete.
> 
> - With this patch applied, it takes a little over 5 *minutes*.
> 
> Without having delved into it too far, I am guessing that the
> unconditional recreation of the netlink RST files is causing the rebuild
> of much of the documentation.  Even so, I don't quite get it.
> 
> That, clearly, would need to be fixed before this can go in.

FWIW on the C code-gen side we avoid touching the files if nothing
changed both at the Makefile level:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/tools/net/ynl/generated/Makefile#n28

And the tool itself actually generates to a tempfile and compares
if the output changed:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=2b7ac0c87d985c92e519995853c52b9649ea4b07

