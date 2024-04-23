Return-Path: <netdev+bounces-90363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E30B98ADE1D
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 09:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457501F22478
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 07:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D2445BFD;
	Tue, 23 Apr 2024 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyMdM0fT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB781CAA2;
	Tue, 23 Apr 2024 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856907; cv=none; b=RnAzk5Olh7gckJTMZXbkukEhE9Tpnt/CFNVBFX/vrcYjEff0TwUoBHlQqc/wDewIuJyd5sC7bSsjyeRCu4yjopvvS9iBRax+jVV4xpf0yIXdHtxIl4RATG6T/okF2NVsXfF5MCrs6aEccCjesUi+A5LWO62n6i5lCaqp6XFKq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856907; c=relaxed/simple;
	bh=YBeJMqd38yCDTXGSQCFQ1Z3M0MpdfWLJDuf5kSVsHrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G386qh316ea/gHH1BLgY6p4XIr+oJc+cqbfGN0kHVoKNQzj6Kv7Srlqynj6lVWesBMJ5P7iV6I8dCFLi5tWytlvoLoJgROBSUzSyqBp7/+/U0SBrQ+puPWQyjFfXYn0PkHEgQOor0IGbiOcnfDoiUa0b5agENqyBOorYFsZeQPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyMdM0fT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso7536555ad.3;
        Tue, 23 Apr 2024 00:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713856905; x=1714461705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWErk60OMZvREVtFAcJcEocSc4JBIDxVWbO7tBYd61Q=;
        b=jyMdM0fTcGenwyT2BeJUVlgGG5ieiL7KejPxRoG4/ABp4CWTzLHP+ZIsRM9EeOLNzU
         jEoKqOz6XKUxOwVC402U9/wr/EN0AdzHlNfqaqT/sPcEodu9f1CFviqf2Osswi6qlJ2r
         8XWnpQueZHnrf0yWIJUPr+zVTQCM7lKqqU5Q85Yd3iwYjp/HCDFyCigFcBcUUVTDa2nP
         jqmUC1vAvktV7Z16G6V+YFXA8RVSZbOT8iGmGsldPWe0Wf75XLuI/eMngyYbFVUxSb14
         N7lPY9UD7nDD9xtj05iHZH7TpF/lJLVNBFBFdeOPDnUaMOp51jGtm3eIVvcPabKsiPqo
         PAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713856905; x=1714461705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWErk60OMZvREVtFAcJcEocSc4JBIDxVWbO7tBYd61Q=;
        b=Z2cES9zm6wuZiyqDne8lasw0sjRAoOAQTu0VCXclo3vZPa1B5U6XYKdP/ryFxR0E8V
         PJO0U1/bNl5HhR/xa4YT0/wkwo77jYt4KbqyTWoA41V52AwGxuKg+oQtJo0prnYu50wq
         g0KGKFgamWRIbOCTm57PoZun9oDDGygDwIVYKPyBxJHQvom9HUxInRIQMXOtxTFRo9HW
         qY4qlehA9NW849usYfi6XkRCngmgcJdEF7L3m5xHiEE4JNbFfSV9EhB7aK3CI8CR2mHj
         GJGhyTBgTDovVshXVBk1cfZRlQ+VkINXGLphknOEJ4A8btamwqNsTwdmyyhaPRrn0Kqa
         7G8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYUS5J2Myn8sXE0kcXHiXpMzUlm0cv+E0gZqRqWYVzhRZLsd8bmOT6a0psX6tzsh5a4e/XgpNFyuJUbBlX4xvpGvw0JmGDjjpQr+hDHbaf/YO1j6dhmUpLVZbr/feviEXKXK6pqODyvwGA
X-Gm-Message-State: AOJu0YzJWTBDoOBSuOGDRi5KHJeIeGA6AeQ+nE/CqI7rE6Ylx3iABT3M
	+BSC1egVD5FILUY61CXjyQe0XeexkZMPaILuvP4FUY1rjJzBj89H
X-Google-Smtp-Source: AGHT+IFquDDTD40LicZS6AbgVpC1YZJ7/c/75vwmyLpn7BIYRsyKqh69oy58mVxb79glOZMWs7ZkLg==
X-Received: by 2002:a17:902:b68b:b0:1e9:6609:37d4 with SMTP id c11-20020a170902b68b00b001e9660937d4mr6536313pls.9.1713856905568;
        Tue, 23 Apr 2024 00:21:45 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902c79300b001e0c956f0dcsm9330114pla.213.2024.04.23.00.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:21:44 -0700 (PDT)
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
	atenart@kernel.org,
	horms@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v8 0/7] Implement reset reason mechanism to detect
Date: Tue, 23 Apr 2024 15:21:30 +0800
Message-Id: <20240423072137.65168-1-kerneljasonxing@gmail.com>
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
implemented on our own, such as active reset reasons which can not be
replace by skb drop reason or something like this.

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

v8
Link: https://lore.kernel.org/all/20240422030109.12891-1-kerneljasonxing@gmail.com/
1. put sk reset reasons into more natural order (Matt)
2. adjust those helper position (Matt)
3. rename two convert function (Matt)
4. make the kdoc format correct (Simon)

v7
Link: https://lore.kernel.org/all/20240417085143.69578-1-kerneljasonxing@gmail.com/
1. get rid of enum casts which could bring potential issues (Eric)
2. use switch-case method to map between reset reason in MPTCP and sk reset
reason (Steven)
3. use switch-case method to map between skb drop reason and sk reset
reason

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

 include/net/request_sock.h |   4 +-
 include/net/rstreason.h    | 121 +++++++++++++++++++++++++++++++++++++
 include/net/tcp.h          |   3 +-
 include/trace/events/tcp.h |  26 ++++++--
 net/dccp/ipv4.c            |  10 +--
 net/dccp/ipv6.c            |  10 +--
 net/dccp/minisocks.c       |   3 +-
 net/ipv4/tcp.c             |  15 +++--
 net/ipv4/tcp_ipv4.c        |  17 ++++--
 net/ipv4/tcp_minisocks.c   |   3 +-
 net/ipv4/tcp_output.c      |   5 +-
 net/ipv4/tcp_timer.c       |   9 ++-
 net/ipv6/tcp_ipv6.c        |  20 +++---
 net/mptcp/protocol.c       |   2 +-
 net/mptcp/protocol.h       |  39 ++++++++++++
 net/mptcp/subflow.c        |  27 ++++++---
 16 files changed, 267 insertions(+), 47 deletions(-)
 create mode 100644 include/net/rstreason.h

-- 
2.37.3


