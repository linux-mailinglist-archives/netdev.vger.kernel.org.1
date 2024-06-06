Return-Path: <netdev+bounces-101537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB4B8FF4B4
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 20:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9C428F67D
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 18:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A199144C8C;
	Thu,  6 Jun 2024 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GluwDzP0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A228821;
	Thu,  6 Jun 2024 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698726; cv=none; b=UfXQCHBG3tci/b19A5s0wVtHP5Rct3VCBSOxfEZH7GQ6Qs/HkaH7nom5rmBktIFYjb1eE4kJds7ROrja0xftx4XBOe2TbSU5fJaqMLRC3fTGSEN8Ob0PBkyDh8a0a1MMSf/1/RUaHqfM8AMBhICE3rvCDo1Q3Y15mcNX4uRyoN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698726; c=relaxed/simple;
	bh=c8317Md13mBmS3nLncmRd43PS4wNRAjjAbEJxzLRCHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+vT0DtNuoKLyPIKpVcDKtfAaxsZcJHK4fOdhWhtFnjTQWNfy3ugAwfDWFq1W/2PbXm/B3+WmLuZ2VRgBOAxRUwAZ37hsO6jbjdM4G8tGEHG7mXq2+9CT8wMcpCDGDoI/E/v6fwk4M0b92UKWL6oSY1HhYVq1IkvbUwLHdIxtC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GluwDzP0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KS2oYQ6kEvwe+tStHjauZWJyl0wKHtSJW2cYetOHMQY=; b=GluwDzP0zbxIddz8/0rWtWfUnP
	Ln4KiPloTvSPVnN8yiLLtHlYqh8rz0Jk8wsMbDT/9VSmeb4d3lPfYsukLdRZPYCkvXRKB0jEnwcKV
	FwKqjeHY+qO2mKiCRJ9IGOvDwycriNLjaoJdyeIFPSxXEUPBmHctT/baE7rsilrMSIK4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sFHtn-00H2hc-F7; Thu, 06 Jun 2024 20:31:43 +0200
Date: Thu, 6 Jun 2024 20:31:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: jackie.jone@alliedtelesis.co.nz, davem@davemloft.net,
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	kuba@kernel.org, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz
Subject: Re: [PATCH] igb: Add MII write support
Message-ID: <12b1febd-a634-43bb-8edf-79ccb4f9e3aa@lunn.ch>
References: <20240604031020.2313175-1-jackie.jone@alliedtelesis.co.nz>
 <ad56235d-d267-4477-9c35-210309286ff4@intel.com>
 <1dbb8291-9004-4ec2-a01b-9dd5b2a8be39@lunn.ch>
 <c12ffb8e-0606-442b-810a-69bf65624bf9@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c12ffb8e-0606-442b-810a-69bf65624bf9@intel.com>

> Yea, its extremely easy to break things if you don't know what you're
> doing here. So its more a question of "are we ok exposing yet another
> way root can brick things?"

Many MAC drivers allow it, and we have not had complaints. It is not
really something i'm a fan of, it in theory allows user space drivers
for PHYs, but it is full of race conditions so in practice unlikely to
work reliably.

If you are worried about it causing additional support issues because
it gets abused, you could make it taint the kernel. That makes it
clear all bets are off if used. For the use case presented here, a
tainted kernel does not matter, it for lab testing, not production.

      Andrew


