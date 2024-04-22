Return-Path: <netdev+bounces-89912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 590A98AC2DF
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 05:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46DA280D39
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 03:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3AA525E;
	Mon, 22 Apr 2024 03:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E39za2Ps"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C704C97;
	Mon, 22 Apr 2024 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713754880; cv=none; b=DWJY/b5zd3qK1kZ4zs2f/ZCfBc4AG3CzdTunfENdO/mTTS5G37va+ZQFwdxb3aryRBjeSH7mT4uoG+TqgTOTJGDG9HUBX7CF0KQRiYEmamYCQpQ686zpGVq7OQoYOzGJbOLxvK62YmAGrqFly/oP1qNhdyhp0+5X0bNenG/Lyeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713754880; c=relaxed/simple;
	bh=0KtavVRG3hlUNjZicNl7ABD032zI5PIuaPRFjowr1nc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F9zhsyMcRUu438n1NjeSNU5Sm0QAugQ8onEM2U6nXBtD2kcyr7tiB2Bq8ABoV5X5aiZZxTde7lO64vJUMaXeayXqjlSazWNhMYPW4X8W95r0k+fPNfbSvFJK6Vnti40sVewB/00djFYW0h8ugvmL/d9+rKPY9C/cl7BvVS5JShk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E39za2Ps; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so2904339a12.3;
        Sun, 21 Apr 2024 20:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713754878; x=1714359678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5XljG5YRDxxuTbg/PB8CT6pUwK7ZygQaCcZH+FSSuM8=;
        b=E39za2PsXiPu6m6UlCsQlvkC2ngzZpZgOXAjf2AV/G4KdHwG3Rj8h3t634x5dWuDip
         wiGdWbWtbQ5SUEl9AdibSOXqnnTfrDVCEgwIvq6lgK1aOatRxMI7JPk+WNm347OjGcnW
         /WWJBVJOHS6SJ19CPhBtrJOBaFt5JqwWUkD3QfYszyr2CBdkL+3WEdDxreV6RL7nFt76
         PZ54MOg0E8vDBIT7+XbgfAy8RBtSTBj2eUZvpb0lZCIyhTUsHevO1OfKIFXLN0ljngO4
         zlXyUhwwWOvf+5nhS+L5L1oqw6s9fSMLpf1R+hSRvkEV1eTGiy8tY38ph0UfV7zTAABR
         PGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713754878; x=1714359678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XljG5YRDxxuTbg/PB8CT6pUwK7ZygQaCcZH+FSSuM8=;
        b=g2onAMIW3q40MXdKPU/jt/+002/7opLE2RmYYqCpk/XrZA6FbyKGDKoo03r8aXGgDw
         euT+kTanhPSZoFTm1jrOKbx05Ww9lbV48CdZSL0eAEx6mjlH5EYvPNJ0QxVkybPZRpjr
         XnIk3yKQ3N8i4u64Md4gpg2w+6JwBlscWcchBXsZZBQ65CtL12gB/gZCFz3RIq2Kf9AJ
         CPOqO3bVIc9kmrnQh//YXfTOXRHbzZivgw6Iil/vb1NbLosdOsVpxJiGWKMMHGqh9cB+
         spVJkGhQqOkM790OD3yCQfdFbNTMcXxhhiuZeacj3xrju+JcYcfVS6pJxgTByULvLJy4
         TpZA==
X-Forwarded-Encrypted: i=1; AJvYcCVO22Nm4+PS5NjQNpQY+V8OyUPi9C8DXpMCuUxf62anBpiOryGDkHMmsd6s/2FVcU9kG9F7cec8Znun9tFTqmOnc0rNAKGdsAK4ZJErSLA+e3/mP+zgw6fve/6trqFOXj6DXQ4/1gJaZW6m
X-Gm-Message-State: AOJu0YwiKOdSGBNZBiY6fx8ek4FWtetzVY9DTfSR/ywKLpDXYkzyN4o4
	dCb+cX5vpJFd6Z+N/A+1ZOok91yMCe/Tn/35oys0EwV+zfIKaO3frto+Fnq3
X-Google-Smtp-Source: AGHT+IFcDVA4AS/+M1qBmfi/G7Sn24v8ZXC4grTDTYRt3A28mIGhXAJhQdX7Heoup0onIKOJeZljEA==
X-Received: by 2002:a17:902:f644:b0:1e8:c995:4135 with SMTP id m4-20020a170902f64400b001e8c9954135mr9985227plg.56.1713754878155;
        Sun, 21 Apr 2024 20:01:18 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d60500b001e421f98ebdsm6966009plp.280.2024.04.21.20.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 20:01:17 -0700 (PDT)
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
Subject: [PATCH net-next v7 0/7] Implement reset reason mechanism to detect
Date: Mon, 22 Apr 2024 11:01:02 +0800
Message-Id: <20240422030109.12891-1-kerneljasonxing@gmail.com>
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
 include/net/rstreason.h    | 144 +++++++++++++++++++++++++++++++++++++
 include/net/tcp.h          |   3 +-
 include/trace/events/tcp.h |  26 +++++--
 net/dccp/ipv4.c            |  10 +--
 net/dccp/ipv6.c            |  10 +--
 net/dccp/minisocks.c       |   3 +-
 net/ipv4/tcp.c             |  15 ++--
 net/ipv4/tcp_ipv4.c        |  15 ++--
 net/ipv4/tcp_minisocks.c   |   3 +-
 net/ipv4/tcp_output.c      |   5 +-
 net/ipv4/tcp_timer.c       |   9 ++-
 net/ipv6/tcp_ipv6.c        |  18 +++--
 net/mptcp/protocol.c       |   2 +-
 net/mptcp/protocol.h       |  11 +++
 net/mptcp/subflow.c        |  27 +++++--
 16 files changed, 258 insertions(+), 47 deletions(-)
 create mode 100644 include/net/rstreason.h

-- 
2.37.3


