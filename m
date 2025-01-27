Return-Path: <netdev+bounces-161205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D84BA20041
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 23:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0123A1287
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 22:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F971DA63D;
	Mon, 27 Jan 2025 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LCL9AhAF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B19319F489
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738015680; cv=none; b=HcB/JR8vicHGi+rqVX6DHaVYcCFHW5hP7gFHsgUIrGLJ1grOAGsyYNCgJXU1h0sagF0WEJ4Qn77UQD9dBQ6JMfBoUlXyMROvXkDRzsyqfuYYWvXcN0ZDH3c/GhxNo+GiGlpv92MdVUAwGz4HUZXOcZE+SoTU/QSvVt89qHNEK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738015680; c=relaxed/simple;
	bh=OjW398BTWizDSrwZF2nXzwsTgBr9BNV0I55QSA9En5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bn7WrUm7NX9WGx3feFvJYExOFpTBQXb5dODF4KtxakNTqmpYenXb687/mc0d2HP57foLI/dm0NoI/V37sBfrZLp0hropvKBsg4wKiVoiFr9jNZ5Y62+O4AX7C73MW3YkVdseGxr7VGDd54myJ+1QLd6nHtjABOoN6frK7w0wugQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LCL9AhAF; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6f53c12adso457306185a.1
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 14:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738015677; x=1738620477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aP5GnQgJZ2/sm68pEmuVw5VQauWjnaDO1BrGzC8Sagk=;
        b=LCL9AhAFsloa+qNg9rnR6FJZDTXg+hXWPbsnjmvHGLDfyjG1c0uRVeDm4bWAJOgDGg
         XjUqGexonrMHyHbuvxsVOiA7pzprCea3oMcivERxROFGNC5Y1TG/yVNvz5UiPIZxHQud
         oH6wB20ZZQsPMmriJmazahR6r6bV10ptVfN7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738015677; x=1738620477;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aP5GnQgJZ2/sm68pEmuVw5VQauWjnaDO1BrGzC8Sagk=;
        b=vJbL2XLl7hOl/6784HkHmlgV2bDVItKr7/QE0ZWyQ3GaFUoYyKRW424RBoxCSOm5nr
         YklzLqnKEL8CxPEalL6p874idoxyYVbzAmvwZjF/SaG9AwZUMtLYQbZ6CqNPExPbK48h
         9n3j1hfSoi3MBW8ety7g5fjhuvDuDx8fULLYib8NqndsBLOZZputWglhQBgfYOENcUkL
         Jl+bvZO5VLwAnQv5VhAcytLAdUoWzP+FTCwANnvMdCzv2KFzC++/dMwwD6Z0w5hSW8j6
         cZbeaAdd/alg7c0UcYbjKBiWU0OqxnWXcE/D+eOZqEPTDpDNAWyCTN/TCUgz84rWiLJn
         6Jgw==
X-Forwarded-Encrypted: i=1; AJvYcCUv+tk/FkzP25yatlAVB544utUWiGFvcTqTO2zlFJnUhsAYTembPHBqUA1TXKpHtU5+1EjE3Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0gHp6+b6hIVSYdw6z50L0DE1pu05NXH6v90xKXqLoy1eP4BVj
	wBBO+rIVysgBJ0LagSSTPt1Q2jpdXMFCZosXY9mP9Xoj/qNoYnIDf1XgfKNHIX56C6FMLv2GQZG
	P
X-Gm-Gg: ASbGncssRbK8HDd6LC7AwCbu6rt5df0g54ilkccNzN8fLolE19Wd2etfqaeZAmcDRC8
	Xx5AAZPB7fPIBWtSfNdLebwW2x17mwxkSwasF8VsBkdUwr6m64qCj0APHBeQoNc+E/i61c+PTy/
	kagzhS6EYgYejSxi+2fprwoeDLMxYg0HJ0PLGHWya9QwMXrM8e4TUtU7y3q0qXgS31OBrupGdEc
	ocJXeYV7KXUM/RTdjRmMDYhZiLBvAGvVqE01oEbVvjkV5EJQEDdBw7ULLdtvHRcokRGkov6QqGp
	8U59rbaRwbCKayqQh0vNOi039Y7iDZvqeSL5Z2x1Nqc=
