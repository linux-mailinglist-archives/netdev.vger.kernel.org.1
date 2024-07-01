Return-Path: <netdev+bounces-108255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2000691E856
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA561F221C9
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E88E171640;
	Mon,  1 Jul 2024 19:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gghdBhp7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2C816F85E;
	Mon,  1 Jul 2024 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861185; cv=none; b=FVOG2zRpSacA7q83gZ8/5p9N3gWndarj6ULyfGZwA87jWDuoKWd8er8ztJ8XlFiNdR4qmlT6QXqEnLl5Q5IgWTQlqRj3TmHldd83W1AfQOQLxAaL63imSIKDDgXXFRrOEk+lJuomlHAybh2H4Row2b4UT08zeuDJc6hZ0+H1p/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861185; c=relaxed/simple;
	bh=ZC+4xLsqMS25+wle+eOPiqDyMZP//OUcAmXX2J5RAVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fJ/4pguvMJs/zZVU63W7lKwyfL5M8rt+5j3FITfTOjug7PdZnwGou0HrN1sobQA4VoR0e5/sExK4rE9CquvN1KlKyMej10f25p6YsX9uGC2U55pZk0ENksohjZGvmxd3W1UXVBX7W2kA5VHf9xUqZmNaaV18RucMvLXMipwtPs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gghdBhp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2019EC4AF0F;
	Mon,  1 Jul 2024 19:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719861185;
	bh=ZC+4xLsqMS25+wle+eOPiqDyMZP//OUcAmXX2J5RAVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gghdBhp7ZB7XhRBrUQVzahbv03mmZLCVplJYE8pWnFaiQBh2snWO0KElN7hj5L0Ny
	 TCJLGI1T2/AYbR2OOeDbeBWZfI7c7oL4M/JJ+RlL0S6mrIsnfyUr2asG/Co/Y4NEib
	 2S8SMe6fCT9MJr1eFjg0+faPtFSQNhPRNUFqlzP/oVpb1NFgNCMw9FHbeSyp8aQwd8
	 Rpp3mces1RFAQJXcr+XIjwJD+CSoa+o3l+nguqgsSPs0GKDCrrDHUS+spXwD2uqiPF
	 isAeixm5YYh/xbBj+DX8ZhRg76tY6LlFeuQrEUT5H9ThGb16jkfh9m3ifBk/g38bmt
	 dF3WKO2zZc9Gg==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	jvoisin <julien.voisin@dustri.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 5/6] ipc, msg: Use dedicated slab buckets for alloc_msg()
Date: Mon,  1 Jul 2024 12:13:02 -0700
Message-Id: <20240701191304.1283894-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701190152.it.631-kees@kernel.org>
References: <20240701190152.it.631-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1954; i=kees@kernel.org; h=from:subject; bh=ZC+4xLsqMS25+wle+eOPiqDyMZP//OUcAmXX2J5RAVo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmgv++179k0fHAvGjqEU5ltN8MHRwh6Dca9ahz8 0TL+TDEUBSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZoL/vgAKCRCJcvTf3G3A JmaMEAChdkbMO+SdicBA6J36xZMom97yPCUJe+AQcsVFpIdELNyttcTScgDv/IxVDdTTaDyBHTr YayvHGh0Bi1wtq7wdAnfUZIju5ZUa/WCgNCX2fLmkOeyKifYhjk2i9+VtTvLMF6K9caBNiPSieA zYCUvURzBk7S44/7T4ThX23ycIiwE+oU9Ud4uP15daHyrsTeeX+aLrWunFHWf4kTgAr71yIitjr 3mqyNbU+g8ZieFgH4PDLYynu+TtPt4iO2wZWiZec5JKUOCxFXM8gah47jLrZhvfdS4y8JwaEt9m Vjla4RVs4n8rqtja/7dPtTBSB1GkhywqySFJoH1BYAt2Vn2vFpWf5I8u5bLmvJM87SdhhRDZyf6 WLCvokYur6sn8yBFlXEw4LO99JBoilqOqAWn+ErUmZLEJeY1HXMJhqTpqU7H2HHlBpleEymLIiN nkdQyxDF92oetfAMKw6rcHGic8gH4aqBBSAELkoPYc3RQg7CKUb8oQDwtNSCtdEgmYI0+rJ2J13 XH821MfWZoLrYcu86MJQ8X3ue/s6Qz+Fj3yp/11eMIW48V1qmlShzTv+ZoL365+1pAl5J0Wbilv XRniyDfgf6MQmT5FSDohh8ztx9NNEwlKNAGEaogx5tGQ8x9sQVSpCXj3bPqAzpYTbjOlm/kTmqh rmeH/xNCP1FCX6Q==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The msg subsystem is a common target for exploiting[1][2][3][4][5][6][7]
use-after-free type confusion flaws in the kernel for both read and write
primitives. Avoid having a user-controlled dynamically-size allocation
share the global kmalloc cache by using a separate set of kmalloc buckets
via the kmem_buckets API.

Link: https://blog.hacktivesecurity.com/index.php/2022/06/13/linux-kernel-exploit-development-1day-case-study/ [1]
Link: https://hardenedvault.net/blog/2022-11-13-msg_msg-recon-mitigation-ved/ [2]
Link: https://www.willsroot.io/2021/08/corctf-2021-fire-of-salvation-writeup.html [3]
Link: https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html [4]
Link: https://google.github.io/security-research/pocs/linux/cve-2021-22555/writeup.html [5]
Link: https://zplin.me/papers/ELOISE.pdf [6]
Link: https://syst3mfailure.io/wall-of-perdition/ [7]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 ipc/msgutil.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index d0a0e877cadd..c7be0c792647 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -42,6 +42,17 @@ struct msg_msgseg {
 #define DATALEN_MSG	((size_t)PAGE_SIZE-sizeof(struct msg_msg))
 #define DATALEN_SEG	((size_t)PAGE_SIZE-sizeof(struct msg_msgseg))
 
+static kmem_buckets *msg_buckets __ro_after_init;
+
+static int __init init_msg_buckets(void)
+{
+	msg_buckets = kmem_buckets_create("msg_msg", SLAB_ACCOUNT,
+					  sizeof(struct msg_msg),
+					  DATALEN_MSG, NULL);
+
+	return 0;
+}
+subsys_initcall(init_msg_buckets);
 
 static struct msg_msg *alloc_msg(size_t len)
 {
@@ -50,7 +61,7 @@ static struct msg_msg *alloc_msg(size_t len)
 	size_t alen;
 
 	alen = min(len, DATALEN_MSG);
-	msg = kmalloc(sizeof(*msg) + alen, GFP_KERNEL_ACCOUNT);
+	msg = kmem_buckets_alloc(msg_buckets, sizeof(*msg) + alen, GFP_KERNEL);
 	if (msg == NULL)
 		return NULL;
 
-- 
2.34.1


