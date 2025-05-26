Return-Path: <netdev+bounces-193400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29E7AC3CA1
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 11:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0A63B6A23
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 09:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4EE1F150B;
	Mon, 26 May 2025 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNAnSRHx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B97B1F0E37;
	Mon, 26 May 2025 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748251460; cv=none; b=eQpn/yl5ciD+CGwrhgPussKpUu9FhyL+/GnH39olLue/fnGDlMaSwGPg92rPjw1NaodOuQhxggDUue7dzEtO1S/kvBAdtniVZNgSpuVSvW2ZaTZ9Ti2nHq3eU4rchYnqBrMGlVyOmZiW1cbv1mw7tQNOI31ZDudAQHb71OzVfJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748251460; c=relaxed/simple;
	bh=A5amcLkvnu1RLd90jrfN8mmXv/+Y2MgfVTSd0Uvqa90=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Wau3gT/iTi34cpxjBOxNuyA/Dz/Gt6uYVJQlXkn/0lBZeQIuLpfP+Q5Cp5whEjsPDkbxC8HafzIenSZ3HJXxSO3wgHD42G9imAS9S4ZZQ4QpNlMQ7AeaR/+SHYY9dtRNh0/DxfDFARnw4aSMNAFoFGYOcI6e2Ndp/doIpf2yk6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNAnSRHx; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3292aad800aso25578151fa.0;
        Mon, 26 May 2025 02:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748251456; x=1748856256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A5amcLkvnu1RLd90jrfN8mmXv/+Y2MgfVTSd0Uvqa90=;
        b=aNAnSRHx8l+WIeHoej8GRR2Hze0moP3FZL1DSr45zlhJLBm3EcFpYa/v3x8+/Klfp+
         4RoL/sLxa1XRmdlDgH7xMXHRAeR04p1IdL74rhcvabVuNgxyUGW41b4H+R2wLjI6zIIh
         pV69306z2nSDaoMzmd71/Uve4myBGNW9hZU2nl0prwBcOhfpTmoGO5dp+haea9LDSS2K
         3aqwEMq/ecxqvXUpsC813eWmCNuRRewdie6We6XgHU6RblIGB5FrK7Tl5JSFPo7ZnL6T
         wAZHX5xIR3qF7oRaT+zBOLsZq4iRT++5ypmuhmeqGIkAk1C+2M4oS9074A8Pyua3+w40
         fy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748251456; x=1748856256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5amcLkvnu1RLd90jrfN8mmXv/+Y2MgfVTSd0Uvqa90=;
        b=D2kkgoRummU0SEkZ+m5sFfAjYBoyc/1FH5DtpawlkZ82EJ9HwWtCSczYr2V+UNY52o
         htnEkquiY1tpqhmg7ski08IH0uy28pnZoSW3mohxNkjVtQyApIW0pRjg2qXrnVkf2ejy
         ypjgMXBWk75YF04oDOV9aDPywlxdDQhq+szTHOAwnomW2QOpk2+uXRq7VCgskbgjHPvB
         KZ7mhcIE43VnHlABuIVkHtkBEEw9hSr2ZH94/Rb/FRvLHdYyT8dDskwmeIS5JM/Hpf33
         v1aS9/LSmmumOtUMWY2xsJJ6ENYuDFhIn5hqNRcYyTalEJDT3g85zVp0YkU7nhNhcwg3
         q2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCW++KXhIOrjGM6k+5S2sDlvP9smnDyMvWKKG7jCejc2Npg+AMjjlUVwGGlW0GKG22DwVytsqPTb@vger.kernel.org, AJvYcCXMtd4lTqFfVspkVsK3gBgP/WntF91rQI0uGxtUAeLd14DLarIAWxakCBZ8s6v6MoSVfBfvuN+blzMNpT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU8M5p39/RTCIGqcsmqaOcHwcunnk9cQKtEJAI7PYWcImDbEdK
	QXz7GDVxt7eHetKrS4byUjztMsef7i2kMYEW9j4jMdoRwnpbKePJHRGUBZKUjHHFTIIpGdgvGVI
	RRAcOZoueovIy5M78IzxabzGa5Czm2A==
X-Gm-Gg: ASbGncu3iMjRsVuAQj4ddRSLpldBgJKkxmIpJCCSRIrI0qSQz9zbAPFzweYZyiwPhnv
	tjWHw6bNnRgiQsKkQXPynrt4HR+MX82lerLP6neiBMNFSSHKs9pVUqEJjhzZYIfjLZcTMkHxCZ1
	W+4dPtB+sbF1uvkI9fGPzervtOrQ4p1WA/uQ==
X-Google-Smtp-Source: AGHT+IE5zZ8qfTpEkvCI7UnpwpxifsJtBTwywq1hO+t6vxQcNfiSjwKH7vzZA70PAuRnYL02U9jhyl0R0USjLSNxUVQ=
X-Received: by 2002:a2e:be1a:0:b0:30c:12b8:fb97 with SMTP id
 38308e7fff4ca-3295b1fdbf8mr20450291fa.11.1748251456216; Mon, 26 May 2025
 02:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John <john.cs.hey@gmail.com>
Date: Mon, 26 May 2025 17:24:04 +0800
X-Gm-Features: AX0GCFtVoXxifTIpeV16GiT1rluEw1BGBZT9nsRJuz1DqHB4bXAhAAUGSbH6biQ
Message-ID: <CAP=Rh=OnQJ2O93GaJQdDXF9W6ft7sEA2QOY7ais8NAJaXH2V5Q@mail.gmail.com>
Subject: [Bug] "possible deadlock in rtnl_setlink" in Linux kernel v6.14
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.14.

Git Commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557 (tag: v6.14)

Bug Location: rtnl_setlink+0x32e/0x6f0 net/core/rtnetlink.c:3420

Bug report: https://hastebin.com/share/nohususeku.bash

Complete log: https://hastebin.com/share/fijazefoci.perl

Entire kernel config: https://hastebin.com/share/qonequpodu.ini

Root Cause Analysis:
The kernel lockdep subsystem issued a warning about a potential
circular locking dependency between rtnl_mutex and the
e1000_reset_task workqueue lock.
The warning was triggered during a rtnl_setlink() call, which holds
rtnl_mutex and later invokes flush_work() on the E1000 adapter=E2=80=99s
reset_task.
The problematic dependency arises because rtnl_mutex is held while
calling __flush_work(&adapter->reset_task), but the reset_task
workqueue handler (e1000_reset_task) can also acquire rtnl_mutex
internally.
This creates a cycle in lock ordering, where task A holds rtnl_mutex
and waits for work, while task B (the worker thread) holds the work
lock and tries to acquire rtnl_mutex.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
John

