Return-Path: <netdev+bounces-268180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFLFGRQauGn/YwEAu9opvQ
	(envelope-from <netdev+bounces-268180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:56:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC38129BD48
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A92F32B2953
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5912EB874;
	Mon, 16 Mar 2026 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaiEYL2c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SR2kWO+j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BFF2EC090
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672425; cv=none; b=ENlg6H4geA0SMgWB1e8vuYfgLV3d4dj+amDXrLIFCzpsT3T0bf7mWw+zcUeIXLgVQccFIVXnRqRKkXpVCBhgVb3yQVbjgdN3nXFkWinpuk6C7HVhDDVXOiC8LXesu0vs7BHunVhJ3zOrdUQmBaC6qj7H5dJQc+3GlzXBUoylsTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672425; c=relaxed/simple;
	bh=ZZfSolL28liTEnsaqqekR1GwI4GeyNvw1ffBWs0x/Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhUxk7aJjpQeBpzYrOIGwxJgR97rPWcohwct9HpRPwGG1FFeWoiuzKnoVFOUovUpIiAzr1ftuh3M8gqk4oNMWDwVZSCgTr5OCkL8SUN8k4ys71CJXl5fZGYTpqmGrVRDvwfImQ8QU2DesnDFyB46lnH5ckLYj07G2rdu6mcy5e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BaiEYL2c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SR2kWO+j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773672422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TKhHuHBXRJ+I0jn8wxM059uZWEF8kMlWUss6Y6JwesI=;
	b=BaiEYL2cpZ3K1N9k/nVH2bcS0Qvebuok/TPP3dYoFsAJkJ/g55FGA3PVAymjc3X+Vv8P4o
	cD+gwHBbE57Mb00sEIZU1HQWIt/ky3A6RrknM7B9D03j3yQ+IV9XaiDO/xvqaO8i25hDqn
	FECcRzPy1Gb9KxFnhVNUELLze3TStQM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-iaPjHggfPYmyUt_VvJhIVQ-1; Mon, 16 Mar 2026 10:47:01 -0400
X-MC-Unique: iaPjHggfPYmyUt_VvJhIVQ-1
X-Mimecast-MFC-AGG-ID: iaPjHggfPYmyUt_VvJhIVQ_1773672420
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b42cd4becso892347f8f.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773672420; x=1774277220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKhHuHBXRJ+I0jn8wxM059uZWEF8kMlWUss6Y6JwesI=;
        b=SR2kWO+jMgL85zef0bwB0X6Ka8jo+Q3PoUlwheL3DulTIhWWFXrq7kV3wGMpD3ehvD
         0D28yWrvN9tEx4bAR5LprmzjpR3nWY0TN97Q5RFHKjCDiqZ6XSovkTFSbAgd5bxUatOI
         NSqDRrgJQI8EFXSDpIP+euxXHLSiQPuWpNrqgkqAylcXCpFSly+0z7TlhIdPcj0j9IhI
         UuJOTe4uFkNND9v2pXdVBKOytXlmWRV76PqY6NpL1cDMiduskm4CMpqfuq64mS7FuuKq
         63Vgqh19vexsJFCnybeHblOJkC+voUfPSrQPubs8YrBycq2TsUF1etSUTqrLCitgnqMk
         XlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773672420; x=1774277220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKhHuHBXRJ+I0jn8wxM059uZWEF8kMlWUss6Y6JwesI=;
        b=Np73J76/kN/g/dO3cAmOsFizXY9PyFiDhcEwh7nw6Sw5NDA/AYvqOmKQJQ66MqU7io
         fCU2U0/YM3fvPSAKn+5Q4SmnBjKHcVW+R8YuwWD0XHBcWxaYnL+ZUd1zexR4TMAocgTd
         Yz43HFem30UdBWzyn+n3G4wdaohak0qLfU59EDp2ztj1ElDeKWsg0Vs2iqRyGTmq+P52
         1mn/w8du8fplub4pIPjneffHSkFC3DThgCA+t4Zw2M6q5YtHeay4yI96KeViZqntPdWp
         uYCllCXG9R0iqbHxyGf1eFgp2TNSOmg/Gh0x9hjdtmMNnYqismcnXWWW6wP1DEw6ej6t
         YP4g==
X-Forwarded-Encrypted: i=1; AJvYcCWu6Ngm0TWBlDgVVRN3WFGobAEEHHZb72N10nMMpTeWEniryvxS6X3HYqnBdmBXtvkJed6EUP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy68VLi/b6KR4XOPqjLqlm0v8gmKXxDWW9J1TBgoibxhRSV1QD+
	clGN1W/o0TQzTXa8Am2eeRt0wxQQjVFMs7ENC/Cmx7c20X1JzBWcUp6qL8AwVWvufrp5lPMnB4U
	rg3YyTT+x6StkjBAz/5ebp11WP9NOaw4pCIHNg3QiGsYDpkLdD0LYhqNB0g==
X-Gm-Gg: ATEYQzwNC+AAxMbwy4cB1aaEFjU8S+SKB/9cjht1KlTDSzGTECN38nwnOUGH6aCHcdZ
	q/CpbsiAj5eszIwM1evVlZw2dL1b2xAMHjQl4RitBiXsxpSSncV8/Qh93ckGZNo5h+X6W0ikoCh
	Jqztfz9k5VOXQizmJ/p0MXK5I/NgN7yBsnMDYDdNueMWFyBMWvmnfoJ+vzNsz9Pbyshs1I9Ax8M
	KKQqGazUWualqpycKGFUsdQ5s5qBncHdd/gmQVRuieBD5yw/bl8bKcEAj8xxpYwlST5xYABkUFr
	1eEJKeH6GG0VuI7XnXX5kkqX7g+k4i8nggUKCTjUA6Vvg8cg6n42W0W4OZxRzQVnCQQrtFLhdJP
	gXMMRSd/Qsl0VvzTRkPD7M4AvX7ibPjvMlb5BYvRoyC07oA==
X-Received: by 2002:a05:6000:420c:b0:439:9812:35ea with SMTP id ffacd0b85a97d-439fdf347efmr31647537f8f.3.1773672420167;
        Mon, 16 Mar 2026 07:47:00 -0700 (PDT)
X-Received: by 2002:a05:6000:420c:b0:439:9812:35ea with SMTP id ffacd0b85a97d-439fdf347efmr31647475f8f.3.1773672419567;
        Mon, 16 Mar 2026 07:46:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b41dd93c0sm10828039f8f.10.2026.03.16.07.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 07:46:58 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:46:55 -0400
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
Message-ID: <20260316095919-mutt-send-email-mst@kernel.org>
References: <20260316072152.910857-1-zhud@hygon.cn>
 <20260316051327-mutt-send-email-mst@kernel.org>
 <607818aba89a44d88afa213f39611451@hygon.cn>
 <20260316063139-mutt-send-email-mst@kernel.org>
 <a82cd6088e554fe1bb3daa6ad3df18dc@hygon.cn>
 <20260316092707-mutt-send-email-mst@kernel.org>
 <4e3ce2d6120545719a286d3daafbef38@hygon.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e3ce2d6120545719a286d3daafbef38@hygon.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268180-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hygon.cn:email]
