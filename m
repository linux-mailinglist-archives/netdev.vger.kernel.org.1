Return-Path: <netdev+bounces-202790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B3CAEF02C
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CC63E2445
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 07:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AF62620D3;
	Tue,  1 Jul 2025 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RS3a9aUY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ED326059F
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356369; cv=none; b=V2/RKEIRX7XttXufcrIkIUnDeRQ1CNI/i+kYIfEEg2fC1dVnEMr1w41KDcPm4lQjbjhm1viNodHHifxtHkDyQT3T/W3kGGoBCPnqKzKQuaMwnqOGt8ifPp9oxixucY25Sv64eELJtV809eT4TPXU7XLy9WCpMEzIILuW875NVgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356369; c=relaxed/simple;
	bh=iqtTO7BdgSOS0hugcE5p2vfRNGvtKPLOW4//tI8bFOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZELzmFzmQbkmfaFYDkH+VRj8mKQZfk3y2lxg24K6u6oMev7d32mPO2e+hbynq6N9g3gptevkdHI962tlc1juPppw4x6aWYAt3tAV+OswGut9sdgbZuHpeEEDvHYIM4L18A9Bsm2jaF1iJnoY3dG8Eg1JgKDxKezrYhVSdUcmVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RS3a9aUY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751356366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5W4qfJP5trIgKgYi+NpmwjcNUOZanDpnOGZEn8fp13E=;
	b=RS3a9aUYB+ijGanu5LQ3UWpdEQ9RpQfBIYeCSNYyoL5ji4Sk7pB5r/SvghNHo6o9e35BM9
	IZCT8j/bOBV4ir01Oj2sMlA97tCAqTKqaRvK3GQ6qi9QJ8dUO0lKBfz2XN8rk8vQ2EDXYU
	l7k+Wes8PXQH/yfwG7oHfnBS8ktihpQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-y9OUIqqdPeS60ulFMiflFA-1; Tue, 01 Jul 2025 03:52:45 -0400
X-MC-Unique: y9OUIqqdPeS60ulFMiflFA-1
X-Mimecast-MFC-AGG-ID: y9OUIqqdPeS60ulFMiflFA_1751356364
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450d6768d4dso18182885e9.2
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 00:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751356364; x=1751961164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5W4qfJP5trIgKgYi+NpmwjcNUOZanDpnOGZEn8fp13E=;
        b=kDzezKL3fIdR80XW570DPXdxxLMHSbcRqpLo67zRd8bprH+aLvjDoNzZopwvfodWkc
         fdDQgwgTVBYKBvCZ8eKl4gkz71JdCIhtIXVHE15BbFJtDEiZdlELNlHV+0PhG3Js4rWn
         7mbw4o/7kJPCg+qTALOxehaaDsGyBerqOFdBLRxC7dCXOysMKpH+ZzDJs6Nr6DC5w8pp
         7pmAb8VvktRDpYquZ2j1DTUoX/DuXaKPo3oMZ5LoxTPFmPqmyn/vhGA48laURD++ZZW6
         XiIz3FHpwnZY2Debyty8kh3I74VLCACUMVViiVoslTOM7zKSNEpQjZv7Wv8nOIkRZCAS
         gZGA==
X-Forwarded-Encrypted: i=1; AJvYcCUVjEJI8+dcpUfEVUtClKb6x54VT/tdw0HSXWwRvUIc0c4X2hq0P09reZOSL+Ir1LEgfShICa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE7zo+rUEHxFhQ7vqU2PWIUArjVM1kD9RZDj1Ah6zbloYtfjPa
	gvvLxNFHh96w43wcTU3FCq8UMlucwsaS9Qhx2t7zM18+iocoH5MHbWJF2zpNgP8c7SU0YCFnVT/
	KoKS8u0qi6166stxZtOJF+Rdp+ek5Zi0yx6t3F0VIxyoC4BKU+ki8lBturQ==
X-Gm-Gg: ASbGnctpXWdxPiKnWQmGal29vc1IiXP0kXzX754cEIb1Rz2JJUFkRCubm8u/FZTdH6s
	yXe6dewyeuj6eHWxIW5Az7BBCrglFXLfHHPfkFVdxX4v5mJeUiRLxhRhvtLUvl6vzgtCJ7LkUEG
	hhvASX45EBohUdbcVPcZY8J1aVS+ejKfyGaHgQUDbzOxk0CJqMGb8XpV+K5X9W7GZl8276TTjgU
	mBH1BNAYU24NKXJt1mxXxDcI4YAmfTvD7BnIYa6BGWPEkIMGUX7davoE03bfjU23HMPX0uaJqhB
	HZeQ9WZCVRf+gyrQ
X-Received: by 2002:a05:6000:25ca:b0:3a4:ed2f:e82d with SMTP id ffacd0b85a97d-3a8f51c1a81mr12478144f8f.22.1751356364395;
        Tue, 01 Jul 2025 00:52:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXOoMiKZEJq6ceWK4Q10DrkD7JlKwDdbKrLj6V8anCMySNXNp0lfxDJ0dXtxq9+6g1HirIxw==
