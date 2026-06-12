Return-Path: <netdev+bounces-298782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NIduG9FgLGqnQAQAu9opvQ
	(envelope-from <netdev+bounces-298782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:41:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9968D67C1D0
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:41:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=oLmilcZJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298782-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298782-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5BE03017038
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49322377039;
	Fri, 12 Jun 2026 19:40:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB6D38F923
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 19:39:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293200; cv=none; b=IwDFttiAFFzXPcnSea2LZrjgOB/jt1PTi+nydM4ZOAW+EqkQCQVpwyr/ABYqkdQWl3COrZNWbsMYEDdrMlFMS917pAOIBUGPPqpH3lB2kvOoMf3f44wADx04CXEAkne8QU4iVCQ+whwfWBuL08gDnL4bWRLWCYmTXDdewspuhp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293200; c=relaxed/simple;
	bh=ga2Oc71UKiHByJauvwwdS3L1tRc9XCRZ/M0bjoo/n6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPW3gXKNzRtqR/+l576qxq6liBnk2NI5M+hnwwKSvQIZ8NUsW9b5b1ElJ+kuAnigS71BLmy8lfs0v4XBFycSskRKwrdn3D/qDONnU8Hlt+0Apb1zanQIYf9gEy2R6/Zb95GBbwoBvtRWtJhyOZ1//6gWHU5EwF20055J8uOzBww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oLmilcZJ; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hv2Ow1ld1FBUX1iqO/T7CKESCohHcY+IkpgYqfsRrnc=; b=oLmilcZJHC5mGFs6JJJ0s6vrsu
	YB3UlQjW5U1FjMgov8M4nv45kbrx2hfZhqBBzyksSXOMmk+/Zk6Mc5k1Vhr/rjypTtmNSjiSdxBLN
	vvlWO++6qr9ZJVyfG7wzA18Q7wswivM42r1kjpPYtYFcUWvWxaMREB7AGEXPQxrU2Rxs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wY7jD-007NEZ-SH; Fri, 12 Jun 2026 21:39:43 +0200
Date: Fri, 12 Jun 2026 21:39:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rongguang Wei <clementwei90@163.com>
Cc: przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: Re: [PATCH net-next v1] e1000: Initialize phy_data to avoid
 unexpected values
Message-ID: <1578c474-ffbf-46f7-b906-49da4ea48142@lunn.ch>
References: <20260612080331.120096-1-clementwei90@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612080331.120096-1-clementwei90@163.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:clementwei90@163.com,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:weirongguang@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298782-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9968D67C1D0

On Fri, Jun 12, 2026 at 04:03:31PM +0800, Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> The phy_data variable is not initialized. If e1000_read_phy_reg
> returns an error, phy_data will not point to a valid value from
> the PHY register, which may cause the regs_buff array to be populated
> with unexpected values.
> 
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
> Change-Id: I46071b3b21a566f8da650168d38d6968251b077d

What does this Change-Id mean?

> ---
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> index 4dcbeabb3ad2..f068108c5004 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
> @@ -327,7 +327,7 @@ static void e1000_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
>  	struct e1000_adapter *adapter = netdev_priv(netdev);
>  	struct e1000_hw *hw = &adapter->hw;
>  	u32 *regs_buff = p;
> -	u16 phy_data;
> +	u16 phy_data = 0;

	if (hw->phy_type == e1000_phy_igp) {
		e1000_write_phy_reg(hw, IGP01E1000_PHY_PAGE_SELECT,
				    IGP01E1000_PHY_AGC_A);
		e1000_read_phy_reg(hw, IGP01E1000_PHY_AGC_A &
				   IGP01E1000_PHY_PAGE_SELECT, &phy_data);
		regs_buff[13] = (u32)phy_data; /* cable length */

Isn't a cable length of 0 also unexpected?

How does this patch actually make the situation better?

    
    Andrew

---
pw-bot: cr

