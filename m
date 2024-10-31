Return-Path: <netdev+bounces-140607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ADC9B72B4
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 04:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39981F24CA5
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 03:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B0384E11;
	Thu, 31 Oct 2024 03:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewt8W3Zt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343951BD9EA;
	Thu, 31 Oct 2024 03:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730344005; cv=none; b=SYmQBi8seQj75lEQxLwoJ337oA7zzCNFfjxCdQ1QJEu5+v/kQ3y4ssTLOY0sQa49b+tiX3Skgl1kwQJfIHzqQ68aIL8zwAgR9ja037iQjR6gsB3QWo65hOkbRZd66/AxeugkRkkTZKV8QwrHFJjKJG9hjp8xq8IbBPi183vSbFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730344005; c=relaxed/simple;
	bh=0+87QNyXrcq66+VpqxO5RqGtaTNR33vzlhv46UBphfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZcaVM+FutdRCAaiNexJhrJIN9St6WiSOBHsz9kHdwj11l9YANLkcpOYB76J3CE1MmWIeKiwszYePdd3xww0SE4wTLb6uI6UcJ0pMzAAeXRnouD4Xq0Esti5q4FEY9L3yLH0AU4IvHnceUeMzjcIU4vrrRNzPo3VEvOs93nY6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewt8W3Zt; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so382477b3a.3;
        Wed, 30 Oct 2024 20:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730344002; x=1730948802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sallBo0D525QcqP1/P+ZmxEdEXJWaysONmrq+mBGLLU=;
        b=ewt8W3ZtO4l0g59NC/7GkXFgGIL1N7StqqNuD/LEUsZxOvsf/RRm4Zg2CW36T6pW2R
         EPtIbRDrhZiVN6XA/olFIHLJWy0pdA5Y3kQOY/A80QZZSMrp4hPwrk9gjrWz8GUGr8RG
         Cv5wOodqyN5/pE63htjXgZ+EKT2lq3vM0v/xCID3yY1lfx2/kO1I8Y7+digCLbBOAx1d
         EONWWTlXERQdIlI5ooepftYEA+TnE/7RYXzihaseeEZlOEejxs9pLiBf+VaUAc5zMcnX
         RBQUZ3p7Wf/Zshjssu543LNNIpHl/Pm+PXaiJoQe72A9OjDCIwNBtiDobxuI/wiZBbtf
         HPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730344002; x=1730948802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sallBo0D525QcqP1/P+ZmxEdEXJWaysONmrq+mBGLLU=;
        b=Tl2OeFSMRFcAS4xN1YxhKAZ9lvG0t653uuMtEHAa5908YkOi/YwxwtpqUz4DVt22Kc
         0jgwHW5VPlzm4l7YZfWa4yl3RICrCEngfNnieqfU8Ayw8GgWXbTVBNO7kblr/B1yBWXO
         FMPcB1SDyIzzpxRTMP1oUUX3FSROrw12jf30W4v4Bw8XnBvgzAl50woVMJtc/v83XZjN
         bAkIz7TeHWwJAWvxJdycyQ41VdhuuDnR0XYnLu+OO8rzhg7tLsfhaPO5CpRpE6cJfwXz
         iHl1ERBauhpH7bBRGKJWuNrlkgQuwJnXrhSRyL8fz8igt258selUZcd0S7IgMHcLBiSU
         +XdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeghqWyjfDiW2cfsO4KJ1aGelKwj2pJU5Pxfk2CMmuGSSEX8xHHUyuDYWsWY4MrT2/fHSWyolwfmBfYJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXfLnB0E+wqjvszTCsMt8SiwrylMIjW2z2be+/yhaBTLJP0zzc
	5KU27K79PD4InbTd33qzIAWTnZyqMvtG3kumnxaT/oZGEfHNo9nl
X-Google-Smtp-Source: AGHT+IHAZCV8L/qW1aocav+j2pJ9KrlW7U/wjfcBMI690bSifTI5pCqIPcCZTJXA1TLu6F/0beGwTA==
X-Received: by 2002:a05:6a20:d487:b0:1d9:2705:699e with SMTP id adf61e73a8af0-1db91d43efemr2039869637.7.1730344002313;
        Wed, 30 Oct 2024 20:06:42 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c47fcsm359755b3a.126.2024.10.30.20.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 20:06:41 -0700 (PDT)
Date: Thu, 31 Oct 2024 03:06:34 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net] bonding: add ns target multicast address to slave
 device
Message-ID: <ZyL0OgXVAEUxthbq@fedora>
References: <20241023123215.5875-1-liuhangbin@gmail.com>
 <213367.1730305265@vermin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <213367.1730305265@vermin>

Hi Jay,
On Wed, Oct 30, 2024 at 05:21:05PM +0100, Jay Vosburgh wrote:
> 	I suspect the set of multicast addresses involved is likely to
> be small in the usual case, so the question then is whether the
> presumably small amount of traffic that inadvertently passes the filter
> (and is then thrown away by the kernel RX logic) is worth the complexity
> added here.

