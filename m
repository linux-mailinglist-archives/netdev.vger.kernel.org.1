Return-Path: <netdev+bounces-244042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 516A0CAE543
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 23:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCA973032A88
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 22:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB612DC79A;
	Mon,  8 Dec 2025 22:34:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E4B1DB95E;
	Mon,  8 Dec 2025 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765233259; cv=none; b=opfFhBdYF6PxN8/nRelOl+Xspo9H8nq74wPGXx4aU1rINUYHo1K3sI+Ilurcd28C7Zav4ijkwZi1+uwnf7iRUgsrPu5nD6syXFuUJ9OegW0R/ofUkczLiXgtoXUy3W7DhKHzAA+nNEPhsVyy97WT5ZeLoE0nNPCqRUVi00jAgcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765233259; c=relaxed/simple;
	bh=Vu9HGTd9aJOrITisKT7t/YFzQLFe29f4rA/ydXXnp1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SrJC64INnt9L/FhURDqtpFRVWKNQG31opSebrJCMAFSMsyAUYH1S9U3WZRTTmYdkq5lvMatuzjlDE8bi0bb160TcTruZmHk+X2o12TvX9CvtXzzWgW58XhJ/KD0LMZurUju3yla27/n0WY3ICS6r+uM8H6cUUsAZGyGIflLlnFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af741.dynamic.kabel-deutschland.de [95.90.247.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8F76661CC3FE3;
	Mon, 08 Dec 2025 23:33:22 +0100 (CET)
Message-ID: <d360b246-b3cc-4ee6-81b3-b9a6eaa5a015@molgen.mpg.de>
Date: Mon, 8 Dec 2025 23:33:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [Patch net v2] ice: Fix incorrect timeout
 ice_release_res()
To: Ding Hui <dinghui@sangfor.com.cn>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251206134609.10565-1-dinghui@sangfor.com.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251206134609.10565-1-dinghui@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Hui,


Thank you for your patch. One minor comments, should you resend.

Am 06.12.25 um 14:46 schrieb Ding Hui:
> The commit 5f6df173f92e ("ice: implement and use rd32_poll_timeout for

Without article: Commit 5f6df173f92e ("…") …

> ice_sq_done timeout") converted ICE_CTL_Q_SQ_CMD_TIMEOUT from jiffies
> to microseconds.
> 
> But the ice_release_res() function was missed, and its logic still
> treats ICE_CTL_Q_SQ_CMD_TIMEOUT as a jiffies value.
> 
> So correct the issue by usecs_to_jiffies().
> 
> Found by inspection of the DDP downloading process.
> Compile and modprobe tested only.
> 
> Fixes: 5f6df173f92e ("ice: implement and use rd32_poll_timeout for ice_sq_done timeout")
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> ---
> v1->v2: rebase to net branch and add commit log.
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 046bc9c65c51..785bf5cc1b25 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -2251,7 +2251,7 @@ void ice_release_res(struct ice_hw *hw, enum ice_aq_res_ids res)
>   	/* there are some rare cases when trying to release the resource
>   	 * results in an admin queue timeout, so handle them correctly
>   	 */
> -	timeout = jiffies + 10 * ICE_CTL_Q_SQ_CMD_TIMEOUT;
> +	timeout = jiffies + 10 * usecs_to_jiffies(ICE_CTL_Q_SQ_CMD_TIMEOUT);
>   	do {
>   		status = ice_aq_release_res(hw, res, 0, NULL);
>   		if (status != -EIO)

With or without amending the commit message, feel free to add:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

