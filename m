Return-Path: <netdev+bounces-176531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C829A6AAF4
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E22318859F6
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B4221D5B0;
	Thu, 20 Mar 2025 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=avride-ai.20230601.gappssmtp.com header.i=@avride-ai.20230601.gappssmtp.com header.b="Z96tCWwg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B451EE035
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487717; cv=none; b=kM2KbXqvmQtcDJMF44KntEJPkyeu2k8HyX5H+oXBaUcFghsDp1OUO9dwlk68Bwg1QbSiQF5t70isHWc3uelkmlTeedG2lxkdkQQXveQ4Wmnf8Sy/k5dIkIty0o844G2NmlNhBwBrfBSwnQTMZQfOhgDqW7Dw9GUttzuPLPtwNhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487717; c=relaxed/simple;
	bh=p8LyDmgqzEDannv7f+gsDTDfaHcnYVeESBD6JdTUnKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJ8c6AuagW7aZbdIHr2Ecrz3cho6ourr3bmh3ys6d0RaCLOaVkK/RIknXC/tVAha3c0TS1JNGGdB5jADMJ8FQ/uiEA26/uSaZFzZmcuZ3Dbt1/DyEsp2BWKDzcat2TIEYQyfa0ke7bWtBylLI/O8TdNg51X/azLAgi1J5cPboKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avride.ai; spf=none smtp.mailfrom=avride.ai; dkim=pass (2048-bit key) header.d=avride-ai.20230601.gappssmtp.com header.i=@avride-ai.20230601.gappssmtp.com header.b=Z96tCWwg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avride.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=avride.ai
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so1791524a12.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 09:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=avride-ai.20230601.gappssmtp.com; s=20230601; t=1742487714; x=1743092514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5tYXZFdDi8NRvBgGzlFquPzq73p+Oxb/2573EY/J83Y=;
        b=Z96tCWwgkLuHlGIyPiKS7fzXMNL2JEQcLIi8+zLyCV3oeGT8dG/sWz9dTd5c1/TQFH
         9ARmqQE57B0NeIOyDvQjiDuz4eBx0f/s9e28KcUkIKN1g9la6IKa6z+6hSXviSE1SFgD
         w1+hRiEprke9bBDogHh94sBBfnZnBO2DoI/9t3g0q2M5xIrcMxrHmoH3dNGcDr/OrLz5
         Rmyc5xPfX8h8w3RtEhEVT2is4Yw7X4aZaDVfgY6AqfLvk/HgLaIOGjfqv/5eWJLtqQML
         HYlnMXIR9mSZt5cTut1QCYJvBw+Adr8niuoe4IX5qzcDFjgdjThuWM7eQZT0uUG1CG1i
         fJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742487714; x=1743092514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tYXZFdDi8NRvBgGzlFquPzq73p+Oxb/2573EY/J83Y=;
        b=rMOuRBzU1guekmNdAomlJ84bt/X6cBiPhB2HbHZabcCRSsQt3pOdSKIHfNoguG/ftU
         nwux7BaS6HTrMSGIo3GcArrsnran4RL90oYCDsL7av22sep4S22v7XJXCy6G0MKo9Dgf
         SYqRwgFHwdwk1I0a5W814J6mILBCh0xZ4OGAasKQGAQ2VLB9OH+vtAga8qx7z3lm4va9
         CEJ9Cdrm8c+jLrdK0Urqm7MHODvvXLBTZR/E7MgxRBhzp8EMEo9xudXGR0c6gLw/oN6q
         KDVBGUBBtRXhJWN+mN4JKz7jl9yD+WTQOnTJI03594ZZCblsn31T+s5qx6iLIRexX+NG
         PEPw==
X-Gm-Message-State: AOJu0YyMnCTc6ZKaY1LuERGrHCYUiUdoQHpR6EMKe1ylXP2qvYv5QlJY
	sBUmbfVe176gzLiYJfLfFtgLWzU04inxwPwBNBfSkhl62eCKQ/wbsEZ+TsY6Hp6ZC1+S1MaxY4+
	NQwKLN3HUCyspmr8U3SX4TxYQQQf/CRRYjeAD1Q==
X-Gm-Gg: ASbGnct+NznVoFLax0jbp5NDb682T0pWKO6LjqEAdqiOTxL8P6cwMWbi3PkCYz6TiIO
	z9lGhxKG970do0N2sb9wHabrA/I0FlMHgx2nyZ66UmX+Q5hUrt8xs9qeKDA5alhXYxikoZGLllL
	Z34sWpFpfrDQz3vxu3vIa/x0U3sw/74vSV+NiJfX3cnXYnr4gSUy+tj+ME
X-Google-Smtp-Source: AGHT+IHvsphPUygP5q4+bf4z9XcOUXnuqcPIg6QZZmBc6kHBCohYRjLTwXKmMibh6g6meeMzVgNyA4w3xojfCGBF/k0=
X-Received: by 2002:a05:6402:524a:b0:5e6:e842:f9d2 with SMTP id
 4fb4d7f45d1cf-5eb80fcde4amr6944155a12.29.1742487714224; Thu, 20 Mar 2025
 09:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai> <CALs4sv3DtyBSqx0v_FHFUPrB+w7GOsheNOEa0pm6N4xNf-4JUA@mail.gmail.com>
In-Reply-To: <CALs4sv3DtyBSqx0v_FHFUPrB+w7GOsheNOEa0pm6N4xNf-4JUA@mail.gmail.com>
From: Kamil Zaripov <zaripov-kamil@avride.ai>
Date: Thu, 20 Mar 2025 18:21:43 +0200
X-Gm-Features: AQ5f1JqWmzJJzxLwuSB2m1YSHS0ON3ueDGu1UQr5DkEWKI4NCDQawaHPSNHqqgM
Message-ID: <CAGtf3iaH3+QQBvU2Po3DMCGd2tUeYzqhHR-SGBbH8_1u1LRAmw@mail.gmail.com>
Subject: Re: bnxt_en: Incorrect tx timestamp report
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Andrew Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

> It's not clear to me if you are facing this issue when the PHC is
> shared between multiple hosts or if you are running a single host NIC.

I think that BCM57502 works in single host mode but I'm not sure: it
is ADLINK's Ampere Altra Developer Platform and maybe BMC can see this
NIC as well. But all actions over PHC are performed from CPU only.

> In the cases where a PHC is shared across multiple hosts, the driver
> identifies such a configuration and switches to non-real time PHC
> access mode.

Is it possible to understand in which access mode the driver works with PHC?

> https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/drivers/net/ethernet/broadcom/bnxt?id=85036aee1938d65da4be6ae1bc7e5e7e30b567b9
> If you are using a configuration like the multi host, can you please
> make sure you have this patch?

We are using upstream Linux v6.6.39 which includes
85036aee1938d65da4be6ae1bc7e5e7e30b567b9 commit.


> Let me know if you are not in the multi-host config. Do post the
> ethtool -i output to help know the firmware version.

Here is output of this command for the first port of this NIC:

    $ ethtool -i enP2s1f0np0
    driver: bnxt_en
    version: 6.6.39
    firmware-version: 224.0.110.0/pkg 224.1.60.0
    expansion-rom-version:
    bus-info: 0002:01:00.0
    supports-statistics: yes
    supports-test: yes
    supports-eeprom-access: yes
    supports-register-dump: yes
    supports-priv-flags: no

