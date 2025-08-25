Return-Path: <netdev+bounces-216546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC555B346D5
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DBFB1B228C4
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95062F3633;
	Mon, 25 Aug 2025 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="KbqdFES7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F6923ABAB
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138597; cv=none; b=GjPkC8RpFPeH1VHDMpvuJmzZmt7KQ1ZMp9sncZo5pZ+IJ0x7ZxMzFXR4TJX3UWOmnjmo9is6jm34Ji+R3QB9WfgyNMfryOr6ZqNDlp/mmNtbyneOY4t1tU3xNWPk9LILb7IdCo4l88EtDY12koYtDPf62fH5I58lvwGfnTJ+YqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138597; c=relaxed/simple;
	bh=tj2MmEXecPtwpTAfQ3pNrpOwDiJR4vJS8emSejJTwmA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fR37Tp1Mf6RfPWFThDGWmEaBsLMaglWJWfkWwRrBjKCC32am452XQKBUP1KVLwWqIaLVZl1HLEkgfZNseI85CenQQxa/MxXX6BIfJHENnqGeRGOFMXCsl6FL2oLpbvqRdxfDcgcOFmnOSqAKH/x8qO2qJ5cbkxeWesmM0xiEKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=KbqdFES7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b05a59fso36599765e9.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 09:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756138594; x=1756743394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmE/Hr18DFyuuwG7lfCIcnpQel7UjYIZYtvFlQ8pNZw=;
        b=KbqdFES74PSx8T3ny7uHZJjFDYe/wZX5WY2p2ikK1s7GiJ60cLSWJIjxYjd77MQXkt
         w6N91LhIpHSQyYSdh+R4LPqrjKOS4v1B2DIJnDt+r/agA3sxrpwE2JXkx5zc4X6v4yEQ
         1esVGxyXRNKbX5oFzUAut+ag8ouP/BCctaYmltG+7x9kgLgwDFKwaJGybZ39HB2VqK7Y
         kjCB7F99XWi86Q38fK1UajCxk3lsSWazXsXiCDG3JJFRq1cWcQwAd+zvoWUwJhlz9+JV
         Zyl8Q5ba7Fdvc2ENCQtuuyfmAM7ENeAakjGYU16w9BvSTjP+uvmaBqRqs6k2taOnhj7E
         WHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756138594; x=1756743394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmE/Hr18DFyuuwG7lfCIcnpQel7UjYIZYtvFlQ8pNZw=;
        b=J5RJrCSg5xQ8ppey9g/yQJPDsoXg8u3NilVx3D7DbgV3o71w9vsmoEGXTstp7zBVzU
         8Ln4KQsr3DtMedTX+YxRT2ql2IYG6htpwyGxMtu4z7ytoQK1bQVyptB3QpGZB0hDTp03
         x6AmUlf5AOQW08WqmVWUGivfJVUHnrwnGqAdwYGF9Nur+R61Imts6zxP4GZblKqXpSRR
         GofJTsx32V5yX+U6zxBzaqfiI8T7amRbZHMg/2SWQAHPNRTx+V0tQL1Z+3b2RNOiRqKG
         xCZEhIk16aqVjvpYKA91c9YAMXeB0j56C2VdwLzonJIXEQg6KP4pyPaoRG9E50d7TvWA
         HfkA==
X-Forwarded-Encrypted: i=1; AJvYcCU5zW+XOcqTz43+M2qQk53xo07ZZfBDGVJe6jC3zdMwkB0gRFTemDo3C8UDc+G3JbmrrBCg2bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg/iSea8JILa6ysvku8OKFzUMMPlHS+hta772wvvXn+6gwL3aV
	Tn8I31ef5I9tTAmXCSiT9zSJ2RkW0Zjgjw0GYRbJegMVKvj5fPev0uCAACkRujYaYnk=
