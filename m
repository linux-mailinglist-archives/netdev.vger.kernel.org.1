Return-Path: <netdev+bounces-175656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10616A67048
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B623AB05F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21BF1FECAE;
	Tue, 18 Mar 2025 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLMs5QiG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917C81FA85A;
	Tue, 18 Mar 2025 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291451; cv=none; b=TwjEx4pYCDP0leYtQVWrmJidEBG3E7XtYf2ygyW7Vbv3lyYnvk5oDv0qr4XvLRdBBjvbDXfKYAus/jUkh/nsf8GxO0g2UJhz+Bxf7dwyuzMP/iqjJHkuXC9teUV66K02on6uCdMhI6V3NEgXBtLkrOqXee0hovRUBV4DvbMr68E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291451; c=relaxed/simple;
	bh=hGopxxqfyPTpZCBKdO/LfYEekxcpzmTVTn43r/TjjzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nVDzy9MUmzceSFZuGvk8JK6gYPBnyfe2oxMNmrLAPwdTmVjUmgWdTqtvKoduJ7kqIAG53+fK19bSGJFrf3KbKAVTFInwCqDuPTrjBk8yT74PwCdoRp9E3g6lg4BBh4eEVOLt8t+OAYVwyfqCpqE+qGGakhATY7MCtzpJZyePxtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLMs5QiG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223fb0f619dso88713035ad.1;
        Tue, 18 Mar 2025 02:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742291450; x=1742896250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr5ydRO9S4SBm+kh2AYrcino5ma1DMprXJx9fx/6uCQ=;
        b=gLMs5QiGD8BswXM7kf8Vwyzn1vFURd/veTnPNmOyBO/a9vDWv86ko4GXCkpsoT/QAz
         UQX9QmXc2rO4ONFqEWrTENcv3l3luOJmaC/KdutcZeOWifv5e1qnYgKj2RjQzm66nWlO
         HRL75XVbXAr9unljn6xZOpG7eRjADY8N5eE3LAnSmWXThlvPBevjhKF6PnaXgPcMG21M
         g/dGiM8R65fcMRFdpxumHvEd2e3QWYitzVjtDrOOjwCwTx1GGdH3wMB7iJMQAb5M7RmN
         PpA1TkYWSNzjRQuZ3Be7DU4gR22RBcHBA6Arj7qRQs+o5RhZktocEiNRjsptXlCBckfc
         6yeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291450; x=1742896250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lr5ydRO9S4SBm+kh2AYrcino5ma1DMprXJx9fx/6uCQ=;
        b=n+jYAdJLwMJ8fjYMu76OEFHCbKNLLPt4zm4A2892gFTy0qjDq4wxMyZWEUW9nsadFN
         Di7kmyxdpHxxjdAEpa+xUUx5K1jiSnjtpSiEYrIrcpGec0R89FKTfbMwgKmK5I8ouGjU
         UPmtge8IicK10nKc9u3j6wtp/dmu0eOx5bcPe2OjieFNI2SILn5o+O2ut0Y2SG/goVph
         jhzGHpCoTwE7882+YgSBD2n7RMR9BxUAvD8Ndbi6AfELv0xgS9ePixP88TYULjW1bSxl
         Oy1nguOAYMQvKyKMz6w2ux0EdmBKHc3AThS8/eCVVbVdFOPYeV003SFfu3pS68lNTz4v
         hl5w==
X-Forwarded-Encrypted: i=1; AJvYcCUUnCnZLq2lILcCwCcOeM1kA6Yh1Ig0SiNwb59l6tFN7LTGnufGjdmEIJu5pT/t/mpe7HU5XS/aATQ=@vger.kernel.org, AJvYcCV1IRMZURGC4u6+25tQEcuQ44TvtDB7uJYkbN+HII61jQq2pwxhPFr0VOZcV5l6zYPgmRLoF0Fi@vger.kernel.org
X-Gm-Message-State: AOJu0YzCxHla50iIUJYbBfx+ofbdO5IOmDPpmpLSq0Kh4IiJ++MX20OD
	wry/+SNUUknP+A/6gTXbfN2JKIezvWB++oot2Ee0ICcF3lb+HwJz
X-Gm-Gg: ASbGncudDi113tZiiZ10pysQsVIBTH1QMcKcJJPBEEQimBtLdxG+aD0S12CBOOBXwSp
	8MxNj49BB+98S7xBusrn26bXn1kiH5C7287zBXSRzmMmrMT3cvU6oek9Gq6e7j4hZKHgZC7M2+u
	sAtU8rHV/DTnvcRx2EV7mC3J1nm9aK99vMDxhxP6zuD3Gt90tLKz177/ZjGtVdO+5zbJJHKuruA
	NPc6VXrcpadd/MH9XNDk3gOop+MtNjjiYBx0+GfjGT20BLSIUy5rbZcgiHbvlu13mumje5Dy7DD
	DIzKJQ0/AcfGy/b5PKUn13yLcKas9wnyxbdExYnod07oN/CacptVhXu+6KGazHT266mqQg==
X-Google-Smtp-Source: AGHT+IHh677GH4bk3aKWox1MAPXdpCOJb6C+7bHv9pEH7uo/TsVnfepDYVk/p16ujYF+cYwIpFPLUA==
X-Received: by 2002:a05:6a00:1950:b0:736:53bc:f1ab with SMTP id d2e1a72fcca58-737223b908dmr19427072b3a.12.1742291449732;
        Tue, 18 Mar 2025 02:50:49 -0700 (PDT)
Received: from localhost.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b102fsm9118085b3a.166.2025.03.18.02.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 02:50:49 -0700 (PDT)
From: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	tom@herbertland.com
Cc: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next] docs/kcm: Fix typo "BFP"
Date: Tue, 18 Mar 2025 09:51:52 +0000
Message-ID: <20250318095154.4187952-1-ryohei.kinugawa@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'BFP' should be 'BPF'.

Signed-off-by: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>
---
 Documentation/networking/kcm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/kcm.rst b/Documentation/networking/kcm.rst
index db0f5560ac1c..71f44d0beaa3 100644
--- a/Documentation/networking/kcm.rst
+++ b/Documentation/networking/kcm.rst
@@ -200,7 +200,7 @@ while. Example use::
 
   setsockopt(kcmfd, SOL_KCM, KCM_RECV_DISABLE, &val, sizeof(val))
 
-BFP programs for message delineation
+BPF programs for message delineation
 ------------------------------------
 
 BPF programs can be compiled using the BPF LLVM backend. For example,
-- 
2.43.5


