Return-Path: <netdev+bounces-181725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAB8A864D4
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BB01898560
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF83238D3A;
	Fri, 11 Apr 2025 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="yHADy6hY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8331C21B908
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392973; cv=none; b=Map2m5IDvfptHRME7ZYz25nbxRewIIE9YG0OkSv0cUq5gG12Ik/3jlbnl7dXUcCBg+2+kl3awRsiryjgAhZBT09CptpV5FdoPwmFmng2UiUYiZfdrYNq0ZLTfH9IvfRAKcR8kTy/IfUlbqKJHYdRRpO3DjZ4iD7iQdbKRr/4MbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392973; c=relaxed/simple;
	bh=AJg+h0xjKCp/cv4dncQ508kXQVo7GYvpDgk5nigHSEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXW0YN0E5ggB3AZhuD3jRdZwTKRkR25F7Meu5E82KUSY+alQ2Uc4wMK5GorvWNVeK6plj0Hoe6jYAks6ExJRcOMqIwVWPucHINZm5N5LawF+KO8ieFHRdUF52Yruig7UDgKfil305Ip54+dCXg6Khkm0x51y0s68m+tvbCqF234=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=yHADy6hY; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af5499ca131so264148a12.3
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744392970; x=1744997770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z5lT0EMfO1WRM6uQZ3dhOnHkrfi/KKbft0plZaI5c4k=;
        b=yHADy6hYrvaebJ390VQJC+bryhXh4w0xckvbNZbidbB/4tT6963LnnHIxQKpl1AFZB
         yfSrbX1KN2XQ25URON7SApAKkA2LPiAUd8fTK+/2tMOYeQJwZWqIuqT0NdJuf5WJJSA8
         pnQvZ5PNPomWjaSqhKDq5CVgfZ/pSW1upG29JWuYiCKxD0A/rGAHWVTkXht8xft70j7h
         /Sl9AK4OlQn763pqX8nycHbU3Hw17pOry2KOQz5sepFpw5vxh6HEHhMbCPDUZ7Ii15j2
         B6ItUARHCQk3VeLm7w7Lgh2YS48EvFOnPQWjktXBM8TcvW+ZoNrXNcB5/kSc/EJ5PdEI
         WdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744392970; x=1744997770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5lT0EMfO1WRM6uQZ3dhOnHkrfi/KKbft0plZaI5c4k=;
        b=HoShLN+qojUZHNF7JeLfX2Tj1+c4phV6lQ3+Ha9MbuZO4gEjrulWTONvsyueS1w8ee
         7R1xp9TBAraDULOPwEb/6SmCf6OESNgzkZzhsHxAqE2AkDa4Gkqf8jutoEeIuww6YFdo
         93E1wEVDc1ycvDZb3HXBOq06gk8s5ee5Idy8CspzMi4y5okMFMjwGn3QhCDQel5ZIUWZ
         TREWit+dIcJ/9DLWZy1I3G4NnbYob3IDnwOdxs6HAB19Z37hsxfNrRkOx0h83ccExb9j
         Wu+Z72Toj5C3q+9gqn+AyijfkX3MbWq+u+BziQiOjwiayAklOTEw9mXv8kIe3spjcKtg
         UibQ==
X-Gm-Message-State: AOJu0YwK8D//HW3vRwKeLHN9877sg0Im5wU7g4yz5LvOYYbemjai/B3+
	u6swVB1OtMklfmiy2NIgaQNunA7nXJSiHd/8NVFAI5izpHOopS7tKvsGm7IUXp+6/xArGJlNC40
	bIbw=
X-Gm-Gg: ASbGncupZH1ysJV96qvqAKKLPfNT8wU1Ln4CFwUCOHCl8/85JBAwE9aX/HaK08CwK2F
	KB1CUOU6tdobdp3RkeMgSiRYElzFk1OoCh0uYdrYQ7UMsycGPeMZ4MlvqhigVSRTIeOfHojP5Ik
	uwzw7WJBm28vlN6lfgs1/AifBT86al9Xr7qP3ZNcWdEGnPDH7eZZCQnfhkJsVOLZlzUsCKDTKaC
	VEOVyd5nxvvf/fPVJ7AL261eVN+bN25qEgqJ6qEfa2nn9ulYso9/1oTgprKI5zWAVpPtrczxwhz
	64I45CQBp3TC07FnVQb0s29GkhWC8w==
