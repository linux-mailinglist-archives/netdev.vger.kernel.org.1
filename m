Return-Path: <netdev+bounces-197764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88197AD9D51
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 16:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5007AA254
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA3E22F774;
	Sat, 14 Jun 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Lm6bpPTN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B01E4A9
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749910276; cv=none; b=eRo2XvwPdn0Jn2mpc9guLFRf21WVhbbEW617MYV7+GBAOLbh/GQA0trISnWbhPgQRfR9I+ByrpYXQng1B4dhkHkjPg64d/Z9shrCrAI+JpP5AIKV16ObhexzMZhv3xbCiCBKWKiz31AJvC2HMujsrW1sdfiwibkiZj75UpCPsj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749910276; c=relaxed/simple;
	bh=uISQTv0V1v84wdrn5pNP27Y/2WCJcOUMmgMRTyOgxz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXoF0JHjvPBYZS8R1ViLLEkxPuFyi8wnoGIWrG87PWNzdM2J0k6eATLdvLS2FfODeFkWM8Whbo1RW5OkaKo7SdRp4BU3ky0E+m5arPqC4L8x6atxNbSwIIm/m374OovboL3wyoEt5LM5DGpL3qiQV0tZLSKlvxcgT/9GQIbRses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Lm6bpPTN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lhMpoOIsO/1OYbCKHIiEdUS4vIbPl/mLr0OH4FNE1xk=; b=Lm6bpPTNZF4Ju5sIkptdp9QSqy
	1axD+TuDBlvEriMnkKNIJj9uJUJKAK+YXujdqiAKZjy3io+e8gNKMRqg6Wmo7Ll3ivgV6VRXrIVdL
	euphB8prWGBNiIknrYV0avb3Ln93yFXgTmNiH8wl8VFJw0RhnDkBkWRb44skXGFvLP54=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQRb4-00FqM3-HZ; Sat, 14 Jun 2025 16:11:02 +0200
Date: Sat, 14 Jun 2025 16:11:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ricard Bejarano <ricard@bejarano.io>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	netdev@vger.kernel.org, michael.jamet@intel.com,
	YehezkelShB@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: Poor thunderbolt-net interface performance when bridged
Message-ID: <ae3d25c9-f548-44f3-916e-c9a5b4769f36@lunn.ch>
References: <8672A9A1-6B32-4F81-8DFA-4122A057C9BE@bejarano.io>
 <c1ac6822-a890-45cd-b710-38f9c7114272@lunn.ch>
 <38B49EF9-4A56-4004-91CF-5A2D591E202D@bejarano.io>
 <09f73d4d-efa3-479d-96b5-fd51d8687a21@lunn.ch>
 <CD0896D8-941E-403E-9DA9-51B13604A449@bejarano.io>
 <78AA82DB-92BE-4CD5-8EC7-239E6A93A465@bejarano.io>
 <11d6270e-c4c9-4a3a-8d2b-d273031b9d4f@lunn.ch>
 <A206060D-C73B-49B9-9969-45BF15A500A1@bejarano.io>
 <71C2308A-0E9C-4AD3-837A-03CE8EA4CA1D@bejarano.io>
 <b033e79d-17bc-495d-959c-21ddc7f061e4@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b033e79d-17bc-495d-959c-21ddc7f061e4@app.fastmail.com>

On Sat, Jun 14, 2025 at 11:13:53AM +0200, Ricard Bejarano wrote:
> Any ideas?
> 
> I've rebuilt the lab with 6.15.2 and I still see that ~12-15% receiver loss.

Sorry, i lost track of where we were.

Did you manage to prove it is skbuf with fragments which are the
problem? As i said, adding the skb_linearize was just a debug tool,
not a fix.

	Andrew

