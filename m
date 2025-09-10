Return-Path: <netdev+bounces-221658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C868FB51735
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 14:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96D91BC149D
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 12:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15826315D59;
	Wed, 10 Sep 2025 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AXdWRiC5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F44311971
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508429; cv=none; b=nj2rPcuey0QvzvwPY4WWrqzXZbpbwDeNhqOc/OnY9uycmphNoIZQ7q82FjZn07pSPDL3PuGwswnlyPmOa6NSUz9IGC6ZkvwJrrOjNkwT1HyiQNxJKOjvTXOfOnO/o8SGqbkkGsDI20TJ7S6NKBLWjLRM8P8xnjbKeQEifXfCu7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508429; c=relaxed/simple;
	bh=3Sa4IjoWHAD2sMCCd8xjvjwc5FJ9+WS1ZXKgSE44sME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kC8mDbaOEDSm5KgAC3fCmCoedE0ePrnVJ030D8ENVO1TTnovYFys9W8IQWKQCM9TD0+XX41835sWCbdIWlFtu0x6VOEnNKumH7u4FmOeA8fpRrXR8QHDzV1bgzVWWvu3NEO/emH3Z0H3T1D2dDuCfmS5LiadqG7NhpuCbsQakWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=AXdWRiC5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HHU0n2ytUZeOyG9gBmJyegmTh9z7Ah2Y4C81Ht+L6Ms=; b=AXdWRiC59Mc4mYO+gpZRTaPjIp
	S1Lxohf9UgqdS7FjTPgL3syfJfiPl8d5+rX2gYZlI9XrBacV+lCEIxiRxIBsLy7RkDkDEBsv3JlMf
	7DpWDz0RMdjl5z3x5OCE49eG/Bm+Al+atute8c2znK5+XEyUX/IAtR/yanXyj2Cs+NSJJMiL+aKBr
	WlsSaqGq3kUBQmvhg3u1Ga774V6a+EdMRE1E5jipyzWvcAguESx4pUYtAbvrK/aXrEpZNPo2jU5xe
	Ej/MTEfiWi4YB09kAbR76oA2bf7yWgEQ1ToBR6YvQUoTn420/EZ6d4Bfhrt7qT+PxaFjj3CSrtX+D
	BzmMn9KA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57174)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uwKDy-000000001cz-3NZR;
	Wed, 10 Sep 2025 13:46:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uwKDv-000000001PN-3Hbw;
	Wed, 10 Sep 2025 13:46:55 +0100
Date: Wed, 10 Sep 2025 13:46:55 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Shannon Nelson <sln@onemain.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] net: ethtool: fix wrong type used in struct
 kernel_ethtool_ts_info
Message-ID: <aMFzP6GFj1jVO6Qs@shell.armlinux.org.uk>
References: <E1uvMEK-00000003Amd-2pWR@rmk-PC.armlinux.org.uk>
 <20250909163302.7e03d232@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909163302.7e03d232@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 09, 2025 at 04:33:02PM -0700, Jakub Kicinski wrote:
> On Sun, 07 Sep 2025 21:43:20 +0100 Russell King (Oracle) wrote:
> > In C, enumerated types do not have a defined size, apart from being
> > compatible with one of the standard types. This allows an ABI /
> > compiler to choose the type of an enum depending on the values it
> > needs to store, and storing larger values in it can lead to undefined
> > behaviour.
> > 
> > The tx_type and rx_filters members of struct kernel_ethtool_ts_info
> > are defined as enumerated types, but are bit arrays, where each bit
> > is defined by the enumerated type. This means they typically store
> > values in excess of the maximum value of the enumerated type, in
> > fact (1 << max_value) and thus must not be declared using the
> > enumated type.
> > 
> > Fix both of these to use u32, as per the corresponding __u32 UAPI type.
> > 
> > Fixes: 2111375b85ad ("net: Add struct kernel_ethtool_ts_info")
> 
> Do you feel strongly about this being a fix? (I can adjust when
> applying FWIW). It's clearly not great but I don't think storing
> a mask of enum values cause functional problems.

Whether or not it causes problems depends whether we have any compilers
that are used for the kernel which select the size of an enum type
based on the value.

From what I recall, when EABI for ARM was being talked about, that
compiler behaviour was certainly on the table. I opposed it - and
we ended up with arm-linux and arm-none variants of EABI. Whether
there's still a difference today, I'm not sure.

Even without Fixes: I think you'll find that the stable autosel bot
will still pick this change up... it uses "AI".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

