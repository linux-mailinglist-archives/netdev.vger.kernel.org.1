Return-Path: <netdev+bounces-202345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE72AED763
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 10:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F913A5458
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 08:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9553917A2FC;
	Mon, 30 Jun 2025 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="1Kj6fQvB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CF11D6AA
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751272385; cv=none; b=b99VpL06QJoh1S8ZSi1GqRAAH4D7DUcWxe64ywPtCev73TUTvkdgT0cQhZYsEtvMKH/RUO+lEvR6p7fjpkXRlf/S1M2+QxKrE0aW5hLZKfDwW/yrVqgm7CasIgPDq3QnvfFJ+sam2G4x+IImPRAlNCL9ddFJH13bBcbtj7Ldckw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751272385; c=relaxed/simple;
	bh=I/52AuXRZNkY/G62Rr93bWOXOlIwyskrSQ0ogVexztk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:Content-Type; b=kRm6YH/VbeUf7Jkau51hq/pGj/kqAYM5nCOQ9H4+03avBZyy1Z/RufHk1LEbrY72lSO3tCGYXyCSXKBx64yZN+W7Ed90dr0cLOXza29aFIkoO07fy/cBr4HXwNGucRCRZbH2yYekPIDD38m6pXoUXQvz6AapWDx5E4hTLqfQ0+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=1Kj6fQvB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6097b404f58so7177945a12.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 01:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1751272382; x=1751877182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpyS8LE74rjVWypnTyY2H6hMEBjb9bnQNwFoy1XdUH4=;
        b=1Kj6fQvBJnx9Gy4SJey9njrq6UyVSk7SbTuZLN6WrzgIz5M02BcPIZXyFJx4WEAlOL
         w32ZH22iZb3iCotyPYQFXriOxXgmnO80SL1TD/+0DJt7mBKseG1os2msbaqnwInv5NW4
         RVpoqlRXg4XvrN7RK0T7qq5VRV/MqJiCvriLVmIb5nfKFkxGE4WrqxFovW+LXtAsLlEb
         ALUgMevHEaur8LrCIJp/DOV+zCckb7Cs2W38Tp4N+wc31xwiPSbpQpg1avDEnlGl1kyt
         iff2KIf/sOF1CcCJgN/7lmV+EOTH9STcHi272LxXUNFMXRWJZ1xeXVnStS2zV4jvcLY2
         6l2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751272382; x=1751877182;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpyS8LE74rjVWypnTyY2H6hMEBjb9bnQNwFoy1XdUH4=;
        b=RC3RUJ93mT7R6uC9Q+JShcHo0WrqWYqbmcDA8SkKASxXNQdFvsLWe7ZacHP4funXjh
         1TagE4sieTuN5701TvAGjzQqGAeTw3d4lKvJlgTSHnyJig6kqI+vPOGeZMCtP14BK2Rq
         9xo8gk0VnZJ/YMK1rUjgo8BRVLgYxl8kB2Eo8EYm8X7iCJuJhg37JaS8qeb3bgJYAbI8
         yW5ruDupLsaeHvm8N1T4vsjWU2xw+q/upCKQzUlYNhj3t0iP8D+9Bkpk372dDJBvQda7
         PQtAF5DTWFJRd47f0QOCr+ALNzZyJCuBAnJYn0ZzSj7UhQtHDT18IIDD90fn5rCAXG79
         5BjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUaHhkq3teVExRdvmt8vnhGpUQL4JFQsZ4PPsTiWYESS8j93IXBJqlR9XYyi5rRjL+grtSeh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYb8V1IW+PQyzu+dVHlypDetQNEZQt9EtBwwtzQIP3kzY8TUsN
	x/fakMu2OtV5a2mZbvHsClYYiOR0rLzUX1HbAZwzHBkczv+0linber10+e3zutsdVQ==
X-Gm-Gg: ASbGncshaCtGs626XoY4hvf0aExaHnPmO08c2CuMiIME7XKn1yyNdpi76HAQwofOE/n
	Yh+GYg+HGv3BwFPaNzEfrr+TBV63Ubk7BwbH0DiALINh120XTeSCbnNcFV2pRXZTW8hQd2m9ITS
	me+e9x2uYyF+jgKRPpq2G/k6GGdYFoeWFT/qN5OEife/S7P5fmEghggJE+7aHNtiODUgR/GQV9q
	FxbuGGlRFr6wlIxZ5/c1+t5luac9/SvdFDGSqcnKivMAmb3/GgwysYvUnk4niapK366WevdXc+j
	cJZacCvHFtO+H7z10XPVl1/2vIQ/Iu2GsW48Gcj0KY/yxTFoJ4Hoj6Qh1Y6yiNZQ
X-Google-Smtp-Source: AGHT+IEt6nK6ONEVCjiWWd2acis9X9s/bUWZV3VYUllsvHKoMSkoTMNF2l8dRHX2bk07NlBfVDF31g==
X-Received: by 2002:a17:906:7308:b0:ae0:ce90:4b6c with SMTP id a640c23a62f3a-ae3501a6b84mr1082075066b.49.1751272381452;
        Mon, 30 Jun 2025 01:33:01 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae36327ce4asm551563766b.163.2025.06.30.01.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 01:33:01 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <3fb71ecc-9096-4496-9152-f43b8721d937@jacekk.info>
Date: Mon, 30 Jun 2025 10:33:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 0/2] e1000e: disregard NVM checksums for known-bad cases on
 Tiger Lake
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As described by Vitaly Lifshits:

> Starting from Tiger Lake, LAN NVM is locked for writes by SW, so the
> driver cannot perform checksum validation and correction. This means
> that all NVM images must leave the factory with correct checksum and
> checksum valid bit set.


There are two issues we have found so far on some Tiger Lake systems:

1. Checksum valid bit unset in NVM

Some Dell laptops, i.e. Latitude 5420, have a valid bit unset and
incorrect checksum over NVM contents.

2. Checksum word in NVM is uninitialized (0xFFFF)

Other Dell system, Optiplex 5090 Micro, has a valid bit set while
a checksum word contains 0xFFFF ("empty"/uninitialized value).


Both issues result in the driver refusing to work with error:

> e1000e 0000:XX:XX.X: The NVM Checksum Is Not Valid

The network card is rendered unusable.


Patches work around those problems by ignoring NVM checksum when those
exact error conditions are detected on TGP-based systems.


v1 -> v2: work around issue #2
v2 -> v3: fix wrong comparison in workaround for #2, drop u16 cast
v3 -> v4: rename constant, reformat files, update commit description

Jacek Kowalski (2):
  e1000e: disregard NVM checksum on tgp when valid checksum bit is not
    set
  e1000e: ignore uninitialized checksum word on tgp

 drivers/net/ethernet/intel/e1000e/defines.h | 3 +++
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 ++
 drivers/net/ethernet/intel/e1000e/nvm.c     | 6 ++++++
 3 files changed, 11 insertions(+)

-- 
2.47.2


