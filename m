Return-Path: <netdev+bounces-246733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD3DCF0B4B
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 08:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AB25300908D
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 07:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66F32DF131;
	Sun,  4 Jan 2026 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U4x7Jn0K"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53E625BEE8;
	Sun,  4 Jan 2026 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767511272; cv=none; b=ZebTWcqwmyDTOyqAWxstGPlTK8bYMD+R5mWkNgwZswZqxPJWr8NRreh3Tb9AopuGvZXA88VG7mp4ZLCry1pfHkncyRgmROTQGvMWWH4zoghnQPH+YOHw7D973N/LyN0KUGje6ZEZdiz0P2/2/3sP0+ablIBvn+WLXlM0fCstr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767511272; c=relaxed/simple;
	bh=Nk/fjs8FcelrSkKsc+dOnGGEP6Ts5C8YS2rUAQ1wCGE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=gYuWQO7Bw4Lz9Qejp1yCQe5C2pI6l6ebTz+MoyWS9FO/fUNhQI1SY57phET7nn6YCWkHmfYLDAnb/FVQupUpZby6VVymvtjISnzpqpTKJjSvaJkxkcpSajBz+hKmbRPzbJPPTesKFBnv9DUx7zLTJHabOzcYmelhsO8gIsvMAL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U4x7Jn0K; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767511260; h=Message-ID:Subject:Date:From:To;
	bh=9HsuVJqs0td5USr9OHW02fGRO++tosykJqJGYFCtWaY=;
	b=U4x7Jn0KCPV78AOTVYvCcm1wWNSFEKow4yoCGjK3Ac2e/P5hUPBNaSPXrR+goDcHb5Bexkd5SGgbfmQW54x6v6RIn7HxwPQINPaOwL27stt7FPYVtJB6WbiU0qVx/O2muM9PuUQF3LOcgkV7SmR7QSUvkMapgKvU36zffGNFu2c=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WwCk1J._1767511259 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 04 Jan 2026 15:20:59 +0800
Message-ID: <1767511249.7713199-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio_net: fix device mismatch in devm_kzalloc/devm_kfree
Date: Sun, 4 Jan 2026 15:20:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Kommula Shiva Shankar <kshankar@marvell.com>
Cc: <mst@redhat.com>,
 <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>,
 <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>,
 <edumazet@google.com>,
 <kuba@kernel.org>,
 <pabeni@redhat.com>,
 <virtualization@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>,
 <jerinj@marvell.com>,
 <ndabilpuram@marvell.com>,
 <schalla@marvell.com>,
 <netdev@vger.kernel.org>
References: <20260102101900.692770-1-kshankar@marvell.com>
In-Reply-To: <20260102101900.692770-1-kshankar@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>


LGTM

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

