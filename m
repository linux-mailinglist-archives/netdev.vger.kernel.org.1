Return-Path: <netdev+bounces-212278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 931F3B1EE98
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 20:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A3C3B2484
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0378D222577;
	Fri,  8 Aug 2025 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="AUEODd49"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B2276030
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754679490; cv=none; b=X+ZU2mwgSLaXkYWg1nObK+iXcqTb4HINc+74c/3tkqkp4nhGFWB9XA+moi0YRB5qv/BfFwIw9f83vJjGKnrNJLwqMtmnqnUEATiJ+IibFu1BgLd0O44hv5z1adFVSt3TrOY9rUjTyClTmfbI3Tub2zljKxb84kih759a6Ur/nFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754679490; c=relaxed/simple;
	bh=zF9NRZgCk+PXK2zvVFzI2ry7Xxx7BQPV4t5GvfMgoFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=II5X06yhEwnezFqwgC0/fwT2z69H+RZPf6jOcRErnctp3q94JA5GWeQhll4rZ8jNCdGjRuJlSlBW02CD99FKieY4C4WlxhGJ5ekzbEqQXmyTPvfIAGlqvO5s/kog2e9lFOCqOp57dbJCCxp6flM74ltJo/s42t73PhD4hyfI+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=AUEODd49; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b42309a87easo450453a12.1
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 11:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1754679488; x=1755284288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2NmIm6mjKZ8t7laHhfHgyGiZS5qOBWvDfmnil0ZPEDA=;
        b=AUEODd49DNcr7y/gCwb3GL9NPipJ202gO89pOcH1Vo7CUjBodbTtvjgNz695cwGFTj
         N7PD91KlA9nz9eZ/u0cLwkum4AI8VgMepJwgSJ79TYaXWqST0N4f4aQRQuoyj5b8RbC4
         wdOiyvyhG8mznww4CTwTy9v858R19ee/L0FEIVvJqPuQyiZFyeWs9kIFsjNkP0GH3tkA
         mtrGAaNaNzdvFjVr5Gp9oPfd/86K4MiUCUnkczFWDAzcuV6pZNbf3uq2a8+OV43lS7lO
         dmmB8M5HpIHM/Tlhh8mYxlw69pxLKOgWfYbEAjzfYQU0K9QIO/bVp4x7S6Pr5Tz4IJ25
         45ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754679488; x=1755284288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NmIm6mjKZ8t7laHhfHgyGiZS5qOBWvDfmnil0ZPEDA=;
        b=jTk2eC3j2HSr4Pwp7jNG9blAk1GBslHZd/KAiAXPG03NTUIe2Wo/MMrmQb1Ww3sg6P
         O29JZIITn8IhomgoMDHWPehX1HjBNqajRODZK9nnWLvTxx1oW+I3pZFQN4jv1HGAsgdb
         t6glXdt7A29cbAqA2wviCNNPScUcfEKvzac1FoYYTrxJ+kxnR6eyYPVQlxk6848OqY0C
         JC3xxR+HFhjFBvNn/cn6lRX4tk1YunAYpuHk5ZQEvP+M1VJiO6zjmEe+StZ7BUKIUbO/
         LDTQ9QIqFDI3zFJNbYLHVHRxlUkcq/rHmuEQYoFpY5oEiUilMH6QcdM2cAUvygf8RXoi
         wM1A==
X-Gm-Message-State: AOJu0Yz6JSUA6J26FgG8CQWCAjrBnbL3VyPYvJUKDc5pnO5Y0V3c3TN+
	hY2/SAZV2MKX+zYqGGjhyzCKbMAfPQ62TpqYNtfHVCnlT8XTRoYbjcSWX3yxuwhrGxeooQzEA1r
	C9SKH
X-Gm-Gg: ASbGnctNsHhT8aSyWrbqRqZsPoyv9LiqreDX7DkVzGfcVNcPaZ+pRHQ0ooqukowYQHI
	DAzhW+YoNKtaP3tb7R4yUVW+4pWjewhBtF95ZvgMnGNf57/Q34l8LnXw0KvROO6EcuAP+wrUgkv
	hsLUDKB8w/oduJotjWIIBNYQC5Q1//NuU2R6VOn4P2d1n+6OViUkHfGd+FulgfP3pP1fMDoy4My
	R4GTOFhvG+CrC+KffROHQITXuvux2ejdY8t1XmcCOEl6A0zx1lK9WpOcdl1RF8ZLxDnhz3aPqYW
	zISmRkX+K4Cacaljg4/+h8M07G8sR8KxtLffaeZIZj6MvXTW61DfRPdoWSoMwu+xweDP+ApDqpO
	ZC7bOcXEetvxumTq1pascnw==
X-Google-Smtp-Source: AGHT+IESlMBhrVvWWMUFLmfaYHZAFxWuSbX6lIqwC5h+YluH3f9UNWN0R2ay0Ti14Qt+x6St7mSQwg==
X-Received: by 2002:a05:6a20:3c8e:b0:240:1a3a:d7d4 with SMTP id adf61e73a8af0-240550452e2mr3172428637.2.1754679488423;
        Fri, 08 Aug 2025 11:58:08 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:a6ee:dea7:7646:6889])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bb0a4b0sm18344803a12.59.2025.08.08.11.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 11:58:08 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 net] docs: Fix name for net.ipv4.udp_child_hash_entries
Date: Fri,  8 Aug 2025 11:57:56 -0700
Message-ID: <20250808185800.1189042-1-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udp_child_ehash_entries -> udp_child_hash_entries

v1 -> v2: Target net instead of net-next (Kuniyuki)

Fixes: 9804985bf27f ("udp: Introduce optional per-netns hash table.")
Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 Documentation/networking/ip-sysctl.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index bb620f554598..9756d16e3df1 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1420,7 +1420,7 @@ udp_hash_entries - INTEGER
 	A negative value means the networking namespace does not own its
 	hash buckets and shares the initial networking namespace's one.
 
-udp_child_ehash_entries - INTEGER
+udp_child_hash_entries - INTEGER
 	Control the number of hash buckets for UDP sockets in the child
 	networking namespace, which must be set before clone() or unshare().
 
-- 
2.43.0


