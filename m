Return-Path: <netdev+bounces-100796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F77B8FC12F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 03:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C281C2298C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 01:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6DD79E1;
	Wed,  5 Jun 2024 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P4xBQZ6v"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58042F44
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717550101; cv=none; b=k7UhXllCc4ZCqJEKFGYUtTZt2F2uTSTLcF/2YvkAtpkgm8Tc5Fha5iwzULEhdpjaEnQJVtl8eYibRSejiiti/ATA0vPDlO4us1p8iWxZuS6Vps6pRhYCAM0LNBbeS+YzDGOQZGgLIq/XqYhZIalgl7vNY8m+2z/UJLKCai9WBls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717550101; c=relaxed/simple;
	bh=Bv4L9NrvSEK+N9qOU007Ygdlatbfv26G5Y2JiYaobwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BW/CKY2TzR6Qzj1HRP/Nem2hVI7kHlcTRvlsK03Bg4tjk7hh7P7G5PyqH8SdoxGoRLjdgqFBZOr8VUYlR1grgxtJrFD/ckdCPqFAru2zPUNmeUtytxBZt8EjTIYWfOlPKFa+F/7f+9m2wrYRZn7Ge9PkLSQH6VKIdnHf6Yt0XL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=P4xBQZ6v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XR4iWXQMJ1j7H79vhf5bobV6/Eeyl57/HHXYOI+dLHU=; b=P4xBQZ6vbY5ZrqnzDZvA/djHFe
	PyG8yVoP1bznQWTb79mOjtEnmNAI6NXXeTUUtEdtyGOfjzllpygcMrtXnZXSjTK5y5PAyROIUZvPQ
	q4H6QbCCicKn5ut5mM/iNX1Eyxkp9b+iBIwQmPSMGMGNXX1XggrPH5/2dQESiZQX26HQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sEfEr-00GrEU-3Z; Wed, 05 Jun 2024 03:14:53 +0200
Date: Wed, 5 Jun 2024 03:14:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "Nelson, Shannon" <shannon.nelson@amd.com>,
	David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Menachem Fogel <menachem.fogel@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH 9/9] igc: add support for ethtool.set_phys_id
Message-ID: <d27f050a-26db-4f08-aa19-848ae2c6ed2d@lunn.ch>
References: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
 <20240603-next-2024-06-03-intel-next-batch-v1-9-e0523b28f325@intel.com>
 <f8f8d5fb-68c1-4fd1-9e0b-04c661c98f25@amd.com>
 <dc0cc2ca-d3f4-4387-88bd-b54ea6896e0f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc0cc2ca-d3f4-4387-88bd-b54ea6896e0f@intel.com>

On Tue, Jun 04, 2024 at 02:12:31PM -0700, Jacob Keller wrote:
> 
> 
> On 6/3/2024 5:12 PM, Nelson, Shannon wrote:
> > On 6/3/2024 3:38 PM, Jacob Keller wrote:
> >>
> >> From: Vitaly Lifshits <vitaly.lifshits@intel.com>
> >>
> >> Add support for ethtool.set_phys_id callback to initiate LED blinking
> >> and stopping them by the ethtool interface.
> >> This is done by storing the initial LEDCTL register value and restoring
> >> it when LED blinking is terminated.
> >>
> >> In addition, moved IGC_LEDCTL related defines from igc_leds.c to
> >> igc_defines.h where they can be included by all of the igc module
> >> files.

Sorry for the deep nesting. I missed the first post.

This seems like a very Intel specific solution to a very generic
problem. The LED code added by Kurt Kanzenbach follows the generic
netdev way of controlling LEDs. Any MAC or PHY driver with LED support
should be capable of blinking. Maybe in hardware, maybe it needs
software support.

So please write a generic ethtool helper which any MAC driver can use
to make use of the generic sys class LEDs associated to it, not an
Intel specific solution.

    Andrew

---
pw-bot: cr

