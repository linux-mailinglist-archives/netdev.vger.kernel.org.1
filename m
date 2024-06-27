Return-Path: <netdev+bounces-107395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6468D91AC97
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E027FB24D6B
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E781199399;
	Thu, 27 Jun 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="im0tGkJ4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA7C199395
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505529; cv=none; b=P+8IAMYNQorNM5m2b8YW5iJwZFea1KoToV+ZyIsMsomNq/WKvBEW6LhBrA9apulxLNiIxfxOypSsqeHOEVqgvJNgQ0UUKmyi5A9gP5GeC7R37yP4IRmUNER02dxzISN2UrL/m15Z8pg5FA1sOlT7DIrnMiDyrFspLoi+P3dPt5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505529; c=relaxed/simple;
	bh=I18LG0K6yB7LNva46isy5nFCld1KGxxx9UBc2WuG83Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3GbHXHBP8EkcMU9tjLl61/JxjLipJpkRshAfQgO6TpA+CiCLq2a+Rgl5y9+KTzZCaJ59EGh68/FnGaWKMaL5JvLrsEhLD09LFtbRXWsUU5Ub5mEglXb1dyuVlINSc98xprLsOxMo3xepEtPU+iwrA6KoT/SAkOD7wJPC51ZpTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=im0tGkJ4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rqXMVmTJVc8DXgV4lz/kT3t9nrtsrb9vG7WkjmnMQDM=; b=im0tGkJ4nmODst7LOojnVIYdDt
	np4Ku3D3wBzJzQlj71hpKerVICtAQH1KojcbmACAg86t94KQhCe91Kt+W69YzRF3XX4QfPbDurXTt
	GLVHho5RCEOBgO2QRl00C8+Or0q8U826q7DaHozYlcLvLC9Ocp/W0mG0Ky0vsdXqSaTA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMrw5-001Bcy-Fh; Thu, 27 Jun 2024 18:25:25 +0200
Date: Thu, 27 Jun 2024 18:25:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, sd@queasysnail.net
Subject: Re: [PATCH net-next v5 24/25] ovpn: add basic ethtool support
Message-ID: <47e77cd0-96d1-4b0c-bdce-9dd1f4c4370f@lunn.ch>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-25-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627130843.21042-25-antonio@openvpn.net>

On Thu, Jun 27, 2024 at 03:08:42PM +0200, Antonio Quartulli wrote:
> Implement support for basic ethtool functionality.
> 
> Note that ovpn is a virtual device driver, therefore
> various ethtool APIs are just not meaningful and thus
> not implemented.
> 
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

