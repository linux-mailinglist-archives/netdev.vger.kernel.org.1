Return-Path: <netdev+bounces-245767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E469CD72FC
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 22:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BDB630011B4
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 21:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAADA3081B8;
	Mon, 22 Dec 2025 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiHukJxK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289F2302165
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766438564; cv=none; b=Lyr+FY/y8GBADgN5vNtMAsh26JwvRKjORu1Ebbi0/qPTK7LlmPLasvnwqKv34MJhZkmNKFDsNJCFkYByMlnU/U/o83tVcU+3abRx9ZTcWLtNUID5c9SFx3zOI4U6jDuxSVnNUHdZWhwLsCnBAHv6hvYb9+e3WZvWl2QJDPHsMVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766438564; c=relaxed/simple;
	bh=8eo4J8AK+aRH1j7peYCAA3rXxRM4PIYen6KnK8j4OuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zr0y5dfPfOo/XGznEGnQRLUPIvs98fpCofetG4FGbUZSbjNB62XkjvLROnRg6txKf2h7RYFwIZineZSn5hhPpNtuktZ8u0yAOZxUTCc0jL4hZrgP+nkhv1TQuBjqJCgs8bGxpY4/n0/H2G1DpX0nlqdEUdOtSkDwVtrkU7bdrV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiHukJxK; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78fc0f33998so23002127b3.0
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 13:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766438562; x=1767043362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=avc6gMhjIypMIzGq7rfC6eXw+5jZGUWEN+YMRJgojxw=;
        b=aiHukJxK83O7ZoypcjCD1sIWTA2+gBWpxgAMVqeSswY2OtzqNqe/ChcFTAf/zZUgey
         N8Nj/syt0OUm+Ef8swU9DMJG8tqYkyMkE1dcrd+7FjeTn4H8iaA5v+v3k5YWH7VoAURs
         WlHHLyVU1tBWoEgbU7wpZTHC+37aL9qjf9vt12tFBUwCxjKHOVKXmC5sFkwfzKRKcvbX
         hGPf6aoSfTU233hw3kJFnr4mKvxWD9TbWHa6w6mWadFRSeK7zu1mw5l4pfh9DIgto0lT
         kjppY5lIBJZRgJ43hqenCyiPQjmAiJbMbroGA6pXKO2xz3QLEwE1VrZaJ5UznqwGBr6S
         jHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766438562; x=1767043362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avc6gMhjIypMIzGq7rfC6eXw+5jZGUWEN+YMRJgojxw=;
        b=rGQMEpKZg1PUlckGOLA0FYV3ABOJGYemjnLVeYhoEhDzZqlTkazg9AHqwjWEmULjeW
         eSTI0HBqIkplNz2fr9XELIvQUcuS4n3QPwLjWAGu7vWwO1SvkpDvdAujT3XFDTzAIi3I
         IxruY4aOkYyfQt1+PLfOsaMp9xM6Odcc1DJBqZTELDbhqyUz8+rxV7fM7WqByE/lHyKv
         11nge59V9ek/49pgOahRR5/PYwWqYEMGEI43TjW5EPwWghAe/ElMqt827SdCIYJ37tMp
         95Gua88rF44yUhCXcUCG9sPN4YOJEzshCDhdBQkOMleYgtwm7k+kvQSvwz6VKWjnRRJ4
         I7Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXOPhLw26Nyrm27eh321+XTRS91+trvWK5lLTVcOryL9xAuzXTLcKurNFVYTtFCdirmJgdN1h4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1hjlRCiBjZLKIWmfgJ6qPruA2ArJALiruSJUIGbNfYBxoqVox
	7VRs0a2Fo/vCrr2J5rTGUnRWUasndtil497iku7uVStNGGGrz/83Vbqg
X-Gm-Gg: AY/fxX6KnJYiTQxTeRWOjbwUb+8V5pJcUwR53WaJoYz7ALPQC7NYTXlDKFHqRGqmF7E
	Qv9dtX6E9o3GeEm9TtMQsxNMqmWR5iOySvtLjYnyOpKgJg5A3hWz2BTS3dW4LwxMH8gVeCUEzr4
	5XwQ5jifWnVAOF+TSlaKo69HIYTU9haB9NzJCdR5/TaHmcC0kzsnZulsqFSUvHkPDrDtt/n8Nac
	JXpcdusybayBKVmEGvD6P5Nn8g0auSvc+aAy3HrKekhSjm9/XRdWoZ6NyPEcnL0FyhJOsrBJK+s
	moW1s9CbHlaQ6Q9qoXKejF/hsX3vAlVHpJvPShBGV3934yx7jVQXSuqAjAauWVKddviM8qdja50
	2Jc8PNTnK35nIXnyqWA00j1k7hkIqyUybHXl21HLTCb7GGQm8EJDmJxLGepeWoIHntIwIpteORC
	FaoXGsw6ffCCtlOUQFEefcfmgLsx1GHNne
X-Google-Smtp-Source: AGHT+IG+t+vm07IfI0JY8xSOL4QtCu7revhabIMBVxAC10bzdwWyO0GXifIxbCOnzbItWz3g+CPpsQ==
X-Received: by 2002:a05:690c:3709:b0:787:f043:1f10 with SMTP id 00721157ae682-78fb40d9267mr233032437b3.66.1766438561947;
        Mon, 22 Dec 2025 13:22:41 -0800 (PST)
Received: from guava.tail5f562.ts.net ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a8bcc06sm6008624d50.7.2025.12.22.13.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 13:22:41 -0800 (PST)
From: Sai Ritvik Tanksalkar <ritviktanksalkar@gmail.com>
To: kuba@kernel.org,
	pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-hams@vger.kernel.org,
	Pwnverse <stanksal@purdue.edu>,
	Fatma Alwasmi <falwasmi@purdue.edu>
Subject: [PATCH net] net: rose: fix invalid array index in rose_kill_by_device()
Date: Mon, 22 Dec 2025 21:22:27 +0000
Message-ID: <20251222212227.4116041-1-ritviktanksalkar@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pwnverse <stanksal@purdue.edu>

rose_kill_by_device() collects sockets into a local array[] and then
iterates over them to disconnect sockets bound to a device being brought
down.

The loop mistakenly indexes array[cnt] instead of array[i]. For cnt <
ARRAY_SIZE(array), this reads an uninitialized entry; for cnt ==
ARRAY_SIZE(array), it is an out-of-bounds read. Either case can lead to
an invalid socket pointer dereference and also leaks references taken
via sock_hold().

Fix the index to use i.

Fixes: 64b8bc7d5f143 ("net/rose: fix races in rose_kill_by_device()")
Co-developed-by: Fatma Alwasmi <falwasmi@purdue.edu>
Signed-off-by: Fatma Alwasmi <falwasmi@purdue.edu>
Signed-off-by: Pwnverse <stanksal@purdue.edu>
---
 net/rose/af_rose.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index fd67494f2815..c0f5a515a8ce 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -205,7 +205,7 @@ static void rose_kill_by_device(struct net_device *dev)
 	spin_unlock_bh(&rose_list_lock);
 
 	for (i = 0; i < cnt; i++) {
-		sk = array[cnt];
+		sk = array[i];
 		rose = rose_sk(sk);
 		lock_sock(sk);
 		spin_lock_bh(&rose_list_lock);
-- 
2.43.0


