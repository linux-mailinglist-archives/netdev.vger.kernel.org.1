Return-Path: <netdev+bounces-38248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187767B9D8D
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 15:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 991D02820C3
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 13:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD29266BA;
	Thu,  5 Oct 2023 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vu+cyG48"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C166266B9
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 13:49:28 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226DC19BE
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 06:49:25 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-664bd97692dso5580706d6.0
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 06:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696513764; x=1697118564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oymkAwTbxNQflv4ebDC3kcwBFW5bZvGX0rS/wRIi1nw=;
        b=Vu+cyG48FWW8kSUDKXfMM/eiKC73HgTw14Iih6hCXj4bAQiPx+Xac13kKkecEVUkwc
         9SPfPK3ya2nxrOVq01WEMr29PWGxSQh9xdSwELttidsqbj8ic75VZDzp98yo8TOCgYHk
         54vnnOSvlSszCQ85H0gUT9gZlqFK73Kz27Q416uBtUXnH5roEoKSbQTCAiNn2O7wQbEP
         7eVGNEDLjr1EW1cIgPkL5J5p/WsRATIgKWxp8QqBUBnd0pBy9rZnZCLwBwOw8V8Xib2D
         vyU4FAs40wyF0BjdJtGdD9bgxtrqPoOR6uMGLq1Ku2Bq3vPK0+cqH9UC1J4Cdrz4f/vk
         5RAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696513764; x=1697118564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oymkAwTbxNQflv4ebDC3kcwBFW5bZvGX0rS/wRIi1nw=;
        b=w8fixLY4K69CQQrs9N/z54DrBkm49GjTTlv9M83ezCEjHRvcxr4mfib4CoLdlSXXoo
         n/38nplGwBZZRmPPWxmJe3Lvihi95rwB3+ZZOVskIOJEe6zBNC1/5ULrzYScMhcXys2N
         7453Tfp8D0w7kuELhsK5xtdLx6FGBQg7ANwcgDOlRpN2YdCLYx/axMBCzMxGh2UKI6T0
         6+weqAxeqiLLFT6fWhd7Ykf0eaS01fndXBJUi44e125qKqBGQ/zwiZSOXAy33bXnNRcO
         3MMjO3+uwx7QvD8Pt1AY87fxuy2CZEx1fuep+hK2flRU5IlI7A72MyBcQ5Ikf3Oy/iPz
         Hemw==
X-Gm-Message-State: AOJu0YwaA3S2Tmn1qJ262Cg41zTjikUgzPtBiLxLvuUNPKbHt1Teosmm
	y7J72ka4n74BGv0QX0mpQcYcZ4hcRl4z+w==
X-Google-Smtp-Source: AGHT+IG/DHGTjYXtt7EZm5HyWFQfr8UgKZtSiQD6f7I6VXNFqXiAZ1lQkin9wR36sIuiKsOfRYQVUg==
X-Received: by 2002:ad4:42b4:0:b0:635:f899:660b with SMTP id e20-20020ad442b4000000b00635f899660bmr5137128qvr.36.1696513764108;
        Thu, 05 Oct 2023 06:49:24 -0700 (PDT)
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
Subject: [PATCH net-next 3/3] net: expand skb_segment unit test with frag_list coverage
Date: Thu,  5 Oct 2023 09:48:57 -0400
Message-ID: <20231005134917.2244971-4-willemdebruijn.kernel@gmail.com>
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

Expand the test with these variants that use skb->frag_list:

- GSO_TEST_FRAG_LIST:             frag_skb length is gso_size
- GSO_TEST_FRAG_LIST_PURE:        same, data exclusively in frag skbs
- GSO_TEST_FRAG_LIST_NON_UNIFORM: frag_skb length may vary
- GSO_TEST_GSO_BY_FRAGS:          frag_skb length defines gso_size,
                                  i.e., segs may have varying sizes.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/core/gso_test.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/net/core/gso_test.c b/net/core/gso_test.c
