Return-Path: <netdev+bounces-88612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9828A7EA8
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 10:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99AF282FA1
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E4912836B;
	Wed, 17 Apr 2024 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yz0VQ18L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4257E0E4;
	Wed, 17 Apr 2024 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343913; cv=none; b=smDUSrVf2QcRzdGMAOh5o+3f0YLOKe+L15NRwbA6SGVjbUhdR2rBIA7q2PZ346ppDe0j4znoO2uhK29P/bsVzfsWT6+KHVFBnRTxbD5Egiiky5YiE7FOwqcRe/7SAaZmZeynkSC+z5ox/5ClfkYGt5SMrN+UiOPJzLMZuLUK81g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343913; c=relaxed/simple;
	bh=NgyKHTOEFBJXVFGLR/rWuf+lbBUP8ErMGBd3Y6OKmbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oFkXRggXG1dRakTj1KlOxeXNfhYzEdRM2wHUzH/Oj0TFd0N5GBs3Y7a3vylawYrtdaG0Wz67WSCJiMI0Sgyq6YLCvr0gt1Pi7gG4XRBxW5+u3AtZlCKONb1YZyatEKU3ku0amrgzbh2Hk6Ri9PTSYdCD5+o24twUwjmrM7et9Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yz0VQ18L; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e3c9300c65so46453285ad.0;
        Wed, 17 Apr 2024 01:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713343911; x=1713948711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OvmW+VBePs02RkEsQuZab+/Oqh+Lls5Zc4vbzJd9eTQ=;
        b=Yz0VQ18LXy/drA3I84xEn9HsmJ0FfstI/inQrPj8en/eVZDf4EMqcizfngfdas1+91
         TXjg6AAOKKKBOAo3m/fyEptCLDD84i65t7IDx3J1GrbCSX4pzcVpaAyoA28M70hX8G0n
         XL09eeq5+K6nSdDNNDi2gIg4oP2IfU1vDjZrbbWSlqm7+MxdxsfQJPQa1tND1HKyhgbC
         JrPx3109omcCtHI+gE6PXCH2T17eevahe7XHccNOKICPF4FyrbJ1Rd4z/J+kmz6Z4tP0
         1tFpFtf2xUexE8mne60obu6wq7oQr443y7SLBlzvvJH5PHGDbXmukeLM+00G1K1Fr8J3
         MiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713343911; x=1713948711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvmW+VBePs02RkEsQuZab+/Oqh+Lls5Zc4vbzJd9eTQ=;
        b=j8Vu676OB361zDu1jj8ajRFwURxFmIT6tETQOM1jq7WV8ouyS5f14gdDVGmo7/Bf4j
         Rg5/zj5sv5aI9U/MJPg5qs96qrg0lFVOauWN8WaNyZqrevUN2ANkZkc6tAeum3R6djCY
         LfgsBAePiz+Rp+tlBq7SDgQ9IY5jzVJmzX577iKGYTqihPNcfxyHcfF5dSajgT6ZH6KD
         M/grN2C+oyQH6E61MHJG1jdpfipgSGLzeHQgQPCONZ04v2wfgKVsKlGOlcBUiNX8wV/j
         w6erb0+H5TXOgEPHiRqjIiHOKK2hSfi9YmYXj0K7iCD+Nxmh2yFTZ2Tr6T3oejQ9ajH1
         sDvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpJB2FmHZq2Eepzce/QthJUkc1/5QQS9yyuksOtp/e+oXUBk9IZ9n8ilFfEpQdBrr41Fz3zDya34WUp6fZRAcT38gbGx8LPGV+v3ngkbQq8Bi79p5GwAJX3bhp2viNDazNhEcGAzUUjh2E
X-Gm-Message-State: AOJu0YyEQ1E5tqFmVYGwxWnVRk0sK34Y+fi4XCvwewn5eSFBTKkujFnA
	BhKU6zTXLvXKZC9zYckUeFYQrPHuHOKYR95UdpeHGBmDoW7w0p4c
