Return-Path: <netdev+bounces-46054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8297E1050
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 17:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D42281700
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3481A5A9;
	Sat,  4 Nov 2023 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7eBe8wx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721B747B
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 16:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF047C433C8;
	Sat,  4 Nov 2023 16:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699114383;
	bh=IBPCzWdCdDg9prsaOp5eMlCDatSGD23F6ve5k8hhS4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7eBe8wxqxcpe0z0+dLLdnfA1v077tnxrQFVK6/UZSbb+a5RQhqfQondUy0+otDPY
	 M4yScJgSK2vbCLf+FjFG5S1AOkh3roOr1ltSJ3dfRzXgi2F50aSeaZt4FRGYQR0S1x
	 iMDG9tzXwBnYSNUuTyunfNEPMO8KTGdZes6Pjs6M6jlnbW9XIlrxMmbUEuf4/NV5Zd
	 Uo/Hu3cp/KKNuTmaPkVcik0cwQx9jyrR41Wlg3VL9Uv19GeEj7q4ORFrFAIXOLd1gz
	 k6r2faVOJvQgedeswe4A2tLtyz+P0HsYwBXsEETeXUdXVhd5w5TNEwyoYdut0WpR/K
	 UWexcZmRBIVFg==
Date: Sat, 4 Nov 2023 12:12:48 -0400
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
	daniel@iogearbox.net, idosch@idosch.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/1] net, sched: Fix SKB_NOT_DROPPED_YET splat under
 debug config
Message-ID: <20231104161248.GM891380@kernel.org>
References: <20231028171610.28596-1-jhs@mojatatu.com>
 <20231104131054.GB891380@kernel.org>
 <CAM0EoMn195kQXDq9hn=NZoCNHOVyh3qS1kGxN+N3q4qNXj2mVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMn195kQXDq9hn=NZoCNHOVyh3qS1kGxN+N3q4qNXj2mVA@mail.gmail.com>

On Sat, Nov 04, 2023 at 11:46:22AM -0400, Jamal Hadi Salim wrote:
> On Sat, Nov 4, 2023 at 9:11 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Sat, Oct 28, 2023 at 01:16:10PM -0400, Jamal Hadi Salim wrote:
> > > Getting the following splat [1] with CONFIG_DEBUG_NET=y and this
> > > reproducer [2]. Problem seems to be that classifiers clear 'struct
> > > tcf_result::drop_reason', thereby triggering the warning in
> > > __kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (0).
> > >
> > > Fixed by disambiguating a legit error from a verdict with a bogus drop_reason
> > >
> > > [1]
> > > WARNING: CPU: 0 PID: 181 at net/core/skbuff.c:1082 kfree_skb_reason+0x38/0x130
> > > Modules linked in:
> > > CPU: 0 PID: 181 Comm: mausezahn Not tainted 6.6.0-rc6-custom-ge43e6d9582e0 #682
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc37 04/01/2014
> > > RIP: 0010:kfree_skb_reason+0x38/0x130
> > > [...]
> > > Call Trace:
> > >  <IRQ>
> > >  __netif_receive_skb_core.constprop.0+0x837/0xdb0
> > >  __netif_receive_skb_one_core+0x3c/0x70
> > >  process_backlog+0x95/0x130
> > >  __napi_poll+0x25/0x1b0
> > >  net_rx_action+0x29b/0x310
> > >  __do_softirq+0xc0/0x29b
> > >  do_softirq+0x43/0x60
> > >  </IRQ>
> > >
> > > [2]
> > >
> > > ip link add name veth0 type veth peer name veth1
> > > ip link set dev veth0 up
> > > ip link set dev veth1 up
> > > tc qdisc add dev veth1 clsact
> > > tc filter add dev veth1 ingress pref 1 proto all flower dst_mac 00:11:22:33:44:55 action drop
> > > mausezahn veth0 -a own -b 00:11:22:33:44:55 -q -c 1
> > >
> > > Ido reported:
> > >
> > >   [...] getting the following splat [1] with CONFIG_DEBUG_NET=y and this
> > >   reproducer [2]. Problem seems to be that classifiers clear 'struct
> > >   tcf_result::drop_reason', thereby triggering the warning in
> > >   __kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (0). [...]
> > >
> > >   [1]
> > >   WARNING: CPU: 0 PID: 181 at net/core/skbuff.c:1082 kfree_skb_reason+0x38/0x130
> > >   Modules linked in:
> > >   CPU: 0 PID: 181 Comm: mausezahn Not tainted 6.6.0-rc6-custom-ge43e6d9582e0 #682
> > >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc37 04/01/2014
> > >   RIP: 0010:kfree_skb_reason+0x38/0x130
> > >   [...]
> > >   Call Trace:
> > >    <IRQ>
> > >    __netif_receive_skb_core.constprop.0+0x837/0xdb0
> > >    __netif_receive_skb_one_core+0x3c/0x70
> > >    process_backlog+0x95/0x130
> > >    __napi_poll+0x25/0x1b0
> > >    net_rx_action+0x29b/0x310
> > >    __do_softirq+0xc0/0x29b
> > >    do_softirq+0x43/0x60
> > >    </IRQ>
> > >
> > >   [2]
> > >   #!/bin/bash
> > >
> > >   ip link add name veth0 type veth peer name veth1
> > >   ip link set dev veth0 up
> > >   ip link set dev veth1 up
> > >   tc qdisc add dev veth1 clsact
> > >   tc filter add dev veth1 ingress pref 1 proto all flower dst_mac 00:11:22:33:44:55 action drop
> > >   mausezahn veth0 -a own -b 00:11:22:33:44:55 -q -c 1
> > >
> > > What happens is that inside most classifiers the tcf_result is copied over
> > > from a filter template e.g. *res = f->res which then implicitly overrides
> > > the prior SKB_DROP_REASON_TC_{INGRESS,EGRESS} default drop code which was
> > > set via sch_handle_{ingress,egress}() for kfree_skb_reason().
> > >
> > > Commit text above copied verbatim from Daniel. The general idea of the patch
> > > is not very different from what Ido originally posted but instead done at the
> > > cls_api codepath.
> > >
> > > Fixes: 54a59aed395c ("net, sched: Make tc-related drop reason more flexible")
> > > Reported-by: Ido Schimmel <idosch@idosch.org>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > Link: https://lore.kernel.org/netdev/ZTjY959R+AFXf3Xy@shredder
> >
> > Hi Jamal,
> >
> > FWIIW, I think it would be nicer to fix this the classifiers so they don't
> > do this, which by my reading is what Daniel's patch did.
> >
> 
> I dont believe it was nicer tbh.

I thought you might say that :)

> In any case we are going to send cleanups to do this with skb cb.

Thanks, I'll look out for the new patch.

> > But, I don't feel strongly about this and I do tend to think the
> > approach taken in this patch is a nice clean fix for net.
> >
> > Reviewed-by: Simon Horman <horms@kernel.org>
> >
> > BTW, this patch is marked as Not Applicable in patchwork.
> > I am unsure why.
> 
> Weird.