X-Google-Smtp-Source: AGHT+IGTdVygXNueO3vCZK4btjxRGHvCS781WeHwgFOuP3bnDqU55mAl0oUxDT4tkYkUoR9+a4Hv8A==
X-Received: by 2002:a05:620a:2490:b0:7b6:e9be:97dc with SMTP id af79cd13be357-7be6320be81mr7301033485a.8.1738015677499;
        Mon, 27 Jan 2025 14:07:57 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae8aaf1sm434734685a.40.2025.01.27.14.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 14:07:56 -0800 (PST)
Date: Mon, 27 Jan 2025 17:07:54 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	gerhard@engleder-embedded.com, leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com, mkarsten@uwaterloo.ca,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v3 2/4] virtio_net: Prepare for NAPI to queue
 mapping
Message-ID: <Z5gDut3Tuzd1npPe@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, gerhard@engleder-embedded.com,
	leiyang@redhat.com, xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <CACGkMEvT=J4XrkGtPeiE+8fwLsMP_B-xebnocJV8c5_qQtCOTA@mail.gmail.com>
 <Z5EtqRrc_FAHbODM@LQ3V64L9R2>
 <CACGkMEu6XHx-1ST9GNYs8UnAZpSJhvkSYqa+AE8FKiwKO1=zXQ@mail.gmail.com>
 <Z5Gtve0NoZwPNP4A@LQ3V64L9R2>
 <CACGkMEvHVxZcp2efz5EEW96szHBeU0yAfkLy7qSQnVZmxm4GLQ@mail.gmail.com>
 <Z5P10c-gbVmXZne2@LQ3V64L9R2>
 <CACGkMEv4bamNB0KGeZqzuJRazTtwHOEvH2rHamqRr1s90FQ2Vg@mail.gmail.com>
 <Z5fHxutzfsNMoLxS@LQ3V64L9R2>
 <Z5ffCVsbasJKnW6Q@LQ3V64L9R2>
 <20250127133304.7898e4c2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127133304.7898e4c2@kernel.org>

On Mon, Jan 27, 2025 at 01:33:04PM -0800, Jakub Kicinski wrote:
> On Mon, 27 Jan 2025 14:31:21 -0500 Joe Damato wrote:
> > Actually, I missed a patch Jakub submit to net [1], which prevents
> > dumping TX-only NAPIs.
> 
> That patch only addresses NAPI ops, here I think we're talking about
> attributes of the queue object.

Yea, that's true.

> > So, I think this RFC as-is (only calling netif_queue_set_napi
> > for RX NAPIs) should be fine without changes.
> 
> Weak preference towards making netdev_nl_queue_fill_one() "do the right
> thing" when NAPI does not have ID assigned. And right thing IMO would
> be to skip reporting the NAPI_ID attribute.

Ah, right. Your patch was for netdev_nl_napi_fill_one, so presumably
a similar patch would need to be written for
netdev_nl_queue_fill_one.

> Tx NAPIs are one aspect, whether they have ID or not we may want direct
> access to the struct somewhere in the core, via txq, at some point, and
> then people may forget the linking has an unintended effect of also
> changing the netlink attrs. The other aspect is that driver may link
> queue to a Rx NAPI instance before napi_enable(), so before ID is
> assigned. Again, we don't want to report ID of 0 in that case.

I'm sorry I'm not sure I'm following what you are saying here; I
think there might be separate threads concurrently and I'm probably
just confused :)

I think you are saying that netdev_nl_napi_fill_one should not
report 0, which I think is fine but probably a separate patch?

I think, but am not sure, that Jason was asking for guidance on
TX-only NAPIs and linking them with calls to netif_queue_set_napi.
It seems that Jason may be suggesting that the driver shouldn't have
to know that TX-only NAPIs have a NAPI ID of 0 and thus should call
netif_queue_set_napi for all NAPIs and not have to deal think about
TX-only NAPIs at all.

From you've written, Jakub, I think you are suggesting you agree
with that, but with the caveat that netdev_nl_napi_fill_one should
not report 0.

Then, one day in the future, if TX-only NAPIs get an ID they will
magically start to show up.

Is that right?

If so, I'll re-spin the RFC to call netif_queue_set_napi for all
NAPIs in virtio_net, including TX-only NAPIs and see about including
a patch to tweak netdev_nl_napi_fill_one, if necessary.

