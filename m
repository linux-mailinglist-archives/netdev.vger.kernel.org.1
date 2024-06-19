Return-Path: <netdev+bounces-105015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD9290F70A
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A059B1C20A30
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9831815B0FD;
	Wed, 19 Jun 2024 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab6SRa4A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F115990E;
	Wed, 19 Jun 2024 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718825638; cv=none; b=kQ4zEqOWPfQTVPBp7empGKinmi9L3CZC0+npQyRV86hk+LwZC5UwjAKHEuw81GKy4IjV+kUdwiP0u2nUpquXZ1trts/4XwvK94hqqvMagpbGrTZf0AlvYJ9ZWrujugQYphf+uMMnVqNSDVBFyQLoki2TJlfE0TkedZzsZZFC+/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718825638; c=relaxed/simple;
	bh=l6yqTeNyOBrP23PYN3nun8WZu+CjjUQ/unbct0M2mXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQkLGMQGKiTLcQQTD6117CjYyghrcyYMRmbb4xGXEyy3GRXeW+TQypzpjP/c9oPzZs3RsP3wIQrSlzTMofzN2GwMl5N6jd3BywnMcE8czgu0hOAAF8jLsWE2Iq2FLDLR3FeXYnYMKvSEEzv0b2GO8iPSRFmfiDJ1BL+J8Qos7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ab6SRa4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ADBC2BBFC;
	Wed, 19 Jun 2024 19:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718825638;
	bh=l6yqTeNyOBrP23PYN3nun8WZu+CjjUQ/unbct0M2mXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ab6SRa4A4O3te1DOOmVV9LKCuiJpDJdfI2FJQBq7Kv17C7DHW9zsNHeb7bueSUyci
	 Lw8BamiL2ZhJaGhfx8G68H5MVVl5rP0PoFMr3MXdBanf8G0+uamQxXGnta/B3S9dDw
	 hxeMRHH2RbBfswtUdPsiANqaMFIchVgdwbI9OYciFSLtTNAUo6Y550TibRKn1EDO+N
	 jFMP5K79mMw1Gt13ZqhVo7pLGtcBu3PyeZYSN0KNkStMGjUKsvFOBnXvq0ajXDw3Km
	 hKwtApCwZSJRbY1AcU0nqYvTcz9qlLvkzi8luHa6uZNhZmCKnFcJPfiqqXBd6ZjO8p
	 iynQrnp0MQn5A==
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
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 5/6] ipc, msg: Use dedicated slab buckets for alloc_msg()
Date: Wed, 19 Jun 2024 12:33:53 -0700
Message-Id: <20240619193357.1333772-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619192131.do.115-kees@kernel.org>
References: <20240619192131.do.115-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1957; i=kees@kernel.org; h=from:subject; bh=l6yqTeNyOBrP23PYN3nun8WZu+CjjUQ/unbct0M2mXI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmczKhrdqjrPyL3pEgr89Wc1pCFROhedjcMhzfD 1ktUaK7VaKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZnMyoQAKCRCJcvTf3G3A JiQ3D/9sneRcmARSURll7MrwE/KHnzRzFcQfEmQHROWakjylRhL3Z0qgUV2xaUp+i+YCu8W3lfd vjdODHDdoXjT/ExemxxivY16a/qE6rBCZGnPKOVxK3ieSuA9ZzetcC5zX+W+++FilPd31YyrXlJ mesSod6rWwnUA5JSzWJM3SRCSq9v826dVuBa/5LuO3DEBHKEJXdmuKjh0omg1zf2f5vPlkq6/dg QfbRJ89z7CY8mHavgoYcCnepTFBhqheIookn2IiB/Uml9NSas9I2zkAKvhknI/QSKeR1uJ+JKe+ Xvyod/C1OCjXxY2Mh9vpESjonkiOcjBwbvmUVemIO6/HtIRKr639BOBbvBgpjz3z70L4U4M7idu Y23rYQDQxyjeSsys0C0w3USaByxJj+rz7bwMoX+DwBhJdCchT/xvk4TlXJ9/j7Cd7FRjKYVvgrq swSCdTWUMlIcP+hMvlV7t0lUti3RUgOtnuLdtg08vETEz0mVTjgKy/fhn8z+N3MUPBwC2WEPqSq fE7nx3DOP8Eeo1yl4iIITBECv/k7Cppw1SaBEDd7IInEJ4sM+V5kIZU1+1LCQQLrffItFFCReOT MF6cMh4pmxuG4jeXxARn7mBikJcVkRfWhv2hbIQE/LCdwAEJRwNg5tKV6icRA6I5m7Oy2Gnm6Vp OMux8ZOHO1evhkg==
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
index d0a0e877cadd..f392f30a057a 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -42,6 +42,17 @@ struct msg_msgseg {
 #define DATALEN_MSG	((size_t)PAGE_SIZE-sizeof(struct msg_msg))
 #define DATALEN_SEG	((size_t)PAGE_SIZE-sizeof(struct msg_msgseg))
 
+static kmem_buckets *msg_buckets __ro_after_init;
+
+static int __init init_msg_buckets(void)
+{
+	msg_buckets = kmem_buckets_create("msg_msg", 0, SLAB_ACCOUNT,
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


