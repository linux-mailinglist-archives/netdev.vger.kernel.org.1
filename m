Return-Path: <netdev+bounces-102430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FFE902E92
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 04:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734FC1F21EF2
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E63D152161;
	Tue, 11 Jun 2024 02:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VR9YtHM+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974AA2A
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 02:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074078; cv=none; b=Z7LttGdionRTkeyT7YLMM+xzpVv0xMSwPcFASZRO1AAzhgy/Lvqjm7B9fdLAUIIBH8dcDpDn34AYkGEDoYRbpOCLwalwEoBOEF2p4mro8tlSvm8B4nh2/prCwZwPtUIOfyVB/1RQw7UJZUALZoblJ7aHrYqxQhmmwCoUT4SmHt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074078; c=relaxed/simple;
	bh=U98cOt1tqguDTBN6tdARL6YiSSn7Q2AcTfocRE7XTLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=um37wSeeaKKOSL5Nq3atFM0Fzr0QLHqv7qZRTx7dj1XL8lStwsfKH67Nf71DtVgkq+ZEiAK3toAcpxP5SsQENMl0BoOkpqldLKI6mMSu8h9yo38WdD18fRh5ypLVUAiEQdd4xeYw0YzY/ezwGwUFRanE6AnwkGMnmkB4pDYV1m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VR9YtHM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA2EC2BBFC;
	Tue, 11 Jun 2024 02:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718074077;
	bh=U98cOt1tqguDTBN6tdARL6YiSSn7Q2AcTfocRE7XTLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VR9YtHM+nmG/MtgCBprW2vEIANJvrsNx36+QS1u1eRwei3YeORbuiqJSVBENkoCTN
	 znL4T1yUXLeLkPa9PtTFDFqPZWp6JXZerJYNE/6N6lFrUogRj3IStSSJLg1HujN75b
	 4Cni6gbLSdwiW/nZkQrb5sx5euV9QjsTsLkBlaF/zJ/HelHv0R+jkFtP4sMW0r8v8h
	 tD194z33zrIofZLzjn0HMgnBCpWVOV7zyaniETTbnOPm7jmYfSJUX+CVFNzecpswCQ
	 CCGfVuQvom0Pd+lN7MsP3lkVEMK+FUJHgVupy/XtFnm+LXhCvUIlPGR9pLp7QG/HWP
	 Ba8yM5J4txNzg==
Date: Mon, 10 Jun 2024 19:47:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, Ngai-Mint Kwan
 <ngai-mint.kwan@intel.com>, Mateusz Polchlopek
 <mateusz.polchlopek@intel.com>, Pawel Chmielewski
 <pawel.chmielewski@intel.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH iwl-net v5] ice: Do not get coalesce settings while in
 reset
Message-ID: <20240610194756.5be5be90@kernel.org>
In-Reply-To: <20240607121552.15127-1-dawid.osuchowski@linux.intel.com>
References: <20240607121552.15127-1-dawid.osuchowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jun 2024 14:15:52 +0200 Dawid Osuchowski wrote:
> We cannot use ice_wait_for_reset() since both the ethtool handler and the
> adapter reset flow call rtnl_lock() during operation. If we wait for
> reset completion inside of an ethtool handling function such as
> ice_get_coalesce(), the wait will always timeout due to reset being
> blocked by rtnl_lock() inside of ice_queue_set_napi() (which is called
> during reset process), and in turn we will always return -EBUSY anyways,
> with the added hang time of the timeout value.

Why does the reset not call netif_device_detach()?
Then core will know not to call the driver.

> Fixes: 67fe64d78c43 ("ice: Implement getting and setting ethtool coalesce")

Isn't ice_queue_set_napi() much more recent than this commit?

