Return-Path: <netdev+bounces-268112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOS7Herft2mcWAEAu9opvQ
	(envelope-from <netdev+bounces-268112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:48:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 309AC29834C
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4AD4E3002B5D
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C7D38F62A;
	Mon, 16 Mar 2026 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGRhmHK/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ptMh1i5P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392AA38D6A9
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658083; cv=none; b=NZ6fMmKjR7u71YsNYrc6mk9pmaD2eVeGLb1GrXMHicYYHjgMqs2fVf56w/hbrUs2cUn4iBYYWqJbOxqkJYzuIt2NiEXsZB7AgU+dNoXtz+a47SHmF/mD9vd6vrR+08hfEjiXi1s/0LvdQgC1aFJCkBAyXDDiILg5V7Ivn2dg3TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658083; c=relaxed/simple;
	bh=1QFgAt6v5G8ZF6zVoJAv0kj7kMi7gvlUjuhjHhXigUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i18zZuGmC/DuKIw6StzFjClPb0TFYwTe/k338UCbc/IHmmMfqR3yXDheLNGzVHmvSmlx5RYneAK7IqYOh/yGvlXNzwFD9/lwAZnUVhALNsPNnC5/JEq9yEo8HP2AX7e8zOX+8ljRAHyPhRQUsp5LKWLsYnJqRcNIhldBq9Dteb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGRhmHK/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ptMh1i5P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773658081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BfYGvWXFyEp3tl8sYK4EkCi7nOSDVzMxt5VwgIY+JXA=;
	b=UGRhmHK/IuvGb2g2bMUsy9/e7eiL50CLcPxClCLx2AyyTgXnk0A0mvjMpV6qH/n0S3/DXk
	ogn0N7SzQrV2SKVBs3GBU3NB1Fi5OM/K90Y8VqPu5AhofMYRyZQCrZjHuSVdAszFS9wz5Q
	gPAEuuTOhrPtzI3qI9JvPRUOBY0P5gI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-QH-Tf6TfMey2Q6KsZznIqA-1; Mon, 16 Mar 2026 06:47:59 -0400
X-MC-Unique: QH-Tf6TfMey2Q6KsZznIqA-1
X-Mimecast-MFC-AGG-ID: QH-Tf6TfMey2Q6KsZznIqA_1773658079
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48541cac34dso41696505e9.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 03:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773658078; x=1774262878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BfYGvWXFyEp3tl8sYK4EkCi7nOSDVzMxt5VwgIY+JXA=;
        b=ptMh1i5P2tbchnYhOvY5pVcd/UtNdP4iQsVxkzuPFhEg0JFtIChciqhbIle0TihC/t
         7JHmpCjYU2apUBX/Lu2h+jF5zSHrm1s+yNWbrgyXxLNjlfUu3PRUYFQtwnZpfkG3qWz4
         dAFQF2dTUM0WZhyzoovsy/4a094OMKXkfgEZKzUphOhzHxqp/tHoeFdPolbS8ROvxyCO
         ++y2eS7EPqEj23pYtx/1OTOLBR0Xn52OuEf76CNBUdk5kk5FGHNvYdBn27hYcO6GkxEi
         0SAVEF/KyxAgrjf8QNmY1J5fMThNPZDYsM0w7kpryDmdYvMquLnUMm9dftdaxT1fWIMM
         G2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658078; x=1774262878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfYGvWXFyEp3tl8sYK4EkCi7nOSDVzMxt5VwgIY+JXA=;
        b=JxiVIcHIFWevxLb7icSLKHVLH5VOdUyXsEOMgLQ05MVPIVuRfCt5Y9v/nDS05WaHL2
         JhX2Cbi3gqCEDbCWaRZnpWQHyI04+bmCIXy896/ynzVn/qXS+hxgunj9n2t8wfEkldU4
         6owRyZpCuhyAKYXRQFQ3BihPuVlraDI3iDG81PaiEvAyIfrynWJ38Vr89utxEjxGZjOU
         MnPpTJ3l5VcVVSHULT4wV3xsqTxVnHGli6/9Bpz5UvEntSLWD05aux+/jyjBiMgoDbe1
         lIoAhJBYSvoSBBe8vAycVkZYjUtv9O/kXt0pSobOyjYcpq34pONjaUsN3nGSw3CPY8J8
         stow==
X-Forwarded-Encrypted: i=1; AJvYcCVCG1xpjrpZdLMFJ0ZIaesynn5l+UD+ups8EVPj6SJBBG+IpAM7Vn2m1jCD9BugKOK5u0gQDAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4PETnR/AIuIIJJHUU1WWDlMNrgfa7wNQgGzs8EYmOk1L6t8U
	8J7z/VD8Tz0RaerCXgcxzI7Oc0GLdKOxBiCqDmmIxL7SnvQm3vmg8t07HYkzrcGIdmI9hzgZkps
	vIK8qfbTFJcQhpnYY6R5hgWqfIxh/zGp4OSv2Gup3FplrvKR05bVJ+hN7Swz0f2p94A==
X-Gm-Gg: ATEYQzxHjwkVyFpAOzSh1M1wlEFBBBhGeU1EDsTfoS+dyO899Z/owJNhuJKEWD7ycXi
	ZvG6M3eE9yc7QSTYuwHWxF5LCPqGtSY/rjd7q5Q285Hsr1mDflme/7UOO6cTMjK04wxF0OsKiPL
	mkqLrgNRr6lvzeEo7HSggDxKQpKcqyRGIRtz7BsTbFnEb/Njk+0NbIxyYhHPHg/cDqXQOR+7M++
	Zc+QbP63s9U7N/znkIBOaItZtwKYwa8EEdasGgH/VAcsduk9PwFo9EAKXn8GtPmyFIfeZmdpHSU
	joMVGTxFiPfB+ElUsXMrtKPYBJiXpGJ9H0FoH4m2CySJaI7rr98x6Sbu6iNg5SJ0voDTy9aQWhE
	gwXA1RwwRVFOkEu5xMX7Z6WpN685TM39hsE4HdsZ5HHnsAQ==
X-Received: by 2002:a05:600c:4f8f:b0:485:4371:539a with SMTP id 5b1f17b1804b1-4855670f7admr178896755e9.31.1773658078259;
        Mon, 16 Mar 2026 03:47:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4f8f:b0:485:4371:539a with SMTP id 5b1f17b1804b1-4855670f7admr178896555e9.31.1773658077775;
        Mon, 16 Mar 2026 03:47:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66ffe2sm383282095e9.13.2026.03.16.03.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 03:47:57 -0700 (PDT)
Date: Mon, 16 Mar 2026 06:47:54 -0400
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
Message-ID: <20260316063139-mutt-send-email-mst@kernel.org>
References: <20260316072152.910857-1-zhud@hygon.cn>
 <20260316051327-mutt-send-email-mst@kernel.org>
 <607818aba89a44d88afa213f39611451@hygon.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <607818aba89a44d88afa213f39611451@hygon.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268112-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hygon.cn:email]
