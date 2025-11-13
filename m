Return-Path: <netdev+bounces-238427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F06C58C53
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A119504E9D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59142FA0DF;
	Thu, 13 Nov 2025 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqDjKf5a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rQlI2mdi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521482FA0C4
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049566; cv=none; b=LflVr17XXNbEfIgCD1QCZf6PbqJbPRZBBvFCVcsKhC7Mpnzx+JTam745ciuGBznPirX21sBqe8DBo6Qu0tJDSdz0PwssRI2eHRfXgrbT996SpjSZ8+zeuuEpICMIFYzblydEgW8Q8Ky6CUyLVSGwirf/lcf4lcKTgYemn5gGaEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049566; c=relaxed/simple;
	bh=3EmHzVlItT664raVKqR3ocJIvAjfrVhTn17yw4jaaDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdsDtt4F0Z/mQaDLKD07H0MxBHoPyUHLpyBql2Vqyb1+fuFZTQGElAy8MfL54FAFPQhGMrp0x9oj2hGvpQGjWKnSY2ibMDIJP1BcST785aMAfVc9Uto4YlGsTIkP/CQV6ZXAe8b7AsAaatWL5qPMc8rj/rVbuLyUmZM8/DCR81Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NqDjKf5a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rQlI2mdi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763049564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uxRT5z3+ifPoZ0211AWdMWgnKEBvwJ3HVrBmgq2vp/0=;
	b=NqDjKf5ar7c3kjH48HV3lW9yhW72yqX9gMR9hDbafz3nhzKc3uC8gpjSb+OvCyoH9K1N8i
	Jpr7AMLmh/o6POrCyV0GHxBCWbERRYrr99w6TQxRmJUm+u6cDoIsJL1eqUKvigh08Ft5bI
	QeBB+HfkiKTGNtKYEIXlyQlj+sujj4g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-a74UdXdaMWSg77UHpu-6Gg-1; Thu, 13 Nov 2025 10:59:22 -0500
X-MC-Unique: a74UdXdaMWSg77UHpu-6Gg-1
X-Mimecast-MFC-AGG-ID: a74UdXdaMWSg77UHpu-6Gg_1763049561
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477632ce314so6068075e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 07:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763049561; x=1763654361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uxRT5z3+ifPoZ0211AWdMWgnKEBvwJ3HVrBmgq2vp/0=;
        b=rQlI2mdiuyM3OR57kjnZU7Jtlmyn0i4rSy5yBVclOBB6JOREHXaQK4F0I4MOWYICoQ
         f0owVnafEhsvdaFFS9B5i2vvmNPBicKIQ7nABzxpiKket4e5oQ+j/8rGU/LYkI/9bH85
         4Zyq9FTVa7EhOQdmV4QXY/I9qk+tesuNtiBF6484Zv8wP1+7ApUKRxkml3LzTR/uudDy
         +/G45aRNzF5p0w8RMNYgVHRMWEGfj79ZyhUogmtmaqVZlzqrU7T7E81LL0+kK2BYPOiR
         XG1KSRuqi/4ZyszjEOdHaZbH/nzccXuskh9YYjLEZV006rEj2GlZUMVNCVfIEu5cyJOn
         MT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049561; x=1763654361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxRT5z3+ifPoZ0211AWdMWgnKEBvwJ3HVrBmgq2vp/0=;
        b=Y8W+8eGnzv/KT7hBmtsUTjs4eIHGTUWiQ24ttqI0SGvivQWN2hbOpRvaabSCl8g+lz
         ShKoy/qOSlbU8lr9zgZF6h2yP7SqAP3YDVkysrQ1M6j62KRoPq+kid0RxTxzFaZxkVAu
         owOhHKoxwuIMqF/WEnN9z72fVU3+6M4AbusJB8lSLLXOvH0DVflKkQ8VtxB48hHThi3j
         HG59uW+1otxCu7gCw17U/CTm3r8TTkiQb7hprvAGOqbIoWSoDn4dtCsQl01cYz7fQSCU
         pCfqP+WB1vYssbZh5bL4g02byV+w67ioLTltJLVNrS7pwt2PsQLK5bkrYuTPn/wgRWZb
         xYIw==
