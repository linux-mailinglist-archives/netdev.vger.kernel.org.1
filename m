Return-Path: <netdev+bounces-135090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A54299C2D9
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6911C237B0
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7B914B077;
	Mon, 14 Oct 2024 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq14tKIv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DED149E17;
	Mon, 14 Oct 2024 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893909; cv=none; b=hM7/qJOiHihHbeXAZmGFwvWh8VOdmlhf8XIBCEVDtGw5PJ64AaNbsByQKzMh/oMa2IXJhAnXGYOM0jz0AmsovH41LUhrV9XYjwRWsJzM+SE4TGQp8JL5nv77fLkMthGdwLrkgA95YCx3nacFS+orXPAq5vvnzyMSwaqG+PdvxNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893909; c=relaxed/simple;
	bh=WSG6JKOrpz//yHgEJmqYwVlan1AwfYYChHInmnQGJWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThHHEdyZsSEU+82KR4YX73LkUOmIuuORpeT0ELfYatviSlZHcT3dsB2y8P7Zopyjzd7I/zY92z19RzDfwTGiDgt8L0kETPuzjaCJSeLBusdHpD78iYmN7XOVvaREPa6vdBOzKYE1Vtmo642YjVsR7w1DnQqszfEbAYago6UMXHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kq14tKIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A04EC4CEC7;
	Mon, 14 Oct 2024 08:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728893909;
	bh=WSG6JKOrpz//yHgEJmqYwVlan1AwfYYChHInmnQGJWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kq14tKIvdRmlqZXLADeTGOPOPtBpwWU/YWA8URdTeOFBla9CtDT8grK/h1Yyv5Cja
	 hDfBL1aVogMWZumJzicbQ2bHE9a7NWgnFTGUzAtOb8hXIHqampAsO/SjDYPIFiZvNV
	 d+t7v/5p6+JTrCc8fMNIY28ISzY0lQCEtGSYc7C5M56HTvU5LjQGPffMdYMmHa59bv
	 dd43wfIL3XvMJ7PQjqJzZUnYD4t6ptLIQLZlHTjHKqC5KEjbFCv4LskEX6TGB/q1Q/
	 zqqvFhAoq9wi3SS8/7iBZXYEr7Ew2X8yXzMk183jqVxfUt3qudmGuNI8HFKYd9b0hT
	 2Z37ZDBiRR/fA==
Date: Mon, 14 Oct 2024 09:18:23 +0100
From: Simon Horman <horms@kernel.org>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next 1/1] net: phy: Refactor mediatek-ge-soc.c for
 clarity and correctness
Message-ID: <20241014081823.GL77519@kernel.org>
References: <20241014040521.24949-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014040521.24949-1-SkyLake.Huang@mediatek.com>

On Mon, Oct 14, 2024 at 12:05:21PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patch does the following clean-up:
> 1. Fix spelling errors and rearrange variables with reverse
>    Xmas tree order.
> 2. Shrink mtk-ge-soc.c line wrapping to 80 characters.
> 3. Propagate error code correctly in cal_cycle().
> 4. Fix some functions with FIELD_PREP()/FIELD_GET().
> 5. Remove unnecessary outer parens of supported_triggers var.
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
> ---
> This patch is derived from Message ID:
> 20241004102413.5838-9-SkyLake.Huang@mediatek.com

Hi Sky,

I think this patch is trying to do two many things (at least 5 are listed
above). Please consider breaking this up into separate patches, perhaps
one for each of the points above.

Also, I think it would be best to drop the following changes unless you are
touching those lines for some other reason [1] or are preparing to do so:

* xmas tree
* 80 character lines
* parentheses updates

[1] https://docs.kernel.org/process/maintainer-netdev.html#clean-up-patches

