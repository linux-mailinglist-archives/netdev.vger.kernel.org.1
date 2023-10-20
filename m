Return-Path: <netdev+bounces-43153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D4F7D19AE
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 01:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB6C1C2102C
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 23:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1B935515;
	Fri, 20 Oct 2023 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKW0EPNk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D90A35509;
	Fri, 20 Oct 2023 23:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DBCC433C7;
	Fri, 20 Oct 2023 23:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697845759;
	bh=loI0on5ZzUtt+TaOW1sABdlRBDhAZ7YRBCQ6BuFriVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LKW0EPNkFkN8eCHVM7IaiF6+PbnRmx5oxq9FHwfSbZoMYP2az69DRLa3zNht6Ya/9
	 CC0L/iiw3vCpTzVf6Azx7By152nt0g/bfnkTL5S1I6zQK/RZ0YblWo/7W/4rJ54NJO
	 YRG64VYitDcGLJQ68FgZ9qoJAZLRZR+4aZZUt2iQkyuYWbZzmgCjc440Hqp1pZ2Y/q
	 +weFo3EZTVlAq7lCQPYEug2RIuaIJWuw4gjwQLPnPxj1w3T8tp4mXJxZA8uLG6g04s
	 agUMEd87THivCYoy1cVsdwRgs+JZB4V/leDMaz7sbr79FFgLJ1Wrgjhc4FMVmeNDLl
	 Y1r+29QTL64eg==
Date: Fri, 20 Oct 2023 16:49:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: <mkubecek@suse.cz>, <andrew@lunn.ch>, <willemdebruijn.kernel@gmail.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>, <corbet@lwn.net>,
 <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <jesse.brandeburg@intel.com>, <edumazet@google.com>,
 <anthony.l.nguyen@intel.com>, <horms@kernel.org>,
 <vladimir.oltean@nxp.com>, Jacob Keller <jacob.e.keller@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <pabeni@redhat.com>,
 <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 1/6] net: ethtool: allow
 symmetric-xor RSS hash for any flow type
Message-ID: <20231020164917.69d5cd44@kernel.org>
In-Reply-To: <c2c0dbe8-eee5-4e87-a115-7424ba06d21b@intel.com>
References: <20231016154937.41224-1-ahmed.zaki@intel.com>
	<20231016154937.41224-2-ahmed.zaki@intel.com>
	<8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com>
	<26812a57-bdd8-4a39-8dd2-b0ebcfd1073e@intel.com>
	<CAKgT0Ud7JjUiE32jJbMbBGVexrndSCepG54PcGYWHJ+OC9pOtQ@mail.gmail.com>
	<14feb89d-7b4a-40c5-8983-5ef331953224@intel.com>
	<CAKgT0UfcT5cEDRBzCxU9UrQzbBEgFt89vJZjz8Tow=yAfEYERw@mail.gmail.com>
	<20231016163059.23799429@kernel.org>
	<CAKgT0Udyvmxap_F+yFJZiY44sKi+_zOjUjbVYO=TqeW4p0hxrA@mail.gmail.com>
	<20231017131727.78e96449@kernel.org>
	<CAKgT0Ud4PX1Y6GO9rW+Nvr_y862Cbv3Fpn+YX4wFHEos9rugJA@mail.gmail.com>
	<20231017173448.3f1c35aa@kernel.org>
	<CAKgT0Udz+YdkmtO2Gbhr7CccHtBbTpKich4er3qQXY-b2inUoA@mail.gmail.com>
	<20231018165020.55cc4a79@kernel.org>
	<45c6ab9f-50f6-4e9e-a035-060a4491bded@intel.com>
	<20231020153316.1c152c80@kernel.org>
	<c2c0dbe8-eee5-4e87-a115-7424ba06d21b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 17:14:11 -0600 Ahmed Zaki wrote:
> I replied to that here:
> 
> https://lore.kernel.org/all/afb4a06f-cfba-47ba-adb3-09bea7cb5f00@intel.com/
> 
> I am kind of confused now so please bear with me. ethtool either sends 
> "ethtool_rxfh" or "ethtool_rxnfc". AFAIK "ethtool_rxfh" is the interface 
> for "ethtool -X" which is used to set the RSS algorithm. But we kind of 
> agreed to go with "ethtool -U|-N" for symmetric-xor, and that uses 
> "ethtool_rxnfc" (as implemented in this series).

I have no strong preference. Sounds like Alex prefers to keep it closer
to algo, which is "ethtool_rxfh".

> Do you mean use "ethtool_rxfh" instead of "ethtool_rxnfc"? how would 
> that work on the ethtool user interface?

I don't know what you're asking of us. If you find the code to confusing
maybe someone at Intel can help you :|

