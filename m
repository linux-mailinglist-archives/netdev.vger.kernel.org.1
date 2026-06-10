Return-Path: <netdev+bounces-297656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OuOmOrhXKWpSVQMAu9opvQ
	(envelope-from <netdev+bounces-297656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:25:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7108566940D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:25:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297656-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297656-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C86D305F0A1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7DB404BD0;
	Wed, 10 Jun 2026 12:19:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC854406838
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:19:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093986; cv=none; b=o+aOEI0K9BnyUJZXoXYzqngqq0rONpN1KKQ+q+m/80fdxEofDENLgrEf4YoNldvgMTDXab+5v+oYJAWHVRWfGkO0821kcp77yz5JVVVl3hva7z1xENA2wJ8oOH2UO8ncyndzLyFUVOi8R1nZixtsSQ6XcmVFNKkPcHI0n/F334w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093986; c=relaxed/simple;
	bh=TSkU4cUHbJjkzOb7Q7xx+5b0DbI7AovkCSZZhux1Cys=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=XopybzFqzFCDX7aiFqm8YdXeaFkNeaH+ZeEj5Gfbn3Hdz6tNsut3/MAIkso6sQaYhCHzGNuG+mRiLuWM+RQYl20TmFX34H4TY8N1uZxI41fH94OoQBWmsrtv28NDXoZCtAGy78LufZXKO9MPab9RefknfnHI27cVUUxngpK5oNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id BD34E808B1;
	Wed, 10 Jun 2026 14:19:32 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net] virtio_net: do not allow tunnel csum offload for
 non GSO packets
From: Gabriel Goller <g.goller@proxmox.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev, 
 Willem de Bruijn <willemb@google.com>
In-Reply-To: <38d33d63ce5d1aee486bd6c7c47345040d526e35.1781016169.git.pabeni@redhat.com>
References: <38d33d63ce5d1aee486bd6c7c47345040d526e35.1781016169.git.pabeni@redhat.com>
Date: Wed, 10 Jun 2026 14:19:26 +0200
Message-Id: <178109396600.129329.5073003425673349392.b4-review@b4>
X-Mailer: b4 0.15.2
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1781093925257
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[proxmox.com];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:virtualization@lists.linux.dev,m:willemb@google.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[g.goller@proxmox.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[g.goller@proxmox.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297656-lists,netdev=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7108566940D

On Tue, 09 Jun 2026 16:44:26 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> [...]
> 
> Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> Reported-by: Fiona Ebner <f.ebner@proxmox.com>
> Closes: https://bugzilla.proxmox.com/show_bug.cgi?id=7627
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Gave it a spin and it works alright, so consider:

>
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..07b8710639f9 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6222,6 +6222,18 @@ static void virtnet_free_irq_moder(struct virtnet_info *vi)
>  	rtnl_unlock();
>  }
>  
> +static netdev_features_t virtnet_features_check(struct sk_buff *skb,
> +						struct net_device *dev,
> +						netdev_features_t features)
> +{
> +	/* Inner csum offload is only available for GSO packets. */
> +	if (skb->encapsulation && !skb_is_gso(skb))

A small question -- should we maybe check for skb_gso_ok here as well?
So add:

	(!skb_is_gso(skb) || !skb_gso_ok(skb, features)))

Because skb_is_gso alone doesn't guarantee that the packets leaving virtio will
be gso'd, they could be software gso'd at validate_xmit_skb, which is called
after ndo_feature_check.
leaving the virtio device.

Not sure if this can happen though.

> @@ -6235,7 +6247,7 @@ static const struct net_device_ops virtnet_netdev = {
>  	.ndo_bpf		= virtnet_xdp,
>  	.ndo_xdp_xmit		= virtnet_xdp_xmit,
>  	.ndo_xsk_wakeup         = virtnet_xsk_wakeup,
> -	.ndo_features_check	= passthru_features_check,
> +	.ndo_features_check	= virtnet_features_check,
>  	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
>  	.ndo_set_features	= virtnet_set_features,
>  	.ndo_tx_timeout		= virtnet_tx_timeout,

Thanks,
Gabriel

Tested-by: Gabriel Goller <g.goller@proxmox.com>
So: packet is a GSO packet but will be segmented by validate_xmit_skb before

So: packet is a GSO packet but will be segmented by validate_xmit_skb before

-- 
Gabriel Goller <g.goller@proxmox.com>


