Return-Path: <netdev+bounces-241205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D576C8181A
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758F33A198E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A3C314D12;
	Mon, 24 Nov 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buAQ4PFk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30C2314D07
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000826; cv=none; b=IJJtWlQDPSCjtmUsCPjoRHe93cNiYgvNmNqsxaXX0SkOmIfXl75fnANEcdU7m4ylAjWZnW0ziIDOUz+NmavrIMj7yzf+PhyxIDPr4veRRR/s/2m6Bpl8D5f99i8rCnplcTjVOIiybTdLm1jrxPt12wggnqki3egbNj9pylZe9N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000826; c=relaxed/simple;
	bh=jjSP/LYJNyk9jWpRW8gGli2ejZT4h4Y4QXCFB+0nMY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLor/0VNgPAgw1xnZszceHGU31ohH8g5K94H+Lx5bWRhJMomUo6pFS1TxJNdJsSM2OL4HVIuKmLXO3RQ2gzPVAlIVqUay8pSwnPbC5+rn/Li+uVEfy+bvH9Z6A1oymdl6WUzvPBZ5dXLyLSNKnWnCMfWd0PlUlrQhw1Sufp0leY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buAQ4PFk; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2953e415b27so53743155ad.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764000824; x=1764605624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JBGbhFp9ofE9mZ/RF8edJWFX3twAnfhW+YguioC3Mc8=;
        b=buAQ4PFkBITu0j3pSM4PNcJqA1eSQZ/l1YJe3O6rdDkPpjC46JRNkQuLwCM9JyDbM9
         fZLR5HndvCvd5jqFF6lsDToKlYQE2BFN8zMw80KcKzSDj6kb4X5YFDvvD+UpPK86D1cH
         vEp78Ke5rfGMx/3vOpLL7da9/zuCQOZ4YDvDeBXsDKn83vC3PBSjfkjKkloRvUsFGiYS
         D+4lfaf8nddHYlzbDkJD42lnAy+j1WQ2gS9oKAe6E+NO8/gJ37VU4rxPCYYEs3LhVaSS
         HEbHxaSEs/Fw0KEzplilb82YA2SlE7/S4VIDWU+xuC0s/pz6b93I9y3j+16PQ4tmxbqc
         jcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764000824; x=1764605624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBGbhFp9ofE9mZ/RF8edJWFX3twAnfhW+YguioC3Mc8=;
        b=Fnv/t78oLltxJ6j7r73FHjPgae7VspwG9UctQcKEhvXOpItCcs6n5oM/CAqK6cgf9J
         ufy4fXrBcpVM2wl3Q+ZYU6zXwnPk1vYJWRVe1cuZQINvmsiMfTKUAaxUZj/MAz/+sFSv
         k7HzvQ6sfC/6MswcBWJABDWWXVjuqfJr2H1qhgZbVexR++3mUqvF1gSFocf7cUlmepFy
         VcLlOP6HOeIG2PABvZvwbKEoUtsTPBGQmn+3cJTbTHZTvhmZgdW+9ijGIpwzGCU+G2QA
         3BUEHCwpm9WcJ9fkG/ZFMm5CFB6hsfobdLOt79GOzdQaNjDnJjjR2vyUr14fKNZ0iq9h
         dBEg==
X-Gm-Message-State: AOJu0Ywyi84PGL7Cv4YY4KdQWa2dIfZ4icOh3rpoKTqA1UgkcefNMXQk
	cHTq0SKmAuRONHr4BsB/nb1zpRWKlXB2Gnwlkt7ug1cn65xvX6uqeYMa
X-Gm-Gg: ASbGncvmv8aOOyxb02PCA/CvRIAO6ENI06S4tzDK+mlCd5fLhe7urHeOlSgBekT0D9c
	73JAnhEC4lJ2M/tG9dchTsSBH1U3UP70Sj44yfkohqQcfhPbGxgq7M75lWD2tCFxYxgJ/Pmu2Q6
	aQJJY82F0A1Jp4QCDoTCQzu+HPV57L1vHQ5GlZ3E081We6Jv4QgwHp9VNfTI8VKBtvE/Z1F5y77
	tk7Sm1vYb3QjXizpu65Lc2bPzshZnFkj9buMExejmx7uLgjgnwJKJ7/ieDRW5o/34GX6NGe3Gpm
	zhyz3X36dOki75vtmWPdVl9vnpQYQjlQlpYQtxlns6Z4RyCiLnGWe3jdW2qpCoQV97fCeCFFvWZ
	s5m/WOVo92F4dWVKtowmcHo+yHGryzCfdiTfiHrcTxIMol0HAcb/GVsl7gSxzkwZS03mFhVCSqL
	NXBD9md1FC+pm7LgCj1cNX3eTLVb1dGQ==
X-Google-Smtp-Source: AGHT+IFyAWItYzJREMkeo/sQHkp6vA4cekHCSsVdluSIl/JP4S//ICISujXNC1QfyubZ0laErlhTCw==
X-Received: by 2002:a17:903:2343:b0:295:68df:da34 with SMTP id d9443c01a7336-29b6bf5d332mr123003615ad.53.1764000819261;
        Mon, 24 Nov 2025 08:13:39 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b29b517sm138118745ad.82.2025.11.24.08.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:13:38 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Xing <kernelxing@tencent.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH] selftests/net: initialize char variable to null
Date: Mon, 24 Nov 2025 21:43:24 +0530
Message-ID: <20251124161324.16901-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

char variable in 'so_txtime.c' & 'txtimestamp.c' left uninitilized
by when switch default case taken. raises following warning.

	txtimestamp.c:240:2: warning: variable 'tsname' is used uninitialized
	whenever switch default is taken [-Wsometimes-uninitialized]

	so_txtime.c:210:3: warning: variable 'reason' is used uninitialized
	whenever switch default is taken [-Wsometimes-uninitialized]

initialize these variables to NULL to fix this.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
 tools/testing/selftests/net/so_txtime.c   | 2 +-
 tools/testing/selftests/net/txtimestamp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/net/so_txtime.c
index 8457b7ccbc09..b76df1efc2ef 100644
--- a/tools/testing/selftests/net/so_txtime.c
+++ b/tools/testing/selftests/net/so_txtime.c
@@ -174,7 +174,7 @@ static int do_recv_errqueue_timeout(int fdt)
 	msg.msg_controllen = sizeof(control);

 	while (1) {
-		const char *reason;
+		const char *reason = NULL;

 		ret = recvmsg(fdt, &msg, MSG_ERRQUEUE);
 		if (ret == -1 && errno == EAGAIN)
diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
index dae91eb97d69..bcc14688661d 100644
--- a/tools/testing/selftests/net/txtimestamp.c
+++ b/tools/testing/selftests/net/txtimestamp.c
@@ -217,7 +217,7 @@ static void print_timestamp_usr(void)
 static void print_timestamp(struct scm_timestamping *tss, int tstype,
 			    int tskey, int payload_len)
 {
-	const char *tsname;
+	const char *tsname = NULL;

 	validate_key(tskey, tstype);

--
2.52.0