On Fri, 2 Jan 2026 15:49:00 +0530, Kommula Shiva Shankar <kshankar@marvell.com> wrote:
> Initial rss_hdr allocation uses virtio_device->device,
> but virtnet_set_queues() frees using net_device->device.
> This device mismatch causing below devres warning
>
> [ 3788.514041] ------------[ cut here ]------------
> [ 3788.514044] WARNING: drivers/base/devres.c:1095 at devm_kfree+0x84/0x98, CPU#16: vdpa/1463
> [ 3788.514054] Modules linked in: octep_vdpa virtio_net virtio_vdpa [last unloaded: virtio_vdpa]
> [ 3788.514064] CPU: 16 UID: 0 PID: 1463 Comm: vdpa Tainted: G        W           6.18.0 #10 PREEMPT
> [ 3788.514067] Tainted: [W]=WARN
> [ 3788.514069] Hardware name: Marvell CN106XX board (DT)
> [ 3788.514071] pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> [ 3788.514074] pc : devm_kfree+0x84/0x98
> [ 3788.514076] lr : devm_kfree+0x54/0x98
> [ 3788.514079] sp : ffff800084e2f220
> [ 3788.514080] x29: ffff800084e2f220 x28: ffff0003b2366000 x27: 000000000000003f
> [ 3788.514085] x26: 000000000000003f x25: ffff000106f17c10 x24: 0000000000000080
> [ 3788.514089] x23: ffff00045bb8ab08 x22: ffff00045bb8a000 x21: 0000000000000018
> [ 3788.514093] x20: ffff0004355c3080 x19: ffff00045bb8aa00 x18: 0000000000080000
> [ 3788.514098] x17: 0000000000000040 x16: 000000000000001f x15: 000000000007ffff
> [ 3788.514102] x14: 0000000000000488 x13: 0000000000000005 x12: 00000000000fffff
> [ 3788.514106] x11: ffffffffffffffff x10: 0000000000000005 x9 : ffff800080c8c05c
> [ 3788.514110] x8 : ffff800084e2eeb8 x7 : 0000000000000000 x6 : 000000000000003f
> [ 3788.514115] x5 : ffff8000831bafe0 x4 : ffff800080c8b010 x3 : ffff0004355c3080
> [ 3788.514119] x2 : ffff0004355c3080 x1 : 0000000000000000 x0 : 0000000000000000
> [ 3788.514123] Call trace:
> [ 3788.514125]  devm_kfree+0x84/0x98 (P)
> [ 3788.514129]  virtnet_set_queues+0x134/0x2e8 [virtio_net]
> [ 3788.514135]  virtnet_probe+0x9c0/0xe00 [virtio_net]
> [ 3788.514139]  virtio_dev_probe+0x1e0/0x338
> [ 3788.514144]  really_probe+0xc8/0x3a0
> [ 3788.514149]  __driver_probe_device+0x84/0x170
> [ 3788.514152]  driver_probe_device+0x44/0x120
> [ 3788.514155]  __device_attach_driver+0xc4/0x168
> [ 3788.514158]  bus_for_each_drv+0x8c/0xf0
> [ 3788.514161]  __device_attach+0xa4/0x1c0
> [ 3788.514164]  device_initial_probe+0x1c/0x30
> [ 3788.514168]  bus_probe_device+0xb4/0xc0
> [ 3788.514170]  device_add+0x614/0x828
> [ 3788.514173]  register_virtio_device+0x214/0x258
> [ 3788.514175]  virtio_vdpa_probe+0xa0/0x110 [virtio_vdpa]
> [ 3788.514179]  vdpa_dev_probe+0xa8/0xd8
> [ 3788.514183]  really_probe+0xc8/0x3a0
> [ 3788.514186]  __driver_probe_device+0x84/0x170
> [ 3788.514189]  driver_probe_device+0x44/0x120
> [ 3788.514192]  __device_attach_driver+0xc4/0x168
> [ 3788.514195]  bus_for_each_drv+0x8c/0xf0
> [ 3788.514197]  __device_attach+0xa4/0x1c0
> [ 3788.514200]  device_initial_probe+0x1c/0x30
> [ 3788.514203]  bus_probe_device+0xb4/0xc0
> [ 3788.514206]  device_add+0x614/0x828
> [ 3788.514209]  _vdpa_register_device+0x58/0x88
> [ 3788.514211]  octep_vdpa_dev_add+0x104/0x228 [octep_vdpa]
> [ 3788.514215]  vdpa_nl_cmd_dev_add_set_doit+0x2d0/0x3c0
> [ 3788.514218]  genl_family_rcv_msg_doit+0xe4/0x158
> [ 3788.514222]  genl_rcv_msg+0x218/0x298
> [ 3788.514225]  netlink_rcv_skb+0x64/0x138
> [ 3788.514229]  genl_rcv+0x40/0x60
> [ 3788.514233]  netlink_unicast+0x32c/0x3b0
> [ 3788.514237]  netlink_sendmsg+0x170/0x3b8
> [ 3788.514241]  __sys_sendto+0x12c/0x1c0
> [ 3788.514246]  __arm64_sys_sendto+0x30/0x48
> [ 3788.514249]  invoke_syscall.constprop.0+0x58/0xf8
> [ 3788.514255]  do_el0_svc+0x48/0xd0
> [ 3788.514259]  el0_svc+0x48/0x210
> [ 3788.514264]  el0t_64_sync_handler+0xa0/0xe8
> [ 3788.514268]  el0t_64_sync+0x198/0x1a0
> [ 3788.514271] ---[ end trace 0000000000000000 ]---
>
> Fix by using virtio_device->device consistently for
> allocation and deallocation
>
> Fixes: 4944be2f5ad8c ("virtio_net: Allocate rss_hdr with devres")
> Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
> ---
>  drivers/net/virtio_net.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1bb3aeca66c6..22d894101c01 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3791,7 +3791,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
>  		old_rss_hdr = vi->rss_hdr;
>  		old_rss_trailer = vi->rss_trailer;
> -		vi->rss_hdr = devm_kzalloc(&dev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
> +		vi->rss_hdr = devm_kzalloc(&vi->vdev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
>  		if (!vi->rss_hdr) {
>  			vi->rss_hdr = old_rss_hdr;
>  			return -ENOMEM;
> @@ -3802,7 +3802,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>
>  		if (!virtnet_commit_rss_command(vi)) {
>  			/* restore ctrl_rss if commit_rss_command failed */
> -			devm_kfree(&dev->dev, vi->rss_hdr);
> +			devm_kfree(&vi->vdev->dev, vi->rss_hdr);
>  			vi->rss_hdr = old_rss_hdr;
>  			vi->rss_trailer = old_rss_trailer;
>
> @@ -3810,7 +3810,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  				 queue_pairs);
>  			return -EINVAL;
>  		}
> -		devm_kfree(&dev->dev, old_rss_hdr);
> +		devm_kfree(&vi->vdev->dev, old_rss_hdr);
>  		goto succ;
>  	}
>
> --
> 2.48.1
>

