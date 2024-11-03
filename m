Return-Path: <netdev+bounces-141377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CDA9BA99E
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 00:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352EA1C20D2D
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8535018CC19;
	Sun,  3 Nov 2024 23:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JO7Frlxp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF5C18C03C;
	Sun,  3 Nov 2024 23:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730677507; cv=none; b=X0Bi4B6NDoqA9hv9ERUX2LMkztOXAWdx+LjRQLsayI+kRYKDa5x+H7fjXqb5mjQyrdjsnWbuO2EpB82Fj8ZunygpgihNsCUbfNdQWO9S2a2JhF3I4m7OjKSdU4uyEbDK6ASigB7jlP942z0UShIq2xiq9XMTbzF4Jv9dCrdcXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730677507; c=relaxed/simple;
	bh=jUwKuVv/zqbbEyV5GPik7fpLp2h4WYi3/vQjohJrDCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+s7Hq6fHHHEefGn0k+w8hvhskcEK8DORFnDwZUaR8EXyYm7L2PawidyehP3SwS9rU8ZO+iB6wJYd2K++wQ/fWgs2sfcriEzENohu3X+slV1lk1h0gXsi1x9+tC/xGgSSGBEcbD2t78C6Mvpgtxkh1c7XpM4UPmSGYzRiQRJ3xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JO7Frlxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52478C4CECD;
	Sun,  3 Nov 2024 23:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730677506;
	bh=jUwKuVv/zqbbEyV5GPik7fpLp2h4WYi3/vQjohJrDCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JO7Frlxp+UCmvs10bRseyO5sa8wSExhKKJ1Bn6sBMBivDRjr5oOBAnDPENyaLzzr/
	 hEZGshUaU4S1JwwQ0U0NvkBNhIcUleBSusvyJRsz4P1m5FDVtuDYaTjQZXBsbzSWXg
	 BfYPFirUt5DQnN+ottqqpCzjjjW0O4oo/0DjvgXkXQ2bgmdNhOtWuVPEMrlQ461AhI
	 y3hJT3nMHHXuHabdNNhURtJpWTtd7L9gj3NrLoQ/JEoQhUF4oJJ7dRD0VoknlBhd1Y
	 4rplH0cx6BJK3FyneO/Fn44/YVCwIEG1uAqzbqGa1j7ZySb3MoVG44D838HDPLDmkK
	 sA/NwTmc6gU/g==
Date: Sun, 3 Nov 2024 15:45:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, havasi@efr.de
Subject: Re: [PATCH net-next v1] net: macb: avoid redundant lookup for
 "mdio" child node in MDIO setup
Message-ID: <20241103154505.686e9009@kernel.org>
In-Reply-To: <20241030085224.2632426-1-o.rempel@pengutronix.de>
References: <20241030085224.2632426-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 09:52:24 +0100 Oleksij Rempel wrote:
> Pass the "mdio" child node directly to `macb_mdiobus_register` to avoid
> performing the node lookup twice.

Applied, thanks.

