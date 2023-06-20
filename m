Return-Path: <netdev+bounces-12307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FB5737117
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BE91C20C39
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 15:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F12317726;
	Tue, 20 Jun 2023 15:59:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43A81078E
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 15:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32D0C433C9;
	Tue, 20 Jun 2023 15:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687276760;
	bh=JvRHHCpfUHPT1y5nSv1lOHmoL4oYB3Bie6coQ1YCqpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ndYk6tuBUkmB2QJsWkmzvNPun5kdhr3H5rNYk5bHzBbHPLqM42qe77Ibp1mG8kFBD
	 /oCyNdI2rvv1fMqbvf4L+jHJZmhS/ZXvMwxL86d4YbsNYB4VzETENq538CU9NRm10H
	 +yJpfpHaw2L0RkdPjuKfIR/bR2Yp3cmwnJFb14QwdktFq3toQ69lpJq1zcSAmBFM32
	 PvEV6i/YZ1zMSoW2E1ACZONpekn0VByjNVkoewMyHGqjz1Rsgp4mS8ar6wHh8u8wTX
	 cwXnlJOjBZwutDgk8mcyOWqQxwZBr4x/tZgiqz9vXD2uEFzks9jYnb8bt8vvUUOUO/
	 RRHdpPInU+9Wg==
Date: Tue, 20 Jun 2023 08:59:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Piotr Gardocki <piotrx.gardocki@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com,
 michal.swiatkowski@linux.intel.com, pmenzel@molgen.mpg.de,
 maciej.fijalkowski@intel.com, anthony.l.nguyen@intel.com,
 simon.horman@corigine.com, aleksander.lobakin@intel.com
Subject: Re: [PATCH net-next v2 1/3] net: add check for current MAC address
 in dev_set_mac_address
Message-ID: <20230620085919.497c3a03@kernel.org>
In-Reply-To: <17cc8e10-3b54-7bb7-6245-eba11d049034@nvidia.com>
References: <20230613122420.855486-1-piotrx.gardocki@intel.com>
	<20230613122420.855486-2-piotrx.gardocki@intel.com>
	<c29c346a-9465-c3cc-1045-272c4eb26c65@nvidia.com>
	<18b2b4a1-60b8-164f-ea31-5744950e138d@intel.com>
	<17cc8e10-3b54-7bb7-6245-eba11d049034@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jun 2023 13:42:14 +0300 Gal Pressman wrote:
> > I checked it, you're right. When the addr_assign_type is PERM or RANDOM
> > and user or some driver sets the same MAC address the type doesn't change
> > to NET_ADDR_SET. In my testing I didn't notice issues with that, but I'm
> > sure there are cases I didn't cover. Did you discover any useful cases
> > that broke after this patch or did you just notice it in code?  
> 
> This behavior change was caught in our regression tests.

Why was the regression test written this way?

I guess we won't flip it back to PERM if user sets a completely
different address temporarily and then back to PERM - so for consistency
going to SET even when the addr doesn't change may be reasonable.

Piotr, you'll need to send a new followup patch on top of net-next.

