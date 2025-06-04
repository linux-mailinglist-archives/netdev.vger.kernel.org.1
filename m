Return-Path: <netdev+bounces-195004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AD7ACD6C7
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 06:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056D217989B
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 04:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3882423815F;
	Wed,  4 Jun 2025 04:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6pVgtTC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA1079CD;
	Wed,  4 Jun 2025 04:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749010169; cv=none; b=mXKs87gd5Yl0gttlqzWC28Cl9t33CsMH9c22ifst8ZheZCnz8fjGzZd1bierNLbxLLxN0TQkBcKtgxoCh8pMgJpQqcYALnIkWmCtohfzMLkxtVeWCd57aBORGGW+ilAMXWvIzVUtvqgabJLx2hIAsH4Vit9jWRu68xxY+xL8/wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749010169; c=relaxed/simple;
	bh=2/YFNC/jk47tx7SqyCaNcTGaW1v9hrr0ZhmxiLDk4IE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lmwjC0lyueSkXDYgSS6O81sVEiRgoYLTXKkScNxSy0ml0NpPFO+0clst7rZVhSjpIhfGqV4zqnahhmto8KFhPLSSyUcothTO/rsQ1wLLZwiQO48rbZcnTcb7fkzzqy+bCKEoX8rkjri+30wA6ETX3HO6Y547WNvCjMTXgnF26Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6pVgtTC; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3105ef2a08dso52700871fa.0;
        Tue, 03 Jun 2025 21:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749010166; x=1749614966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BjxjoBh5mEnviEwlFUKxBIqZ+w5uVC8kt2sr+b29Zv4=;
        b=M6pVgtTC6hmvx9KbmvE2xQ5mEFuOHJsH4p3VZmJTDrHQhfhFobMn+uhmqUTO1kP4BO
         G2npfQGmBmUqMLWztWSFL9QFQ4yotHrAWcmATxbaHGdqksvbK7T/f15AaWoKmO+uNf1t
         4UE971gt8ov6tG3RXzKwa/axQpGkWCveKntHu42o/jdFKQ0clt6JLmhXBRlpZyMsBnud
         2GcFTN7y56vAoOkaXAscfNNLxthlT/+0kxKYOqxq4u+b6TmFj58B3cGhmK/Lu37LYnH9
         BDV9q93rbUIPnSNRtVJz1MjNWbgTrMH/P1msOpik8G1LV69raMmjyZGvuXoH0acAkYUK
         4j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749010166; x=1749614966;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BjxjoBh5mEnviEwlFUKxBIqZ+w5uVC8kt2sr+b29Zv4=;
        b=NjDiSp2X6ZHg5OYL/xtXuoYrQo8lTxJux9PoGLmVSVpGx14t0v2UUSxy2hNBNVdNps
         YgI0IvC1rf746ar2REPY8/d63cxh8z/PgogA2Yt0rnc7YK+qfam/Pt0uyAxkTIXSeHh2
         IuR2/LaFnbfdq1yIBNVt5LeOfASjkqvNnMHjCHqXM1nnkzYnQPEbKif/F3H0u0cctmZP
         4oym32TAK5C9nGx1usCnPECRX8xdDIrm1Ts/bnlmK/YyiPXNs4AbZlqz134QpAhpEUVe
         cH4Eca3Qcv7/ZK1GJwADB3hGZFNm/xsPuhfJ68LKj2U3Moz2hT35vG/rUIh3TFdB5wCe
         hhOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHhiU+Y53ltaS8ffrlxZJG6k6dneTHOs4mQLvu2GkVnSvWDhf05OGU+zvvNJrvmvKoRRFE29gMP+Jt1f4=@vger.kernel.org, AJvYcCV3e2QT0yb9/IhpBlgT5LzL5C5TAk3HU+v61ul4FyGCSAHKue16/7hZfRRs1vMrVGCpcE5ED7RI@vger.kernel.org
X-Gm-Message-State: AOJu0YyjF9SyNCROdnTaluh+7mGVclx19LB0DZzpkRr9ZMPq0IJS9wHk
	WDQZAhKI6dWvSoGAGE/3SSJfBXDxRLdoFr/ibKMvi0FGOQzzFFHRb75AKNKtQN27ciR9mE9eiI0
	o5TfHRBOZHVIUibfTEbvTzmmY81yK9gg=
X-Gm-Gg: ASbGncs9QqEj/VkwcA6hAHeOTthPurINAI1naZ/whVpyxm/A5FnDTo/Ih0WDUuEz6OX
	QlAdoCnSWbYNidA305+JAQGZ4yK4KTXcQQkmzIx5FhFJqThZzeZuHJTwXiCuE4HP4RRWH0ToXyD
	eVPwuharCNnePpAS6fYLRu5qFaFTl0pQ85lZh9k7qH0JR82w==
X-Google-Smtp-Source: AGHT+IH6rrAqUQnEtG2z3eAW+kJco5Iy6BdAdeJ6ut/+9Jks/OD8XvT+0K/DThWSsnqUZhTuAszUtv/L25TXuOALiUg=
X-Received: by 2002:a2e:bc24:0:b0:32a:7e4c:e915 with SMTP id
 38308e7fff4ca-32ac7267453mr3758421fa.29.1749010165279; Tue, 03 Jun 2025
 21:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Wed, 4 Jun 2025 12:09:13 +0800
X-Gm-Features: AX0GCFs7QTrUdeEp-Aa3e1TxVh3ak-t_cXS8oq4lhLDJQFkCAf5wGqWxTuiC0RM
Message-ID: <CALm_T+01euHRJ-G-_jvQx6M5rDEULOW+PYx1GTAH79XKiVsF0g@mail.gmail.com>
Subject: [BUG] rcu detected stall in wg_packet_encrypt_worker in Linux v6.12
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Kernel Maintainers,

I am writing to report a potential vulnerability identified in the
upstream Linux Kernel version v6.12, corresponding to the following
commit in the mainline repository:

Git Commit:  adc218676eef25575469234709c2d87185ca223a (tag: v6.12)

This issue was discovered during the testing of the Android 16 AOSP
kernel, which is based on Linux kernel version 6.12, specifically from
the AOSP kernel branch:

AOSP kernel branch: android16-6.12
Manifest path: kernel/common.git
Source URL:  https://android.googlesource.com/kernel/common/+/refs/heads/android16-6.12

Although this kernel branch is used in Android 16 development, its
base is aligned with the upstream Linux v6.12 release. I observed this
issue while conducting stability and fuzzing tests on the Android 16
platform and identified that the root cause lies in the upstream
codebase.


Bug Location: wg_packet_encrypt_worker+0x278/0x1064
drivers/net/wireguard/send.c:297

Bug Report: https://hastebin.com/share/tuyiwegowi.php

Entire Log: https://hastebin.com/share/nubazamaca.perl


Thank you very much for your time and attention. I sincerely apologize
that I am currently unable to provide a reproducer for this issue.
However, I am actively working on reproducing the problem, and I will
make sure to share any findings or reproducing steps with you as soon
as they are available.

I greatly appreciate your efforts in maintaining the Linux kernel and
your attention to this matter.

Best regards,
Luka