X-Gm-Gg: ASbGncsFwLGS4z8EuQBeRdrZhOG4BVFm2ITPzsLQJe+M0jiyIrqxm2WeDgLL7Exv6+O
	+QyKmItwf9Sag9tN2htGlPHTxlh/OQEMmSrnBohHo1C119KMNXxC8OKYnZZYLTQPFJVefLsD27m
	F0KVPAlIQviTzOR/CTqHrG+RRDWz0Kdxw5W8KlpZRMK0RLql45YcSfCl2fQPOYVVlM6PN+ndoTE
	8VrtUsJuraoNYxMxzavDwSmXnoFk+pxQukLk58kXfM8UBbjj2i+tE5mVbFmnIUZyHWCghcuv4k8
	NvqlmtzNEfYIwoNs5/eoni3ZWPW4TSgYnS2e2lxpJW2IyrTEdE9FI2Sbbd1vzyGDWRdSfOmbl6S
	vhefXw6DrnWYMxNdxUznDPTle9OiXlxeINcjhyVkn5cpst0zzOVXObzBmxLxVBnG+NpxqKhD912
	I=
X-Google-Smtp-Source: AGHT+IEJ1fLpUWcm4ksBtyKolRV27R1GwnHC5a1PDnWf8VD1epBc/XKpDfqD8Xregvaf5oHTmQNPnQ==
X-Received: by 2002:a05:600c:4511:b0:456:1156:e5f5 with SMTP id 5b1f17b1804b1-45b517d27f6mr127722015e9.31.1756138593491;
        Mon, 25 Aug 2025 09:16:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e8de85bsm101255725e9.7.2025.08.25.09.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 09:16:33 -0700 (PDT)
Date: Mon, 25 Aug 2025 09:16:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Jakub Kicinski <kuba@kernel.org>, dsahern@gmail.com,
 netdev@vger.kernel.org, haiyangz@microsoft.com,
 shradhagupta@linux.microsoft.com, ssengar@microsoft.com,
 dipayanroy@microsoft.com, ernis@microsoft.com
Subject: Re: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to
 'ip link' for netdev shaping
Message-ID: <20250825091622.417897ca@hermes.local>
In-Reply-To: <20250821110607.GC7364@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
	<20250816155510.03a99223@hermes.local>
	<20250818083612.68a3c137@kernel.org>
	<20250821110607.GC7364@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 04:06:07 -0700
Erni Sri Satya Vennela <ernis@linux.microsoft.com> wrote:

> On Mon, Aug 18, 2025 at 08:36:12AM -0700, Jakub Kicinski wrote:
> > On Sat, 16 Aug 2025 15:55:10 -0700 Stephen Hemminger wrote:  
> > > On Mon, 11 Aug 2025 00:05:02 -0700
> > > Erni Sri Satya Vennela <ernis@linux.microsoft.com> wrote:
> > >   
> > > > Add support for the netshaper Generic Netlink
> > > > family to iproute2. Introduce a new subcommand to `ip link` for
> > > > configuring netshaper parameters directly from userspace.
> > > > 
> > > > This interface allows users to set shaping attributes (such as speed)
> > > > which are passed to the kernel to perform the corresponding netshaper
> > > > operation.
> > > > 
> > > > Example usage:
> > > > $ip link netshaper { set | get | delete } dev DEVNAME \
> > > >                    handle scope SCOPE id ID \
> > > >                    [ speed SPEED ]    
> > > 
> > > The choice of ip link is awkward and doesn't match other options.
> > > I can think of some better other choices:
> > > 
> > >   1. netshaper could be a property of the device. But the choice of using genetlink
> > >      instead of regular ip netlink attributes makes this hard.
> > >   2. netshaper could be part of devlink. Since it is more targeted at hardware
> > >      device attributes.
> > >   3. netshaper could be a standalone command like bridge, dcb, devlink, rdma, tipc and vdpa.
> > > 
> > > What ever choice the command line options need to follow similar syntax to other iproute commands.  
> > 
> > I think historically we gravitated towards option 3 -- each family has
> > a command? But indeed we could fold it together with something like
> > the netdev family without much issue, they are both key'd on netdevs.
> > 
> > Somewhat related -- what's your take on integrating / vendoring in YNL?
> > mnl doesn't provide any extack support..  

No YNL integration with iproute adds too much.

