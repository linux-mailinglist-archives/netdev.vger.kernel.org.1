Return-Path: <netdev+bounces-188477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65884AACF27
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 23:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71E3179641
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 21:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097E0192D97;
	Tue,  6 May 2025 21:03:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA27472612
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746565424; cv=none; b=exEm7ZDbCJMUrFfrt1LshKXDx7xGBSQPKuU8gPyNmvvwpwmHVBDWXT+7DDsgYoymOGCirsK0Ia4mZp5nh/foHFKpNyDVev4sNA/X+gt+yVR7Rf+vcxqCSQd3OQ5C+TGg277pCRpy3iyTcrX+00ZJalvTKkV1ogdMfd99OQXMlCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746565424; c=relaxed/simple;
	bh=P/ccP/pNHF0F2hsx2I/NCsAwBuNSPxpYtsNjyMmzMHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cle8LSHI5RwUQqpIz2HlUWv5/K4NfZCJwMy1yJfGlfw0H22rdUrAoA6uRnzWgLS3EF8V54mlM+4mhQHEFecM8AW1BhQf+vJ8N6XpWixv9NNvqVsvNrpI+TzqUgMcIXUIpzyI+2L+J6I6d4h0pzAUDvf408sjVuj8Z0OYhs0lvOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736a7e126c7so5515468b3a.3
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 14:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746565421; x=1747170221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Cd+QqLSaclaP3RqlTwaQ5zmJYa2G6O+wa/d2avgEeU=;
        b=I1OoGDCTkD86vGB3fJwpCYVIjcbq92JGfVsDDDBa1DbTmYSXtF1Vd6Bev1tXvKlF1E
         cBX3WjyunTXaSfXGpCuk0DyCUKNxcxtd96axZ/fPuR0jfgIqevs/Y7JTAuTmjgy8AlE7
         zF+wi1zyuxQUlw3bGKGm1+pSOIIX7Zll8DueOQrVpKzspZIdFdQGDbYIInNbs5b3I+W4
         JflIiLfiFYgE/7g/09OngypUuJvoRXZxXeakDu5MlYhWLHjIQJHxIE5Woajqeettip/z
         UYThHflNUxCOKWn953eBoVOgioYzaSAOI5LxBu+cmwQt/DQXUkio4fAVRYcBLo0JZ1HK
         iE4Q==
X-Gm-Message-State: AOJu0Ywedfi69G8MHVHP3ud7O2zUJVW/u/sd/QMpiO2CPd8cZF87lbxg
	p12Z9P0leDBTiwqBJF8fv+a5AsfI1EDeqZjNgQjHGT8dtMZ6DRdDAZkuhcY=
X-Gm-Gg: ASbGncuSRVgbB5I6zcuCQKBvgwHHaCgk4JFzEJJ9JaOwWPO1Z714QgFPOFKcKc0amHr
	X8C9G6/dMIs0OwxGNY2dmgGr66RLno11jh6iAgLuee28Ctg5mrI8/vj+kjGzBsLY+OujKUxWNWX
	Uk68cF7UN1ZejiMUAtNPfcUrGfYNKAu40Sr4csTT3dFsSD9CsyEv6WypIg+8ZHBDR9C0YsAD7Am
	pxH6KGZMTe7NHhzfnVcjG8wMuvzKR2+m1zb4O8+ox175DX8CKPF7HGT5box26p7hp5a15WVgEf5
	44e8y6VLVlOkyRfjpir+GideUYr1BD9OZ4RhRIKjxMefTuTLclD91mJXH1fYEdW1V8Hsts40kyn
	vUptVvlzVhA==
X-Google-Smtp-Source: AGHT+IFBBgWsJC+DUBNap8tUH9FmSsIPQyECMwT2upmZ1vl6iXcxSSOoJ8NViSmPxtTQ3el8RlQQ8w==
X-Received: by 2002:a05:6a20:3d8f:b0:1f5:8622:5ecd with SMTP id adf61e73a8af0-2148d52b78amr1006397637.32.1746565421303;
        Tue, 06 May 2025 14:03:41 -0700 (PDT)
Received: from localhost (c-73-170-40-124.hsd1.ca.comcast.net. [73.170.40.124])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74059021044sm9824842b3a.96.2025.05.06.14.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 14:03:40 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com
Subject: [PATCH iproute2] ip: support setting multiple features
Date: Tue,  6 May 2025 14:03:40 -0700
Message-ID: <feace2e1ac81af7dfbce514727229a5b2767d5a1.1746565372.git.sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a043bea75002 ("ip route: add support for TCP usec TS") added
support for tcp_usec_ts but the existing code was not adjusted
to handle multiple features in the same invocation:

$ ip route add .. dev .. features tcp_usec_ts ecn
Error: either "to" is duplicate, or "ecn" is garbage.

The code exits the while loop as soon as it encounters any feature,
make it more flexible. Tested with the following:

$ ip route add .. dev .. features tcp_usec_ts ecn
$ ip route add .. dev .. features tcp_usec_ts ecn quickack 1

Fixes: a043bea75002 ("ip route: add support for TCP usec TS")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 ip/iproute.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/ip/iproute.c b/ip/iproute.c
index 0e2c171f4b8e..a692e7c47110 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -1374,16 +1374,23 @@ static int iproute_modify(int cmd, unsigned int flags, int argc, char **argv)
 		} else if (matches(*argv, "features") == 0) {
 			unsigned int features = 0;

-			while (argc > 0) {
+			while (NEXT_ARG_OK()) {
 				NEXT_ARG();

-				if (strcmp(*argv, "ecn") == 0)
+				if (strcmp(*argv, "ecn") == 0) {
 					features |= RTAX_FEATURE_ECN;
-				else if (strcmp(*argv, "tcp_usec_ts") == 0)
+				} else if (strcmp(*argv, "tcp_usec_ts") == 0) {
 					features |= RTAX_FEATURE_TCP_USEC_TS;
-				else
+				} else {
+					if (features) {
+						/* next arg possibly not a
+						 * feature, try to rewind */
+						PREV_ARG();
+						break;
+					}
+
 					invarg("\"features\" value not valid\n", *argv);
-				break;
+				}
 			}

 			rta_addattr32(mxrta, sizeof(mxbuf),
--
2.49.0


