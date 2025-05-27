Return-Path: <netdev+bounces-193763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10481AC5C8D
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 23:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5583A6027
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 21:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01943214A64;
	Tue, 27 May 2025 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqqWctTY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9EC1F3B8A
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748382910; cv=none; b=io9VijzFmJ5x/etitgV8LgmmntKwud3kTUodEF9YpwzQFpZyqL9B8wq7kENyxcU1ONWwthkvPqpoFMD/3TXAA5rAQA59aS+B6/57d2j+vxtls3hqjYyb2t5SOFhWgf9NUxEHyWGsLNWquFSOBY1tH3CFKfdY2GdQef3AD33fxIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748382910; c=relaxed/simple;
	bh=IeLBgOZuNXvj8HysuhUNZldGlm3qhHFR/ScEAKHOQzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fm9D+EXyOu7kPN8yJuHXh2aiWlKZKW+Uu4Q/XMcEMDReWi85RQeQ+GRtmCN5hiio97yl82xCZQsKm1RqkdOugBSvzwG4xVx5agKls8BR/QvVKlrKHxcHDuf41o8vx9SX/SJXVHa18tLXXpmooMHtExTJsPHnXJ3tgwaLlez/8OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqqWctTY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23211e62204so25319935ad.3
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 14:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748382908; x=1748987708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YwLDS5RsyI8FXbPjv1PHb5m+Ae4FWh2awfIQoRzPmME=;
        b=WqqWctTY1rTOiBB25OsVoAsTtoXqe53LwgIYri+wTJBAL7tuBNNTQT9+nXGXlXFVw9
         5wn5vdDnd3+s1PpJsekqN5udE17EN2+xA6Cc787rYIgD7iGvhsUWUEQPGIbEBJ2OSxRF
         C/4dS9riWfUaf570leEFFgqRrz6ZqO3VSwsVJrTdvzcNjderSdisMBI85PCEygetTvOF
         3ZLVSDiePgmY2ga1DH/OWy0+YQkUVPvyZCP0ZqejSYDi1Gh4U5Jc50yjPMXhWSjC69Q0
         4h4vnueHQFyCV0AxORmoxggQ1IMq6E2mXpuvsRxj9eAx0/qex0KfEh97UksHki07BDqR
         cJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748382908; x=1748987708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwLDS5RsyI8FXbPjv1PHb5m+Ae4FWh2awfIQoRzPmME=;
        b=ZdJibsGrCfVkCSfwy6eAgvdniWcC2gseBbQ7rfu+sakC4/Dl9BXOFtrFQTi2mP5Rwy
         yYCb7rEVMYx81ECNFrlbcuihDGRh8xcAofGCxjlDnwn9/h2YAL8drjJvm1DLLNEIL5n0
         OEmp7b8XFq7EOi40AXuFowpI88zOXKwo0u6K1mdRgeyjyuPRolR3rBpLWSQFiv2y6L53
         sDxKT3DuMeYlFlk0HLv4uUsxJtSZGjVlThK1ZkTyvYuKM9IlFPwl067eINz3USiGczw4
         lse3SPVCPq6FPN1NB9zJB7Rt1Vqv9CoYloqqT5KsF7xeH3CrrxLCeOac8pSqKTQpgBJz
         wecg==
X-Gm-Message-State: AOJu0YxHTAFN8Iuwa8MpKWwFxL/6ki2Ls6Mo/uauYrOESjHzCFn321KM
	V1h8uW1n6u1cs+sjaaDFGHI9/JLiY+7wiFFcv5EIYhd+c7y+c0xUz5n4mE4e
X-Gm-Gg: ASbGncut+n/67Tv1X3aygpnLlBqArilycW6fjg2jAigPW6wcARe9yELcn4jT4Tegy6S
	/Y1n6N0aWN7qjHTzIDjssHi8dpIxABbEoEvCXRTBdLyovZ7qfd5GqT1rb+x2iGcEkpqPm284QdH
	MXiO4B7YxCOTSzpkxp9rUFgBDNdLJtdy0GzBQX8PODYAKn9n+E0OQYAeO54022LyAAFPfwqAO46
	WJIj5IF1MiiMGZd+cT/PMJvaG92pM036EaDlkRxWfhYUUPAuLVwPHWhs52+ACNhTCKQ8Df0ZvWI
	D7ZenmGlCxdkRuRT01A7qRHytdJBoMyLHTRLaltWc9TJY72RyQ0nj10z5086PAp9TkF/vVvlXe/
	94R2xelP0Y+pk
X-Google-Smtp-Source: AGHT+IFu7zCpK1cj0R8BYjWeDvTcP0fmIRflGnZOQm33xpRWv8s8ePefjR7TydCk8F8vUM70Ib7uHg==
X-Received: by 2002:a17:902:f686:b0:234:a44c:18d with SMTP id d9443c01a7336-234a44c034bmr61761435ad.22.1748382908247;
        Tue, 27 May 2025 14:55:08 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-234cc2190a8sm592055ad.150.2025.05.27.14.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 14:55:07 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@gmail.com,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next] ip: support setting multiple features
Date: Tue, 27 May 2025 14:55:06 -0700
Message-ID: <e55dec9ff62227636a4782bda3cfa7e063e614f0.1748382868.git.stfomichev@gmail.com>
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

Cc: Stephen Hemminger <stephen@networkplumber.org>
Fixes: a043bea75002 ("ip route: add support for TCP usec TS")
Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
v2: separate logic into separate function (Stephen)
---
 ip/iproute.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/ip/iproute.c b/ip/iproute.c
index 0e2c171f4b8e..c2538894da63 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -1134,6 +1134,27 @@ static int parse_nexthops(struct nlmsghdr *n, struct rtmsg *r,
 	return 0;
 }

+static unsigned int parse_features(int *argcp, char ***argvp)
+{
+	unsigned int features = 0;
+	char **argv = *argvp;
+	int argc = *argcp;
+
+	while (++argv, --argc > 0) {
+		if (strcmp(*argv, "ecn") == 0) {
+			features |= RTAX_FEATURE_ECN;
+		} else if (strcmp(*argv, "tcp_usec_ts") == 0) {
+			features |= RTAX_FEATURE_TCP_USEC_TS;
+		} else {
+			break;
+		}
+	}
+
+	*argcp = argc;
+	*argvp = argv;
+	return features;
+}
+
 static int iproute_modify(int cmd, unsigned int flags, int argc, char **argv)
 {
 	struct {
@@ -1374,17 +1395,14 @@ static int iproute_modify(int cmd, unsigned int flags, int argc, char **argv)
 		} else if (matches(*argv, "features") == 0) {
 			unsigned int features = 0;

-			while (argc > 0) {
-				NEXT_ARG();
+			features = parse_features(&argc, &argv);
+			if (!features)
+				invarg("\"features\" value not valid\n", *argv);

-				if (strcmp(*argv, "ecn") == 0)
-					features |= RTAX_FEATURE_ECN;
-				else if (strcmp(*argv, "tcp_usec_ts") == 0)
-					features |= RTAX_FEATURE_TCP_USEC_TS;
-				else
-					invarg("\"features\" value not valid\n", *argv);
-				break;
-			}
+			/* parse_features stops at the first feature it can't
+			 * parse, rewind one argument back.
+			 */
+			PREV_ARG();

 			rta_addattr32(mxrta, sizeof(mxbuf),
 				      RTAX_FEATURES, features);
--
2.49.0


