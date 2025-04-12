Return-Path: <netdev+bounces-181928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58583A86F08
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 20:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD3419E2568
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 18:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2498C1DE3D1;
	Sat, 12 Apr 2025 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAIyXFd6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421C19049B
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483900; cv=none; b=FS+cVuAueyxYZceop9AW2IbZpw2FxQFO29jF/LfJy8QqrjsPFTfQQi+FYwiJrdjX1Xp8zQBv5LTZLxtHYJR6CcUZAZUN+WplP5UWYYp2Jc7TjaSyKDh5p3njBBalRWzvpdXNN4cy+VLQrzTsg8y3K/BEmdCioskE0sy2H3iapHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483900; c=relaxed/simple;
	bh=TJeAhN7UVWxKbz3b/oizNT6LyE4kHo/KOvKEu07vtLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aegpOdbl+nSxzZxFHkcu8+HRjsv8BmuaG6mEcu8SVn/i98GqEb/3yOUiOeEIJiz4/78gpip5TPK+bGYbhazP2kFFw76M7pSzLISRjPA7hBT8MabAMindTN7BN68PONzt5eEyoX26RHIYoaow6P+XC5FpPwO/2oXhLl4jNYuk9HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAIyXFd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A1AC4CEE3;
	Sat, 12 Apr 2025 18:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744483899;
	bh=TJeAhN7UVWxKbz3b/oizNT6LyE4kHo/KOvKEu07vtLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lAIyXFd6exOgyUDReZVkzxe/lcBoXJM4hyi8P6AultpmXSFeONVfHE5IysRUKZxmo
	 S3FXR4r/QNIz305NOwAwNNr4jLoVCijU6OFLyXSZHBM2Z+ld5u8SHghYRyvfhFKkBl
	 SwE8lmmcA4CWfa+cGy6UMAWIeaiR7zyyemyrt2CWHlMrUUUWkEL5rn94bxWWB3OlRw
	 56zCAlPdHdH1GnYhqx3v4fpPlfGqBRf95OfslL5eFb+YYTLVKINAOj+ywHpKAUOqSO
	 sjkT148npoTtNC+4VPHYsI2WxjDue0kkbckZUODh1os/HmsPRfTdNGAnLoGydKw9li
	 i2QvJh2Hzlkhw==
Date: Sat, 12 Apr 2025 19:51:35 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net] ice: fix vf->num_mac count with port representors
Message-ID: <20250412185135.GR395307@horms.kernel.org>
References: <20250410-jk-fix-v-num-mac-count-v1-1-19b3bf8fe55a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-jk-fix-v-num-mac-count-v1-1-19b3bf8fe55a@intel.com>

On Thu, Apr 10, 2025 at 11:13:52AM -0700, Jacob Keller wrote:
> The ice_vc_repr_add_mac() function indicates that it does not store the MAC
> address filters in the firmware. However, it still increments vf->num_mac.
> This is incorrect, as vf->num_mac should represent the number of MAC
> filters currently programmed to firmware.
> 
> Indeed, we only perform this increment if the requested filter is a unicast
> address that doesn't match the existing vf->hw_lan_addr. In addition,
> ice_vc_repr_del_mac() does not decrement the vf->num_mac counter. This
> results in the counter becoming out of sync with the actual count.
> 
> As it turns out, vf->num_mac is currently only used in legacy made without
> port representors. The single place where the value is checked is for
> enforcing a filter limit on untrusted VFs.
> 
> Upcoming patches to support VF Live Migration will use this value when
> determining the size of the TLV for MAC address filters. Fix the
> representor mode function to stop incrementing the counter incorrectly.
> 
> Fixes: ac19e03ef780 ("ice: allow process VF opcodes in different ways")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> I am not certain if there is currently a way to trigger a bug from
> userspace due to this incorrect count, but I think it still warrants a net
> fix.

Reviewed-by: Simon Horman <horms@kernel.org>


