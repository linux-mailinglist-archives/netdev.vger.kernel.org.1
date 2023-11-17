Return-Path: <netdev+bounces-48754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C1C7EF6C7
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBC41C20926
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CE94177B;
	Fri, 17 Nov 2023 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="SAvVAj92"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4B5D57
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:12:31 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc3bb4c307so20165535ad.0
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700241151; x=1700845951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsXp4akWhByUsbhRVOnU84CPXghQ4aI2lN+tCctcdH0=;
        b=SAvVAj92HZ1HS6L78aWxMpa9vL0HjaFNGoE/xzkniHjbft2fBCxGAKVC3fDWIMtz8T
         0Q8Gdwus425xXVjB/oaD3Vk+F9eHq9Zb5inaJy64cF4HA0wppnlNMlW9zZxjJnEsF0KJ
         GeOcb3Slo1SOYuGq4uM3N1p7yVi6nIDt9e63G/i4iu3QXq0pYDrIabjgXhMGa81+QCQP
         c0TO+NMNcWbkhocxVTyxNByNQQSe1q97mq+BCJIUuPSOHforYwoteZPVEaqxkN0fCp2h
         Qqj8obZYP9b+Ax2JoRO37LE1HJ44tJmJsLwwGsa421F8OaQl8lHfeQePbB7XOUAF0Nlw
         4RIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700241151; x=1700845951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsXp4akWhByUsbhRVOnU84CPXghQ4aI2lN+tCctcdH0=;
        b=LJhy8c2Uuoqv1GgR+tGdJ9XwRmPXmI1A5JS5XAk2cFM/lz5Ya7skuM39gTLV9ji5tq
         c06n/0gW/dHzYJelighYzc0YwK8ufXHxja+Byq8ppWFvy6WHNRrUn3LthBigSY6PtLSm
         VOLfwwsl6fcKBpN4UApFkwh4SgoX3RA96DBFNI/cBkk5Ma04zixZj91vgHDADLAtDbpw
         zQjglemvIhoXK061MNPTziFviHmgfQ/wO+aEXUwmhuS4K3vr8GvRqltZ9U/YnqvSBzCN
         zb+5v0ov+4CzRk87AgC5Q+BeHCvMgg3OAkEeQl/BolTaxlWSgrfGAygHpHQBU+TanavI
         61xA==
X-Gm-Message-State: AOJu0Yy6j6seICyf3lZW/S3oGCCz/G3wKINZYYxwP503p2f5Z81O7oHi
	ejErjviltUgeKlZvn1fcWQidjU61L1tIlefRTuw=
X-Google-Smtp-Source: AGHT+IEzO7OOtRz7VaeGDR7n3NTuNYAzXgo6/Y08x7WKenl0GXzaR+ddYY2iPY3JBetDqAL8dTTk6w==
X-Received: by 2002:a17:902:ecc1:b0:1cc:6dd4:5955 with SMTP id a1-20020a170902ecc100b001cc6dd45955mr287585plh.19.1700241150708;
        Fri, 17 Nov 2023 09:12:30 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:49f6:37e1:cbd9:76d])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b001ce5f0de726sm1343979plc.70.2023.11.17.09.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 09:12:30 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: [PATCH net-next 1/6] selftests: tc-testing: cap parallel tdc to 4 cores
Date: Fri, 17 Nov 2023 14:12:03 -0300
Message-Id: <20231117171208.2066136-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231117171208.2066136-1-pctammela@mojatatu.com>
References: <20231117171208.2066136-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have observed a lot of lock contention and test instability when running with >8 cores.
Enough to actually make the tests run slower than with fewer cores.

Cap the maximum cores of parallel tdc to 4 which showed in testing to
be a reasonable number for efficiency and stability in different kernel
config scenarios.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/tdc.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index a6718192aff3..f764b43f112b 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -1017,6 +1017,7 @@ def main():
     parser = pm.call_add_args(parser)
     (args, remaining) = parser.parse_known_args()
     args.NAMES = NAMES
+    args.mp = min(args.mp, 4)
     pm.set_args(args)
     check_default_settings(args, remaining, pm)
     if args.verbose > 2:
-- 
2.40.1


