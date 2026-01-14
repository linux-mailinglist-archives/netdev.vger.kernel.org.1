Return-Path: <netdev+bounces-249709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE26D1C465
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 04:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F1013010AAB
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB872C3266;
	Wed, 14 Jan 2026 03:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gpu38sFC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E4227FB21
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768361904; cv=none; b=e8Dbg1cq5QSOXl89uFPL1IpifA0AkW81lHOtd+7ruTK+75tTU3Yvx1tBCBcYGL8yM3DFWvqO6HQsJx2Y30TLLS6oCnPOdutIfVr+SNj7Yz3zH9VfY9OqPaI3XcgPphjfmH/wEhMdvoKI084MbXWXUqFG1DmjKTjUE6XL57p6L+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768361904; c=relaxed/simple;
	bh=lPT5BE3PeQqfFRFIWWykPR23lK4xM2BkOdYn+eOOGXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoHJZhvW1HIPzizx3Wbu2tJ00MPipmG78ABz5B8iWywn0yBEchVBy5l7rtooITsJORX76ZNY3V99ro8pAGnW1HqzjGiHTJJXeFEe4sWtCf2L/+d5Pv07TBnVWuiXCtzy9ZVFG9o6AcLLa13kQ4J4SxoylIpYHbHwteL0N1c0sAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gpu38sFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680A3C4CEF7;
	Wed, 14 Jan 2026 03:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768361904;
	bh=lPT5BE3PeQqfFRFIWWykPR23lK4xM2BkOdYn+eOOGXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gpu38sFCEJFbspgdGnKfFBxiwMkIrc4oiSgLOQXZGN5SA5FVYPqoYd2JrY+bprB38
	 J7XvqTNRb3uyEu6iJMSiRcENOaHMmgJUJnGGpyFL8WO5DtNNc6j71vhrbwJD6NzMlB
	 viW9y3AXVllTOow9xGRZYq8m7wuJ7Gpa3lctQjGQt0GThDAwhy80BslFTb5zoMTNSS
	 NKmtncUVt1xJhxUakdNKxNPW5WXMVA/b3QwYjyLHZz9/OZBUOPHaxmhzXwffYO49Qn
	 KiaSijQI0yKP29gzynXIzWNIppZOV081oLf8sAPQMeuMq5L36vdUEtsZRiO4Dg3FD9
	 je7WFwJRrnp1g==
From: Jakub Kicinski <kuba@kernel.org>
To: mohsin.bashr@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	davem@davemloft.net,
	sanman.p211993@gmail.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	edumazet@google.com,
	lee@trager.us
Subject: Re: [net-next,V0.5,4/5] eth: fbnic: Remove retry support
Date: Tue, 13 Jan 2026 19:38:14 -0800
Message-ID: <20260114033814.1033266-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112211925.2551576-5-mohsin.bashr@gmail.com>
References: <20260112211925.2551576-5-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least pausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
    eth: fbnic: Update RX mbox timeout value

This commit unifies timeout values for firmware mailbox completion waits
by introducing a wrapper function fbnic_mbx_wait_for_cmpl(). However,
there appear to be two regressions where the condition logic was
accidentally inverted.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> index 1ecd777aaada..6b3fb163d381 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h

[ ... ]

> +static inline bool fbnic_mbx_wait_for_cmpl(struct fbnic_fw_completion *cmpl)
> +{
> +	return wait_for_completion_timeout(&cmpl->done,
> +					   FBNIC_MBX_RX_TO_SEC * HZ);
> +}

The wrapper returns the same value as wait_for_completion_timeout():
non-zero on success, zero on timeout.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> index b62b1d5b1453..193f554717b3 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> @@ -178,7 +178,7 @@ fbnic_flash_start(struct fbnic_dev *fbd, struct pldmfw_component *component)
>  		goto cmpl_free;
>
>  	/* Wait for firmware to ack firmware upgrade start */
> -	if (wait_for_completion_timeout(&cmpl->done, 10 * HZ))
> +	if (!fbnic_mbx_wait_for_cmpl(cmpl))
>  		err = cmpl->result;
>  	else
>  		err = -ETIMEDOUT;

Was the negation here intentional? The original code sets err to
cmpl->result when the completion succeeds (wait returns non-zero). With
the added negation, it now sets err to cmpl->result when the wait times
out (returns zero), and sets err to -ETIMEDOUT when the wait succeeds.
This appears to invert the success and timeout handling.

[ ... ]

> @@ -447,7 +447,7 @@ static int fbnic_fw_reporter_dump(struct devlink_health_reporter *reporter,
>  				goto cmpl_cleanup;
>  		}
>
> -		if (wait_for_completion_timeout(&fw_cmpl->done, 2 * HZ)) {
> +		if (!fbnic_mbx_wait_for_cmpl(fw_cmpl)) {
>  			reinit_completion(&fw_cmpl->done);
>  		} else {
>  			NL_SET_ERR_MSG_FMT_MOD(extack,
>  					       "Timed out waiting on core dump (%d/%d)",

Similarly here, the original code calls reinit_completion() when the wait
succeeds (to prepare for the next iteration), and reports "Timed out" in
the else branch when it fails. With the negation added, reinit_completion()
is now called on timeout, and the "Timed out" error message is reported
when the wait actually succeeds. Should the negation be removed from this
call site as well?
-- 
pw-bot: cr

