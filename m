Return-Path: <netdev+bounces-164593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BD8A2E668
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 561887A3F4F
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 08:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF971BEF63;
	Mon, 10 Feb 2025 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UESplH9n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F071BEF6A
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739176089; cv=none; b=Ke51vP2Uq+lYZzzAldG0zqkRY3VEAJbr3q/Z6IJqtjcc2xVSy7+PHE5PrQuXPftMD4Y5N3p9RZSVEo92cpzytx/bnS0WR3nfoXh+z/r5pyXEWVgm3DZauraPHLNXgoF4YQBZ+zuheJdPeIU3Lhmpys4axeXw6Ki8A13hjSxg4vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739176089; c=relaxed/simple;
	bh=nVy88hcVPLlG5h8m5yDPk3kmmdM86buD/YUB8tBjvzk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p/08sRuwvKfhZaDF9+17x+B/6n36AvzZiCajVy9tmpaE26lWvHLXq2O+WOZtwlx1V+VQiAAdg4b4mGy7PQeHIW1MrImYjHXXq33TpsWtdknmy555zMiFCNMAJQyp/iI2uNpUesGygsOnl/k/6bzEQoW0Fp7jC2X7FbYdA4XtG8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UESplH9n; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c0595377b5so180380085a.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 00:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739176086; x=1739780886; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4bCe/kYo6BjqDbU/jB3ekEHCt04i96Bw0fBanT3UxEg=;
        b=UESplH9nYutHO2KG1ULaJIuQpR7UUyD+o/w4z4NDfvKscS6h+pHx+0svCE/RxREmRn
         XFEO+BvN3UU3U/g1+dfHY8iVWOgLrndxvdHDFnGcop7FtRX6tMzJScUng6GKKKwvHnuI
         twQIfRLkA0wim5J4dcyYE7F7o588Tzf/AlCSeCPM29M8DGIEWvzu4/aJHNLyP6TI6gg7
         JSfTEuAnnYhpH7j8JM73WZu4hkpM9GEpBSl8ErOiAym5g19WKe4sBvcqWYMwYPnS9QkV
         gDPVE1NmJTJpP3VvDLoudX5SrDLZWFdPMbEKMkMywX4D6/Fq1r9O/41cK/cUOAM8K8RC
         iB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739176086; x=1739780886;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4bCe/kYo6BjqDbU/jB3ekEHCt04i96Bw0fBanT3UxEg=;
        b=QA3IteoD9LW1N5FFPNvhdIcOaK0FSjyg9l1dbyHc1U5kSoytaTtRLjK7KiytCW9g6z
         I988aZzYHWe4MOZlqlTNeC+UcAtVfa2exo7I3FA6/a7WcVQr4CvGQjmpabJ27qT6Keeq
         e5jNgfCja3vzz/m9XihM5n6IS0ZnyQuNq6aigppplv4TcKhxeJ5csLYVcebGxMzAG/9h
         KWsbP/P0JHDZ44fEEt1gcxH1v+5+biyuHAP2v8W2B0YPxQ4dozXtMD6pdRF8TeDG2gRK
         Ja2hHYMllsqS+Jj5P6s4s9Wq66Voiw4BNdwnsjCfElby3H84I49zAs6/go4pPa6xSaz0
         PoXQ==
X-Gm-Message-State: AOJu0Yw0YG9jhAy9kOFoSY/RbDx8sSCUaiGmUVNeQVQtMTU8To7DBAXY
	8LnVIUM4C9mP8B4BEcbQ7kQcIjqdF0dIhBGkzILSBEF4Ayc19jCh0+tVQmLAJovbR3/9MQL6iiN
	WgkRaR1Ptkw==
X-Google-Smtp-Source: AGHT+IFpMJ020454uLxFSufvjVv0OnreL0ZsiMjVdWfpl4LCFVHKgOLbawoYbp3EW8+2bbMQvlRrZIF+WyrA7Q==
X-Received: from qkoz21.prod.google.com ([2002:a05:620a:2615:b0:7b6:d073:9cb4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3c04:b0:7c0:5dd0:eda7 with SMTP id af79cd13be357-7c05dd0ef21mr451554885a.48.1739176086639;
 Mon, 10 Feb 2025 00:28:06 -0800 (PST)
Date: Mon, 10 Feb 2025 08:28:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250210082805.465241-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] net: add EXPORT_IPV6_MOD()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In this series I am adding EXPORT_IPV6_MOD and EXPORT_IPV6_MOD_GPL()
so that we can replace some EXPORT_SYMBOL() when IPV6 is
not modular.

This is making all the selected symbols internal to core
linux networking.

Eric Dumazet (4):
  net: introduce EXPORT_IPV6_MOD() and EXPORT_IPV6_MOD_GPL()
  inetpeer: use EXPORT_IPV6_MOD[_GPL]()
  tcp: use EXPORT_IPV6_MOD[_GPL]()
  udp: use EXPORT_IPV6_MOD[_GPL]()

 include/net/ip.h         |  8 ++++++
 net/core/secure_seq.c    |  4 +--
 net/ipv4/inetpeer.c      |  8 +++---
 net/ipv4/syncookies.c    |  8 +++---
 net/ipv4/tcp.c           | 48 ++++++++++++++++-----------------
 net/ipv4/tcp_fastopen.c  |  2 +-
 net/ipv4/tcp_input.c     | 14 +++++-----
 net/ipv4/tcp_ipv4.c      | 47 ++++++++++++++++-----------------
 net/ipv4/tcp_minisocks.c | 11 ++++----
 net/ipv4/tcp_output.c    | 12 ++++-----
 net/ipv4/tcp_timer.c     |  4 +--
 net/ipv4/udp.c           | 57 ++++++++++++++++++++--------------------
 12 files changed, 114 insertions(+), 109 deletions(-)

-- 
2.48.1.502.g6dc24dfdaf-goog


