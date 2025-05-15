Return-Path: <netdev+bounces-190587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF92AB7B6E
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 04:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0341BA1599
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 02:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8C52820A0;
	Thu, 15 May 2025 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NLP3yUpV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D327933E
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 02:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747275002; cv=none; b=nSgGHk7ktSIQsK8GSeFEvTioiMOXW5MSJe7DiDiwyG4kIFdjsxlKprFUPJFKV51fe8W0Yn68iB7SRWvfAnbnPTFqiKHVEmcL3BbP1ZTsO9jgwQowGMIVeq9SX0/gV4xgqtBdlbTKQ51ebnPkXOlVp17Jyu+zvex+EhOpnynXpQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747275002; c=relaxed/simple;
	bh=RsR++g2yEaQrQQo3tnNQKA4yZdiazKjrF9bkSTXgRB0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ippRvRcoFCa+zq+HK/Vw8MXmI0FBbI33GnihwQsdDbjk4vH8ky50/5jgTA1jErLQQ4l33kLN4Slb+wg5zx34kWfIAGmCi3lHQQI1dIwOPsUJFUDH02AsibDGyWNwATqiBQq450tn8OErClBcf07rJ1O8jLRm+BBhUUHQmLbnxFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NLP3yUpV; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747275001; x=1778811001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=okZ4eTJeMpCxUUU4mkAO95r8xPPod79Im2fy8Yt+K7o=;
  b=NLP3yUpVWQosgUAgxElutoxl6qCwGpEtUtJokIdLq1IgV8LI1Bu16Kri
   3y0RM54WFQDebEgR2ZLAEQ/KJrRUP0GFjndMyyoHlyfslYtEfKYLuIgil
   t69KY4Wg5oGLJUmWwZ6H7NjLMgMZ71qROecerkE3fehIzc6fsoz1MOrUm
   w0q+YeGbG+os7lkH0QGBuqAaxtZcjg0yDxjsuyvvehiQMyC2N9ubBp2ec
   /tnxOp3rkoXgStewOlD+ljSPggoRt41Zjmd2NTKBU1WhLbqrPREFIa+kB
   K1NsrKWcw3MZ0MyV616tWuzdAQSIiRPDFL4LfMfzZLvWrqx/38GVODQv8
   w==;
X-IronPort-AV: E=Sophos;i="6.15,289,1739836800"; 
   d="scan'208";a="722917181"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 02:09:57 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:8611]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.33:2525] with esmtp (Farcaster)
 id c82ebb15-ada0-4601-876a-476694d5ae3b; Thu, 15 May 2025 02:09:55 +0000 (UTC)
X-Farcaster-Flow-ID: c82ebb15-ada0-4601-876a-476694d5ae3b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 02:09:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 02:09:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 0/7] ipv6: Follow up for RTNL-free RTM_NEWROUTE series.
Date: Wed, 14 May 2025 19:05:16 -0700
Message-ID: <20250515020944.19464-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514184502.22f4c4e6@kernel.org>
References: <20250514184502.22f4c4e6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 14 May 2025 18:45:02 -0700
> On Wed, 14 May 2025 13:18:53 -0700 Kuniyuki Iwashima wrote:
> > Patch 1 removes rcu_read_lock() in fib6_get_table().
> > Patch 2 removes rtnl_is_held arg for lwtunnel_valid_encap_type(), which
> >  was short-term fix and is no longer used.
> > Patch 3 fixes RCU vs GFP_KERNEL report by syzkaller.
> > Patch 4~7 reverts GFP_ATOMIC uses to GFP_KERNEL.
> 
> Hi! Something in the following set of patches is making our CI time out.
> The problem seems to be:
> 
> [    0.751266] virtme-init: waiting for udev to settle
> Timed out for waiting the udev queue being empty.
> [  120.826428] virtme-init: udev is done
> 
> +team: grab team lock during team_change_rx_flags
> +net: mana: Add handler for hardware servicing events
> +ipv6: Revert two per-cpu var allocation for RTM_NEWROUTE.
> +ipv6: Pass gfp_flags down to ip6_route_info_create_nh().
> +Revert "ipv6: Factorise ip6_route_multipath_add()."
> +Revert "ipv6: sr: switch to GFP_ATOMIC flag to allocate memory during seg6local LWT setup"
> +ipv6: Narrow down RCU critical section in inet6_rtm_newroute().
> +inet: Remove rtnl_is_held arg of lwtunnel_valid_encap_type(_attr)?().
> +ipv6: Remove rcu_read_lock() in fib6_get_table().
> +net/mlx5e: Reuse per-RQ XDP buffer to avoid stack zeroing overhead
>  amd-xgbe: read link status twice to avoid inconsistencies
> +net: phy: fixed_phy: remove fixed_phy_register_with_gpiod
>  drivers: net: mvpp2: attempt to refill rx before allocating skb
> +selftest: af_unix: Test SO_PASSRIGHTS.
> +af_unix: Introduce SO_PASSRIGHTS.
> +af_unix: Inherit sk_flags at connect().
> +af_unix: Move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
> +net: Restrict SO_PASS{CRED,PIDFD,SEC} to AF_{UNIX,NETLINK,BLUETOOTH}.
> +tcp: Restrict SO_TXREHASH to TCP socket.
> +scm: Move scm_recv() from scm.h to scm.c.
> +af_unix: Don't pass struct socket to maybe_add_creds().
> +af_unix: Factorise test_bit() for SOCK_PASSCRED and SOCK_PASSPIDFD.
> 
> I haven't dug into it, gotta review / apply other patches :(
> Maybe you can try to repro? 

I think I was able to reproduce it with SO_PASSRIGHTS series
with virtme-ng (but not with normal qemu with AL2023 rootfs).

After 2min, virtme-ng showed the console.

[    1.461450] virtme-ng-init: triggering udev coldplug
[    1.533147] virtme-ng-init: waiting for udev to settle
[  121.588624] virtme-ng-init: Timed out for waiting the udev queue being empty.
[  121.588710] virtme-ng-init: udev is done
[  121.593214] virtme-ng-init: initialization done
          _      _
   __   _(_)_ __| |_ _ __ ___   ___       _ __   __ _
   \ \ / / |  __| __|  _   _ \ / _ \_____|  _ \ / _  |
    \ V /| | |  | |_| | | | | |  __/_____| | | | (_| |
     \_/ |_|_|   \__|_| |_| |_|\___|     |_| |_|\__  |
                                                |___/
   kernel version: 6.15.0-rc4-virtme-00071-gceba111cf5e7 x86_64
   (CTRL+d to exit)


Will investigate the cause.

Sorry, but please drop the series and kick the CI again.

Thanks!

