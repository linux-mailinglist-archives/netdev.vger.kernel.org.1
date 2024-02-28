Return-Path: <netdev+bounces-75562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBA186A878
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 07:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE9D1F24E2B
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 06:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AA922EE8;
	Wed, 28 Feb 2024 06:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eYIqAprp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9CB21370
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709102620; cv=none; b=n/KR0wjI5ESfP2Oc3YqVyo/PJOielI1fjGFjhCL1pkfxLoCKJ3JLnfiAwmOefzDm8pj3mTvD8xagiXosEd+cbOCdhsyjz6CRPa+qYtmX2LQKBsLyM+ajdGJtI++TAHECP4Dw9UQiYo0lJ4VS5AueCnN8KSrbC5jZ9iHilnL72WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709102620; c=relaxed/simple;
	bh=LM+OsxCppsJ6vH6sdJRPnnLwwS2Ds6CfVd62BHFGpNA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rqQ5AoFn6ARbjVkRY4owp1+sgh3HUSB/m3eYKD5RYaDtoQtmuvFodMZglSNI5jeNaXNQpfvL9fMeK1hXUU3lcIg+xq3uP1pV/3eGkpc59bsVMOBDI8twtHF789u/F5Fvlwjp3YKBs2pJnq87G60GUN7jAg17PCfooqp+wyVTcig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eYIqAprp; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d8b276979aso3977819a12.2
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709102618; x=1709707418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W37pxQOj7sbIyu7CJO+URF/XloPZZvMA9cXiDnGo9tE=;
        b=eYIqAprpTZE0V6C0gXzkpK8BhkLlmgoXHu5jRfh9+2PJKIudDxHlJiHvN5EB/6saur
         achkj+PCk+/02eEgatTZndkwRfxYig9rRRIIZMM5UqwBgoFsOeyEjOisSWKVhuJI1lMP
         +x2RUd0FrXcnLcVrd7439Lr11uIrgUueDRhhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709102618; x=1709707418;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W37pxQOj7sbIyu7CJO+URF/XloPZZvMA9cXiDnGo9tE=;
        b=U6LsDARR1HUCzftM5lcFFGB6XzZrgVQLWLGSYfbN5VrjhQpwA0QVE0jPwNTYwNnwAf
         /bPis38OpaCXqjs0YGys1j6JtpUYXM72s54F5uMBS5VStJTYCRA9r9VgOl7Dl9+dIxLP
         4z/gi2NV2OejMj5oJfNaM7p8RRBbovDkJff4kyvO1L46OhjI1geLokMIQ5rWzqSqgdbx
         hXxXvq68ViYW7qNbXcR0U8RI6dqJiTL0F8tP2D6zZCjRNf540xhuljfD6bIeANb+x7kN
         AkUDkVEKEZnXOeAFktRyyUTE2lp72xdPKFoe/GT4j+n4NNyKlKvZ2yssIcc6hEklPJFt
         4w3w==
X-Forwarded-Encrypted: i=1; AJvYcCXOXcDi4UiBat114TZXE49MNyAdE4+mFwkYNLQKmV90O3J/UpSO0o2QSarNcjB65QVMwDuNB6q+Wf0le55nxyjxjHu36t7x
X-Gm-Message-State: AOJu0Yxw9X3vL8xwtKiCvuBqkJBh02a4+dLRpc3NN435vTxVCIz4aYOa
	+D5Iby8sDQSsbeBTXVZNRGobM/DMf+JI9Uoi1/dIbpjr9qv28OSK4BF+0PRcP/Fs5BSgfjDtOhn
	Hz02Lc8PQxPw2HCQdzSEhbwS8SYMw+J/VpDNV4c6WHdMrFFRFJMASE3nk/oOdWRvPigabSQLFZu
	+oXuOfXY9r14DdKlJIXQ==
X-Google-Smtp-Source: AGHT+IFiAFQF0tsosZziRXvjhFNgZTGoEsb3uhNiMXK7LDGGnE1BLYnqExv8d6Odjw5vZ23ToTxyjpgPL4Un3Whvc2Q=
X-Received: by 2002:a17:90a:4209:b0:299:1777:134c with SMTP id
 o9-20020a17090a420900b002991777134cmr9222310pjg.33.1709102618037; Tue, 27 Feb
 2024 22:43:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Abdul Anshad Azeez <abdul-anshad.azeez@broadcom.com>
Date: Wed, 28 Feb 2024 12:13:27 +0530
Message-ID: <CALkn8kLOozs5UO52SQa9PR-CiKx_mqW8VF9US94qN+ixyqnkdQ@mail.gmail.com>
Subject: Network performance regression in Linux kernel 6.6 for small socket
 size test cases
To: edumazet@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, corbet@lwn.net, dsahern@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Boon Ang <boon.ang@broadcom.com>, John Savanyo <john.savanyo@broadcom.com>, 
	Peter Jonasson <peter.jonasson@broadcom.com>, Rajender M <rajender.m@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

During performance regression workload execution of the Linux
kernel we observed up to 30% performance decrease in a specific networking
workload on the 6.6 kernel compared to 6.5 (details below). The regression is
reproducible in both Linux VMs running on ESXi and bare metal Linux.

Workload details:

Benchmark - Netperf TCP_STREAM
Socket buffer size - 8K
Message size - 256B
MTU - 1500B
Socket option - TCP_NODELAY
# of STREAMs - 32
Direction - Uni-Directional Receive
Duration - 60 Seconds
NIC - Mellanox Technologies ConnectX-6 Dx EN 100G
Server Config - Intel(R) Xeon(R) Gold 6348 CPU @ 2.60GHz & 512G Memory

Bisect between 6.5 and 6.6 kernel concluded that this regression originated
from the below commit:

commit - dfa2f0483360d4d6f2324405464c9f281156bd87 (tcp: get rid of
sysctl_tcp_adv_win_scale)
Author - Eric Dumazet <edumazet@google.com>
Link -
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=
dfa2f0483360d4d6f2324405464c9f281156bd87

Performance data for (Linux VM on ESXi):
Test case - TCP_STREAM_RECV Throughput in Gbps
(for different socket buffer sizes and with constant message size - 256B):

Socket buffer size - [LK6.5 vs LK6.6]
8K - [8.4 vs 5.9 Gbps]
16K - [13.4 vs 10.6 Gbps]
32K - [19.1 vs 16.3 Gbps]
64K - [19.6 vs 19.7 Gbps]
Autotune - [19.7 vs 19.6 Gbps]

From the above performance data, we can infer that:
* Regression is specific to lower fixed socket buffer sizes (8K, 16K & 32K).
* Increasing the socket buffer size gradually decreases the throughput impact.
* Performance is equal for higher fixed socket size (64K) and Autotune socket
tests.

We would like to know if there are any opportunities for optimization in
the test cases with small socket sizes.

Abdul Anshad Azeez
Performance Engineering
Broadcom Inc.

-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

