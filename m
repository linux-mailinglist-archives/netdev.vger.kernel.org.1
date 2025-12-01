Return-Path: <netdev+bounces-242933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAB8C968E7
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 11:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49A43A1145
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 10:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542432E4279;
	Mon,  1 Dec 2025 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz6lHG7p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71E9207A20
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583550; cv=none; b=fUrv/Paj8YsTt+RIQv20Ck/D4rpmCtwbYgfg4vJgpVYyLDc1wmLSrk3DAwXHbv9F9ETuGvVEclSEMZYXYQf6VbYCm+29nvbGBTk/FRFRrbVieU5VRzD1D/axMJAq+XtAZ8kYHoFzlYnuwDP9YlBLL6p1KWzT8kwi/KrN/vrozL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583550; c=relaxed/simple;
	bh=FjV22poyLif+9WCbsiqQAc6IH7XpV6n4F/FhX8+Qz2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP3TPTvK9C3RRkHhSSAVRGqC9KnpGV2MyQACNT/HcmBtYbftXNlTL2FU2q04hlqmldBCSUKhlzA9M1sX8Au9NB6sVC+WesjDvjXm5V/XVAKEAa5mD0YVepXEX1qkj94Re3zpeSMjNgVq+Psp58IHNbq5vz69fH87jLUf82tqgxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz6lHG7p; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo4766384b3a.2
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 02:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764583547; x=1765188347; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FpWHpZt+wHbnU5ztoKrUHeQsPj/EObdQ5KcM6yDCsdA=;
        b=Jz6lHG7pP9YYKmtsFXVqh/9w1Pex2FxQ6k6dZm2C5qPbkC8ttQvGQIzciZuo1U2a+o
         js6MdJk7QDP/8GTI62lVrK0zR2m4Zs1+K7JONY7Z6zfnLLDTQ68CG+Cf1GN3vEWHaOJN
         0pxmuLRVJZnW8MkqFxYQ7xpcQlLFCL3rrsuI64TEGwNmp4fvH1BQRGB3FsgMtYOexTDk
         ey2DAGhCDSK2qYf36391Zv8LGzDrDLYhSOs6CKYCBd1SwKpKHObt0dr+GI2W9tgvloF9
         KubOqbAuas8EFPearppV9mJt7dnr8ZpXxMazlsffrL4L+I6oH+pnBCLpfa8Hw4GFgp1A
         d39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583547; x=1765188347;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpWHpZt+wHbnU5ztoKrUHeQsPj/EObdQ5KcM6yDCsdA=;
        b=XZU2HbJLDXDJPyjvofPtvHOdhFESI5SUcvmxLfZLNBSmWRQUy5RiUwYuLQkJZFIKD6
         qLJlpepGb/rXH7FWBt5IjUDejeCLX4e7lU2RsNgjx44xcjwsRsyIIChSVD6VJ8S5HrbM
         W+c0Hu+OwDWfUC2QMSmF2dvGH92WfBiWFhwuQxS/G+TqQD1ogfB2dfRjywksFPGS3g4b
         eJQJilaRdxIzkQBoBQxFXb4gFDAWWFqUL/Pj5aNK29M1FIa03MGgEe8vjYo3FiHTu+dj
         mdbAm0ewK7dz1tpLta4jpgsL/T8tYeEuas5K3Kpy3y/ijUorP5efSrmU+2rKpYqP3M3X
         eC0Q==
X-Gm-Message-State: AOJu0Yxi3nV1SIyiHwxKGgtiOLIF6nG8j0yfMNs7aQy2SC6c2POdrUxN
	9Yy3GwJcqvHMlfoY7xgi3EMxQhM1t5JMS09lmuxbZJqxNwIzttsaK3Hq