X-Rspamd-Queue-Id: DC38129BD48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 01:57:22PM +0000, Zhud wrote:
>  > On Mon, Mar 16, 2026 at 12:57:00PM +0000, Zhud wrote:
> > > > On Mon, Mar 16, 2026 at 10:18:04AM +0000, Zhud wrote:
> > > > > > Thanks! Yes something to improve:
> > > > > >
> > > > > > On Mon, Mar 16, 2026 at 03:21:52PM +0800, Di Zhu wrote:
> > > > > > > Although VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is negotiated, which
> > > > > > > indicates the device supports dynamic control of guest
> > > > > > > offloads, it does not necessarily mean the device supports
> > > > > > > specific hardware GRO
> > > > features.
> > > > > > >
> > > > > > > If none of the features defined in GUEST_OFFLOAD_GRO_HW_MASK
> > > > > > > (such as TSO4, TSO6, or UFO) are present in
> > > > > > > vi->guest_offloads_capable, the device effectively lacks the hardware
> > capability to perform GRO.
> > > > > >
> > > > > > So what is the user-visible problem this is trying to address?
> > > > >
> > > > > A key concern is that once a user enables NETIF_F_GRO_HW via
> > > > > ethtool, they might manually disable software GRO (ethtool -K eth0
> > > > > gro off) assuming the hardware is now handling the aggregation.
> > > >
> > > > Thanks!
> > > > Sorry could you be even more specific please?
> > > > Is this a theoretical concern or did some users encounter this?
> > > > Note that NETIF_F_GRO_HW is best effort anyway: e.g.
> > > > it can apply only to TCPv6 and v4 will still need software.
> > >
> > > This might not be the best example, but I want to draw an analogy to
> > > show how this hardware offload capability can be misleading. For
> > > instance, if I enable GRO_HW expecting to see lower CPU usage when
> > > receiving packets, but it doesn't happen, that would be very confusing.
> > 
> > It still can happen if hardware does not offload the specific traffic, yes?
> 
> Yes, of course, but there's still a difference between "best-effort" and "no-effort." Right?

