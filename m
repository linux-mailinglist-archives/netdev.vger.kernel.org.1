Return-Path: <netdev+bounces-216017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E04EB318D6
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3949E606390
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188832C0277;
	Fri, 22 Aug 2025 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ySk1i4Ja"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAA9302CC7;
	Fri, 22 Aug 2025 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867606; cv=none; b=R0MXxbra21flMzgJY8gx5ri7gvNamQ0rk7T09kBsXZa+q7LOoUpp/2AILwxIlK2rLbw7iK5KUu3ns85usE/72ZQfa+l3Jd0VBzKx7uznx9aaoiUTy+LomyefJ5fMXK8SqZAQlAVuKsvP6zin/7jzOA213CENdf0wlIzKpbaG0j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867606; c=relaxed/simple;
	bh=OrVIPYS1E+djrOZ4LNmEbYam6+d+/9oqufM7Sapxb6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeEznmHNTrLENJb+RGoEe0yGZox9NDQYfVV3bW38VSiucnW+wf8riV4Peq/8As5KT1p0WoWrFE85y1SVPg1TN1WPW2h3WGDPsPkLSnwhYIKAse8ilFr40nYCDZj+U4S6/7ogwvz2/yQwHEVgAj/qyMymps+l/DiqhQWwgSidMr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ySk1i4Ja; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zwhAsXIwgy930xIEIc3hqz2SZ32KH1hEL9whGsP/YPU=; b=ySk1i4JaLkNHQKa6Rgx7+NZAiP
	T6lMu0roX8z0YB9obpFJMEON09A6hCC+GnrPfKeg6Qxy/VfpyexSBEpP+xccYfRjWKu4doOYxuWjp
	+jnauKfAlQGsZ1hitamFDNRMDCFaxiJRtfMqv8PFMX9i/nigWKNmOkydAMPLdIsIqIAs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upRN2-005ZzQ-1J; Fri, 22 Aug 2025 14:59:52 +0200
Date: Fri, 22 Aug 2025 14:59:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] microchip: lan865x: fix missing ndo_eth_ioctl
 handler to support PHY ioctl
Message-ID: <5ac05a1f-0cd2-421c-8747-9159a62dce2b@lunn.ch>
References: <20250821082832.62943-1-parthiban.veerasooran@microchip.com>
 <204b8b3d-e981-41fa-b65c-46b012742bfe@lunn.ch>
 <4a2e6ca1-7ae9-4959-a394-c84aab4b4c02@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a2e6ca1-7ae9-4959-a394-c84aab4b4c02@microchip.com>

> By the way, is there a possibility to submit or apply this patch to the 
> older stable kernels as well, so that users on those versions can also 
> benefit from this feature?

This is the sort of patch the machine learning bot picks up for back
porting to stable. The Fixes: tag is only one indicator it looks for,
it being a one liner and the words in the commit message might trigger
it as well.

	Andrew

