Return-Path: <netdev+bounces-38783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7607BC721
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 13:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F737281FAA
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 11:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EFE18AF3;
	Sat,  7 Oct 2023 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rDr1R2um"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289CF9F4
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 11:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A7DC433C8;
	Sat,  7 Oct 2023 11:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696678400;
	bh=MhC2Xsh1F0Dp/xiGufKa2htr3zYIzm0ooEtftPrfJ5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDr1R2umQ5BwJUJxxoc2jFkKlxL2yQU6SkCbIMRVdn4NYYTg8CmJH154fL9154PU2
	 +ZKCVfl5tqG5SksBNrtI6kwF0uNqyQdfZTSpXm9eEl80y2j2YQUafulniKHjQHtmxf
	 ldQuN/RPF5ZBqHna+Mn9BpEnAE7SFVvcMSO8BCS8=
Date: Sat, 7 Oct 2023 13:33:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] i40e: fix the wrong PTP frequency calculation
Message-ID: <2023100707-hydrogen-tapestry-62e8@gregkh>
References: <20230926071059.1239033-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926071059.1239033-1-yajun.deng@linux.dev>

On Tue, Sep 26, 2023 at 03:10:59PM +0800, Yajun Deng wrote:
> The new adjustment should be based on the base frequency, not the
> I40E_PTP_40GB_INCVAL in i40e_ptp_adjfine().
> 
> This issue was introduced in commit 3626a690b717 ("i40e: use
> mul_u64_u64_div_u64 for PTP frequency calculation"), frequency is left
> just as base I40E_PTP_40GB_INCVAL before the commit. After the commit,
> frequency is the I40E_PTP_40GB_INCVAL times the ptp_adj_mult value.
> But then the diff is applied on the wrong value, and no multiplication
> is done afterwards.
> 
> It was accidentally fixed in commit 1060707e3809 ("ptp: introduce helpers
> to adjust by scaled parts per million"). It uses adjust_by_scaled_ppm
> correctly performs the calculation and uses the base adjustment, so
> there's no error here. But it is a new feature and doesn't need to
> backported to the stable releases.
> 
> This issue affects both v6.0 and v6.1, and the v6.1 version is an LTS
> release. Therefore, the patch only needs to be applied to v6.1 stable.
> 
> Fixes: 3626a690b717 ("i40e: use mul_u64_u64_div_u64 for PTP frequency calculation")
> Cc: <stable@vger.kernel.org> # 6.1
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Now queued up, thanks.

greg k-h

