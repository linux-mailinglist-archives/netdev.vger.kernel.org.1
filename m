Return-Path: <netdev+bounces-31067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE6678B38E
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 16:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E97D280E21
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 14:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9267712B80;
	Mon, 28 Aug 2023 14:48:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FFE46AB;
	Mon, 28 Aug 2023 14:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB70FC433C7;
	Mon, 28 Aug 2023 14:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693234108;
	bh=bEnsuBETn363kdOAj68YWRCqUeK+MuT2Lu1pkca8XRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dUZ8/LByqntr2tsVN3+hzMy3MXE4ExGMkJf2S1gxNPOJBCWNIJLmlk93FGkHw5iJS
	 3BStSz4CRnb47eTxGOQzCbvBNRVd3rCCuXm6VIurlFwiMlgcYACMCmB/GOOJA8Akk5
	 37Cq9ky6/N3JuU+bTizb7zqicev6e4c/AHHtaFIhADf4wFF3KlO3d8v3Gqv9SrUtUr
	 Ksl/rxUfrJOubX22WAVMMWMIxdwY80yNFLgNeh8gwlvKWjgk1KOkV8xSYNvBOlsk2S
	 WkebQCcASNoN/LjJCyqkSIEq+agb3F8N1LVXUn59QlqOOR635Nc7hDySv6IO0dfyVM
	 R786iZCVzYg8A==
Date: Mon, 28 Aug 2023 07:48:26 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: clang-built-linux <llvm@lists.linux.dev>,
	linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>
Subject: Re: clang: net: qed_main.c:1227:3: error: 'snprintf' will always be
 truncated; specified size is 16, but format string expands to at least 18
 [-Werror,-Wfortify-source]
Message-ID: <20230828144826.GA3359762@dev-arch.thelio-3990X>
References: <CA+G9fYscGFiG1TVLyfETVu3NV5BAe8sCOXRGDnky-w31aB6yVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYscGFiG1TVLyfETVu3NV5BAe8sCOXRGDnky-w31aB6yVQ@mail.gmail.com>

Hi Naresh,

On Mon, Aug 28, 2023 at 05:57:38PM +0530, Naresh Kamboju wrote:
> [My two cents]
> 
> stable-rc linux-6.1.y and linux-6.4.y x86 clang-nightly builds fail with
> following warnings / errors.
> 
> Build errors:
> --------------
> drivers/net/ethernet/qlogic/qed/qed_main.c:1227:3: error: 'snprintf'
> will always be truncated; specified size is 16, but format string
> expands to at least 18 [-Werror,-Wfortify-source]
>  1227 |                 snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
>       |                 ^
> 1 error generated.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thank you as always for the report. This is a result of a change in
clang to implement the equivalent of GCC's -Wformat-truncation, which is
currently disabled for the whole kernel in mainline and enabled in W=1
in -next. I have filed an issue to figure out what to do about this:
https://github.com/ClangBuiltLinux/linux/issues/1923

For the record, if you see an issue with clang-nightly that you do not
see with older versions of clang, it is generally an indication that
something has changed on the toolchain side, so it is probably not worth
bothering the stable or subsystem folks with the initial report.
Consider just messaging Nick, myself, and llvm@lists.linux.dev in those
cases so we can pre-triage and bring other folks in as necessary.

That said, this seems like a legitimate warning. As I mentioned above,
GCC shows the same warning with W=1 in -next, so this should be fixed.

  drivers/net/ethernet/qlogic/qed/qed_main.c: In function 'qed_slowpath_start':
  drivers/net/ethernet/qlogic/qed/qed_main.c:1218:63: error: '%02x' directive output truncated writing 2 bytes into a region of size 1 [-Werror=format-truncation=]
   1218 |                 snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
        |                                                               ^~~~
  In function 'qed_slowpath_wq_start',
      inlined from 'qed_slowpath_start' at drivers/net/ethernet/qlogic/qed/qed_main.c:1250:6:
  drivers/net/ethernet/qlogic/qed/qed_main.c:1218:43: note: directive argument in the range [0, 255]
   1218 |                 snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
        |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/net/ethernet/qlogic/qed/qed_main.c:1218:17: note: 'snprintf' output 18 bytes into a destination of size 16
   1218 |                 snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1219 |                          cdev->pdev->bus->number,
        |                          ~~~~~~~~~~~~~~~~~~~~~~~~
   1220 |                          PCI_SLOT(cdev->pdev->devfn), hwfn->abs_pf_id);
        |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Cheers,
Nathan

