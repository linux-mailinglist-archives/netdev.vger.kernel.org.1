Return-Path: <netdev+bounces-201271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047B8AE8B20
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 19:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A5B3B4728
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0BA2D9EE2;
	Wed, 25 Jun 2025 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLSr3Sod"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767AD1D63F8;
	Wed, 25 Jun 2025 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870854; cv=none; b=R/ItAU5fikrRuvbpup5EAIH6cQBdqTuczMb+TvgAAnoig9ugxd8hadD3wQa53SRKa0r6DUpif9feA1ZSNYUirYaexTd/WHr5tEkBHwfzPyBTtgKk56XW9L0pujo6yV/K+zn0ZwS+9lg//Ss8OcQ3ENaWMPNwXeTOoNi6F4QGTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870854; c=relaxed/simple;
	bh=sV4Z0ubPWbCvivHS7xiJTDANUW3GSypskarbYGUfU5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GV1NqQhavFqvliM2GUpcxe0CofJgMllDdUpuHyxiV5in4YVOZE2PBtThx10QZW6lHRTtsYWCgOsnLGYjvII10bh1hHYZsknrNS8VoAMLZYQsmgft7Y7CZQI8rg2dfCfA9RPsAMjuSc6RKoQsvvXOVq4OJXiwKJX2f7J4q3x0Sjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLSr3Sod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180A5C4CEEA;
	Wed, 25 Jun 2025 17:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750870854;
	bh=sV4Z0ubPWbCvivHS7xiJTDANUW3GSypskarbYGUfU5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vLSr3SodfBFHXLPE0oP7krUvDl54AWbcRgXX6JAoA8kqCZNlpjFmyq5slqvGogvfy
	 6S3GpHspF9Tle2Pl4EQ0/kYQU6SPHqFf07MBSceXAaVY8S01D3oPN7bh2+SzAAmcVh
	 6FNlgYjd8PEKfMNKDPQh8NC171TYeHKCY7Tt2jsmDwKGDXnNzIJtTvdnn7uCnjEN6X
	 O9iXYLTfDisifWP4bXP3adwuirJL8JFu0XTtSTVEan9y484fQ1ieK63UZoscAUubd4
	 IRBkDfajXOuoKfkCdIyb6WCtw25Hdp3dWbU3pIJVzsX3U0q/QapjrU/fGC20xliwHm
	 VwAC7VPUPlpyQ==
Date: Wed, 25 Jun 2025 18:00:50 +0100
From: Simon Horman <horms@kernel.org>
To: Vlad URSU <vlad@ursu.me>
Cc: Jacek Kowalski <jacek@jacekk.info>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] e1000e: ignore factory-default checksum value on
 TGP platform
Message-ID: <20250625170050.GJ1562@horms.kernel.org>
References: <91030e0c-f55b-4b50-8265-2341dd515198@jacekk.info>
 <5c75ef9b-12f5-4923-aef8-01d6c998f0af@jacekk.info>
 <20250624194237.GI1562@horms.kernel.org>
 <0407b67d-e63f-4a85-b3b4-1563335607dc@jacekk.info>
 <20250625094411.GM1562@horms.kernel.org>
 <613026c7-319c-480f-83da-ffc85faaf42b@jacekk.info>
 <eb418aae-c0d4-438f-9b3b-fcb870387b1a@ursu.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb418aae-c0d4-438f-9b3b-fcb870387b1a@ursu.me>

On Wed, Jun 25, 2025 at 05:06:44PM +0300, Vlad URSU wrote:
> On 25.06.2025 16:05, Jacek Kowalski wrote:
> > > > > > +#define NVM_CHECKSUM_FACTORY_DEFAULT 0xFFFF
> > > > > 
> > > > > Perhaps it is too long, but I liked Vlad's suggestion of naming this
> > > > > NVM_CHECKSUM_WORD_FACTORY_DEFAULT.
> > 
> > So the proposals are:
> > 
> > 1. NVM_CHECKSUM_WORD_FACTORY_DEFAULT
> > 2. NVM_CHECKSUM_FACTORY_DEFAULT
> > 3. NVM_CHECKSUM_INVALID
> > 4. NVM_CHECKSUM_MISSING
> > 5. NVM_CHECKSUM_EMPTY
> > 6. NVM_NO_CHECKSUM
> > 
> > Any other contenders?
> > 
> 
> For reference, I called it "CHECKSUM_WORD" in my proposal because that's
> what it's refered to as in the intel documentation (section 10.3.2.2 - http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/ethernet-connection-i219-datasheet.pdf)
> 

FWIIW, I'd vote for 1.

