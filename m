Return-Path: <netdev+bounces-227036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BB7BA7617
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 20:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5C93B9C52
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 18:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7151146A66;
	Sun, 28 Sep 2025 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTX83zm+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214D92571B8
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759082946; cv=none; b=j878W/eTnNJR+OZfTRHWaHJzj1gM3KiR+8LG7b39aaFsuG+7gDg0fJyG3UjyZL+LOSm8iU3IcYk2krQE3n6vmV/2YKaFXi62MYeOPQ9vhAijdBmOpz9jwQ+ksNmhjbIjmL/gXy5tU2ZbYXOzIs2AeDhw++o+VfQc/sk7wRSc5HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759082946; c=relaxed/simple;
	bh=PFX1/pQ2DrCYy6bmZ77l9OWLlT2CVR0y3HYyYI9cbrk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LdOrtWujmnuKakRjup6uJkaM08kqtaZFiWz1Lrd/8g7arJc7rs0eeu0tsjzYQ0AGnFZCqGpIBvJpId6u+TR1JeFGir61hbu3xA7Wd5YhavVq0zq6knb0WFLn/Gl4AZ5cUpeNICWg8bdE1x9zfzfYem/BfmG/ZclqoJHcXtCs0oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTX83zm+; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-54a8514f300so1977055e0c.2
        for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 11:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759082944; x=1759687744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQqsjxVPfgWXmWp6CzXKOW9/aRf6LaILKfQbFzxS6SY=;
        b=hTX83zm+QcIox8l0+xUxRcH9nbqPUSKaNxhZOiUUzihNQFJm4NI8qXCuXf76Y6A3ec
         qPJqU172CQ90/YXmO0xramPZli7fuj+tEHxShrxUD5NZgNqOdGti8SlyLiCBQI2dOW1c
         HDzItbet5Ej0vRaSsoQRhnbHFNe34CucNA06gOFTHVInaHDvY5Pr64hlQhi7/3pCTDGN
         VfdGTpwAe+bJ1uTcq9w4hQW879g3Gzah674geeXmTDsVHX/N4tZ3OKonDcVQRKPxi1KD
         hcDDVFi5vRfCzDhYz1gFtKEUTG2EYugTaikKywDeB5RnmlpbnyeT94YFY8xvuECEgXWv
         79Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759082944; x=1759687744;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KQqsjxVPfgWXmWp6CzXKOW9/aRf6LaILKfQbFzxS6SY=;
        b=i9BxzmyqIWCCm158mZvkMaJNyORrVL6LPWzR7xt4VWdYRRCClk3Ai2hQDnvuIGt3PX
         2LomQX2UBVXP3Z3nABdb+s9iKttWPc7mVIY34QmcsstRy9jPY86yZs+JYNdOj6JOg6sv
         7LVRfWIX+3U0+DTHUmSV5HuS0B6A9c/mvOoASZ2zCx6Lwm+SwM6KczbLposilE/sK8By
         Myqw4hjkXYtMRT+oMWvom206d0Pw06aJB/iVegDybfbAc5bE8uOvI9uZNi5doaQZva0E
         pKs7pWZ7wWSlQ10tbZ3omh6w2Lz5hbEDCpgJZOsBk2LUIrGvzOp89p6vAIY1SR2rQbNC
         wGNA==
X-Forwarded-Encrypted: i=1; AJvYcCV4sk4Aj65DiDIAg584Kag6fWENmb2hNSufNekjMSpAqmLXSfq17VLDME+ydyOW7H59TtwkZms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWp+um364qmPP0x5iVK4EFJ841U75swbSFvW02PA0kliRzIm0D
	Jb5g/emrpWcG0cPzKpZ+8TBtpcR9GDDFhJi2T3wLem40KmU4zF91Bldn
