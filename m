Return-Path: <netdev+bounces-157486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFB8A0A6DA
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 02:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21ED43A8C16
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 01:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498727482;
	Sun, 12 Jan 2025 01:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpreGqEi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F5A6FB0
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 01:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736645850; cv=none; b=hpExdJCyi0jvux1gLPiCNm19P0OV8DSCF1nPWPdLTJoP/kjTnHZzCCo7bDAffULlLKtbWB6MZv76H1akmdtif3Vrtodj4u28zgX/FIjkSuMCKQNfX+csYylsIDUH38XyoCV7bxApL1NJwx7GCMDSSTt7M4HjDkzFhLKmagalaD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736645850; c=relaxed/simple;
	bh=CB2pDfSzG2YTW3WNtDhAosllucRgmsnMXM84/8wPPCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FnU5sjxFrqj71+Cic9sv00wBggr0Uoy291M3ifmJZkhBiRfW0DEj3HfDPnvUnutq4GveRMfEthBcg1/vgZ9WGz5IiGmGz5/WmjbdAZxeQXkM5z/LNAM5FTgw6WckbKqw8z6MYmjmP4G9nxTLLIihBguD625So6zH75t8Soz2mnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpreGqEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416C4C4CEE1;
	Sun, 12 Jan 2025 01:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736645849;
	bh=CB2pDfSzG2YTW3WNtDhAosllucRgmsnMXM84/8wPPCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UpreGqEi6efAxzyaw6cCLe9AjTNJ8++SGSa9CU1SftzEhE9nVpTKmFotCjo1xQ8IZ
	 BGDbo7cDpfqxhvcECXr9rgLCgsgCmn/daR35kv9r9Iold7JKrrv0e5EtfwwijNuJbq
	 JRCghfKmsKEAIvmnU0YgmXPGXmUdJk+A+nyEBssdH2TMBFGPN0hxm/E4tf28p+UoJZ
	 Xp6yK8NrwcSopxtdT/8Lev5O7Fh+zT6nw6sD+POQOdLBjRYW1w6BRYLq89+roYyNNW
	 FQUo2lbJiuFmxT3CQPC8w1pfPjHvyaSjQSzIi6Qa5zE8+D6qHak6/z3rl1R/8OV9py
	 eSSLepn7S/tqA==
Date: Sat, 11 Jan 2025 17:37:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Andrew
 Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@armlinux.org.uk>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 04/10] net: phy: c45: improve handling of
 disabled EEE modes in ethtool functions
Message-ID: <20250111173728.78984988@kernel.org>
In-Reply-To: <d8d0b779-4127-4b36-80ee-6256ba425244@gmail.com>
References: <90b3fbda-1cb7-4072-912c-b03bf542dcdb@gmail.com>
	<d8d0b779-4127-4b36-80ee-6256ba425244@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 21:28:32 +0100 Heiner Kallweit wrote:
> +				NL_SET_ERR_MSG(data->extack,
> +					       "Requested EEE advertisement includes disabled modes\n");

nit: coccicheck says:

drivers/net/phy/phy-c45.c:1551:12-67: WARNING avoid newline at end of message in NL_SET_ERR_MSG
-- 
pw-bot: cr