I am not saying this does not improve the user experience.
But let us set the expectations correctly.

What this does (I think):

	When a virtio device does not have either GUEST_TSO6 or
	GUEST_TSO4 offloads, this means it can't really do
	hardware GRO.

	however, the driver will set NETIF_F_GRO_HW whenever
	the device allows control over offload support - even
	if the offloads that can be controlled have nothing
	to do with GRO.

	As a result, in such a setup, rx-gro-hw reported for the device
	is too optimistic.  Improve the situation by masking off
	NETIF_F_GRO_HW.


	Out of abundance of caution, this does not change the
	current behaviour for hardware with just v6 or just v4 GRO:
	current interfaces do not allow
	distinguishing between v6/v4 GRO, so we can't expose
	them to userspace precisely.

Also:
> Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")

are you sure it's right?


> > 
> > > > > Secondly, while we haven't encountered a specific hardware failure
> > > > > yet, enabling a hardware offload feature that the DPU does not
> > > > > physically support introduces the risk of undefined hardware
> > > > > behavior
> > > >
> > > > This would be a major concern but I don't get it - how would one trigger this?
> > > > It seems that guest_offloads_capable only includes offloads actually supported.
> > >
> > > You're absolutely right. Upon rechecking the code,
> > > virtnet_set_features already ensures that only bits within
> > vi->guest_offloads_capable are sent to the device.
> > > Thank you for pointing that out.
> > >
> > > > > > >
> > > > > > > So, making NETIF_F_GRO_HW conditional on these feature bits
> > > > > > > ensures the stack does not enable an unsupported hardware
> > > > > > > offload
> > > > configuration.
> > > > > >
> > > > > > I guess the assumption is that without this, something enables
> > > > > > such a config? Which stack is this and what happens then?
> > > > > >
> > > > >
> > > > > Sorry for the confusion, let me clarify the intent.
> > > > > The 'stack' here refers to the ethtool interface and the netset (ioctl/netlink)
> > path.
> > > >
> > > >
> > > > A bit more detail about the specific set of commands that leads to
> > > > confusion in the commit log would be helpful.
> > >
> > > > Thanks!
> > > >
> > > > > >
> > > > > > > Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> > > > > > > Signed-off-by: Di Zhu <zhud@hygon.cn>
> > > > > >
> > > > > > judging by this, has something to do with LRO?
> > > > > >
> > > > > > > ---
> > > > > > > /* v2 */
> > > > > > >   -make the modified logic clearer
> > > > > > > ---
> > > > > > >  drivers/net/virtio_net.c | 6 ++++--
> > > > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/virtio_net.c
> > > > > > > b/drivers/net/virtio_net.c index
> > > > > > > 72d6a9c6a5a2..b233c99925e9 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -6781,8 +6781,6 @@ static int virtnet_probe(struct virtio_device
> > *vdev)
> > > > > > >  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > > > > > >  	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > > > > > >  		dev->features |= NETIF_F_GRO_HW;
> > > > > > > -	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > > > > > > -		dev->hw_features |= NETIF_F_GRO_HW;
> > > > > > >
> > > > > > >  	dev->vlan_features = dev->features;
> > > > > > >  	dev->xdp_features = NETDEV_XDP_ACT_BASIC |
> > > > > > NETDEV_XDP_ACT_REDIRECT |
> > > > > > > @@ -7058,6 +7056,10 @@ static int virtnet_probe(struct virtio_device
> > *vdev)
> > > > > > >  	}
> > > > > > >  	vi->guest_offloads_capable = vi->guest_offloads;
> > > > > > >
> > > > > > > +	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)
> > &&
> > > > > > > +	    (vi->guest_offloads_capable &
> > GUEST_OFFLOAD_GRO_HW_MASK))
> > > > > > > +		dev->hw_features |= NETIF_F_GRO_HW;
> > > > > > > +
> > > > > > >  	rtnl_unlock();
> > > > > > >
> > > > > > >  	err = virtnet_cpu_notif_add(vi);
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> > 
> 


