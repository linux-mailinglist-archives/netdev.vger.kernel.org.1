Return-Path: <netdev+bounces-193392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4814AC3C11
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30123A8EAC
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986AC1EB5C9;
	Mon, 26 May 2025 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDMdOgR8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E199E1DE2AD;
	Mon, 26 May 2025 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748249514; cv=none; b=RRYwbkIwneLwfiZiq7e6pMDiUSDLuu6/fXjs3qiA6NNl/yNh/7OWt/97r4ZWu0LKB90DgRQy9NmExdWpUyTV+Q7sNAKv5O8d3rHn0e5f4vQSkkZI++i/NpNRZthlULGp4237lskVGp8t9WNCVCznmVqoCR1vqj4EWdltpWlPj7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748249514; c=relaxed/simple;
	bh=zvra6HZl9Z3MP0n1eJxJdrcAGuePSjq1PbQ5QlWDQQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwbTh5amai9DI0RfQ4GbptvmRfB0jmWi4ArhhT8kuI6OfkRwKMcaWu3yaZviElYfFJiS2FHdIFEDG0oW4b99LtYQ/BLI0/1WlaokTxasTzRRa9PJovt1nGPfewyHilF6joM60cXr5ZgjqmuhbRtl9lbv0nF8AHWmFWol+Jmucbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDMdOgR8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7398d65476eso1253205b3a.1;
        Mon, 26 May 2025 01:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748249512; x=1748854312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jAKi39KJyx4nPhzTCMTmMmK3H8uV0z0zL/rPiOL2COA=;
        b=gDMdOgR8H8MZFRJf6NUtoIPrI3TgxzutVvgG6RFCBph5euCNPcdlpUdF3LbR9lPZOz
         35qN8ERcDCvG2jM+D9Vj0nUpEpwYt1PAgMU9MOJ71kWn9kVTQIJFyZkRJwtNeg/MT4hF
         GiYFSLQqgIAM+LCgDHyYx8ko7HUJGInHfBJPDAcsx8tLNyD8n5k+96idbenzCm3AjwS6
         S9oFVMBZ7PiA+w1727Gefdu8X/Xxg156n5LBfqXCvTDItJvPazVgscShnPQ0IbCvsdoa
         I7gwg3YaHiot7wWowYPoSFtQP6smmdhy08FQmk4ogMMNhpVn1uwq0XVCT6pjxsrzf9Hx
         ZBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748249512; x=1748854312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAKi39KJyx4nPhzTCMTmMmK3H8uV0z0zL/rPiOL2COA=;
        b=v4C1dUqTcgc/YPDVVB7q27jLAqWi+CSA4KLf1Vf/4/9hhnZQs0tm/0+pI/UvMlODWe
         DCn+1wHZj6hysi9v5Oab/kUlqa0KnTxsz5T8gnyV7LfhXuKG0tGBGZkxNkO0Xj0YewSA
         IVP4gkaaRq+wG5cAU3/6ukvMZm3otRA4dBXcPHQ2ohm1imtR+SmfRJt05rIyrfEFujfz
         5ZiWIZPdNyL++P9W34HSNjLGBd9cLCZm3qkQ8gkKLWgDcckyiXy7OWIb3L6Kh4ZbyTrb
         pyemH88XU48JDch7UtIBsyP+kq1JIPnVOLW4M9gcSsxnnFI4iYRrVcR6MTVv6lBv+LDD
         Rnlg==
X-Forwarded-Encrypted: i=1; AJvYcCWg/nA+Kxtz6F433F4l/xefw3RoIJVP/RiJAiHVKMTMaNII33/lAB6z+wyYADHkhz3LErd5cw0gd7o8PWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHavYRG+P4smoT5EPl2DnKCjc4tK/imtzNUivc607R8A/USXNc
	np66Ny4bHwM3I6XSnAWbvAuf826owtmcGml/F+O2ICKaIy3FbYHY0v7Z