X-Google-Smtp-Source: AGHT+IGJoCJ14aCk7csQlJsDVgBQpUgpZfHxoorcgN6SNpmmlceF9xmW9CEw5QtS3HDgg37ApBzh5Q==
X-Received: by 2002:a17:902:cec7:b0:215:a96d:ec36 with SMTP id d9443c01a7336-22bea4b3c13mr19603345ad.5.1744392970337;
        Fri, 11 Apr 2025 10:36:10 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:fd98:4c7f:39fa:a5c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb6a50sm52317725ad.205.2025.04.11.10.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:36:09 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v2 bpf-next 0/5] bpf: udp: Exactly-once socket iteration
Date: Fri, 11 Apr 2025 10:35:40 -0700
Message-ID: <20250411173551.772577-1-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both UDP and TCP socket iterators use iter->offset to track progress
through a bucket, which is a measure of the number of matching sockets
from the current bucket that have been seen or processed by the
iterator. On subsequent iterations, if the current bucket has
unprocessed items, we skip at least iter->offset matching items in the
bucket before adding any remaining items to the next batch. However,
iter->offset isn't always an accurate measure of "things already seen"
when the underlying bucket changes between reads which can lead to
repeated or skipped sockets. Instead, this series remembers the cookies
of the sockets we haven't seen yet in the current bucket and resumes
from the first cookie in that list that we can find on the next
iteration.

To be more specific, this series replaces struct sock **batch inside
struct bpf_udp_iter_state with union bpf_udp_iter_batch_item *batch,
where union bpf_udp_iter_batch_item can contain either a pointer to a
socket or a socket cookie. During reads, batch contains pointers to all
sockets in the current batch while between reads batch contains all the
cookies of the sockets in the current bucket that have yet to be
processed. On subsequent reads, when iteration resumes,
bpf_iter_udp_batch finds the first saved cookie that matches a socket in
the bucket's socket list and picks up from there to construct the next
batch. On average, assuming it's rare that the next socket disappears
before the next read occurs, we should only need to scan as much as we
did with the offset-based approach to find the starting point. In the
case that the next socket is no longer there, we keep scanning through
the saved cookies list until we find a match. The worst case is when
none of the sockets from last time exist anymore, but again, this should
be rare.

CHANGES
=======
v1 -> v2:
* Drop WARN_ON_ONCE from bpf_iter_udp_realloc_batch (Kuniyuki).
* Fixed memcpy size parameter in bpf_iter_udp_realloc_batch; before it
  was missing sizeof(elem) * (Kuniyuki).
* Move "bpf: udp: Propagate ENOMEM up from bpf_iter_udp_batch" to patch
  two in the series (Kuniyuki).

rfc [1] -> v1:
* Use hlist_entry_safe directly to retrieve the first socket in the
  current bucket's linked list instead of immediately breaking from
  udp_portaddr_for_each_entry (Martin).
* Cancel iteration if bpf_iter_udp_realloc_batch() can't grab enough
  memory to contain a full snapshot of the current bucket to prevent
  unwanted skips or repeats [2].

[1]: https://lore.kernel.org/bpf/20250404220221.1665428-1-jordan@jrife.io/
[2]: https://lore.kernel.org/bpf/CABi4-ogUtMrH8-NVB6W8Xg_F_KDLq=yy-yu-tKr2udXE2Mu1Lg@mail.gmail.com/

Jordan Rife (5):
  bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch
    items
  bpf: udp: Propagate ENOMEM up from bpf_iter_udp_batch
  bpf: udp: Avoid socket skips and repeats during iteration
  selftests/bpf: Return socket cookies from sock_iter_batch progs
  selftests/bpf: Add tests for bucket resume logic in UDP socket
    iterators

 include/linux/udp.h                           |   3 +
 net/ipv4/udp.c                                | 100 +++-
 .../bpf/prog_tests/sock_iter_batch.c          | 451 +++++++++++++++++-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/sock_iter_batch.c     |  24 +-
 5 files changed, 537 insertions(+), 42 deletions(-)

-- 
2.43.0


