Return-Path: <netdev+bounces-144685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A51C9C8202
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 05:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 848BAB23F33
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 04:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394261632DF;
	Thu, 14 Nov 2024 04:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avneL4k5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5351D46BF;
	Thu, 14 Nov 2024 04:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731558945; cv=none; b=AQWA1VK/SCbPemMKYcJC1Yn1H8zZ0bucp/U5r+zElRK7CHZJLzlFnWgru9JTxLc+hna5AtxjACSRjYCHlLoSjO/eb7s1utoao/t30HCxwPnDXwuBKlU2groVYqwYyxi8i5w3VwILqNf1nSq12XdX9v1b+quTD/TR3Y8sgWJjUzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731558945; c=relaxed/simple;
	bh=qD1IW+f1kR09edDspe+k6r67xtRpNtIiv+xj7UhMIfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcT+u32jSUqoPF6B+wUwScXwA/Jc6aGjRsD2gMmmCJOQqbmx4Tu8UQ6wip3T00MXveSoDRegYMvfaOYIXwVU//by79RuDPCWVLFet8QpJppkgRiNdM+AouNqKRqmaCefknf2E6JHQQgWNot+bYOJj7isnQAoWqlMKuljq5sWdgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avneL4k5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731558943; x=1763094943;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qD1IW+f1kR09edDspe+k6r67xtRpNtIiv+xj7UhMIfU=;
  b=avneL4k5RXaNJGJhdePKJTqVHcEHE0wscEzFMRvl6ug76jAVn1YOIZ6I
   9T96zlkQND26FxNemq3RHXYjBXO8JczVidpDosKLVpkXjVbDfxQHF0j9c
   4ewDHNhtZEQZF3FexgrvsrVXO8mUn/twYMepOdapkg27sFAeky5e0Tw3t
   Ik56RLHuaH3bkHadqwwmxGFUdItNYKOToV46IiZW78WtdKcgoFHK8kbqj
   jXSQIcH7vM7++Z3yfrXfw6ixvgSnCOO7BfilbO4ZEZMwklUJCG9ArhqFk
   YYabHlFUBOH3yvyOCVL1eowyt/RNo0biqavooSry92tz+9yxbq8+/aZSq
   w==;
X-CSE-ConnectionGUID: Ty64akOHRi2F/qFLGpKUYw==
X-CSE-MsgGUID: euj2YxK9Ro+v9rKAcXePZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="42864385"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="42864385"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 20:35:42 -0800
X-CSE-ConnectionGUID: llR+QJXdTuucDK8/8v7CBA==
X-CSE-MsgGUID: UTS55jWTSVK1r8iz+qNE1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="88260930"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.16.168]) ([10.247.16.168])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 20:35:39 -0800
Message-ID: <5401b791-3c69-4603-ba14-7d430df25667@linux.intel.com>
Date: Thu, 14 Nov 2024 12:35:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/2] net: phy: Introduce phy_update_eee() to update
 eee_cfg values
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20241112072447.3238892-1-yong.liang.choong@linux.intel.com>
 <20241112072447.3238892-2-yong.liang.choong@linux.intel.com>
 <f8ec2c77-33fa-45a8-9b6b-4be15e5f3658@gmail.com>
 <71b6be0e-426f-4fb4-9d28-27c55d5afa51@lunn.ch>
 <eb937669-d4ce-4b72-bcae-0660e1345b76@linux.intel.com>
 <392105cb-3f73-4765-a702-7cce0c6ac62c@gmail.com>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <392105cb-3f73-4765-a702-7cce0c6ac62c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/11/2024 5:48 am, Heiner Kallweit wrote:
> "relies on" may be the wrong term here. There's an API definition,
> and phy_ethtool_get_eee() takes care of the PHY-related kernel part,
> provided that the MAC driver uses phylib.
> I say "PHY-related part", because tx_lpi_timer is something relevant
> for the MAC only. Therefore phylib stores the master config timer value
> only, not the actual value.
> The MAC driver should populate tx_lpi_timer in the get_eee() callback,
> in addition to what phy_ethtool_get_eee() populates.
> This may result in the master config value being overwritten with actual
> value in cases where the MAC doesn't support the master config value.
> 
> One (maybe there are more) special case of tx_lpi_timer handling is
> Realtek chips, as they store the LPI timer in bytes. Means whenever
> the link speed changes, the actual timer value also changes implicitly.
> 
> Few values exist twice: As a master config value, and as status.
> struct phy_device has the status values:
> @eee_enabled: Flag indicating whether the EEE feature is enabled
> @enable_tx_lpi: When True, MAC should transmit LPI to PHY
> 
> And master config values are in struct eee_cfg:
> 
> struct eee_config {
> 	u32 tx_lpi_timer;
> 	bool tx_lpi_enabled;
> 	bool eee_enabled;
> };
> 
> And yes, it may be a little misleading that eee_enabled exists twice,
> you have to be careful which one you're referring to.
> 
> ethtool handles the master config values, only "active" is a status
> information.
> 
> So the MAC driver should:
> - provide a link change handler in e.g. phy_connect_direct()
> - this handler should:
>    - use phydev->enable_tx_lpi to set whether MAC transmits LPI or not
>    - use phydev->eee_cfg.tx_lpi_timer to set the timer (if the config
>      value is set)
> 
> Important note:
> This describes how MAC drivers *should* behave. Some don't get it right.
> So part of your confusion may be caused by misbehaving MAC drivers.
> One example of a MAC driver bug is what I wrote earlier about
> stmmac_ethtool_op_get_eee().
> 
> And what I write here refers to plain phylib, I don't cover phylink as
> additional layer.
> 

Thank you for your detailed explanation. It has been very helpful and has 
clarified how the code behaves.

Based on your and Andrew's input, I agree that phy_update_eee() is not needed.

I will ensure that our implementation follows these guidelines and will 
address any potential issues with misbehaving MAC drivers.

Thank you again for your valuable insights.

