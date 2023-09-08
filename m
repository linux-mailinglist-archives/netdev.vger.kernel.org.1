Return-Path: <netdev+bounces-32598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC01A798A1D
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 17:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD7B281AE9
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 15:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B028F514;
	Fri,  8 Sep 2023 15:41:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9976AA2
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 15:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D87C433C9;
	Fri,  8 Sep 2023 15:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694187670;
	bh=3BXc76kIRMFjhnOaKfVYbjrmTmRwWhcVytEgALnadJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JcKpgVjD/cf2ND/B2QxKZSbgci1Akt7SrzFTW1aEzPN0e8JRXPKGzeyWIAU69dOuK
	 9uc1fzd6fZM3ypJ4ODlTJYhtaOxusCa6QVVk8ZR0rTwKY9GX5agjq7HCRLUsRwBmtA
	 K9zFOe3Bq9e+F3R9Zqir7b8EVhbMR01UPPBYGCWtUc3Fba/B3/NAtpHdRLIIijduoz
	 zKefNCBK94i+O6fqvjXL+nWf9fntYpSlGzJmoiXvIJd6drxAh0YMFRHvXY6ls8uDn4
	 AR7HZJa9KHHADu7Dy0+IBUvoBRmlaKDhJqqJbEYdjU7tKurInQlMzBvmSwqxbdYeQY
	 rCqa7Jm5EGCug==
Date: Fri, 8 Sep 2023 08:41:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Oleksij Rempel <linux@rempel-privat.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 0/7] net: phy: introduce phy numbering
Message-ID: <20230908084108.36d0e23c@kernel.org>
In-Reply-To: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Sep 2023 11:23:58 +0200 Maxime Chevallier wrote:
>  - the netlink API would need polishing, I struggle a bit with finding
>    the correct netlink design pattern to return variale-length list of u32.

Think of them as a list, not an array.

Dump them one by one, don't try to wrap them in any way:
https://docs.kernel.org/next/userspace-api/netlink/specs.html#multi-attr-arrays
People have tried other things in the past:
https://docs.kernel.org/next/userspace-api/netlink/genetlink-legacy.html#attribute-type-nests
but in the end they add constraints and pain for little benefit.

