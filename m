Return-Path: <netdev+bounces-24441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0BA77032F
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EA61C20EDD
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3333FBE4F;
	Fri,  4 Aug 2023 14:35:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCB4BA4D
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8BBC433C7;
	Fri,  4 Aug 2023 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691159706;
	bh=lI3Yz8yyI1OekaPbi6kQfjrKofOteaQVZnmEx+XbDVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jCQUEn3kKTRpq8LNxvB8atg3pEf55bRiqS83dVV4mR9nGKMe7n+WwbNFdcj50i2+5
	 tkxnMifwxXdiQHzJbzWCNwjBiiVCGybNy+8qggbvi+49V6wqFywsV2w+nprqQopEQL
	 HM7HkjeCX3DBNHQKrxqUerxN3YUxVrKLIZUlsPLnypldZ2PUdQpyFX/7RqY3mI2PGE
	 5afKAIgLXD6CJqzdD5D0jTf4cHxOuyQourKnWJD3JKHmRd0aX8DyelF1ruCXPoEcMV
	 n4afMB2IpFFexRq9TElS9z5T7fXIy+NM+PwZ21T+aP0qkxCSrbzFTMfk5fU7Asx59z
	 dk5EEmYkvx73A==
Date: Fri, 4 Aug 2023 16:35:02 +0200
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-next v2] ice: split ice_aq_wait_for_event() func into
 two
Message-ID: <ZM0MlhZduLVa6YZV@kernel.org>
References: <20230803151347.23322-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803151347.23322-1-przemyslaw.kitszel@intel.com>

On Thu, Aug 03, 2023 at 11:13:47AM -0400, Przemek Kitszel wrote:
> Mitigate race between registering on wait list and receiving
> AQ Response from FW.
> 
> ice_aq_prep_for_event() should be called before sending AQ command,
> ice_aq_wait_for_event() should be called after sending AQ command,
> to wait for AQ Response.
> 
> struct ice_aq_task is exposed to callers, what takes burden of memory
> ownership out from AQ-wait family of functions.
> 
> Embed struct ice_rq_event_info event into struct ice_aq_task
> (instead of it being a ptr), to remove some more code from the callers.
> 
> Additional fix: one of the checks in ice_aq_check_events() was off by one.

Hi Przemek,

This patch seems to be doing three things:

1. Refactoring code, in order to allow
2. Addressing a race condition
3. Correcting an off-by-one error

All good stuff. But all complex, and 1 somewhat buries 2 and 3.
I'm wondering if the patch could be broken up into smaller patches
to aid both review new and inspection later.

The above notwithstanding, the code does seems fine to me.

> Please note, that this was found by reading the code,
> an actual race has not yet materialized.

Sure. But I do wonder if a fixes tag might be appropriate anyway.

> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

