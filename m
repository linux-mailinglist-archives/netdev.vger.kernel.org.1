Return-Path: <netdev+bounces-146734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304E49D5551
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 23:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA41028176C
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 22:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37551C242D;
	Thu, 21 Nov 2024 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4MVQQ+w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF3414387B;
	Thu, 21 Nov 2024 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732227549; cv=none; b=t910qRwascKr8ziQGZNm4hHDot2pvbJKbE9BZ7m3zH92sURgdaSQ6iPQ2g/b+tkNvhV7o+Z+x4F7+iyoMhCG3gXS1NraVcRLjyzznvVOlZa+twOLWu164dwofeIOYTn54L66ifjUygqk9MUdEE3pEl8o3GywblIMPcFNb9uJ5EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732227549; c=relaxed/simple;
	bh=WMR4RmGFGlPT8eChNSZOr/PaAXgWJnF+bhV14k8Dh78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WC1s/FMV5HMNYL5qpKMlb0aYmfVm2q5XXZzgeDFgRgs7Tfp7r1LrIAmf2VbqJY1BewqrRs1VoMEp9juv8NPnyd13U+60/XWzJccNZATDxNe4nsmLrpVk2dj03d3+e4fe0A8QjMraIqmSCStiCOeZ4ehG9jdQeUl1O8dFAfkXqWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4MVQQ+w; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7eae96e6624so1262052a12.2;
        Thu, 21 Nov 2024 14:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732227547; x=1732832347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hZggklY2Fi/dNmVankkNxdut6MBEI7Jy0qOCS0HPHkg=;
        b=j4MVQQ+wdqJDy9qkdp6mvkHv+yRw2YpnKhUjfG8gKHPRmubBF77xOfB+3DoC83zvrw
         kxKWMJbuee01NcjeH+0WaRKMB1c4b+jW7NO9PeCTqiC3hg21+oruZKNLxi2AjvaX3PrB
         vVai5KAccuMXjxNC4tF7yHjvVOcOBUyv1YGxC4kCCHVueFkH2CRzOhVpk6bZsF3r86ba
         UZ/4O/WeDvvmgi0piJZPRMzAWUMs5FJ/qNyVYZ7eF4UhFKtKVdQ7H894fM+yw0ZMEYbh
         6/n0PxoCkJn0UwZe/DvmJ9Xe1QJJD273glNkTpb+9QRVbEykPyo4QRyY8y5XAH0oydcB
         qf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732227547; x=1732832347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZggklY2Fi/dNmVankkNxdut6MBEI7Jy0qOCS0HPHkg=;
        b=bBL9nVq8mB4co1FgxHsZi593dJX273AlD/h86LKRbkjfkWUq7G46rtt9zNTRUxSr39
         GycNr7Y5mxzQqF06ZkJInfs1SKcXa5sbLgwcJepfgrsewnWTRqz1i92VM3vcD+yNK4YK
         5DdAjrBzL2J5MWhGwaTOA71ukvZ1o6wNHO8oCODD0vy09ztUnTRxNXMeqMAY12nhvml4
         4w+Qi95L2iLbTP60DUVypHoMbG/1PHi28tmGeKv1bX0xM8X3xVnkz+FiLty5js84HTRS
         zgOxPgWoXeZq7ILX4EYRWtRTCWIj1pekB55pihhFJ3N+9LH1khUdnZG2D/aWOIf7dxEy
         UK6A==
X-Forwarded-Encrypted: i=1; AJvYcCUP2wvNr9qAGVTVvvqlTXAFxNtCY508kgOkCLVgufOPXfTRL5uETaBVTRbfFo0r1L96EJYPvFFF8X/YaFWv@vger.kernel.org, AJvYcCWwX5Zw3gOd/llyPRZ8lKYECDXtx4BusNpg3qDGXWXxGuC9qZhhELN0wfUERoAha9y7ODOuP/eOndc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqOnDb/H2Omnra4+tywoCzdYMZEsy00HQdhzB8eBctsQ9mEThA
	L6+XLMJ0Oc/lcCJE/74vBqBk8i5VjdoeJuYPJwbq3DSagYptkgnjddmz7taZwg==
X-Gm-Gg: ASbGncuBVbpFDdhwPIiRH4km84Xh4owfG57w9qACZrs1K5knbAnCv3SdUy2U1ZXv13t
	qMWMDlN7ah6MjnNgXjiSPAuDkg9o9SnBMh3oS4gcF+WdVEbS6KcEBfHuvo/cL0JrsIrRAN5oleA
	z5CH2Z1xbTvBEDlTxThnbi3zoIS5KJvOE6GqNqQ9u589IB/0QmfO6XjWTvtwLP9QuoWRjqJgjTd
	nstPfOPYB+eUB2ELLdjImiQ3Jk/3tQ9Fulhs+4OjOvosO+IDMOWRGN/K+u3fTMVepUF5dqbVsw=
X-Google-Smtp-Source: AGHT+IFnvrbKLX4Xb2+HiudnW6Ahf6zFTzKruU6142xxjYoU/oyzCbgJbCDz3GNCFUXAtJP4U3jzCw==
X-Received: by 2002:a05:6a21:594:b0:1dc:5e5:ea65 with SMTP id adf61e73a8af0-1e09e57f95dmr778991637.34.1732227547386;
        Thu, 21 Nov 2024 14:19:07 -0800 (PST)
Received: from localhost.localdomain ([117.250.157.213])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc3f62ddsm219468a12.70.2024.11.21.14.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:19:06 -0800 (PST)
From: Vyshnav Ajith <puthen1977@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vyshnav Ajith <puthen1977@gmail.com>
Subject: Fix spelling mistake
Date: Fri, 22 Nov 2024 03:48:52 +0530
Message-ID: <20241121221852.10754-1-puthen1977@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changed from reequires to require. A minute typo.

Signed-off-by: Vyshnav Ajith <puthen1977@gmail.com>
---
 Documentation/networking/cdc_mbim.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/cdc_mbim.rst b/Documentation/networking/cdc_mbim.rst
index 37f968acc473..8404a3f794f3 100644
--- a/Documentation/networking/cdc_mbim.rst
+++ b/Documentation/networking/cdc_mbim.rst
@@ -51,7 +51,7 @@ Such userspace applications includes, but are not limited to:
  - mbimcli (included with the libmbim [3] library), and
  - ModemManager [4]
 
-Establishing a MBIM IP session reequires at least these actions by the
+Establishing a MBIM IP session requires at least these actions by the
 management application:
 
  - open the control channel
-- 
2.43.0


