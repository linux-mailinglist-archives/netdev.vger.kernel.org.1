Return-Path: <netdev+bounces-241581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84713C860AC
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47F944E4182
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51361329C45;
	Tue, 25 Nov 2025 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apIzVQrX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C18432938E
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089642; cv=none; b=lr3dNfPbRNBIiwPHMV6gnRzdixe6DHs5+d/WsrrgwRecpjzjTzLP1cnZfl4yDUUekRY3Gf+rWGn+q/bUKtqmIXtOv3AQATAewWqvk9ox7TZLbix++RbeXhtrHUkwOU9oLKV9hGfoh94Ut6BLm3ZsO5C5H+A3gheMenlemE8bPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089642; c=relaxed/simple;
	bh=aUplM0Q+WymYe+1A/lZP7aug9PsfhHdEn+gWO5zCenM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BtOxNx+YAqOVYQMCOQv8Egx6xghLf0dMrVRFqx/zNnxZKMVXjPobJN3ZvAYZgE7/deikJRGnQEfzX/uO8DSh82B7tRbph2T/YR6BHnpCubIBFDReEL1EEv2X9jTeCJSgyUAoTkdiVC8vlgAqIpDab/3eXxYEQUKAFjt9rQc2laU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apIzVQrX; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-297ec50477aso24475855ad.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764089639; x=1764694439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6s18FMY7uyV1u44mRCnu5uh2i4blp0jl9qxnh4O2Nz0=;
        b=apIzVQrXn1eJ3b4cYXW4b0RSsqx/8AUv0ki1imPuN0shCz6xwUOoV1nLxYy0t5EPiC
         EkT/p9BuQrPrQGG3R4Ygg37PyhJ5QkWPktWbZLC6el6QFpSKf2H+/cd3V7HGtwcyQLTt
         N5cWzIIwM8Is+1AphzFN2kc/atq3a06B1pB/gELvomI0Zz0G0mqWbXEA4vbM2M1BH06Z
         YsBElocCWuBFPyB2h8bCTe++Wt1VaVEdMe2D7Eb5w50LQf8nmRvNplXzZFFBfomxNG6k
         atW3Y4dU5NxUFK6y19R9t9ym67my3qgbTA6cMqRh8AZusi2f84j4ZOzGfDCsgjrCfxia
         EKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089639; x=1764694439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6s18FMY7uyV1u44mRCnu5uh2i4blp0jl9qxnh4O2Nz0=;
        b=hmp6/s9OpLmPQQD4Xv2EEqX2TZbWUtTwQLwoRMwQrb2pSBCgz13z95K237pooNNaSz
         zsMO5wWNctkscEbn7mqhSULCSQqwVX4jQQiXxWZUYJL2RnSJsbXSC8K3BF0qWQEzTCi8
         aTwbWthbrE9wqQVBEvMNxGlSWbDbquccvivAF1nDNtlbwG1Bbr9uqNZ6LTFEvkqyODfN
         1riwQiHaTbw5ghbzWK7tUyhYS7e03Qs0/VfZmpLsdyyIlZfpig6lDo48ZFcVdmeAhlac
         faYOphtED3p9TIDVse4n6YPcS/vwd6rSO/bMyug8f5y3Z5KaBQxvfa9MOdTG8VoojmoK
         U87w==
X-Gm-Message-State: AOJu0YyfPxb3swxGYjwi+HLbxrOofiFg3tnd7muEaczm+YFSiaJ9U1JV
	JWHR2p/9k1g1XyTpIVuC4jiaH0mP0wr4GsB0vEl9hI970SO3PfsrS0P+
X-Gm-Gg: ASbGncsaGBWrmTPFZIt2FAS0qCygd6ORzB3Jf9WEAFW9kHoP26TN/A0fUkGvO65KVQm
	kwQPQchDBElUWvMk1ySv6YcDcJOHOjoHH2fPpjsOSPS+GPjFI5SWAf69EtV/ppYINvOlks0GkIN
	ilr4poiJOiIAjbvMmr02khkVnj/bJdrMaW/kMkKuViCPlBgan6zWELHvyBf6srIsk/tp8zFPviL
	EXIyoqaMklXP6r0cNwQSZF0okKhQMDZNuS0I3Zau6c7+oWvsMpcU729XtVaw3TIHmKmB02oBdnr
	FENh+iwsowQm4Xx+kzRP5qbUSfqn8j7hTpgfv8pYMhI+DCDbSqqQzXl1rrqTNPBEq3F4T0Qwasf
	kOXFPUKe3IkPurhGXfIuu6pdbOwvYaQnsqiZ8NAkerlELmzKsmtllVcpfG72HeCs/aQFCY8xwhO
	8Pomes5fpfkTZx7Vg=
X-Google-Smtp-Source: AGHT+IHbazQEvSJes2O1nzZNAo1c74boxJ0wjTnr/HuZ/uGnkJLH8XoebhI/9J0mCujwUj3AMXkadw==
X-Received: by 2002:a17:902:f78c:b0:297:eb3c:51ed with SMTP id d9443c01a7336-29b5e38c16dmr231490695ad.16.1764089639434;
        Tue, 25 Nov 2025 08:53:59 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2ad643sm172438435ad.91.2025.11.25.08.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:53:58 -0800 (PST)
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
Subject: [PATCH net-next v2] selftests/net: initialize char variable to null
Date: Tue, 25 Nov 2025 22:23:02 +0530
Message-ID: <20251125165302.20079-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

char variable in 'so_txtime.c' & 'txtimestamp.c' were left uninitilized
when switch default case taken. which raises following warning.

	txtimestamp.c:240:2: warning: variable 'tsname' is used uninitialized
	whenever switch default is taken [-Wsometimes-uninitialized]

	so_txtime.c:210:3: warning: variable 'reason' is used uninitialized
	whenever switch default is taken [-Wsometimes-uninitialized]

initializing these variables to NULL to fix this.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
changelog:
v2:
change patch name to net-next.

v1:
https://lore.kernel.org/all/20251124161324.16901-1-ankitkhushwaha.linux@gmail.com/
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


