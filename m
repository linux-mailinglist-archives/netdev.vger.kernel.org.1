Return-Path: <netdev+bounces-200484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9749DAE5959
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 03:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405384803CA
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2A61BEF7E;
	Tue, 24 Jun 2025 01:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwfmAOJh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B826619DF4A;
	Tue, 24 Jun 2025 01:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750729389; cv=none; b=PYJbcvOqdNkzBg+sTjimcYYTZUxc2gpB53uAK33WN2mks8nxmhZaLlMWh5/tt67GzSm4zWvkK9bAMKo8oNTEfq4RkDUukYli7yJtxzq53gxxEok/yHYeSOuw3v+MsF8M2QPUrJu70LdCDJRx6B2s1MHyuiY7z9yTVcSZSCswics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750729389; c=relaxed/simple;
	bh=mDwbW2RYJLKZSo29Mv3VBBW7ZQVeSfp9v3+qTSW5ZTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKgq+FtBYLa2gCgwP84t7p6vPJk6RfBsG8SgL4kFAxLCsaQOACs1s+35MS1SVPTnZgpKraCncHBYloayM/4QB5BjeusJ48AULrA8ph/7cBKkOGqUNRzRXLdI5DKx8BU2cgOYCfF7qQqmktCWPfuhjobXbIMGfoztF2IbNDDSjrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwfmAOJh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74264d1832eso6115038b3a.0;
        Mon, 23 Jun 2025 18:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750729387; x=1751334187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DOOiBUETmZUo+2d+xi4iRdjoD85wR+IsmzKEMiNVupo=;
        b=VwfmAOJh3YD6gK/GMtyb73/aakGDdB8I4oJgA60wM1rZzGeIg8nbD5mihNIr7lv+Fm
         0aqxSVe3YX5LYvpz1elOFxE0BHkDsRltESoLOZdBss8703xJvjoZQRA2DG01DD+BrbpG
         g74MwiVU6ly0kcHJLXXmaGt+2M8O9TNHTTcqZBauw6+PGqB7vJbBLItm9RkhylGk0jp9
         01ODReirylAtRB2ljcSNFapf+YQIvnjDvSwOHktJT43dS7BPocGcBPBx/3H1pr2sbt8r
         eUVibSNE7EK6B0/+K2+rP/g1p0pVfzwNcrd83EfItyPaTrMq+QblD8kqoLncUapQCztq
         XmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750729387; x=1751334187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOOiBUETmZUo+2d+xi4iRdjoD85wR+IsmzKEMiNVupo=;
        b=QEHf3XaZ/zQxV9K8CHIqMH8VjHUCJzGO7YRHa60DQGdwVb3Wy0YK+TxOLCasAp1+Od
         pO2pjowX9oU1dJQOigmwe2XJ/nWFIPKmyzmOOmBBpQ6yZVEI5Z4hi26bCWpkOso9vQ4a
         b5G622i8+jnLoV5y6W/vakn7qEvRVPzNXw1WSBg1u1yatIwM7ddZBcGLxNdRtxYDXetD
         WgPwqXL1vof4b/994/xk9BnwFMuOvsW5W/L2KQaCuxBunMwuowI9HyCplzECWnw9jm5z
         RSQIfiCTHatCyoWb5MYoE/vodJrMqkqVPqJOBa0g64DMMZp9oDN2jz5Pj9rVbaQxvVRl
         WKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5Rhq0ishmPlpG/AidkwyzPajnbjruPCqeFo99vWE8oH6E6mb5ovUiwWXKnsk2Z76EF+0jG1N8qUVivu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFO6M3EIXzJesTvI0ttG+JvUjPz0AqOPmyvlpYM/hvf3BmqREY
	U8JEOupGZMm8ZeH4eIVYlWQpAhwIMU8VktT79sp+Md1G8JQKXDUBZv5F
X-Gm-Gg: ASbGnculruMRLHefd+5r5QR+7qiLT9hGtnAjxaHrM4bl+W1SfFq5L9lL+nEwqfjjwuf
	ItDOPsVVMPLb6FRQIDQkz+/Aus/wga2SSt9GgOpW2vG/53ZorRgSIEgQ3v7UBO1mh6ETfSHJdLR
	whH+Ca9HFkqh2aGOq+dDRmwO5DRP1GV93S+DdpbEc4aTKLLQvBzfJAVzLYO/5yOUTiOKxUu9XDi
	wqZqMUsBntBFyqzUD8mO6t4nt3EZv5HiEp1p7J2+ueqllpQuFP6Ej2SXvBLcHqCqWWcTklhnIv/
	yTzK2HClRZDn0KiAQq8VYmAeEo84tzVqbVjzuysdERtQ2zzhyIqV7jEgUGBo8OdT+Ss=
