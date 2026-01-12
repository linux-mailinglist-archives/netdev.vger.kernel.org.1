Return-Path: <netdev+bounces-249083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 461DAD13B1E
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFBEF3001604
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDC435F8C1;
	Mon, 12 Jan 2026 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SHXh23RM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF2535F8D6
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232012; cv=none; b=akx30XSKKXUkzgWfr0uFdqWP5tAWnFocHeXNsf9atNfq4bsVamgwacfXO7AEK1x4cqhyyoq+79MWXfxMjg5NwY6rU2KpN/j1XbJlYE6hNkKltaqW3g7tgkYQ5dyXokBoz1gs0pPZleFQxqztGwnBHgn9mbXv9ae+AFa0sGEu9DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232012; c=relaxed/simple;
	bh=7br71al70osdNhYhoyfhcPflvupA4OlexkHzJQSUs7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWzESSKsX0dY/xAC0BPiUzRF46oXNTSc+vubfLEWs+GJVMvQh+ozn12Wqi9txATPKpM03so995hcyZaOo99HoL5Jpn50BsoOMx+11LoX2oiMS3FCqNnfYIjmG98ktLG3gkMW5fGUqqZrM/eFCI31db3WttZ9X6MxjEdnvyskAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SHXh23RM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+tS+VPw2eHksooP1q/eKYTDOe/N7Ous7Lw3PFa80c8o=; b=SHXh23RMSQbQZBvzoogHvuhzmb
	rgfazA1/obO6kDzaB3dO8Bi6Z6scSSmcVNiJHRtdNTgCvwaFNIU1EwZE+pZDe+D4RSoJQ2Ho0rzoJ
	AK498+YXIRKpZxfeiMyuL61blcDFDZC5sYu9AT6D59n50CRD3C0ohPZhuxqd+pOi+unY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vfJv2-002Uy5-Bd; Mon, 12 Jan 2026 16:33:24 +0100
Date: Mon, 12 Jan 2026 16:33:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v1 5/7] ixgbe: move EEE config validation out of
 ixgbe_set_eee()
Message-ID: <29577cab-c96f-4799-99d7-c78cf61cfd61@lunn.ch>
References: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
 <20260112140108.1173835-6-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112140108.1173835-6-jedrzej.jagielski@intel.com>

> +	if (keee_stored.eee_enabled == keee_requested->eee_enabled)
> +		return -EALREADY;

I know this is just moving code around, but i don't know of any other
implementation of EEE which returns -EALREADY when no change has been
requested by the user. Maybe in a follow up patch you change this to 0?

	  Andrew

