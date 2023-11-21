Return-Path: <netdev+bounces-49833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E127F3A0E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 00:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18902829E3
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 23:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D89F54BFF;
	Tue, 21 Nov 2023 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPficb9h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4D654BF6
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 23:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57535C433C7;
	Tue, 21 Nov 2023 23:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700608140;
	bh=qBLKfkbkagbdBbl6e0aA2LHfmNjL2L1x6etHid+StRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WPficb9hFbv57jkbne0ldlaIiOnFY9BJwatJstHDqOTvAu8cnx4xrLqY87ObZH3E+
	 3xMpYQP2cUgqRYRVRQ8rIzZYBCTV5kmJCVCLc1hbo+z4cePu5gvr4aYpAcd7wePho8
	 skLQrVM41tGzuI/DE2vHdbYq9/C6N0uvQ/ZQeeUa3IqF2juxa8/c7h+IV11lsgwLMc
	 vTkPDPAon7dUReZR75aVjy3Vp1y2P1P1osbp7CaTU44JN2mATJj9ZnYB8Uu3UUXMdH
	 I5F/z112G27jBLetkyoAtUacNZgf6U4D9zKw4OnGBWEEIob4drB4VHwJh4yRsmjYno
	 gd8FydaASHrXA==
Date: Tue, 21 Nov 2023 15:08:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Robert Marko <robimarko@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [net-next PATCH] net: phy: aquantia: make mailbox interface4
 lsw addr mask more specific
Message-ID: <20231121150859.7f934627@kernel.org>
In-Reply-To: <20231120193504.5922-1-ansuelsmth@gmail.com>
References: <20231120193504.5922-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 20:35:04 +0100 Christian Marangi wrote:
> It seems some arch (s390) require a more specific mask for FIELD_PREP
> and doesn't like using GENMASK(15, 2) for u16 values.
> 
> Fix the compilation error by adding the additional mask for the BITS
> that the PHY ignore and AND the passed addr with the real mask that the
> PHY will parse for the mailbox interface 4 addr to make sure extra
> values are correctly removed.

Ah. Um. Pff. Erm. I'm not sure.

Endianness is not my strong suit but this code:

	/* PHY expect addr in LE */
	addr = (__force u32)cpu_to_le32(addr); 

	/* ... use (u16)(addr)       */
	/* ... use (u16)(addr >> 16) */

does not make sense to me.

You're operating on register values here, there is no endian.
Endian only exists when you store or load from memory. IOW, this:

	addr = 0x12345678;
	print((u16)addr);
	print(addr >> 16);

will print the same exact thing regardless of the CPU endian.

Why did you put the byte swap in there?
-- 
pw-bot: cr

