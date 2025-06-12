Return-Path: <netdev+bounces-196931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B20BAD6F61
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDF3176D9A
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0AC223714;
	Thu, 12 Jun 2025 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAV9KzVS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8A5218E9F;
	Thu, 12 Jun 2025 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728956; cv=none; b=lVZXR2UxY4HD8PKsC7hQxs9rCS7cA89oDA6Dl8uNDIhUjFbScWT8ASU+MAWrpJO6gQaHVUJZZ0adJkgrkUsOe4Wxm5qw/0MWaB2MVHesCrIyYDkzCY66Wi5jIPx8D67TFusU1V+Q/o1qSRO/i8AUh3UBae4SHflMMwHLPJUl1iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728956; c=relaxed/simple;
	bh=z+jyBC0rDsvIMFnB2CX5hTuZkM0uQU8PSDEQ97J9Fms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hSnvlEN8LWpMwgHa8JWDfnNYpbSbG5fX1aPlMwlcEKwntSYwnExPMDYoc43e+oyfQZa01blxtluFhnBMUhima9zMQR4PoMSouSYq1LOglnfkTshOGIkIjbnaewVx4T4h0qclWccThozcLxGMAB+0tczD2KXQ8W5FqfDahPcOEbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAV9KzVS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22c33677183so7144765ad.2;
        Thu, 12 Jun 2025 04:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749728954; x=1750333754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+c2fxGTrOu+gHD3RHbFZi/o0nuFFUaAiSBwnrt9ygdg=;
        b=jAV9KzVSLpuyVfYWWE51EhgZWxRRhWoezj2fiRkquASTFUzWkZTWuwT9HliN4ZjHIS
         KzMw4IIk3eorietmzX9iUPw81cftpBDLbfuzZldo4JtG0/tqnhGnQXZMiPCV2qP0h6+6
         HVqoovUeqzCsWzIBf0CU0QXaKPZS7jzWsLAMgCMXE9dyQz2y0eIVOlD2hL3tB/rkUYz5
         961RgI+sQpOQZvQoKS/oedtqsltB78RveFzJSwYu8uzhCld0zU9mSzNTIjDsXSC38FzW
         LDAqnPD65Xj2TC8dh5G3jAwERjZm82C58/qQI3R66IFZm50dyhs83GnEnaJhJQEvute2
         l61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749728954; x=1750333754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+c2fxGTrOu+gHD3RHbFZi/o0nuFFUaAiSBwnrt9ygdg=;
        b=p1GIlJzaZWo6GMFU1SIsFA0GjMoK8nVr2WO01FV2e04Rf0vIcsN2n1sX0ca20xg9XM
         s9H4VzF5CEkAJ/QkzunMqrM7wRo6jK4sp3umWvv+WiziM1Las9BzF9C3JrL1Y/vjzOlf
         DKGaZJH2TXRbA+VHbOez/SDKkgO9MleHNH0LPgH4NhuHYB89TxYoOkV/MP2IK6obXJMo
         rRtGXPmaAj//QAKb/Gq+11C5V+pjAxPVVheqlsyXY2CNlPbgCkqjimDaaePwabjYZ+9t
         E/B93zTN11+6j4hc3GmCXALIgvPh7Zsj69qc914ht2HAx4JtneK/nxNmIOTWPJo04khF
         YbeA==
X-Forwarded-Encrypted: i=1; AJvYcCVDYFg147Ts01OBVX7uzRNHRRV/bqN5YSKAiS7szw42AviNQIjQLPfLBKtSLIMAAL9ocQUJq7YVH/+/2EQ=@vger.kernel.org, AJvYcCWyJvTW9KWCQ0UX43xFOjYSuUZvnNefiK3SroReOdHvsjrLDCGMYlPn9gZtQOmN3guXmTwxysgq@vger.kernel.org
X-Gm-Message-State: AOJu0YyXjQHvnHOImbyFrlcRNcgCL0TFU3YFnQcVnw4C5jVLSOzT77zj
	pr4s45/iKynl1CpbiLIRlELv2ABXNjFvIyWMlX1jL60UJSfP89PRnLRa/a2anctG
X-Gm-Gg: ASbGncsgvWohcQRExD0rDHH2+Gi8BPReOx2pZsbxNBgB9PnkSQZyJl8afbIe/HefOfw
	3/GsvDmUBdHxtFpI3UmZRHBsGoGlvcz0lqkPP8VS17zQortrLascI0NDF4A0Rr458E1+xV4+Dt8
	CwDVll2b3HkP5twp0ohc/TocZ75dphjGpYPcHpS4FN0IfeKdgnUMNJTLRQKbcZooDpTFza3c3qa
	lhvm8FyYkYm9boGD+B3jrumao7zxs8YJ+bAqrhrBR1xy74PZTHZ5xFc/xArSi/6viummvE97CfJ
	eDyu1cS+olusq2dgyL/aTesjo/ERHuBGFCGHpwrKzHSyUfMT1fSsar9WxyUKcl8ztLWgiHBZabP
	fhu1SSw==
X-Google-Smtp-Source: AGHT+IF+iRobvx4n3EdTVD6DvuQh7mzj9PkD4pyqkWGBI3vAZmXIXO/ynMbvEebXoFzhjKLmEwsN1A==
X-Received: by 2002:a17:903:2ace:b0:234:8a4a:adad with SMTP id d9443c01a7336-2364ca857e7mr46686155ad.26.1749728954393;
        Thu, 12 Jun 2025 04:49:14 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c30:6c31:5551:ae55:e297:cf31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fd613cfa3sm979731a12.21.2025.06.12.04.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 04:49:13 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: skhan@linuxfoundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH v2 net-next] net: ipconfig: replace strncpy with strscpy
Date: Thu, 12 Jun 2025 17:18:59 +0530
Message-ID: <20250612114859.2163-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated strncpy() with strscpy() as the destination
buffer is NUL-terminated and does not require any
trailing NUL-padding. Also increase the length to 252
as NUL-termination is guaranteed.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 net/ipv4/ipconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index c56b6fe6f0d7..eb9b32214e60 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1690,7 +1690,7 @@ static int __init ic_proto_name(char *name)
 			*v = 0;
 			if (kstrtou8(client_id, 0, dhcp_client_identifier))
 				pr_debug("DHCP: Invalid client identifier type\n");
-			strncpy(dhcp_client_identifier + 1, v + 1, 251);
+			strscpy(dhcp_client_identifier + 1, v + 1, 252);
 			*v = ',';
 		}
 		return 1;
-- 
2.49.0

