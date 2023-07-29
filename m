Return-Path: <netdev+bounces-22523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B9B767E64
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 13:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91A01C20A94
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 11:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAED14261;
	Sat, 29 Jul 2023 11:01:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1334F10F7
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 11:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36426C433C8;
	Sat, 29 Jul 2023 11:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690628497;
	bh=r4ub2sfb+3RGyLzoPfGridl9iQmattPqXfX7+exr16M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lGbKm1rMkfGoHjsONfO6cumIoG2Jf2qe4UP2rgQe6sDRG/jOdD/Kxr0mklt1tacfp
	 cXbPigsXbB8SsTDdNWosUXxHM2wv020pbiaVX72aIgHv+HsBczN4TVb22kItJIGWTI
	 H/LA7UYgfUbxyNHEKw7LbDxftDosNGj8zg2Q8AnM7c3IoB+jd2GSdF12UTrqzuUuuU
	 YRn+0u9j2QGiXBoTo9Fm+BnHHp6oc1C/51sAd+aIxSAMxsvt+XM46aI+KkeVOD7ZiJ
	 HfIkOOWjInK36k2T3kxTok9UIEW2viq4jeNhhXR2kT4p2xAFsAbuset+MaxswhAW+O
	 NY7MR7iQaS5Jw==
Date: Sat, 29 Jul 2023 13:01:32 +0200
From: Simon Horman <horms@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] net: dsa: microchip: KSZ9477 register regmap alignment
 to 32 bit boundaries
Message-ID: <ZMTxjP5dReD6+B3P@kernel.org>
References: <20230727081342.3828601-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727081342.3828601-1-lukma@denx.de>

On Thu, Jul 27, 2023 at 10:13:42AM +0200, Lukasz Majewski wrote:
> The commit (SHA1: 5c844d57aa7894154e49cf2fc648bfe2f1aefc1c) provided code
> to apply "Module 6: Certain PHY registers must be written as pairs instead
> of singly" errata for KSZ9477 as this chip for certain PHY registers
> (0xN120 to 0xN13F, N=1,2,3,4,5) must be accesses as 32 bit words instead
> of 16 or 8 bit access.
> Otherwise, adjacent registers (no matter if reserved or not) are
> overwritten with 0x0.
> 
> Without this patch some registers (e.g. 0x113c or 0x1134) required for 32
> bit access are out of valid regmap ranges.
> 
> As a result, following error is observed and KSZ9477 is not properly
> configured:
> 
> ksz-switch spi1.0: can't rmw 32bit reg 0x113c: -EIO
> ksz-switch spi1.0: can't rmw 32bit reg 0x1134: -EIO
> ksz-switch spi1.0 lan1 (uninitialized): failed to connect to PHY: -EIO
> ksz-switch spi1.0 lan1 (uninitialized): error -5 setting up PHY for tree 0, switch 0, port 0
> 
> 
> The solution is to modify regmap_reg_range to allow accesses with 4 bytes
> boundaries.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Simon Horman <horms@kernel.org>


