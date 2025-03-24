Return-Path: <netdev+bounces-176995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D665BA6D312
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 03:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4960E188E907
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 02:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D48B667;
	Mon, 24 Mar 2025 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8M1nk8E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56A82E3372;
	Mon, 24 Mar 2025 02:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742783460; cv=none; b=rnwhVkQ2aEL3xu+aHOHO4IdK7hQ4nei7iRgsJ/996b1///VwqfnHsED2my2Pn2vuQVpSL4T+pAgX8rasqGB5XuYz2HFdbsyirlWQtHrdBIDnGHWxqYk+jw1dsbeCQ8zA1T+/u3PCXm7qjQJVOYllbzyFiqHLuoFNZn9A20/+Z1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742783460; c=relaxed/simple;
	bh=/rzzdZJlmQ5zb2IM26oAquHgY1NbEZ1MjFid6PgfYYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxnRDaV3Oe3CwhDWzOhv0cp6PqIMNqkOUBGfC0Hpx5lSawOc3nHahR9phitwLimp4IsOpkTIJWK3LTsStDWQhEV7rZ5zYBakFaq5pg3mrLpYBoZ264UH6c43S+vqFjXq5ARKjIPELPRshSPic0NUr5EkeRPJZy/SMrNLaWprito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8M1nk8E; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2240b4de12bso54528645ad.2;
        Sun, 23 Mar 2025 19:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742783458; x=1743388258; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dWmKD0zxPc9GyGbKnAUcHzGx7aZdb/2XMSjzXTa1Vco=;
        b=f8M1nk8EkPnMaM/SN1PU6ZlbTNIiQwGxL0CDWHcQcZjN8YIlqFA4w1WIDku03JHjm3
         z+G5p2N/MCgrYGm8kBXNoP4d3oGwQuk9siwp5T/KhK5dpZIwooZYTyiSu0tFkxHfv1M3
         so4yhTryK/kTpUQ9f5M98IAQ6YBtDYX7jUR8aJIGBp3BMJWnOtcKph7c+k0GJp4B2QKF
         yiirJJmdlcza1Xv6iwPZoAhaRjcR58BDvMt7Ux5cEihLvZTFbw3XpMlIWhqKzrJhyQSN
         JgcXor8Qda7ABuU/7L12r/1yALG+ty2aVA712N0iUxYpdkSyjZazQtMPQbXAm/YmH1Ea
         ktTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742783458; x=1743388258;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dWmKD0zxPc9GyGbKnAUcHzGx7aZdb/2XMSjzXTa1Vco=;
        b=Z7d06q1FzwNTsoPkoKDO6xf+fi2ppQFAtxtS9WLaJjMSaLBBQ2Dq04yTiom6h4+XTQ
         KDhSQHwP9raS9Alv+6sFadxhTtPiEMhD1eMnJAx6K3ATsgkSAMmPxCVa5su7iwwWDik2
         fr8bSws1rfGl9yPitoCasrnE5JZxiBi9skvW0zhPub6d8Z6Al8/27Ikt8T4uimggxdEm
         5RJ3HEu21H+9cEAi7FMgSGhXnTnENBmwjwog6oIZjeSFIOJ5/iUbQLEqcelyWRzttRXd
         pUmv/WEWb/iKn2Hev+46rkw09e3/9Lk4AzP4iz9BTU41wUbaWi1dE7/OPcTtKrZSvUQo
         zscw==
X-Forwarded-Encrypted: i=1; AJvYcCVTdnegK092DJ/cES/K7CVaa9IMx9DZ6jDCaZDxKoa7FJAH+LmZt3GACWnI5L3LROnw3rqTZ7s7/DmgKgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz23c0TkNCUI9gsRYj+wDdjX+SsMlbgiYHVRR1GrVZMOfsvxkcc
	BGQSu7aS8Crbb7HUnjl+AjBc/5hJkcHrfe2vvdOxV8Re//aCX65i2y5u/opQ8D4=
X-Gm-Gg: ASbGncucW4ieGoPL88e6RNVUuK5D3Cdv2LqMyQ/AB5VFqL17tllN6Lbd5hMTQAMbaRm
	GPTaskpf1sOkbS9eQfl19Wpngd4SyuhbP27jcPV6r7TMeUfhLQ90sPgDD/GaGXwAAXQ2Awfw5sW
	aWrh7A6zp/WdtEvH8FhO4FS6fidx8FiVu7/aw2iiS0zKgBEJl1K7RYCvbzrNTtWRQ2ccREUaYK5
	p95Euko6KBgKCDQxoyK3N0M9C+gPg0Ff5hlY7SkMbasVzj2VMFp9Y3quGVlBSdZA6Cc5+zzNecY
	sI8rOlaZaE7InQTNmuUtc9CRhkQGko9WhUW2EUByO9tEpRXWHQ==
X-Google-Smtp-Source: AGHT+IGfmLGFc9uBS4LBov4T4e/f/ddrrxlEy5QvxNrD7sufqdSP5PrFCTaBVyhi12x0HATkXgxzNw==
X-Received: by 2002:a05:6a20:c906:b0:1f5:8e54:9f10 with SMTP id adf61e73a8af0-1fe43205c56mr24279585637.34.1742783457966;
        Sun, 23 Mar 2025 19:30:57 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fab1aesm6632907b3a.36.2025.03.23.19.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 19:30:57 -0700 (PDT)
Date: Mon, 24 Mar 2025 02:30:49 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kernel@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net] bonding: use permanent address for MAC swapping if
 device address is same
Message-ID: <Z-DD2TcMZmBUugIY@fedora>
References: <20250319080947.2001-1-liuhangbin@gmail.com>
 <2696885.1742497994@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2696885.1742497994@famine>