X-Rspamd-Queue-Id: 309AC29834C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 10:18:04AM +0000, Zhud wrote:
> > Thanks! Yes something to improve:
> > 
> > On Mon, Mar 16, 2026 at 03:21:52PM +0800, Di Zhu wrote:
> > > Although VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is negotiated, which
> > > indicates the device supports dynamic control of guest offloads, it
> > > does not necessarily mean the device supports specific hardware GRO features.
> > >
> > > If none of the features defined in GUEST_OFFLOAD_GRO_HW_MASK (such as
> > > TSO4, TSO6, or UFO) are present in vi->guest_offloads_capable, the
> > > device effectively lacks the hardware capability to perform GRO.
> > 
> > So what is the user-visible problem this is trying to address?
> 
> A key concern is that once a user enables NETIF_F_GRO_HW via ethtool, 
> they might manually disable software GRO (ethtool -K eth0 gro off) assuming the 
> hardware is now handling the aggregation.

Thanks!
Sorry could you be even more specific please?
Is this a theoretical concern or did some users encounter this?
Note that NETIF_F_GRO_HW is best effort anyway: e.g.
it can apply only to TCPv6 and v4 will still need software.

> Secondly, while we haven't encountered a specific hardware failure yet, 
> enabling a hardware offload feature that the DPU does not physically support 
> introduces the risk of undefined hardware behavior

This would be a major concern but I don't get it - how would one trigger this?
It seems that guest_offloads_capable only includes offloads actually
supported.

> > >
> > > So, making NETIF_F_GRO_HW conditional on these feature bits ensures
> > > the stack does not enable an unsupported hardware offload configuration.
> > 
> > I guess the assumption is that without this, something enables such a config? Which
> > stack is this and what happens then?
> > 
> 
> Sorry for the confusion, let me clarify the intent.
> The 'stack' here refers to the ethtool interface and the netset (ioctl/netlink) path. 


A bit more detail about the specific set of commands that leads to
confusion in the commit log would be helpful.
Thanks!

> > 
> > > Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> > > Signed-off-by: Di Zhu <zhud@hygon.cn>
> > 
> > judging by this, has something to do with LRO?
> > 
> > > ---
> > > /* v2 */
> > >   -make the modified logic clearer
> > > ---
> > >  drivers/net/virtio_net.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> > > 72d6a9c6a5a2..b233c99925e9 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -6781,8 +6781,6 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > >  	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > >  		dev->features |= NETIF_F_GRO_HW;
> > > -	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > > -		dev->hw_features |= NETIF_F_GRO_HW;
> > >
> > >  	dev->vlan_features = dev->features;
> > >  	dev->xdp_features = NETDEV_XDP_ACT_BASIC |
> > NETDEV_XDP_ACT_REDIRECT |
> > > @@ -7058,6 +7056,10 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >  	}
> > >  	vi->guest_offloads_capable = vi->guest_offloads;
> > >
> > > +	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) &&
> > > +	    (vi->guest_offloads_capable & GUEST_OFFLOAD_GRO_HW_MASK))
> > > +		dev->hw_features |= NETIF_F_GRO_HW;
> > > +
> > >  	rtnl_unlock();
> > >
> > >  	err = virtnet_cpu_notif_add(vi);
> > > --
> > > 2.34.1
> > >
> > 
> 


