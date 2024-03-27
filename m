Return-Path: <netdev+bounces-82463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0631288E4A5
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A46D1F25B8F
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 14:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A16B3A8E4;
	Wed, 27 Mar 2024 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d85pcWdh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA27E1EF0D
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542704; cv=none; b=XnU+BA/KQrUXwPQQ7Nlfd6/S1QtPAdr9o3m7AZ5pTY4JDABdT35HXBI3PpHNdZbE1RF3uLbGT3EpRqW1Hi3qfIledMjIufol32HV+iSQF7maeqjmId5xf160Vb5MbxBwaqJMWMlzv4GFVV9xa8kok+6pRa7paCZqNU8dG9eSZdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542704; c=relaxed/simple;
	bh=MVRo1FVaNQkt6cygR/FZtAHMjsfJUCgUtoJADLDJUfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B4oz58FehIcRE0zPUSmW9hXynPLl5AWkpj1My1LJFcYJ5mW8CqlcD9FnIuD4QTmi7B7R4+6gOyAPx/6hb4tjUPkzWg7cXJMuWMnjadxdqNpkP0ZdXyLysFLmV6WE9x4dG9ipgTSjK5bbq2vyCkbCkyPHYWpDr0Yg2iXVhqvfr+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d85pcWdh; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dff837d674so52694435ad.3
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 05:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711542701; x=1712147501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t5Vhd35Q0Ojrnz32o7q4ugHp0PTDWaaA9QvDHNSN3rQ=;
        b=d85pcWdhaZQGcBs98gWjUyAwBrIcGnvojNu2ztFAq5AI7Ll+wIfNyoK2aFXpCmlO1B
         sGISK741CNbfU48Yd7KBT/ZdX1SmPkTScd+hsFCHkJ7Z6yZ47XZWHs0pWzFDxHAwyHhn
         BTkBHhPtG+nZctTkCRYFjmzzvuvgREgC0Qvc2bCcuAUVur+QXUL4EuC/NCkMeDymKgoI
         iCz06gHhPmxVj65x/fE/QYm9sm98TvwhA/oumR6z7pIWNoriAP1xvzD+mNdGUFzjE4AR
         O2h4LVSmjROLBxiEHVdWPfNZA9OcUVDuqNw9+zHLmGi+KJlS5He99BfuUAM2d+jQ70Zg
         41Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711542701; x=1712147501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5Vhd35Q0Ojrnz32o7q4ugHp0PTDWaaA9QvDHNSN3rQ=;
        b=OJ2I+RYZwUlRq/iu4k5dn8hS/nyVgRJAiLTWg9J2huw1Qm6yzsdIwcp938g+5pyO99
         Fg1Xq6k57aNvoeNmtkpWWqCiuPCGpMtTv1RBPpCwXbgeqOhZI/gjMAv12g2/I4C4+OUT
         DW+h3377PfotdI4iuO8kf/1MZzLoXc9+8BcjTHEDRSJLPDP4s8+BPpd2gQtmGN0zQbKx
         iXMN+hAQ1sc8LVHASgOXO0p/K/n9Bmw7WFiyA1XCfhI1/H4ULkV6uPJZxdh5/1Hpu/lb
         upBAArBPReLn8dsRcVG/P3o4wIdmEvoEoWqqHNSJVsbMa3usf+MkJDMHuQGDhZl9KZJB
         Z3MQ==
X-Gm-Message-State: AOJu0Yy4o9bsaqgUAumKqHSYMIM1tKxcOxidtFrd2A1xNKuQgJWJSSR+
	2pNNHE+F+jBxirDzA/KSfTvw0sTD/Uc6qLSVbhGdwWRNCbUHBmft0gmn2W+5lLQJWz1t
X-Google-Smtp-Source: AGHT+IGyfL96nXP6BkhZifAGCmLmGDUFZpSwcT2pYB73q6UCXAaii+uX+WH0gUjcgCfQAj6tLbNPcA==
X-Received: by 2002:a17:902:ab94:b0:1e0:c5cc:d7cc with SMTP id f20-20020a170902ab9400b001e0c5ccd7ccmr1066773plr.64.1711542701457;
        Wed, 27 Mar 2024 05:31:41 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x17-20020a1709027c1100b001e197cfe08fsm1356771pll.59.2024.03.27.05.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:31:39 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 0/2] doc/netlink/specs: Add vlan support
Date: Wed, 27 Mar 2024 20:31:27 +0800
Message-ID: <20240327123130.1322921-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vlan support in rt_link spec.

Hangbin Liu (2):
  ynl: support hex display_hint for integer
  doc/netlink/specs: Add vlan attr in rt_link spec

 Documentation/netlink/specs/rt_link.yaml | 80 +++++++++++++++++++++++-
 tools/net/ynl/lib/ynl.py                 |  5 +-
 2 files changed, 82 insertions(+), 3 deletions(-)

-- 
2.43.0


