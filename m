Return-Path: <netdev+bounces-95028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D7A8C143D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 19:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44A5CB20E9E
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 17:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5112974BE2;
	Thu,  9 May 2024 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jBhZy8L1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1583D537F2
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715276662; cv=none; b=L1HB/aizGxacN2UUTyMOZRAPfYXSv/7I44KTYxl+rQRx+chk27ywXOy26b0jvmqs9d1bebQp4k3N2P54b8WMQiqcwr9qNTtz0wYUwL7hzl4vgy8r3sE61DzsRbVoVyOFClTP2UWC4z5io3x0VRG5YCIABMJBXzm9y3gzKDuFvps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715276662; c=relaxed/simple;
	bh=5C8v5MVYmYz1jOdqIEyZUnZslFOJx/IK1YUPLapEMRA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ND/V7XLqfFj0O6rfX9K1oPo6UWInprCsShDHVnDowzQTtsiRgKVwi5TuLfbTRvWszZIkDGafemRHNIXpNz0zIWKknEtISlF0cLBnAd1bjX+KDnsp03iHVkaZDR1CmF7iWWu+k5+0PGhe7xrqrt42uarRTk71VLkCykO21Fr4404=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jBhZy8L1; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d6b362115eso9534639f.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 10:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715276658; x=1715881458; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSmnM+qeofdulZBy1pvMmuQ/QVln46hTgoYnIiJYZs4=;
        b=jBhZy8L1ZH+e1Bb6zRzvaVeAdrleSpUGoJMKkskSIA7uybvlAlE8wC4e4W49qLSQhh
         uu1Ir+Z1TlylfHMRyFJmLhUTpcwCSIzUSDM/6poLlSIX/F9VzS6S0YIY3VjjB6yGPFH0
         9O0E0Hw4nkEemJtSiXMn9/2cSYFPbYd1guvUBtjUkUaSs9gduJ0MBamjwfP5dOAyxlr7
         CATc83uVVopZGGP6W6w7NH1rVS6CQKdpuhf1un7MgNuYe/7oY0CBwNS8nnUNhuaxohw0
         GhLzv84I9nD/oQ/pRUAWlaac6yTHdIdgC63tasP2TCEU2ORHkJq2AUW16cSJvBGidiTw
         L2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715276658; x=1715881458;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hSmnM+qeofdulZBy1pvMmuQ/QVln46hTgoYnIiJYZs4=;
        b=wUDJ1qsV9N8pgt9cGQhGMNPShd7cVlQMDlDfTM2OF5neYHPdBWLrVqHnXH5Hmkzo8c
         LcHZ5bDVvYfwe+udOn0M6A2bTPWFFV9xSoMotbvWohJeOnb9FnkWGx4nfYNhPmrIatJU
         77I+a1hh9TbVHkHiDSsSthFkARyLYCsBfe3L2qugTCm9mLRjxsHGQwrpc9XsrlpWDh7l
         xN9F1CShKFaDpmX2tkFTuyTXrNp+3qgAHPBGUugkCVJp5OxMFp6IeZ7kpv4PYvye2SKQ
         C8qHSlejfTT8g0rWyDeIOjGqazKR2Bf3q9lBlJUjmT2LjvBlzXLBoU96Ol47NZCcTYeW
         8RUg==
X-Gm-Message-State: AOJu0YzV8ee8qBe/OVIJxQB9/QWTFmQB+zYNOWMW6WiipfOgBJ5p/IZ/
	dJ2ShYBOB4/XEQY4vcA0db3IBzwMRx0uXiW1uSDwsiMULEajnhOTRAYmB6fb4t/hnKs32o43jK7
	2
X-Google-Smtp-Source: AGHT+IEpo/U/HG5AMPZ55+2Bf3nfvi+sEWikC8zz+6Fi/WZf/rzb7zCQ2jc7nqEG6saWnWn5cD70+w==
X-Received: by 2002:a92:2a0a:0:b0:36c:5572:f69d with SMTP id e9e14a558f8ab-36cc144509bmr3669855ab.1.1715276657854;
        Thu, 09 May 2024 10:44:17 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376fade3sm482479173.166.2024.05.09.10.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 10:44:17 -0700 (PDT)
Message-ID: <0674ca1b-020f-4f93-94d0-104964566e3f@kernel.dk>
Date: Thu, 9 May 2024 11:44:16 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: danielj@nvidia.com, jiri@nvidia.com, hengqi@linux.alibaba.com,
 Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Subject: Leak in virtio_net in net-next
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Starting working on a small networking series this morning, and
was instantly greeted by:

[   13.018662] kmemleak: 2 new suspected memory leaks (see /sys/kernel/debug/kmemleak)

when booting my vm image. Details:

# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff000006479aa0 (size 8):
  comm "kworker/3:1", pid 98, jiffies 4294892862
  hex dump (first 8 bytes):
    00 00 00 00 00 00 00 00                          ........
  backtrace (crc 0):
    [<00000000e3a8eaad>] kmemleak_alloc+0x30/0x38
    [<0000000067412f7a>] kmalloc_trace+0x234/0x364
    [<0000000077402ae2>] virtnet_rx_mode_work+0x144/0x78c
    [<00000000a7f96032>] process_one_work+0x538/0x1048
    [<000000002cbbcce6>] worker_thread+0x760/0xbd4
    [<0000000077f92d4a>] kthread+0x2dc/0x368
    [<0000000051ca839f>] ret_from_fork+0x10/0x20
unreferenced object 0xffff000006479ac0 (size 8):
  comm "kworker/3:1", pid 98, jiffies 4294892862
  hex dump (first 8 bytes):
    00 00 00 00 00 00 00 00                          ........
  backtrace (crc 0):
    [<00000000e3a8eaad>] kmemleak_alloc+0x30/0x38
    [<0000000067412f7a>] kmalloc_trace+0x234/0x364
    [<0000000077402ae2>] virtnet_rx_mode_work+0x144/0x78c
    [<00000000a7f96032>] process_one_work+0x538/0x1048
    [<000000002cbbcce6>] worker_thread+0x760/0xbd4
    [<0000000077f92d4a>] kthread+0x2dc/0x368
    [<0000000051ca839f>] ret_from_fork+0x10/0x20

and taking a quick look at the virtio_net commits that are in that tree,
this one introduces the leaks:

commit ff7c7d9f5261e4372e541e6bb6781b386a839b48
Author: Daniel Jurgens <danielj@nvidia.com>
Date:   Fri May 3 23:24:41 2024 +0300

    virtio_net: Remove command data from control_buf

I didn't look into debugging this, figured if I can trigger this by just
booting a vm in 10 seconds, it should be trivial for the
authors/testers/reviewers to sort out.

-- 
Jens Axboe


