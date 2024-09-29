Return-Path: <netdev+bounces-130202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BD398922C
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 02:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821261F2371B
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 00:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83E5538A;
	Sun, 29 Sep 2024 00:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xu76kUuw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2380C28EF;
	Sun, 29 Sep 2024 00:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727571054; cv=none; b=PwcsOvVDgFz2OtVz5ZisIJPuWONVpVU6IxPiTbG65in17sm1Zdz/LtTEzHGTCLLC/mNXxG4At2mzlkZfQaEkhofk3rRv6r85dgDGfRpaPh7t8Tc0xde06z5hHfdUu1V8lodxqEh1Tl3glgzMNTPplojgWQtEpc2ysgeZWwyvB1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727571054; c=relaxed/simple;
	bh=Qn+pIqUYweu8EZ+bLGwoknjYMd7EzzvBNty++7THH2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PtbZ2L+poTRf10pWPG263o9okxnr+BM1xk84puYt+mHgKlX/Oli7/TXffHbfV1LJlf2qgdBTuQ1HIFpf+ArITnMiPaPJQYA0XA9y4ODxcZqe95QgHlNVOcrXFaf7Wa2KGVeOGzL7OZ4rl/mKlo4sNIiqUp8ugY50R9orp756Aog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xu76kUuw; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71c5df16b10so1324385b3a.0;
        Sat, 28 Sep 2024 17:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727571052; x=1728175852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zsU7CWgjM1UsFEJ24JSmjSnHHeZkMF6S2e9wKCHHVoA=;
        b=Xu76kUuw5pmnUJqweoMEY56ZvgBR8LYVPsFk2LQeLG6Di4JxrksA3MPHcEwXJkb7Vk
         rTRiriIYEawnh/Gq0gz5CYBWMWaVR2615OdZQiiuBULCLKLCkoziaCkBgf9YjUnyzoiH
         7NJ7iuNAULhGXi81eU1wpLD0LvxI44rYivhZsTrIqkfHLUY3z3pf3wLGkFCQJtk38ShI
         ukVR1EIBPpE1HmUGmrCzEe2S+TEDr5hNOAoiCbUw1KEktLoLoA6QXe5kPZ76nS1eDkhz
         59CBbqqQz0td6SH3+W2ytCnuwfKeTFymKhc65RxUssrtv/f+4mUdRjuz1qLVqWWIXCw6
         gv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727571052; x=1728175852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsU7CWgjM1UsFEJ24JSmjSnHHeZkMF6S2e9wKCHHVoA=;
        b=WAO6KTYEkVJ9+TBB7/uIDsy+Vpor6kCxl183J4UtmLJ6ipeGWXwIk7xPj9bIfr7LFr
         NkiTuaznTFW0itlNH7TcnKKPg5dprZxmtIiFrZNxRBVyMVt8/APIdKVZytiqZg13cypv
         w6B3UrmQZSVN9eqEclNyktAOC52/HVi1BAQAdhsdZI8mDppg7ZBKxM4KlRmFjAyeMoIV
         a8MBA4pl4vco5yiUJyehHryiAgIZ3REEyPnFd/TPISGGwaLCo6AQBFfLLigxlJzx89z8
         YUTDzRT+kgBLYiWvvXbx5pJKSNZX2NNDrJIIdJlp/q/YC74sKZlI3YzkIivPTtr7kn/x
         KEXw==
X-Forwarded-Encrypted: i=1; AJvYcCURlLs8lcnr4x4GaGgPrPGNLUrQgbdktofOurVLk0DClC/3gT8RalQjePe/muD0qLx7J+dbk79NemncoVMB@vger.kernel.org, AJvYcCWoaNE5tolkXgmH2y0QW/hkViqFnUhe9ZT9hK1C+MoTdXonG0DH6wxicAV8A784RHhOAAFNAn763eM=@vger.kernel.org, AJvYcCXYi62CZv0gEKSvlAtgaXdXrRassuHoTmyeKpTgrLkb+mPrJ0Tgtc6NthfYKbAiYUVYVqsiRBg7@vger.kernel.org
X-Gm-Message-State: AOJu0YxKAfRM3zUBg/3gi9Blpi1rlpPlu6qu3zvOanmjFISZnfWDeXTP
	ujJSlWkJF7HhHMgVAdnzPTY61gcF7EwiLHohs4QcmnScqrU8+5To
X-Google-Smtp-Source: AGHT+IEX9arcIqOdoeQ6I52TYmZER7sGAhx3wBhVAyDDDYCLHrnyPUfX8+t1K9Q4qxsL7BktBYwPDg==
X-Received: by 2002:a05:6a00:2d25:b0:717:8d9f:2dbc with SMTP id d2e1a72fcca58-71b2606c524mr12222150b3a.23.1727571052202;
        Sat, 28 Sep 2024 17:50:52 -0700 (PDT)
