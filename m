Return-Path: <netdev+bounces-135670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8145099ED7C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CBA1F246B7
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F362B1FC7F6;
	Tue, 15 Oct 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcMAehVr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2881FC7F4;
	Tue, 15 Oct 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998922; cv=none; b=cQzds3H+JWBracPT/89GLKA0pC7g4Qnsa4fqj8dEzioIxwOaAvj3teijhPSGU4OuctYPQchpJdXO+rDNlJAI6Zq+2AKDIv9Aw/fNyXa+xWe+nINPHhmTNCOvpkNkfOKwI0x7TkBkwwDw/u9ZEh0o/Eib9X2XSs5N8s9/j3kWre8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998922; c=relaxed/simple;
	bh=rdqT2EodJ8Ix2L0ycX2C3KeM0vWWuvwqEUXf8iaIIFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mzk3hDkVwSaxc0ND088SdvtymAaeGVkRqFFAcUjgoZ6iSWggOo2m/mK6nxFldmpMATwST6R0+cjs5kUI/61IxJxAQnZDm6u2ZdSGGLga9S7TU3etVm8XeglrqLQdx2y7NXsALNzq8ty2N2JkF8vOSlPjbS9lAu0tt66mQiNlgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcMAehVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3714DC4CECE;
	Tue, 15 Oct 2024 13:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728998922;
	bh=rdqT2EodJ8Ix2L0ycX2C3KeM0vWWuvwqEUXf8iaIIFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pcMAehVrmQrOr67xvxzA41DHOblLu12fG/K3UcWXMxodrk1yE7iEnLsBaWeL8CMWh
	 CsiohzZg1OArfe2seH7VDk1UoIoVVB9h+HWLTDC49X5+H98/BsOMCI774bNZW1h0fv
	 RP7sdj5nPy8GQWokCx/COQVRzFodRlX5WOnOoMhWHUfgqLKlYZyhb/mXUx4ZRHgaxg
	 qmQntKlZh/+aHWaYfbWCzCPjqWj1VmUeNdMF3THMKV1577ZWyx8NAZ7vi5nb1B7duI
	 YWQRcc+I4sgR40e8s9JoTG3WkJaHbgfOaB4W201rnRkMNcW4kVh7R8V2ft58FPP+oF
	 7O3xaYxsjgNqQ==
Date: Tue, 15 Oct 2024 14:28:38 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>, thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: pse-pd: Fix out of bound for loop
Message-ID: <20241015132838.GB2162@kernel.org>
References: <20241015130255.125508-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015130255.125508-1-kory.maincent@bootlin.com>

On Tue, Oct 15, 2024 at 03:02:54PM +0200, Kory Maincent wrote:
> Adjust the loop limit to prevent out-of-bounds access when iterating over
> PI structures. The loop should not reach the index pcdev->nr_lines since
> we allocate exactly pcdev->nr_lines number of PI structures. This fix
> ensures proper bounds are maintained during iterations.
> 
> Fixes: 9be9567a7c59 ("net: pse-pd: Add support for PSE PIs")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Simon Horman <horms@kernel.org>


