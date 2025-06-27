Return-Path: <netdev+bounces-201963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B6EAEB9E7
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941BD3B0762
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 14:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67AF2E7166;
	Fri, 27 Jun 2025 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWM8mV8x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025442E2647
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751034698; cv=none; b=kw7QGyFD7c+uHyTZNO0EJAyFTw2UBItDEo11k7co4xRqy2mmeKslb7nSDJKZxo0is3+4lRsvLM94tpc8k4P/OI+6fUHWve4BUwFBTkThbRpthGYLG03wSf9+NbbwbcJMafbMA36kimFE9KIuHqLkyYFxtw8U1J28SKEarpM6Ud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751034698; c=relaxed/simple;
	bh=ONc8t81NFVZ2BFFCnYm2zfAM90QikYEfG0DlHPf4SBU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cvsWvjOQNd3BLmyRRseJ1fBx0guLPhODugyZQQPMOmED5S6S7oMMFfAsYc2/clT4Jn95/eCtZtv8HEahzFtSdP7Isesg6AfWZGzSKcV8o+FcAXp9EeVSREwQokAQity4j8C/MsVGBwNjjrar6MYK61omr5judZ2k5ETKoepVQ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWM8mV8x; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-453066fad06so14034165e9.2
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 07:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751034695; x=1751639495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ONc8t81NFVZ2BFFCnYm2zfAM90QikYEfG0DlHPf4SBU=;
        b=mWM8mV8xzopW0oAG1yrUeH6slwTGC91Hy4rw3zhNkpY1yULD+evBLxues2C8WeKYzK
         3zF8k+4t3oY/W4xljy1cq4xd7JigyvQBmDYeZIYwu5f+H9hxo6lDDJuxw1MVmnbMU976
         jYqV3HfaeRuz5YFbcTFLj0VEC97fnjd1fV62oeoCAzYO7TyaSsceAfAUPxBp6AhLQJZv
         2QkiR3BSWelvJ92e8ChNF/WCJosvPsdUVzin5/4FmUz05ZLi3aNvjoJsK9fB8TOJcIIr
         C/eobxhgWmO1AgCmVjaDcU5BAyO6LIkSilQDGIL3tf28fKV5ZVIdErF16wXtAYAXwoOW
         dYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751034695; x=1751639495;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ONc8t81NFVZ2BFFCnYm2zfAM90QikYEfG0DlHPf4SBU=;
        b=rX/YUKurSvd68P9eyAFBuwsjZHVzJUahLGvyZzhXY9qxvt/bK/tvVHgzzE/t9vGTCN
         QrI2Krsb/HNnjLpj3WhdyV1GVCkwcCrHn+EeJ/8ymAmk/zPEEBvseknckhNme8udWRxP
         SvO59gllRkLJ5FOl41bCXEE9hQ/Fysy06wACiTox69RaW9BTgSjEwHeT5B5M3AOYNTdi
         qZvJs3QAkvKo/UVAUHaI5PPHTzzNKgPrinVeo6QxVj8B0utMMHZmKXjGw8v6wNZcRGGx
         rFDVhTo+MfQZdqSX/0SZVO7hoBh+LTR+qYXFl7dLy8YVixyjv+kX+tX+4LUt+/t0DACB
         GzLw==
X-Gm-Message-State: AOJu0YwdDtt9TXpfqUcaEr8U/IJdwOPgyLVAWYj2GsX8+1cmQRqN45Rf
	qzaS4o+SMjJ2RGPEQvKWLMp2+tWDgOdbFaWioj8M3P3+ZCH50fushLcJ8pHUVCJaZZIgezxC9z8
	wEf0Tei194ukAgDH91JRaswfoQXH9rwgnDQ1P
