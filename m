Return-Path: <netdev+bounces-204857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD2FAFC4B9
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F977A6FB0
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 07:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7DE255F25;
	Tue,  8 Jul 2025 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF84yCMY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E133438385;
	Tue,  8 Jul 2025 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961278; cv=none; b=LyFef7BqZexB3M4pN2xqKAPc90SjI7DS8+jsDskebV/tU3Ww1KTJAj73wLUpAOWyd6DBqxkLqV5IBc7AGGPK2IMh94mhCI07OD0WcE8GQBtkFNpnx/JNnonqbvn8HUZvsKvxh4Jb8NLI2MJT1sT/EAlviST6GAY8FxOfxgzNRTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961278; c=relaxed/simple;
	bh=LcjjroJv6jUPN317HmzJPvVEqfeQXMCiRBvZixvv4rM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Sq5FF1iepxz+KGCO+ob5qcQ0nVWcCnGynWAEOTrnoFEW50dVjxN+sBEFqY1fZEuf2pJzEsfxpf2HpPejQKDT48emebt9rsCo5GJjVdLj/d35d6ni2uuEFHcvmhmHe4ub96dONQKejLz0PBzMlDL/8uUWcio5jjVSj68KuouaU8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZF84yCMY; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32e14cf205cso32777891fa.1;
        Tue, 08 Jul 2025 00:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751961275; x=1752566075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LcjjroJv6jUPN317HmzJPvVEqfeQXMCiRBvZixvv4rM=;
        b=ZF84yCMYvWCNQOzh8Vt0GWhPTlQRHU21D/M7QOHa14rgukAv9dgJm+LKc5gXwy1jwP
         xZk1OK5gwYqROjRrxaOFA4iNTadcF/LkPn74SvcM2mkphZDWKHKxEiW25zQH3gxRnxi4
         Zzzi220BcEwPGOVO9ee+js+QeDrPmSyvGA1atOikj+QGds6BiZ4m4RfXErWaxbfVJ9ZO
         uqzt5yCPPvt47J1xa+nT9ruio96oLtDghLwQ6UTIx9QzmecPPuZWqWX6NJ+Tt0a6qWDb
         WTVOo0OMbGOlOuHEBfNiQGywz8KelAPxL+oG4YagNR2Q8SI1wgk68s0wnDvuZ/ald7+a
         +62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751961275; x=1752566075;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LcjjroJv6jUPN317HmzJPvVEqfeQXMCiRBvZixvv4rM=;
        b=V/GXvKYFhWaw9VWNbkGoPRYu5tfaymFw4xrPGz3VqzwoC+APes0LVbbWAoOPZLYSW0
         10RNeCWg93wppPxcXL0fuPujnLJTn+wGEbYctBeWUB7FSmmakK0iXse6PIwYxFPNd+4j
         Sif0Z4oBfohkSbHYITRNOeYashxEY7OIg7clgqNq1BZbdpsGLgwH25FISGiRj1QZAo4x
         /EZPN4OtNGKcXZS4+LMC954EolXu/jAEeXY4i+bCMcRZDZ7ImjxCR+gggLW6f8i/quCc
         CT90QAMKwT70CMcNAFw+lNcY8yA8KHNCOWJyqvD0n2waiIeY1oMG2Kq8NyHw0sKvNEj+
         HSGw==
X-Forwarded-Encrypted: i=1; AJvYcCWW+lutmBYSkNEMdr17vUf/g1XEuScO8Ympp+ki+kANu0hZDEVPc3xez0+LSPGJvMOIKm6ufsa0k7NcysQ=@vger.kernel.org, AJvYcCXZnTPO09bf6ZwRa4sHEwLrU5qq3ehub8GqOYl/vONuYQ3Vr4OHbdU71uSCy1rOfy6Pgx7KFFyI@vger.kernel.org
X-Gm-Message-State: AOJu0YxfhtTfzqp7K2mfYC4zv1GDZ0ntnQ9t50WnW5ACT/qpBZ+AEJtz
	AsfgprSbw1ZL/pntecmzUDYKsxkkVwyy71/jPUhMHU4kJHnBT+jjTHEVjoaFKcZRIWtVE4ofc52
	1u95XNWV8F15/3DGduJR2Rk3bW1YHRN8=
X-Gm-Gg: ASbGncs1d1hQ5koBWFD8EjYlayR7JtqsH/dMahsdw2el9Ar4rXXizdjs4lLSEO37VoE
	gTA5LxhmxjgIbwKnqEA5RXNm0fU7hXIjVhQSP4rLYtDxm198rfD4JzUAV0jVn0iHUkhRTQvRikk
	Mkp8/cC8qJ9ib4iHFoLIA2mQPGJRV5DI44E8aaZYj266YNgrYn6fwy8c9fRa5elFHWeLB9Ya9Y/
	eHp
X-Google-Smtp-Source: AGHT+IFf5eBlfFpolAmGJlktxY/InjcvTzbi2Xrq5uZ+pCp8vPsNCDeoGS4qGiKBx1+49FmEG4H801rd+Cno8Ka72vk=
X-Received: by 2002:a05:651c:4093:b0:32a:8297:54e3 with SMTP id
 38308e7fff4ca-32e5f565509mr32071471fa.6.1751961274928; Tue, 08 Jul 2025
 00:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Tue, 8 Jul 2025 15:54:22 +0800
X-Gm-Features: Ac12FXzpe_0T1yBqD44q7eH33qC3hJW2DnJf5wQDwrUP6_f3yd8kOFQeyI2Sk9g
Message-ID: <CALm_T+2rdmwCYLZVw=gALPDufXB5R8=pX8P2jhgYE=_0PCJJ_Q@mail.gmail.com>
Subject: [Bug] soft lockup in neigh_timer_handler in Linux kernel v6.12
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.12.

Git Commit: adc218676eef25575469234709c2d87185ca223a (tag: v6.12)

Bug Location: neigh_timer_handler+0xc17/0xfe0 net/core/neighbour.c:1148

Bug report: https://pastebin.com/06NiBtXm

Entire kernel config: https://pastebin.com/MRWGr3nv

Root Cause Analysis:

A soft lockup occurs in the neighbor subsystem due to prolonged
execution within neigh_timer_handler(), where repeated neighbor entry
invalidation and associated routing operations (e.g.,
ipv4_link_failure() and arp_error_report()) lead to excessive CPU
occupation without yielding, triggering the kernel watchdog.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
Luka

