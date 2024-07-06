Return-Path: <netdev+bounces-109607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83C392916B
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 09:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E934E1C20FFC
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 07:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADCB1C697;
	Sat,  6 Jul 2024 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="KIC5+1EY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38A01C68C
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720249931; cv=none; b=ENmj8I3mDfTDFSeRzgjAm3k71+YR3pyzz5g2RGyKptE1qYKTRJ91HB1Sx3i0dE4NpWCn2vNFnQUWCcf/d2oRsbK9h0VPDhYQaRZEbW862nA+U68BDMhCsjh7nCMpKsZ4KxKk1ysUldNFjq299qeFffnCz1Oh7WYPPvs/ypzIJbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720249931; c=relaxed/simple;
	bh=pRdqgQSLxCw7s0+Z4EG0qKtEpm8+VGpqYfnMuZ5v9yM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iuuUIZ21MLBXRZ7Z1J9gsULXa0+Tk7LCWrl1kaq8L/jXfyOtf3ibbTXfS7XqZguL/LQX4zoDZpyh9M+C1Y/IBe063n4TkdGvx4sWh5kgt+cQTtGtykAd+fII+AiMwoRe0YRuJOpydghpPz9+WNGV6Za4uTZCtUN0UgRRjNpH5iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=KIC5+1EY; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7ec0385de1fso92419639f.3
        for <netdev@vger.kernel.org>; Sat, 06 Jul 2024 00:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720249929; x=1720854729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pBU/rymr2sXnQ8jMVGFQ/FuQw119gxmXGTmzs+tMs8I=;
        b=KIC5+1EYDZOu7Oj3S+lpVpy4spLDefVFpRsG5xl5yq21fayQgB/CmdSPytOUXzT/CJ
         X0Za1NBUos2GI8SAzvm1pJUgNblHPMm1HFwQ0pUMHz0VYheyUf0qWjOv4/JFTJLDUlLh
         RgJPWGYgXgbY4vollE4ejDrOdURAogx+5sxfqql1nGEj8tYdc1T/ikAu1fLtsjevAiG5
         DPeoAYRZUo9bxzrpIny0fA1UXaykYYkHufknnXW6oWw1KRwxYCHzvnwZ05qKkvEbP0i0
         Kvr3fKl/BZOS+eM8FYIlDNHZNJh6fQkip6sOL3vwiGpN+j9Yo3QDmSAnBSKZFVT+OK8X
         l7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720249929; x=1720854729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBU/rymr2sXnQ8jMVGFQ/FuQw119gxmXGTmzs+tMs8I=;
        b=FOg9ORDq9PlUJ5B7xopO0A97Sn7TxrNJM4og/yzMYxKIyfhYwitpcH3UGBuvLneonn
         gRWYCqSqm3ZWO7tXZ93dDtEQdw160oSbqKE1W7mkPZ/saXRwz32PN3UnTDPJY1bO+WpS
         tbNCsDrcgcNFRnfbXQw4rTVdNPfG+yjlsNAtbTw16dg6f/zJE5YXlXrKsdTtreo3T+TU
         QC5wMaPVrqcFigK79tRHqkVVPgHTxw3g3vdwoz15ipidfBG0Sfr5jzfleRPzTzNvsJ+N
         0lQSPGKpFuvR4YS3wlX+ykN3MdSfPrHWAsFM618TOWIvEizuISmGwt3AgOveV1My9+7t
         nppA==
X-Gm-Message-State: AOJu0Yy0GzhrzdIHr+baLEsF8AfTzaL4VRfR4DdCAiauKLvHk31Rlu2o
	1diLlvr/yu6nSJibwZ0gVMBngyMO6CYsJVKTvlqol+MkBKmJKKGgeB1x9QjWFYE=
X-Google-Smtp-Source: AGHT+IE3zQMSFK/fbRzcbv7S0sxo7hPGZzrByXAJW70o+JHkBq52dAH/GLhjQhmzXMBjOV2I5kCG9w==
X-Received: by 2002:a05:6e02:148b:b0:374:6e8f:c760 with SMTP id e9e14a558f8ab-38399e4a998mr84825435ab.20.1720249929076;
        Sat, 06 Jul 2024 00:12:09 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6d416554sm11921931a12.94.2024.07.06.00.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 00:12:08 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH net-next] udp: Remove duplicate included header file trace/events/udp.h
Date: Sat,  6 Jul 2024 09:11:33 +0200
Message-ID: <20240706071132.274352-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file trace/events/udp.h and the
following warning reported by make includecheck:

  trace/events/udp.h is included more than once

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 net/ipv6/udp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index c81a07ac0463..bfd7fff1bc0c 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -46,7 +46,6 @@
 #include <net/tcp_states.h>
 #include <net/ip6_checksum.h>
 #include <net/ip6_tunnel.h>
-#include <trace/events/udp.h>
 #include <net/xfrm.h>
 #include <net/inet_hashtables.h>
 #include <net/inet6_hashtables.h>
-- 
2.45.2


