Return-Path: <netdev+bounces-141197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2679BA017
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 13:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6200C282433
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 12:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFC5185936;
	Sat,  2 Nov 2024 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bu1BAs/Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B45804
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730551919; cv=none; b=nVQxlg93YR5V909q4HJKZSdDdoyAAibwqkWOjtfvZxH4ngOtTNDqgk3igIplVWh7MEclAJqARka3CajhQ9WuXKh9k4n+ChqZX4ZQV/xa4f3Z11IinczBE9UQnGdw6//P5n5MG9M2SOSZl5+A3hN3M2WNSvNithimHaE45/8uCCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730551919; c=relaxed/simple;
	bh=D9419gwxpAYzlVZjD/j9PQgqExgyPjqSP5+auessYxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O4FeNuLsilQG/LkGIm6LNnjGXUEPL/r2tPIDN0v0sjKA6aeFzN56P0qvisFVKnAHvTkRzaG6IE1MQsHanR8e0oSrQ93A5+0KdV9qDXsHRpKiwQuZ1mQz+Hmz+K9IJDScA//5Gp9JLt3AIoE1Duolhe/bMEcmstSsRVjF6JPCc3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bu1BAs/Z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so23600115e9.1
        for <netdev@vger.kernel.org>; Sat, 02 Nov 2024 05:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730551915; x=1731156715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yfzuFzxsOPnyitYDLaDd7xjUun10cj2SzjH0hul3Bnk=;
        b=Bu1BAs/ZyuJhQpwvKW5NAMxy9DSTu5xtaBymNReeI2/reRiPjMlBZkERDq+uUnrq02
         Vp8OGeGdGcMF097qcGDL8XMUncKvgnuAAdtA0inG3NI67GtdKK+gBZy15jPTskPhMyzY
         osxoxpagm7e+oQOdLw7hY3yC/Lv2tLRk6vPep6/+HAy/KI+W2eeQw4ObjdeNC9fN2ztK
         LUyc3+YhxxvUGso4ZJQhWE1Y2zvpGgfdKMWQC3DWXNk2P76HhE1sXmlCzy5Fvyoya7VO
         esOPiNogc2t8KY+QxC3uQ2P4mwD+lrpx217hLiT+hBmboTDLxS5D5g260DyTi6wrMpzy
         CL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730551915; x=1731156715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yfzuFzxsOPnyitYDLaDd7xjUun10cj2SzjH0hul3Bnk=;
        b=Cexje/wDT6w9n2Pue6VXE1HwmuOYH9RQPf8bCiA/3rvCR9gn8Klo7bP4u8xtA+/sgh
         gpFNGIz/PkbgTMKOypsPkiJq7OBDKR/Gd3Xdup0Vdyg+iTarwjYsMTuSm/3a4HK4tSse
         MmTJ2vhUyY3Cpr9yfEoI+lEn5JOoXAHy9UBljJjqZIh+KVsqGuCWemdc5YIRAIcngEnV
         zbeNq52uLbwjTdSEG+MYi2Oi8ZRtMcWkX5xewhBKimf4Bmv8dRZbs2IXmIaEERP22ClD
         9zHYf+BqtUWjcCFmZA7BRgmEFZAVI+9yg3kexF4+JqZ4TcMI9UlUaHe3/2hBCafm6Fug
         QBow==
X-Gm-Message-State: AOJu0YzJIigOkAY71aHoWXZlGDQ4X1hL0KGYEHUTanLCEABNmD9GlO7T
	v3ZAIP41TnibYHwZxiJmrPrp+YHDvMiQ4kmZrG9dDrTJu7E/NE63wWf5ot6n
X-Google-Smtp-Source: AGHT+IFmt9yNYltjVbR5x1+IpsUEEFoLf/DtPLCKppsQDB1Vb/sSa2mTvkX7C0jp8/A2uVpkFk/J5g==
X-Received: by 2002:a05:600c:1d99:b0:431:1868:417f with SMTP id 5b1f17b1804b1-4319acadccdmr272699385e9.17.1730551915277;
        Sat, 02 Nov 2024 05:51:55 -0700 (PDT)
Received: from raccoon.t.hu (20014C4D21419900D048749C30556844.dsl.pool.telekom.hu. [2001:4c4d:2141:9900:d048:749c:3055:6844])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd947bf4sm127471305e9.27.2024.11.02.05.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 05:51:54 -0700 (PDT)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	annaemesenyiri@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH net-next v2 0/2] support SO_PRIORITY cmsg
Date: Sat,  2 Nov 2024 13:51:34 +0100
Message-ID: <20241102125136.5030-1-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The changes introduce a new helper function,
`sk_set_prio_allowed`, which centralizes the logic for validating
priority settings. This series adds support for the `SO_PRIORITY`
control message, allowing user-space applications to set socket
priority via control messages (cmsg).

Patch Overview:
Patch 1/2: Introduces `sk_set_prio_allowed` helper function.
Patch 2/2: Implements support for setting `SO_PRIORITY` via control
messages.

v2:
- Suggested by Willem de Bruijn <willemdebruijn.kernel@gmail.com>
  introduce "sk_set_prio_allowed" helper to check priority setting
  capability
- drop new fields and change sockcm_cookie::priority from "char" to
  "u32" to match with sk_buff::priority
- cork->tos value check before priority setting
  moved from __ip_make_skb() to ip_setup_cork()
- rebased on net-next

v1:
https://lore.kernel.org/all/20241029144142.31382-1-annaemesenyiri@gmail.com/

Anna Emese Nyiri (2):
  Introduce sk_set_prio_allowed helper function
  support SO_PRIORITY cmsg

 include/net/inet_sock.h |  2 +-
 include/net/ip.h        |  3 ++-
 include/net/sock.h      |  4 +++-
 net/can/raw.c           |  2 +-
 net/core/sock.c         | 19 ++++++++++++++++---
 net/ipv4/ip_output.c    |  7 +++++--
 net/ipv4/raw.c          |  2 +-
 net/ipv6/ip6_output.c   |  3 ++-
 net/ipv6/raw.c          |  2 +-
 net/packet/af_packet.c  |  2 +-
 10 files changed, 33 insertions(+), 13 deletions(-)

-- 
2.43.0


