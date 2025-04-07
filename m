Return-Path: <netdev+bounces-179935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696ECA7EF43
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04D216FCFA
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C9821ABBC;
	Mon,  7 Apr 2025 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bS2USaNA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D2C19B3EE
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744057462; cv=none; b=KqrPDX5JF0VMXfifSlE72YuZCuUmuhamoZyTuXLA3mZOCvzdCYzM0LCZA3t1PRbawJQAfKMk5IN/7vaCVYI8g57SCJyx49uH9Js0m0JwZxq+/HFumXRjQtM4tQfk5EVdlT68PQpK3HBWVr00mhQfa+8XKHsi15GEjQ8r/MvwIBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744057462; c=relaxed/simple;
	bh=V8/I1ZJF5JD5exMnLRUcR3dYWCa639h+Euu5atuF2Q4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O64mFD2/M5RzJ0Ij5OBZwEZwZYTDHSJcZE0uBxE95xSbj+ZElNs3/GoWsjljvtlTK+wgKygrMLK2AWdXGny6RyxdNct1q7DOlmo1W3DM/TfJO4T2vAWuda4Bw+4uw3tXbRi3YQGFsId4GZPtPytK/laM7AAnZQtZ+pXWALY0Ads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bS2USaNA; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-739731a2c25so3318389b3a.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 13:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744057460; x=1744662260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GfJMmuI7SYBKs0i4Uo8AwabODwd6qTW67G2m4TM8zos=;
        b=bS2USaNAtyCzysui36ClCzxcwuy7UKPiu6xZuyteR0JA83KWsmxRJIbzDcpSDoBCBE
         2+dBO4lpFBxeCr/qgeoO9FTr+9CxFEDeaN9FglQwVXvmm7W3DrxPjD+CCOKTtYzIegmH
         tM/lNrr7u1I7TJrTzzZBSAHVzd8MJmC/3AYUMOPlK80f9H+zN1mY6pbHdBUdlEQ/Of+V
         5MCHdpbhLKledYcRAsd2+fUbMh4clnVXZf6gWlT1w8naNmviGWeUspwFR8E17+iNtRH6
         ie4WiZHM9ghq0WG15/psrms4CKSibx3d56hGlk+9BWh0gnQ21EWmpzCt3a4q/MBOTn9o
         +wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744057460; x=1744662260;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GfJMmuI7SYBKs0i4Uo8AwabODwd6qTW67G2m4TM8zos=;
        b=mHYwHUExFLcgbJYoZXxXPydjMbyLvoD6MRweejC8TaOOjc+3nj+di5qJFhUncAXdif
         l6MjsFM6N4Dcs4VV9tfipOOAFfISFD7tAa1/IDETIyQO53a2o9qQCfKDoFmTWTnysiAN
         meGdwjrtTQIRQgrs1uqcp6mD3O54JpR277ACPOgOK5NVRXkotK4V2b7DrBjm/0NQxvf5
         faC+tVd9eSbTH2D9YrP0r7fGjN0KC7kznbZHq3Vy8dW7oubIKYrGrtoOk5J6hO3/Wok2
         qTgk34T2dXkbi23/gjZRRzvJJ9ZfH9L+BD522Y028vo3qu89eZycIvtIjAwysygcwyqH
         iXew==
X-Forwarded-Encrypted: i=1; AJvYcCXuvzArRm/blwG+ppSp7OvYdObaM+Et1IGVaUxkTV8otHJ9dHjlTxa0oMMpdRSPj23Z8LtoGTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDULI2B5WK34a8KG7upqBA/Usp+O3FTXXIGAuQokX6rpX0Vmxj
	w5ogoUkLH6lLGF/CedElrct0T4NYuU5Yu0KHRSmsX4CQHlke0L/LwF8QoM5NAfR5FnoME84jog=
	=
X-Google-Smtp-Source: AGHT+IGEVQUuRVl5/CLjgx82B8y9cwASrxwIRNXmWCdDSKgDIq7ks7Qf6RDqwI4o1x1BplOK1MH8c3DviQ==
X-Received: from pfoi21.prod.google.com ([2002:aa7:87d5:0:b0:732:6c92:3f75])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1411:b0:730:927c:d451
 with SMTP id d2e1a72fcca58-739e4c0ccc3mr19838635b3a.20.1744057460570; Mon, 07
 Apr 2025 13:24:20 -0700 (PDT)
Date: Mon,  7 Apr 2025 13:24:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407202409.4036738-1-tavip@google.com>
Subject: [PATCH net v3 0/3] net_sched: sch_sfq: reject a derived limit of 1
From: Octavian Purdila <tavip@google.com>
To: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

Because sfq parameters can influence each other there can be
situations where although the user sets a limit of 2 it can be lowered
to 1:

$ tc qdisc add dev dummy0 handle 1: root sfq limit 2 flows 1 depth 1
$ tc qdisc show dev dummy0
qdisc sfq 1: dev dummy0 root refcnt 2 limit 1p quantum 1514b depth 1 divisor 1024

$ tc qdisc add dev dummy0 handle 1: root sfq limit 2 flows 10 depth 1 divisor 1
$ tc qdisc show dev dummy0
qdisc sfq 2: root refcnt 2 limit 1p quantum 1514b depth 1 divisor 1

As a limit of 1 is invalid, this patch series moves the limit
validation to after all configuration changes have been done. To do
so, the configuration is done in a temporary work area then applied to
the internal state.

The patch series also adds new test cases.

v3:
 - remove a couple of unnecessary comments
 - rearrange local variables to use reverse Christmas tree style
   declaration order

v2: https://lore.kernel.org/all/20250402162750.1671155-1-tavip@google.com/
 - remove tmp struct and directly use local variables

v1: https://lore.kernel.org/all/20250328201634.3876474-1-tavip@google.com/

Octavian Purdila (3):
  net_sched: sch_sfq: use a temporary work area for validating
    configuration
  net_sched: sch_sfq: move the limit validation
  selftests/tc-testing: sfq: check that a derived limit of 1 is rejected

 net/sched/sch_sfq.c                           | 66 ++++++++++++++-----
 .../tc-testing/tc-tests/qdiscs/sfq.json       | 36 ++++++++++
 2 files changed, 86 insertions(+), 16 deletions(-)

-- 
2.49.0.504.g3bcea36a83-goog


