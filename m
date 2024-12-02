Return-Path: <netdev+bounces-147966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0263D9DF89E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 02:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B852E1621DC
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 01:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27D31799B;
	Mon,  2 Dec 2024 01:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dMKX7oBo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECD8171C9
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 01:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733104289; cv=none; b=Yx3jSkb2dmNTAJ1qWepdejSJv/N33JhkGygWQoJ2t7hurFRtolCCOeGit18LdJj23AwcdK3/uT8tGFlxEtYy17BFWg+aS0QUmGYCIT4NxxyLuBTubd5yweKi0RGXHyuhICs2Ht//DgAj7/Ubb2NQiGlvnOnL6+sPVEAAZyIbVFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733104289; c=relaxed/simple;
	bh=2l3KE7bylHjFVh5AXBsoFd78q2e9cugb2NxB61CQJtc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXp9SIwcPQNv0/T2XLpOf+wpnyTau3Rueq7tOx4D3gL3btWPhKnDepTWumaHplDKpuWme0qkjEnaKopcNCl4jCwQMbWJXAzL3FY3lKVg/48GC52EMAxmOeeXgpIGMupTZNS3XO6DI2wAHb4fazN4k4cbaMiacNSBJwF5RgvVZgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dMKX7oBo; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733104287; x=1764640287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XiSLoYsQiWsbbS7djHjMKXWrQNxZdVfh0udBekthVAE=;
  b=dMKX7oBoOE6TQyrTiFcNgY0EiHGcW56GmT21Hp0WHOg6ovy4lb2mPR9o
   GZy4J23phl+EhPe/t2iT+l39MOjosOrL3klJiEEPsZUEOLWoe1RmUogkx
   T0FYR7Ywa+owXGmFycVwlkWbVGyurcTlXx3Bj98OVJP8SdKnawOb/f4W6
   U=;
X-IronPort-AV: E=Sophos;i="6.12,201,1728950400"; 
   d="scan'208";a="442216795"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 01:51:22 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:25731]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.147:2525] with esmtp (Farcaster)
 id ae2e2f8d-3f30-4193-8ec6-00eed72b1b74; Mon, 2 Dec 2024 01:51:21 +0000 (UTC)
X-Farcaster-Flow-ID: ae2e2f8d-3f30-4193-8ec6-00eed72b1b74
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 2 Dec 2024 01:51:21 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.8.244) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 2 Dec 2024 01:51:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <xiyou.wangcong@gmail.com>
CC: <cong.wang@bytedance.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com>
Subject: Re: [Patch net v2] rtnetlink: fix double call of rtnl_link_get_net_ifla()
Date: Mon, 2 Dec 2024 10:51:12 +0900
Message-ID: <20241202015112.78882-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241129212519.825567-1-xiyou.wangcong@gmail.com>
References: <20241129212519.825567-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Fri, 29 Nov 2024 13:25:19 -0800
> From: Cong Wang <cong.wang@bytedance.com>
> 
> Currently rtnl_link_get_net_ifla() gets called twice when we create
> peer devices, once in rtnl_add_peer_net() and once in each ->newlink()
> implementation.
> 
> This looks safer, however, it leads to a classic Time-of-Check to
> Time-of-Use (TOCTOU) bug since IFLA_NET_NS_PID is very dynamic. And
> because of the lack of checking error pointer of the second call, it
> also leads to a kernel crash as reported by syzbot.
> 
> Fix this by getting rid of the second call, which already becomes
> redudant after Kuniyuki's work. We have to propagate the result of the
> first rtnl_link_get_net_ifla() down to each ->newlink().
> 
> Reported-by: syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=21ba4d5adff0b6a7cfc6
> Fixes: 0eb87b02a705 ("veth: Set VETH_INFO_PEER to veth_link_ops.peer_type.")
> Fixes: 6b84e558e95d ("vxcan: Set VXCAN_INFO_PEER to vxcan_link_ops.peer_type.")
> Fixes: fefd5d082172 ("netkit: Set IFLA_NETKIT_PEER_INFO to netkit_link_ops.peer_type.")
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks for the fix and nice cleanup :)

