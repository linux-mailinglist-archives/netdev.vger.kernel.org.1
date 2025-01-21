Return-Path: <netdev+bounces-159889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED070A1753E
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 01:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13D33A3089
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 00:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BF68C1F;
	Tue, 21 Jan 2025 00:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNjKlELI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF98D139B;
	Tue, 21 Jan 2025 00:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737419688; cv=none; b=TNEoqZgx1Cmy+cqvPgQ2mhVmHQLQN9joXPE07tCksGz8g/2Na8VI8hQ8tDsxtsj+ETvxal9Dg9/Z1grdLHLOvG694k45GPFKWuHphw98rtya30FfAOogTwi5vM7X/AB6iPVY0u2DI8NfPD5iEgU+Eq+y/ai5qbg9ACPSlb4E62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737419688; c=relaxed/simple;
	bh=uG04OFncj0TWsbeTomoONMWNUr/b/CK+1d1OfCOIKHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bs6s192mHDv4c9CPQWn4YF1ZSd2SP9nBYmNpeAQPzVvqeGxaVg+qOrq7YO6IfjUiDeQI0TrFAk1hAPk7VWQCYGycrthC591KkGx0Y/84c/4xgc3yEHq/V1BI4YT7EGNAJQdm7HO5USLgHbAFiOeVRa2zijllh923uzDX8nRpvbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNjKlELI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D503C4CEDD;
	Tue, 21 Jan 2025 00:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737419688;
	bh=uG04OFncj0TWsbeTomoONMWNUr/b/CK+1d1OfCOIKHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QNjKlELIq0dllSAVACSuHPzzX2edEtQ0IlpQrKDD/l64lr/f+ItjakPSCRsVPP5TP
	 bslwd5SAhU6Jo8mI5EZRUN38rnQUApHaQBshpD472WeSwemBNlEBeee7jmRzCS62i8
	 8Clt5L7/vXAS8tJ3VodBLloZcNiDXgEip4tXcb9rRtYZyNwK4ywS8m//skUYEz8cse
	 hPUaf65QmO2QJtcpT4/idExMeq1v37Nk+HJwkxRRgv5+OL0zFA/eLkKYlXiESKzQ+O
	 6uTWAJh7QliBiCo4NI2CjtXw94wc9nCkCQAJ4ukoqVyxBk5+fJNp+6+ImFxW5e9cTq
	 a9r3aYV2+yWlQ==
Date: Mon, 20 Jan 2025 16:34:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dimitri Fedrau via B4 Relay
 <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Cc: dimitri.fedrau@liebherr.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew
 Davis <afd@ti.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Florian
 Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Dimitri Fedrau
 <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v2 0/3] net: phy: dp83822: Add support for
 changing the transmit amplitude voltage
Message-ID: <20250120163446.3bd93e30@kernel.org>
In-Reply-To: <20250120-dp83822-tx-swing-v2-0-07c99dc42627@liebherr.com>
References: <20250120-dp83822-tx-swing-v2-0-07c99dc42627@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jan 2025 14:50:20 +0100 Dimitri Fedrau via B4 Relay wrote:
> Add support for changing the transmit amplitude voltage in 100BASE-TX mode.
> Add support for configuration via DT.

## Form letter - net-next-closed

The merge window for v6.14 has begun. Therefore net-next is closed
for new drivers, features, code refactoring and optimizations. 
We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 3rd.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


