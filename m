Return-Path: <netdev+bounces-136776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CBE9A31CB
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103131F226D7
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 00:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AF034545;
	Fri, 18 Oct 2024 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYDAqtT2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43B155887;
	Fri, 18 Oct 2024 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729212795; cv=none; b=T1oC/A3IKft5rFupCuBXpA+UTy/upB/ywDuJ+ZsdGETZaDN/LYnuOorSbOwkL2k1Pf9MUi3LSt54Wz2F2uHKnATNl2g6uj75aM+2yqE7HkL1SXUDRYF3spFsrBoFQIQ85qvhb1/x0Bj9B8Rbd9DH81zGGLCdmkdMzLEJC3ohQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729212795; c=relaxed/simple;
	bh=StyKCwIcHfT8c+oiyibcqDLGZovNaO1pE/asYGcZzaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qirn0vTC76fYn+VOwCNhMBzNPkOJJjn5r1i4YEbkDZP7p/onirqlzR3nuC+gM3y/3R887pjTRyLiDo7LQHp+ArdZmNqWwDt2ZXjgzLMT0XvEF3M1SzzZn4OhLTXGI1BIlD/qlGbJznfXZIxMRJDZAhrvoGtTtJqE24tx1eWQfSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYDAqtT2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso14536415ad.2;
        Thu, 17 Oct 2024 17:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729212793; x=1729817593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CWA6I7sn0KrpsQZLDDiKWms4i4J3QDzTseMTC7YriGs=;
        b=SYDAqtT2OqJCwa8FpdkYlzpaLE5YF9BBAgRJmg43iH+HK6qWib5u+T/nWL++/KA6Kc
         D+TdeOVC9/ZI1XL9vAacXom4prwY265UjaASDB1dHhSvG6xqe+LOAZf0/3wKGpTh+hyy
         ZNC6z0qeLlG2YNWf5WCyo8UtVRgt1P5V4l6XzZnhpGu5IwnrFpmFuQPDk892Z/3n5WgD
         K1XM3A1kaZgaQt9MnxQWMDSVNfR57KSeARobfqHkFiv6l0QSIr/KBR5x8/PTImcBlvoP
         vet9cVbbJoCPcusOQKo0aS/EUKKM0U8BeqkSYQnaM489D8hTykiD3fSZo8OIbaxCW7Ng
         jSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729212793; x=1729817593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWA6I7sn0KrpsQZLDDiKWms4i4J3QDzTseMTC7YriGs=;
        b=XaCSXg4z0lFxnnyWNEDPzlQJRRbJ1lUWy+lnuwm9oK0Vj2Ugr3HIdCAgQjUiKeHRF9
         puzFBtYUCK06U4w6jqKiFzKofR4l8taEBHlZzEnlWSxfhcLRL5O6g6j6f+0/ETg2jP6q
         mBsNVTTe0UmXO6a6vsvkYPP1z4dKj1cHq0btiiCWgcO4CeViyopO/sZOn7Lb78Mz8ZfB
         6Jasxm0nD8PpPoSYlIAvCrEy7QLxZWT8ChfH1uYCnehWl1H6fJSOF7Tk17FND2fpIKal
         6umYwLsu1oCsiiiJrPMwmpuhdm8lEfgEgkRU8WP0bsTgLavpkSDMLNCZwlJiiJvDjOCc
         tKPg==
X-Forwarded-Encrypted: i=1; AJvYcCUfiANd61fZAvHLh1IisdfOlg2Qz7n+Sg48fcxVQTxCo6+tiCQONYK/OVom3FP7nSOdP10m71CTdAUo8IY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+tx9LWop9XytZQoBIBECGgUq0vzZuBV7LNQtPbB8/brx9cQo
	s1F+VEBSzNnFucF7j8by3hiAzTIYW8I5rY9jkZ4Gh2lCWPj1TMf2cJil95bdXJ0=
X-Google-Smtp-Source: AGHT+IF3FcgiQplD+nmcJZXp8kC5+Ecx+S9CWITAVd+DjAF4EobTkJnuJWnXCT9ULROc8aw00LMVaQ==
X-Received: by 2002:a17:902:f68b:b0:20c:d76b:a7a0 with SMTP id d9443c01a7336-20e5a71ec2amr11661375ad.8.1729212792953;
        Thu, 17 Oct 2024 17:53:12 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8f99c3sm2298915ad.194.2024.10.17.17.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 17:53:12 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kevin Hao <haokexin@gmail.com>,
	Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Antoine Tenart <atenart@kernel.org>
Subject: [PATCHv2 net] MAINTAINERS: add samples/pktgen to NETWORKING [GENERAL]
Date: Fri, 18 Oct 2024 00:53:01 +0000
Message-ID: <20241018005301.10052-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

samples/pktgen is missing in the MAINTAINERS file.

Suggested-by: Antoine Tenart <atenart@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: fix alphabetical order, make patch target to net (Simon Horman)
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44d599651690..e5dff2a7b868 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16200,6 +16200,7 @@ F:	include/uapi/linux/rtnetlink.h
 F:	lib/net_utils.c
 F:	lib/random32.c
 F:	net/
+F:	samples/pktgen/
 F:	tools/net/
 F:	tools/testing/selftests/net/
 X:	Documentation/networking/mac80211-injection.rst
-- 
2.46.0