X-Gm-Gg: ASbGncsbwSm3TkvShZ3BOSYUceUI+wLqkLYmjwQcLmeiXjy50NK0Q9ZMvLhtJC4EYX5
	+dBRkttYKoIwPwLeLbb7SQLVlStHn/Za/tpVqa9TffxTgyI0Inx+C8smLAMSYTlzAgwtVy2jXqw
	RDBiP+y1qTk2tv0TTXdkcZ2yc2yoBWfWS22OOJn+wKlFgBDXATeXKxAKnGrZpI8pNFSMJ9eqKm4
	aA1thOCP0Avakf1LnfJF/I2EWgt+wg+SbcZoUwbH+ia6gXXuQN+PCDiU5ZaQkkXkB0PuXshA/iP
	YKkS8V45zSN2eCXG2LzXODfU9C5ofkwUQiOvZ5p5dxwtZbI2zFsJZTsauL6IUpPDHg1cXlRBgZN
	4pjH7UnUIesNXkjXZlHmiOMQ26uVvCvWj0Tr0OXjDw4LoO0bcllO5xo9nbAeZtql0REeq0HY7h5
	3Wyistn7F++KPOeQu5f54YyyGh0Q==
X-Google-Smtp-Source: AGHT+IH+TuwQ55+fv0nl5gpBo+2+wetAB5YZvO+8JX/cBfB3hf5flzeGOqMIsgyKMQqYaMAWCX9XZw==
X-Received: by 2002:a05:6a21:328e:b0:361:4f82:e758 with SMTP id adf61e73a8af0-36150f3c256mr42189381637.52.1764583547004;
        Mon, 01 Dec 2025 02:05:47 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be508b06606sm11523576a12.18.2025.12.01.02.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:05:46 -0800 (PST)
Date: Mon, 1 Dec 2025 10:05:38 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v3 1/4] net: bonding: use workqueue to make sure
 peer notify updated in lacp mode
Message-ID: <aS1ocogQc01owxSC@fedora>
References: <20251130074846.36787-1-tonghao@bamaicloud.com>
 <20251130074846.36787-2-tonghao@bamaicloud.com>
 <aS08d1dOC2EOvz-U@fedora>
 <AACE3A98-C0C0-4B24-BC29-B8EC3A758D90@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AACE3A98-C0C0-4B24-BC29-B8EC3A758D90@bamaicloud.com>

On Mon, Dec 01, 2025 at 05:45:49PM +0800, Tonghao Zhang wrote:
> >>  * bond_change_active_slave - change the active slave into the specified one
> >>  * @bond: our bonding struct
> >> @@ -1270,8 +1299,6 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
> >>      BOND_SLAVE_NOTIFY_NOW);
> >> 
> >> if (new_active) {
> >> - bool should_notify_peers = false;
> >> -
> >> bond_set_slave_active_flags(new_active,
> >>    BOND_SLAVE_NOTIFY_NOW);
> >> 
> >> @@ -1280,19 +1307,17 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
> >>      old_active);
> >> 
> >> if (netif_running(bond->dev)) {
> >> - bond->send_peer_notif =
> >> - bond->params.num_peer_notif *
> >> - max(1, bond->params.peer_notif_delay);
> >> - should_notify_peers =
> >> - bond_should_notify_peers(bond);
> >> + bond_peer_notify_reset(bond);
> >> +
> >> + if (bond_should_notify_peers(bond)) {
> >> + bond->send_peer_notif--;
> >> + call_netdevice_notifiers(
> >> + NETDEV_NOTIFY_PEERS,
> >> + bond->dev);
> >> + }
> >> }
> >> 
> >> call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
> >> - if (should_notify_peers) {
> >> - bond->send_peer_notif--;
> >> - call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
> >> - bond->dev);
> >> - }
> >> }
> >> }
> > 
> > I don’t see the benefit of moving NETDEV_NOTIFY_PEERS before NETDEV_BONDING_FAILOVER.
> > Is there a specific reason or scenario where this ordering change is required?
> No, to simplify the code, and use common peer notify reset function.

bond_change_active_slave() is called under RTNL lock. We can use
bond_peer_notify_reset() here. But I don't think there is a need to move
NETDEV_NOTIFY_PEERS before NETDEV_BONDING_FAILOVER.

Thanks
Hangbin