X-Google-Smtp-Source: AGHT+IHuLKY1a7HsVvEY5xQE/35OD+dmhreFwJA/hjEl4umoxJx0PFFkc1WIiYEP/d051p+T0bBgfg==
X-Received: by 2002:a17:902:eb81:b0:1e4:4125:806f with SMTP id q1-20020a170902eb8100b001e44125806fmr17993764plg.11.1713343910743;
        Wed, 17 Apr 2024 01:51:50 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b001e452f47ba1sm11348611pli.173.2024.04.17.01.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 01:51:50 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	atenart@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
Date: Wed, 17 Apr 2024 16:51:36 +0800
Message-Id: <20240417085143.69578-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

In production, there are so many cases about why the RST skb is sent but
we don't have a very convenient/fast method to detect the exact underlying
reasons.

RST is implemented in two kinds: passive kind (like tcp_v4_send_reset())
and active kind (like tcp_send_active_reset()). The former can be traced
carefully 1) in TCP, with the help of drop reasons, which is based on
Eric's idea[1], 2) in MPTCP, with the help of reset options defined in
RFC 8684. The latter is relatively independent, which should be
implemented on our own.

In this series, I focus on the fundamental implement mostly about how
the rstreason mechnism works and give the detailed passive part as an
example, not including the active reset part. In future, we can go
further and refine those NOT_SPECIFIED reasons.

Here are some examples when tracing:
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=x
        skaddr=x src=x dest=x state=x reason=NOT_SPECIFIED
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=x
        skaddr=x src=x dest=x state=x reason=NO_SOCKET

[1]
Link: https://lore.kernel.org/all/CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10QN2WBdr+X4k=w@mail.gmail.com/

v6
1. add back casts, or else they are treated as error.

v5
Link: https://lore.kernel.org/all/20240411115630.38420-1-kerneljasonxing@gmail.com/
1. address format issue (like reverse xmas tree) (Eric, Paolo)
2. remove unnecessary casts. (Eric)
3. introduce a helper used in mptcp active reset. See patch 6. (Paolo)

v4
Link: https://lore.kernel.org/all/20240409100934.37725-1-kerneljasonxing@gmail.com/
1. passing 'enum sk_rst_reason' for readability when tracing (Antoine)

v3
Link: https://lore.kernel.org/all/20240404072047.11490-1-kerneljasonxing@gmail.com/
1. rebase (mptcp part) and address what Mat suggested.

v2
Link: https://lore.kernel.org/all/20240403185033.47ebc6a9@kernel.org/
1. rebase against the latest net-next tree



Jason Xing (7):
  net: introduce rstreason to detect why the RST is sent
  rstreason: prepare for passive reset
  rstreason: prepare for active reset
  tcp: support rstreason for passive reset
  mptcp: support rstreason for passive reset
  mptcp: introducing a helper into active reset logic
  rstreason: make it work in trace world

 include/net/request_sock.h |  4 +-
 include/net/rstreason.h    | 93 ++++++++++++++++++++++++++++++++++++++
 include/net/tcp.h          |  3 +-
 include/trace/events/tcp.h | 37 +++++++++++++--
 net/dccp/ipv4.c            | 10 ++--
 net/dccp/ipv6.c            | 10 ++--
 net/dccp/minisocks.c       |  3 +-
 net/ipv4/tcp.c             | 15 ++++--
 net/ipv4/tcp_ipv4.c        | 14 +++---
 net/ipv4/tcp_minisocks.c   |  3 +-
 net/ipv4/tcp_output.c      |  5 +-
 net/ipv4/tcp_timer.c       |  9 ++--
 net/ipv6/tcp_ipv6.c        | 17 ++++---
 net/mptcp/protocol.c       |  2 +-
 net/mptcp/protocol.h       | 11 +++++
 net/mptcp/subflow.c        | 27 ++++++++---
 16 files changed, 216 insertions(+), 47 deletions(-)
 create mode 100644 include/net/rstreason.h

-- 
2.37.3


