Return-Path: <netdev+bounces-175139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6A0A63742
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 20:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6363AE657
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 19:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F601CCEC8;
	Sun, 16 Mar 2025 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Z0iHAaG3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928598F5E;
	Sun, 16 Mar 2025 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742154138; cv=none; b=BoI8NlERNPdre/Eyflxv3GwMGYf+1FJWK95QY8tnCpAGOdzH55i2gQ/LNqFCLbEsTB4OSY7eR8wRMtS965aIvpnCz3An2xE2N0tYEvAHIbp/D0cpmzUi/fU1+hkAcPZKYpfIrCokgi6yPlFcxCcKtRrU+y4wtrw1brDNk2P6VqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742154138; c=relaxed/simple;
	bh=18zHOQIXGAybHcjA06dHs5rydnqcg3S53cn8XNzeJpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wgf6ABSmPfnXw5qy5dMVzS6TEBUWVKQp1Nn9GpF1cJ8osfpHjpZrAQkgSmmARlz83Z9cainKHjIrmdgN6j+Z5QBz8lavNShFHkLqPEnTpBNCFu7lp8IO1uVzfOAwiq9KLY40irrXOEas8id4o3O6W15tSQyf66CPkqxNg77WEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Z0iHAaG3; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742154137; x=1773690137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UWO7ZTm/qXjZpCxF4k5eUGMoYbri6JKoyMc1jHkmoo8=;
  b=Z0iHAaG3XDoEIBkvTsb9MlqMYxIlX5zKRS6D5e3iBAa/sUfoUtmE/jZr
   kD3LEhZxt5QEy4Z+RtcdcsauH5d7cN0cNwZX+NM51XyIxaFRMxpT1DJOP
   rsV4M9NC7IZOag/eCe0ZJboVgC3TMyrwKwYqzOa7SGsxcy/mKZlGMOmj1
   M=;
X-IronPort-AV: E=Sophos;i="6.14,252,1736812800"; 
   d="scan'208";a="705480033"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 19:42:13 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:39755]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.127:2525] with esmtp (Farcaster)
 id 8e4d5b63-0a54-4e41-840b-cdc676e69e51; Sun, 16 Mar 2025 19:42:12 +0000 (UTC)
X-Farcaster-Flow-ID: 8e4d5b63-0a54-4e41-840b-cdc676e69e51
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 16 Mar 2025 19:42:11 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.216.189) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 16 Mar 2025 19:42:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <stfomichev@gmail.com>
CC: <aleksander.lobakin@intel.com>, <bigeasy@linutronix.de>,
	<davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<jdamato@fastly.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <xnxc22xnxc22@qq.com>
Subject: Re: Linux6.14-rc5:  INFO: task hung in register_netdevice_notifier_net
Date: Sun, 16 Mar 2025 12:41:51 -0700
Message-ID: <20250316194201.21195-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <Z9cCQ1huViMjZkvS@mini-arch>
References: <Z9cCQ1huViMjZkvS@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Sun, 16 Mar 2025 09:54:27 -0700
> On 03/16, ffhgfv wrote:
> > Hello, I found a bug titled "   INFO: task hung in register_netdevice_notifier_net  " with modified syzkaller in the Linux6.14-rc5.
> > If you fix this issue, please add the following tag to the commit:  Reported-by: Jianzhou Zhao <xnxc22xnxc22@qq.com>,    xingwei lee <xrivendell7@gmail.com>, Zhizhuo Tang <strforexctzzchange@foxmail.com>
> 
> Haven't looked that deep, but it seems to involve a tunneling device,
> so I wonder whether it's gonna be fixed by:
> - https://patchwork.kernel.org/project/netdevbpf/patch/20250312190513.1252045-2-sdf@fomichev.me/
> - https://patchwork.kernel.org/project/netdevbpf/patch/20250312190513.1252045-3-sdf@fomichev.me/
> 
> Do you have a repro? Can you rerun with the above fixes and enable
> lockdep?

It seems lockdep is enabled but doesn't report any locking bug,
so I think this report is generated simply because of RTNL storm by
syzkaller.

I have 200+ task hung reports due to RTNL on my syzkaller instances.

The tunnel part is ip_tunnel_init_net() that takes RTNL too for
register_netdevice().

