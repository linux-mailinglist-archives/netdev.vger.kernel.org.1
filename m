Return-Path: <netdev+bounces-197282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF89AD802C
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C37F3AE190
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362881A23AD;
	Fri, 13 Jun 2025 01:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0YEGeIZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4071420DD
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 01:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749777487; cv=none; b=srDxsJf0eeCafojmJ+63GphOMtIKzmVQuy4GGkyRcHZcjT3m/gX7E1Rm1Bo7fNjatSjx0XCin0DvH9qlyM3SuG8sVozoe8BLirRUWU73vlMK7VUULrv52B4JzlzButrwbtz8LAw1RLymygvN5K+1MEwdW0W2W4IvaT6tj35/+N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749777487; c=relaxed/simple;
	bh=N/WFctq+AvImCupp49VEeQ9T2EDgilymczHxDKLPawM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=E8SO9KM+eSA3qr5WBOrFpmOppAKnREcZL6zxdKqAxGpGFJH3R82h6zGCWLmAfRY1V2MQR8OCAY8kdyFKLtjajgrtzyPKK+aqhYykiEc/e40DKsoAj30CJAPP9EJJ0AJMgdnbSA56JrxZHuOl4b8SFkB1TArgIdLQgfyZ0QOcoiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0YEGeIZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749777484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=qdi0oMWseOBhdOX25jhhjzuvoeNXv4cNg3yRD4jCMSM=;
	b=Y0YEGeIZPKhx/FPF8U7sJs3LK1wfic6+hTh1egCJMPwKV52JYzZUnCk83Xl6ZkTdBzRW1g
	GzLe/vMAEugLsglPEZvFmn7CdXjZyIuu5YqpBpX4zyiygmemTq9F44LEnlGv3uOG3LnDbL
	x0mKXPTXUdrrFKlyUmhzKySOVbgPgXs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-d6xQftZHMvqzUw-LyKNpew-1; Thu, 12 Jun 2025 21:18:02 -0400
X-MC-Unique: d6xQftZHMvqzUw-LyKNpew-1
X-Mimecast-MFC-AGG-ID: d6xQftZHMvqzUw-LyKNpew_1749777481
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-553af33d98aso195453e87.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 18:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749777480; x=1750382280;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qdi0oMWseOBhdOX25jhhjzuvoeNXv4cNg3yRD4jCMSM=;
        b=mquEXduhQnGtqB6E2+i4t0cKNJnSWFnWmzLpJS878NVIMnmAn3FcHYmLdhYNVnYYNt
         XVusjK/U43bl6LUEcKF2YgT3b9DOIYNL6i7fvnW8Beg2Nqigiw20A0xrqQ28jNQxl4/A
         GKRfTAmiqNN9xBS/rCsszs43M8ZkozAzOh1M01bn3zwtJ+nl9kPndZXjIX9ObePP0PhK
         40w/TY0bmHrdnQ8orPMye+wfqbOkeY37kaaEO/+R0PtwGDsun7Y3jC0Q8TpF9jR+lq9f
         EyO5l7nXS4fQ7nMCIoAvualN1U6UkmIxtNaOwTbnPxoNY8k5oR2HtZvQ2JikKXhQbzbr
         h5ug==
X-Gm-Message-State: AOJu0Yzj2MjIPel/nxsOHwLTLQs6rnwzB2U9+VXFVRczDFC8IQQ1N70F
	StlJe+KpW6WnFzuy2wg1bujwmUlE2kBzL299twlH4shwcuLAqbOeyyyUDosAL88IqfKlYGU7hFQ
	BmXxwKCFsktyzGpLWHp2jNx6wsWLKhZ1hLTVxznK7bHc42F1WO8skmxwUPTzvTAx9eEFiwHsq/t
	kM+d+HPzgdVn5L51QwfyivGWBQxrkDAO+VoZLYYp8EzeoM8w==
X-Gm-Gg: ASbGncs6ILWzZiBLS209Keiue78zJISnu7m0HXHFYO76dPYbxH0W6oL5ixb3CuqhQ9q
	wjoItB1HLmACgn5DTPFc7B+nOvviniXhGeBrO5sK/PFEbf5Wfv0u5pO7KEXh5CpqDsib4Vnwn0k
	SXTudN
X-Received: by 2002:a05:6512:1092:b0:553:2760:e82c with SMTP id 2adb3069b0e04-553b0ef4f39mr138665e87.25.1749777479890;
        Thu, 12 Jun 2025 18:17:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPY5onBHETdPprx/U/RGT0XAYeUHQAXUiMU9hQMoA9l8nZ77qLZR1uMF+mTL0KgN5zetZv/3kw3xMr8RsnmMQ=
X-Received: by 2002:a05:6512:1092:b0:553:2760:e82c with SMTP id
 2adb3069b0e04-553b0ef4f39mr138662e87.25.1749777479408; Thu, 12 Jun 2025
 18:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 13 Jun 2025 09:17:47 +0800
X-Gm-Features: AX0GCFuiAKKrNFik8IHGvZk2bvYtKypapbUF_5WYqUpvtKL12QZ2aDwf-CKVcyU
Message-ID: <CAHj4cs-CWX0nFzq=ZnhE_Cj_ZSw8-3c+aUXeexpCs=9pEa2rGA@mail.gmail.com>
Subject: [bug report] tg3: kmemleak observed after system boots up
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

I found the kmemleak issue after the system boots up with kernel
6.16.0-rc1. Please help check it and let me know if you need any
info/test for it, thanks.

# dmesg | grep "suspected memory"
[ 1489.395283] kmemleak: 2 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)

# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff8881703d4500 (size 232):
  comm "softirq", pid 0, jiffies 4294869720
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 c0 ed 09 82 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace (crc 549bb074):
    kmem_cache_alloc_node_noprof+0x3e9/0x4b0
    __alloc_skb+0x205/0x2d0
    __netdev_alloc_skb+0x3f/0x720
    tg3_rx+0x5bc/0x1990 [tg3]
    tg3_poll_work+0x1e3/0x570 [tg3]
    tg3_poll_msix+0xb1/0x7d0 [tg3]
    __napi_poll.constprop.0+0xa3/0x440
    net_rx_action+0x8b7/0xd50
    handle_softirqs+0x1fc/0x920
    __irq_exit_rcu+0x11b/0x270
    irq_exit_rcu+0xa/0x30
    common_interrupt+0xb8/0xd0
    asm_common_interrupt+0x22/0x40
unreferenced object 0xffff88820bca9a00 (size 704):
  comm "softirq", pid 0, jiffies 4294869720
  hex dump (first 32 bytes):
    40 75 3d 70 81 88 ff ff df 02 00 00 88 02 12 00  @u=p............
    53 59 53 54 4d 3a 30 30 2f 4c 4e 58 53 59 42 55  SYSTM:00/LNXSYBU
  backtrace (crc 8f8d581b):
    kmem_cache_alloc_node_noprof+0x3e9/0x4b0
    kmalloc_reserve+0x143/0x240
    __alloc_skb+0x10c/0x2d0
    __netdev_alloc_skb+0x3f/0x720
    tg3_rx+0x5bc/0x1990 [tg3]
    tg3_poll_work+0x1e3/0x570 [tg3]
    tg3_poll_msix+0xb1/0x7d0 [tg3]
    __napi_poll.constprop.0+0xa3/0x440
    net_rx_action+0x8b7/0xd50
    handle_softirqs+0x1fc/0x920
    __irq_exit_rcu+0x11b/0x270
    irq_exit_rcu+0xa/0x30
    common_interrupt+0xb8/0xd0
    asm_common_interrupt+0x22/0x40


