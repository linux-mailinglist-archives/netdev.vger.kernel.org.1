Return-Path: <netdev+bounces-36383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F817AF719
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 02:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 02BC728289B
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 00:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E4C7E5;
	Wed, 27 Sep 2023 00:13:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6910F9
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 00:13:26 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432A15581
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 17:13:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c451541f23so77829185ad.2
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 17:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695773604; x=1696378404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Le/c0YgktUnEDcOh4FSJ0sBiH21QKPiXLtB2lr2AvBc=;
        b=TDibrhCJcIJ2UMz2jtMZhFFNAXJcmIB61kViUcrVknlVr7pUTfOCxJq+IG5TKf5pgh
         MpMospYlMmphF+6Ok55Us38Cr74je2qFKJ9w8k134uxud74qkLQxhit1WGAo5zUiMPfZ
         I0FFhtt0twtT3od4xa7ePsHGutIiD8aneVsV4cWSMoQhA27fova2kloPIuvBJAPikKJc
         kCjVLmtIV74JAneDo0CjvzUwMc2C9IIfLkHNdG2BaSa1YETZPPBO+zceeGJrz/LHpQVY
         9hYw7TqVxDsO3+hCTt5mrY8zT6WKNa58CrPVbaHzH6t8cxmvfUcTFckcXIMimeNCQzf1
         m2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695773604; x=1696378404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Le/c0YgktUnEDcOh4FSJ0sBiH21QKPiXLtB2lr2AvBc=;
        b=J2bDyj9yTU1GvYPYyr1UbiCf25qVHkrZ89uzVeGs3pYaYBgK24j3RIQr+eCu1qFLiA
         bHCh+geC33ACPa5U0jFalTAc+T9CNZU3UXyZUZoPGRlifmruLY1zBwH0o3WnB+yLQY4v
         8JfQnGzQj7shDzXedt7SVpCOGyEZZLXenE3WVxJwQYrE+kmXkM+4Zw+UB8M+qJR6v0dU
         MafFId8+aqCm7BhXrlOwa++Iq2ZrCXg4hhFzswrd7tyydEn0MsyvAwa4iS/dbqzi8Tl9
         GVUtUkiHmnNWkpmMvSWlge0QdSvGbdCegfUBFUY/IrfGmgLHdckK2OtCPG/AfOTEHpO6
         /pqQ==
X-Gm-Message-State: AOJu0Ywi9+NKYWojUZfFjMpNQu5SMInptwidPkqzYj9WLAtGfXwPuEkY
	1TSKAXWTYH791JyDidUBn0FP5poFFLU=
X-Google-Smtp-Source: AGHT+IHZte+tfqg1S1fQiq/biwIqcnyw0fdEHy1faVZZfp8bNJKkeSfwaAZLd1sC1yNax9O4IOXe/g==
X-Received: by 2002:a17:902:eecc:b0:1c4:172b:2f7c with SMTP id h12-20020a170902eecc00b001c4172b2f7cmr353100plb.0.1695773604540;
        Tue, 26 Sep 2023 17:13:24 -0700 (PDT)
Received: from wheely.local0.net ([203.63.110.121])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b001bc18e579aesm5623333plj.101.2023.09.26.17.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 17:13:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>
Subject: [RFC PATCH 2/7] net: openvswitch: Reduce execute_push_nsh stack overhead
Date: Wed, 27 Sep 2023 10:13:03 +1000
Message-Id: <20230927001308.749910-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927001308.749910-1-npiggin@gmail.com>
References: <20230927001308.749910-1-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use dynamic allocation to reduce execute_push_nsh stack consumption
from 336 bytes to 64 bytes, at the cost of introducing a GFP_ATOMIC
allocation.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 net/openvswitch/actions.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 8933caa92794..af177701a606 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1290,13 +1290,17 @@ static noinline_for_stack int execute_push_nsh(struct sk_buff *skb,
 					       struct sw_flow_key *key,
 					       const struct nlattr *attr)
 {
-	u8 buffer[NSH_HDR_MAX_LEN];
-	struct nshhdr *nh = (struct nshhdr *)buffer;
+	struct nshhdr *nh;
 	int err;
 
+	nh = kmalloc(NSH_HDR_MAX_LEN, GFP_ATOMIC);
+	if (unlikely(!nh))
+		return -ENOMEM; /* XXX: should this skip action like clone? */
+
 	err = nsh_hdr_from_nlattr(attr, nh, NSH_HDR_MAX_LEN);
 	if (likely(!err))
 		err = push_nsh(skb, key, nh);
+	kfree(nh);
 
 	return err;
 }
-- 
2.40.1


