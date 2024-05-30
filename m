Return-Path: <netdev+bounces-99242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4323D8D432E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749D81C21713
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A471078B;
	Thu, 30 May 2024 01:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzykIKlQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3127F1C68F
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 01:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717033868; cv=none; b=LdAqLyBQOFP2MkwmDNsX1bRXJrrP21rEggEvjZqEZw3goF43r6c8OVRsst9KsGWD8LrZDVSP9j2CSsbJKozJIEEQ3s3zA3URB9yGgduzmD1XLHztg74sGa3qQgbeJ7Q10j329lCQ/HtRdEJXNyhPLVvFMD6G1FPnzbU2TTuE6x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717033868; c=relaxed/simple;
	bh=LAlKR0PH+puh4iEhxICEMeMqRtvWXESzijdJvrGZAWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHtl627psnAhugi8wVztrxjearuMTE67D4N1UEIfZJusbI1H8TqXlDXjbyHd3EiXf1lswlX5aX7HCSnxdvFN5h1zIOrCRR4O1Hi2xYiDcbitsSYIwVb9uLI+dUVVL8mXmER9K2PMhxV9+LhRCmsRdUqHFnDAkxxYdwvn+8oonww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzykIKlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CDCC116B1;
	Thu, 30 May 2024 01:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717033868;
	bh=LAlKR0PH+puh4iEhxICEMeMqRtvWXESzijdJvrGZAWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nzykIKlQBIz0HWUphbV98dOuhB9flYcajIQjXIg6qRwzHYCjtb4lDGzmKiAwD16UL
	 IEE9AwcfCkqHyrJ7Lqkw51vriXbL08asOnFkdkCXDMRSo2ocWW+Y1MeDz1luhX5I+q
	 BSuCs5dAXRhBR6gl0+wWNv27NShOnGCIYiSkrYRJcSGzIqB+I4gbNI071Pch2eM42s
	 tyUowe31zXWvldLKQmMD11k+qM7EYdM9kmCLpsOthaGBRo9YqyO6QjU4sYZeIQ3wIZ
	 FquCe6NQ1FYiwckxte9OW3AASt+xcQNR1HbhgzMMAZ/BLAyEdenVoLrrXigo5NYQ7m
	 In6U9HQS0Hlvg==
Date: Wed, 29 May 2024 18:51:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>,
 Wojciech Drewek <wojciech.drewek@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Brett Creeley
 <brett.creeley@amd.com>, Pucha Himasekhar Reddy
 <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net 6/8] ice: implement AQ download pkg retry
Message-ID: <20240529185106.3809bf2e@kernel.org>
In-Reply-To: <20240528-net-2024-05-28-intel-net-fixes-v1-6-dc8593d2bbc6@intel.com>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
	<20240528-net-2024-05-28-intel-net-fixes-v1-6-dc8593d2bbc6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 15:06:09 -0700 Jacob Keller wrote:
> +		while (try_cnt < 5) {
> +			status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE,
> +						     last, &offset, &info,
> +						     NULL);
> +			if (hw->adminq.sq_last_status != ICE_AQ_RC_ENOSEC &&
> +			    hw->adminq.sq_last_status != ICE_AQ_RC_EBADSIG)
> +				break;
> +
> +			try_cnt++;
> +			msleep(20);
> +		}
> +
> +		if (try_cnt)
> +			dev_dbg(ice_hw_to_dev(hw),
> +				"ice_aq_download_pkg number of retries: %d\n",
> +				try_cnt);
>  

That's not a great wait loop. Last iteration sleeps for 20msec and then
gives up without checking the condition.

