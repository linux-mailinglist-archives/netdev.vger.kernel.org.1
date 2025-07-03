Return-Path: <netdev+bounces-203656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9726AF6A3E
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7201C45186
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 06:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB77428FFFB;
	Thu,  3 Jul 2025 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNgsLbX/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F296B28DF12;
	Thu,  3 Jul 2025 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751523989; cv=none; b=TmzLAWE4Fm3UydRjU2traEFkEbcQ267Z3TZ9ff1O6HgjYx1Kf3mqBZu6SZZVatYWDiHPQxw7LETU/skUsmJH7P2gYjWWEEMYCtrlewxLh4joCMnQuSk0b7VWP/z8RXbgUiD4Y7FPN3kQbm5pvr2InR9RwPBkp/veXvldHxGbXAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751523989; c=relaxed/simple;
	bh=O7FtMN/oZvbdEPRzE2eGJw2a74XUhi2ghAeHVB3nVk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0stRlwU68LV7SJhlL5sOCd75huXqRf9jKzMNHeS3e1zaGsDqVf1DoaCQOmDJQbhz8QbTacjCCvL72g6bB68JYdfA+HktQD+9mEWde3FjJgw6xZUHIaZxVo5hiw3vZCHdPucSDtDp6lFv8tNKieAwWAF4MmZ67wM/IDpQ23pthI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNgsLbX/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so7402066a91.1;
        Wed, 02 Jul 2025 23:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751523987; x=1752128787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QuIAHAlsiFGvJaXEewMBhiZ5Eab4fEfhk+tp+Ptj1aE=;
        b=KNgsLbX/9ox6XzgZPkDhmrvOY5XxE47+bhd7b+nEeVdfrKmH1OCFvZYRnkZaEb9VaT
         XBwzIUIMJRT+bR/llzAOJjvLdZpBEw9Zt59ZeSosGpUi7FKvmtAvOxjWn6NprkN8jF1x
         lM2tF3Ratq4IFucMdz1fXACq6HA8nEZQk/WW4f1XXXNExJpafLjDY03+KiTri/bQcYyl
         HGFCg4qPo45De5Ry8E/NAGkR1CgVBecaZJPCs9HhS2x8YX/xPBPQhZoUBUVRUofBsT10
         Na5Gzs3l6pXJalDgJzRlwwHSjl3DxROduV9ES5Yz9LDdzjrV0Ke1EhZLg3vxGdzG3o8+
         +Yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751523987; x=1752128787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuIAHAlsiFGvJaXEewMBhiZ5Eab4fEfhk+tp+Ptj1aE=;
        b=r1+WIxhD+6VUdM7xfAQ1Vj5ZBGYkAebEtLVrG/3G9/906XCZRLlUgGltJnFoWuOItB
         9CFD7miYyTcqVWRkDsu+0qzIXveIWX3d1SAvYGMv7UVsWe8j4P+nBiZ4HN4aIJAoR1Wc
         d/1bz4tyWwTs6VmZgxjzIfas9iw36CnthecsOqKZTjgMaDEOebHb7MIjTQoUbptgdu/S
         pz6+Yf9C4aKW/s72FkS4e5gZhUxJeIt3dsVnAyvZn8+WLTuMfOA+mCICcZbzmVymDYG9
         POHAogpqlVK9bXuGZwivefQAHwvfdRMzRd37uYFr6V34x9kg+ak2QFlkK8PNDD4h+z1P
         y0Vw==
X-Forwarded-Encrypted: i=1; AJvYcCU1yjb4v5AXeY1q7HV9IdOyuTO4rG2PEWmqUAXw3DN2etvFoR6fYTGjQlw2nWF8PP6AIU5BlxIZ/lPFfX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywzwn7X4s+826WkCvPbwkBEoJyhmNLq+3AofIu2zbelbI9HMmm
	9317YUhLt8kJjlh5ufCl+wXxihfIWrIXDYiq+XRn8MR87rdzCCqOf8OS
X-Gm-Gg: ASbGncsz1XFWz7GeXY2zzxqVSUW8LoJPwXkv+xHsSGuJv41WrrYlvgaTKDzeJGgpsNl
	dCjfULqGILz/r/RB33U9bGyVMKv4gSm0x6rUmoRpzwjvqOZvdZ46El+o3TSImcuLI/mTXE4GD8P
	bSObt1hR3iC9so5rKzHM91sh6IqhastEhOM0B2RLfW2Xnk/LhMoheOYrli+UTYBs3npEuaV6+AR
	0nQsxOyBXMNLR76yOcz+twPUGgybRoyqbGuKzLlpSHHHifE4gGaTcie9VBflkkUFL7soc7PpMR+
	Jw7zN3IP7o4ZZX7H5NVWgCngp+xovQJFFK0CFWuze3OH9taj5iunnXs7G+jX55g1dUk=
X-Google-Smtp-Source: AGHT+IF5quh2GmPJA9pctNyeWe7UNYZqkXGkms/Kv9FuB0DogmCg3pIalj/wfNhCusfEInF4jgQmJw==
X-Received: by 2002:a17:90b:5345:b0:311:abba:53d2 with SMTP id 98e67ed59e1d1-31a90bcae27mr8856716a91.17.1751523987040;
        Wed, 02 Jul 2025 23:26:27 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc6ec94sm1382212a91.23.2025.07.02.23.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 23:26:26 -0700 (PDT)
Date: Thu, 3 Jul 2025 06:26:19 +0000
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
Message-ID: <aGYiiw5oVEc2cyXu@fedora>
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

Thanks
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

