Return-Path: <netdev+bounces-180057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D056FA7F5BC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B449B1679AA
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 07:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4BF261569;
	Tue,  8 Apr 2025 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="codYwDoH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8A25FA28
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744096460; cv=none; b=bFmqJqAnb2zYo+1dlmHb0h/fzMf8SRAfhagwj7KQ6aGgA3/jPpOnnRrKTavD+Ag5H0qBCGrWgCf9PCnpBqCHS6ypBMl98iz7qGrus6+pfySyhHVXyQnw2SgAWFUeHe0TRbKlHBBBsvjIzYvVbRKCf9ZlZP9yyGi38K0ebOijUos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744096460; c=relaxed/simple;
	bh=i93igg49mItteayVR06UBujTm9EzjzWLprog6S2Il+U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BDCQIPC/V8imclVqCbmhZgIMNYi+qQiC6QtcmfIs+lN62x8ADYstxRQ3YZt9o+ySqfWYc+MsFpc94595V0/PboUaR/3aNNR8qM9o835txH6uQptJSVL3/bNZfBDetx+lMpawN3t9c3uSztWpFeJF5mcgqqFkuzJ3moo7fHYELpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=codYwDoH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2260c91576aso43400805ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 00:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744096458; x=1744701258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jn5KLXC6x63iEco5Kztp9Iwz6ZEqoWR2FXPhfKP52n4=;
        b=codYwDoHo7aU4Gni9I+z7jw9ZjyFw/UQKP/MYn6iBxR5FfPpqietn+VLueUNMVJQ93
         SfzD7czkpc59v37mx+F9DdP41DjAlbLuFAf3XomwAXea2lpj0/YcS3LxLfIpCF4hQoIu
         WfUEolprnmYcDTpRCkxx9whHy2htNC2w1UsbY3nIoWN+eBXz9KulIWNg5DwDiQu+eDwO
         pxn1M5OzRzEJrbwu+F9MALhuoNyc8myeuIIfR5xYwkipKTVvt0F2S8QSKwYmaqipPqMl
         EQUxCFoGcuosDzifvEbl7e3JSNkVzAUGkxlTmW27sLqZ9i/DoaHuFGHROzFWPfqm9E/n
         DG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744096458; x=1744701258;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jn5KLXC6x63iEco5Kztp9Iwz6ZEqoWR2FXPhfKP52n4=;
        b=dzyzmlGU04eCxidbXw5692PUX6DahGrLYhRld7X0UWi4BrmZi0LFHlYmMpGRPNXRHX
         /WFf3HNuZKegcI4VWMEMtZqnyD93JdlaGVlgZPS9kk2h/lrlI4FPam4ywHGs2EOj5P6j
         v9+ano5lQucT+j3HR8pp0SCVUZdtuxNFmW42sbIff0Md08Cs9TelqcFUnEs+W+9WyR+Y
         yN+k2Ebkw9roWT7OpHUoew0qSA6jBBxMhzrwRZ5rvj0STg6N56jGMjplYyFkmG3bDFE2
         hUjhzvNXRb0VC/CyQSAb4rkJ9g2I+SU8u082I1fl9AT0ecBYuVPfyjBluSQw5K0RNJxD
         +9pw==
X-Gm-Message-State: AOJu0Yy3o7zQTFXxTdS56BXARl7kH93AixXfUuEGhAnkiHImlzqnWyfM
	HNDaBPfViPgv3osPpjCNCXa2j33h7EYYfJD/99Qy01trjWS0Aca5yS4aMgvbefsfr9CWKqpYlNC
	qrrfcxdsle3fQvRtcXpRQ3aYv4aKbgYxeWDXsIQ==
X-Gm-Gg: ASbGncsFvkExwP8mMr92V//Rx+l+5j1olf4WtOFNGIrQwqyrwjE3oqFJ0NacSq6ZQSb
	1TMYJ6BpOInGDxlnFgG1ERmdnhnVHkEizLT9mhFk0224DQg25Gb9G/ICHpjNKeM46kwYJUtzk2q
	KX7yDe5Nx2JwZR6tYS/qWXKLN7EBQK+p+RbxcsJQ==
X-Google-Smtp-Source: AGHT+IETp/7iZuhdL/l0VKuWcHMyFMbdXC0Ydco0+uuRI2R8/1chSUA0MgOSLRUl9fB9TWiPeaz7R93vZsJJbmZvv2k=
X-Received: by 2002:a17:903:3c44:b0:223:67ac:8929 with SMTP id
 d9443c01a7336-22a89ebd5a3mr213133995ad.0.1744096457690; Tue, 08 Apr 2025
 00:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Abagail ren <renzezhongucas@gmail.com>
Date: Tue, 8 Apr 2025 15:14:06 +0800
X-Gm-Features: ATxdqUFFesBL1QBvRPXMhubG37papZ-7pbqvu8K1-XO2eFahQ6FFwCqtxBQzbVA
Message-ID: <CALkECRjxuNBBYrTwa8-pOX6BTCXM7YBWZX-O-FOjrsbqdXXqzw@mail.gmail.com>
Subject: BUG] General protection fault in percpu_counter_add_batch() during
 netns cleanup
To: netdev@vger.kernel.org
Cc: syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi maintainers,

In case the previous message was rejected due to attachments, I am
resending this report in plain text format.

During fuzzing of the Linux kernel, we encountered a general protection
fault in `percpu_counter_add_batch()` during execution of the
`cleanup_net` workqueue. The crash was triggered during destruction of a
network namespace containing a WireGuard interface. This was reproduced
on kernel version v6.12-rc6.

Crash Details:

Oops: general protection fault, probably for non-canonical address
0xfc3ffbf11006d3ec: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0xe1ffff8880369f60-0xe1ffff8880369f67]

CPU: 0 PID: 10492 Comm: kworker/u8:4 Not tainted 6.12.0-rc6 #2
Hardware: QEMU Standard PC (i440FX + PIIX, 1996)

RIP: 0010:percpu_counter_add_batch+0x36/0x1f0 lib/percpu_counter.c:98
Faulting instruction:
    cmpb $0x0,(%rdx,%rax,1)

Call Trace:
 dst_entries_add                    include/net/dst_ops.h:59
 dst_count_dec                      net/core/dst.c:159
 dst_release                        net/core/dst.c:165
 dst_cache_reset_now                net/core/dst_cache.c:169
 wg_socket_clear_peer_endpoint_src drivers/net/wireguard/socket.c:312
 wg_netns_pre_exit                  drivers/net/wireguard/device.c:423
 ops_pre_exit_list                  net/core/net_namespace.c:163
 cleanup_net                        net/core/net_namespace.c:606
 process_one_work                   kernel/workqueue.c:3229
 worker_thread                      kernel/workqueue.c:3391
 kthread                            kernel/kthread.c:389
 ret_from_fork                      arch/x86/kernel/process.c:147

Reproducer Notes:

The issue was triggered during `netns` teardown while a WireGuard device
was active. It appears to involve use-after-free of a `percpu_counter`
structure, likely after its owning peer or device was destroyed.

Environment:

 - Kernel: 6.12.0-rc6
 - Platform: QEMU (x86_64)
 - Trigger: `netns` teardown with WireGuard devices present

Related discussion (possible fix?):

https://lore.kernel.org/all/20250326173634.31096-1-atenart@kernel.org/

If this has already been resolved, apologies for the noise. Please let
me know if more trace or repro information would be useful.

Best regards,
Zezhong Ren