X-Gm-Gg: ASbGncvaSsUDw3OHkmSYpdSm5tKKf1V8cGkNUQ1rPZz5sHwye9Wd7d7MQBKqAT0aoWp
	I598ZfQErEffa89yX91YM+acQse0xiMc9pJEkqlVqX9uPj1ILmoYRz/obCPHIvcCsFqpIYlZRg2
	Z/1jhYtlLQWsIoGEU3uLsQolhAlYwXTbGFCiy81A+K9qIATe/ch/0leJiDkezzoByRZjG8pH0h2
	7A+1oLHnJ2NFUVoyGxSVpGBQSjpbIiZaPfMfTRQiAZbsSDaLZ4qiZvfHz2AIncAmzsbUdykePhH
	Ba6jJruEO4UL+CfX6dueEjGnXiotioJPznEFre+oCPEjyKObNPtIy+1BsBi0Uq7XBe82WuVS/RH
	zRjC+RAXXVZpvuHHD8xp5lNNKk32cTe25zZCiBIoNum6nT2yiWWKO1uzzqTjfCbGnnZ2u+w==
X-Google-Smtp-Source: AGHT+IHtzyXckvli4fA59fvA4nw91cwKJYa726RDffat9DvtVLICsvD/oGO0/4NYTHabrL3LpT5fGA==
X-Received: by 2002:a05:6122:512:b0:54b:d7b6:2ef5 with SMTP id 71dfb90a1353d-54bea30c403mr5981624e0c.9.1759082943902;
        Sun, 28 Sep 2025 11:09:03 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-54beddbb84bsm2066535e0c.21.2025.09.28.11.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 11:09:03 -0700 (PDT)
Date: Sun, 28 Sep 2025 14:09:02 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.22202affbad0@gmail.com>
In-Reply-To: <20250927213022.1850048-1-kuniyu@google.com>
References: <20250927213022.1850048-1-kuniyu@google.com>
Subject: Re: [PATCH v2 net-next 00/13] selftest: packetdrill: Import TFO
 server tests.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> The series imports 15 TFO server tests from google/packetdrill and
