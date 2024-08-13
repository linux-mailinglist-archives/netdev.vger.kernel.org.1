Return-Path: <netdev+bounces-118133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF00950AE7
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 19:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FD91C210F5
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B141A38CE;
	Tue, 13 Aug 2024 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="r0g3m8Go"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D525B1A2C21
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568384; cv=none; b=YeCYAs5kjQNXAmu20tE7jbf14AbzG2baSV7ZzaMHfQCumfbLJZ4uZHY2g0njX9e1mmUYHmqNQv6bTvttXWK53bx0yayn1+h6Mna43KZQ6w+EBy5ZK1eLDwkSbuAdcPxhpy9fnPHdhF/TAJVSKj0YEyJVynSWTES8q2ZqJA1Do34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568384; c=relaxed/simple;
	bh=YzTZh9n/Jm8fXEYYAXqDmmy6YN5B2kitzFF1gkQo49Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=haU+GzoZBGvnBv6NsuFzxbzIw/13SI0KriSQBYPwHvSQY8pGXF3APB+n79QphDV2BVuniNVjXRf22Ro0vnzTB2jFWO55WDVNMd36zPLpQrnVwTaQTIYRnRMoutoZnKeaXbqRer/ti7z4CxR5IhhJPqBVinMyM02vXW7ccaS1Ys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=r0g3m8Go; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc611a0f8cso41824365ad.2
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 09:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1723568382; x=1724173182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v9vIgsxLfHWGLUUi2T2bTTOZA0z+DnAhZpLkPoUEtWs=;
        b=r0g3m8GoM0Bq+T8+gJ3ssOIK0i2fgq+FSm+wapTfG1lAVQ6JjYWGYfyAcL09lY92HW
         9yd1aYQMplal0OlCgqI4OvTw7yoGYT4Pr4Z3XNuK5TWm843REvttMfjLAWkk5HFGgGze
         wp2daRMOu3BiyhUTiadRGNZRfZ2qiwscGxTUUYar2sRDtCd96DwKtRIY/oM2dXitY23n
         SBkdW0wRck1lgoMpUyLKl6X6RtfOiVvp2qceAI2TBQwR94MWM34LOj0aeUuMRKi0jz0H
         K0ihp+ixyZSUgNKMLlpQjG/j9yG/uUB2NavpKMgZhJQVYm4uAS3NbXV+yQ69buIu10LA
         I3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568382; x=1724173182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9vIgsxLfHWGLUUi2T2bTTOZA0z+DnAhZpLkPoUEtWs=;
        b=krJ6Pz4/Su5oEb+qukR5z3RkWyxiwRG0CM9bvaE3r1hmJ0jhyCNRobEda3QwL/7f6F
         7Y7fa0alUDFpKRbehH3r6E2nXLklRrv03ddi0ZJj85V1O0Rk1yyuYDNkaFj+bHHHUMXe
         EBAlyooWBJPuAqx7++zLKw7+GEFWvgbjjvvcMV7EKVkWjEMv/AA2jdJS8oFpb2ghgfnS
         bkxGqr5/1AWanZwA3gJyleuPkeOmec4P1e+6G/6O7vR0I6lJGBveVmWMxrHj8ifaH0Ob
         WbFrEQM6QmiLJzgpqoevXdlXFaeJYqQgZ+JCfKkMZfFZ15nuGlEECDuj5G3iFeRZ3T6r
         oYog==
X-Gm-Message-State: AOJu0YyNqGqmYicdredJ249gJG37r3j9FZ9Wgt+ogzJqlVEeZyebdWD4
	Xu0Eyruk+PFh6B4KiR2Qtynf6rA14HqeJRKcAqA7nNfndOztBXK+t4aeSLl0F0/zfrEltS2wASV
	U43Q=
X-Google-Smtp-Source: AGHT+IF7eRD2i+LWH+0zKmgvWisTMpCF+ODNQM7LMWcL+FqKjN9YwXVEuipZ5wT5q0wQBH/4Cf0X1Q==
X-Received: by 2002:a17:903:40d2:b0:200:869c:9602 with SMTP id d9443c01a7336-201d6463c8emr1448275ad.34.1723568376060;
        Tue, 13 Aug 2024 09:59:36 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a9357sm15869855ad.164.2024.08.13.09.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 09:59:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC iproute2] include: replace htobe64
Date: Tue, 13 Aug 2024 09:58:50 -0700
Message-ID: <20240813165925.12345-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PDCP code introduced rte_getattr_be64 and that introduced
a dependency on htobe64. But iproute2 already hadn htonll macro.

Move the macro into an inline function in libnetlink.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/libnetlink.h | 23 ++++++++++++++++++++++-
 include/utils.h      |  3 ---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/libnetlink.h b/include/libnetlink.h
index 30f0c2d2..b0e3be3a 100644
--- a/include/libnetlink.h
+++ b/include/libnetlink.h
@@ -13,6 +13,27 @@
 #include <linux/netconf.h>
 #include <arpa/inet.h>
 
+static inline uint64_t
+htonll(uint64_t x)
+{
+	if (1 == htonl(1)) /* is this a big endian cpu? */
+		return x;
+	else
+		return ((uint64_t)htonl(x & 0xFFFFFFFF) << 32) |
+			(htonl(x >> 32));
+}
+
+static inline uint64_t
+ntohll(uint64_t x)
+{
+	if (1 == ntohl(1)) /* is this a big endian cpu? */
+		return x;
+	else
+		return ((uint64_t)ntohl(x & 0xFFFFFFFF) << 32) |
+			(ntohl(x >> 32));
+}
+
+
 struct rtnl_handle {
 	int			fd;
 	struct sockaddr_nl	local;
@@ -277,7 +298,7 @@ static inline __u64 rta_getattr_uint(const struct rtattr *rta)
 
 static inline __be64 rta_getattr_be64(const struct rtattr *rta)
 {
-	return htobe64(rta_getattr_u64(rta));
+	return htonll(rta_getattr_u64(rta));
 }
 
 static inline __s32 rta_getattr_s32(const struct rtattr *rta)
diff --git a/include/utils.h b/include/utils.h
index a2a98b9b..59bfd294 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -303,9 +303,6 @@ unsigned int print_name_and_link(const char *fmt,
 #define _textify(x)	#x
 #define textify(x)	_textify(x)
 
-#define htonll(x) ((1==htonl(1)) ? (x) : ((uint64_t)htonl((x) & 0xFFFFFFFF) << 32) | htonl((x) >> 32))
-#define ntohll(x) ((1==ntohl(1)) ? (x) : ((uint64_t)ntohl((x) & 0xFFFFFFFF) << 32) | ntohl((x) >> 32))
-
 extern int cmdlineno;
 
 char *int_to_str(int val, char *buf);
-- 
2.43.0


