Return-Path: <netdev+bounces-107410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E76291AE42
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 19:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE441C22D84
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732631AAE06;
	Thu, 27 Jun 2024 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXOxwct0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B31A8C3F
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509635; cv=none; b=aqzfA8jr1hpUZslqKWwTMigkfolJhvDTrTN9laneQxl8qD2r/xcckfV9Bp/fG8pxOlHa3jyiJThoB8EJL+R9GCBbvrlNRSwTqoj7t6EV+UmdOGoYqKoWwdua7kuApJgr3veIOFs70we4J4BYNQhppGIvXSQZilyl2bax0qP5l3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509635; c=relaxed/simple;
	bh=xW8BSegUXXjq3l04zqHTpEkRmdEOsnKZFH7nYj0E+y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkELuiN22/Mgfm1QLuAuSolAjDTFu4ddG9MePf0QVM9rcyUip4qTACtYDTfV0e++5d4VUOO+nOr9Vpi9KbaFnryEuI9d2GARWCo6iDfUFKV5Nq56LATCzI5wRtzFSLEVOeghBR7WkzB4qRK+9YXxlY1khHhcmhHzMb2FvE+LMw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXOxwct0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8ECC2BBFC;
	Thu, 27 Jun 2024 17:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719509635;
	bh=xW8BSegUXXjq3l04zqHTpEkRmdEOsnKZFH7nYj0E+y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gXOxwct0z4Icgj6y53z/0eBDvHlpikw1G+ZjekhY+sDLZN1Cgr0WvrJt1KJ1z4f5H
	 tyyPkbL8jFSxMxHu8z5j4sjcPYOY+5u1Nz9wU6VsRFaILhLX9ISxVXBC9Iq1W++twg
	 ZiIRxwduInRoK/cFSZ65TdRgBIr531StNnkXMJ6sC/CU8HknL53T7tSXieyo+YN1wx
	 aXwqEPY9JQ/Pnoz1ZsdygVozGXSABelLr0gwD4pdzNYJltnV//dd1ivaIohmYfjadQ
	 8OkVsUvChWLaeX0wT4RKgomsj8oGZVuzurhSg0K/28rJ5dq2CiKEOMsAPC0C0Qy0A3
	 /rPvDGoEScc3Q==
Date: Thu, 27 Jun 2024 18:33:51 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Kelvin Kang <kelvin.kang@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH iwl-net v5] i40e: fix: remove needless retries of NVM
 update
Message-ID: <20240627173351.GH3104@kernel.org>
References: <20240625184953.621684-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625184953.621684-1-aleksandr.loktionov@intel.com>

On Tue, Jun 25, 2024 at 08:49:53PM +0200, Aleksandr Loktionov wrote:
> Remove wrong EIO to EGAIN conversion and pass all errors as is.
> 
> After commit 230f3d53a547 ("i40e: remove i40e_status"), which should only
> replace F/W specific error codes with Linux kernel generic, all EIO errors
> suddenly started to be converted into EAGAIN which leads nvmupdate to retry
> until it timeouts and sometimes fails after more than 20 minutes in the
> middle of NVM update, so NVM becomes corrupted.
> 
> The bug affects users only at the time when they try to update NVM, and
> only F/W versions that generate errors while nvmupdate. For example, X710DA2
> with 0x8000ECB7 F/W is affected, but there are probably more...
> 
> Command for reproduction is just NVM update:
>  ./nvmupdate64
> 
> In the log instead of:
>  i40e_nvmupd_exec_aq err I40E_ERR_ADMIN_QUEUE_ERROR aq_err I40E_AQ_RC_ENOMEM)
> appears:
>  i40e_nvmupd_exec_aq err -EIO aq_err I40E_AQ_RC_ENOMEM
>  i40e: eeprom check failed (-5), Tx/Rx traffic disabled
> 
> The problematic code did silently convert EIO into EAGAIN which forced
> nvmupdate to ignore EAGAIN error and retry the same operation until timeout.
> That's why NVM update takes 20+ minutes to finish with the fail in the end.
> 
> Fixes: 230f3d53a547 ("i40e: remove i40e_status")
> Co-developed-by: Kelvin Kang <kelvin.kang@intel.com>
> Signed-off-by: Kelvin Kang <kelvin.kang@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Hi Aleksandr,

Maybe I'm reading things wrong, I have concerns :(

Amongst other things, the cited commit:
1. Maps a number of different I40E_ERR_* values to -EIO; and
2. Maps checks on different I40E_ERR_* values to -EIO

My concern is that the code may now incorrectly match against -EIO
for cases where it would not have previously matched when more
specific error codes.

In the case at hand:
1. -EIO is returned in place of I40E_ERR_ADMIN_QUEUE_ERROR
2. i40e_aq_rc_to_posix checks for -EIO in place of I40E_ERR_ADMIN_QUEUE_TIMEOUT

As you point out, we are now in a bad place.
Which your patch addresses.

But what about a different case where:
1. -EIO is returned in place of I40E_ERR_ADMIN_QUEUE_TIMEOUT
2. i40e_aq_rc_to_posix checks for -EIO in place of I40E_ERR_ADMIN_QUEUE_TIMEOUT

In this scenario the, the code without your patch is correct,
and with your patch it seems incorrect.

Perhaps only the scenario you are fixing occurs.
If so, all good. But it's not obvious to me that is the case.

I'm likewise concerned by other conditions on -EIO
introduced by the cited commit.

> ---
> v4->v5 commit message update
> https://lore.kernel.org/netdev/20240618132111.3193963-1-aleksandr.loktionov@intel.com/T/#u
> v3->v4 commit message update
> v2->v3 commit messege typos
> v1->v2 commit message update
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> index ee86d2c..55b5bb8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> @@ -109,10 +109,6 @@ static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
>  		-EFBIG,      /* I40E_AQ_RC_EFBIG */
>  	};
>  
> -	/* aq_rc is invalid if AQ timed out */
> -	if (aq_ret == -EIO)
> -		return -EAGAIN;
> -

Perhaps it has already been covered, but with this change the aq_ret
argument of this function is longer used.  It could be removed as a
follow-up for iwl-next.

>  	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
>  		return -ERANGE;
>  
> -- 
> 2.25.1
> 
> 

