Return-Path: <netdev+bounces-110306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0FA92BCB6
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 16:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E9A4B2929A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE0415B980;
	Tue,  9 Jul 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0SipaOi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0566718E76F;
	Tue,  9 Jul 2024 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720534728; cv=none; b=HLstgMHDAB25ykIysQJoQ2kU7bfXozVtEBGlcpDuF0wFN+RwOrqX9UNjhmKG1EctdQeEI9FCzkhfLRaFsQaU6EcbhwXd1ly4CSqplJF06DRuDgl5Zk1rFBfzurmKg2Ph9AIFkDsjQl/vxc3mpptxYBbbKIqEBDxT2YUVd5QhVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720534728; c=relaxed/simple;
	bh=0i6utTeX8DsPV7/9WcDwrn3XMqTdMQ92uqBdyZ9F1mo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJIID2jFdmEOTXln9al5OzOzekEkreZgESXc1PLmds47RnFKtWRoyF/NzKHB38RcmSvN67TWAIvQCUgfJHU1vtdzbZnSRTSpsnqN1MC1KDYzdeDbay2SYDOzYM0igg4n2TlKrU+9zQ8LHeR6lE3/VlDaHhj8fT/brzhE9nbVtWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0SipaOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3795CC4AF0D;
	Tue,  9 Jul 2024 14:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720534727;
	bh=0i6utTeX8DsPV7/9WcDwrn3XMqTdMQ92uqBdyZ9F1mo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b0SipaOiY6nCFMPx/id9nUCE1pzdR0Redys/TlMqLvYNG9PWYb6mWLAqm2MzyxxRs
	 w2Uimh+A1WonyA+XR+W4F0ihJtL75HhEb089xfFbkAwDi0tsV4DPBm4RUXC5RQaphi
	 untPjtavermqv63+y44cHCDyR27fZTu6ikoPxzSi/AaK0GFVbQePO0JkDGVN4smzBS
	 8ariXvfnPPi3Jh5Lq/a5Q50MXRccrpVDzgr5PcsmM6HR8X8Ft82L/dGE7y5hZO2B7+
	 nmTTjs6QdxdWZvddeIJw4thNsjnEJ1cKOdkuxhZzzCejBd5kiiQx5Pr1FAK5Be9cAo
	 bB9ugwNiEEfJQ==
Date: Tue, 9 Jul 2024 07:18:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 thomas.petazzoni@bootlin.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: ethtool: pse-pd: Fix possible null-deref
Message-ID: <20240709071846.7b113db7@kernel.org>
In-Reply-To: <20240709131201.166421-1-kory.maincent@bootlin.com>
References: <20240709131201.166421-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jul 2024 15:12:01 +0200 Kory Maincent wrote:
> Fix a possible null dereference when a PSE supports both c33 and PoDL, but
> only one of the netlink attributes is specified. The c33 or PoDL PSE
> capabilities are already validated in the ethnl_set_pse_validate() call.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20240705184116.13d8235a@kernel.org/
> Fixes: 4d18e3ddf427 ("net: ethtool: pse-pd: Expand pse commands with the PSE PoE interface")
> ---
>  net/ethtool/pse-pd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
> index 2c981d443f27..9dc70eb50039 100644
> --- a/net/ethtool/pse-pd.c
> +++ b/net/ethtool/pse-pd.c
> @@ -178,9 +178,9 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
>  
>  	phydev = dev->phydev;
>  	/* These values are already validated by the ethnl_pse_set_policy */
> -	if (pse_has_podl(phydev->psec))
> +	if (tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL])
>  		config.podl_admin_control = nla_get_u32(tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL]);
> -	if (pse_has_c33(phydev->psec))
> +	if (tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL])
>  		config.c33_admin_control = nla_get_u32(tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL]);
>  
>  	/* Return errno directly - PSE has no notification */

At a glance this doesn't follow usual ethtool flow.
If user doesn't specify a value the previous configuration should be
kept. We init config to 0. Is 0 a special value for both those params
which tells drivers "don't change" ?
Normal ethtool flow is to first fill in the data with a ->get() then
modify what user wants to change.

Either we need:
 - an explanation in the commit message how this keeps old config; or
 - a ->get() to keep the previous values; or
 - just reject setting one value but not the other in
   ethnl_set_pse_validate() (assuming it never worked, anyway).

