Return-Path: <netdev+bounces-89213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8CD8A9B56
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC351C23493
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A2816133C;
	Thu, 18 Apr 2024 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQi1A4EG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C22C14535E;
	Thu, 18 Apr 2024 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447180; cv=none; b=i8w3jvZ789+c5cTwm2cjRnhbPtxxDqPiS+WK4L+uW3pp5N8KqC+c6m4vqMz+OIisqiUb+PfvyUoczjkPqIvlqKwDWahC+75gAlihg+PnqbZ7rUFotkjixH4nG7uKRcM+UP2JIT12XGEnTEEi0JefwP4yCJ0WonGeDIPADE1gXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447180; c=relaxed/simple;
	bh=iYR1OrxPk3A1vKJQVSmt7cNExAjBfIB5lBVL9JnMP68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZSa28NWh+B26XcQ50iePraZZHKV4AY52sN1W+7iRq3WHM34od3pk/625z1W/YNuT2KFZEh+Bho5SgrvXdACpLZW1DIgANrr6wqdm9VlMMYLxGUoksDb1qXCOw3ly7iLh6+2ISPugIVG2QhVhfGxgVbqK3TvqjB7+0HuDevzFiQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQi1A4EG; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so618668a12.0;
        Thu, 18 Apr 2024 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713447177; x=1714051977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L5fDxSBarwXqYnNyE9xgBbxngQ2AUEwn3Wxv/dS4CR0=;
        b=dQi1A4EGiBQDx+a2qXQRVoU9iHNj27/AYIiCEste3hTOUDGcR/OrJg9l1JBUJo3mdU
         4NvY4/d1Xar1o4FzRY9iyZ3SP25/8RhLrxSUdBB/UE9ZtS9o2+brb2dVWwIftlz3/nsn
         7OWd5FBiAdXyAaf5KBJL50viBtHlLgShN91BTXTkSdEL8aAW/WZumGEjiDtAiYyuslS5
         982ZYf/bFMgdWceL0aAMceB1B7lMe7WQPUkjh0+K5JKpB98a9fB2YRh0qHMOahn5cxCn
         o6ZYYkmmveMv109puH2tTYa78XrfsxNdiH7cV9SXkmbZv+8PpUI8oVPfu/oOIA0OfNLr
         Epjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713447177; x=1714051977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5fDxSBarwXqYnNyE9xgBbxngQ2AUEwn3Wxv/dS4CR0=;
        b=V5ocy3zID7g5OWtWYHH9nIPmvxHCsxnHGf7oIU+Epyy9RzYfgLTVtqwG8VR9FpDZHM
         FIqP2fmU1wSy5GkVWd+RKLyJvbt/+oL+EMQcPdMIY2VsYsdw03hi8OHypo8LzA9/sQzY
         iATPGVI6xjJyFBrZXgjACohtJznPCyZCMqEeAXg35sdp5I9W2WFHnlzbR0c+drCMgION
         mJZwtoq5tyMthZ0EvqM5miikbCTU1Fb1z3rdPSIwJfJXmwYcheZbTdv5d/QJfAC9SMtS
         zyl+pa/EwFYZgfts8QTZd6oSp1gFaEQ9Fb0n1AHzLHuPhNPrZBadLdI8JiA8LA08tqnj
         oQFg==
X-Forwarded-Encrypted: i=1; AJvYcCUVE6niDbODuaQ4ax9fsW/1UpkBPWn6cRiAidhhjgW8Z7TAIeaTUFagGWxEm62ZScBwaTWQjZKgkQlcSebrfJUKu6+jGzKK6to69sJRzkMUAatEE4BenXivgy62zzknlfLTkvd+vbEHCkIq
X-Gm-Message-State: AOJu0YwyQLpI9pYdKTFdnjQ1Kzvimn4YoIk1RP7dHNgDVVb4cCdruXvS
	PCfHuwari9JCLKqIEURhhYsR3AumEaeK1wcNuErLkCmyehxDAQl6
X-Google-Smtp-Source: AGHT+IGAk75lhjyuWo4eZLtm2wg4+N/OO1aSFQFnDqUzCdCi4+ZZ0gNj+YggQD2SQ7R1+s/su9165g==
X-Received: by 2002:a05:6a20:748a:b0:1aa:14a1:e5ef with SMTP id p10-20020a056a20748a00b001aa14a1e5efmr4072308pzd.38.1713447177414;
        Thu, 18 Apr 2024 06:32:57 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id bt19-20020a17090af01300b002a2b06cbe46sm1448819pjb.22.2024.04.18.06.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:32:56 -0700 (PDT)
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
Subject: [PATCH net-next RESEND v6 0/7] Implement reset reason mechanism to detect
Date: Thu, 18 Apr 2024 21:32:41 +0800
Message-Id: <20240418133248.56378-1-kerneljasonxing@gmail.com>
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
2. RESEND because the status of patchwork changed.

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