index 41d1daa20831e..dc3ca31d11292 100644
--- a/net/core/gso_test.c
+++ b/net/core/gso_test.c
@@ -27,6 +27,10 @@ enum gso_test_nr {
 	GSO_TEST_FRAGS,
 	GSO_TEST_FRAGS_PURE,
 	GSO_TEST_GSO_PARTIAL,
+	GSO_TEST_FRAG_LIST,
+	GSO_TEST_FRAG_LIST_PURE,
+	GSO_TEST_FRAG_LIST_NON_UNIFORM,
+	GSO_TEST_GSO_BY_FRAGS,
 };
 
 struct gso_test_case {
@@ -37,6 +41,8 @@ struct gso_test_case {
 	unsigned int linear_len;
 	unsigned int nr_frags;
 	const unsigned int *frags;
+	unsigned int nr_frag_skbs;
+	const unsigned int *frag_skbs;
 
 	/* output as expected */
 	unsigned int nr_segs;
@@ -84,6 +90,48 @@ static struct gso_test_case cases[] = {
 		.nr_segs = 2,
 		.segs = (const unsigned int[]) { 2 * gso_size, 3 },
 	},
+	{
+		/* commit 89319d3801d1: frag_list on mss boundaries */
+		.id = GSO_TEST_FRAG_LIST,
+		.name = "frag_list",
+		.linear_len = gso_size,
+		.nr_frag_skbs = 2,
+		.frag_skbs = (const unsigned int[]) { gso_size, gso_size },
+		.nr_segs = 3,
+		.segs = (const unsigned int[]) { gso_size, gso_size, gso_size },
+	},
+	{
+		.id = GSO_TEST_FRAG_LIST_PURE,
+		.name = "frag_list_pure",
+		.nr_frag_skbs = 2,
+		.frag_skbs = (const unsigned int[]) { gso_size, gso_size },
+		.nr_segs = 2,
+		.segs = (const unsigned int[]) { gso_size, gso_size },
+	},
+	{
+		/* commit 43170c4e0ba7: GRO of frag_list trains */
+		.id = GSO_TEST_FRAG_LIST_NON_UNIFORM,
+		.name = "frag_list_non_uniform",
+		.linear_len = gso_size,
+		.nr_frag_skbs = 4,
+		.frag_skbs = (const unsigned int[]) { gso_size, 1, gso_size, 2 },
+		.nr_segs = 4,
+		.segs = (const unsigned int[]) { gso_size, gso_size, gso_size, 3 },
+	},
+	{
+		/* commit 3953c46c3ac7 ("sk_buff: allow segmenting based on frag sizes") and
+		 * commit 90017accff61 ("sctp: Add GSO support")
+		 *
+		 * "there will be a cover skb with protocol headers and
+		 *  children ones containing the actual segments"
+		 */
+		.id = GSO_TEST_GSO_BY_FRAGS,
+		.name = "gso_by_frags",
+		.nr_frag_skbs = 4,
+		.frag_skbs = (const unsigned int[]) { 100, 200, 300, 400 },
+		.nr_segs = 4,
+		.segs = (const unsigned int[]) { 100, 200, 300, 400 },
+	},
 };
 
 static void gso_test_case_to_desc(struct gso_test_case *t, char *desc)
@@ -131,10 +179,55 @@ static void gso_test_func(struct kunit *test)
 		skb->truesize += skb->data_len;
 	}
 
+	if (tcase->frag_skbs) {
+		unsigned int total_size = 0, total_true_size = 0;
+		unsigned int alloc_size = 0;
+		struct sk_buff *frag_skb, *prev = NULL;
+
+		page = alloc_page(GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, page);
+		page_ref_add(page, tcase->nr_frag_skbs - 1);
+
+		for (i = 0; i < tcase->nr_frag_skbs; i++) {
+			unsigned int frag_size;
+
+			frag_size = tcase->frag_skbs[i];
+			frag_skb = build_skb(page_address(page) + alloc_size,
+					     frag_size + shinfo_size);
+			KUNIT_ASSERT_NOT_NULL(test, frag_skb);
+			__skb_put(frag_skb, frag_size);
+
+			if (prev)
+				prev->next = frag_skb;
+			else
+				skb_shinfo(skb)->frag_list = frag_skb;
+			prev = frag_skb;
+
+			total_size += frag_size;
+			total_true_size += frag_skb->truesize;
+			alloc_size += frag_size + shinfo_size;
+		}
+
+		KUNIT_ASSERT_LE(test, alloc_size, PAGE_SIZE);
+
+		skb->len += total_size;
+		skb->data_len += total_size;
+		skb->truesize += total_true_size;
+
+		if (tcase->id == GSO_TEST_GSO_BY_FRAGS)
+			skb_shinfo(skb)->gso_size = GSO_BY_FRAGS;
+	}
+
 	features = NETIF_F_SG | NETIF_F_HW_CSUM;
 	if (tcase->id == GSO_TEST_GSO_PARTIAL)
 		features |= NETIF_F_GSO_PARTIAL;
 
+	/* TODO: this should also work with SG,
+	 * rather than hit BUG_ON(i >= nfrags)
+	 */
+	if (tcase->id == GSO_TEST_FRAG_LIST_NON_UNIFORM)
+		features &= ~NETIF_F_SG;
+
 	segs = skb_segment(skb, features);
 	if (IS_ERR(segs)) {
 		KUNIT_FAIL(test, "segs error %lld", PTR_ERR(segs));
-- 
2.42.0.582.g8ccd20d70d-goog


