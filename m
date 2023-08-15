Return-Path: <netdev+bounces-27603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D2B77C840
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FF01C20C67
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5748828;
	Tue, 15 Aug 2023 07:01:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332F81857
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7CDC433C8;
	Tue, 15 Aug 2023 07:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692082916;
	bh=/meUY+oN+XVpIa8/E3ykWEy/wLab0vdKq+vyS5v4u9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPJ/TL4eB9mc0Wp8v7qYntt88KDUc+Sr8IusUrkPKwnidA5jg8tlRFhDnogYt/ZfN
	 hoSuc45ZVm74UGo5YjH3fsIlrzBgMKLL91n5mnqHmL967aOHzutMKcdBBBzdwjbORw
	 M041YXmC7IHPaUOEZIBH8+cNVU2oVb+4x9PA42oBVC2yfBQlkz9M8oW05VXyOYe3jn
	 gPrd8rKQW57ywefmxsrOqNCgWMTPo0O9paz2kg3A7BDZ0uY0ayNOvhdDYWnG0ysRIp
	 prFlFNbHbNkQFPnb24Wzs75xVGdh21cJ7k/WtoQFmUk9v+kaSq3FZlACzApPXXWA2o
	 XXsMhTxvaDs3A==
Date: Tue, 15 Aug 2023 10:01:51 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com,
	syzbot+7456b5dcf65111553320@syzkaller.appspotmail.com,
	pshelar@ovn.org, andrey.zhadchenko@virtuozzo.com,
	brauner@kernel.org, dev@openvswitch.org
Subject: Re: [PATCH net] net: openvswitch: reject negative ifindex
Message-ID: <20230815070151.GF22185@unreal>
References: <20230814203840.2908710-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814203840.2908710-1-kuba@kernel.org>

On Mon, Aug 14, 2023 at 01:38:40PM -0700, Jakub Kicinski wrote:
> Recent changes in net-next (commit 759ab1edb56c ("net: store netdevs
> in an xarray")) refactored the handling of pre-assigned ifindexes
> and let syzbot surface a latent problem in ovs. ovs does not validate
> ifindex, making it possible to create netdev ports with negative
> ifindex values. It's easy to repro with YNL:
> 
> $ ./cli.py --spec netlink/specs/ovs_datapath.yaml \
>          --do new \
> 	 --json '{"upcall-pid": 1, "name":"my-dp"}'
> $ ./cli.py --spec netlink/specs/ovs_vport.yaml \
> 	 --do new \
> 	 --json '{"upcall-pid": "00000001", "name": "some-port0", "dp-ifindex":3,"ifindex":4294901760,"type":2}'
> 
> $ ip link show
> -65536: some-port0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 7a:48:21:ad:0b:fb brd ff:ff:ff:ff:ff:ff
> ...
> 
> Validate the inputes. Now the second command correctly returns:
> 
> $ ./cli.py --spec netlink/specs/ovs_vport.yaml \
> 	 --do new \
> 	 --json '{"upcall-pid": "00000001", "name": "some-port0", "dp-ifindex":3,"ifindex":4294901760,"type":2}'
> 
> lib.ynl.NlError: Netlink error: Numerical result out of range
> nl_len = 108 (92) nl_flags = 0x300 nl_type = 2
> 	error: -34	extack: {'msg': 'integer out of range', 'unknown': [[type:4 len:36] b'\x0c\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0c\x00\x03\x00\xff\xff\xff\x7f\x00\x00\x00\x00\x08\x00\x01\x00\x08\x00\x00\x00'], 'bad-attr': '.ifindex'}
> 
> Accept 0 since it used to be silently ignored.
> 
> Fixes: 54c4ef34c4b6 ("openvswitch: allow specifying ifindex of new interfaces")
> Reported-by: syzbot+7456b5dcf65111553320@syzkaller.appspotmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: pshelar@ovn.org
> CC: andrey.zhadchenko@virtuozzo.com
> CC: brauner@kernel.org
> CC: dev@openvswitch.org
> ---
>  net/openvswitch/datapath.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

