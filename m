Return-Path: <netdev+bounces-171154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4070EA4BB45
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DB53AAD7F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094351F181F;
	Mon,  3 Mar 2025 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJljErG/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B9D1F153C
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995649; cv=none; b=ilSyBoVfjEMBup43dlm8EtULMSNgADWwpJ+mlfFsKCHOJNe0ttvPhftZPpAGtCrzmTquxG+Z/lgJvwCz8qI67JYHEJWEF9jPkpuqa04J9O7LgEcPoXM6hxDu31StIVKbvtdpYEIXRf0J9ouaQIpFAxyqAjY3aeSXR99FdfEPJcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995649; c=relaxed/simple;
	bh=c1Lvome+23UjOHK9xCkGg5jc+J3HRiu4lPiJ5XsX5+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQ2MI3NtMZLOdUQxwdfcd9z1SrwNIOuYYI0S6sT809fiAu+vpzxIi4LE3fmn0hKCSqeY/K3NTVbhD4ZT5JNkqujCvKJRgWnBi1HRa7we3TmIFxaMiDcYfYnLKaFrSivhMp18YFl1mUObzjqh9Mmul1IGi5QfGLXCUshQgzKrKlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJljErG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAA4C4CEE4;
	Mon,  3 Mar 2025 09:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740995649;
	bh=c1Lvome+23UjOHK9xCkGg5jc+J3HRiu4lPiJ5XsX5+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mJljErG/qqeholJw9y2TbK8znKFffbrWOEldE4B80HZmwVtHQZSPDMn68sHrPlGNq
	 SxBai8slwoaFcRlVcEXoAwl4C+lkhJ6Yy6clS6U0ONmT39iI24IX2xg+ar7sa6s39Q
	 eF6ghjIkV+wljcNjvaFjgUPRFuFqGBWZmW26HbEcrlqaAJr78fAOtbm9M0gVEV0/qj
	 hQ81CoBrX5A5dJri6UUBEU77rMZL3e8HYInNv2glV1MWJtZCxgeiK4j9JRR+OutWns
	 DzZcC6kvI85KkUcf66YVd0Awx4qxl8mYMDxN0zZwPuLcWknhmGQ7aoUbtFYw2WhOK0
	 GlJeypV2H+GWA==
Date: Mon, 3 Mar 2025 09:54:05 +0000
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: refactor the Tx
 scheduler feature
Message-ID: <20250303095405.GQ1615191@kernel.org>
References: <20250226113409.446325-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226113409.446325-1-mateusz.polchlopek@intel.com>

On Wed, Feb 26, 2025 at 12:33:56PM +0100, Mateusz Polchlopek wrote:
> Embed ice_get_tx_topo_user_sel() inside the only caller:
> ice_devlink_tx_sched_layers_get().
> Instead of jump from the wrapper to the function that does "get" operation
> it does "get" itself.
> 
> Remove unnecessary comment and make usage of str_enabled_disabled()
> in ice_init_tx_topology().

Hi Mateusz,

These changes seem reasonable to me.
But I wonder if they could be motivated in the commit message.

What I mean is, the commit message explains what has been done.
But I think it should explain why it has been done.

> Suggested-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

...