Yes, while the code and logic may be complex, the "small amount of
traffic", specifically, the IPv6 NS messages, plays a crucial role in
determining whether backup slaves are up or not. Without these messages,
it would be akin to dropping ARP traffic for IPv4, which could lead to
connectivity issues.

> 
> 	That said, I have a few questions below.
> 
> >    arp_validate doesn't support 3ad, tlb, alb. So let's only do it on ab mode.
> >---
> > drivers/net/bonding/bond_main.c    | 18 +++++-
> > drivers/net/bonding/bond_options.c | 95 +++++++++++++++++++++++++++++-
> > include/net/bond_options.h         |  1 +
> > 3 files changed, 112 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> >index b1bffd8e9a95..d7c1016619f9 100644
> >--- a/drivers/net/bonding/bond_main.c
> >+++ b/drivers/net/bonding/bond_main.c
> >@@ -1008,6 +1008,9 @@ static void bond_hw_addr_swap(struct bonding *bond, struct slave *new_active,
> > 
> > 		if (bond->dev->flags & IFF_UP)
> > 			bond_hw_addr_flush(bond->dev, old_active->dev);
> >+
> >+		/* add target NS maddrs for backup slave */
> >+		slave_set_ns_maddrs(bond, old_active, true);
> > 	}
> > 
> > 	if (new_active) {
> >@@ -1024,6 +1027,9 @@ static void bond_hw_addr_swap(struct bonding *bond, struct slave *new_active,
> > 			dev_mc_sync(new_active->dev, bond->dev);
> > 			netif_addr_unlock_bh(bond->dev);
> > 		}
> >+
> >+		/* clear target NS maddrs for active slave */
> >+		slave_set_ns_maddrs(bond, new_active, false);
> > 	}
> > }
> > 
> >@@ -2341,6 +2347,12 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> > 	bond_compute_features(bond);
> > 	bond_set_carrier(bond);
> > 
> >+	/* set target NS maddrs for new slave, need to be called before
> >+	 * bond_select_active_slave(), which will remove the maddr if
> >+	 * the slave is selected as active slave
> >+	 */
> >+	slave_set_ns_maddrs(bond, new_slave, true);
> >+
> > 	if (bond_uses_primary(bond)) {
> > 		block_netpoll_tx();
> > 		bond_select_active_slave(bond);
> >@@ -2350,7 +2362,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> > 	if (bond_mode_can_use_xmit_hash(bond))
> > 		bond_update_slave_arr(bond, NULL);
> > 
> >-
> > 	if (!slave_dev->netdev_ops->ndo_bpf ||
> > 	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
> > 		if (bond->xdp_prog) {
> >@@ -2548,6 +2559,11 @@ static int __bond_release_one(struct net_device *bond_dev,
> > 	if (oldcurrent == slave)
> > 		bond_change_active_slave(bond, NULL);
> > 
> >+	/* clear target NS maddrs, must after bond_change_active_slave()
> >+	 * as we need to clear the maddrs on backup slave
> >+	 */
> >+	slave_set_ns_maddrs(bond, slave, false);
> >+
> > 	if (bond_is_lb(bond)) {
> > 		/* Must be called only after the slave has been
> > 		 * detached from the list and the curr_active_slave
> >diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> >index 95d59a18c022..2554ba70f092 100644
> >--- a/drivers/net/bonding/bond_options.c
> >+++ b/drivers/net/bonding/bond_options.c
> >@@ -1234,6 +1234,75 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
> > }
> > 
> > #if IS_ENABLED(CONFIG_IPV6)
> >+/* convert IPv6 address to link-local solicited-node multicast mac address */
> >+static void ipv6_addr_to_solicited_mac(const struct in6_addr *addr,
> >+				       unsigned char mac[ETH_ALEN])
> >+{
> >+	mac[0] = 0x33;
> >+	mac[1] = 0x33;
> >+	mac[2] = 0xFF;
> >+	mac[3] = addr->s6_addr[13];
> >+	mac[4] = addr->s6_addr[14];
> >+	mac[5] = addr->s6_addr[15];
> >+}
> 
> 	Can we make use of ndisc_mc_map() / ipv6_eth_mc_map() to perform
> this step, instead of creating a new function that's almost the same?

Ah, yes, I think so. Thanks for this tips.


> >+void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool add)
> >+{
> >+	if (!bond->params.arp_validate)
> >+		return;
> >+
> >+	_slave_set_ns_maddrs(bond, slave, add);
> >+}
> 
> 	Why does this need a wrapper function vs. having the
> arp_validate test be first in the larger function?

We have 4 places call slave_set_ns_maddrs(). I think with this wrapper could
save some codes. I'm fine to remove this wrapper if you think the code
would be simpler.

Thanks
Hangbin

