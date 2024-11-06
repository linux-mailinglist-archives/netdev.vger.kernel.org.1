Return-Path: <netdev+bounces-142479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DC09BF4D2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8281C2332F
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C47207A0F;
	Wed,  6 Nov 2024 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rB2SFywN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047AD2076C0
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916470; cv=none; b=lVYFB8jPaumnXTI2CIo41CU4fDs8/ecNd+rFIYcusmAiAZcQncT3IvCCtxLjhYaK6zQyNejahexpkUW6iJdPiI+e8w2AxLi6CY4CXpDsTACK9ShpNhW1+304BwjiIKjP0BNQH6heGNe5a21TvNlJvLKPUx7ISiM+VFYTovFh/JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916470; c=relaxed/simple;
	bh=1uN+lx6Q52xc7VqJJ2JnvkrNl+Bya2uyzQ2iOU/tpwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGslC1NrfMswZlaa2ObMLCdwoDTUYvgBL/RjL2SpvrEs1zWvUCR6kNvMunLn5crYY8tt1C4r5RmCwOlHAJB1fgK8zN+PdeH9SsUI3kO14YJVUukO4Opgd7nrPsKDaFbH5W5anDSa0SbZxHfP3Cb98b8syxd8Ce41llN/fgevCsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rB2SFywN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=W7tawP5tFd6bBBJus73Bue8aXadO8vvB9NMfmf+dK8o=; b=rB2SFywN4JMuKFYll/FwXj3mIY
	fq2ZXnziO9FwMuczpINddoJjLfqF+XfatPHQM4VAUVHmZhOTXljncGwDzreU/qOH5XDZbqrQM22Nn
	hiW4uQ2Y1B6zmU2CK8vFQz/MsRNL/c2REW+z3KLlcCqSjU4QanMs01FqT8p0FpW1vKE8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t8kRV-00CMis-PJ; Wed, 06 Nov 2024 19:07:45 +0100
Date: Wed, 6 Nov 2024 19:07:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: wojackbb@gmail.com
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com
Subject: Re: [PATCH] [net-next] net: wwan: t7xx: Change PM_AUTOSUSPEND_MS to
 5000
Message-ID: <eff354db-0ba4-421b-8ecf-a285ea7aab36@lunn.ch>
References: <20241106104005.337968-1-wojackbb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106104005.337968-1-wojackbb@gmail.com>

On Wed, Nov 06, 2024 at 06:40:05PM +0800, wojackbb@gmail.com wrote:
> From: Jack Wu <wojackbb@gmail.com>

FYI: The net-next should be inside the [] with PATCH:
[PATCH net-next]

Use --subject-prefix= with git format-patch.

You should also put the patch version in there:

[PATCH net-next v42]

	Andrew

