Return-Path: <netdev+bounces-246563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1105CEE58C
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 12:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A351A300AFC4
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 11:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F372F5319;
	Fri,  2 Jan 2026 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QS2vcJXS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lAmC0eft"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1C427BF6C
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 11:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767353290; cv=none; b=R1ZTzwHl0PoR+eiM5rBnlAapN8kbHEAZfZkVHeFItnPJVPLQc8x/ACHYaw65WGMc3nvnTeFpMTfN6IIuzLgTeBIeG5sgfIdHpcH4vGGsKDK+KEq5US4Fn2iHawGuUJUaIwloKTllKJTcj2rFv9pngA18omBxsHSsVYl44oomt9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767353290; c=relaxed/simple;
	bh=MrA/iC6uXK00oFfnomIoFNL4cI3ON8WRR4eo/8OcvIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ValUSYrDFqZmJCSgAARxlMglcVz0egI9OrI6bkW0Nyb2NfEZRlzECF/2D+zw8ZkJZMtPHK0XYXqs/SRiPkGxYcKBcy8gxxBauXb2fdX+udPwybQXwLar8rtVwkzzUyoSrACZOodqtGPYM+P/qQOIrFnrBrijzIghL+hEq31hIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QS2vcJXS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lAmC0eft; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767353284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a5KWW+w9vwNZz8IB9ClsEs76JwqPsCktHDEUEsy01HU=;
	b=QS2vcJXSuiU02YNmlWSUMe5dMCFtxn4N/UB7DuXbG50xIGwKEHqiWoyty0YI0nss5wGC6E
	sBkKnvRocC34wabLeT9eXAAkcrGV2vmalQQuAJ+ixUsm76ATfZaEw1sS45rn62/Ewd4knj
	/8HHIwG0aJkW5N13SRucgeDOH5RoMXY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-ZXjDK25gMeyu6Cwgb1wO2w-1; Fri, 02 Jan 2026 06:28:01 -0500
X-MC-Unique: ZXjDK25gMeyu6Cwgb1wO2w-1
X-Mimecast-MFC-AGG-ID: ZXjDK25gMeyu6Cwgb1wO2w_1767353281
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d5c7a2f54so13290635e9.1
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 03:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767353280; x=1767958080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5KWW+w9vwNZz8IB9ClsEs76JwqPsCktHDEUEsy01HU=;
        b=lAmC0eftrH1Aa4L3QgxLJUIAJMGLfCZIh3KvjRZaNsipSAbKl8ajBMUtQtTAfRShfg
         o+D0nrbfAARNn+RcvBvNlnwwDM2F7nSUQdkTfy4tKWSa9Qa18KnXxsYyHNusj9xX5E/0
         wjyFvhht+CIcyPhCui7m8WyN+NtMXwSZfDy/jee2ZxaosuKZjreic0mvjK7wR9qQVjoo
         IMa0S4l3RCCOYxYzu3qm7Q2MYM/psmQ98E5x+lQ4NQz8S4ZEdUzFNB2oJixUQB2kaNom
         VtuFOwXyysyDlXbw/REmCi+XzDRxanNN+QMpkugJMOLyF7aIhCy96kFriOzJIIq+mAPL
         ZXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767353280; x=1767958080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5KWW+w9vwNZz8IB9ClsEs76JwqPsCktHDEUEsy01HU=;
        b=ZNDN/LD3YeP0vs/0RenWenSsCoGHT5CNHWD0ylBjafXfLEp+kKDEV4K/EsMKP6ZqOX
         OWsyKLowbEj6wr0jpUjXtoG6arXr/YNi870uc9UqilZgfp3AtVeJIz+jh3lDQwpFhfC/
         uP+dvo8TfoBqccMal6Qc7L0p9ktrPoFq3Frm5NIu/3PsQDgjiTo7acP54VVppTihS89E
         Do9vkJ3N4xCHd5FOOKjkeylqIgcLWHst+H+Yb2lwwD+XWP5Ubqdg5cf8m6Z9XuPin/8T
         P9v53lRWDfMWRN7EmIibUKcbCXrP3Z3XeyXAZtUG8jC/UGxAmBNEdORt5l4UIqu6ShOP
         hzgA==
X-Gm-Message-State: AOJu0YzqQWcgISd+Jpo9t6HfTFcguN+28ofUY5YItebAD3+Oe0TaKLMG
	tKoNkiIqbnS+V6KQWAh30HupGr4xRuUO3VczreJ5n0ethZXtfy191ZL8mAr5Sw3cfrCXiqf0BYe
	mOvJLgpho3FF2W1x0dSSf/o+ZV8UY3QZfliHm872R6HzKRPzmHM7LBR4Ofw==
X-Gm-Gg: AY/fxX5KXMi2/i2u+4fSzAAyJn45sp7QxAjYQazLn0TZsRp5V2LQoaUOdjqSPfHz087
	qFkQEvkHW/THrKHeyagPKnA1R8GYRxX0LtI9nZBMJHjyeSY/tn5jiYRHJMJx0Pqe8UsrgKS9bxN
	80YA9C4wqUGV4ZmXphrQqG2HY3OoyvR0LQjIH4qdJ+SN/UGNSVOPCChBaO+3Qr/+14aAJAuCQpZ
	WkJr8zjVoV/Z6OHwK7fLTHpL4V352q2QbCTwBis9ZO3Y3FI963kjEbJMuT4EU95WjTn9Spa2Dpi
	jFQWut3Bz7gx55Sr+0j6jqpqvMLXXZ+nYkFmg00mbXmrizAUE1JDncCaAzKNd9MX32gUpDrEokf
	d5wWu8Kp/+fpSNFcdxzB/SxJ9uDv9wWThtA==
X-Received: by 2002:a05:600c:8b11:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-47d2d273999mr523916955e9.15.1767353280499;
        Fri, 02 Jan 2026 03:28:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSem6shw7vwIlPX3e1/RTDoSJUqFE1OPFk1fBhHK+goG5CCxGxCuV653N1vyh7HUcu+1Ah3w==
X-Received: by 2002:a05:600c:8b11:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-47d2d273999mr523916635e9.15.1767353280022;
        Fri, 02 Jan 2026 03:28:00 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27c2260sm769656105e9.15.2026.01.02.03.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 03:27:59 -0800 (PST)
Date: Fri, 2 Jan 2026 06:27:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kommula Shiva Shankar <kshankar@marvell.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jerinj@marvell.com, ndabilpuram@marvell.com, schalla@marvell.com
Subject: Re: [PATCH net] virtio_net: fix device mismatch in
 devm_kzalloc/devm_kfree
Message-ID: <20260102062457-mutt-send-email-mst@kernel.org>
References: <20260102101900.692770-1-kshankar@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102101900.692770-1-kshankar@marvell.com>

On Fri, Jan 02, 2026 at 03:49:00PM +0530, Kommula Shiva Shankar wrote:
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

And not just a warning, it can be a memleak/double free, right?

Acked-by: Michael S. Tsirkin <mst@redhat.com>

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


