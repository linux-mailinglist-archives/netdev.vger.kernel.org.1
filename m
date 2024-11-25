Return-Path: <netdev+bounces-147121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF179D7955
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 01:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D11B2128F
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 00:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1044624;
	Mon, 25 Nov 2024 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chibgOME"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93258383;
	Mon, 25 Nov 2024 00:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732494861; cv=none; b=DaLQQy2xkLeIFeogBert3akgC8BoXYA2L6Ch3U3LdQRoIRGH+BKDRU/1vnp/BMOQI+oAZFLErtwNhBaESBkDP1u38wh5CVPZP0rfwgpiNqNYSVLxsmTS1zajENLpfcLHv8hc3NuY6q/wHZMcE9qmW4qxCWwKskUA31R07HSDBWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732494861; c=relaxed/simple;
	bh=DcK+pncfX4NLcE3dPlnE4kiw2u4zkosRKrNme8jPgBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTjsus9PP1ogUCeXypwcYufuZJXHCYySG7qf+kb8RW3KhlkGLdpi2DPp8Gly9l4477YRffLcHylM9FT3vKz7Tpxf74rzwY+6iZKtUXBx7/2Nu8sKMJx8w0liPKC2dXOfnpKowv1Lvf1FqWvWIW3CqekTCXNXmdPMbvK3XhvvQ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chibgOME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58352C4CECC;
	Mon, 25 Nov 2024 00:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732494860;
	bh=DcK+pncfX4NLcE3dPlnE4kiw2u4zkosRKrNme8jPgBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=chibgOME2vWqb6tmjch5NAUbqhkIlORaDPZ/jOoHgtSPVWB3WMo6XScfTsTzbNDLH
	 Bo7qYZ2pkucWtb071iF8P1i9EKp0BCDwcNQRPW1MH1o+H900t54VVi+ZVe9ZdVy/BV
	 Oq/hJrQdA+RoaYTsJ7JH26kFKBpwHjW7QVCQNP1QKbXj0YdQq4JiDxAwVqy6L3j5yw
	 qY+8fjRzWFv83jon4ZCyU0zZNBf/mNmLhn65dA2Tk4sxfmWJhokOber8VX4cauSeC7
	 zwm8ypff6pi3k8vWJELcMwR/5OpVfYxcOdbNQKP/65c+knY979QR68EvVM4eS7t6v2
	 MziIrg9796GoA==
Date: Sun, 24 Nov 2024 16:34:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Woojung Huh
 <woojung.huh@microchip.com>, Arun Ramadoss <arun.ramadoss@microchip.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Yuiko Oshino <yuiko.oshino@microchip.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com, Phil Elwell
 <phil@raspberrypi.org>
Subject: Re: [PATCH net v1 1/1] net: phy: microchip: Reset LAN88xx PHY to
 ensure clean link state on LAN7800/7850
Message-ID: <20241124163418.7d97a19b@kernel.org>
In-Reply-To: <20241117102147.1688991-1-o.rempel@pengutronix.de>
References: <20241117102147.1688991-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 11:21:47 +0100 Oleksij Rempel wrote:
> +	/* Reset PHY, otherwise MII_LPA will provide outdated information.
> +	 * This issue is reproducible only with after parallel detection
> +	 * where link partner do not supports auto-negotiation.

sorry for late nit, the comment needs a bit better grammar

	 * This issue is reproducible only with after parallel detection
	                                   ^^^^^^^^^^ ?
	 * where link partner do not supports auto-negotiation.
                              ^^^^^^^^^^^^^^^
	                      does not support ?
-- 
pw-bot: cr

