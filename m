Return-Path: <netdev+bounces-226364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6537B9F964
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D56B7BC529
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 13:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F0A2264AA;
	Thu, 25 Sep 2025 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AR3y7+40"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378062356D2
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806924; cv=none; b=oYxf5wwJeaMgBW/2XPOwEDvFrevDBvnq54a69V0zUmkb3mpDDkMqsnLqsBpWg3epdGXe2Y0Oo42h714ZLS/3qkg+C9CSyWmqZT37q3Vuzy6jehyDBwlrGyKysnAa2V+LW+qzD33qqBY7QRCQSAXZaJ+WdmS1001tF18TeoQBvH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806924; c=relaxed/simple;
	bh=WNzxPrFin73Lh2ypAKh0zFTGhRAVwxDD1dobdQ9kdBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TPZbI5zGpUJfECaymtWo3OpyRK7YnnkMWVlcmg6OEFFWLeDMWweJ3eV9bHpxFIyMnUtG7lqljkB9hHpViwCQM6ioD2B224ZCfN6gIEORmCTLW5vOK8LqW3VQtoEadSEVLo96VOXuHxm7hMpSv7+6seo3cLOjw+wVpnfDw1gNyoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AR3y7+40; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so1582847a12.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758806921; x=1759411721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RIjBW0HGJ1nhvOGLp1W0sfAHAgMMEq0zVvUkf/NQa8k=;
        b=AR3y7+40bS4vLrdByw6VpDa3ZXTdOXtstO/0xWrva5oNUBYV5ZtTRdRvK1RlMecLX3
         /UgFk5Et6I/DGiI2jid3F+kvfNLBuY5laGTMPcojrOY16dToUiCWmakcyffT2hLJjWTa
         Tmt5IiUL843rxtWTgMZiRBoQsTtNzbOC5Ccp+qrbB7SPObD5uR0ago8OyTXOjmL0C72i
         OE8laPZApuUHi7fVlbTlWCUvxH+FrC40VjtKViWGK7DI/k+K0H4Cd1bSGli7zft8kK1B
         XWiTx+DXqGgxOMY7fUt5nZM1tpPBhxEvmH5RcCASSaIO3Flzx1uRDG8v6weWbvScX3aD
         WzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806921; x=1759411721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIjBW0HGJ1nhvOGLp1W0sfAHAgMMEq0zVvUkf/NQa8k=;
        b=B3fd/LlFS8xnoJYJYyAuD5iv1cGt4sSUUEokIq5WMC0AkFRgm42O012xZ0m9I6eoO1
         jt1sgVGiRpa65ydnQO8a1TAhEtIDQHBTmmcwhry34wMHo1a11u1jmhDr1w7pIFndnkYM
         dxUxYN7n5kqkajRl13uqfQpXcC2WWlWq+bWuERIa3AJuLcfw5IYaSbRgoTjeN12Hnz3x
         X+BXxlzXg0s3ela9itMbGVa8NYccSJqpoHU5383zEw0NzFV3yMwRCDLd6sE0yLx5jLsI
         CBEiGSYjzmy4fva9lJpBywyDzCSnNguDYAO/n7o/kzkF34GeGmn84sjZ6lBFjijqLHrp
         7/4g==
X-Forwarded-Encrypted: i=1; AJvYcCUrlRZ9UUmoMr91/f4nAt7Br5AFCvxVhJrPXtSaWcVPwa6q2x2e44wNpTrJJLokOH1vHv0CPCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFDoSmo01ViKEP7YOZ5mS9FtUnmL6tqzTIHEmzziO5ODpJ0xh2
	Bbd8WZOo5jZQCLb2q9nHsyUAziqNv3fBl2uQ4mBXOw7E7Oru9GrGX5KL
X-Gm-Gg: ASbGncv+DS7jI/TmphO7O/z9dS3SHSGgonIJV4VZr6DXJAxnGva8sXfDPwXVPeNsBbk
	wDeZjyIifqOBboLOT+B5WiSiYP5knJTk77HI7S3IOvUcEJn7urrJCq7MmWFRewVWFJFnzdu5mpR
	H0wk+B6Z6yJEUf6sxoAKa+s62v1kVLw7O16EnKIbqH3xflTWzBghs1GQyQBq/l7qjgXP/UXsNDd
	DbETczSH6PSY5me2uJ+bYIX+WY1+lGQvz+LLNO/rJbJGrJ2CLxpbrDm2Ky/ZCT0iBU55MKYsVIO
	b3lfWGdJa50LrXFnctvTFMkFRShihMDNbWTO6AWmpjWzmgIYgIUTmlErV2svoWnSpG0k4t+FLhc
	fppaf3dvFCDoUjiXlglZxZMe3nrOp060LwfvhAfn+SEppF0n1Q8rwSJW7VmMJzDoJ7lr4btfDxj
	Z0AESyaw==
X-Google-Smtp-Source: AGHT+IE3bLNJPUzSKiXc9lkzEM/Izf2jTetxO9oV5D9S6+ZprF/oHUQ3nKipbH/bpNZu/lVBwAtFEQ==
X-Received: by 2002:a05:6402:348b:b0:62f:32c7:6c2b with SMTP id 4fb4d7f45d1cf-6349f9fad7emr2672620a12.11.1758806921247;
        Thu, 25 Sep 2025 06:28:41 -0700 (PDT)
Received: from alessandro-pc.station (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3b02d8asm1185354a12.44.2025.09.25.06.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:28:40 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftest: net: Fix error message if empty variable
Date: Thu, 25 Sep 2025 15:28:23 +0200
Message-ID: <20250925132832.9828-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix to avoid cases where the `res` shell variable is
empty in script comparisons.
The comparison has been modified into string comparison to
handle other possible values the variable could assume.

The issue can be reproduced with the command:
make kselftest TARGETS=net

It solves the error:
./tfo_passive.sh: line 98: [: -eq: unary operator expected

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---

Notes:
    v2: edit condition to handle strings

 tools/testing/selftests/net/tfo_passive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tfo_passive.sh b/tools/testing/selftests/net/tfo_passive.sh
index 80bf11fdc046..a4550511830a 100755
--- a/tools/testing/selftests/net/tfo_passive.sh
+++ b/tools/testing/selftests/net/tfo_passive.sh
@@ -95,7 +95,7 @@ wait
 res=$(cat $out_file)
 rm $out_file
 
-if [ $res -eq 0 ]; then
+if [ "$res" = "0" ]; then
 	echo "got invalid NAPI ID from passive TFO socket"
 	cleanup_ns
 	exit 1
-- 
2.43.0


