Return-Path: <netdev+bounces-225835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7594B98C3E
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB5A3ADE25
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C3628152A;
	Wed, 24 Sep 2025 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIaKNLU5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E627FD64
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701401; cv=none; b=QWQD5KboFicqT3rBlcOJtWr92unn5sUaJprVCG3617LGbcFiVboyCFN0undFcfL2UUHblXKg5f8HJ12sPDw1Y2YCVQJCRVRTRUMi7bXv4bFPP1dfse/TFRpZ1v2OQL1kQVaUAoa1crG6J5zGRQa5keILgvDhLvuBnALkPDleIgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701401; c=relaxed/simple;
	bh=iyV5w9cbgt6ZgVOTxo8iAQ4w6DBDgBjEsyMsIZQh/kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhBzdfVPZbJ7oBZX2x+D0cgFIm0mHGKjs8pPRNFYWrPU3yGg3/GXoBoHGOB/MYsdw4yf5kejbgKTZcMgseeazQ1XyNY8T1M3nHzBUcqttjC1IRKGaY1LIeVNcFyv2x+OoWtNFn5IEW9X7UsHNbmS/wIjCiyBknya5xWCEO/vdrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIaKNLU5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758701398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkM4oXRVV4nD2vjM2JL+8uqwWZZi2+21i3PZycL5UHY=;
	b=PIaKNLU5Anfh732lj7csOM1LaofINFbc6I4L4Oe0GG6CLB9C8aYy8BXk58JAHurJA7nNWP
	HqudR35Cf7km8ENtqyDtRUw6+emaVNuTrKURA8aXlGY7FqamhM1csDAh6Uv2LTA1mH0Mli
	hgCYyNIqyuO/+9/NsU8MY8F0v83yinY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-MNrJ1tNRNqyCAwUF3fKeQA-1; Wed, 24 Sep 2025 04:09:56 -0400
X-MC-Unique: MNrJ1tNRNqyCAwUF3fKeQA-1
X-Mimecast-MFC-AGG-ID: MNrJ1tNRNqyCAwUF3fKeQA_1758701395
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b990eb77cso4376805e9.0
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 01:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758701395; x=1759306195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CkM4oXRVV4nD2vjM2JL+8uqwWZZi2+21i3PZycL5UHY=;
        b=Rzab+ECYu0ntI/JRKF6hl082r7IIbivHG3OqJOtq+b+hklAtmHUD4AndWAhtMeMUy/
         mO5eqfLUDr++M+eOefOFufCe+pj3a6+2mQursr2Itrkmw5W21GOb44QX22LZuEkt/ICB
         m0MpmZB3BblcUXbg1p/YWIeaP3oymRiyDnA964XtOgadUUknYZidqP3r7VYQfHDPPiYY
         3c5HyvvwMVyGKZA6cpPfqdU3TaC0pS5oamxO+FABUu0+JpsOSS0Te53s0A13sNfGPJEH
         r8nVPd5dCkAgvyuVN70lOACCliYJxJjE/ul9mIL/uaWcDWQDywrEA7ffkx37Ueui7mo6
         owWw==
X-Forwarded-Encrypted: i=1; AJvYcCV4iMG7XVadFmsCXMKZXvzH9sYdnb2IS/sJT6wCTy21kpVMBhYjCb3IW8Pm1mpZ/OcKAcdh8KI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3SkQbeMQ9aH9xA2Ge3w8qolBYVcKwZ0U3F+U1XCu4ya3xV82G
	1YIGdQCb4Q8P7+H4B98jHGK5kIqVVyqmHiafELlA0vYLUByaDhhQDJD3JuohNsY8PqShfIuLVqG
	+UAQVaw50gbiSO37Va5/tGhTMzQvVCBG8RlSrvwxEPU1fmkaf4X346UryPw==
