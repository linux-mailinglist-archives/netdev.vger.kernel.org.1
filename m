Return-Path: <netdev+bounces-210856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E28B15215
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 19:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29AD27B081C
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089311DE4C3;
	Tue, 29 Jul 2025 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aGvb/i+J"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481E24A0C
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753810296; cv=none; b=hIGuhTz5rtGHDJDS8bGnyr+nv1NwwNkRLMtxr+/kG0Xkko27uuM/A3z6WK11m2YS9UmphZsOdoxstWTAR3HbuR7nskv2X5DBU+BH96C8RtsAcijwi1rAVtp4009z9j+sO94jKdpuFP4+MHCbZtDQ7pg0eTsc0zkEXf+LYevRbRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753810296; c=relaxed/simple;
	bh=y3bpG+sPzl/fFFBwcwLlONLSVo3kcxpCx4UijUP30lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aw0fTwnuboEPkQ/c7I3Ol9dv8x8s7k3m98QFzKg5OswJzXGsmKONSXx/eMp6J9yJjRr9Ig6KTkD9TyGciLiCNHVd8rV1g52Na6CxkDAiTLtjah/3CguUovEWbnYiDl6k7BnhHDrI+lORkWBkyl41QEfJSSZ2gSVzIi0sy3sRgXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aGvb/i+J; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aKSxifxHJIONDr0VjJJF1bsS+31GhF1VK0dWldW+/t4=; b=aGvb/i+J7eQlpUuA5uH9y3LVox
	/Pkdq0soFJwPFlloCPNVy6qQbb8d1+SS/1r3kTbncqkcIENqPABuZqVl9EFrbg0ESJH+tWRt+4pu+
	aBJwkXm3EFOsVLMoGINPaiD5KWIyVrXzHFOMayInCmr1E9ph6gi1Gj7EUbZ3+w5q9JQw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugoAa-003DW2-PA; Tue, 29 Jul 2025 19:31:20 +0200
Date: Tue, 29 Jul 2025 19:31:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	intel-wired-lan@lists.osuosl.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [RFC PATCH] ethtool: add FEC bins histogramm report
Message-ID: <c52af63b-1350-4574-874e-7d6c41bc615d@lunn.ch>
References: <20250729102354.771859-1-vadfed@meta.com>
 <982c780a-1ff1-4d79-9104-c61605c7e802@lunn.ch>
 <1a7f0aa0-47ae-4936-9e55-576cdf71f4cc@linux.dev>
 <9c1c8db9-b283-4097-bb3f-db4a295de2a5@lunn.ch>
 <4270ff14-06cd-4a78-afe7-1aa5f254ebb6@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4270ff14-06cd-4a78-afe7-1aa5f254ebb6@linux.dev>

> The only one bin will have negative value is the one to signal the end
> of the list of the bins, which is not actually put into netlink message.
> It actually better to change spec to have unsigned values, I believe.

Can any of these NICs send runt packets? Can any send packets without
an ethernet header and FCS?

Seems to me, the bin (0,0) is meaningless, so can could be considered
the end marker. You then have unsigned everywhere, keeping it KISS.

	Andrew

