Return-Path: <netdev+bounces-251137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A83A5D3AC02
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0233E3110A2E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D7C35CB95;
	Mon, 19 Jan 2026 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YwpUWWPy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A833659E9
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832771; cv=none; b=Wf1dl2HYeTd5FCrFTmnG7jZqgCy5nH4esQDwI09f5nFmTGX4jpu0HtUtsDstePnTvPh22G3r7HV1nyohRemVnw2ctOcvu4hyls9P0ES4TOU6mvmVpEURWWj0LDu2CXzXgsUAEhXUAL4nRJccGT3vVIfmARjfsc4t5BC6N5nttCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832771; c=relaxed/simple;
	bh=NK7F76R7iNrrVjxo1QUhsfEojWx77yUJX3OwpQv/viI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDNASwVQw7DVfnugcBJjxuYNc3TWw6GlISc+E/IH4jF1heUv2KQ18fCq25I7A2bN0p5G+SgKL+OXBYwscVKR0Fwq+tedzWhSZML6MWtLot5mACeHpZvn1wQNSf8o5RLdB5EQ/y/qb9OpiDil/p2/5/jPFYcllcItQnJTgiljMNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YwpUWWPy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xfpHbLD0lfcxO5zc/kGX8zLRlFIUbZY41QPpyljPP3c=; b=YwpUWWPy5k5IazfLWBKi3MdjBL
	Bh9ICL8flh3YGaQ67Xl/BA1tcXdi3TrnUcP5WFxBDED1X73MC77SKcalxBfbBWwDgNKYMAeJZ/BS0
	PGAHEQmoXlpZXjZd01JVse+RPvvOE9ziGzl3ixxCuV3rbMMK0DRCeeiwCqshvtOMPUb4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vhqCk-003VYy-DY; Mon, 19 Jan 2026 15:26:06 +0100
Date: Mon, 19 Jan 2026 15:26:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v1 6/7] ixgbe: replace EEE enable flag with
 state enum
Message-ID: <4263db7a-fe7d-4bd7-a33b-54fd0a8d570d@lunn.ch>
References: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
 <20260112140108.1173835-7-jedrzej.jagielski@intel.com>
 <8f976990-1087-4ba0-a06d-c0538c39d2a3@lunn.ch>
 <PH0PR11MB59027E7BBF8EF6121DF24DDCF08EA@PH0PR11MB5902.namprd11.prod.outlook.com>
 <cb9f2295-0f1d-48a3-ab53-3d51c2930f94@lunn.ch>
 <MW4PR11MB589023306C8055BD6A937557F088A@MW4PR11MB5890.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR11MB589023306C8055BD6A937557F088A@MW4PR11MB5890.namprd11.prod.outlook.com>

> i've checked the scenario and, indeed, EEE gets reenabled once link
> conditions are meet again even without driver intervention.
> Thanks for pointing me that.
> In that case i will remove link enablement/disablement on driver side,
> but i am wondering whether leaving logging trace on link condition
> change (EEE gets disabled due to unsupported link conditions) would be
> beneficial
> WDUT?
> then keeping tristate EEE would be required i believe

The current phylib/phylink code does not log this. There is also not
much the user can do about it, if EEE is disabled, other than throw
the ixgbe out and get a card which does implement EEE at lower speeds.

    Andrew