X-Gm-Gg: ASbGncvcOyqzKebXoKPW5Z0l8HRiC3B9vvgNVJ+NfzN7A15ixMyeAsCu+8jfDiXd/6K
	PCJbwCQN73EvM5+XQNLnHywcYGbBd/VQD82tLWV39ENwT2bE6hRzTlxTRmEX6fFFjRHJBd9oXGK
	DHxN8s416xhaz/tzZnGkDAFX/gZBhnGnQ7R6dzxvTZarFmsGBn6d8ANdVoflU4ZNIUXekgueRFo
	SNJAA==
X-Google-Smtp-Source: AGHT+IEJsFVPEqqC5gwju17HP+MMCt4N5iceDQuRdUyxnmwq9lR8tMfaSDq4uxGua6GLFO0EAIj5j3bMub6TnihfIqQ=
X-Received: by 2002:a05:600c:4f12:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-4538ee85622mr44847775e9.16.1751034694840; Fri, 27 Jun 2025
 07:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zak Kemble <zakkemble@gmail.com>
Date: Fri, 27 Jun 2025 15:31:23 +0100
X-Gm-Features: Ac12FXxsIjL58em8bbETNvuU5s3GYFuIvZHsUYXQPCzOcQB9BLXNH_E0vbkXHao
Message-ID: <CAA+QEuRZXkPjN+=mgeLL8znYsMEpsk8a5omJ+eC1y-0SFnSrCg@mail.gmail.com>
Subject: BUG: bcmgenet transmit queue timeout lockup 6.15+
To: Doug Berger <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, I have a Raspberry Pi CM4 setup as a NAT router with the bcmgenet
ethernet on the LAN side and an RTL8111 on the WAN (although any
adapter will work fine for this). I've found that downloading
something from the internet to a PC on the LAN while also running
iperf3 from the Pi to the same or another PC at the same time will
cause transmit queue timeouts and queue 1 locks up. Network
connectivity is lost and a reboot is needed to fix it. Doing only one
at a time is fine.

6.14.11-v8+ bcm2711_build
https://github.com/raspberrypi/linux/actions/runs/15676052461 is fine,
no timeouts.
6.15.3-v8+ bcm2711_build
https://github.com/raspberrypi/linux/actions/runs/15845884292 is
affected.

The same occurs when I backport the latest driver code (just
bcmgenet.c and bcmgenet.h IIRC) from kernel 6.16 to 6.12.

Jun 26 14:32:06 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 1: transmit queue 0 timed out 2004 ms
Jun 26 14:32:08 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 1: transmit queue 4 timed out 2004 ms
Jun 26 14:32:09 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 2: transmit queue 3 timed out 2004 ms
Jun 26 14:32:10 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 1: transmit queue 3 timed out 2892 ms
Jun 26 14:32:11 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 2: transmit queue 3 timed out 3884 ms
Jun 26 14:32:12 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 0: transmit queue 1 timed out 2208 ms
Jun 26 14:32:13 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 1: transmit queue 1 timed out 3232 ms
Jun 26 14:32:14 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 1: transmit queue 1 timed out 4224 ms
Jun 26 14:32:15 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 2: transmit queue 1 timed out 5216 ms
Jun 26 14:32:16 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 2: transmit queue 1 timed out 6208 ms
Jun 26 14:32:17 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 2: transmit queue 1 timed out 7200 ms
Jun 26 14:32:18 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 2: transmit queue 1 timed out 8224 ms
Jun 26 14:32:19 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 2: transmit queue 1 timed out 9216 ms
Jun 26 14:32:20 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 2: transmit queue 1 timed out 10208 ms
Jun 26 14:32:21 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 2: transmit queue 1 timed out 11200 ms
Jun 26 14:32:22 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 2: transmit queue 1 timed out 12224 ms
Jun 26 14:32:23 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 2: transmit queue 1 timed out 13216 ms
Jun 26 14:32:24 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 3: transmit queue 1 timed out 14208 ms
Jun 26 14:32:25 router.localnet kernel: bcmgenet fd580000.ethernet
lan0: NETDEV WATCHDOG: CPU: 1: transmit queue 1 timed out 15200 ms

Thanks,
Zak

