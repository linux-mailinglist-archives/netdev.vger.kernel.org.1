Return-Path: <netdev+bounces-241866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E80A3C8995F
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 12:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D997E4E20AA
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 11:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F25324B34;
	Wed, 26 Nov 2025 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="k+oI7hx2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7886320A0D
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764157605; cv=none; b=u8DjPPZPuA+tMFHIYxlh4kX3biQqisNPdPHtpfDVmmvEHFeixOAOo88n3chrYCSmrHJSkE1G4CtwMGfGLqPPHNxkBTm4Hag1YqveT4FTb0LRGsPPWrZRWye+TCYgg/F87Yus/LGlA9xIRtZpDq/eW2pWbuvYH+MKSEWOuLyxQEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764157605; c=relaxed/simple;
	bh=4Eyv+Yv5XInFX+7bj1wjMfGMu8GrQe45JPpVsoZ8RHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqFuN+HABJ8Xc3SiKn0NOe22AVxanX9xUCf0A2L08NYW7CQnp32R6hunNEyoCE+nFXLl3bITcjQ+XHEdWYbfKMPzl7jvoxrenfs8+IBTo6pvroTCHZkU5FUm8VP1mIYzyMkm9GZvpyqhxb20pGsbnCZ5a6BEF3uynUkBhAewQW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=k+oI7hx2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=idZH2h/5MOn2BpvO2NsaMW9MH0PQn/xXe34joZcJV90=; b=k+oI7hx2JT1gTwNlxw/iufN1GT
	7bt0/SdgGFl5jlQEdkfaSucsJojlmITuzJwAn229N3JVCTWmhCnMfSZPeeh/ccu5uC9qEEcc8MXLp
	7FjQvYmR5gJQeJ6crmXSOMbMcKuRcuOqXqnhiQffmCeEYUsdeRF8AKlMEbUZyWpx1NWudpsImv9yg
	USevgdzZANgGK9MVBYLJwilcW/iTX37QoMpWvidMCi2rIsFEcIp1cM+9I1zcRGjMVf4VbaCr+J9MN
	eBrKYxh2q/KGiFxSfEE6/fKErhEuNP/VqFGrhyMpjesHyJH9K8omSJQozflB7ZRiHIbtn8SR7lHUP
	31XfM12w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41852)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vODyj-000000003vq-3gDf;
	Wed, 26 Nov 2025 11:46:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vODye-000000001gr-06HK;
	Wed, 26 Nov 2025 11:46:28 +0000
Date: Wed, 26 Nov 2025 11:46:27 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Jochen Henneberg <jh@henneberg-systemdesign.com>,
	Piotr Raczynski <piotr.raczynski@intel.com>
Subject: Re: [PATCH net-next] net: stmmac: fix rx limit check in
 stmmac_rx_zc()
Message-ID: <aSbok34XaG1DrlKp@shell.armlinux.org.uk>
References: <20251126104327.175590-1-aleksei.kodanev@bell-sw.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126104327.175590-1-aleksei.kodanev@bell-sw.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 26, 2025 at 10:43:27AM +0000, Alexey Kodanev wrote:
> The extra "count >= limit" check in stmmac_rx_zc() is redundant and
> has no effect because the value of "count" doesn't change after the
> while condition at this point.
> 
> However, it can change after "read_again:" label:
> 
>         while (count < limit) {
>             ...
> 
>             if (count >= limit)
>                 break;
>     read_again:
>             ...
>             /* XSK pool expects RX frame 1:1 mapped to XSK buffer */
>             if (likely(status & rx_not_ls)) {
>                 xsk_buff_free(buf->xdp);
>                 buf->xdp = NULL;
>                 dirty++;
>                 count++;
>                 goto read_again;
>             }
>             ...
> 
> This patch addresses the same issue previously resolved in stmmac_rx()
> by commit fa02de9e7588 ("net: stmmac: fix rx budget limit check").
> The fix is the same: move the check after the label to ensure that it
> bounds the goto loop.
> 
> Detected using the static analysis tool - Svace.
> Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> ---
> 
> After creating the patch, I also found the previous attempt to fix this issue
> from 2023, but I'm not sure what went wrong or why it wasn't applied:
> https://lore.kernel.org/netdev/ZBRd2HyZdz52eXyz@nimitz/

It was because:

https://lore.kernel.org/netdev/871qli0wap.fsf@henneberg-systemdesign.com/

indicated that the author was going to do further work on the patchset,
so the patch submission was marked as "Changes Requested":

https://patchwork.kernel.org/project/netdevbpf/list/?series=730639&state=*

My guess is the author never came back with any patches.

netdev is based on patchwork, which means once a patch series has been
marked in such a way that it isn't going to be applied, it won't get
looked at again, and it's up to the author to resubmit. If the author
doesn't resubmit, no action will happens, especially for a driver such
as stmmac which doesn't have a maintainer.

I think this is a safe change.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

