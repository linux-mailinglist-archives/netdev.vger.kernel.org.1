Return-Path: <netdev+bounces-241952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDEAC8AF98
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7215F3AA9C5
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCDC33A014;
	Wed, 26 Nov 2025 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYRVTlmj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D68B309EEA
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174670; cv=none; b=hrFRo4uvz4oMsHg8kacadAO5bCfxmLx2iqI1+UGgqRP8BuBr8Ik4J/7hRlCGOm6GS+4mK7WdE4vVOCh/K/eX8Dq0dodwfRE8I3IpV6mWC/L/bRM14J38x8NnGoqiM+oZlB5BbiqwUHe16ZWUStfzjeXsluWeDi949HmpEoOAsZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174670; c=relaxed/simple;
	bh=JUk+V7+BC+lkMoAifGFTRedw6UOHlW97lAtjujuGo3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u0GBKm946ewG5QEnnZqLod0/AEkTvnUQNa5hP0zxatB8ZNx9tYd97UXv/Pt1APVhu+IRErd8c5c4IpRWsjrDoh/mH3kqDpXA+Dm935/MN3j1Ebrxr3CUIVhmX+8kgbhXc0Wq1uyktyKTsUQ7YnNuWl8pLmWPitXIKTKU0TZii0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYRVTlmj; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-340ba29d518so4438531a91.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 08:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764174667; x=1764779467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YOzfVQwGYNqC1lxFkH12YuFq4cbbjh7siJwig+OWKTg=;
        b=YYRVTlmj0WXe0OGg28gHJOU4bizezja97OUEzQhNLpXNw7cgAgE4vYJMQWIjf7aQbW
         VdpL8H5gzGbdl6EgBjeOUIYBOREIyPGIU8ZAsLF/hbX9imTNo56Bd0Janql+aNU0zhKT
         1QcanX8GYxbQAunEcRNncralrW9EZdNYfuQmrcZX95jQP4EamSGlN7Ux3HddDa2wC4AL
         xn1950uATu/77O4fbjFHGrQ50RrWiTuGpD8yM+BLuf5Wi64/IOFQiIdwRYb4xQ0pEwvt
         QFH7aQaTGkp+OOv3J75B2AOMvZMiMDIODQ3ZNLbsQtoY9obpQxnV/ypd8d9EnmsarEk0
         LIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764174667; x=1764779467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOzfVQwGYNqC1lxFkH12YuFq4cbbjh7siJwig+OWKTg=;
        b=JbtmJxr8MYgyYba1r+Syh4uy8vHhBWCtJ4E6cJ1vvhKe6tJ56wBBmlU5bypJbah5wJ
         KPIUFmchFZizLygpSdIXar8Kz+N0f/PYfOAGIBIZC19qzywp5qW4be4tiWkiN7UTM5ct
         v9qI9ESzDAmAyQk0eUfhqQmFDdEovtahpgFqdGiQSc2Hd4w4eTxWIaqKctLLpU4xJ17p
         4WHbK4edRfwS9sFC6j7Mp7iFK69y/vgI3qTJ2QmkiIwozub/rD7rj6o76tYahfSY8eyn
         pd4KGipeiGDvTc+0GuuvugX6bnj2c9bCnnB6QE8llA9gfM/E1YYvBSiMKJ7jtZNfFz+C
         YW2w==
X-Gm-Message-State: AOJu0YxcX7CZNWiFH7ALQQEQTFRDwC1Mkl7XLQJbIElmnF7RshJm1r2t
	6pL48FpftrppBbvpP3PQMfF9O/p1ag6TfRvQpkYrF2XKqoGpWMFtkiLl
X-Gm-Gg: ASbGncsIhA1cNoOieJzmuRt7H+i5Wv8N5tsSHkLqk2V7Qflf9q1DgxYpnLlLdUcot1H
	crdbyO5vxsfi/nRqwsei5G9ctebEn/Kb4r86fRJtqIXEU6i3u+a2UkuFeXqLp5+VTv0oQyc9kIN
	DSz6wyT8k9ASWwo46LPPOw5XH6O+FYalAs20f4xGCm41uj6bFJ1zpqYmPJwf6zQx5x5GNaWA0GM
	AR6Rc2pummJzPU5Uz452g4suEfCPQ1DguVqBcE6YE+iKsM0lXOV4fkCyKYBXaXl531asHAkv4+3
	vG57rUJ8SHL016OTY4h5YZBRirk1ICaYIOgJC6N1q4TDEzh9MmjJ1/MGI65qVZQ/QICVjLTo2TU
	b0sHF11KNaLXXD5B6mHujgCJ5z5u2YtT40iXgTl61zQHN3izSM7QXanLGNWo/Q+bGBWovnS8vvA
	QdM8FxnnjBW4D0lnMGq8ZVtx3UF+WcyQ==
X-Google-Smtp-Source: AGHT+IHYlOs7ib3WRoxz+IosxSmgFDE9P7H1+e8rCoPRGJ8hqrHc7dD/TBxgldig3bre3IVxR56yzg==
X-Received: by 2002:a17:90b:2247:b0:340:f05a:3ed3 with SMTP id 98e67ed59e1d1-3475ed5141bmr7678530a91.17.1764174666979;
        Wed, 26 Nov 2025 08:31:06 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760fae9e2sm19829401a12.31.2025.11.26.08.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 08:31:06 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Shuah Khan <shuah@kernel.org>,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH] selftests: mptcp: initialize raw_addr to Null
Date: Wed, 26 Nov 2025 22:00:46 +0530
Message-ID: <20251126163046.58615-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "void *raw_addr" is left uninitialized when else path is
followed raising below warning.

mptcp_connect.c:1262:11: warning: variable 'raw_addr' is used
      uninitialized whenever 'if' condition is false
      [-Wsometimes-uninitialized]

so the fix is to assign *raw_addr to NULL to suppress the warning.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
compiler used: clang version 21.1.5 (Fedora 21.1.5-1.fc43).
compilation cmd used:
	make -C tools/testing/selftests/net/mptcp CC=clang V=1 -j8

this maybe also be false positive. But somehow clang - 21.1.5
triggering this.

---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 404a77bf366a..cdb81e0d08ad 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1248,8 +1248,8 @@ void xdisconnect(int fd)
 {
 	socklen_t addrlen = sizeof(struct sockaddr_storage);
 	struct sockaddr_storage addr, empty;
+	void *raw_addr = NULL;
 	int msec_sleep = 10;
-	void *raw_addr;
 	int i, cmdlen;
 	char cmd[128];

--
2.52.0


