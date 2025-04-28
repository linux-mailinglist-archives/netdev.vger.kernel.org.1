Return-Path: <netdev+bounces-186604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A67A9FDB8
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7984A189AADF
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3676F1E04AD;
	Mon, 28 Apr 2025 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2TvODcG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8754214237
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745883003; cv=none; b=XAIjhHggfMRDunKMuvYebAIsKIb/yZrFTT0u1XKzdPnoXanBRU4mS5PKngVRbHT3Kn0+Da8FYaSK2DslyForwVPnV22rBsa8RMJDWUf2rXOLCSlGrr7q1UpzsO3WOOh2LMKVOpkLiiPxEe123EmkyA3k6bzRFuMbfdo7SZNjlw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745883003; c=relaxed/simple;
	bh=9CuYW6m4/VSpoCpwxUDOBdwYdAdPbRqj0TZMJC1xP70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hR90IXg8zPschByL2ZghbafffTceDe3YkASwW8mXmV3J8qyKtAW/E+1fZg6lquKQtgACj3SmNkzCpfI8ErsObzCoJC6G9Nto2ScpV9r6wkOmQlfnMc5FbT/4cib5HJbqeDEFTYUIHZNWJTfSjxT7mhRsjGXhvnlwdy3D/egOvE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2TvODcG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224100e9a5cso65126075ad.2
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 16:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745883000; x=1746487800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LJlSSzZtxanZoWg2urG9v6N5auYOiw8ZyqeaC+iTNYs=;
        b=W2TvODcGPuoc/isbFm8mQYRtd5oS8o28qDtuvBCK2ji4GhsuB6WFmsMosFlzTI+5f9
         TdARNtO/LY1BR2e/TPW90C4pIptf9h/jZGmFxW4ssYcUsLy1nqnqat3TaoT+TaSBKYYA
         5ChtCTjv0WoE6aW5Zh+rdz/swYIjsqHoF4SKyIBWE7T6yhN05aqzcMfZy+MKxuSRJMlQ
         zXBaJYcdhRoSpJ6ZOmNg3kmh3T4VHIDxe9vYzDCdr0yOYpNtgsFsHiDsJnAlYZHAdkyy
         D4OGn+hab6r/2Bbpq+M9xWY6gyc8/wwxawVgLabSeVidUTRAcLM+6wHcw47tKs6BV29G
         tBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745883000; x=1746487800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJlSSzZtxanZoWg2urG9v6N5auYOiw8ZyqeaC+iTNYs=;
        b=GBFMkzuDqLL8PmutyEDc9yQ6zFv2h7IkKjImDGHso+LMQ/hZIC3P/jSxFKn6m3CxiW
         YBPTjHpd0fBtqZG9to2N3Mpp5g4lujqwFcGp+dwYRYUCZPo99Ao9lHeB2svwzxMppOQs
         d2/BpalIhIbNCbub4ZyYq7pAuN7djIpPuxxIkcCTseI/kCyVPOjSfazT1QhTaxbG63os
         N2lGdT2p6JDEZMMpK4vB/e51r+2UBWIOu80DZi50js0ZDhaFWVqc4oePqAb7Y7nhdp4R
         fudE3TNriq3uylxQ1UP2DpzlAEnBC1xCKRpA1vg4KjXieL4g00TNkcqF9jkqBV0JiO19
         y90Q==
X-Gm-Message-State: AOJu0YwqkBonzb8xl1Y8daP6NCOpC+Pz6EU+2PS5VyX9LoTXCsgQnpjB
	bcqS/pN5BwYM8EuiQE0WM9/ZN2REPKvQWFC+YkxFGo/TP4Uik1Sbke6vPVj/
X-Gm-Gg: ASbGncu3AC+p2ppM/wztsQEpOinSVaP7fbF//ZwRutACD3M2THqIDIrf8egQed/pALO
	uVB2FdgjfxkQdicQsfe15L+lF6t+fQdwyGQFm1hvFZQkQjwgOW4eqNbDBFkhBuuRg77SaM0FiaX
	cqUC0wE/ClegSScS0SU9372/HpBv7MswSNniGm59InJF1rUDYPk3JXnsi8tXVJYOgqmUpjj8dRu
	NL1XU2vVO89R96Nm6utW5X2SLLyGGzGRXe4Hat94b4kgGicx8tltrrKChCl5Wo7DdsZoawPWRvk
	81TPfwEH9UmZQC1cUDv1VdXxz8SoaFgTBC+Pwvaao1ySBlwcApIgmZ/IVhvDXA==
X-Google-Smtp-Source: AGHT+IH3xjmSUX9nbATTSzX1d+/tmfl4OSeFh3n2mwWzizLX8pF7jBc+QxnR2oHW46MzXl4AUgy6sA==
X-Received: by 2002:a17:903:190:b0:224:216e:3342 with SMTP id d9443c01a7336-22de6075029mr23115255ad.43.1745883000632;
        Mon, 28 Apr 2025 16:30:00 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4db97b3sm89248235ad.55.2025.04.28.16.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 16:30:00 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	alan@wylie.me.uk,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 0/2] net_sched: fix a regression in sch_htb
Date: Mon, 28 Apr 2025 16:29:53 -0700
Message-Id: <20250428232955.1740419-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains a fix for the regression reported by Alan and a
selftest to cover that case. Please see each patch description for more
details.

---

Cong Wang (2):
  sch_htb: make htb_deactivate() idempotent
  selftests/tc-testing: Add a test case to cover basic HTB+FQ_CODEL case

 net/sched/sch_htb.c                           | 15 ++++----
 .../tc-testing/tc-tests/infra/qdiscs.json     | 35 +++++++++++++++++++
 2 files changed, 41 insertions(+), 9 deletions(-)

-- 
2.34.1


