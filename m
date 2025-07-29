Return-Path: <netdev+bounces-210810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8673DB14EB3
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 15:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F4617CA1B
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217E1433D9;
	Tue, 29 Jul 2025 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZnEcNsLQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386031758B
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796932; cv=none; b=Zouo5eItyPqHs39KEII3vEMxhNZppU1srcXM7otzP/pXaRDMivIA6qME1opBT+pojyipuBEBDD4Hpqd3Oih28BlWgjCyg8Rp0UIcbgBWWSMq+B72b4pBujD8SF6aC9GJV6D+qJTobFx+TjUFkbPciHM3Cep2mZ8tgjrJ6X47O+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796932; c=relaxed/simple;
	bh=2e+RPRHeTVz50khmU6T7cO+VIeMn86gRpZfYACqnkKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZqVIdrEG0P4ieyMCG8jeqjZ5dgM9I/srGLOBAVoQpbudFe6nxJJzy4S8lg1Ep4TPQVsMr5/9Br7DlAZ5EW3PtXOTy3L99epH20k2Mlo5Z3CV7Ftem7eornbl9kqo6bRoVHWIQTaZvwH9eEM3gY68CEn8MC0mWCtFpGY3O6Y0/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZnEcNsLQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hGDwxRqu2TQfpwBCrX29WUZRJA0tBu5dVT8LhjMjgZo=; b=ZnEcNsLQzbJb8K9hzFKYK3h+dx
	XGq6q0s2eFNfYn+DRd2HIJIRxe9LjSESrva4iga7P4+pvF0cCAUHKXDG0nMAWyGvuKogWVNaT7brc
	VlwJ2P2HTG1NZvX34+CpgdXKaquUKMEzuZGJfdU5ax0zYcMi79FyciWn9ZIYb2Ypjt30=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugkh0-003CKK-56; Tue, 29 Jul 2025 15:48:34 +0200
Date: Tue, 29 Jul 2025 15:48:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	intel-wired-lan@lists.osuosl.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [RFC PATCH] ethtool: add FEC bins histogramm report
Message-ID: <982c780a-1ff1-4d79-9104-c61605c7e802@lunn.ch>
References: <20250729102354.771859-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729102354.771859-1-vadfed@meta.com>

> +        name: fec-hist-bin-low
> +        type: s32

Signed 32 bit

> +struct ethtool_fec_hist_range {
> +	s16 low;

Signed 16 bit.

> +		if (nla_put_u32(skb, ETHTOOL_A_FEC_STAT_FEC_HIST_BIN_LOW,
> +				ranges[i].low) ||

Unsigned 32 bit.

Could we have some consistency with the types.

	Andrew

