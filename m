Return-Path: <netdev+bounces-36387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5221F7AF71D
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 02:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id F209E282523
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 00:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326D51365;
	Wed, 27 Sep 2023 00:13:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837311118
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 00:13:34 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FEF558D
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 17:13:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5db4925f9so72365445ad.1
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 17:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695773613; x=1696378413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTg9psR2+piEPoaSc9Zx3utTOXhQXIIsVJjumDfUeU4=;
        b=PV07f/f+LxbmnVsPHQZrLkh9cYaIu7o7MhxTS/6L5bDsReQ8WN+aAag+ircaWf7Jap
         FxQ4+7NMXIMpCI5O0rCdCL8tQw7FDRuxgpx5wHOCRl4yfj8SL5RfndmzHdwX6XDy3uoy
         E0FiyrHdgUje2401oVuJW3Hf0bEkxjv3auSgkyDWIlUrNMGs0fIHDAhbzRE71x7ekbgA
         nK5Y07qcG8905I+pzh51fDWIl8kzJ2TZ+h1gNDmFWyfyor3D8MtaztUkugjM4L3zFhKk
         2Nh6J9KD8oF9D1LNSaOXuMlLU3ZDW4n105Gv+p5kmKNE5zU/I5veOKyHOfPaBOylsE7K
         Gd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695773613; x=1696378413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTg9psR2+piEPoaSc9Zx3utTOXhQXIIsVJjumDfUeU4=;
        b=YBrJ6b8GdLAn86ezu/h+96UgEGlNnGMiCWkpU0NtYVm/8x3NI1N9tiDm+HZKE5nJNH
         bMemx04VZvdbhF3JWsuD+i9Wvt4E9ZNoOiyJv1ilZO3fXW76gy4eaifLpC6EHaEKW4bw
         rh1qjwZTLXJNM1nwQAMn+kl7BDVOvjDNdpnySl0d5HZuQttybz1w0Fz7Hf4Q+E0xJce6
         HuRNkq5fXuRJ6QmfoCsCf53Tlg/ljDQ3aNJXmjlIuk0AIcdvgRsKrik2MYghbwUYvbxT
         1O3X2pmF3TcANI9ru5ZKxtq/Y5KGJ6iupYGd+1wX3aghqrrrqdEYUt1tSXydgN7ozo9S
         8hDw==
X-Gm-Message-State: AOJu0Yzy9AggaHleoev5Fkyndx+hMkyAL3lySKaIsYeF0cEShaw0iwLo
	YrFqKbUbyogFQ/NRke28F5MjoHxmu3E=
X-Google-Smtp-Source: AGHT+IEJ5jzuWWHM5ESo+TJV0BG+cRQP7JW/ctMT2E6K4vI/izFd29y7VGylKavigU0du58wXErHQg==
X-Received: by 2002:a17:903:2349:b0:1b5:674d:2aa5 with SMTP id c9-20020a170903234900b001b5674d2aa5mr754754plh.13.1695773612850;
        Tue, 26 Sep 2023 17:13:32 -0700 (PDT)
Received: from wheely.local0.net ([203.63.110.121])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b001bc18e579aesm5623333plj.101.2023.09.26.17.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 17:13:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>
Subject: [RFC PATCH 5/7] net: openvswitch: uninline ovs_fragment to control stack usage
Date: Wed, 27 Sep 2023 10:13:06 +1000
Message-Id: <20230927001308.749910-6-npiggin@gmail.com>
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

ovs_fragment uses a lot of stack, 400 bytes. It is a leaf function
but its caller do_output is involved in openvswitch recursion.
GCC 13.2 for powerpc64le is not inlining it, but it only has a single
call site, so it is liable to being inlined.

Mark it noinline_for_stack, to ensure it doesn't bloat stack use in
the recursive path.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 net/openvswitch/actions.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index b4d4150c5e69..12ad998b70e2 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -849,9 +849,9 @@ static void prepare_frag(struct vport *vport, struct sk_buff *skb,
 	skb_pull(skb, hlen);
 }
 
-static void ovs_fragment(struct net *net, struct vport *vport,
-			 struct sk_buff *skb, u16 mru,
-			 struct sw_flow_key *key)
+static noinline_for_stack
+void ovs_fragment(struct net *net, struct vport *vport, struct sk_buff *skb,
+		  u16 mru, struct sw_flow_key *key)
 {
 	enum ovs_drop_reason reason;
 	u16 orig_network_offset = 0;
-- 
2.40.1


