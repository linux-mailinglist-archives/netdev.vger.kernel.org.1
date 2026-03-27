Return-Path: <netdev+bounces-272502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK88Lhpfxmm+JAUAu9opvQ
	(envelope-from <netdev+bounces-272502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:42:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E70342BF4
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EA93302FAAC
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080F53DCDAA;
	Fri, 27 Mar 2026 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfa2zwRV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAFE33D6F8
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608151; cv=none; b=gKTjlt7jVxaF1RLPky34vNhFAVYBnvgLxvNhKCbrGs4UfzqGigePYHOH8/2Rswh1W8KhrD7/IA7AW7/njsd+3jFjJyabsaq4gViZTKjsr/n9kRjjrU/ggUkoQAG0t6ekARpvIVTV+QO+NxcPyFnwrL1rSOZ0Q0rl+yI7yk9iLoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608151; c=relaxed/simple;
	bh=VRPQa153BmsRdQ41Ha8e5bRpzNA1GOP6vDNjJZFcIh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyMIDZhueQthes2otqJF8jHJKEGn8QS6MvYfPTIcizZylXvYfWn05Jja76R/DwpOxMnl2U1M0jxA3aFmqofyf1XqvEzBN32dVf8b9zTZkFwrUu45U5U+uQp06HxLQpCd9uPbBgO0pUpaAjN02wIp07Fek7LFgYDuwreaEtnPt+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfa2zwRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06015C19423;
	Fri, 27 Mar 2026 10:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774608151;
	bh=VRPQa153BmsRdQ41Ha8e5bRpzNA1GOP6vDNjJZFcIh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hfa2zwRVEK4BUP3GzGhn16aq8LhGGnedGGYuIR6pD5NDJEPrKy/zrmnwnhB8Sq/vH
	 pQ/nY1KfuD0AAJVslO6YvyBrAV8eM8vqqBQvd3xGboTjDGy/Ny+3XJbxL0qOgHOG8t
	 zGSXa62TlWXUtRmIxRe3UAd5Tinux5OZHL/ncTwVy4JHCaIXyU98q98AIVJOSjeit4
	 bBVP4D2DJDEDD4XlwaaRafZoDtwyZAbT6QLg24wOsBNAqmqxXpcu2sd8ZBOSIBokRi
	 ZX41skMUDHCGdU2CWPpD4OBFy5f4xuZ3qawmTb9o1zl38SiLckoK/l18SK6qXDhUdv
	 JAn5PowJI8jXg==
Date: Fri, 27 Mar 2026 10:42:26 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	mbloch@nvidia.com, admiyo@amperemail.onmicrosoft.com,
	ben.copeland@linaro.org
Subject: Re: [PATCH net-next] mlx5: shd: Gracefully avoid shared devlink
 creation when no usable SN is found
Message-ID: <20260327104226.GA567789@horms.kernel.org>
References: <20260325152801.236343-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325152801.236343-1-jiri@resnulli.us>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272502-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,onmicrosoft.com:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: F0E70342BF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 04:28:01PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> On some HW, not even fall-back "SERIALNO" is found in VPD data. Unify
> the behavior with the case there are no VPD data at all and avoid
> creation of shared devlink instance.
> 
> Fixes: 2a8c8a03f306 ("net/mlx5: Add a shared devlink instance for PFs on same chip")
> Reported-by: Adam Young <admiyo@amperemail.onmicrosoft.com>
> Closes: https://lore.kernel.org/all/bab5b6bc-aa42-4af1-80d1-e56bcef06bc2@amperemail.onmicrosoft.com/
> Reported-by: Ben Copeland <ben.copeland@linaro.org>
> Closes: https://lore.kernel.org/all/20260324151014.860376-1-ben.copeland@linaro.org/
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


