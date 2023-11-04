Return-Path: <netdev+bounces-46046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 596047E100C
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 16:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0574B20F88
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 15:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B51918B08;
	Sat,  4 Nov 2023 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMH+AFjq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C251168A7
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 15:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E70AC433C8;
	Sat,  4 Nov 2023 15:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699111436;
	bh=DkV5ol6LRvxR/zbp5+534rklJBjVe5TEcuyE8neuqcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMH+AFjqP8byr8zB/Dv7oDlyMhPwMC/JIXz24p3r9rvIVq+7I2fGQq3DfXXSJNdp9
	 m6lgF2Sp0q3h3aOuzmH4NJPCyoiZORb9htvsBFZFSG+kQYjZUjo1mTBxhzKvFMjsDo
	 YVdoDRXBU7yMQfV2RGSES6VxU61Iqr33edIetHAvKKZwOzQwlTd4s/pCm3lA4E26Tj
	 sKimBe5o51EvBs3e1FnplEDXtBO6Jw6a3jDQWxT9WkhzeVgy9wyAXwT8Lfjwd2LVbi
	 DPjCJBr/qpFzboWv8YrAS9IRoKxJ1ihii0mSQZnvvfr9Qo2+QRxjiDu+bJdC8U0Y3l
	 Y7ph8B99rlcrQ==
Date: Sat, 4 Nov 2023 11:23:41 -0400
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	netdev@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-net 1/3] ice: remove ptp_tx ring parameter flag
Message-ID: <20231104152341.GG891380@kernel.org>
References: <20231103234658.511859-1-jacob.e.keller@intel.com>
 <20231103234658.511859-2-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103234658.511859-2-jacob.e.keller@intel.com>

On Fri, Nov 03, 2023 at 04:46:56PM -0700, Jacob Keller wrote:
> Before performing a Tx timestamp in ice_stamp(), the driver checks a ptp_tx
> ring variable to see if timestamping is enabled on that ring. This value is
> set for all rings whenever userspace configures Tx timestamping.
> 
> Ostensibly this was done to avoid wasting cycles checking other fields when
> timestamping has not been enabled. However, for Tx timestamps we already
> get an individual per-SKB flag indicating whether userspace wants to
> request a timestamp on that packet. We do not gain much by also having
> a separate flag to check for whether timestamping was enabled.
> 
> In fact, the driver currently fails to restore the field after a PF reset.
> Because of this, if a PF reset occurs, timestamps will be disabled.
> 
> Since this flag doesn't add value in the hotpath, remove it and always
> provide a timestamp if the SKB flag has been set.
> 
> A following change will fix the reset path to properly restore user
> timestamping configuration completely.
> 
> This went unnoticed for some time because one of the most common
> applications using Tx timestamps, ptp4l, will reconfigure the socket as
> part of its fault recovery logic.
> 
> Fixes: ea9b847cda64 ("ice: enable transmit timestamps for E810 devices")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