Received: from tc.. (c-67-171-216-181.hsd1.or.comcast.net. [67.171.216.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264c23b6sm3731737b3a.88.2024.09.28.17.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 17:50:51 -0700 (PDT)
From: Leo Stone <leocstone@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net
Cc: Leo Stone <leocstone@gmail.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: [PATCH] Documentation: networking/tcp_ao: typo and grammar fixes
Date: Sat, 28 Sep 2024 17:49:34 -0700
Message-ID: <20240929005001.370991-1-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix multiple grammatical issues and add a missing period to improve
readability.

Signed-off-by: Leo Stone <leocstone@gmail.com>
---
 Documentation/networking/tcp_ao.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/tcp_ao.rst b/Documentation/networking/tcp_ao.rst
index e96e62d1dab3..d5b6d0df63c3 100644
--- a/Documentation/networking/tcp_ao.rst
+++ b/Documentation/networking/tcp_ao.rst
@@ -9,7 +9,7 @@ segments between trusted peers. It adds a new TCP header option with
 a Message Authentication Code (MAC). MACs are produced from the content
 of a TCP segment using a hashing function with a password known to both peers.
 The intent of TCP-AO is to deprecate TCP-MD5 providing better security,
-key rotation and support for variety of hashing algorithms.
+key rotation and support for a variety of hashing algorithms.
 
 1. Introduction
 ===============
@@ -164,9 +164,9 @@ A: It should not, no action needs to be performed [7.5.2.e]::
        is not available, no action is required (RNextKeyID of a received
        segment needs to match the MKT’s SendID).
 
-Q: How current_key is set and when does it change? It is a user-triggered
-change, or is it by a request from the remote peer? Is it set by the user
-explicitly, or by a matching rule?
+Q: How is current_key set, and when does it change? Is it a user-triggered
+change, or is it triggered by a request from the remote peer? Is it set by the
+user explicitly, or by a matching rule?
 
 A: current_key is set by RNextKeyID [6.1]::
 
@@ -233,8 +233,8 @@ always have one current_key [3.3]::
 
 Q: Can a non-TCP-AO connection become a TCP-AO-enabled one?
 
-A: No: for already established non-TCP-AO connection it would be impossible
-to switch using TCP-AO as the traffic key generation requires the initial
+A: No: for an already established non-TCP-AO connection it would be impossible
+to switch to using TCP-AO, as the traffic key generation requires the initial
 sequence numbers. Paraphrasing, starting using TCP-AO would require
 re-establishing the TCP connection.
 
@@ -292,7 +292,7 @@ no transparency is really needed and modern BGP daemons already have
 
 Linux provides a set of ``setsockopt()s`` and ``getsockopt()s`` that let
 userspace manage TCP-AO on a per-socket basis. In order to add/delete MKTs
-``TCP_AO_ADD_KEY`` and ``TCP_AO_DEL_KEY`` TCP socket options must be used
+``TCP_AO_ADD_KEY`` and ``TCP_AO_DEL_KEY`` TCP socket options must be used.
 It is not allowed to add a key on an established non-TCP-AO connection
 as well as to remove the last key from TCP-AO connection.
 
@@ -361,7 +361,7 @@ not implemented.
 4. ``setsockopt()`` vs ``accept()`` race
 ========================================
 
-In contrast with TCP-MD5 established connection which has just one key,
+In contrast with an established TCP-MD5 connection which has just one key,
 TCP-AO connections may have many keys, which means that accepted connections
 on a listen socket may have any amount of keys as well. As copying all those
 keys on a first properly signed SYN would make the request socket bigger, that
@@ -374,7 +374,7 @@ keys from sockets that were already established, but not yet ``accept()``'ed,
 hanging in the accept queue.
 
 The reverse is valid as well: if userspace adds a new key for a peer on
-a listener socket, the established sockets in accept queue won't
+a listener socket, the established sockets in the accept queue won't
 have the new keys.
 
 At this moment, the resolution for the two races:
@@ -382,7 +382,7 @@ At this moment, the resolution for the two races:
 and ``setsockopt(TCP_AO_DEL_KEY)`` vs ``accept()`` is delegated to userspace.
 This means that it's expected that userspace would check the MKTs on the socket
 that was returned by ``accept()`` to verify that any key rotation that
-happened on listen socket is reflected on the newly established connection.
+happened on the listen socket is reflected on the newly established connection.
 
 This is a similar "do-nothing" approach to TCP-MD5 from the kernel side and
 may be changed later by introducing new flags to ``tcp_ao_add``
-- 
2.43.0


