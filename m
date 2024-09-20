Return-Path: <netdev+bounces-129053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A6297D3A7
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 11:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687FAB24847
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 09:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DB213B5A9;
	Fri, 20 Sep 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZJJKOAwV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2B813AA3F
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824778; cv=none; b=p2YAB/iVKSEGXzE6zmJaf0BeEuUARB4ZaO0NvMc7kbS5kz1W9esZcl/yyPAyZ/6lZUTjuiCH6IsYVdcv644T1mHzwPqhTlmRQq5cd9tx0HDzIbX5ysQdy5vZnDWcAkspYKdUUKuEy/J2Pitu95GtKw1GadC6dGs2vDcgS08h2dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824778; c=relaxed/simple;
	bh=I9dhLtSXEvmlIWYEYser1c807olsUVp/skBDoxd2mFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfH6xL1X94ShAX6Ix46a8YOE8VHgF0jCZo2QltrVn57ai4cxHBYo2TXOxzaee+JxqjlRjZ20lANwt4dIpc22ak76GmZ1fkW4BMAaHYg6SLA5DmSLejc+tUs9BwFbp3bZdOA6RXX6D4OvwFhqa++HBSbnxW1hnmqM77qT0469Vrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZJJKOAwV; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1726824777; x=1758360777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QKLDz0heWIM+VCaAEhYedaui5JDmYRErGsztJ7XqYm4=;
  b=ZJJKOAwVNYU4ZTmRp2Kp/TDU1KeFvBhWJh4LjxlssV7vBSB/zZnT9L9m
   7AAqb8fv261Qx8+xMES+iOLRtCCd/CIhh90fvbQn9S5J4Sx1H+E+HgUe4
   6zL57CMfiLE5dSdkxC6MOaKMhMrY0YTZf9oniOhTmd1+QattGPhV/P8v0
   U=;
X-IronPort-AV: E=Sophos;i="6.10,244,1719878400"; 
   d="scan'208";a="456092711"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 09:32:50 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:39381]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.209:2525] with esmtp (Farcaster)
 id a33904f0-ee91-4027-bc62-bf84e58f85bd; Fri, 20 Sep 2024 09:32:49 +0000 (UTC)
X-Farcaster-Flow-ID: a33904f0-ee91-4027-bc62-bf84e58f85bd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 20 Sep 2024 09:32:49 +0000
Received: from 88665a182662.ant.amazon.com (10.1.213.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 20 Sep 2024 09:32:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <antonio@openvpn.net>
CC: <andrew@lunn.ch>, <antony.antony@secunet.com>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <ryazanov.s.a@gmail.com>, <sd@queasysnail.net>,
	<steffen.klassert@secunet.com>
Subject: Re: [PATCH net-next v7 03/25] net: introduce OpenVPN Data Channel Offload (ovpn)
Date: Fri, 20 Sep 2024 11:32:34 +0200
Message-ID: <20240920093234.15620-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <a10dcebf-b8f1-4d9b-b417-cca7d0330e52@openvpn.net>
References: <a10dcebf-b8f1-4d9b-b417-cca7d0330e52@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 19 Sep 2024 13:57:51 +0200
> Hi Kuniyuki and thank you for chiming in.
> 
> On 19/09/2024 07:52, Kuniyuki Iwashima wrote:
> > From: Antonio Quartulli <antonio@openvpn.net>
> > Date: Tue, 17 Sep 2024 03:07:12 +0200
> >> +/* we register with rtnl to let core know that ovpn is a virtual driver and
> >> + * therefore ifaces should be destroyed when exiting a netns
> >> + */
> >> +static struct rtnl_link_ops ovpn_link_ops = {
> >> +};
> > 
> > This looks like abusing rtnl_link_ops.
> 
> In some way, the inspiration came from
> 5b9e7e160795 ("openvswitch: introduce rtnl ops stub")
> 
> [which just reminded me that I wanted to fill the .kind field, but I 
> forgot to do so]
> 
> The reason for taking this approach was to avoid handling the iface 
> destruction upon netns exit inside the driver, when the core already has 
> all the code for taking care of this for us.
> 
> Originally I implemented pernet_operations.pre_exit, but Sabrina 
> suggested that letting the core handle the destruction was cleaner (and 
> I agreed).
> 
> However, after I removed the pre_exit implementation, we realized that 
> default_device_exit_batch/default_device_exit_net thought that an ovpn 
> device is a real NIC and was moving it to the global netns rather than 
> killing it.
> 
> One way to fix the above was to register rtnl_link_ops with netns_fund = 
> false (so the ops object you see in this patch is not truly "empty").
> 
> However, I then hit the bug which required patch 2 to get fixed.
> 
> Does it make sense to you?
> Or you still think this is an rtnl_link_ops abuse?

The use of .kind makes sense, and the change should be in this patch.

For the patch 2 and dellink(), is the device not expected to be removed
by ip link del ?  Setting unregister_netdevice_queue() to dellink() will
support RTM_DELLINK, but otherwise -EOPNOTSUPP is returned.


> 
> The alternative was to change 
> default_device_exit_batch/default_device_exit_net to read some new 
> netdevice flag which would tell if the interface should be killed or 
> moved to global upon netns exit.
> 
> Regards,
> 