X-Forwarded-Encrypted: i=1; AJvYcCXyFNRxhcUV2UOm+DLpsJZOeK14C2otCuvGBm4bIwrbonnzDQmnwkWW7s3ZFGtIVEgOoBACZwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIwvQvjtawT0qp1KHnjQ32MR+eeH3TShXcPoFwe7trOsqCDnyY
	6w0uKF1eRQUOrP+o/+SvmsjmMBPg2iVNRE4wucXRIvfu6tnhRt5gaWIuV+CYGOe/vXZnI7jGDUF
	B/CBWgGp9lEqjSmkup2nkqrPsLMBgZG2zrJToJaDCdNbg+ZfaQ4zZ3BJsYQ==
X-Gm-Gg: ASbGncv4010M1KViSyQxYTNOsBbczJe1IdIl7uAfoyotIRPRromoVnXO2/E1J+Vbn5x
	8iEGpg8MgNY3JswhcrAGvv5++zt0G84kH6QCsplPP1H248dHg0FOcE1jVdf9Dn0oUutgCFNGyuK
	WeB/w33ZNXfOe+17xCx+XmFJhHJJ9xYk1fWEn+cATe0bpPcCBdnysxBWv9d+qJ0q1Hqc89JA3cy
	GmkNI93nVOv8gCSA/a69he3l9RIVfo+oQFUblUvxYHrQaXBOR2jWgScclalzKC0PKoD5C9HMVa5
	cgvfDA/vFfGbVS51eY2PjoTfYIUeqCbVz0ZJeGojpmYHXeI2TAImMycDyzpVRBNe9pEpc9tHAoA
	7oG2ms3ldiRlPcbzHCvc=
X-Received: by 2002:a05:600c:a44:b0:477:832c:86ae with SMTP id 5b1f17b1804b1-4778707ca20mr71013815e9.12.1763049561299;
        Thu, 13 Nov 2025 07:59:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHofPBYTP8F88iDpWUsKc8RAorynWUsDJxAs3/eKa1LXdZTVcuI1g6r5czDqfHcNjC7gedDcw==
X-Received: by 2002:a05:600c:a44:b0:477:832c:86ae with SMTP id 5b1f17b1804b1-4778707ca20mr71013415e9.12.1763049560788;
        Thu, 13 Nov 2025 07:59:20 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bb30e3asm24606075e9.1.2025.11.13.07.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 07:59:20 -0800 (PST)
Date: Thu, 13 Nov 2025 10:59:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	linux-um@lists.infradead.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net v5 1/2] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
Message-ID: <20251113105844-mutt-send-email-mst@kernel.org>
References: <20251111111212.102083-1-xuanzhuo@linux.alibaba.com>
 <20251111111212.102083-2-xuanzhuo@linux.alibaba.com>
 <25b05194-63cd-4265-8d2c-e174d801fc3a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25b05194-63cd-4265-8d2c-e174d801fc3a@redhat.com>

On Thu, Nov 13, 2025 at 03:39:35PM +0100, Paolo Abeni wrote:
> On 11/11/25 12:12 PM, Xuan Zhuo wrote:
> > The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > feature in virtio-net.
> > 
> > This feature requires virtio-net to set hdr_len to the actual header
> > length of the packet when transmitting, the number of
> > bytes from the start of the packet to the beginning of the
> > transport-layer payload.
> > 
> > However, in practice, hdr_len was being set using skb_headlen(skb),
> > which is clearly incorrect. This commit fixes that issue.
> > 
> > Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length guest feature")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> IMHO this looks like more a new feature - namely,
> VIRTIO_NET_F_GUEST_HDRLEN support - than a fix.


I mean if guest negotiates VIRTIO_NET_F_GUEST_HDRLEN but the header
length is wrong then yes it is broken and this is a fix.


> [...]
> > @@ -2361,7 +2362,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
> >  	if (vnet_hdr_sz &&
> >  	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
> >  				    sizeof(struct virtio_net_hdr),
> > -				    vio_le(), true, 0)) {
> > +				    vio_le(), true, false, 0)) {
> >  		if (po->tp_version == TPACKET_V3)
> >  			prb_clear_blk_fill_status(&po->rx_ring);
> >  		goto drop_n_account;
> To reduce the diffstat, what about creating a __virtio_net_hdr_from_skb()
> variant (please find a better name) allowing the extra `hdrlen_negotiated`
> argument, define virtio_net_hdr_from_skb() as a wrapper of such helper
> withthe extra arg == false, and use the helper in the few places that
> really could use hdrlen?


