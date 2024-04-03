Return-Path: <netdev+bounces-84290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1C1896667
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF611C20C38
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 07:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D605B1E2;
	Wed,  3 Apr 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sxbo8jqJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3708955C29;
	Wed,  3 Apr 2024 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129522; cv=none; b=jKAF9IggTMCK3co0X/eWSO/jTIBMHKslzxoiQVDw8jG5CAdK0Qsy80vivA9dmMoaufFTaGYEMpgiU1of3kerXKhmYzsr2L4BsNKBYzgInXIwYpV9fOJA840wZC/MEVdXQmd3daeYHND72nkqiZHFWHCI99AJJulFDoFx/XgbiSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129522; c=relaxed/simple;
	bh=IYGqofXTixcqgKsTRQdMNiZ655WhCgAGfO6FimJogF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=osI0P3VQGJZyoQQ3ymCHWwIfFv2Fca6x+VpV6J4OOOeIpPuteIn4Xnw8cBd5JJ+DgpUuOv8USOtkjnvcomcylpeuuOWtnWLUmPwWxJ2wTZJU2gUvvpKXGUxcYMB+FZKvbZFYCpBgwj+AR6EdpN5Ic0t2CfM9MiBdGGuuAJqrU1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sxbo8jqJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6c0098328so5207218b3a.3;
        Wed, 03 Apr 2024 00:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712129520; x=1712734320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pNtMYAEo2tFm50CvZbzCEMtnb8xqmlnnhCu6vPSs0yE=;
        b=Sxbo8jqJVGKC3uaoFICcHIYkHW2f5KmwsoriVTx5ktvUtiBzVyEahPItaZaOxjzz62
         7ufCFfZgKwYT3N8m1YY6uUm2PStTLmGjUuUw2BBO2sqcFCa22udUt7o3mxP7pqo0NJRT
         ZmWhNKN4QJS1EgdMravO1WU0Vd4TFxMC7fn1KCH2jfP1dzgPK7rGAJSSd/2GeJcPIQNL
         ZzwdPgZD3YLIVLl2YGY6i/GCf4L2uBvmys9rVT2QdkhJyzHix08HOEivT/USSdRXmnhr
         1k5ISce0d1yPxyUxttgy7/qLKwhUP4O9v5dyaXVA8xhlKuZasrA9WDhSxxZhBQIxUdh2
         enDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712129520; x=1712734320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNtMYAEo2tFm50CvZbzCEMtnb8xqmlnnhCu6vPSs0yE=;
        b=I8MpjFR0eyPtpCQNz2KphgKJNJra63pQRzxmbvBVjyN+Kkv2+NeA+PlsNBCAbscyzC
         yZBf+48TncuXz0wh9Y/CY7HNXenWyUR56NTJWzvjF8alrVNi8VB8bB5Qohd5h0I6raQs
         iF0GCLBCIXSl5/bs2CxTI6FnVWoFRlX7SMazquUFICOSlxM5JGWXBNyMwC3CcVZMVmYj
         29/RZM+Hv73MnylIIo9IxyUrnCvuSt1dXnLsPB0JDHlFLpT8QU9bdiGwWyiPR/MYXDBS
         3a9VtphYpe8BBbwTuIPG56Pg7iWkORBWu8QYp/b69Y2xUswGeHgSgnHhdH6FxcsEWeYh
         0//g==
X-Forwarded-Encrypted: i=1; AJvYcCVbriH8fnY08LrzP+XE1B0eagQzCu+e3VToRko6KCp+zqIGXt9KMzYfz95k66JLXPXspAtFlcDsGgz9t2nxqm5DIlBYp720dksfVSUFJSPCJJ6DbMt+oj0XCjVy9d54MRumy/5ouwcLfr6z
X-Gm-Message-State: AOJu0YxB959mBXherAxJJ1os2vEuBNL83XY4rL5cFeHp+hf5JtaGUCjT
	ZqOHfkTs9kGsvtEqxMhk73ZvqZiTQzQ4/oD7K/9OF5JX22TDKGBz
X-Google-Smtp-Source: AGHT+IFjJ4YKli3gCiijcxM+vyWCFeOt2dMZheZQbq9K0r1XuLrzNH4ZMCiXy8XjIrGCQ3X0TtLUAA==
X-Received: by 2002:a05:6a20:121e:b0:1a3:6404:7f0a with SMTP id v30-20020a056a20121e00b001a364047f0amr11815680pzf.50.1712129520346;
        Wed, 03 Apr 2024 00:32:00 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d48200b001e03b2f7ab1sm12563067plg.92.2024.04.03.00.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 00:31:59 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/6]  Implement reset reason mechanism to detect
Date: Wed,  3 Apr 2024 15:31:38 +0800
Message-Id: <20240403073144.35036-1-kerneljasonxing@gmail.com>
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
the rstreason mechnism and the detailed passive part works as an
example, not including the active reset part. In future, we can go
further and refine those NOT_SPECIFIED reasons.

Here are some examples when tracing:
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=x
        skaddr=x src=x dest=x state=x reason=NOT_SPECIFIED
<idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=x
        skaddr=x src=x dest=x state=x reason=NO_SOCKET

[1]
Link: https://lore.kernel.org/all/CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10QN2WBdr+X4k=w@mail.gmail.com/

Note:
It's based on top of https://patchwork.kernel.org/project/netdevbpf/list/?series=840182


Jason Xing (6):
  net: introduce rstreason to detect why the RST is sent
  rstreason: prepare for passive reset
  rstreason: prepare for active reset
  tcp: support rstreason for passive reset
  mptcp: support rstreason for passive reset
  rstreason: make it work in trace world

 include/net/request_sock.h |  3 +-
 include/net/rstreason.h    | 93 ++++++++++++++++++++++++++++++++++++++
 include/net/tcp.h          |  2 +-
 include/trace/events/tcp.h | 37 +++++++++++++--
 net/dccp/ipv4.c            | 10 ++--
 net/dccp/ipv6.c            | 10 ++--
 net/dccp/minisocks.c       |  3 +-
 net/ipv4/tcp.c             | 15 ++++--
 net/ipv4/tcp_ipv4.c        | 14 +++---
 net/ipv4/tcp_minisocks.c   |  3 +-
 net/ipv4/tcp_output.c      |  4 +-
 net/ipv4/tcp_timer.c       |  9 ++--
 net/ipv6/tcp_ipv6.c        | 17 ++++---
 net/mptcp/protocol.c       |  4 +-
 net/mptcp/subflow.c        | 33 ++++++++++----
 15 files changed, 209 insertions(+), 48 deletions(-)
 create mode 100644 include/net/rstreason.h

-- 
2.37.3