> adds 2 more tests.
> 
> The repository has two versions of tests for most scenarios; one uses
> the non-experimental option (34), and the other uses the experimental
> option (255) with 0xF989.
> 
> Basically, we only import the non-experimental version of tests, and
> for the experimental option, tcp_fastopen_server_experimental_option.pkt
> is added.
> 
> 
> The following tests are not (yet) imported:
> 
>   * icmp-baseline.pkt
>   * simple1.pkt / simple2.pkt / simple3.pkt
> 
> The former is completely covered by icmp-before-accept.pkt.
> 
> The later's delta is the src/dst IP pair to generate a different
> cookie, but supporting dualstack requires churn in ksft_runner.sh,
> so defered to future series.  Also, sockopt-fastopen-key.pkt covers
> the same function.
> 
> 
> The following tests have the experimental version only, so converted
> to the non-experimental option:
> 
>   * client-ack-dropped-then-recovery-ms-timestamps.pkt
>   * sockopt-fastopen-key.pkt
> 
> 
> For the imported tests, these common changes are applied.
> 
>   * Add SPDX header
>   * Adjust path to default.sh
>   * Adjust sysctl w/ set_sysctls.py
>   * Use TFO_COOKIE instead of a raw hex value
>   * Use SOCK_NONBLOCK for socket() not to block accept()
>   * Add assertions for TCP state if commented
>   * Remove unnecessary delay (e.g. +0.1 setsockopt(SO_REUSEADDR), etc)
> 
> 
> With this series, except for simple{1,2,3}.pkt, we can remove TFO server
> tests in google/packetdrill.
> 
> 
> Changes:
>   v2:
>     * Add patch 1 for icmp-before-accept.pkt.
>     * Patch 2:
>       * Keep TFO_CLIENT_ENABLE for
>         tcp_syscall_bad_arg_fastopen-invalid-buf-ptr.pkt.
> 
>   v1: https://lore.kernel.org/netdev/20250926212929.1469257-1-kuniyu@google.com/
> 
> 
> Kuniyuki Iwashima (13):
>   selftest: packetdrill: Set ktap_set_plan properly for single protocol
>     test.
>   selftest: packetdrill: Require explicit setsockopt(TCP_FASTOPEN).
>   selftest: packetdrill: Define common TCP Fast Open cookie.
>   selftest: packetdrill: Import TFO server basic tests.
>   selftest: packetdrill: Add test for TFO_SERVER_WO_SOCKOPT1.
>   selftest: packetdrill: Add test for experimental option.
>   selftest: packetdrill: Import opt34/fin-close-socket.pkt.
>   selftest: packetdrill: Import opt34/icmp-before-accept.pkt.
>   selftest: packetdrill: Import opt34/reset-* tests.
>   selftest: packetdrill: Import opt34/*-trigger-rst.pkt.
>   selftest: packetdrill: Refine
>     tcp_fastopen_server_reset-after-disconnect.pkt.
>   selftest: packetdrill: Import sockopt-fastopen-key.pkt
>   selftest: packetdrill: Import
>     client-ack-dropped-then-recovery-ms-timestamps.pkt
> 
>  .../selftests/net/packetdrill/defaults.sh     |  3 +-
>  .../selftests/net/packetdrill/ksft_runner.sh  |  8 +-
>  ..._fastopen_server_basic-cookie-not-reqd.pkt | 32 ++++++++
>  ...cp_fastopen_server_basic-no-setsockopt.pkt | 21 ++++++
>  ...fastopen_server_basic-non-tfo-listener.pkt | 26 +++++++
>  ...cp_fastopen_server_basic-pure-syn-data.pkt | 50 +++++++++++++
>  .../tcp_fastopen_server_basic-rw.pkt          | 23 ++++++
>  ...tcp_fastopen_server_basic-zero-payload.pkt | 26 +++++++
>  ...ck-dropped-then-recovery-ms-timestamps.pkt | 46 ++++++++++++
>  ...cp_fastopen_server_experimental_option.pkt | 37 ++++++++++
>  .../tcp_fastopen_server_fin-close-socket.pkt  | 30 ++++++++
>  ...tcp_fastopen_server_icmp-before-accept.pkt | 49 ++++++++++++
>  ...tcp_fastopen_server_reset-after-accept.pkt | 37 ++++++++++
>  ...cp_fastopen_server_reset-before-accept.pkt | 32 ++++++++
>  ...en_server_reset-close-with-unread-data.pkt | 32 ++++++++
>  ...p_fastopen_server_reset-non-tfo-socket.pkt | 37 ++++++++++
>  ...p_fastopen_server_sockopt-fastopen-key.pkt | 74 +++++++++++++++++++
>  ...pen_server_trigger-rst-listener-closed.pkt | 21 ++++++
>  ...fastopen_server_trigger-rst-reconnect.pkt} | 10 ++-
>  ..._server_trigger-rst-unread-data-closed.pkt | 23 ++++++
>  20 files changed, 611 insertions(+), 6 deletions(-)
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-cookie-not-reqd.pkt
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-no-setsockopt.pkt
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-non-tfo-listener.pkt
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-pure-syn-data.pkt
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-rw.pkt
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-zero-payload.pkt
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_client-ack-dropped-then-recovery-ms-timestamps.pkt
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_experimental_option.pkt
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_fin-close-socket.pkt
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_icmp-before-accept.pkt
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-after-accept.pkt
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-before-accept.pkt
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-close-with-unread-data.pkt
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_reset-non-tfo-socket.pkt
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_sockopt-fastopen-key.pkt
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-listener-closed.pkt
>  rename tools/testing/selftests/net/packetdrill/{tcp_fastopen_server_reset-after-disconnect.pkt => tcp_fastopen_server_trigger-rst-reconnect.pkt} (66%)
>  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_trigger-rst-unread-data-closed.pkt

Reviewed-by: Willem de Bruijn <willemb@google.com>

This was not just a trivial import from github.com/google/packetdrill.

Thanks for cleaning up the tests and converting the experimental-only
variants to the standard FO mode, Kuniyuki.

