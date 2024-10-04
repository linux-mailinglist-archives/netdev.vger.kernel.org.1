Return-Path: <netdev+bounces-132209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7E8990F9E
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409731C231EF
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF861D89F5;
	Fri,  4 Oct 2024 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lSNGHh4R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C481D89F9
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069410; cv=none; b=Jzmuxjj28ue3dX0Ud9v40wh/on9xZ9tUZn4CZkK7opVjD1qUR39ciyBSl8zRvv21EzuigT/SZaMFuVBM+DZ5sJuCO22t6Pmr9+FVyMf/yEfwT4LeMjSuqBfAgA2brbjxivYITGQAHR4Ch8PZrU43HHK8qeiX/2WekLFk82/3Jt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069410; c=relaxed/simple;
	bh=tdaFK6Eccgum7vZ0jMS/79cdK4OfsNgqF5k7/DVC4BM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kXLrGc4QSNQrGdsinYzdNld2mNkY0yPS0+wqW5c2rX0FrlkoeZ5gyXx3AiIty8UKtinDFXEFtUBFEh2n+4+EybR5myjUWDNVwxSGkhRiKPY++RIMBziaAr08d4qgMZwZXXK/o2+Bk0ryZf6R0OsyF6V7GyPHin+aYnrs32mHc0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lSNGHh4R; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6cb37b45f24so44949856d6.1
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728069408; x=1728674208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SwIu71OIlv6gaaL1ktIj4cy1/r5IUv8UVF++6I05wEQ=;
        b=lSNGHh4RXBf0UML1O3iOkw63khUrzTn7xHTnDeYTr4mP0SJGt6C6Ir56jvit8VsHuD
         hu/J9L4msBv8OBoHf9GpkyPS9tpQWtUzDdDQioRD+AUaKSRQs25gTC1p79BvPFfjTX2R
         SveydybbQ5gl2Vh19JigX//slrsMm9+Td8C/GMUnOyRGl3esIYu50omO0DSMrWHDQAhU
         9MeGf3p3wmC4u3id7mbPInT0MKqjVTVNqN8/T2Ns0WaUvKLHswHgvuVkA2lLT3Rs4cXt
         qsMTPkxGvyYwhM+aJpOcBDOWVsluUtOMlW2Hbf0HWIRFoITkcqv5Fsv3TWdF6lzuSlPl
         ylMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728069408; x=1728674208;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SwIu71OIlv6gaaL1ktIj4cy1/r5IUv8UVF++6I05wEQ=;
        b=YgWEVUlKXvHQAYmkrFQYa5sa2JngiCqQxX62pd1u1vo51bPH13HzUFx6h2YUH+FHs4
         9iXc/g4dGlHxQPtXF42Axpp3s4cHyAtz2zkhaYaeTBY7h9uuTZCf7fp1mCCPy2d42JvM
         XPVJKU4PpvqTkH6m5BJQd6DU0GNXPuHEIr3zGcSo1Uw4tgSlVXZSrMyJ7Utb+cIzQ3s9
         Bm5aDj2R0g/f6C84He9o7qIShsQA0+b4GA751Z5B8SRBHMfP66PcHSTbmNg5KYSw/Efv
         PE/YDGC3SU/o6ZT8D8GMTsptiKkn9Vm/s+MqTskIYWWx/M9lg0ikXCSDy7ansi6yMUgb
         8/ZA==
X-Gm-Message-State: AOJu0Yz/LTQS3TPzPGUWWD2ZsLCVqezCSvjrCwvhHcWO26auPLNSG4Im
	Oqw2RXU9m8GNaffdgm6MpUJgz7RwFDuJSSaVP1GEBFPil5pBU9Wa8QXhCcU2pq3Imi4x+uUL9F/
	rdpioVKd2CA==
X-Google-Smtp-Source: AGHT+IER84K4dDVZ19+UPcpLUvkt6zdpY1UiN8HGE5/jEztmWOcTwabK6wuyCrUwyP4+fY9POkMvwgbkcja7zA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:6214:5007:b0:6c5:88bf:b257 with SMTP
 id 6a1803df08f44-6cb9af3dbe9mr739566d6.5.1728069407793; Fri, 04 Oct 2024
 12:16:47 -0700 (PDT)
Date: Fri,  4 Oct 2024 19:16:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241004191644.1687638-1-edumazet@google.com>
Subject: [PATCH net-next 0/5] tcp: add skb->sk to more control packets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, TCP can set skb->sk for a variety of transmit packets.

However, packets sent on behalf of a TIME_WAIT sockets do not
have an attached socket.

Same issue for RST packets.

We want to change this, in order to increase eBPF program
capabilities.

This is slightly risky, because various layers could
be confused by TIME_WAIT sockets showing up in skb->sk.

Eric Dumazet (5):
  net: add TIME_WAIT logic to sk_to_full_sk()
  net_sched: sch_fq: prepare for TIME_WAIT sockets
  net: add skb_set_owner_edemux() helper
  ipv6: tcp: give socket pointer to control skbs
  ipv4: tcp: give socket pointer to control skbs

 include/net/inet_sock.h |  4 +++-
 include/net/ip.h        |  3 ++-
 include/net/sock.h      | 19 +++++++++++++++++++
 net/core/sock.c         |  9 +++------
 net/ipv4/ip_output.c    |  5 ++++-
 net/ipv4/tcp_ipv4.c     |  4 ++--
 net/ipv4/tcp_output.c   |  2 +-
 net/ipv6/tcp_ipv6.c     |  3 +++
 net/sched/sch_fq.c      |  3 ++-
 9 files changed, 39 insertions(+), 13 deletions(-)

-- 
2.47.0.rc0.187.ge670bccf7e-goog