On Thu, Mar 20, 2025 at 12:13:14PM -0700, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> >Similar with a951bc1e6ba5 ("bonding: correct the MAC address for "follow"
> >fail_over_mac policy"). The fail_over_mac follow mode requires the formerly
> >active slave to swap MAC addresses with the newly active slave during
> >failover. However, the slave's MAC address can be same under certain
> >conditions:
> >
> >1) ip link set eth0 master bond0
> >   bond0 adopts eth0's MAC address (MAC0).
> >
> >1) ip link set eth1 master bond0
> >   eth1 is added as a backup with its own MAC (MAC1).
> >
> >3) ip link set eth0 nomaster
> >   eth0 is released and restores its MAC (MAC0).
> >   eth1 becomes the active slave, and bond0 assigns MAC0 to eth1.
> >
> >4) ip link set eth0 master bond0
> >   eth0 is re-added to bond0, but both eth0 and eth1 now have MAC0,
> >   breaking the follow policy.
> 
> 	Are all of these steps necessary, or does the issue happen if a
> new interface (not previously part of the bond) is added to the bond
> with its MAC set to whatever the bond's MAC is?

Yes, any new interface(usually the previous first bond link) with MAC
same to bond will has this issue.

> 
> 	Did this come up in practise somewhere, or through inspection /
> testing?  I'm curious as I'd expect usage of this option today would be
> rare, as I hope that current hardware wouldn't have the "MAC assigned to
> multiple ports" issues that led to the "follow" logic.  If memory
> serves, the issue arose originally in the ehea network device (on IBM
> POWER), which I believe is out of production now for some years.

This issue has also been reported by OCP users[1] with NetworkManager setups.
When the bond is controlled by NetworkManager, using nmcli to set a slave
link down will remove the slave from the bond and bring the interface down.
Similarly, using nmcli to bring the link up will add the slave back to the bond.

This is the default link operation logic of NetworkManager, and there is
little possibility of changing it. However, this behavior makes the MAC
address duplication issue much easier to trigger.

[1] https://github.com/openshift/machine-config-operator/pull/4609

> >To resolve this issue, we need to swap the new active slave’s permanent
> >MAC address with the old one. The new active slave then uses the old
> >dev_addr, ensuring that it matches the bond address. After the fix:
> >
> >5) ip link set bond0 type bond active_slave eth0
> >   dev_addr is the same, swap old active eth1's MAC (MAC0) with eth0.
> >   Swap new active eth0's permanent MAC (MAC0) to eth1.
> >   MAC addresses remain unchanged.
> >
> >6) ip link set bond0 type bond active_slave eth1
> >   dev_addr is the same, swap the old active eth0's MAC (MAC0) with eth1.
> >   Swap new active eth1's permanent MAC (MAC1) to eth0.
> >   The MAC addresses are now correctly differentiated.
> 
> 	An alternative solution could be to disallow adding a new
> interface in "follow" mode if its MAC matches the active interface of
> the bond.  If this patch is more of an correctness exercise rather than
> something found out in the world impacting production deployments, it
> might be better to keep the MAC swapping logic in the failover code
> simpler.

With the NetworkManager operations situation. It looks we can't simply
disallow adding the interface back to bond if its MAC the same with active
interface of bond.

Thanks
Hangbin
> 
> 	-J
> 
> >Fixes: 3915c1e8634a ("bonding: Add "follow" option to fail_over_mac")
> >Reported-by: Liang Li <liali@redhat.com>
> >Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> >---
> > drivers/net/bonding/bond_main.c | 9 +++++++--
> > include/net/bonding.h           | 8 ++++++++
> > 2 files changed, 15 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> >index e45bba240cbc..9cc2348d4ee9 100644
> >--- a/drivers/net/bonding/bond_main.c
> >+++ b/drivers/net/bonding/bond_main.c
> >@@ -1107,8 +1107,13 @@ static void bond_do_fail_over_mac(struct bonding *bond,
> > 			old_active = bond_get_old_active(bond, new_active);
> > 
> > 		if (old_active) {
> >-			bond_hw_addr_copy(tmp_mac, new_active->dev->dev_addr,
> >-					  new_active->dev->addr_len);
> >+			if (bond_hw_addr_equal(old_active->dev->dev_addr, new_active->dev->dev_addr,
> >+					       new_active->dev->addr_len))
> >+				bond_hw_addr_copy(tmp_mac, new_active->perm_hwaddr,
> >+						  new_active->dev->addr_len);
> >+			else
> >+				bond_hw_addr_copy(tmp_mac, new_active->dev->dev_addr,
> >+						  new_active->dev->addr_len);
> > 			bond_hw_addr_copy(ss.__data,
> > 					  old_active->dev->dev_addr,
> > 					  old_active->dev->addr_len);
> >diff --git a/include/net/bonding.h b/include/net/bonding.h
> >index 8bb5f016969f..de965c24dde0 100644
> >--- a/include/net/bonding.h
> >+++ b/include/net/bonding.h
> >@@ -463,6 +463,14 @@ static inline void bond_hw_addr_copy(u8 *dst, const u8 *src, unsigned int len)
> > 	memcpy(dst, src, len);
> > }
> > 
> >+static inline bool bond_hw_addr_equal(const u8 *dst, const u8 *src, unsigned int len)
> >+{
> >+	if (len == ETH_ALEN)
> >+		return ether_addr_equal(dst, src);
> >+	else
> >+		return (memcmp(dst, src, len) == 0);
> >+}
> >+
> > #define BOND_PRI_RESELECT_ALWAYS	0
> > #define BOND_PRI_RESELECT_BETTER	1
> > #define BOND_PRI_RESELECT_FAILURE	2
> >-- 
> >2.46.0
> 
> ---
> 	-Jay Vosburgh, jv@jvosburgh.net
> 

