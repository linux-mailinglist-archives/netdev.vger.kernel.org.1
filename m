Return-Path: <netdev+bounces-122570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE64961C26
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 04:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF1CB22914
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 02:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF7D2D045;
	Wed, 28 Aug 2024 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zpg+1xQm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A86347C7;
	Wed, 28 Aug 2024 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724812407; cv=none; b=a1F5Gy0bRB7JlbKRQ35rRZlmrfFZhMyh+lHyfHSGzdPs/OR33VCf9fKM2uILdhxnnsjfgCYUszN0eMDGosRLSRdC4ZvsnF+P2TcQeYPqoKbgHImundSnspfKEHfb88A7rqDUWqA88hWxvy4Vt2bvWdO4sxJzAh8BkBqYsriWOlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724812407; c=relaxed/simple;
	bh=BlnQ9/MA5zhVMb7qNEM3QWamSDXMyB7WwKzyr5wNJfg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgo7+dbUfsKHdVfuXlVHabTjJNKawB/Gbf+okciIR7KOqpFN8TIhF/AM4ClJT/y7Z0qTJZz4+BbVUBTfVJ/VK/L57gyWeaxOmqo5Cjt4KhDv1dJbbHMhFn67lBVAzBsbYdC4GPwCqkg2JDSb8nlc8ejK0CqlGC1fArvUPzdz3K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zpg+1xQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99E2C32782;
	Wed, 28 Aug 2024 02:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724812407;
	bh=BlnQ9/MA5zhVMb7qNEM3QWamSDXMyB7WwKzyr5wNJfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zpg+1xQmhbfhfK/udVSLNKL3eD0W3nS6zHeSrYzuInLxkX6oGprrtyrSyGCQ+nAxW
	 01tkWvwwEnv7wTjEPIPbR1PiGb4SOZeqY7IQ7fOpRjFG66i6eqkDT0lHFteHeK2wcE
	 VhDrRvVwUfc1lNi9AP6n1Iw4h3hp+Ua24Vny2pBjEXRT7gROJmrDh2yOMrbgFVIffs
	 YVM+l5PAiRKTEHGo64HFr9hIlpNEopK9e8ZyuoPIGHCNjrV5xxql/mjoPCp/Uooh6v
	 nnU7FmGFHc6A2vchBb/2+zKE544KthJrAtakWnCdXTvGSGBrdFf/JDGlVv6M3kAEHm
	 Fsf5k/rgJ0pqA==
Date: Tue, 27 Aug 2024 19:33:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Diogo Jahchan Koike <djahchankoike@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>,
 syzbot+5cf270e2069645b6bd2c@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch net-next v2] ethtool: cabletest: fix wrong conditional
 check
Message-ID: <20240827193325.68bc341a@kernel.org>
In-Reply-To: <20240828021005.9886-1-djahchankoike@gmail.com>
References: <20240828021005.9886-1-djahchankoike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 23:09:19 -0300 Diogo Jahchan Koike wrote:
> In ethnl_act_cable_test_tdr, phydev is tested for the condition of being
> null or an error by checking IS_ERR_OR_NULL, however the result is being
> negated and lets a null phydev go through. Simply removing the logical
> NOT on the conditional suffices.
> 
> Reported-by: syzbot+5cf270e2069645b6bd2c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5cf270e2069645b6bd2c
> Fixes: 3688ff3077d3 ("net: ethtool: cable-test: Target the command to the requested PHY")
> Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
> ---
> The previous patch was sent without the appropriate tags, apologize for
> that.

You were already told by Eric not to repost within 24h.

https://lore.kernel.org/all/CANn89iJ0qNYP8zMz6jDtP2=n23emnue4m2tyJkE64QL_xiwc9Q@mail.gmail.com/

There's already a fix from Maxime pending for this:
https://lore.kernel.org/all/20240827092314.2500284-1-maxime.chevallier@bootlin.com/

I didn't need to see the tags to tell you this.

> diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
> index d365ad5f5434..f25da884b3dd 100644
> --- a/net/ethtool/cabletest.c
> +++ b/net/ethtool/cabletest.c
> @@ -346,7 +346,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
>  	phydev = ethnl_req_get_phydev(&req_info,
>  				      tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
>  				      info->extack);
> -	if (!IS_ERR_OR_NULL(phydev)) {
> +	if (IS_ERR_OR_NULL(phydev)) {
>  		ret = -EOPNOTSUPP;
>  		goto out_dev_put;
>  	}

-- 
pw-bot: nap
pv-bot: 24h

