Return-Path: <netdev+bounces-72560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF22858868
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 23:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026A1282714
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CF11482E2;
	Fri, 16 Feb 2024 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="07/RfGlT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C6514600B
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 22:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708121596; cv=none; b=DgtTWfEOTR1rC0XDNJHLpYoQ2IjispEF7jUPvoBQqWPoyRq2wwU8sPfJOTctbU2m7lRkg5aV0sIhYLyKP7V20CxBdPov4e19RoxQINqGIEF+xvibIhwRXSV2tmZGTXo08STogvfzZ5d6JGQO2xmK9OMuow4ZkauhnQe3lv8jvLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708121596; c=relaxed/simple;
	bh=3aimH8FspEs+csOBlAHgVFPfFbmqvZ8ZuQlmVDHEjMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOKA698K6MRfEWdM+r+Of1nc25XIW3le8y88xUEvfC/nOgpe0+rlsRfmK5fmOCURrJJMHo5P3HxzvwsrqbCYbXkBw31AD722jcsAWerYfocgF3jFG+z1DDYgbMAOO7353y3i96Ih6T4YaUEibv71+pHYYGJt/s7UUnT3faVbmKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=07/RfGlT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IPNy8U1/V8k7vRZK1MvGyZgQ98uI9Vj14PHzlW32EYw=; b=07/RfGlTJmfy8GRri68+RvOABF
	izgLPAsSBSYSphe5DiIwA6gSEZJKcgBrUjvQyvb+eqCg69Q5z7TpDuP1mX/CcjAGYF160aCVYcVfG
	OKulH+pz5IZNce7zm3q54KBnKYoL9jdYPz1Gpufizh75zG90niPM2BTWl+ZIYpOy3HQ4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rb6SL-0081Qe-9u; Fri, 16 Feb 2024 23:13:17 +0100
Date: Fri, 16 Feb 2024 23:13:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, steen.hegelund@microchip.com,
	netdev@vger.kernel.org, horatiu.vultur@microchip.com,
	Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
	Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com
Subject: Re: [PATCH net-next v2 0/9] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Message-ID: <1e6c9bf1-2c36-4574-bd52-5b88c48eb959@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>

On Mon, Oct 23, 2023 at 09:16:40PM +0530, Parthiban Veerasooran wrote:
> This patch series contain the below updates,
> - Adds support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface in the
>   net/ethernet/oa_tc6.c.
> - Adds driver support for Microchip LAN8650/1 Rev.B0 10BASE-T1S MACPHY
>   Ethernet driver in the net/ethernet/microchip/lan865x.c.

Hi Parthiban

Omsemi also have a TC6 device, which should use this framework. They
would like to make progress getting their device supported in
mainline.

What is happening with this patchset? Its been a few months since you
posted this. Will there be a new version soon? Has Microchip stopped
development? Postponed it because of other priorities etc?

Thanks
	Andrew

