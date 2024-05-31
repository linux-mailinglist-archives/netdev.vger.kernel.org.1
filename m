Return-Path: <netdev+bounces-99825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336DF8D698F
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 21:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6570E1C2477F
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 19:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D02117FAAE;
	Fri, 31 May 2024 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJ94SEMU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233D917D8A5;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182900; cv=none; b=qTTKNFx8WECDXJDL6G5OdKwXUezhLiI6E2J9oUfGdlPswYpqV3WrQi44TROpfBrjRHWIdQg6lM2CETgfbWq8NNlsYdTX/7z1ewNh667pHt505+Stj4Gs0Oh2JTTHc9VANHSdnm50z+52bfwrnU0lcwEk5jW3PD13Us6Kq53g3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182900; c=relaxed/simple;
	bh=9A8yq+jsLnEY9XtsifO4pnJhUYQibC3G54xH7WF3Dj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gnNWWhONIQ8ZmiBt4Vy8RkcQ9XkMgZv1Z/+7o6C84OVMMxnpiTIEaDVSss9MrmTvjD00KAjpDPWxWiF2m0FlmVkhZ81WHfs536hJARkl/BOHnx8qDrVIe7FCLLg/Ronqm74ZmZYzbjs2Xj0I8mofBzcHw+Gpc86yve3Q3zoVMS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJ94SEMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABA8C4AF13;
	Fri, 31 May 2024 19:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717182899;
	bh=9A8yq+jsLnEY9XtsifO4pnJhUYQibC3G54xH7WF3Dj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJ94SEMUEAi0G+xM96x4XYoiJDcb0qfXFLRPz0/u++ZCuMBiMP4N+dQZ/5WzMuf0J
	 7nEYVNuzZRF7r3hwWa0Jsf5KheXxXfycWzjYaRsXudaEtjxhpVB0ikcDRnDFR8iaV9
	 OZGkA9+rXQcezVxLSrx1tqCyJtoLLdY68VZ0AzQSxYGw2Ztaevj4N+pOUt/iAaovAY
	 rybbbuKLKSr/KXIqwHOIIK5bOhBm+2NSgCmZ6YzUwhS+3fvK/bIEXpEY7pyM6y3HDV
	 Yiq2Mtmr3OSKj/fIskTPFM5frnLmXncLQcHQF+K+K2cMUBIP30k8CRAS7Zd7XWVbL3
	 Pig4fGkgA24nA==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	jvoisin <julien.voisin@dustri.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 5/6] ipc, msg: Use dedicated slab buckets for alloc_msg()
Date: Fri, 31 May 2024 12:14:57 -0700
Message-Id: <20240531191458.987345-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531191304.it.853-kees@kernel.org>
References: <20240531191304.it.853-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2262; i=kees@kernel.org; h=from:subject; bh=9A8yq+jsLnEY9XtsifO4pnJhUYQibC3G54xH7WF3Dj0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmWiGxyTBp2lx8Omk4GJvqG8JlvO5V6TG04TJr5 OpKBK400V+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZlohsQAKCRCJcvTf3G3A JjytD/4tYkg8aTTXkEDJQTDS78uMcmGvgti9YYYONm70aRUsgZ2NOCsbfkTf5fxNyTqi9iRQhCG M8mNQcuLRnO0XfhtP8+WYinTIpI/rMHdm3dJQ5qpqud8iyNGvkD9T4vFMs3q+SjzaF6SXt1lefj dotmyKXABhbLGYH3rRKXR6vOAhDbktYauSb/gjvMkYFl/82yOenQTK0bP+ysn2sVOhqCdwaNRlV GVS+Z0DRHZHNzhCwS4iZAhR5BLKdy8ljeD13yC9JmDXJBLdkL6XO5GJFxrixfq92hk3Gvmf1npE CvgNLaa/Q1h0CylSCrHiM7fsji0R1rW2PFjR2I3Dwh8RC5BgPZFW7iKn7dPZKE/JlwNhAFB7P3d odTCg9G87cqbhIuzbfVW873JG4yeVERpzVHT/tZlGxSPH/Gi+qdoGFJouhc9vX0EzRvlybRzGRd yttjTi2+GwRmuToPZIjIeTq3UG0xjeoLSBZOf+yVKJ46jIQmp6kaR9R1fL/j1q4qHchC1JnQl4y ksVMniTRqY1mgqX35gEIb0TbqNneD6WspnMzFKNVSZzkQMsOmlwxbPEnIEC59OcYfkTsScAj6Bu tqc3tfKbSiPqujUwsxw6EIjtkVwoSkgPO+uyzj6qC4EaPBF756njG76W6fn7B38ITUDAU1DDmTG IGdaAR94n/zELiQ==
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
Cc: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jann Horn <jannh@google.com>
Cc: Matteo Rizzo <matteorizzo@google.com>
Cc: jvoisin <julien.voisin@dustri.org>
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


