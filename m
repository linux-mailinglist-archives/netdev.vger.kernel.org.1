Return-Path: <netdev+bounces-229206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 515A9BD955A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444705449EC
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A90313E05;
	Tue, 14 Oct 2025 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5KakaIof"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C4631352D;
	Tue, 14 Oct 2025 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444858; cv=none; b=pRbH1Sqv5eEdVymDX6WCi0wHShe8S+OfXofIN7WcsusUmO4fB3dvWD3P29FOy6TTFfRCQ4XfL2ZUN7d53SbdTYArquyM9L/HBSchXG59NLS3/sX++wTud5ZjGNDRY0woLaut1uDG3aVEc6SjTPpTqGR/0y/KXBHTiwD/Vs0v+Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444858; c=relaxed/simple;
	bh=qdggzO2D/Kd+fYeG9PsGsHhuIsXOu5H6fGpCCu/jeRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+0PqcPaQcfcCM92i/08+GBW7bMKiSb6BjJM49CWwZjrDoRNovu1U9I826EotGvKn2IPAruFryf51OpO5Ix0wd12AVBS6KSOdXAjno8j5lAeArmJgu2+ILLWLg9c4ZmZK4T/wZDmIx+gX2k9B/sBnWqRFUbb2x/3uFOB/4rU/lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5KakaIof; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QyT8a6xTN6cFhxquXbZ2kYWpr0cYAghxKfrpKvxJbOc=; b=5KakaIofM9Ae7SVAEBCuk5tGOV
	3K3k/CHMOlFgWID0ivc+FKllftOh7XBJ0cuqH7AoidMJ/+yN/JxJoQzzq1SZpNiyTcNvhcBhq/tt1
	T4HYISk9iai7Od3T8wSMhB67EFCBcCxjdO7zaqROdNMDK7mIk1OAjyO6QgyVQG3QgPAA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8e7f-00AuKg-JQ; Tue, 14 Oct 2025 14:27:23 +0200
Date: Tue, 14 Oct 2025 14:27:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] ixgbe: Add 10G-BX support
Message-ID: <0c753725-fd6f-4f85-9371-f7342f86acff@lunn.ch>
References: <20251014-10gbx-v2-1-980c524111e7@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-10gbx-v2-1-980c524111e7@birger-koblitz.de>

On Tue, Oct 14, 2025 at 06:18:27AM +0200, Birger Koblitz wrote:
61;8003;1c> Adds support for 10G-BX modules, i.e. 10GBit Ethernet over a single strand
> Single-Mode fiber
> The initialization of a 10G-BX SFP+ is the same as for a 10G SX/LX module,
> and is identified according to SFF-8472 table 5-3, footnote 3 by the
> 10G Ethernet Compliance Codes field being empty, the Nominal Bit
> Rate being compatible with 12.5GBit, and the module being a fiber module
> with a Single Mode fiber link length.
> 
> This was tested using a Lightron WSPXG-HS3LC-IEA 1270/1330nm 10km
> transceiver:
> $ sudo ethtool -m enp1s0f1
>    Identifier                          : 0x03 (SFP)
>    Extended identifier                 : 0x04 (GBIC/SFP defined by 2-wire interface ID)
>    Connector                           : 0x07 (LC)
>    Transceiver codes                   : 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>    Encoding                            : 0x01 (8B/10B)
>    BR Nominal                          : 10300MBd
>    Rate identifier                     : 0x00 (unspecified)
>    Length (SMF)                        : 10km
>    Length (OM2)                        : 0m
>    Length (OM1)                        : 0m
>    Length (Copper or Active cable)     : 0m
>    Length (OM3)                        : 0m
>    Laser wavelength                    : 1330nm
>    Vendor name                         : Lightron Inc.
>    Vendor OUI                          : 00:13:c5
>    Vendor PN                           : WSPXG-HS3LC-IEA
>    Vendor rev                          : 0000
>    Option values                       : 0x00 0x1a
>    Option                              : TX_DISABLE implemented
>    BR margin max                       : 0%
>    BR margin min                       : 0%
>    Vendor SN                           : S142228617
>    Date code                           : 140611
>    Optical diagnostics support         : Yes
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

