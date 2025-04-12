Return-Path: <netdev+bounces-181915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4CBA86E0C
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 18:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059BB7B277A
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93D21FBCAE;
	Sat, 12 Apr 2025 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxupO1j4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621C1192D66;
	Sat, 12 Apr 2025 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744473998; cv=none; b=Inyp1b4ztL8wbaxP4Ez40QHGVvfBqD0yt70g7fRgAvC7Io9Jmivz3Y/uq024z4P9G7AkGg7q/gCGu+YA3ozCwgqs+wLUTgVTBQAPSmRTK6lZuQbwK5mKrIN1mpBTKT0SUKOC9aHOnpytqEv0R4S8ZK+oBPHMza76eDAtsnlGRfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744473998; c=relaxed/simple;
	bh=5pjImVyaUSqRmZRdn2LiZv08c/e1+C24mgMzF4falaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmnrXZ3JGqKLsa8VLYuyuiQZmjjMAovFGuMQ16duoQQ830xnAXb0L1db44M+QirluC+OTmJdbcSgbJfzosVevOWDZkYL75M1jlUgP5oAuap4rkk11BK9GfNvaaosIr4kSXL7hEk9f1dMI/ifkMaGWYQLXYGFX18aIU44Y2X+1Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxupO1j4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22401f4d35aso34401465ad.2;
        Sat, 12 Apr 2025 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744473996; x=1745078796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ewF251k2sP2DDRu+cfWYtdHJ78ZbeiTilTLAfoCOfS8=;
        b=DxupO1j4p0Sklig3um10ntfhWdj130wOa6kPkuJgQMQjGxct9EkSxr8Lz6ERSBa3pu
         Z4gmJRs+PdBDgLp16A9O3/m4T5A03fPCi3KMLYDwVnqUvxcTn1UKvsBN6rlq30Xq0qtT
         JVl3Fqx1LfLPKq3L4DNPoRYPxAblyBs4nE/JZG2iSx4eQXDTO/mGSFlsS1nNcerSeICG
         s6f8JllzFut0Db4H0kGUssXqXHwv7ird9k4ObKcauqymlKOnql4oq+o/4nT8CBR4qkXh
         lVsxlF76ZkO5AwLbhmDQ8rg+MNbD4+Wr98d3T6LdgoxeTf5iwiVaYVgUPvYQeXQXXAnm
         U3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744473996; x=1745078796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewF251k2sP2DDRu+cfWYtdHJ78ZbeiTilTLAfoCOfS8=;
        b=B/PAg9vbNJDtb6O+RazFFDjEjhZ/xihtoqYA9b/eqw1wNp+qoXJSLI56QB1oHNA7X1
         I3HO7zGEe2BmPmVWv3UJsvi195jEHHH+CXtsqC5RvyeKSrojl8N8/uoeuamQ7LDcRs5N
         DuqWmRrSvcn7Uq6do5qgOTN3SOABgOD84WiazZSiDXRHl2Eq+9efeOe9up5IaO/wvY37
         lPNpCL8383WffhT6wNmEC2Snl7txBIqvrXVhh0Pw56ktgNmJQ4AcS+ASc6CbS41tkRjX
         ieRY5XpUMq/Gmp3cGgTqOXSQFwEAGgOjPrjuxp+EV1/JkMKyMOSyFSAydu3S2Wj3Er5S
         aWJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg2HSaC8cLmN+LhSl/drRSka94aOsy+ZfP7zbdofKnA5WIe5QwnsFh4CQedt1coOsvRhqTn2wmQcPqD2o=@vger.kernel.org, AJvYcCVx+tuNyH+opSiZqFBDRJ6WuEFIlo5cyrkCxFhKHlrOwlr4zkvfvldhS/FetiOkEfOX5lpOpXBK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4XKLOa/HKQm+gt/hdfpHXBIqShY6IvkqLcd8qJabE+kL/wQks
	rw3sf6DQ/vlpNv7WtABahQxyChtlA641goD5APocFRJ0+s5lIqR5oAEkcGwL
X-Gm-Gg: ASbGnct5PcQzE/9pzjVjjamX1T+g+kVKQMBzTsDweYwil8zmKUpATo7ylGmVZs+LRjP
	xJNvdBaqtEsbDWfxiqYpx6HliWmZ9vhKgBLo8dRu9nyvxB+5eh9TcfdsnypP8Vq90F198IfuXwa
	61O7AuD7hg0iYLZGWPtNX8Ax5N6KytQJT4wZWbN5uo9l6FeUYZll5zCLq0xCmvsP04EWfbBMdul
	YpkMBcTO/sTWSZOdPkYCzL3EUP0oiA1VcY2zxF2h+/rB+EWLm8WnfsuNNVSg9MRBJIUU0UeTIrE
	P/6UMSqW+6CWONf4gaeFjLENtOQbDlalLYLoDIlr8/PjoVCSuQeZFtMrpsld9Bg=
X-Google-Smtp-Source: AGHT+IGXh4kfZjPxYfbZ3hjPWbProLo0Qzsresv2r7n6gjlLxMEEblQMxjL50En14mw8sraWfIkB4A==
X-Received: by 2002:a17:902:f60b:b0:223:3ef1:a30a with SMTP id d9443c01a7336-22bea4fee8fmr90347365ad.45.1744473996419;
        Sat, 12 Apr 2025 09:06:36 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:5c08:585d:6eb6:f5fb:b572:c7c7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a322114fsm6558498a12.73.2025.04.12.09.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 09:06:35 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	skhan@linuxfoundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Cc: Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH net-next] net: ipconfig: replace strncpy with strscpy
Date: Sat, 12 Apr 2025 21:36:23 +0530
Message-ID: <20250412160623.9625-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated strncpy() with strscpy() as the destination
buffer is NUL-terminated and does not require any
trailing NUL-padding.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 net/ipv4/ipconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index c56b6fe6f0d7..eb9b32214e60 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1690,7 +1690,7 @@ static int __init ic_proto_name(char *name)
 			*v = 0;
 			if (kstrtou8(client_id, 0, dhcp_client_identifier))
 				pr_debug("DHCP: Invalid client identifier type\n");
-			strncpy(dhcp_client_identifier + 1, v + 1, 251);
+			strscpy(dhcp_client_identifier + 1, v + 1, 251);
 			*v = ',';
 		}
 		return 1;
-- 
2.49.0


