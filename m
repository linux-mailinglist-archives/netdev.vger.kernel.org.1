Return-Path: <netdev+bounces-38249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0277B9D8E
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 15:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CD2FC281B86
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 13:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1AE266DA;
	Thu,  5 Oct 2023 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1GOFM4U"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F68266BB
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 13:49:28 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B48819A1
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 06:49:24 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-65afd8af8bbso5441976d6.3
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696513763; x=1697118563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMrD+b8fz9u+6jiIFM4sQLi2ogSziH3Lh07rXPTog2k=;
        b=Z1GOFM4UDi3ixYNCV0R3QeE6/Cv7ALrF0sJfv+ubXSehVwZ/DXH8+nFPMSw3TnEAy4
         L6zb1PiXlBSv9HqZONkY7tHWB3622AB2LVZce5wrbiUxrKEOZiPByRuNPZU7VueNT/Op
         7EC66YhE+RIyEeGxliJYeTn/Z+dTGF4Egy1uC9fCtnzX7BVid+WDY+SLXRlEVxc9hM5J
         312pFk3bAf8z3b+Qt58Y8NSFfwrT1JTk2+cxtCKrgJRhu3fjXlpx77j76g/jxDGoTKf9
         pDVUHcpbv0tiRXEt/EUvIhHiwE47dWvU5Kxndqo7ruWofTUI6sdh/HyGve1Fe9ftJuMx
         kqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696513763; x=1697118563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMrD+b8fz9u+6jiIFM4sQLi2ogSziH3Lh07rXPTog2k=;
        b=Q8LU7RjXe21dpx0OgeMS421O/PKDYDrcmTPCvGZGBbZ2WMyR8WLvJx4LUSg3m9PLy5
         a/2ZB4B5gegiabsIf/3oIFDfXTM3KnW1WPAvyAavHhUl328f+HmQEtgKz46MxtTEdW7H
         akHQVlek0SoDJbTgT5snJmEM9xokRAIlEYxlhn4Yh64R8CiE4yHpqbryR1n5/LgOFe+d
         LO9A9Ai18YLVdZR03bXkutmNZtJyu88nA3QxQ1R33nOHNN/mUoQJC1txS4fpw7nsTvh/
         GCMWkX6bQszxOmugb6Rp6bK8zLy8ZKgF/EWHiyqFa4MeGUH+jo3oPS5nRA3RXT0uWmak
         aYUA==
X-Gm-Message-State: AOJu0YyPDHy6Kjd7cYS+I87MB2ZZtvqul2VGYwg9drYoJldrdlWngESL
	aeGcARJ7UlxfVefXNYvOfVEixzVUTJ6EAg==
X-Google-Smtp-Source: AGHT+IGPCng27f1Sr4nh0vfIOHiqq1e0QI6J55OERiTDBZMpjk75eBte1UXFGbpp0J/DYRZC7uZ5zA==
X-Received: by 2002:a05:6214:5488:b0:64a:9308:3016 with SMTP id lg8-20020a056214548800b0064a93083016mr5448018qvb.56.1696513763640;
        Thu, 05 Oct 2023 06:49:23 -0700 (PDT)
Received: from willemb.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id n20-20020a0cdc94000000b0065b1e6c33dfsm512591qvk.18.2023.10.05.06.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 06:49:23 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	alexander.duyck@gmail.com,
	fw@strlen.de,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 2/3] net: parametrize skb_segment unit test to expand coverage
Date: Thu,  5 Oct 2023 09:48:56 -0400
Message-ID: <20231005134917.2244971-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231005134917.2244971-1-willemdebruijn.kernel@gmail.com>
References: <20231005134917.2244971-1-willemdebruijn.kernel@gmail.com>
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

From: Willem de Bruijn <willemb@google.com>

Expand the test with variants

- GSO_TEST_NO_GSO:      payload size less than or equal to gso_size
- GSO_TEST_FRAGS:       payload in both linear and page frags
- GSO_TEST_FRAGS_PURE:  payload exclusively in page frags
- GSO_TEST_GSO_PARTIAL: produce one gso segment of multiple of gso_size,
                        plus optionally one non-gso trailer segment

Define a test struct that encodes the input gso skb and output segs.
Input in terms of linear and fragment lengths. Output as length of
each segment.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/core/gso_test.c | 129 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 112 insertions(+), 17 deletions(-)

diff --git a/net/core/gso_test.c b/net/core/gso_test.c
index 9a4828b20203a..41d1daa20831e 100644
--- a/net/core/gso_test.c
+++ b/net/core/gso_test.c
@@ -4,10 +4,7 @@
 #include <linux/skbuff.h>
 
 static const char hdr[] = "abcdefgh";
-static const int gso_size = 1000, last_seg_size = 1;
-
-/* default: create 3 segment gso packet */
-static const int payload_len = (2 * gso_size) + last_seg_size;
+static const int gso_size = 1000;
 
 static void __init_skb(struct sk_buff *skb)
 {
@@ -24,21 +21,121 @@ static void __init_skb(struct sk_buff *skb)
 	skb_shinfo(skb)->gso_size = gso_size;
 }
 
