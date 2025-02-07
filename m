Return-Path: <netdev+bounces-163908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816B9A2BFF4
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C52188C0CD
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4E61DC184;
	Fri,  7 Feb 2025 09:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h65NkVK5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CCE19ABBB
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921999; cv=none; b=tPba0qJBo7QLLb/lpkjGreaJC6XJo9XUfeS6uTZOtY72htZPb5X4vIN3F7rGcKUKFhgX2+iBIJam1+QTZvhLpQsVm92G/vkO2Gm4ld4BZhOBwqZkChTiijMNIICqJW0X11Bk4YqByCF8Msevf6jtCiuRvhoobwWk5AdVMcfk3Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921999; c=relaxed/simple;
	bh=zEp8Uxkr84jq3Q1p4fuCS7o83LuStOvmC/R8ERMZGxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8oGJx4KqGhA0lBy+4ibIIfwMhQ+zRgZ4fX7sRKm7PlQwh7gKID5iCug5fCTfc0JAkaOtEWZWmP+RJzdeyhKSmZ7bY03dR8amlwmKRZtrEK8o/vzCyyn4LInYZj/rjykJ0S6QL8TxDzNc5sfP7mKcViDDZQ4XYE54mCnF4TN1cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h65NkVK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7681C4CED6;
	Fri,  7 Feb 2025 09:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738921998;
	bh=zEp8Uxkr84jq3Q1p4fuCS7o83LuStOvmC/R8ERMZGxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h65NkVK5Sp2r9IKWzJJR3f1XO8G+XYPs83bRVyFqsYjzfz7s+dgHdtyr5ppzOckSe
	 j+WL3TW2yCTHmjdNvZSR8Z/rPq/ZpGOaBMkXcmfUe8gkgv7N1aQ2IxmA4Xohd8pdXF
	 qXIJac7YXGSI6w6BT6VdY5GyDLh5unxKyDRfP+v2ksXxMEtEOmjvbkubOwDwNyDKNF
	 liqhL7Of8oF7L+3kjLNpjbqo2feit6fJ2h8NLs+tTzPNIB+M9Qf5caYYqWFu5vzqyR
	 q59BSO22lvNJ2rO3855//6Pbh1FdKhCtAUkPPkecPyXR+EST4JujjF2Bvn0yNkEPCK
	 G8xQKQuPWAxQQ==
Date: Fri, 7 Feb 2025 09:53:13 +0000
From: Simon Horman <horms@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH net-next v2 6/7] net: ethernet: actions: Use
 of_get_available_child_by_name()
Message-ID: <20250207095313.GH554665@kernel.org>
References: <20250205124235.53285-1-biju.das.jz@bp.renesas.com>
 <20250205124235.53285-7-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205124235.53285-7-biju.das.jz@bp.renesas.com>

On Wed, Feb 05, 2025 at 12:42:26PM +0000, Biju Das wrote:
> Use the helper of_get_available_child_by_name() to simplify
> owl_emac_mdio_init().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> previous v2->v2:
>  * Dropped using _free().
> v1-> previous v2:
>  * Dropped duplicate mdio_node declaration.

Reviewed-by: Simon Horman <horms@kernel.org>


