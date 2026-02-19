Return-Path: <netdev+bounces-259595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJmxCViLl2n/0AIAu9opvQ
	(envelope-from <netdev+bounces-259595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 23:14:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7438B16312C
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 23:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6385D3057EAE
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 22:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B251232AAC4;
	Thu, 19 Feb 2026 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNjkySNy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC0328B4E;
	Thu, 19 Feb 2026 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539249; cv=none; b=Fz2z2WOGaJX0TZG6Oh28KzQjw/BLlv35NQMVgOE/Zj50QF7ZGz3iYCZUIupUwkPlYrGIX6UTgFre86klIOKzoqXFReAVWSEI8U0t0WV9UdSqCDV4a6RdjoyizrHq3GpIr0OhLLaGdLtG9CRzdd0eMPdJWRwHKV4dG0r+S60T8sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539249; c=relaxed/simple;
	bh=BWG7i9FteAotwZgv9mf0jsGbtroT6PmHh4rsCMlUZpk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uG0QpwLTwNOJxmT8dOI2wQXCHQp+w5Vx76VKdJgfeZ72PHAeswfe84PL1MZVDFRbglmKWQ0TpqtVbKWfJKp6nYlBl4pNrxlqPYzualBZrQnZPbk0W6Stldns2iNCWB9jyl34U29RmPhMUznT1cNjBooXX4gJijWolhFyalws/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNjkySNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39BFC19424;
	Thu, 19 Feb 2026 22:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771539249;
	bh=BWG7i9FteAotwZgv9mf0jsGbtroT6PmHh4rsCMlUZpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WNjkySNynndmXVQbKm1LU2TmM9bdSMF+O5493mvWCNIpbEUt08LnGqEkwqSof7wEn
	 3sjJgiyhzWgmMdReyJi+JHhulPvbYLVpOeAHHKV8kAv3vK2xU+SG+OlBGjOrJkMxLN
	 1vjBoFulMb5HpSfvxA56ePHAwLxYv5Yr0GT7M+JwzCIbNCWkgCJmhLYsdBgRf0xs+S
	 Rs1SV5qcORzmBArNW8TdrBsz5F+e+tFAXA1yRu4GQJbfn5fQ8iBR/JD28BTmlNcj5R
	 g6X8zK5gu/YLFaN4xgLrV1EE2auCk4lJJnFNCDOBhyDzuA7reEMG9GRoR0l9HTUvT3
	 vXkPFcZ6Q/KxA==
Date: Thu, 19 Feb 2026 14:14:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Yuhao Jiang
 <danisjiang@gmail.com>
Subject: Re: [PATCH net] dpaa2-switch: validate num_ifs to prevent
 out-of-bounds write
Message-ID: <20260219141407.7fd697c0@kernel.org>
In-Reply-To: <SYBPR01MB788110DFE66BA1A5CE7E594FAF6DA@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB788110DFE66BA1A5CE7E594FAF6DA@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-259595-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 7438B16312C
X-Rspamd-Action: no action

On Tue, 17 Feb 2026 22:42:40 +0800 Junrui Luo wrote:
> The driver obtains sw_attr.num_ifs from firmware via dpsw_get_attributes()
> but never validates it against DPSW_MAX_IF (64). This value controls
> iteration in dpaa2_switch_fdb_get_flood_cfg(), which writes port indices
> into the fixed-size cfg->if_id[DPSW_MAX_IF] array. When firmware reports
> num_ifs >= 64, the loop can write past the array bounds.
> 
> Add a bound check for num_ifs in dpaa2_switch_init().
> 
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Reported-by: Junrui Luo <moonafterrain@outlook.com>

Please remove the self-referential reported-by tags. FWIW:
https://github.com/google/security-research/pull/334

> Fixes: f054e3e217e4 ("dpaa2-switch: refactor the egress flooding domain setup")

This commit looks like refactoring.
Please dig a bit deeper to find the real commit in which the bug was
added.

> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index 66240c340492..78e21b46a5ba 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -3034,6 +3034,13 @@ static int dpaa2_switch_init(struct fsl_mc_device *sw_dev)
>  		goto err_close;
>  	}
>  
> +	if (ethsw->sw_attr.num_ifs >= DPSW_MAX_IF) {

Unclear to me from a quick look at the code and the commit message why
we reject num_ifs == DPSW_MAX_IF. I see there are some references to a
control interface in egress flooding, is that why?

Please explain clearly.
-- 
pw-bot: cr

