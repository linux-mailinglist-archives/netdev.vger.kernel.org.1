Return-Path: <netdev+bounces-222972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DCBB57561
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 11:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9D83A7FD1
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 09:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2F12F6187;
	Mon, 15 Sep 2025 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvdh/vXA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B61D2F3613
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930330; cv=none; b=o/sk64m8v8fOrbMIr3Sq4StW3Eq8qaAJ27U5LBzH7wmDkm3FGy+G6Oe6oj6Y8QGyfC77B76vYAirSKtaT6kFjnaVHXbcA+XzC3pJ3VnzVIyuPTWZ9akyMLUXrhEcr5/1pe9f8SryzSCzo+mS/lEsmF8I8fPZRfcZq9l92Pb3A80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930330; c=relaxed/simple;
	bh=FsKJ8c81julWLc3GJCezM9mE5Z2asGVrmNz1XbPv02s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7v0Njay6DyaUjFaLgggOIfd0UB707taznbVG60TekzqKYiMwg3KDY2OMDM+mhgRL7WEqV2HQnBczqPyRHJgTg24j6y12gBqZIATDktlZ7pageKsjBx1hJMOR3D0oKOPhZVn9/P3b4M5m6g5FXeKc/H1zXiDB+7eH6vloZfqkDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvdh/vXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66208C4CEF1;
	Mon, 15 Sep 2025 09:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757930330;
	bh=FsKJ8c81julWLc3GJCezM9mE5Z2asGVrmNz1XbPv02s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvdh/vXAtL+Lh9tEsXZxJwsTfCQ1tVO9QiAhSEtWs6h1cBWWsID4zUoqCV4JtWeol
	 U7p1SLQd66A8IiiBXrdyjTKSeStikeSmp5usEcTFq8orMBOfVY08TEd1wFLFw0wu3u
	 TegtUQ/V0mp1B04IxjMHIsHAeQazgIjHBEWRj5I4BunBITEpEVJbo2Dm09PQiFPeew
	 QE0i5B0feUsVusSRu9y/uQ6hDS2uMbdIEy8hmHOphMGUp6+qbnDuU2+0AWEQPBXXYU
	 xudRj54+GaKJDCMNYtg0+8vsL+lHmJHksdwTyx730Qi5Eu60shsnD2huZF3w/Q6mAA
	 aRrJ8psV3c6Kw==
Date: Mon, 15 Sep 2025 10:58:46 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, alexanderduyck@fb.com,
	jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 2/9] eth: fbnic: use fw uptime to detect fw
 crashes
Message-ID: <20250915095846.GO224143@horms.kernel.org>
References: <20250912201428.566190-1-kuba@kernel.org>
 <20250912201428.566190-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912201428.566190-3-kuba@kernel.org>

On Fri, Sep 12, 2025 at 01:14:21PM -0700, Jakub Kicinski wrote:
> Currently we only detect FW crashes when it stops responding
> to heartbeat messages. FW has a watchdog which will reset it
> in case of crashes. Use FW uptime sent in the heartbeat messages
> to detect that the watchdog has fired.

I see that the time sent in heartbeat messages is critical to this check.
But the time sent in ownership messages is also used, right?

> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic.h    |  4 ++++
>  drivers/net/ethernet/meta/fbnic/fbnic_fw.h |  6 ++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_fw.c | 15 ++++++++++++++-
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
> index 311c7dda911a..09058d847729 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
> @@ -84,6 +84,10 @@ struct fbnic_dev {
>  	/* Local copy of hardware statistics */
>  	struct fbnic_hw_stats hw_stats;
>  
> +	/* Firmware time since boot in milliseconds */
> +	u64 firmware_time;
> +	u64 prev_firmware_time;
> +
>  	struct fbnic_fw_log fw_log;
>  };
>  
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> index ec67b80809b0..c1de2793fa3d 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> @@ -201,6 +201,12 @@ enum {
>  	FBNIC_FW_OWNERSHIP_MSG_MAX
>  };
>  
> +enum {
> +	FBNIC_FW_HEARTBEAT_UPTIME               = 0x0,
> +	FBNIC_FW_HEARTBEAT_NUMBER_OF_MESSAGES   = 0x1,
> +	FBNIC_FW_HEARTBEAT_MSG_MAX
> +};
> +
>  enum {
>  	FBNIC_FW_START_UPGRADE_ERROR		= 0x0,
>  	FBNIC_FW_START_UPGRADE_SECTION		= 0x1,
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> index 6e580654493c..72f750eea055 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> @@ -495,6 +495,11 @@ int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership)
>  
>  	fbd->last_heartbeat_request = req_time;
>  
> +	/* Set prev_firmware_time to 0 to avoid triggering firmware crash
> +	 * detection now that we received a response from firmware.
> +	 */

I'm having a bit of trouble understanding this comment.
Here we are sending an ownership message.
Have we (also) received a response from firmware?

> +	fbd->prev_firmware_time = 0;
> +
>  	/* Set heartbeat detection based on if we are taking ownership */
>  	fbd->fw_heartbeat_enabled = take_ownership;
>  
> @@ -671,6 +676,9 @@ static int fbnic_fw_parse_ownership_resp(void *opaque,
>  	/* Count the ownership response as a heartbeat reply */
>  	fbd->last_heartbeat_response = jiffies;
>  
> +	/* Capture firmware time for logging and firmware crash check */
> +	fbd->firmware_time = fta_get_uint(results, FBNIC_FW_HEARTBEAT_UPTIME);

Maybe FBNIC_FW_OWNERSHIP_UPTIME?

> +
>  	return 0;
>  }
>  
> @@ -685,6 +693,9 @@ static int fbnic_fw_parse_heartbeat_resp(void *opaque,
>  
>  	fbd->last_heartbeat_response = jiffies;
>  
> +	/* Capture firmware time for logging and firmware crash check */
> +	fbd->firmware_time = fta_get_uint(results, FBNIC_FW_HEARTBEAT_UPTIME);
> +
>  	return 0;
>  }

...