+enum gso_test_nr {
+	GSO_TEST_LINEAR,
+	GSO_TEST_NO_GSO,
+	GSO_TEST_FRAGS,
+	GSO_TEST_FRAGS_PURE,
+	GSO_TEST_GSO_PARTIAL,
+};
+
+struct gso_test_case {
+	enum gso_test_nr id;
+	const char *name;
+
+	/* input */
+	unsigned int linear_len;
+	unsigned int nr_frags;
+	const unsigned int *frags;
+
+	/* output as expected */
+	unsigned int nr_segs;
+	const unsigned int *segs;
+};
+
+static struct gso_test_case cases[] = {
+	{
+		.id = GSO_TEST_NO_GSO,
+		.name = "no_gso",
+		.linear_len = gso_size,
+		.nr_segs = 1,
+		.segs = (const unsigned int[]) { gso_size },
+	},
+	{
+		.id = GSO_TEST_LINEAR,
+		.name = "linear",
+		.linear_len = gso_size + gso_size + 1,
+		.nr_segs = 3,
+		.segs = (const unsigned int[]) { gso_size, gso_size, 1 },
+	},
+	{
+		.id = GSO_TEST_FRAGS,
+		.name = "frags",
+		.linear_len = gso_size,
+		.nr_frags = 2,
+		.frags = (const unsigned int[]) { gso_size, 1 },
+		.nr_segs = 3,
+		.segs = (const unsigned int[]) { gso_size, gso_size, 1 },
+	},
+	{
+		.id = GSO_TEST_FRAGS_PURE,
+		.name = "frags_pure",
+		.nr_frags = 3,
+		.frags = (const unsigned int[]) { gso_size, gso_size, 2 },
+		.nr_segs = 3,
+		.segs = (const unsigned int[]) { gso_size, gso_size, 2 },
+	},
+	{
+		.id = GSO_TEST_GSO_PARTIAL,
+		.name = "gso_partial",
+		.linear_len = gso_size,
+		.nr_frags = 2,
+		.frags = (const unsigned int[]) { gso_size, 3 },
+		.nr_segs = 2,
+		.segs = (const unsigned int[]) { 2 * gso_size, 3 },
+	},
+};
+
+static void gso_test_case_to_desc(struct gso_test_case *t, char *desc)
+{
+	sprintf(desc, "%s", t->name);
+}
+
+KUNIT_ARRAY_PARAM(gso_test, cases, gso_test_case_to_desc);
+
 static void gso_test_func(struct kunit *test)
 {
 	const int shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	const struct gso_test_case *tcase;
 	struct sk_buff *skb, *segs, *cur;
+	netdev_features_t features;
 	struct page *page;
+	int i;
+
+	tcase = test->param_value;
 
 	page = alloc_page(GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, page);
-	skb = build_skb(page_address(page), sizeof(hdr) + payload_len + shinfo_size);
+	skb = build_skb(page_address(page), sizeof(hdr) + tcase->linear_len + shinfo_size);
 	KUNIT_ASSERT_NOT_NULL(test, skb);
-	__skb_put(skb, sizeof(hdr) + payload_len);
+	__skb_put(skb, sizeof(hdr) + tcase->linear_len);
 
 	__init_skb(skb);
 
-	segs = skb_segment(skb, NETIF_F_SG | NETIF_F_HW_CSUM);
+	if (tcase->nr_frags) {
+		unsigned int pg_off = 0;
+
+		page = alloc_page(GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, page);
+		page_ref_add(page, tcase->nr_frags - 1);
+
+		for (i = 0; i < tcase->nr_frags; i++) {
+			skb_fill_page_desc(skb, i, page, pg_off, tcase->frags[i]);
+			pg_off += tcase->frags[i];
+		}
+
+		KUNIT_ASSERT_LE(test, pg_off, PAGE_SIZE);
+
+		skb->data_len = pg_off;
+		skb->len += skb->data_len;
+		skb->truesize += skb->data_len;
+	}
+
+	features = NETIF_F_SG | NETIF_F_HW_CSUM;
+	if (tcase->id == GSO_TEST_GSO_PARTIAL)
+		features |= NETIF_F_GSO_PARTIAL;
+
+	segs = skb_segment(skb, features);
 	if (IS_ERR(segs)) {
 		KUNIT_FAIL(test, "segs error %lld", PTR_ERR(segs));
 		goto free_gso_skb;
@@ -47,7 +144,9 @@ static void gso_test_func(struct kunit *test)
 		goto free_gso_skb;
 	}
 
-	for (cur = segs; cur; cur = cur->next) {
+	for (cur = segs, i = 0; cur; cur = cur->next, i++) {
+		KUNIT_ASSERT_EQ(test, cur->len, sizeof(hdr) + tcase->segs[i]);
+
 		/* segs have skb->data pointing to the mac header */
 		KUNIT_ASSERT_PTR_EQ(test, skb_mac_header(cur), cur->data);
 		KUNIT_ASSERT_PTR_EQ(test, skb_network_header(cur), cur->data + sizeof(hdr));
@@ -55,24 +154,20 @@ static void gso_test_func(struct kunit *test)
 		/* header was copied to all segs */
 		KUNIT_ASSERT_EQ(test, memcmp(skb_mac_header(cur), hdr, sizeof(hdr)), 0);
 
-		/* all segs are gso_size, except for last */
-		if (cur->next) {
-			KUNIT_ASSERT_EQ(test, cur->len, sizeof(hdr) + gso_size);
-		} else {
-			KUNIT_ASSERT_EQ(test, cur->len, sizeof(hdr) + last_seg_size);
-
-			/* last seg can be found through segs->prev pointer */
+		/* last seg can be found through segs->prev pointer */
+		if (!cur->next)
 			KUNIT_ASSERT_PTR_EQ(test, cur, segs->prev);
-		}
 	}
 
+	KUNIT_ASSERT_EQ(test, i, tcase->nr_segs);
+
 	consume_skb(segs);
 free_gso_skb:
 	consume_skb(skb);
 }
 
 static struct kunit_case gso_test_cases[] = {
-	KUNIT_CASE(gso_test_func),
+	KUNIT_CASE_PARAM(gso_test_func, gso_test_gen_params),
 	{}
 };
 
-- 
2.42.0.582.g8ccd20d70d-goog


