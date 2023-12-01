Return-Path: <netdev+bounces-53134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 358E6801737
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 00:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB26F1F20FDA
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C773F8C9;
	Fri,  1 Dec 2023 23:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="jinn21TH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0063490
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 15:00:19 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b844e3e817so750344b6e.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 15:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701471619; x=1702076419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdCEdkIzxRkw9uVoHT4u6L8OnkYy+pL1LkGUviftO20=;
        b=jinn21THagA2jM1x4iOjkAcl2bqiqKMktxWHv0SryX8xMq0N0kV/sNRJPRkHOSSsG8
         LuGVWXFFlaSHP0pI2Wy6LMEY1Ux6nNUl51oxFwLqmg0JNhNj0OvAa+QS4pmwJaCxDBct
         Z5pDiH/sqoinpvy6ahDAjW+VZyaUvBhAv5heWZtCKCTN1H37MLJkafDH5cWu1rXQ+hIl
         /Mlguuh0YZSc4TIwO2E4U6Ek++w1k9v7jZ6Ijzq6BUbXrtWvY7m/Y6pSV7LIZGw+pGwU
         ElioiSsnr8qpFPgDZlSuA8dLmfO/DRULgq8CWJTKLmHwMGSCLL7oe3aP5sSh94BHd+Bn
         RGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701471619; x=1702076419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdCEdkIzxRkw9uVoHT4u6L8OnkYy+pL1LkGUviftO20=;
        b=ZB8/2wa7SbNRlzptZ2eK0hcDEWn/SmKhTWMy/CavAhCKnZrDd+wrpAyRnbcxy1lnT1
         gKL3vbGTLtF+P1U2Pe7mesdi4RrOpDKokaVXVRw1aDzjwNYaUq36tgiuYGQSy2hmulbI
         2gGjsaaaRc+DC9z+tbhsWXaof0ihqvQ+H1mcy2DumvaMIlUidtZN/AP/Vf4SpS+xv4cp
         okAieutSZtDID6Jf/3bsTDRWdUGZtTN3OhQ9lt/KY2opq01hB8ADsV1CVdKZy5spsDFA
         0KiwzCFYQpqDKMfn0x/v6pQL7EOrKGA0VJEtjT3ECUVl8/G+9vXzAn7zQElJrucFCm9T
         PWUQ==
X-Gm-Message-State: AOJu0Yz3VS0t2jnbCqgnT0a9cUnz6djMFZwv40b/Ci/LY9ORepjE+sTA
	uSR2zqng02XLp/u0kyeDuN7jMJwzgyYQywI81VI=
X-Google-Smtp-Source: AGHT+IG1lS0lLtwxPZbyG4JUmhu4IideDFKndRQ0/dylXEGGAtJi91NdjLHiOrARU9PeOl2ptHK56Q==
X-Received: by 2002:a05:6808:1241:b0:3b8:4d7b:9259 with SMTP id o1-20020a056808124100b003b84d7b9259mr379135oiv.35.1701471619301;
        Fri, 01 Dec 2023 15:00:19 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:638:b3b3:3480:1b98:451d])
        by smtp.gmail.com with ESMTPSA id y62-20020a62ce41000000b006be0fb89ac3sm3632124pfg.30.2023.12.01.15.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 15:00:18 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@iogearbox.net
Cc: dcaratti@redhat.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v2 0/3] net: sched: Make tc-related drop reason more flexible for remaining qdiscs
Date: Fri,  1 Dec 2023 20:00:08 -0300
Message-ID: <20231201230011.2925305-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch builds on Daniel's patch[1] to add initial support of tc drop
reason. The main goal is to distinguish between policy and error drops for
the remainder of the egress qdiscs (other than clsact).
The drop reason is set by cls_api and act_api in the tc skb cb in case
any error occurred in the data path.

Also add new skb drop reasons that are idiosyncratic to TC.

[1] https://lore.kernel.org/all/20231009092655.22025-1-daniel@iogearbox.net

Changes in V2:
- Dropped RFC tag
- Removed check for drop reason being overwritten by filter in cls_api.c
- Simplified logic and removed function tcf_init_drop_reason

Victor Nogueira (3):
  net: sched: Move drop_reason to struct tc_skb_cb
  net: sched: Make tc-related drop reason more flexible for remaining
    qdiscs
  net: sched: Add initial TC error skb drop reasons

 include/net/dropreason-core.h | 30 +++++++++++++++++++++++++++---
 include/net/pkt_cls.h         |  6 ------
 include/net/pkt_sched.h       | 18 ------------------
 include/net/sch_generic.h     | 32 +++++++++++++++++++++++++++++++-
 net/core/dev.c                | 12 ++++++++----
 net/sched/act_api.c           |  3 ++-
 net/sched/cls_api.c           | 31 +++++++++++++++----------------
 7 files changed, 83 insertions(+), 49 deletions(-)

-- 
2.25.1


