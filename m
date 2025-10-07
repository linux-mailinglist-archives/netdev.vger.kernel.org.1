Return-Path: <netdev+bounces-228073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC12BBC0CD5
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 11:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35AB34E2B73
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 09:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9D62D3EE0;
	Tue,  7 Oct 2025 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+kmPj8Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EA525FA0A;
	Tue,  7 Oct 2025 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759827617; cv=none; b=AL7fh+PVs9g4iMRyeHYlGc56q4/+EbSDQ6GdO3EU7Iadb3MyE5VS6T/Pf0bLWBfseYdMEp52Q/asa8UOKRUGQLVOJBY91rp1nDOSbSyoQCUQuQyYG31HS4wJx8AoMZdPOndsSceLm2R4qft7yXY3A2xcRtcxbrmfKK3G3Hz5q10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759827617; c=relaxed/simple;
	bh=3bEjxxbLlRz2SL9DcgL5La+6IXRtFYGl8rSV52XWn3s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=glGhMLhSptrIiaNrC+IFpcxmg+CRh6m8BBsa3Kjt59yp+V7RmfgyWi2vCZAXOon9c5v30Hxtb8s8DvXsI9PjL+ZlkIlzPChMQV2UkPZyWYXe2YoyFvVSeG/1lvFLAhBIH2Y5GGWMS27GAYc6QIMvHvBxVTWNjkV9NJykVPT2hf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+kmPj8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BE7C4CEF1;
	Tue,  7 Oct 2025 09:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759827616;
	bh=3bEjxxbLlRz2SL9DcgL5La+6IXRtFYGl8rSV52XWn3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i+kmPj8QuUNfHD0j7GTVYkyYTntHx03rFuYsSViTNzU6ZrWHBmdZt4gth/T7sRugQ
	 utAZAAb4zLt0GmNc3MmqKB3g/p1zuGTHOxI3fMNkbvC+LMqCQzpS6IoEbTUQxTSOxi
	 YxOMeKWCH+0DPlgnip4JDLocClq7FULDEkaL2tlRp9C5HntWZyXWpyp7HVT+/ZqF2j
	 rBJeAaMnO/HzTDwNcpSxdpXMHToU/e8pMwMCZfqL+QHeSp/Jfige6RIPmbynrsEWK2
	 HymOkY22psuvhKz93tquryJr1qzht2nuOECLV8Sl2mmMwFcn3uYRIcxh/1YOyInxr5
	 MaFBgL92oKNlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FED39EFA5B;
	Tue,  7 Oct 2025 09:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mdio: mdio-i2c: Hold the i2c bus lock during
 smbus
 transactions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175982760601.1816219.15728598756858423622.git-patchwork-notify@kernel.org>
Date: Tue, 07 Oct 2025 09:00:06 +0000
References: <20251003070311.861135-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20251003070311.861135-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, f.fainelli@gmail.com,
 kory.maincent@bootlin.com, horms@kernel.org, romain.gantois@bootlin.com,
 kabel@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  3 Oct 2025 09:03:06 +0200 you wrote:
> When accessing an MDIO register using single-byte smbus accesses, we have to
> perform 2 consecutive operations targeting the same address,
> first accessing the MSB then the LSB of the 16 bit register:
> 
>   read_1_byte(addr); <- returns MSB of register at address 'addr'
>   read_1_byte(addr); <- returns LSB
> 
> [...]

Here is the summary with links:
  - [net] net: mdio: mdio-i2c: Hold the i2c bus lock during smbus transactions
    https://git.kernel.org/netdev/net/c/4dc8b26a3ac2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