X-Google-Smtp-Source: AGHT+IH/XfOfU+AGQ2idPxoT2AAt9ZiHthZsvHDqLYtbe5fUwlrTmYFJxcGC0Nni1nqlnH99RG6CAQ==
X-Received: by 2002:a05:6a20:e687:b0:216:1ea0:a51e with SMTP id adf61e73a8af0-22026f0379cmr21901325637.41.1750729386869;
        Mon, 23 Jun 2025 18:43:06 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c8850d53sm426708b3a.118.2025.06.23.18.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 18:43:05 -0700 (PDT)
Date: Tue, 24 Jun 2025 01:42:58 +0000
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
Message-ID: <aFoCos-vPLfbGoM1@fedora>
References: <20250523022313.906-1-liuhangbin@gmail.com>
 <302767.1748034227@famine>
 <aDQrn8EslaWx_jEA@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDQrn8EslaWx_jEA@fedora>

Hi Jay,

Any comments?

Hangbin
On Mon, May 26, 2025 at 08:51:52AM +0000, Hangbin Liu wrote:
> On Fri, May 23, 2025 at 02:03:47PM -0700, Jay Vosburgh wrote:
> > Hangbin Liu <liuhangbin@gmail.com> wrote:
> > 
> > >There is a corner case where the NS (Neighbor Solicitation) target is set to
> > >an invalid or unreachable address. In such cases, all the slave links are
> > >marked as down and set to backup. This causes the bond to add multicast MAC
> > >addresses to all slaves.
> > >
> > >However, bond_ab_arp_probe() later tries to activate a carrier on slave and
> > >sets it as active. If we subsequently change or clear the NS targets, the
> > >call to bond_slave_ns_maddrs_del() on this interface will fail because it
> > >is still marked active, and the multicast MAC address will remain.
> > 
> > 	This seems complicated, so, just to make sure I'm clear, the bug
> > being fixed here happens when:
> > 
> > (a) ARP monitor is running with NS target(s), all of which do not
> > solicit a reply (invalid address or unreachable), resulting in all
> > interfaces in the bond being marked down
> > 
> > (b) while in the above state, the ARP monitor will cycle through each
> > interface, making them "active" (active-ish, really, just enough for the
> > ARP mon stuff to work) in turn to check for a response to a probe
> 
> Yes
> 
> > 
> > (c) while the cycling from (b) is occurring, attempts to change a NS
> > target will fail on the interface that happens to be quasi-"active" at
> > the moment.
> 
> Yes, this is because bond_slave_ns_maddrs_del() must ensure the deletion
> happens on a backup slave only. However, during ARP monitor, it set one of
> the slaves to active, this causes the deletion of multicast MAC addresses to
> be skipped on that interface.
> 
> > 	Is my summary correct?
> > 
> > 	Doesn't the failure scenario also require that arp_validate be
> > enabled?  Looking at bond_slave_ns_maddrs_{add,del}, they do nothing if
> > arp_validate is off.
> 
> Yes, it need.
> 
> > 
> > >To fix this issue, move the NS multicast address add/remove logic into
> > >bond_set_slave_state() to ensure multicast MAC addresses are updated
> > >synchronously whenever the slave state changes.
> > 
> > 	Ok, but state change calls happen in a lot more places than the
> > existing bond_hw_addr_swap(), which is only called during change of
> > active for active-backup, balance-alb, and balance-tlb.  Are you sure
> > that something goofy like setting arp_validate and an NS target with the
> > ARP monitor disabled (or in a mode that disallows it) will behave
> > rationally?
> 
> The slave_can_set_ns_maddr() in slave_set_ns_maddrs could check the bond mode
> and if the slave is active. But no arp_interval checking. I can add it in the
> checking to avoid the miss-config. e.g.
> 
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index 91893c29b899..21116362cc24 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -1241,6 +1241,7 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
>  static bool slave_can_set_ns_maddr(const struct bonding *bond, struct slave *slave)
>  {
>         return BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
> +              bond->params.arp_interval &&
>                !bond_is_active_slave(slave) &&
>                slave->dev->flags & IFF_MULTICAST;
>  }
> 
> > 
> > >Note: The call to bond_slave_ns_maddrs_del() in __bond_release_one() is
> > >kept, as it is still required to clean up multicast MAC addresses when
> > >a slave is removed.
> > >
> > >Fixes: 8eb36164d1a6 ("bonding: add ns target multicast address to slave device")
> > >Reported-by: Liang Li <liali@redhat.com>
> > >Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > >---
> > > drivers/net/bonding/bond_main.c | 9 ---------
> > > include/net/bonding.h           | 7 +++++++
> > > 2 files changed, 7 insertions(+), 9 deletions(-)
> > >
> > >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > >index 8ea183da8d53..6dde6f870ee2 100644
> > >--- a/drivers/net/bonding/bond_main.c
> > >+++ b/drivers/net/bonding/bond_main.c
> > >@@ -1004,8 +1004,6 @@ static void bond_hw_addr_swap(struct bonding *bond, struct slave *new_active,
> > > 
> > > 		if (bond->dev->flags & IFF_UP)
> > > 			bond_hw_addr_flush(bond->dev, old_active->dev);
> > >-
> > >-		bond_slave_ns_maddrs_add(bond, old_active);
> > > 	}
> > > 
> > > 	if (new_active) {
> > >@@ -1022,8 +1020,6 @@ static void bond_hw_addr_swap(struct bonding *bond, struct slave *new_active,
> > > 			dev_mc_sync(new_active->dev, bond->dev);
> > > 			netif_addr_unlock_bh(bond->dev);
> > > 		}
> > >-
> > >-		bond_slave_ns_maddrs_del(bond, new_active);
> > > 	}
> > > }
> > > 
> > >@@ -2350,11 +2346,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> > > 	bond_compute_features(bond);
> > > 	bond_set_carrier(bond);
> > > 
> > >-	/* Needs to be called before bond_select_active_slave(), which will
> > >-	 * remove the maddrs if the slave is selected as active slave.
> > >-	 */
> > >-	bond_slave_ns_maddrs_add(bond, new_slave);
> > >-
> > > 	if (bond_uses_primary(bond)) {
> > > 		block_netpoll_tx();
> > > 		bond_select_active_slave(bond);
> > >diff --git a/include/net/bonding.h b/include/net/bonding.h
> > >index 95f67b308c19..0041f7a2bd18 100644
> > >--- a/include/net/bonding.h
> > >+++ b/include/net/bonding.h
> > >@@ -385,7 +385,14 @@ static inline void bond_set_slave_state(struct slave *slave,
> > > 	if (slave->backup == slave_state)
> > > 		return;
> > > 
> > >+	if (slave_state == BOND_STATE_ACTIVE)
> > >+		bond_slave_ns_maddrs_del(slave->bond, slave);
> > >+
> > > 	slave->backup = slave_state;
> > >+
> > >+	if (slave_state == BOND_STATE_BACKUP)
> > >+		bond_slave_ns_maddrs_add(slave->bond, slave);
> > 
> > 	This code pattern kind of makes it look like the slave->backup
> > assignment must happen between the two new if blocks.  I don't think
> > that's true, and things would work correctly if the slave->backup
> > assignment happened first (or last).
> 
> The slave->backup assignment must happen between the two if blocks, because
> 
> bond_slave_ns_maddrs_add/del only do the operation on backup slave.
> So if a interface become active, we need to call maddrs_del before it set
> backup state to active. If a interface become backup. We need to call
> maddrs_add after the backup state set to backup.
> 
> I will add a comment in the code.
> 
> Thanks
> Hangbin
> > 
> > 	Assuming I'm correct, could you move the assignment so it's not
> > in the middle?  If, however, it does need to be in the middle, that
> > deserves a comment explaining why.
> > 
> > 	-J
> > 
> > >+
> > > 	if (notify) {
> > > 		bond_lower_state_changed(slave);
> > > 		bond_queue_slave_event(slave);
> > >-- 
> > >2.46.0
> > >
> > 
> > ---
> > 	-Jay Vosburgh, jv@jvosburgh.net

