Return-Path: <netdev+bounces-81270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96D4886C5F
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3803D283B89
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54394176D;
	Fri, 22 Mar 2024 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="fGAV9BAo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196AD20DDB
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111937; cv=none; b=lvHsBNwtPU0oav2nAuTiArzqsa7HazMW0+P8FPjn8DQAvZVRVCKXxvmJ75Qk+UTEAI6LGM+7OezpHIFM4YtHhOroe/yrVuqIspAzkQFqi7ScVfZRrA3X2CYVpWonNGhIDkXBZLr+GYZz2SHBqXeF+zeJ8SH2/KNoEs5PUyDgQmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111937; c=relaxed/simple;
	bh=dsdO5CH7Qw9um70/10M+qgZza75yAcO0Og8Zl3IogeM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lqYrlk9iNU98nvIR1R5aMRtIv83p/vLatd5Glb5fwofamCz74/Y6jL0Y95KMO2fg71uIsP+1r1rjV4mzYtufg3l3uCDbuY9YI937VhK99+UVuXYWhNM8Mcp5f4C+D3wAOkdEBQz60YI1Br2kwW6xSplzXroblAe8G6ng9Fj/q8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=fGAV9BAo; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so2085888276.2
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 05:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1711111935; x=1711716735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5fDq+eHdChttsC3g5E8atTUdfB857ql9+BEatZ6I/YY=;
        b=fGAV9BAoIPYXJu/eFT2lxZKdWE5P08Mv45SBbm2UMU7B/G3Q6L45rY9MPeUcbG2OHQ
         lJnkel47QRaNfNbF+v5s12fzU2C7MJCHTe8AtaG8Z9FIwJmgKn7WGnCfJz0cmznTIosH
         ErloHCmbkH05A/Wk6nhk1OQY+6tFCa4OQy+F2deTPOgbdzsfLk6MKGP5DVKCkwM/+SBg
         QihM1GTXZhqbQ9fzRurrR87dWkTdiTCtgQYrbAhucju+u3QZq5sebq4axvaVWTGqfz37
         Ayhb5ybo9g/bdEKYciv4QeXREw3IdXgWCvJSkhb5WdEf1Rx9Gm+6kBKYtLscXfBgQsXZ
         rsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711111935; x=1711716735;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5fDq+eHdChttsC3g5E8atTUdfB857ql9+BEatZ6I/YY=;
        b=wRRulLXIHl2+dvWhbpE3R37nh148lRBFSTz2gg4b6t5Tr2tCzzcfAJyaHskUp+uuYs
         l4VniUOn2qjqtxTav3BV6/M8FFo6bSafTiDG3clM1uXpy/SCaZzl75xi/+xwS7222+lD
         mUjbET3A8xlCc751fEoRt/0VHjrCLSt/VXAfljUnzeTgWIf7Yz/Yi+VdLRwycS7UsEtQ
         84nQ0j6LWZzm8P3TUtzgWGBuEUIadoZrmhJJbwDjkrnTplBAAcOAavd+Dog7/TKWN0fF
         00Um1x9PZnLhQuMqNn0EZg92vH35YyJBm8+7OPQGEUXdPTf4AeOAlaLMJtvcRxVpNDNZ
         WK/A==
X-Gm-Message-State: AOJu0YwjUhFXqLGP6LbrYAq8EIbNTiozbXsyLpzM68aEvRnATjDqjVF6
	t03PTrnxGlfcP6kS+3r+KaM7pd+/sZoNKUp7kFNJob6RZccmqDa3czxtUlBBafBQwwyQc3q1CTe
	wOAV4rhGlKqbc26nDhRShtFBLUEc0XNZWKKHzgw==
X-Google-Smtp-Source: AGHT+IH+sJwKt075SU02C975lfAqjJ+tKId9+ftNDtqo7PX0yYP1sKhjfrVXmozphh6uYc8bbM2vpz3ifondIxHkc1E=
X-Received: by 2002:a05:6902:567:b0:dc6:cbb9:e with SMTP id
 a7-20020a056902056700b00dc6cbb9000emr2190263ybt.41.1711111935163; Fri, 22 Mar
 2024 05:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 22 Mar 2024 12:51:58 +0000
Message-ID: <CAPY8ntBB+qDuw9M+2ZSFFuP78dFP9d5WPL93TdYAGxbdg=Msfw@mail.gmail.com>
Subject: AX88179 interface is always NET_ADDR_RANDOM after d2689b6a86b9
To: jtornosm@redhat.com, weihao.bj@ieisystem.com
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	kuba@kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"

Hi

A few of our users have reported that in 6.6 and 6.8 an AX88179 is not
using predictable net names.

Digging into it, it's because addr_assign_type is NET_ADDR_RANDOM, and
that is caused by commit d2689b6a86b9 "net: usb: ax88179_178a: avoid
two consecutive device resets" (I haven't got that patch in my
mailbox, so I can't reply to it directly). That has also been
backported to 6.6.

Prior to that commit ax88179_reset was called as part of ax88179_bind,
and therefore set dev_addr before usbnet_probe looked at it.
That now doesn't happen, so usbnet_probe flags the interface as
NET_ADDR_RANDOM. The flag is not removed when ax88179_reset comes
along later and sets dev_addr.

I can fully understand the intention of the patch, but it seems that
dev_addr must be set as part of the device binding. I don't know this
driver well enough, so am making the report for those more familiar to
be able to evaluate it.

Many thanks
  Dave

