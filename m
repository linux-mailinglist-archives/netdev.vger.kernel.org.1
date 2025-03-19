Return-Path: <netdev+bounces-176352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E20BCA69CDE
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 00:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DC216AFC8
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 23:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F91D222599;
	Wed, 19 Mar 2025 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NlXY00M4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DAD218AA3
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742428156; cv=none; b=F4hurlxuef0bVHpV19ivdogKJJbFb+3O0cNRtuAUrQd/NPmZMMl07ZJbFwY83SMLMkqrH8KjWa04F2PjsQsyj7SGFV5nAfAVuU++FLIvI+oh1MyQ0kL/KuCL5tGyCmoxv27JKzC+QpWPvGdWUsSeYN/bZe6FrNkOx11Hxl1dllw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742428156; c=relaxed/simple;
	bh=kBApISPiNYDn3vU6yhDdi+hU5u3k64AmjMPlKRp8KJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQm7xoEJJ2VhN80KFSk6fGJsvcnpUnJvdW4fhenoPl+T4sqRGnmZnpr1R6wFNbkv3QIqr38shOMO6HWSAesZcfn/yY3wZQT38mGOpXR1PIgIVUJB0YoPPNGoVaEyuC06dngoXVsnPXg26aBDMDXfzUe62iVJ/hb53uOzgn/d+QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NlXY00M4; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c55b53a459so23552585a.3
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 16:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742428153; x=1743032953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5QfDcV84lJfkh0SuTH8QAOQMjcXcgthE0b6ZZKYAf8=;
        b=NlXY00M4kHTcGbHDAeAlyHMpHKegHgiDmuQiROSCaiHbzIjuW2DN/OnJm/o05uF3ES
         MxoaFhycby3jJeXe2SUrSBNpHPBtsWdQ6JzE1MzpxRD0p+fEYsbtbUHm2eJlltQP8UyI
         PKCeuanR60wQPO4IPJX4MrAO2QZXd5rYG0C8cvbWW1aAyIWKV3z7EG5k5uDLPTXmZbzy
         t148kjATDGyTIUzDV6Cft0oQOj0/hNnAWTPUcxG5FloQyz7+mTXzcs4X8VLVkmt9G/sm
         e2s//SXo3MtNJOP1SN9oAvYZDW9qKi8r3iPemmXdV7idzGn9wR2wHf89hED3Xf6XeRdU
         lJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742428153; x=1743032953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5QfDcV84lJfkh0SuTH8QAOQMjcXcgthE0b6ZZKYAf8=;
        b=CyAqgIC5Y94+znsPTOSf3uMUot9zdh0BGvBN1U8sOR8a8CJrKnIUGrEBMjfOmQyRxO
         wWPBJb2oCiBozW+IvMDe2re+maqhpRIqDQzsiWIjMJ2Mrz3Imr3ojbG0bTWf8FE2KH1o
         rjY3ezMwPdOD37pyPuNbnYvv4Q7udgmyc3TTIemNx4JemtDpJMTI20jMR3SuJIU+3imj
         A/Q+iJLv4YJ/+4O6CPFSmSPrHujALvSl/hJpOOSUQgFvyn/QGrWG1v9Xa2Ez3EZgKnta
         Hcozcvucjrq+PxEm2AF80UEQ870qmgLZ2eO4I6XPGwtGAjuMdcaILQe2xLSyvobtdd0f
         R6Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWQcP3xzyS4nj7RtF/rJBZMb55er+QVHyYtcF+03TsPe4MlbB2X+bZbIWoiodIuJLb7ZUM7Wfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXCUoTh6WZD8ygBs5tzcxrrmK8HtBylwn16LXsbZkf9WGBdJ3b
	B4XPSTy9OaK4jVg5Z5oOpDQImwL0f4lBZ9KeTpohObIIm4BuutzKpJqwB2isvI0=
X-Gm-Gg: ASbGncub+scvFchDiga5/6UO9JvBj4Vn6n/6VoTqPvYKsY/w8+Vr27qM7e95xU4BfYX
	FlCzyKJaEBBSJaieGlIQpatP5nLHFIvgbQonkwiwU2uxnnsF+GX715K7GR468eHKJS6eD30av/H
	xmaKrghlklOYNc+7SHv3eTM3hSWwD4SxhYp3mLVB4c01wrrM+b4ZFyvpbMznCYTJjTyldVWcRQX
	63/cpJlSZGCxAzH5EzK1ryYRZD0jn1G0c7d9L+0ifF1zVnDJchq9srWDY0EHihNdRaODD8gli0V
	NwUp8sMuI/ZD0qUv2Oylf5KHWLmjvNJk1skpgGpI3f5hx4Vl5iwX4CZwpPhXCHgpHJNolpsQPEP
	xrlsiBBIwSYbgC68NDw==
X-Google-Smtp-Source: AGHT+IFxBsP7ws/LHh2WRg2R3XRYd7ulo4Cve6JtWcz3/n58zxufpzBDEKNeeKF86f1/rNhxf7voDg==
X-Received: by 2002:a05:620a:2616:b0:7c5:4769:3acb with SMTP id af79cd13be357-7c5b0d1826cmr219468985a.47.1742428153586;
        Wed, 19 Mar 2025 16:49:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d8aeebsm917200985a.103.2025.03.19.16.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 16:49:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tv39s-00000000csH-2Ivg;
	Wed, 19 Mar 2025 20:49:12 -0300
Date: Wed, 19 Mar 2025 20:49:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: syzbot <syzbot+17fb1664c4f5a2eeb36f@syzkaller.appspotmail.com>
Cc: leon@kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in
 ib_device_uevent (2)
Message-ID: <20250319234912.GH126678@ziepe.ca>
References: <67b25ec8.050a0220.54b41.000d.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b25ec8.050a0220.54b41.000d.GAE@google.com>

On Sun, Feb 16, 2025 at 01:55:20PM -0800, syzbot wrote:

> CPU: 1 UID: 0 PID: 6903 Comm: udevd Not tainted 6.14.0-rc2-syzkaller-00039-g09fbf3d50205 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  add_uevent_var+0x17c/0x3a0 lib/kobject_uevent.c:679
>  ib_device_uevent+0x4e/0xb0 drivers/infiniband/core/device.c:502
>  dev_uevent+0x28b/0x770 drivers/base/core.c:2673

> 
> Allocated by task 12483:
>  kvasprintf_const+0x164/0x1a0 lib/kasprintf.c:46
>  kobject_set_name_vargs+0x5a/0x140 lib/kobject.c:274
>  dev_set_name+0xc8/0x100 drivers/base/core.c:3468
>  assign_name drivers/infiniband/core/device.c:1202 [inline]
>  ib_register_device+0x7e0/0xdf0 drivers/infiniband/core/device.c:1384
>  siw_device_register drivers/infiniband/sw/siw/siw_main.c:72 [inline]

> Freed by task 12485:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2353 [inline]
>  slab_free mm/slub.c:4609 [inline]
>  kfree+0x2c4/0x4d0 mm/slub.c:4757
>  kfree_const+0x55/0x60 mm/util.c:43
>  kobject_rename+0x179/0x260 lib/kobject.c:524
>  device_rename+0x130/0x230 drivers/base/core.c:4525
>  ib_device_rename+0x114/0x5c0 drivers/infiniband/core/device.c:402

This looks like it is racing siw_device_register() with
ib_device_rename() ??

Whichi suggests we don't have the right protection in
ib_device_rename() to not act on devices that are yet to be fully
registered.

Jason

