Return-Path: <netdev+bounces-297091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hZd4K70qKGqn/QIAu9opvQ
	(envelope-from <netdev+bounces-297091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:01:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D995661748
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:01:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=XAtxLEFL;
	dkim=pass header.d=redhat.com header.s=google header.b="i+s4/No9";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297091-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297091-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7BAF3091783
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD804219FF;
	Tue,  9 Jun 2026 14:51:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17238356760
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 14:51:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016676; cv=none; b=Rjb9XH8ETb1JI5nfIsN2gjS2OcwTQORbhg2PqGAWFhappNcKmTy2XBBZ+s+1YdkMi6DLAlS3SbyW3isfGgqo7PU/q6bLPffddYo2hCh1w4UL9eNfMmf4/eD+HBH180+FjjS0cpSv7Z1kyi4ukD3X/pif5yrQ7MQArxHEfX9v2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016676; c=relaxed/simple;
	bh=gWQ/Il4P4t0zTHBxAJZA63W9tJWeyjxCRza7HeFyBSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/TeVuTW26gk6Wgz5G0UN095c2W4bb6i56s+QuV8dxJSFxumakuOeCMXtTx3oFgap22fEAFNFFGbQW2HyMuusvenuU5tFXVRAakfCGzOhxc8kOpPBebR0Us1gZh8X74RkexC2+eSXy66AXQl0ngjsZQPwwuRxEV8puYbqCy8mj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAtxLEFL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+s4/No9; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781016666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LzesbWGj4YTo1y0et+ljf+77fl9oQ9V4yKu6m9JZpcY=;
	b=XAtxLEFLmAddGaFg6XxTgE8KDCmEWP80SmZahaZ1P5HTupcrsit7dNDgIoyjTwTFlt0aMB
	mo7yok5RbOR3bkFTIcmvlCnIyv/ITi9/cgz21ispgs268J2XRtsX3FYNWoxKVW5t1o++hg
	11F5kRO5QAPCQtkr6CEzIUMeAn08uNU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-awgJ0hqdPFaZpPvP2PEscQ-1; Tue, 09 Jun 2026 10:51:02 -0400
X-MC-Unique: awgJ0hqdPFaZpPvP2PEscQ-1
X-Mimecast-MFC-AGG-ID: awgJ0hqdPFaZpPvP2PEscQ_1781016661
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4601c9b630fso2308229f8f.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 07:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781016661; x=1781621461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LzesbWGj4YTo1y0et+ljf+77fl9oQ9V4yKu6m9JZpcY=;
        b=i+s4/No9MyoM/EZB/qJXtAkVNCYwnw7q9DHUHvBortGasB9V3tQ2RgpBL2eD8JUMhf
         WRb+hQkD4EiCCg+XONbjQtv8TyRUvqaEjh/z0RzMwahTeyqZyxxCrFIGuuMIB+IlmQ7a
         lW6k+OYdYw4z+HZYomVldaQoBGqeeq2WLnZZU9U8TNyG6b87FzUmJwwCq6mQFSFG5vDJ
         mDgU0veHdKA+gUSP/IyZ5qZ4Frrum3e3O0dpX0d22sP4UnYRNU5Yz0i22J8Yp3XPq7js
         oM5QYt6/h/x/o2jCx4tYmvymsjVmZKMmcBaUnzOh1BRSF5No2kBQh0gnfrJyEiLXrENA
         bA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016661; x=1781621461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzesbWGj4YTo1y0et+ljf+77fl9oQ9V4yKu6m9JZpcY=;
        b=FukZ7LkbEY9f9O1BZTkivoEGFnbmQ4K2f8OSGXNwJR/LYikA2hq+G11BYax9zlZAwz
         T3GhsjDKEMCrFVWpzldSv9Z2bgor0tm04ryHXSn8LbbNwRYa9QDfkBckeEVpD9BEH1/A
         qwTvOIqxAH7eKWzubx2rrMtqjm0ExH8HABNn+WllOoEZbtBN22lXJA0kEEZnBgZqWQHB
         f2DzQuJ7c+aAIieGbAGu77mKaXnNsme/nZU9OzQzUoE3lWnyfeRDLs81eX4IKMBiSWqs
         ZAHwLvZf0KBW264PylkiFyT8NfKkoPjrf++OlmbGlzU2cmA7K0UZGThTlKDwixVmv8G1
         SO1w==
X-Gm-Message-State: AOJu0YyGHlR0/sgDY/74zsQeYKHrPaniHEXGQtootWCPEVViGfdngS8g
	3bwzQvi43wwy33JcwTKejVTre8jK3MXIrNfiKd3udO2/mUfxlKgRk6LWJJUUutIo0Xy5yBoU/+Y
	bO9hYjFdc/DsyqiU6QQo4rDNGStWcO0GD21AofUJpQgzEsx1RBF/wEFNdrQ==
X-Gm-Gg: Acq92OGtuir4e4TsekMzRXaNJUyqKXM0HwngbeAxbsKodCEdCbIwU22LQ+LZiB++o60
	gnEYmaxorg7kXaxsnkByILPkz3isSyi25RkhBuWKk4qVZ+KD7hjB2QKsmeEoYXvlbZSLnNQyxzJ
	6wa/jU5q4R0bRiFvG2BPuhvrCHv29DPRlK8w0y+zpqt2NiNayf70jbKw8sE3+r5Tgvl7IyXtFP+
	Q34OqrfMfgcqUFRNg5VeBnrnGk63Rtck+CULfBMiYmBUDtgaowX+/Ao+yM1Asa3JQWHul5KEkTM
	DrTjWedwwcrVjLtw/Y+F2bGRs35PooQcdNxi1ZaOquPhnvlXzDJZvnTj9bq9zcUVO0s8R+LhHYZ
	h534wDF6nhfkykwFbWrokX0Rwmx2DdLMfYO9Bg9VDQJWaWTrnwUV2tA==
X-Received: by 2002:adf:e608:0:b0:44a:2cb3:b633 with SMTP id ffacd0b85a97d-460304fae53mr23680407f8f.12.1781016660809;
        Tue, 09 Jun 2026 07:51:00 -0700 (PDT)
X-Received: by 2002:adf:e608:0:b0:44a:2cb3:b633 with SMTP id ffacd0b85a97d-460304fae53mr23680357f8f.12.1781016660290;
        Tue, 09 Jun 2026 07:51:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35133csm60643986f8f.25.2026.06.09.07.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:50:59 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:50:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] virtio_net: do not allow tunnel csum offload for non
 GSO packets
