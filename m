Return-Path: <netdev+bounces-238914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A19C610C2
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 07:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B8554E36EA
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 06:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C120239E63;
	Sun, 16 Nov 2025 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgHvFnpK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIfugPI5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5329E1DC997
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763274743; cv=none; b=EYJZNIRWw87WMOkjyEZUu0ARrEgaMGUrdxHyU/iuFCc5WDNiI0caJqxLsH2AbzMQpwwns6lTyTn9wbUSAAYaeynAwYAxtLtCcUGzbu2LD5ZLr50cF521mkis1Nm7vON5ZOm66IhjxIESsLFCst9hLuejPEZCT2dqJBHTD/AdoVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763274743; c=relaxed/simple;
	bh=9J5ZanlTR5MbI7H/PM8zBqnWF1m30dsYYnGd+HHXpsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gisvg0dygKB0q50NxI62hivlaTdrXypAIxKKhtPV/GXzTa02316rUE1uoitUApQeucXkVGYn9peyJz1/fowgYtWL4yd9aJB00fpKV1utmeB3rgEh1ij+yzaeubvJAGR13A23wT+/VNiMVdhALuTJN4Au/z1u6D74I2R6ovE0/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgHvFnpK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIfugPI5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763274740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONdbfWw8hd11o6VVpJ9FO1hpF1iyjC0aAQGdHwbR22w=;
	b=AgHvFnpKc9rsH1qRlT31M742zF90yt97OM4gqgZXJC+kpcELz+ITktCIO472MGPsTCB907
	ZFYNjDD5nkGFXBwdCT0HSVYXLF5bxumO2jXG/btyR63zDr4zkD8ERRm4o3Y61OihYoWjGN
	QlocHT4e2/p2Qz+k/Oe8Hpfp03VRFO4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-13c0Elw4PX2nxADcF3BC_Q-1; Sun, 16 Nov 2025 01:32:18 -0500
X-MC-Unique: 13c0Elw4PX2nxADcF3BC_Q-1
X-Mimecast-MFC-AGG-ID: 13c0Elw4PX2nxADcF3BC_Q_1763274737
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4775d110fabso25902365e9.1
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 22:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763274737; x=1763879537; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ONdbfWw8hd11o6VVpJ9FO1hpF1iyjC0aAQGdHwbR22w=;
        b=WIfugPI54hoYAZIZc4HXbxYa69ttBV4QlHE2OzA1WOLLlUoy9bTE4PcxOsG4SnPlnb
         AN0oxU8yfBmlTsWp964m6rHCTAgkjI4S9pcoSmY0vX6fO+gadnNA3B4D2jVBAfkvzDTR
         IR7Wc4nAKpTDr+bOZBOxmy9PHRt0W4jmgBXmPSUINgH93S8XtSmBY6ZhYuw6sSMcQHJP
         bgWv/FMrMb14Xj3oRD1Mmzz+n/GA/os0eMnlRxOckI5t8dUYIhdT58XVdWKyWumMAm7G
         2Nt7o++FimoaTrUKrMzudWAjb0WTbzUSWF/DJJUcihDg9FBxtxCLdpjSt3StTmiY5tcD
         aWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763274737; x=1763879537;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONdbfWw8hd11o6VVpJ9FO1hpF1iyjC0aAQGdHwbR22w=;
        b=iOSms/ICowG+jTTOFqGcTPi57AupATV7SN/ZztAqXvSO+a6xt4STCS9jto4gPreB5M
         yxrxt06HJhl+JcCRiyU8SSUov/qiqRkMX66YsY6oZL5FvznAmWfcIPaHhdr5Pv0cLLfC
         sUsPL5+fth9nxgCKLWDJJPrgDxnGncdayc4VUXOAJfAs3tcjk2/leuY6OLEJzlz6rAHY
         y0UAJSHtiMuuxTOggHOV35qNwADqRlA2DEVpjxVA91oBvkaK6TpcO4F50FuAnnqy1YRK
         KmHtfIpgaGmmrziUWQHVYuIkxSmf0u9cWzVBw3r261oRlPfi278E+bTTs3gt7P26Vkjg
         2+Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXetlsz+bIJAazvoBCo5ku3T+/DoWgLg2EOsk+HiXVghw6Ab2ybRDgKyvkZ4FNkdc9CjUoNgX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXT5cN+PWozazn4Z0vH9Op0U8k42ZyVj/PYGAw41XuWpE1WKJg
	91HkTopf0RYzMgDpft87FtPWe7rDd9Ocrc6C13VOmNgoedWGn2Pnwl58W37iwQ7ui1A9ffgA44e
	m08eohsxCvmKKxKWpzp2uL721u+dF5+xaQlfV5H6vcFcz+NBWaDxHoHrpWQ==
