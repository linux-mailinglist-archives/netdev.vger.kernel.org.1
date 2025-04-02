Return-Path: <netdev+bounces-178915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1601EA798C5
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4061886552
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 23:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDD21F4608;
	Wed,  2 Apr 2025 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wmisjzy+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0151EF0A3
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636270; cv=none; b=gIobWXF2U87fET4p+jZzcveH4PTWEhtulgl/MxXvhf9xkAwCfJF5gsQrN27Yp2T82sExLNc0txnrPAC3jPj8B02yFXanR+1LWvMCobaVqBgHj4oJvRUiiSnVaoPvLTzfm4rFsSh3T0NtNzEQPSH0ngfgGorZ7z/daSuVSHC5mXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636270; c=relaxed/simple;
	bh=ItVDTJdNiw8uaHk9iV1rg5Ps7P/YyhnkysOK88V2Xkc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6jJYzp3PEwA5rrtNoUuBuDbrvTFNf5A8jTjuoqFE3Zsc0Mwdmq7cmnFBXF+zpf4n2fnAyamcmi0KvDiKthFVSlD46Jtae+B4hdyBEPv2eXHy1nyFUNNTGoJzNrJ9JCfeCfGzfFBy9PEmDObz+bS1o5ksbCXylB2uPkAI54qyWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wmisjzy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E70C4CEDD;
	Wed,  2 Apr 2025 23:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743636269;
	bh=ItVDTJdNiw8uaHk9iV1rg5Ps7P/YyhnkysOK88V2Xkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wmisjzy+Cjy+0/xHWlvRmtl+ZLL/mI/bL3ST1r8KYql5/RPb5bg1RKteRJBneMrSa
	 qQPESIakYdsFgZLWgkL/eTLJXkS+lBMoNz8sqrlY4x4EbU06UvPIwrO+XCQnIsdVi4
	 j4B3lyKMj6gqT/OHgxf4mQV2hTlERQeezZ/HVFYSan49VIlWS95DfikJyde8To0IRi
	 Hpa2ooliMCQG3b3AY4npbJfDSND+5X9S9qV0Zy86j55H347rCwDdY53tg0QaZB1G4u
	 3UP9zBIaSs2AKF67TEdhErz8xPXRpePnVUhxwpzER4o/mOD5VcWEutERY2x0FOOQ8W
	 8S0xdC0xs4F/Q==
Date: Wed, 2 Apr 2025 16:24:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>, sdf@fomichev.me
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ap420073@gmail.com, asml.silence@gmail.com, dw@davidwei.uk
Subject: Re: [PATCH net 2/2] net: avoid false positive warnings in
 __net_mp_close_rxq()
Message-ID: <20250402162428.4afc90cb@kernel.org>
In-Reply-To: <CAHS8izNWqPpeRvnF4no8VOs0YpFCahG9WNsVB8VLuaWsUy_-+w@mail.gmail.com>
References: <20250331194201.2026422-1-kuba@kernel.org>
	<20250331194308.2026940-1-kuba@kernel.org>
	<CAHS8izNWqPpeRvnF4no8VOs0YpFCahG9WNsVB8VLuaWsUy_-+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 11:52:50 -0700 Mina Almasry wrote:
> >         netdev_lock(dev);
> > -       __net_mp_close_rxq(dev, ifq_idx, old_p);
> > +       /* Callers holding a netdev ref may get here after we already
> > +        * went thru shutdown via dev_memory_provider_uninstall().
> > +        */
> > +       if (dev->reg_state <= NETREG_REGISTERED)
> > +               __net_mp_close_rxq(dev, ifq_idx, old_p);  
> 
> Not obvious to me why this check was moved. Do you expect to call
> __net_mp_close_rxq on an unregistered netdev and expect it to succeed
> in io_uring binding or something?

Yes, iouring state is under spin lock it can't call in here atomically.
device unregister may race with iouring shutdown.

Now that I look at it I think we need

diff --git a/net/core/dev.c b/net/core/dev.c
index be17e0660144..0a70080a1209 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11947,6 +11947,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
                unlist_netdevice(dev);
                netdev_lock(dev);
                WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);
+               dev_memory_provider_uninstall(dev);
                netdev_unlock(dev);
        }
        flush_all_backlogs();
@@ -11961,7 +11962,6 @@ void unregister_netdevice_many_notify(struct list_head *head,
                dev_tcx_uninstall(dev);
                netdev_lock_ops(dev);
                dev_xdp_uninstall(dev);
-               dev_memory_provider_uninstall(dev);
                netdev_unlock_ops(dev);
                bpf_dev_bound_netdev_unregister(dev);

since 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
we drop the lock after setting UNREGISTERING so we may call .uninstall
after iouring torn down its side.

Right, Stan?

