Return-Path: <netdev+bounces-268164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Px9DzoGuGkWYQEAu9opvQ
	(envelope-from <netdev+bounces-268164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:31:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C243F29A6E8
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9334304A33E
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847BB1DF254;
	Mon, 16 Mar 2026 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hem16l5g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFUf3DH2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1068F17A30A
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667816; cv=none; b=MimfXEfWLK0CU0GU8EFaodIeY6fiQkEpdAKsCUr2to8U6EQgR+cdnPY3hW6HXNppJodPV13qtPY+eghKZU10h2ANhE+tpbTPTd+WU6YAKnM45fcMlvuMYl1PIGWMwR0JoAIOWkARZnB/vqMnorXBQgR0B5GAF1g/5vmVdt2s2BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667816; c=relaxed/simple;
	bh=QDNHRZmE38+feZWtHpvQ6ICZ4f0tHwvcrBjAtOmklMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+qBlHiTmU+5D3NqUma3A2LGKitfreiUTu73PvzSZQnlY9TawB/lT+Oq26AlmnFst2ZEvVN9oW7BjN0MUwB5SoZgZ3BSrFyPCM93kIFo2Xsitq3wOwkeiWOcek7Cmg3OYvDBhMAcW6yKeCgYrrLecNgUGm9rLGy0Q3Db4hXgyi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hem16l5g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gFUf3DH2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773667814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+w+/Jh+WDYnnRceoUho544RVsc8WCcn6+lrKA2JyEu0=;
	b=Hem16l5gTzq9zYAhgQ4G7/cUH7wagQ2QgTWDCIF0LgT/YbIQqBm2ZVMotsNjtfxXUbUzD/
	CNHeNxKUTaQiqk7BYG3VsVYz8fwwOoHQM+oAPjHBqt0+EFZwnoIHc5YLkaIae23rKoZI50
	Q/fYO5/V8HI8rAqGFawY0n9pjngPtqg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-1uP01aMpMzu3i8In0XA66Q-1; Mon, 16 Mar 2026 09:30:11 -0400
X-MC-Unique: 1uP01aMpMzu3i8In0XA66Q-1
X-Mimecast-MFC-AGG-ID: 1uP01aMpMzu3i8In0XA66Q_1773667810
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5a14d9e07d7so3997888e87.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 06:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773667810; x=1774272610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+w+/Jh+WDYnnRceoUho544RVsc8WCcn6+lrKA2JyEu0=;
        b=gFUf3DH2Bb9H0sZlqNUhGFl6RcqaZ7NzTPto3/ZdIM/YnPiL7GGWW7/3JnxnIIU8gx
         20vLOCeqS60nNlwhvpR4cn8uvuvvG33nrmrLsI0HT0YXV3Wx2vX02csOG4VJ3oISiXNa
         UpBTkZ5a0btQQfY82Bgtm+vs3BffFhM+OceFctqD4cIzSx7KQmUW94olhwr2/A2/cFSg
         Cms2RvPvBPCpxM31nh5I0CTCKHK+dg5zB/AnveGQg/GL7Zri9YglwHeJFtwrFKNrynY2
         We/8Tij16TFOSutfVo99B3KzpCDn2cV1oCepYJ9YVyJxIRuFt4HlDy5LZByy47ZukPra
         yXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667810; x=1774272610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+w+/Jh+WDYnnRceoUho544RVsc8WCcn6+lrKA2JyEu0=;
        b=PQy2NQN2BL/40R7H0LIbviYCKa9/7qPj5rylM7dM0veU1m8mwv4cdkiuYd5xnIAbRc
         PI3vD9vt39OLVy08+3IzV68rGB8QNrWZe8QJG1EEZ1CZoh5xarjm96xYKgTFWm6wTWrI
         g0Rzwg6cNkegdq2olu/62u8alNvR90wH1/wn8v/bWoMzOzjv8bLx13cdp5vhaTlb3v7k
         9J3Q0Sy197MBRrVvpGsewsjOFYJRAMgBgFOjeAzjOEhgESgNDGgYQzhMKVWA6bD31gxg
         WQb2LIwb9z2OhOxBioNGBNuw/f91OHT6b6HXh0se3/NE4kSlWNlWnkYGT49BZY6EcFlb
         oz3w==
X-Forwarded-Encrypted: i=1; AJvYcCVjgS+SmM1ClDTBS0vHGr9oBWkcE+HcVx0je3sj7oC0zL2Kx1e4pCEoxCJAYwKRnFd6/Lga9fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvWxtuMo4cjmYqqG5AITL85wOlVhSX2QnE8kEtSQ8EyBOz32aT
	zqr6DCnIzNCmHArFtmLCY144yUngn3DzUSU9WMjBoKGlrQS0VPF/umKWWhStsTEF+lNtfcNGpg8
	dzkMq0pfHhfkAFZ4dODZRIJVRhPECZiMWZm8SCzfnHiZ1K8uaWzbwE9hC7g==
X-Gm-Gg: ATEYQzxGxhQ1OvjuK7K1bBD1ZgbSXwVtx5x+1uVPFpJcuZ21tqD8JVA+iaXk8ofKX3h
	mBs8DfcmMpB83mPwlmrTu5wiyF6frZ6L3EOPjqeKH9uREokIb2SN8IMOzkNwx/XXM0xLUaEcrTr
	kuWnz8m89y14tI3S2ASJog6kImAM+6aoI2uCKm+VUGh5Rz3sKl0kNx3FFFQsTEdFpt2Z4te571W
	quxhvzCYcONDj7z6edxP2WDamWdiBbdOp1C2fq3ZdoS2gQkayu5WT5F3PF8DjKJ94xau4vV8xEN
	KkKZZNAU1+MqHBTVSmdoiUv/V3s7R8Cr44ibYLpI14pHasmwpLiqdhKVFwSBw4u3CZhWXdtSsoT
	F3Ml4r3IBxExFilr2P7t1GJ4exoWifruO/zVzBPeJXGgoyA==
X-Received: by 2002:a05:6512:1148:b0:5a1:4440:2c48 with SMTP id 2adb3069b0e04-5a162af145dmr4701588e87.12.1773667809866;
        Mon, 16 Mar 2026 06:30:09 -0700 (PDT)
X-Received: by 2002:a05:6512:1148:b0:5a1:4440:2c48 with SMTP id 2adb3069b0e04-5a162af145dmr4701557e87.12.1773667809250;
        Mon, 16 Mar 2026 06:30:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156162b82sm3488441e87.56.2026.03.16.06.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:30:08 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:30:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhud <zhud@hygon.cn>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"willemb@google.com" <willemb@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	Jing Li <lijing@hygon.cn>, Zhiwei Ying <yingzhiwei@hygon.cn>
Subject: Re: [PATCH net-next v2] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
Message-ID: <20260316092707-mutt-send-email-mst@kernel.org>
References: <20260316072152.910857-1-zhud@hygon.cn>
 <20260316051327-mutt-send-email-mst@kernel.org>
 <607818aba89a44d88afa213f39611451@hygon.cn>
 <20260316063139-mutt-send-email-mst@kernel.org>
 <a82cd6088e554fe1bb3daa6ad3df18dc@hygon.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a82cd6088e554fe1bb3daa6ad3df18dc@hygon.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-268164-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C243F29A6E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 12:57:00PM +0000, Zhud wrote:
> > On Mon, Mar 16, 2026 at 10:18:04AM +0000, Zhud wrote:
> > > > Thanks! Yes something to improve:
> > > >
> > > > On Mon, Mar 16, 2026 at 03:21:52PM +0800, Di Zhu wrote:
> > > > > Although VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is negotiated, which
> > > > > indicates the device supports dynamic control of guest offloads,
> > > > > it does not necessarily mean the device supports specific hardware GRO
> > features.
> > > > >
> > > > > If none of the features defined in GUEST_OFFLOAD_GRO_HW_MASK (such
> > > > > as TSO4, TSO6, or UFO) are present in vi->guest_offloads_capable,
> > > > > the device effectively lacks the hardware capability to perform GRO.
> > > >
> > > > So what is the user-visible problem this is trying to address?
> > >
> > > A key concern is that once a user enables NETIF_F_GRO_HW via ethtool,
> > > they might manually disable software GRO (ethtool -K eth0 gro off)
> > > assuming the hardware is now handling the aggregation.
> > 
> > Thanks!
> > Sorry could you be even more specific please?
> > Is this a theoretical concern or did some users encounter this?
> > Note that NETIF_F_GRO_HW is best effort anyway: e.g.
> > it can apply only to TCPv6 and v4 will still need software.
> 
> This might not be the best example, but I want to draw an analogy to show how
> this hardware offload capability can be misleading. For instance, if I enable GRO_HW
> expecting to see lower CPU usage when receiving packets, but it doesn't happen, that
> would be very confusing.

It still can happen if hardware does not offload the specific traffic,
yes?

> > > Secondly, while we haven't encountered a specific hardware failure
> > > yet, enabling a hardware offload feature that the DPU does not
> > > physically support introduces the risk of undefined hardware behavior
> > 
> > This would be a major concern but I don't get it - how would one trigger this?
> > It seems that guest_offloads_capable only includes offloads actually supported.
> 
> You're absolutely right. Upon rechecking the code, virtnet_set_features already ensures 
> that only bits within vi->guest_offloads_capable are sent to the device.
> Thank you for pointing that out.
> 
> > > > >
> > > > > So, making NETIF_F_GRO_HW conditional on these feature bits
> > > > > ensures the stack does not enable an unsupported hardware offload
> > configuration.
> > > >
> > > > I guess the assumption is that without this, something enables such
> > > > a config? Which stack is this and what happens then?
> > > >
> > >
> > > Sorry for the confusion, let me clarify the intent.
> > > The 'stack' here refers to the ethtool interface and the netset (ioctl/netlink) path.
> > 
> > 
> > A bit more detail about the specific set of commands that leads to confusion in the
> > commit log would be helpful.
> 
> > Thanks!
> > 
> > > >
> > > > > Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> > > > > Signed-off-by: Di Zhu <zhud@hygon.cn>
> > > >
> > > > judging by this, has something to do with LRO?
> > > >
> > > > > ---
> > > > > /* v2 */
> > > > >   -make the modified logic clearer
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 6 ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index
> > > > > 72d6a9c6a5a2..b233c99925e9 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -6781,8 +6781,6 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > >  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > > > >  	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > > > >  		dev->features |= NETIF_F_GRO_HW;
> > > > > -	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > > > > -		dev->hw_features |= NETIF_F_GRO_HW;
> > > > >
> > > > >  	dev->vlan_features = dev->features;
> > > > >  	dev->xdp_features = NETDEV_XDP_ACT_BASIC |
> > > > NETDEV_XDP_ACT_REDIRECT |
> > > > > @@ -7058,6 +7056,10 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > >  	}
> > > > >  	vi->guest_offloads_capable = vi->guest_offloads;
> > > > >
> > > > > +	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) &&
> > > > > +	    (vi->guest_offloads_capable & GUEST_OFFLOAD_GRO_HW_MASK))
> > > > > +		dev->hw_features |= NETIF_F_GRO_HW;
> > > > > +
> > > > >  	rtnl_unlock();
> > > > >
> > > > >  	err = virtnet_cpu_notif_add(vi);
> > > > > --
> > > > > 2.34.1
> > > > >
> > > >
> > >
> > 
> 


