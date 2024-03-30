Return-Path: <netdev+bounces-83535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EBD892D97
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 23:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD34F1C20DE5
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 22:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F864AEFE;
	Sat, 30 Mar 2024 22:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WAQ3uGBN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C2641C93
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711836856; cv=none; b=ET1Z3thUny7dCCkpC8lbUebGMy5Plrtw6hvPlf/UJkksxBeLbmw1ghzEaCGB4mURAd074f3qtBzUYMarYvRF614ab6MmcXulApsm2/AWHxcSS4meNk4xemu+sLA9LGeMAe5fjb5xaN1coMfmUABfnU7im3jdIJCj5hwISMynSTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711836856; c=relaxed/simple;
	bh=htnwxaRYLoNkryWLJaBVSFOfS9tn6Oh5EBSghNzeRHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2reOn0VT70EDOh7dna04qpxZe84BLB7BiD9y/VeQ6ly9aFwPhVqy1eWaKESospD71beZBL20aEdIGypfjBPmMd5m04+WfJtonrC+U0P6N7eG8FeuxbCnVBE+GEUIlHWjCKZxDJEUKQTsJzVHLIsEGpD4f9dPMvsSvg7l/ZEbCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WAQ3uGBN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E3M9C94KlYgWkxVnJ7peUnv4RFU6IKeHU/i44aG+ovM=; b=WAQ3uGBNwM5q1A2jNEp8fqa4y4
	JAPFdkTelMrUfMAR1POls1sGXQYtQhs18rv/qsFXdzweD1Q+mSVouU8wxfgek9U/hyINTk4SSk4Kx
	yGhGJ2J93d1KR7+sE78wwu9AikmLOwitEiZB3TRceJ7vybO9GqK7qDxwvkkMuc+q6+TM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rqgxm-00BkRL-2u; Sat, 30 Mar 2024 23:14:10 +0100
Date: Sat, 30 Mar 2024 23:14:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	simon.horman@corigine.com, anthony.l.nguyen@intel.com,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	idosch@nvidia.com, przemyslaw.kitszel@intel.com,
	marcin.szycik@linux.intel.com
Subject: Re: [PATCH net-next 2/3] ethtool: Introduce max power support
Message-ID: <07572365-1c9f-4948-ad2f-4d56c6d4e4ab@lunn.ch>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
 <20240329092321.16843-3-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329092321.16843-3-wojciech.drewek@intel.com>

On Fri, Mar 29, 2024 at 10:23:20AM +0100, Wojciech Drewek wrote:
> Some modules use nonstandard power levels. Adjust ethtool
> module implementation to support new attributes that will allow user
> to change maximum power.
> 
> Add three new get attributes:
> ETHTOOL_A_MODULE_MAX_POWER_SET (used for set as well) - currently set
>   maximum power in the cage
> ETHTOOL_A_MODULE_MIN_POWER_ALLOWED - minimum power allowed in the
>   cage reported by device
> ETHTOOL_A_MODULE_MAX_POWER_ALLOWED - maximum power allowed in the
>   cage reported by device

I'm confused. The cage has two power pins, if you look at the table
here:

https://www.embrionix.com/resource/how-to-design-with-video-SFP

There is VccT and VccR. I would expect there is a power regulator
supplying these pins. By default, you can draw 1W from that
regulator. The board however might be designed to support more power,
so those regulators could supply more power. And the board has also
been designed to dump the heat if more power is consumed.

So, ETHTOOL_A_MODULE_MIN_POWER_ALLOWED is about the minimum power that
regulator can supply? Does that make any sense?

ETHTOOL_A_MODULE_MAX_POWER_ALLOWED is about the maximum power the
regulator can supply and the cooling system can dump heat?

Then what does ETHTOOL_A_MODULE_MAX_POWER_SET mean? power in the cage?
The cage is passive. It does not consume power. It is the module which
does. Is this telling the module it can consume up to this amount of
power?

	Andrew

