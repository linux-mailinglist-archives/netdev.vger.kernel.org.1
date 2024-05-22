Return-Path: <netdev+bounces-97558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEC68CC25C
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 15:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4DE1F24831
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 13:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7D81E877;
	Wed, 22 May 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOhXImGb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC21E4AB;
	Wed, 22 May 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716385521; cv=none; b=NGnVe0ZSfQQWo97aQCsdas3VXqb7umX/SQFqrLLnKJzYdJy3fK4Kjyw8NdDmY33URr9koSHpFR/C8XVDTM+pzZOGb6RYKeg8Ut6AFEkoz0H6Ehl+uD6NwTWkvMKNmo76f1x0dZ/hhmZXi6Q2N90/wtG2kaK1r0/+siNcL0yjjyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716385521; c=relaxed/simple;
	bh=1W4kFLAzSSYWvoPap3Xf2bjJpHvLN+WISbxmEp4RrVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9HKI/kf9/ecLq5BSh1LANenxZecigaB8KOp8cpM1VVZqAN79uk1FoxuaJIsJW4vnNTzT9RflH1JnDh/kvQtfuSW9XpIcBJLRiSlQO9yQDkzXYKVlUaiiwV+E65DTOkfbpCe2o+TUsIfL1Iz1ydPnmEOvrQBmnaXSHoecRO8ygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOhXImGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5B2C2BBFC;
	Wed, 22 May 2024 13:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716385521;
	bh=1W4kFLAzSSYWvoPap3Xf2bjJpHvLN+WISbxmEp4RrVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uOhXImGb+N3fAigARf5tCSwGCGfUFadbRsPHhIGLyd6wHgF6eaRnXJCR3fcgNXTM4
	 rFeSTGVpUSDqVgAbUFRZN3PXdFVeI0Qgg99IlKSDyAuXXYqd7EeA+mHAPaAioyGqNC
	 1VZDUMuG5/dmuudCij+lg6Kl8B7Q/eViJ1iFdJCCcOxghjvWhnd6SivfV/8TpqCLvq
	 9Z1WgVFzTGW+vdj9RdT+Gj3M9TqO6chUHkSsH/Jd6u0SpZWMnT++9IoVqF5/nJ61Ti
	 nE1BBhie5DvUsIVXyOfgRG7hZtZrOPZvKqct7zsp0FK6OqjuJE5K20mguejIrje6rP
	 vDrzS1VDiCFuA==
Date: Wed, 22 May 2024 06:45:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: Ido Schimmel <idosch@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "sdf@google.com"
 <sdf@google.com>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
 "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
 "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
 "paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, mlxsw <mlxsw@nvidia.com>, Petr Machata
 <petrm@nvidia.com>
Subject: Re: [PATCH net-next v5 04/10] ethtool: Add flashing transceiver
 modules' firmware notifications ability
Message-ID: <20240522064519.3e980390@kernel.org>
In-Reply-To: <DM6PR12MB451687C3C54323473716621ED8EB2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240424133023.4150624-1-danieller@nvidia.com>
	<20240424133023.4150624-5-danieller@nvidia.com>
	<20240429201130.5fad6d05@kernel.org>
	<DM6PR12MB45168DC7D9D9D7A5AE3E2B2DD81A2@DM6PR12MB4516.namprd12.prod.outlook.com>
	<20240430130302.235d612d@kernel.org>
	<ZjH1DCu0rJTL_RYz@shredder>
	<20240501073758.3da76601@kernel.org>
	<DM6PR12MB451687C3C54323473716621ED8EB2@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 May 2024 13:08:43 +0000 Danielle Ratson wrote:
> 1. Add a new unicast function to netlink.c:
> void *ethnl_unicast_put(struct sk_buff *skb, u32 portid, u32 seq, u8 cmd)
> 
> 2. Use it in the notification function instead of the multicast previously used along with genlmsg_unicast().
> 'portid' and 'seq' taken from genl_info(), are added to the struct ethtool_module_fw_flash, which is accessible from the work item.
> 
> 3. Create a global list that holds nodes from type struct ethtool_module_fw_flash() and add it as a field in the struct ethtool_module_fw_flash.
> Before scheduling a work, a new node is added to the list.

Makes sense.

> 4. Add a new netlink notifier that when the relevant event takes place, deletes the node from the list, wait until the end of the work item, with cancel_work_sync() and free allocations.

What's the "relevant event" in this case? Closing of the socket that
user had issued the command on?

Easiest way to "notice" the socket got closed would probably be to
add some info to genl_sk_priv_*(). ->sock_priv_destroy() will get
called. But you can also get a close notification in the family 
->unbind callback.

I'm on the fence whether we should cancel the work. We could just
mark the command as 'no socket present' and stop sending notifications.
Not sure which is better..

