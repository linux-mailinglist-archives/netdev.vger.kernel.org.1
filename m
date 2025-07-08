Return-Path: <netdev+bounces-204858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C67AFC4D9
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DEC17F9EB
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 07:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1581629ACEE;
	Tue,  8 Jul 2025 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9jL9lcG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB4429ACE0;
	Tue,  8 Jul 2025 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961503; cv=none; b=WIKaXGAYYaYWAGqDCKw1euHc4p0yWoIEPwEerdjCcK4hrMXcVYn/BDF2/PmBTvWVXCvUIV7rfI12kzxGN0Qad2k7SBohNnDMVnjPpfaPhcq66qL6LVHVEIwlTMU+aR8TaDmwI0Dzxj/XSMLyHfAk09C7B8GD5sFKjSqxlVEt8hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961503; c=relaxed/simple;
	bh=h1iuGjv3UbXMjMFgoLLbVZ5QxGKoSLsQtRcriFFqXJg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Gkk6LDd4tvInWUV1UT7i5zqr64sJEnGCK8USxRi1upf31JieG1s3KM1MPLiaT7NN0WISZ1E86zK2ASU7HHitmn3DQPU/Nyj/3qRpg93PPFGGmTX4hgPEa3qKyaHMhE8ssNPv8JFKHq9kwqwCbMSLAe/F+7tuPjpkTsDq1XDT7QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9jL9lcG; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b7f41d3e6so48421881fa.1;
        Tue, 08 Jul 2025 00:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751961499; x=1752566299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h1iuGjv3UbXMjMFgoLLbVZ5QxGKoSLsQtRcriFFqXJg=;
        b=g9jL9lcGo2fkST1d3t1weg26RfcJyN5YvSFPKAqwkeot1mqtpeZGMBU50e6fA4Irap
         /epfdmgg4m+T3aw9ytcm5h3EYuvntOYPZ7c4cLRbpV3y9lThFItqMAjfJqeUU11vYkYk
         4j7nmFmN4UCB+BZDR1g4KEhSVRDDtNqM1yrT2rTliDB9ION5MZyh2beMd55jboN0ilNu
         MhU3a6xDYNzcbX22WrtNMtLOVCIqL4J//Bl0z8l7kgfdaNtY3ChMINbUKiTZwUcgylNc
         FMB91pxJt0JE1gbnojpPttnmrbu/PAt00Zqac3e12qYFgqJsnUeguZ+VH6rutLOyjK/l
         B5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751961499; x=1752566299;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1iuGjv3UbXMjMFgoLLbVZ5QxGKoSLsQtRcriFFqXJg=;
        b=Yx7yylEK7AYhIcD46ZxYTgL4bvlklKKytFGclHC6SEyElYhsiXBP75crOQxRwKOak6
         K+s2jo4lvhm4TJVLJaAGiPBVcyEYI/mkGOwo6b3hXtEtkXeTvMLTZ8BcCbDJdnasVfti
         PAA1SlWYAhXSksNiZxDNzmuY7JJHvbahXUra3OYJQ9/2ZoIj8RgY4O3k4bHk2usWPYyQ
         B9BSv8+WVRsd1ODbU6KntHZaT/xeKGYxJ96OtF02ZzKUKrGPIFrCPfWbpYKjRkwWzRZz
         erbeZWJw4wgOwSxwaartv21V/NttZHpF7caB34vNleoF5OEqof78jkUcJVP1CMtGQDvB
         aNLw==
X-Forwarded-Encrypted: i=1; AJvYcCW+HcILIr1XJVJj3IrnFo788nz0PRAHr87UmrpxwiABxKkDwyaK8yNTGaEpqnpHem7CROepyA0r@vger.kernel.org, AJvYcCWfIZtUJe8vjG2UBQrkXDUVRkjnffGnYFalmT2AQOv2Ut6tmVzWy+Q+EyPApksxP9/qpqTLcymBywHOwg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeaurpRG+wJO8+5B9L1uHhKTiV7gTaEFGreEwk40ghRUZ0kRlh
	L3huJEc9G5cVhnu/DI4DP7+4/3KT8FzJYalZNX38vrRRnENP0K27W+nNKGJog7mECF2NwXp01v/
	I4y2Ch1kptWj24twE3IKg2aIoyPxKJrA=
X-Gm-Gg: ASbGnctauk+sBwe1GsKNcrgKpM9lqth6dlBfSj2g5JOM6g5pishGDQmxQdULcbUD2rE
	Qds53GLspIIPvnk73w7nQkYQXIbcNXSt1OYwO2VayMP7/exRCFaycTIvxWHCe3If/XYeoNvEZPO
	V7JavWGmtWPtTJVjZ0t3XXp1MiBJxjZuXK1qroxFuci1VkKWjEQFukHhEsOdVoDEoltQ==
X-Google-Smtp-Source: AGHT+IEtoXpmkf9iZQV6tBXZF6qwYD72aKqyosImMmeqKEpeK7e3jy4rDmc1wEWR+39tq6mOBnnUMFzjMgK6cIVDagY=
X-Received: by 2002:a05:651c:3254:20b0:32a:82d7:6d63 with SMTP id
 38308e7fff4ca-32f3a083069mr3643871fa.12.1751961499296; Tue, 08 Jul 2025
 00:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Tue, 8 Jul 2025 15:58:06 +0800
X-Gm-Features: Ac12FXxFWdc0-K4TzKRh2bgjw4KDhDQdm_dKlQ0d-dr_d101Ozv0Jva16llqQic
Message-ID: <CALm_T+3Fxe4tiKiV9RpWyOpchgb6588d4qvgHn6qmDE5aMwKjg@mail.gmail.com>
Subject: [Bug] soft lockup in __sk_free in Linux kernel v6.13
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.13.

Git Commit: ffd294d346d185b70e28b1a28abe367bbfe53c04 (tag: v6.13)

Bug Location: __sk_free+0x1a9/0x4b0 net/core/sock.c:2322

Bug report: https://pastebin.com/0T4EFSse

Entire kernel config: https://pastebin.com/LepsHYGb

Root Cause Analysis:

A soft lockup is triggered during socket deallocation due to prolonged
execution in __sk_free(), where the destruction of socket-related
resources under heavy task context and scheduler pressure leads to
excessive CPU time consumption without preemption, ultimately stalling
the CPU and activating the watchdog.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
Luka

