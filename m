Return-Path: <netdev+bounces-155237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7193FA017C2
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 02:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9991883928
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FD85473C;
	Sun,  5 Jan 2025 01:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzldYET2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23D949652;
	Sun,  5 Jan 2025 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736041504; cv=none; b=nUA+T3E4C0Q7FcKRsP/g1pQJa09OO6G2sN94Bw3dOgdHDEo969Pq8xhOwKqM3y3MfCdDcfHaZ3rGLBvu2gd4kpb/I04bT5R+pmMf6EoK+sZgJGvgXBStOMnWMOUxhSykFEDdq+xWnzVLqaIiTaLN0HUT1hfL0jVEQtCwBVPDvaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736041504; c=relaxed/simple;
	bh=oq/Zazx3snTJ//HvVkRX0cBRbpMDsarbsm2tecQIdeI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7OC3qYRnEYOxNCWLbe/TE1QNcHiyTmMVioduT3iN8QZ5CZ7W7l+riyC9t+lAQYHl2cRxRetkD7QfpFtgSf9tNNSGxvpSZX2+frV6UvdX4YSJmAIW43uZLLprN0UosGgYeJCvts9tXdUmV7jztGYhXoHbHNktKCF/LuI/iLVMIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzldYET2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE66C4CED1;
	Sun,  5 Jan 2025 01:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736041504;
	bh=oq/Zazx3snTJ//HvVkRX0cBRbpMDsarbsm2tecQIdeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dzldYET2emHDIAf7pzP0JoImS29VgCeY5/sCXhrOSKaxR6uYeadUuElqftv4FLpGK
	 fLXF6VYE8kqqFAQgqJ5ZPUAl6NcPe4N8yw63oF0pCNU7QCaQ3rUiaqrNkXAGZSAUpe
	 pOml0TNelBOAPn8HO/MR/lobpU5ydKFYEuhZIIkndr2ok5amNRxKyyog/lE+QZ4Tz3
	 Xt7sYf0lK3xoiLYHzahbLj3ljbjWtL4Z0eZvM4y4hwfBhihxbDjXJwBNr5R9HSE9Zb
	 BZ6sVBRhXiQBLYpjk3km+425LXrZTM4OXYTHXwruV2TsbfxR1OMLFbkqUDq/PcpCaw
	 W4mevP1ED11vQ==
Date: Sat, 4 Jan 2025 17:45:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next 04/13] net: enetc: add MAC filter for i.MX95
 ENETC PF
Message-ID: <20250104174502.0d43e7c0@kernel.org>
In-Reply-To: <20250103060610.2233908-5-wei.fang@nxp.com>
References: <20250103060610.2233908-1-wei.fang@nxp.com>
	<20250103060610.2233908-5-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Jan 2025 14:06:00 +0800 Wei Fang wrote:
> The i.MX95 ENETC supports both MAC hash filter and MAC exact filter. MAC
> hash filter is implenented through a 64-bits hash table to match against
> the hashed addresses, PF and VFs each have two MAC hash tables, one is
> for unicast and the other one is for multicast. But MAC exact filter is
> shared between SIs (PF and VFs), each table entry contains a MAC address
> that may be unicast or multicast and the entry also contains an SI bitmap
> field that indicates for which SIs the entry is valid.
> 
> For i.MX95 ENETC, MAC exact filter only has 4 entries. According to the
> observation of the system default network configuration, the MAC filter
> will be configured with multiple multicast addresses, so MAC exact filter
> does not have enough entries to implement multicast filtering. Therefore,
> the current MAC exact filter is only used for unicast filtering. If the
> number of unicast addresses exceeds 4, then MAC hash filter is used.
> 
> Note that both MAC hash filter and MAC exact filter can only be accessed
> by PF, VFs can notify PF to set its corresponding MAC filter through the
> mailbox mechanism of ENETC. But currently MAC filter is only added for
> i.MX95 ENETC PF. The MAC filter support of ENETC VFs will be supported in
> subsequent patches.

clang reports:

drivers/net/ethernet/freescale/enetc/enetc4_pf.c:1158:6: warning: variable 'pf' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
 1158 |         if (err)
      |             ^~~
drivers/net/ethernet/freescale/enetc/enetc4_pf.c:1179:24: note: uninitialized use occurs here
 1179 |         enetc4_pf_struct_free(pf);
      |                               ^~
drivers/net/ethernet/freescale/enetc/enetc4_pf.c:1158:2: note: remove the 'if' if its condition is always false
 1158 |         if (err)
      |         ^~~~~~~~
 1159 |                 goto err_wq_task_init;
      |                 ~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/freescale/enetc/enetc4_pf.c:1128:21: note: initialize the variable 'pf' to silence this warning
 1128 |         struct enetc_pf *pf;
      |                            ^
      |                             = NULL
-- 
pw-bot: cr