X-Received: by 2002:a05:6000:25ca:b0:3a4:ed2f:e82d with SMTP id ffacd0b85a97d-3a8f51c1a81mr12478113f8f.22.1751356363901;
        Tue, 01 Jul 2025 00:52:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52a5asm12587008f8f.54.2025.07.01.00.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 00:52:43 -0700 (PDT)
Date: Tue, 1 Jul 2025 03:52:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zigit Zo <zuozhijie@bytedance.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH net] virtio-net: fix a rtnl_lock()
 deadlock during probing
Message-ID: <20250701035110-mutt-send-email-mst@kernel.org>
References: <20250630095109.214013-1-zuozhijie@bytedance.com>
 <20250630103240-mutt-send-email-mst@kernel.org>
 <20250630105328-mutt-send-email-mst@kernel.org>
 <f1f68fbd-e2cf-40c5-a6b8-533cb3ec798f@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1f68fbd-e2cf-40c5-a6b8-533cb3ec798f@bytedance.com>

On Tue, Jul 01, 2025 at 03:48:41PM +0800, Zigit Zo wrote:
> On 6/30/25 10:54 PM, Michael S. Tsirkin wrote:
> > On Mon, Jun 30, 2025 at 10:50:55AM -0400, Michael S. Tsirkin wrote:
> >> On Mon, Jun 30, 2025 at 05:51:09PM +0800, Zigit Zo wrote:
> >>> This bug happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while
> >>> the virtio-net driver is still probing with rtnl_lock() hold, this will
> >>> cause a recursive mutex in netdev_notify_peers().
> >>>
> >>> Fix it by skip acking the annouce in virtnet_config_changed_work() when
> >>> probing. The annouce will still get done when ndo_open() enables the
> >>> virtio_config_driver_enable().
> >>
> >> I am not so sure it will be - while driver is not loaded, device does
> >> not have to send interrupts, and there's no rule I'm aware of that says
> >> we'll get one after DRIVER_OK.
> 
> Yep, at first we're thinking that when the VIRTIO_NET_S_ANNOUNCE flag set,
> we can always assure an interrupt has fired by VMM, to notify the driver
> to do the announcement.
> 
> But later we realized that the S_ANNOUNCE flag can be sent before the
> driver's probing, and for QEMU seems to set the status flag regardless of
> whether driver is ready, so the problem you're talking still may happens.
> >> How about, we instead just schedule the work to do it later?I'm not sure if scheduling the work later will break df28de7b0050, the work
> was being scheduled before that commit, and we have no much idea of why that
> commit removes the schedule_work, we just keep it for safe...

Well managing async things is always tricky. Direct call is safer.
If you reintroduce it, you need to audit all call paths for safely.


> Then, for plan A, we change the check_announce to schedule_announce, and if
> that's true, we do another schedule_work to call virtnet_config_changed_work
> again to finish the announcement, like
> 
> 	if (v & VIRTIO_NET_S_ANNOUNCE) {
> 		if (unlikely(schedule_announce))
> 			schedule_work(&vi->config_work);
> 		else {
> 			netdev_notify_peers(vi->dev);
> 			virtnet_ack_link_announce(vi);
> 		}
> 	}
> 
> >>
> >> Also, there is another bug here.
> >> If ndo_open did not run, we actually should not send any announcements.
> >>
> >> Do we care if carrier on is set on probe or on open?
> >> If not, let's just defer this to ndo_open?
> > 
> > Hmm yes I think we do, device is visible to userspace is it not?
> > 
> > Hmm.  We can keep the announce bit set in vi->status and on open, check
> > it and then schedule a work to do the announcement.
> 
> Okay, so there's a plan B, we save the bit and re-check it in ndo_open, like
> 
> 	/* __virtnet_config_changed_work() */
> 	if (v & VIRTIO_NET_S_ANNOUNCE) {
> 		vi->status |= VIRTIO_NET_S_ANNOUNCE;
> 		if (unlikely(!check_announce))
> 			goto check_link;
> 
> 		netdev_notify_peers(vi->dev);
> 		virtnet_ack_link_announce(vi);
> 		vi->status &= ~VIRTIO_NET_S_ANNOUNCE;
> 	}
> 
> 	/* virtnet_open() */
> 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> 		if (vi->status & VIRTIO_NET_S_LINK_UP)
> 			netif_carrier_on(vi->dev);
> 		if
> 		if (vi->status & VIRTIO_NET_S_ANNOUNCE)
> 			schedule_work(&vi->config_work);
> 		virtio_config_driver_enable(vi->vdev);
> 	}
> 
> This is a dirty demo, any ideas are welcomed :)
> 
> (I think in virtnet_open() we can make the S_LINK_UP being scheduled as well?)