X-Gm-Gg: ASbGnctmPyS9E49LhIpLcg3AFmz+L2FLJDud0ThRGktUCOIEdSnLURf1756lTl2ROW2
	0YkblaJwfg/HW2rMT12mWYpw2zjC+q93YCfOOlcWg7uJ5YT9zkJ0nbhejiVB4pwopSF0cMoA7Ed
	MhUwtlESxOgqG2MpimBRnlUHyGqGpbdyfkCCx+vUbzllxOCzVA954GLTp8hRcZCGHLvXcd5M4tp
	4UfatjUTxAoQ2B5a4UOfhAhBTn7pOHmxZMk83SjCYrwFr0CAD3AmtiSDRNMjHhnOSuft3kVtfGE
	EoQSYdltQ7uWXpJcqxxhKTa5nkiHFKT7jv8=
X-Received: by 2002:a05:600c:540b:b0:46e:28cc:e56f with SMTP id 5b1f17b1804b1-46e2b539770mr14433315e9.6.1758701395314;
        Wed, 24 Sep 2025 01:09:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2isQpxZ6pAJzr2vpEkZfoKb5tx8a+WdsYfEl5CDZPv35AgMoMJYvNF0tcDqDtm8H3UIV5Gg==
X-Received: by 2002:a05:600c:540b:b0:46e:28cc:e56f with SMTP id 5b1f17b1804b1-46e2b539770mr14432985e9.6.1758701394926;
        Wed, 24 Sep 2025 01:09:54 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31bdesm20213965e9.11.2025.09.24.01.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 01:09:54 -0700 (PDT)
Date: Wed, 24 Sep 2025 04:09:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	willemdebruijn.kernel@gmail.com, eperezma@redhat.com,
	stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/8] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
Message-ID: <20250924040915-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250924031105-mutt-send-email-mst@kernel.org>
 <CACGkMEuriTgw4+bFPiPU-1ptipt-WKvHdavM53ANwkr=iSvYYg@mail.gmail.com>
 <20250924034112-mutt-send-email-mst@kernel.org>
 <CACGkMEtdQ8j0AXttjLyPNSKq9-s0tSJPzRtKcWhXTF3M_PkVLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtdQ8j0AXttjLyPNSKq9-s0tSJPzRtKcWhXTF3M_PkVLQ@mail.gmail.com>

On Wed, Sep 24, 2025 at 04:08:33PM +0800, Jason Wang wrote:
> On Wed, Sep 24, 2025 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Sep 24, 2025 at 03:33:08PM +0800, Jason Wang wrote:
> > > On Wed, Sep 24, 2025 at 3:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Sep 23, 2025 at 12:15:45AM +0200, Simon Schippers wrote:
> > > > > This patch series deals with TUN, TAP and vhost_net which drop incoming
> > > > > SKBs whenever their internal ptr_ring buffer is full. Instead, with this
> > > > > patch series, the associated netdev queue is stopped before this happens.
> > > > > This allows the connected qdisc to function correctly as reported by [1]
> > > > > and improves application-layer performance, see our paper [2]. Meanwhile
> > > > > the theoretical performance differs only slightly:
> > > >
> > > >
> > > > About this whole approach.
> > > > What if userspace is not consuming packets?
> > > > Won't the watchdog warnings appear?
> > > > Is it safe to allow userspace to block a tx queue
> > > > indefinitely?
> > >
> > > I think it's safe as it's a userspace device, there's no way to
> > > guarantee the userspace can process the packet in time (so no watchdog
> > > for TUN).
> > >
> > > Thanks
> >
> > Hmm. Anyway, I guess if we ever want to enable timeout for tun,
> > we can worry about it then.
> 
> The problem is that the skb is freed until userspace calls recvmsg(),
> so it would be tricky to implement a watchdog. (Or if we can do, we
> can do BQL as well).

I thought the watchdog generally watches queues not individual skbs?

> > Does not need to block this patchset.
> 
> Yes.
> 
> Thanks
> 
> >
> > > >
> > > > --
> > > > MST
> > > >
> >


