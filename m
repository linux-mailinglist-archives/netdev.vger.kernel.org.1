Return-Path: <netdev+bounces-202592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C71E1AEE520
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41B6189DA7A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FAC433A4;
	Mon, 30 Jun 2025 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFvLYFGj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D26D4A3C
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751302839; cv=none; b=YagUEoQJQIfM/ZRLHNUHHM3OSvdPX98FNFAwygV9W43/WEEDvkyUXBL0bSWsjS8H79cePpLCoU+n8oNCki5l6pBWsr5PlYtP6LSMeV3QIwernSk363FF/lV8hv6KilZXQjlRL0pHS4FHyrIl4khkMVfmgAOqqifV9jIdLjEUdkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751302839; c=relaxed/simple;
	bh=A1ZSkoTFKTKhjpljfgDctJifOFrYqObAJ6IZojsoYAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izYVyP3H+XF8ZCur2SCa5XaaXD30TZxBkb2XBLFX8PuJkxh1It4h/tcGvb2w/09Act0BSALQ8PDNTkkTQiMvanvZlu1uUNz96vl4Hg7+PjUVSsT9NOJ6qkBv53uKGbyGxqhL/CE6V/viQPKL2cYHmaaT2WWmbytjG80yW5xJheI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFvLYFGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17E4C4CEE3;
	Mon, 30 Jun 2025 17:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751302838;
	bh=A1ZSkoTFKTKhjpljfgDctJifOFrYqObAJ6IZojsoYAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFvLYFGjbDkqPXBkpc0o6ksJ1DVo7hJR8iHF/K3W8LjK6nqYMxBji7QEtmFfs5IFy
	 kSoeHEXn0wcJs03fuCYeOaqLJATW6Rw5RSrhJ/BUgyssQG1pvNmay7bmWOjCWASDr4
	 xbgnvQ5n/u1F/ZH8bvLXRXtAUWowWD7Wroa5bipVNj3uGewBLJrAbJZxBV/0XcI9nq
	 95Vc8Lnk7LTDc032hy1qySIga/KUrwe9k3Ehsu3+ICOxugNySSLDrFwih3gdsGgx2+
	 Ds9uwkFi6BJadQhGEOi/j4+y7EAVb5BHyTL2WBI62MMa9eSp14qrMwjWnAIJRLs8F6
	 JePBQM1iIE8uQ==
Date: Mon, 30 Jun 2025 18:00:34 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vlad URSU <vlad@ursu.me>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 2/2] e1000e: ignore uninitialized checksum word on tgp
Message-ID: <20250630170034.GM41770@horms.kernel.org>
References: <3fb71ecc-9096-4496-9152-f43b8721d937@jacekk.info>
 <28347e4f-c6a7-4194-8a80-34508891c8ec@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28347e4f-c6a7-4194-8a80-34508891c8ec@jacekk.info>

On Mon, Jun 30, 2025 at 10:35:00AM +0200, Jacek Kowalski wrote:
> As described by Vitaly Lifshits:
> 
> > Starting from Tiger Lake, LAN NVM is locked for writes by SW, so the
> > driver cannot perform checksum validation and correction. This means
> > that all NVM images must leave the factory with correct checksum and
> > checksum valid bit set.
> 
> Unfortunately some systems have left the factory with an uninitialized
> value of 0xFFFF at register address 0x3F (checksum word location).
> So on Tiger Lake platform we ignore the computed checksum when such
> condition is encountered.
> 
> Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
> Tested-by: Vlad URSU <vlad@ursu.me>
> Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM checksum")
> Cc: stable@vger.kernel.org

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


