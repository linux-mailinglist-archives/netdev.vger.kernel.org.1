Return-Path: <netdev+bounces-65872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3001A83C1A6
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 13:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D2ADB217C8
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 12:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52553376E1;
	Thu, 25 Jan 2024 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdJsTM/7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA8A36B0E
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184545; cv=none; b=uR7QpAyEBD+DOXDJekbPdSD2ndW77BHS4FUTce0yITirsr/9hepSvYj6gu4GMGFbGS7fIVvP88MMjGP5kRWji14IcnxkfDW11xrDJUOo3gquR1W5tb4CVuXuu7KWLqgEr2z/6DLNH6Kpcnx/snWw6cBv+TzInekmJaxdC0PZrM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184545; c=relaxed/simple;
	bh=a9SclDCdnk4tHjqsJqgvGigpEtxz5IrfAxZl4F7PZ/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHL7BblgcjnuBkYc4ibAcIaY/K8FYbCZcoQG4OpGuoZTyleSzdMhMW125ZAyVmfXwsOz30eNxq0rPibHSY8mx5jmPf59JdUdbNZatoHcrlY5ESwuLidOwrMoakVP+apIg5paaBXXAPeVx0fTzh7MF1pYBaZN/DL+RN7dpNA7JPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdJsTM/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2455C433C7;
	Thu, 25 Jan 2024 12:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706184544;
	bh=a9SclDCdnk4tHjqsJqgvGigpEtxz5IrfAxZl4F7PZ/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VdJsTM/7dTMeWXhojPsQqkFjier0OEdHskQoy7nPVDHIC1ayRkD5fO7PBQdEm0EUx
	 Chl7f5HNKxx5XC57Q1iIeH9LK3aYIL//JzDtgggyph/tfAhFS/Fc27FBskNZkmwgga
	 bOtCHskwb/NPg7Cc2NxxhcyiTR13t1zKbumyCPWE5WK6QYnh++XfFIH8wKMYq4xIcY
	 LrBg4hqMsACk0M218ogKLyNnVL9+8aHg9AjMpwivWJPmbxcIVU/RFfUMrL6olEBu50
	 MV9lWVPsSEpx6eIglX3ea2Fcr231T4vIoRGZLeSvQTGsWQJFCpLX/s8VHvkGxcep35
	 uj4F89+K+8Nbg==
Date: Thu, 25 Jan 2024 12:09:00 +0000
From: Simon Horman <horms@kernel.org>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] taprio: validate TCA_TAPRIO_ATTR_FLAGS
 through policy instead of open-coding
Message-ID: <20240125120900.GM217708@kernel.org>
References: <20240124092118.8078-1-alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124092118.8078-1-alessandromarcolini99@gmail.com>

On Wed, Jan 24, 2024 at 10:21:18AM +0100, Alessandro Marcolini wrote:
> As of now, the field TCA_TAPRIO_ATTR_FLAGS is being validated by manually
> checking its value, using the function taprio_flags_valid().
> 
> With this patch, the field will be validated through the netlink policy
> NLA_POLICY_MASK, where the mask is defined by TAPRIO_SUPPORTED_FLAGS.
> The mutual exclusivity of the two flags TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD
> and TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST is still checked manually.
> 
> Changes since RFC:
> - fixed reversed xmas tree
> - use NL_SET_ERR_MSG_MOD() for both invalid configuration
> 
> Changes since v1 (https://lore.kernel.org/netdev/b90a8935-ab4b-48e2-a21d-1efc528b2788@gmail.com/T/#t):
> - Changed NL_SET_ERR_MSG_MOD to NL_SET_ERR_MSG_ATTR when wrong flags
>   issued
> - Changed __u32 to u32
> 
> Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>

...

> @@ -1863,12 +1827,28 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
>  	if (tb[TCA_TAPRIO_ATTR_PRIOMAP])
>  		mqprio = nla_data(tb[TCA_TAPRIO_ATTR_PRIOMAP]);
>  
> -	err = taprio_new_flags(tb[TCA_TAPRIO_ATTR_FLAGS],
> -			       q->flags, extack);
> -	if (err < 0)
> -		return err;
> +	/* The semantics of the 'flags' argument in relation to 'change()'
> +	 * requests, are interpreted following two rules (which are applied in
> +	 * this order): (1) an omitted 'flags' argument is interpreted as
> +	 * zero; (2) the 'flags' of a "running" taprio instance cannot be
> +	 * changed.
> +	 */
> +	taprio_flags = tb[TCA_TAPRIO_ATTR_FLAGS] ? nla_get_u32(tb[TCA_TAPRIO_ATTR_FLAGS]) : 0;
>  
> -	q->flags = err;
> +	/* txtime-assist and full offload are mutually exclusive */
> +	if ((taprio_flags & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST) &&
> +	    (taprio_flags & TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)) {
> +		NL_SET_ERR_MSG_ATTR(extack,
> +				    "TXTIME_ASSIST and FULL_OFFLOAD are mutually exclusive");

Hi Alessandro,

Perhaps there was an uncommitted local change, but
I think an attribute is required as the second argument to
NL_SET_ERR_MSG_ATTR(). Without that I see this code fails to compile.

> +		return -EINVAL;
> +	}
> +
> +	if (q->flags != TAPRIO_FLAGS_INVALID && q->flags != taprio_flags) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Changing 'flags' of a running schedule is not supported");
> +		return -EOPNOTSUPP;
> +	}
> +	q->flags = taprio_flags;
>  
>  	err = taprio_parse_mqprio_opt(dev, mqprio, extack, q->flags);
>  	if (err < 0)

-- 
pw-bot: changes-requested

