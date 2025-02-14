Return-Path: <netdev+bounces-166585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB09A3683F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B0016D53B
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474DB1FC7E0;
	Fri, 14 Feb 2025 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuPHe8dd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77AC1FC100
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 22:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572048; cv=none; b=ANvtC/67+B1DnPdZ3JwUOq+h3LPHciDHvTmmjTW3w/pZlh8itFmD6KAbjZeuyMnvHhyF0FKT0fSzB90GCRLt0D9cCeN2+xAlccjTI3ttvkRsXRUCW4DEbcF2+0696cMispziGGNpHuas8W5Ul7TbVO/2lAFvixuTTukYEvKXEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572048; c=relaxed/simple;
	bh=ya+xWaZWF4NpAOCfi9ejUOakQ8IYXygDYzvWVZMHxeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kSsQSv3W/3pMzGnfm+suQh57FNCbhsM1gwXJUBe52MGrrfOiF3+IXLmf/0ZJNlHd1DpwzHg0uspK93q8xaZWbll00E1PNpspk9ly5HG8RFShVBN7BvZIowu3zXgOMqya45szWtI+JZzCS1nna7SVpDUmsC/qYBwPH6jl5nG/SVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuPHe8dd; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c072d6199eso133910385a.1
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739572045; x=1740176845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s7snJ5mjnki9+lNnN1jOHaeDP5kz9ddWCwW23nXQwJw=;
        b=cuPHe8dds4wlFfNhAWOXs4DDvVgEfsOawHTUVRxeEIUjtRZWH/+qcBJs/h8WvKPET0
         kq8fWj0To3JAs+T/b+AOwwM8KYX1dJSCSGaSCPneXBzZevYUs6UB4KVPibrmGUcsTGK6
         FODol7opRzXlyPT/Yr8L+j1Fw51kpmEEo0bWgiNMSxvaGzZg5smTx58tLaKX7mV7EH3h
         /CTtKiQehUP8OxFAEsIfd6iUB+m2yZ7nIB6I+1/vlG6mfnaPQq9eTaFOkBS6nbPoXywB
         C3WUhMqcPYoYEI4rUkp6Ty2JfMVUitNfoqmEjXOmlOLVvyjUzLa0WWmuqxah7xbl+nF9
         MKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739572045; x=1740176845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7snJ5mjnki9+lNnN1jOHaeDP5kz9ddWCwW23nXQwJw=;
        b=pq79v/PsF5NqAbtSvvthKeKOSnejWv6MHwJZc57nSBlodGczAaxP5nwh/QCrH6qF6U
         g4UOoEFcIg/jXBOxFgE0/7k0o9yN0Rm9eLo75Ai3CrokmXF9KtuEKFwRbY83xb8LUQC/
         de6SY4EvFfkawGcmnveb7TdKUvSLPDncuR0GsJD2l15hIRFEY+bQD5R7+FElECyF4eSE
         UtnmuDOaOUEjf2OR7IdTL24tmxsL8Z83nXA2lFfbGVx60AAuzSLOchPXIJN4LxL/Yndr
         tbrRWnytmtkuCbw/Up/AR00fXO7cc66SMoausPswRDOjwT5+jUMaj5BL90kH4BswbSHm
         ApPQ==
X-Gm-Message-State: AOJu0YzhT0BgvdjtxQPLbVlf5re7c9iKu9SAJRJ6LSyKr+QrVriT2V8b
	drSouedfvIw2gzqXQOFk460aoCpETtJMz2Kc29LCSuMKDSi73sHDwQFeTg==
X-Gm-Gg: ASbGncs8EkAiVeSJbrR41Phb5oXn7CXeQQZ1VgXsHnu/80SrDH0KMkj+veStVPBFhzV
	TnCMv6ogX5sIBeIuAHvUaoO6UFrXL15qBaA9eYADlOSm88m28j2NVNTuqKic9ZolUl9RfzUPb3k
	R4ofgIWeBfbVYzk7nsMwiSIJt5ScayY+BYrBA0UYxkraIXISXHfUwsM5zfj9IsnmSEcht0Xmt7l
	MLv6AFk+7mwNy9Nb81+UFWnGEpr4e1hJtk+qrheGws0glJgQFWnC0HPZjvCFz15ihBwCW5blfZP
	cEnBG/qaMO2NEkEo2j0kVJRIm0tpZUYWZTY0pgKBfdBGz8faBALdhrYxFnKACm3/CKWPpbgoGR+
	IuzTXwq76sQ==
X-Google-Smtp-Source: AGHT+IHx4TCbfHycPGqNuQJGm1hSz+YPx4m4pLFvXvCDZNYUjdFPQjUNV2LyZVlz1pqR2AGuo1Li7A==
X-Received: by 2002:a05:6214:19e3:b0:6e6:6089:4978 with SMTP id 6a1803df08f44-6e66ccef4b5mr15598846d6.24.1739572045431;
        Fri, 14 Feb 2025 14:27:25 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7848b7sm25832916d6.27.2025.02.14.14.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:27:24 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 0/7] net: deduplicate cookie logic
Date: Fri, 14 Feb 2025 17:26:57 -0500
Message-ID: <20250214222720.3205500-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Reuse standard sk, ip and ipv6 cookie init handlers where possible.

Avoid repeated open coding of the same logic.
Harmonize feature sets across protocols.
Make IPv4 and IPv6 logic more alike.
Simplify adding future new fields with a single init point.

v2->v3:
  - rebase, no code changes
  - commit messages: apply Reviewed-by from v2 (David Ahern)
  - commit messages: move changelog below --- (Paolo Abeni)
v1->v2:
  - limit INET_DSCP_MASK to routing
  - remove no longer used local variable (fix build warning)

Willem de Bruijn (7):
  tcp: only initialize sockcm tsflags field
  net: initialize mark in sockcm_init
  ipv4: initialize inet socket cookies with sockcm_init
  ipv4: remove get_rttos
  icmp: reflect tos through ip cookie rather than updating inet_sk
  ipv6: replace ipcm6_init calls with ipcm6_init_sk
  ipv6: initialize inet socket cookies with sockcm_init

 include/net/ip.h       | 16 +++++-----------
 include/net/ipv6.h     | 11 ++---------
 include/net/sock.h     |  1 +
 net/can/raw.c          |  2 +-
 net/ipv4/icmp.c        |  6 ++----
 net/ipv4/ping.c        |  6 +++---
 net/ipv4/raw.c         |  6 +++---
 net/ipv4/tcp.c         |  2 +-
 net/ipv4/udp.c         |  6 +++---
 net/ipv6/ping.c        |  3 ---
 net/ipv6/raw.c         | 15 +++------------
 net/ipv6/udp.c         | 10 +---------
 net/l2tp/l2tp_ip6.c    |  8 +-------
 net/packet/af_packet.c |  9 ++++-----
 14 files changed, 30 insertions(+), 71 deletions(-)

-- 
2.48.1.601.g30ceb7b040-goog


