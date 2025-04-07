Return-Path: <netdev+bounces-179536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A399A7D88F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2247189351C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 08:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E701922A7FC;
	Mon,  7 Apr 2025 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hudHDkwz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F1F227EBB
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015907; cv=none; b=MJ70YVJ4rr9OCE5b43GIc4nSb6CPh35cGbzbVQvudhVIbhIk+cJSaArfP/WbbrKuQVw6rnWPiJtB+nrrrcH+Jc+R7H679Nf2NtkD9+Vo5bAuBg6EqGWdAm51B8IDn8BdR0DCmVD3Rw9Wb05hEewtp62smdLJh50QPTQmHgG81B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015907; c=relaxed/simple;
	bh=JzUuLgQjqzsuDFsOmyFLNHi+3ZA2NXJNSaqGAaMZIJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2hPR71YWR/zEMrjwA0it/73IzCOFPeFdTHVRN6P5uZIXDfbtOFQIy4qyVZbssAiqsFtY1URCNvPkgazkUrw9rQ9EfDJFDEsY+Dgcwo/UYPnN3ghtbgylQMtKDGEF8msTI2nrUh8BFw8JwmNoZH65Po24jsZgcgoW9E3DIbG29M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hudHDkwz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2254e0b4b79so48854925ad.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 01:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744015904; x=1744620704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1uyJxUSjwirFDuWmm3Ov2pKSAd0ErZhNjYPXSZRPwMg=;
        b=hudHDkwzHMFKEzT7mdhekPHwsOQAsrP6Ny/5DVlghsRkOSCgd+KdTm8xlEVMHpA35l
         W36haTVziOQCALDdix5wP1dDRAZLH++YGAB2PVpUpxBXCH9zj+GafFSCPYUWV+RtHa1R
         8x+z41ht6Yqil3o9RLDC42HNfiHlO667FLVQFcgF+TOxW6m8KC6/tBYhtuL77nGqAH1y
         z/1EZfdPcqsqQUDnKu8k/ZyI4ujT9lM/0B++iBy5lPlzEvV2flgPJrOZrsFO4bkl0D0T
         0bd6jxcSIinf85j5ctJyPX8eb3s4jZrH2m12ebvna/fsJP9o8Ceq4GzuHSMfT0YEVPLu
         YMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744015904; x=1744620704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uyJxUSjwirFDuWmm3Ov2pKSAd0ErZhNjYPXSZRPwMg=;
        b=R6LJ6pr5onbzmyWvJjmHei4U7sYtXL+XC917tfl/SGBzTj5MeLvczlinkbhb5K4t4j
         BsvqnTbtWlD9yGMIejzccC1zy2VpLXEZFb87QyxEWNCK/jjV5gBhu1nCrbuMqM+/7Ijs
         UMo1iYFf2RoLEMvthrFXIEExC8nMIu9uQrVeMlWocEPImOpB4R7jce9Yu+tOKext8WTP
         SHa/zEGtnwVMR3CLredJmrVwLsUHJDU5/+Hd8YwGv2LahuVvz/3RMO8wibr+JEFjTUw/
         nDvIhS67daXP/ItxJ/1ug07SSDWyGx6qZRSpZQSD2VOjXunupYmyrMNzi6R89I3oWWnj
         Mm9A==
X-Forwarded-Encrypted: i=1; AJvYcCVd2YX1wi6AztT5iMsrKI3VFIlh6FiBpc1PlPik3LYD0KKVBY3EgxL84J+b8ofgo3iQ22x45nU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/wXOXQovNk57jFaUeJHMzpRKR8exZCd75UPnfT1rUBimRroLc
	8/coS9fQO+EoBIx+P3ldl5nppy6rzF7WkoOYL8+NnFbvyrfXfWuI7wtQtL9N9lk=
X-Gm-Gg: ASbGnctAq6B/jN5JWyuZvibvcIzgojnCgUSjD3Tujzn+58OXkNzHjyESSwxk6x3gzQ+
	kI3GvPwOJ40wfZliStWUXLUUB1qytgevWVMWaJq6XrYvjiffE3SaUr8M1IyCMQoNN2UBQADRyui
	sY/IhoRo2IXFoSysrLwaLO1OHf4AYX4XietVDN4dTKvfwJASgrLhCxdz4lEQqH345171DdL+hDH
	HzG/rxGhghW6gLCL49KYhoMhAujveO41RoV5YlVYawzqlmBqbf6NecqnayqpnUtm90grLtu7IHb
	6vLVHAcF6g+f5oHHVNulML2d4vd3qxyBbTJap3b4oPkVQBhIVW/vxAxsEY4+pyL72Ps=
X-Google-Smtp-Source: AGHT+IGW7/HQcOSrWsFxMUBwQZEFvu6hcIo8WL0C16qqewIUDvPZ3V176EqIWn668YLPeuSi7WpN/A==
X-Received: by 2002:a17:902:f64d:b0:220:f87d:9d5b with SMTP id d9443c01a7336-22a8a867cfdmr200793525ad.24.1744015904387;
        Mon, 07 Apr 2025 01:51:44 -0700 (PDT)
Received: from always-zbook.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229787727eesm75759455ad.224.2025.04.07.01.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:51:44 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	viktor.soderqvist@est.tech,
	zhenwei pi <pizhenwei@bytedance.com>,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH] selftests: mptcp: add comment for getaddrinfo
Date: Mon,  7 Apr 2025 16:51:22 +0800
Message-ID: <20250407085122.1203489-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_connect.c is a startup tutorial of MPTCP programming, however
there is a lack of ai_protocol(IPPROTO_MPTCP) usage. Add comment for
getaddrinfo MPTCP support.

Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index c83a8b47bbdf..6b9031273964 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -179,6 +179,18 @@ static void xgetnameinfo(const struct sockaddr *addr, socklen_t addrlen,
 	}
 }
 
+/* There is a lack of MPTCP support from glibc, these code leads error:
+ *	struct addrinfo hints = {
+ *		.ai_protocol = IPPROTO_MPTCP,
+ *		...
+ *	};
+ *	err = getaddrinfo(node, service, &hints, res);
+ *	...
+ * So using IPPROTO_TCP to resolve, and use TCP/MPTCP to create socket.
+ *
+ * glibc starts to support MPTCP since v2.42.
+ * Link: https://sourceware.org/git/?p=glibc.git;a=commit;h=a8e9022e0f82
+ */
 static void xgetaddrinfo(const char *node, const char *service,
 			 const struct addrinfo *hints,
 			 struct addrinfo **res)
-- 
2.34.1


