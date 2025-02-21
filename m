Return-Path: <netdev+bounces-168359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1B8A3EA4B
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 02:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5EA189C5FC
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 01:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737561ADC98;
	Fri, 21 Feb 2025 01:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsgqRGkR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1BF4A04;
	Fri, 21 Feb 2025 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102315; cv=none; b=hTiUDHleMxp/qZ5SirMbdtamk5NoCfSKQK/RnL4XbSghHuweMIvK1TGhqsKt7wlEAyXyfRmlWLacNfsDklAotSPA4pcWG1AJeQSXh+OdKgUEGED6jyKA7dU0mlIiuAWsj5SqnDAjFcjcA+yASICbaPGmsyteHGCFmzFSQ43tZSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102315; c=relaxed/simple;
	bh=MflqgNRZC8HrjsqgYUo/6L/lKQz+zC1RrHrV1YTvXLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5mlA22s+CQu20rd9HCmQA7rqtUE/Z5u27uSkCXcJodC7M4FqYsCHtnRyVUWgxTCt8PMykS/W7kscMa0ZFTdZO1VOMT45llYmAE6oi3ry+VBhTaBRqvzfiQdhoZZLTdhVvvsnAk9ykaD8/MsYrgEoGebjRlN9K9uJ4KaY3DLaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsgqRGkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E736CC4CED1;
	Fri, 21 Feb 2025 01:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740102313;
	bh=MflqgNRZC8HrjsqgYUo/6L/lKQz+zC1RrHrV1YTvXLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IsgqRGkRkqab7x+//LL3zBUQa+DGNxA0eecHXBF0PN7ugub8SScfvs2pDK+RwNt9H
	 dDJkJSeY1tWmMxQxT6NoyrYT1MrbmoiSJDVtuK+m2qEJRAPXW1D7Dq+HEGH97lCB/F
	 K0JHTOO8bmqsbjB8oABevXonfVr0acuVszlkpxG0tnoFl6X8MYpjSKcXpow0CBJFub
	 8BZMSBV7nGCUTHdXlYjySIeggjjmy189vgaDgwq+hybnPkJUetRy/WFJvK4djp6GOF
	 Bj0EyFgpPTWfVs2cpq+mfsnzOuPWhER9TSc0i4Gj5evdkfTkqjYgFMgBE+CNHxE9QS
	 c/1NauROVApCQ==
Date: Thu, 20 Feb 2025 17:45:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Jiri Pirko <jiri@resnulli.us>, Cosmin Ratiu
 <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 netdev@vger.kernel.org, Konrad Knitter <konrad.knitter@intel.com>, Jacob
 Keller <jacob.e.keller@intel.com>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, linux-kernel@vger.kernel.org, ITP Upstream
 <nxne.cnse.osdt.itp.upstreaming@intel.com>, Carolina Jubran
 <cjubran@nvidia.com>
Subject: Re: [RFC net-next v2 1/2] devlink: add whole device devlink
 instance
Message-ID: <20250220174512.578eebe8@kernel.org>
In-Reply-To: <20250219164410.35665-2-przemyslaw.kitszel@intel.com>
References: <20250219164410.35665-1-przemyslaw.kitszel@intel.com>
	<20250219164410.35665-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 17:32:54 +0100 Przemek Kitszel wrote:
> Add a support for whole device devlink instance. Intented as a entity
> over all PF devices on given physical device.
> 
> In case of ice driver we have multiple PF devices (with their devlink
> dev representation), that have separate drivers loaded. However those
> still do share lots of resources due to being the on same HW. Examples
> include PTP clock and RSS LUT. Historically such stuff was assigned to
> PF0, but that was both not clear and not working well. Now such stuff
> is moved to be covered into struct ice_adapter, there is just one instance
> of such per HW.
> 
> This patch adds a devlink instance that corresponds to that ice_adapter,
> to allow arbitrage over resources (as RSS LUT) via it (further in the
> series (RFC NOTE: stripped out so far)).
> 
> Thanks to Wojciech Drewek for very nice naming of the devlink instance:
> PF0:		pci/0000:00:18.0
> whole-dev:	pci/0000:00:18
> But I made this a param for now (driver is free to pass just "whole-dev").

Which only works nicely if you're talking about functions not full
separate links :) When I was thinking about it a while back my
intuition was that we should have a single instance, just accessible
under multiple names. But I'm not married to that direction if there
are problems with it.

> $ devlink dev # (Interesting part of output only)
> pci/0000:af:00:
>   nested_devlink:
>     pci/0000:af:00.0
>     pci/0000:af:00.1
>     pci/0000:af:00.2
>     pci/0000:af:00.3
>     pci/0000:af:00.4
>     pci/0000:af:00.5
>     pci/0000:af:00.6
>     pci/0000:af:00.7

Could you go into more details on what stays on the "nested" instances
and what moves to the "whole-dev"? Jiri recently pointed out to y'all
cases where stuff that should be a port attribute was an instance
attribute.