X-Gm-Gg: ASbGncsqzkrAIliZW8zJHZEhWMcBqh11NtY+2FEiqZRElBdbkdjvz2AEuXI4coFNXjh
	aSIjwLeq11hO8ocDFzjhykYkqIALI5sFdoUEbbYBssejLuiYrzACn9hl2zHmdQ3/B2MQczxJLTx
	+SUgyyUaasA80MbKfh6EHa/Fdd2qGr4Sf2ynsKivQMNl6egFRltpLZd4v3XpfTDxOqSsY9tqOUF
	NO2mO4uoD87Bqo2ltB4DKV36P1mp75rR973AVjVZvXoMLly1u8lZJHqGMqBLfxCfVXrcgsfLspP
	MDofofTFEptDA7BVbY/r8G9E3bUyt8ExGQB15TdAvzIR8wY5m2N6TDl4z5++gGZqGMAIEWU34GR
	7pGE3NuzF8E6TeO/pvco=
X-Received: by 2002:a05:600c:450f:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-4778fe4a05emr84091625e9.16.1763274737042;
        Sat, 15 Nov 2025 22:32:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeRI/yezHZxOP1x7mKLvN6v76+5MYb3nziZ0TDSQOyL2+hNz6X/UXawre7ClVnkphXS6dc2Q==
X-Received: by 2002:a05:600c:450f:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-4778fe4a05emr84091395e9.16.1763274736503;
        Sat, 15 Nov 2025 22:32:16 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e84a4fsm19190559f8f.11.2025.11.15.22.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 22:32:16 -0800 (PST)
Date: Sun, 16 Nov 2025 01:32:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user() and
 put_user()
Message-ID: <20251116013201-mutt-send-email-mst@kernel.org>
References: <20251113005529.2494066-1-jon@nutanix.com>
 <20251114185424.354133ae@pumpkin>
 <2CD22CA1-FAFA-493A-8F41-A5798C33D103@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2CD22CA1-FAFA-493A-8F41-A5798C33D103@nutanix.com>

On Fri, Nov 14, 2025 at 07:30:32PM +0000, Jon Kohler wrote:
> 
> 
> > On Nov 14, 2025, at 1:54 PM, David Laight <david.laight.linux@gmail.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Wed, 12 Nov 2025 17:55:28 -0700
> > Jon Kohler <jon@nutanix.com> wrote:
> > 
> >> vhost_get_user and vhost_put_user leverage __get_user and __put_user,
> >> respectively, which were both added in 2016 by commit 6b1e6cc7855b
> >> ("vhost: new device IOTLB API"). In a heavy UDP transmit workload on a
> >> vhost-net backed tap device, these functions showed up as ~11.6% of
> >> samples in a flamegraph of the underlying vhost worker thread.
> >> 
> >> Quoting Linus from [1]:
> >>    Anyway, every single __get_user() call I looked at looked like
> >>    historical garbage. [...] End result: I get the feeling that we
> >>    should just do a global search-and-replace of the __get_user/
> >>    __put_user users, replace them with plain get_user/put_user instead,
> >>    and then fix up any fallout (eg the coco code).
> >> 
> >> Switch to plain get_user/put_user in vhost, which results in a slight
> >> throughput speedup. get_user now about ~8.4% of samples in flamegraph.
> >> 
> >> Basic iperf3 test on a Intel 5416S CPU with Ubuntu 25.10 guest:
> >> TX: taskset -c 2 iperf3 -c <rx_ip> -t 60 -p 5200 -b 0 -u -i 5
> >> RX: taskset -c 2 iperf3 -s -p 5200 -D
> >> Before: 6.08 Gbits/sec
> >> After:  6.32 Gbits/sec
> >> 
> >> As to what drives the speedup, Sean's patch [2] explains:
> >> Use the normal, checked versions for get_user() and put_user() instead of
> >> the double-underscore versions that omit range checks, as the checked
> >> versions are actually measurably faster on modern CPUs (12%+ on Intel,
> >> 25%+ on AMD).
> > 
> > Is there an associated access_ok() that can also be removed?
> > 
> > David
> 
> Hey David - IIUC, the access_ok() for non-iotlb setups is done at
> initial setup time, not per event, see vhost_vring_set_addr and
> for the vhost net side see vhost_net_set_backend -> 
> vhost_vq_access_ok.
> 
> Will lean on MST/Jason to help sanity check my understanding.

Right.

> In the iotlb case, that’s handled differently (Jason can speak to
> that side), but I dont think there is something we’d remove there?