Message-ID: <20260609105050-mutt-send-email-mst@kernel.org>
References: <38d33d63ce5d1aee486bd6c7c47345040d526e35.1781016169.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38d33d63ce5d1aee486bd6c7c47345040d526e35.1781016169.git.pabeni@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297091-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:virtualization@lists.linux.dev,m:willemb@google.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[mst.redhat.com:query timed out];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proxmox.com:url,proxmox.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D995661748

On Tue, Jun 09, 2026 at 04:44:26PM +0200, Paolo Abeni wrote:
> Fiona reports broken connectivity for virtio net setup using UDP tunnel
> inside the guest and NIC with not UDP tunnel TSO support in the host.
> 
> Currently the virtio_net driver exposes csum offload for UDP-tunneled,
> TCP non GSO packets. Such packet reach the host as CSUM_PARTIAL ones
> with the 'encapsulation' flag cleared, as the virtio specification do
> not support this specific kind of offload.
> 
> HW NICs with UDP tunnel TSO support - and those drivers directly
> accessing skb->csum_start/csum_offset - are still capable of computing
> the needed csum correctly, but otherwise the packets reach the wire with
> bad csum on both the inner and outer transport header.
> 
> Address the issue explicitly disabling csum offload for UDP tunneled,
> non GSO packets via the ndo_features_check op.
> 
> Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> Reported-by: Fiona Ebner <f.ebner@proxmox.com>
> Closes: https://bugzilla.proxmox.com/show_bug.cgi?id=7627
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
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
> +		return features & ~NETIF_F_CSUM_MASK;
> +
> +	/* Passthru. */
> +	return features;
> +}
> +
>  static const struct net_device_ops virtnet_netdev = {
>  	.ndo_open            = virtnet_open,
>  	.ndo_stop   	     = virtnet_close,
> @@ -6235,7 +6247,7 @@ static const struct net_device_ops virtnet_netdev = {
>  	.ndo_bpf		= virtnet_xdp,
>  	.ndo_xdp_xmit		= virtnet_xdp_xmit,
>  	.ndo_xsk_wakeup         = virtnet_xsk_wakeup,
> -	.ndo_features_check	= passthru_features_check,
> +	.ndo_features_check	= virtnet_features_check,
>  	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
>  	.ndo_set_features	= virtnet_set_features,
>  	.ndo_tx_timeout		= virtnet_tx_timeout,
> -- 
> 2.54.0


