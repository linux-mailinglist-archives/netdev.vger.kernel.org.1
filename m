Return-Path: <netdev+bounces-118175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD032950D90
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 22:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2871C219CE
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 20:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCCD1A4F23;
	Tue, 13 Aug 2024 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K8a6UXE0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74661A7044
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 20:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723579537; cv=none; b=keBdu2m1sjVL02Jq0+EXkqsW+CvuYWRm5llUqg1XaG4AUbRCVPup4yLDZEP0e8VbzRcZlwMCCDtcx87Y7rFbphG2SAh1pVJdesgpBTyf8ZAgtRB9ixBZ+a9l1Mk1b96YWZb226lEv3Gj7Lcf7tntHL7AkVenCmsfY3OubaJ3JI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723579537; c=relaxed/simple;
	bh=EhrZJ5BqQnOsuX+2xOZAIWIscs0ThJt5L60z0SMEFhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SX6/gpS7sZpH5JlhfPO/KWCXRf7XmRS9SG77qXzRyDVQV/FYmY+RCqKdEwdeZBwgmG/EaCwbP/Aq/JFgIVRkRWU9uXWse002Xrqn5c2q4s7Wf938TJtRBJnEdT6P29H1JWhUR9PhFJZ1e/rFg37zIX8CXp949drPe9hxCVi2tiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=K8a6UXE0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zvupSQrqXGvd/QnhwC49Qmegw/VxY86UNMEfKe8CJig=; b=K8a6UXE0XqZKX6JYi4qaThq4aI
	rZrLxERCZQcZyIEVL4V3mPvTekM3m6V7gvxW/Kdb48j5iFrsTdAYU83RYbT3I7XmQqc7gYdbQ2Wdj
	N2xguHyN600KXJ1ZOios+l3psgSg5HkAIo53qaoKgg1XQ+qjADT2ymkE4OPJ4HOplcIE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdxlr-004i8M-0o; Tue, 13 Aug 2024 22:05:31 +0200
Date: Tue, 13 Aug 2024 22:05:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
	jacob.e.keller@intel.com, vadfed@meta.com, darinzon@amazon.com,
	kuba@kernel.org
Subject: Re: [RFC 0/3] ptp: Add esterror support
Message-ID: <4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch>
References: <20240813125602.155827-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813125602.155827-1-maciek@machnikowski.net>

On Tue, Aug 13, 2024 at 12:55:59PM +0000, Maciek Machnikowski wrote:
> This patch series implements handling of timex esterror field
> by ptp devices.
> 
> Esterror field can be used to return or set the estimated error
> of the clock. This is useful for devices containing a hardware
> clock that is controlled and synchronized internally (such as
> a time card) or when the synchronization is pushed to the embedded
> CPU of a DPU.

How can you set the estimated error of a clock? Isn't it a properties
of the hardware, and maybe the network link? A 10BaseT/Half duplex
link is going to have a bigger error than a 1000BaseT link because the
bits take longer on the wire etc.

What is the device supposed to do with the set value?

     Andrew

