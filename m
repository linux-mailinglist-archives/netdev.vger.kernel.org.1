Return-Path: <netdev+bounces-64977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED99838A29
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 10:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475711F2899B
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 09:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C2B58209;
	Tue, 23 Jan 2024 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/q+Llqu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0535812D;
	Tue, 23 Jan 2024 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001569; cv=none; b=UvBFGNTuBQxOrDvnPDujTHhIlcwK9PdN4I91pJm9Zmlc0z2B30ns/j9kzQRi+9IBUe17hgLS8a8k1X/FrzSu/O9i+TswH8z9P/w5vIL8oAdvg8yXpqcBYMIEGshcd+eV/LHUB/TA3RCtAUAKbUnh9JuXUBhkWgWee5lWEk6OB4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001569; c=relaxed/simple;
	bh=aD4SlO0Hu0Mw0mKb5dOzItJkI2KAfCmtVe2oegO3tLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8gJc/qTYBIs9fu0lEtGcTSBYpHXMfC/jyKBD9Pst36xv2LTBkfEx1eVYIC7YJdSEQYRG6coDIU9T7kalL35Y/5MkZGb7bpT3jjWGTAa/EF2U4WWDZfdNun6EhqhPoBDC123IK25gC+ORRAfYcteBrRsso/GD8YqKjFre+6nvaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/q+Llqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A03EC433C7;
	Tue, 23 Jan 2024 09:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706001568;
	bh=aD4SlO0Hu0Mw0mKb5dOzItJkI2KAfCmtVe2oegO3tLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z/q+Llqut5iXtP7BpwidsR6GcYZMozz4c5J1If8e/trDCO8vZBKITGwAJ6tgY+4Cq
	 7aFARNPvskdIG/cYDYBA+V57G1Of1v+C38mus57lcU7z+AdQn1ndrDiR4mXNwNrXF0
	 FTqu8HXmehMfWFvtcYdpXdH74ihzV9le08+Io1jDAsEinQbCkSiNKTW6Vzf75nOIO+
	 EJ1CfyPxHUDG0LG0FCf627ofEe/vOU5SjYzsKe/4n+h7mvUZ+QXAMH1ig8mWSeBU6s
	 KalNc7yX4+3hRGT7nra4KgefM4xljWJ0eyzZSDSXlZGYZHzSzdQx2qUz3YAGrCZdzm
	 GI4SGQv173kyQ==
Date: Tue, 23 Jan 2024 09:19:22 +0000
From: Simon Horman <horms@kernel.org>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	kernel@pengutronix.de, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: adin: add missing clock option
Message-ID: <20240123091922.GL126470@kernel.org>
References: <20240122110311.2725036-1-f.pfitzner@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122110311.2725036-1-f.pfitzner@pengutronix.de>

On Mon, Jan 22, 2024 at 12:03:12PM +0100, Fabian Pfitzner wrote:
> The GP_CLK pin on Adin1300 PHY's offers three different output clocks.
> This patch adds the missing 125MHz recovered clock option which is not
> yet availible in the driver.

nit: available

...

