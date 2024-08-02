Return-Path: <netdev+bounces-115436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA0A946603
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 00:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4AA1F2180B
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 22:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E87647A64;
	Fri,  2 Aug 2024 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mosenkovs.lv header.i=@mosenkovs.lv header.b="SPgbeb9V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F365C1ABEAC
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722639266; cv=none; b=AIxuMBYdXfzXkuU4vbHfv2O+7HANChYFQqmfVhCBUP0FbeeTj2xmSZkqUx7/aGOghGsJauVHXptb/eLALibC/TQXacdw0VLhOf5iNxF7EUXonf0708Nvl5GVKYnbuPbwDt6xs6y3SI0x9YFJEwZ19ML7JoG7Iu6yb6XzsZsUyJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722639266; c=relaxed/simple;
	bh=RZwtE0dI715xs3rqxTRg+qXaLGQGWYaoXTpW9BmYbEc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QAaq0ZIWDXvOY0pTwrhZy/+OLPj1Me8nZd1cIXlnopDvfi20OwAqciNGpgSBnTtZHPMkBy+OfKv8LnwxH1dNNDozLddB3AbhRw8u/wMsbxHEmQms4A5vdM8Wp2uDkiKKOP9uPOXgUCz3sZxTwTNaGH6eWog5EDvOxwaVtIuPJDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mosenkovs.lv; spf=pass smtp.mailfrom=mosenkovs.lv; dkim=pass (1024-bit key) header.d=mosenkovs.lv header.i=@mosenkovs.lv header.b=SPgbeb9V; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mosenkovs.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mosenkovs.lv
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7104f939aaaso2999853b3a.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 15:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mosenkovs.lv; s=google; t=1722639264; x=1723244064; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RZwtE0dI715xs3rqxTRg+qXaLGQGWYaoXTpW9BmYbEc=;
        b=SPgbeb9VOiNMO9q0Z6zh0UqCERkkYHn47xoj6yB4Yrqz801uPN6jzJ5N16SA1WFs5F
         DkgyGbr8+UKdAxTsxQHye8umNlCWB0V3SbnP555n5KfUhh57hwZ0hdB/bvobwbKqMdlt
         UTsJqn4kmoSIdOOeq0k+c0jM2Q4CSn1C7UDD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722639264; x=1723244064;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZwtE0dI715xs3rqxTRg+qXaLGQGWYaoXTpW9BmYbEc=;
        b=INgR0oFBVSKghO5vifjlclaiYxsrZ+Rc1WvTjM/ccNQc2fQIj0stmPDwlE3pnDMApL
         juokjHrNflaez/cyOsDleJzELw5wgiOeuIF+6HtmgCjExsFbYggkeqA1g8b7jr+dg75m
         cGg7ZtipYHoyk0oKUOeIURZDM3K04gttYeh/7xnqY2OWXvW4QkstuaRgcnRLoG2kcI0x
         2TIwGufewAJvm8wIp8DfaB2mSoWF8etsf8FmHvnL8Y22xcktP+H8Zv9Q8LuNWmRajidE
         0E56UDfnMHfUWGvWSsqb0LR9WACCer1y5TmHyOZRDMfO3gzCsUIpeq+bxw/45aQo+MN+
         eJkA==
X-Gm-Message-State: AOJu0YyvDipQN6tpkPwJMrS423WYWWNN4OLOGiXbyx0F6TIyzjILYUAc
	diPafIJwSP5Jn6ZDc1wJOsgeWMCvSrKu9gFHvBVQ73u1VhNJJ64/ymz6XnEJAadSzjHJRCdlhm7
	SW9xmVXen4oNfqWqCMbg2r9/n0E442nCUVYaiWozvRVkqaLXFo2oA4Q==
X-Google-Smtp-Source: AGHT+IH7TCvO9VEGhknOG/cdWpkGYsN0fmqX7MSdZjf4Q1lWv5x/X5SkiN1p/F9Q9Wl0HFVaXfiOWJOnoXUbQcCcKvY=
X-Received: by 2002:a05:6a00:181e:b0:70d:3777:da8b with SMTP id
 d2e1a72fcca58-7106d09d5a4mr6282315b3a.25.1722639263838; Fri, 02 Aug 2024
 15:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Davis Mosenkovs <davis@mosenkovs.lv>
Date: Sat, 3 Aug 2024 01:54:13 +0300
Message-ID: <CA+42Kx5UKSnzhaKSfz2t1Kis7Q4=Ms3spd-tnW-CDHKvzTm5PA@mail.gmail.com>
Subject: Mirror DF flag in ICMP echo replies
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greetings!

Currently, after receiving an IPv4 ICMP echo request packet with the
Don't Fragment (DF) flag set in the IP header, a Linux node sends an
ICMP echo response packet without the DF (Don't Fragment) flag.
Some other operating systems (e.g. some commercial network devices)
mirror the DF flag in ICMP echo responses (ICMP echo responses have
the same value of the DF flag as the received ICMP echo requests had).

Would such feature (mirroring DF flag value in ICMP echo reply
packets) be welcome in the Linux kernel?
If yes, should it be configurable via a sysctl named
icmp_echo_mirror_df (under /proc/sys/net/ipv4) with 0 (off - the
current behavior) as the default?

Best regards,
Davis Mosenkovs