X-Gm-Gg: ASbGncsZyBIAgFMcd68yLHE9o/0+OHcnUOwnEGvbYAl9oxnJScldwmtx+XxoLyNsjWP
	i7dt3K8wL305fSxWH3SEzZpVBEotvNV3zRYoIdxtdGf2d+nrELob4V9ZeEc/5ql2FdVeTu5v4OO
	5MNxcFniJp5zevp55z6cH1fpDdST41O6NqIiG5If08z1LIPr6NiRAcPW6DY445tfXmk6HRgBcLf
	7HoComW8ryKTIJG8LsOWnIbUstX9cfNLkGG4fZRAm0Ws1zZS96hS2yyqwzMfnm9ASHm7rQWiAAx
	jWY8sQkteYcPqNzXIyZntxFUZR9XvdLFO9dxOj1cL2Pi/Wg/l+s079/i
X-Google-Smtp-Source: AGHT+IHZ6dxFmJ0CCz8tTX2ecJYrhJXPRDslBcpPPLLQ0CQOzng4GJHDlDWj3e3Wmi5Agu/O7euQEg==
X-Received: by 2002:aa7:93b9:0:b0:746:1c67:f6cb with SMTP id d2e1a72fcca58-7461c67f943mr1288493b3a.5.1748249511901;
        Mon, 26 May 2025 01:51:51 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9878b53sm16560267b3a.152.2025.05.26.01.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 01:51:51 -0700 (PDT)
Date: Mon, 26 May 2025 08:51:43 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	Liang Li <liali@redhat.com>
Subject: Re: [PATCH net] bonding: fix multicast MAC address synchronization
Message-ID: <aDQrn8EslaWx_jEA@fedora>
References: <20250523022313.906-1-liuhangbin@gmail.com>
 <302767.1748034227@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <302767.1748034227@famine>

On Fri, May 23, 2025 at 02:03:47PM -0700, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> >There is a corner case where the NS (Neighbor Solicitation) target is set to
> >an invalid or unreachable address. In such cases, all the slave links are
> >marked as down and set to backup. This causes the bond to add multicast MAC
> >addresses to all slaves.
> >
> >However, bond_ab_arp_probe() later tries to activate a carrier on slave and
> >sets it as active. If we subsequently change or clear the NS targets, the
> >call to bond_slave_ns_maddrs_del() on this interface will fail because it
> >is still marked active, and the multicast MAC address will remain.
> 
> 	This seems complicated, so, just to make sure I'm clear, the bug
> being fixed here happens when:
> 
> (a) ARP monitor is running with NS target(s), all of which do not
> solicit a reply (invalid address or unreachable), resulting in all
> interfaces in the bond being marked down
> 
> (b) while in the above state, the ARP monitor will cycle through each
> interface, making them "active" (active-ish, really, just enough for the
> ARP mon stuff to work) in turn to check for a response to a probe

Yes

> 
> (c) while the cycling from (b) is occurring, attempts to change a NS
> target will fail on the interface that happens to be quasi-"active" at
> the moment.

Yes, this is because bond_slave_ns_maddrs_del() must ensure the deletion
happens on a backup slave only. However, during ARP monitor, it set one of
the slaves to active, this causes the deletion of multicast MAC addresses to
be skipped on that interface.

> 	Is my summary correct?
> 
> 	Doesn't the failure scenario also require that arp_validate be
> enabled?  Looking at bond_slave_ns_maddrs_{add,del}, they do nothing if
> arp_validate is off.

Yes, it need.

> 
> >To fix this issue, move the NS multicast address add/remove logic into
> >bond_set_slave_state() to ensure multicast MAC addresses are updated
> >synchronously whenever the slave state changes.
> 
> 	Ok, but state change calls happen in a lot more places than the
> existing bond_hw_addr_swap(), which is only called during change of
> active for active-backup, balance-alb, and balance-tlb.  Are you sure
> that something goofy like setting arp_validate and an NS target with the
> ARP monitor disabled (or in a mode that disallows it) will behave
> rationally?

The slave_can_set_ns_maddr() in slave_set_ns_maddrs could check the bond mode
and if the slave is active. But no arp_interval checking. I can add it in the
checking to avoid the miss-config. e.g.

diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 91893c29b899..21116362cc24 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1241,6 +1241,7 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
 static bool slave_can_set_ns_maddr(const struct bonding *bond, struct slave *slave)
 {
        return BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
+              bond->params.arp_interval &&
               !bond_is_active_slave(slave) &&
               slave->dev->flags & IFF_MULTICAST;
 }

> 
> >Note: The call to bond_slave_ns_maddrs_del() in __bond_release_one() is
> >kept, as it is still required to clean up multicast MAC addresses when
> >a slave is removed.
> >
> >Fixes: 8eb36164d1a6 ("bonding: add ns target multicast address to slave device")
> >Reported-by: Liang Li <liali@redhat.com>
> >Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> >---
> > drivers/net/bonding/bond_main.c | 9 ---------
> > include/net/bonding.h           | 7 +++++++
> > 2 files changed, 7 insertions(+), 9 deletions(-)
> >
> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> >index 8ea183da8d53..6dde6f870ee2 100644
> >--- a/drivers/net/bonding/bond_main.c
> >+++ b/drivers/net/bonding/bond_main.c
> >@@ -1004,8 +1004,6 @@ static void bond_hw_addr_swap(struct bonding *bond, struct slave *new_active,
> > 
> > 		if (bond->dev->flags & IFF_UP)
> > 			bond_hw_addr_flush(bond->dev, old_active->dev);
> >-
> >-		bond_slave_ns_maddrs_add(bond, old_active);
> > 	}
> > 
> > 	if (new_active) {
> >@@ -1022,8 +1020,6 @@ static void bond_hw_addr_swap(struct bonding *bond, struct slave *new_active,
> > 			dev_mc_sync(new_active->dev, bond->dev);
> > 			netif_addr_unlock_bh(bond->dev);
> > 		}
> >-
> >-		bond_slave_ns_maddrs_del(bond, new_active);
> > 	}
> > }
> > 
> >@@ -2350,11 +2346,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> > 	bond_compute_features(bond);
> > 	bond_set_carrier(bond);
> > 
> >-	/* Needs to be called before bond_select_active_slave(), which will
> >-	 * remove the maddrs if the slave is selected as active slave.
> >-	 */
> >-	bond_slave_ns_maddrs_add(bond, new_slave);
> >-
> > 	if (bond_uses_primary(bond)) {
> > 		block_netpoll_tx();
> > 		bond_select_active_slave(bond);
> >diff --git a/include/net/bonding.h b/include/net/bonding.h
> >index 95f67b308c19..0041f7a2bd18 100644
> >--- a/include/net/bonding.h
> >+++ b/include/net/bonding.h
> >@@ -385,7 +385,14 @@ static inline void bond_set_slave_state(struct slave *slave,
> > 	if (slave->backup == slave_state)
> > 		return;
> > 
> >+	if (slave_state == BOND_STATE_ACTIVE)
> >+		bond_slave_ns_maddrs_del(slave->bond, slave);
> >+
> > 	slave->backup = slave_state;
> >+
> >+	if (slave_state == BOND_STATE_BACKUP)
> >+		bond_slave_ns_maddrs_add(slave->bond, slave);
> 
> 	This code pattern kind of makes it look like the slave->backup
> assignment must happen between the two new if blocks.  I don't think
> that's true, and things would work correctly if the slave->backup
> assignment happened first (or last).

The slave->backup assignment must happen between the two if blocks, because

bond_slave_ns_maddrs_add/del only do the operation on backup slave.
So if a interface become active, we need to call maddrs_del before it set
backup state to active. If a interface become backup. We need to call
maddrs_add after the backup state set to backup.

I will add a comment in the code.

Thanks
Hangbin
> 
> 	Assuming I'm correct, could you move the assignment so it's not
> in the middle?  If, however, it does need to be in the middle, that
> deserves a comment explaining why.
> 
> 	-J
> 
> >+
> > 	if (notify) {
> > 		bond_lower_state_changed(slave);
> > 		bond_queue_slave_event(slave);
> >-- 
> >2.46.0
> >
> 
> ---
> 	-Jay Vosburgh, jv@jvosburgh.net

