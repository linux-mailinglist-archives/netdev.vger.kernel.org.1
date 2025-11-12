Return-Path: <netdev+bounces-237867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DADACC50FB2
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9851A3A614E
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C9F2D8DAF;
	Wed, 12 Nov 2025 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HqrVPZHZ"
X-Original-To: netdev@vger.kernel.org
Received: from sonic304-47.consmr.mail.ne1.yahoo.com (sonic304-47.consmr.mail.ne1.yahoo.com [66.163.191.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5672D9EE2
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933218; cv=none; b=QDwzso4BK2EToArhLLiAf5xZ6bLRd9IsM0f5YrX3N+a+tF8F7xZETLTQC6Fbiz+5k7pIyfk49iww494S8dq2ICuiS/QIEFxwqXhSPKZdXLn9wzl7IC5S1tRpnbTGoIO6JA4tTb14AQCl9h0xQr/OgKoaR9RrNDlUs1XeEbi/1cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933218; c=relaxed/simple;
	bh=dlh6LlHVG2M9YzO6My0+Zr01fsRMVgvrEyzCDrIsLpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfUjprWcFGOGTkkozzYCKR6eQCvkS6++QPJo5fAwMMMXde3jx6q5ZcMFbzf5kblRUOocgGGiGgy202J9v02pCtWA7BxClavV1TF4QpUgy9C0PWVMdU7Huq3N0BejWS+RV5EaMryMefLHGYz9Kjzr2LWkUh3MTfFzsBmVjaBXd/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=HqrVPZHZ; arc=none smtp.client-ip=66.163.191.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762933216; bh=ZwArgljLr6/Lo+sgo10BP0rVV4dpOdUy22RlCIb1XE0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=HqrVPZHZNS6AA2wR9Scw5QZiEVKaqj9dTHlh8v7E4DZiUOMNR7GbHu10/4JvlcmO6s92sdklw819QD72x3Xgahnly9AdQ/DNuusDarVywtL50g9zmIm7z67fFRaR4hCgADC9UTONqzxyTI52wkC9IOleAl53YOqTOUxZnDlaqNsFMcmcD9YhoSdySgy6I7kNQh1u+GOHKexgmVBm5Yuh6+h06zJB0kjwoPjMSJh1Gxzk5r9ocPKiDjSSnC/dumcJwt0gJFQM2HPhRILS68+X7N4OnVxR4SaXYHjeRXSQZWyArbPJ2a3gmNXT5TZD7Y6ifaKeJ9Rmol0Zh40wkQw8/A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762933216; bh=PUTtww14ywViD9qyO3qqFz/GaaULdaQ6Yko2aPc2gY8=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XjxYjkr13wSbpHPilU9yF0YbqWvirZrZ9tGaLov8YB/alN4L7kaNbVHwXIzUpiJqmijwTG6riW8W00FIK4PRb/0KgbQjRpe6CvsqK0GtOrFYQPMoy98KTyki1o+5iVGkhttO/qV6671MwJ2LIpNkUXdGS4sayQkgjHPb4XkFsF51mTPhYiQ0B4rVdSJKo2suIPhDi8WDLZyfvcYcHw7SAS9DDHZcI4Z8I5Ph+eFT4sE6mapbgMp8ulIi093NVGgGxUO4FEfUaE+0fcdMPoB5e5rZVfIfw2G2N55Ek8po/BlYsWSsjCBzADrcRHADUU2mOC5LFntoXK0NszBbhlKMbA==
X-YMail-OSG: Ai5TpUwVM1n2Yk0_hAiR3BDs1.flFkUXX6OYzZnVH4Bq9287vv50ErVa0oTwoeG
 JASsgQVEAqTua9rYEHFNuZjF5VRVUwgNLwqGndvw7elXaXaFXkHAPQxDOLK_eoFyIjrNIQTL1VLw
 m0hyX5wwVXGIypZls4EoRcJ1vngfAJCf4wr_QAlDra0ok1EVT2C_kTlfE.g9fZpE0plq0LEGK9N5
 h8ZExS_ju1ZwXCN52F4WjsVfPmxtGE0NUrGXDu2wvx5ZrgJ5ME9_VgjdMxYK3xzLzGzweCQ3krip
 jzNhdSi.9Z6zvpdT.LyzsCPU.ODe1_AvZP1JXqWyQ8.LkBYs3o2DdIIMOdmmteK21KfcXvdig4qX
 XDrqkK_fOPg2UOJnOkGa3SthF0tJyK9ogtVi_TUFsJ47XY9b9AAJPt0l1wmW0uDJFk_8TqDIPST6
 OziID1pR.6WHlW5YWIvhRVZIf0OkcDpRKCprLl2hiuX5A3BmysfIM6YwS4LcWWqir6m54CSmuBIG
 losGsQcGVYZ_pzHLleQiDE7DjSy4aRy6HGe81c2SiH7nju58oMi2WM4nKlM1PP6fhYn5WLpMWl2P
 t03w9.ZTSnOVY1VrGkuQ1SAON.I2H.cSPRgydyJiFgMeamqB5Sd7cdF59iRLCsoGjcGbe66FnOVV
 eWx8KFB65M.ebLVBAvJg5G2oOLqCXJATq76.ZjXu1KCYFXTbmcNz6tPOjuS6P9lDD3L2s5pS0dUH
 hA8T_1gI4QUNQwu4ziQxmyLpbHlSfWjajg3KxdjRaQWsVqywJG8UFx6zbfFYLz8XxO1Qh9cZs8F.
 CqqfRGLjsuf0nvVujiNkLoIwHeCOtfBQBPkAG8YggWfRnO6mDd1RQcy715HD9yiMJHzyEiDgqj2z
 zMORRmuf2BhKwrAkEYSvW_HALCpkT6R_sv52jD0WNpX0Zl2iFqoQ8tTd1XuUg9SGWis9qI4JjTey
 X5RDLgOneLj8hKKu95t29.DzoTXdmgvwKXr825zQlzx49n8I2c5sdbNPXAGGKRCoQlrxBUO_iMq0
 dLpzliTnWBM4EXW_4MhPNQ9AfuLRLDvo834hsWcUCCNhMv07Yu_f0IW1r2UmjxCi27nYp37qpdot
 sXknNvoPg6TLwsokeNi80CmANfkCQu8aXaoUaR8kVY.cZCFcMH.6aKr4GC7hVOwa6GAzxwnldHeI
 WLbt4k.aaSIfNTO_X3.VRe9_D8gbCDa5bppcs17VCKF5OtRnH4DViQSUy2JwafRgJhco9e6Q5hw5
 l0W9RfXlAWlU8iy1g6SJGYQH.N5NCBCxB7Z6spTsVbDyK9dSRrBqjQ.v6wQNB0NHK8wNiyhGfd9I
 eJcb_afH7nzQCncAIuqFDqHjQJBpeZXCZSJEQzX4xAaQyimmNIPlTzm8tRUly.GiKB8EMpwTa6kH
 JFDXPYAdkPaV06q7tJD2hr8XBgW0g_EpfDDwlQlE_1ssXtWlnQMPidmWM1Lq.ytekfBMwwqRxXhB
 RKmNgYWSxcfWjOOUaQLQHxo7.FyKJSS4IndokklV_pmREMyBJAsHdH5Z6lPgbuLRi0Q0j0rwTKRO
 .51gj.mTn4SU1KvbaRcI_Xd53R8ReEXQDgjNfkrUVMlYvYEfvdP6tqd6RMWsVUpZtoU_FSU5kznW
 sXdNmwt8yMECEtxPrf2CyqgNEQoD3LcScLsCZ9hwij.q_W9qFPEWhmz0tF.5X5P7Kn5TyJpTOP_X
 7oVvhsiT3sdbWT6WAmjLL.EDQpkgjjnaDou.yo4aBs39zj3UWGjiIZlzD1kHOUMq7KNimd7gMH6w
 paW9yNAAzuvkHyzxkUqe_RdHF7ykuxYBWwWgTtkloBsCG1NtOQA05HJpfCClL6DyNiZuQwSGbWuR
 VcWWN25YIWnVZ6Tfd3KyviLuOvoull3MC0Y6uSkcoWht4dZK1IX8pskYlRONXAU6_fC2hbOpvoF5
 TRUXNsBJDY7QamC._4ev9nteLm1N0wTmukpJsXgn4Q6CuM0fYx6OFRBsbdoFojID7UfnxHsXtUxH
 NS9AWPza855c2JK7YdZ.hCgXJ2wF_rnH64NR5793pGm_QwI1gQB45cEqMpSyiX.iuf3e.PONIFtm
 gWcA2lkv2y.xOFf_Sx5fuxCWKeILnKwukSWxt_6w75UVdBR_pT3d0zftdMLkVUDYn6acO.f6FLOa
 gD4ImqVk6RafpxvyFptyTdQkjkAIk8HtBMsAVWjX6l6VGKa0DJDwQKXdp8tPmkvhFBGyogh6Wwsa
 o
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: c8b4b5f1-c136-4b21-affa-62aaec2307d1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Nov 2025 07:40:16 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-2cnbk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ce2e5d13638178c4daec60c4681fbbb6;
          Wed, 12 Nov 2025 07:28:03 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v4 01/14] net: dst: implement dstref object
Date: Wed, 12 Nov 2025 08:27:07 +0100
Message-ID: <20251112072720.5076-2-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112072720.5076-1-mmietus97@yahoo.com>
References: <20251112072720.5076-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the dstref object, which is a potentially noref pointer to a
struct dst_entry.

A similar object already exists in skb->_skb_refdst,
but is coupled to struct sk_buff, and it can be very useful on its
own. For example, it can be used to return a potentially noref dst from
a function, which is currently not possible unless we attach it to an
skb.

Implement dstref as a standalone object, decoupled from sk_buff.

Some of the helpers have to be in dst.h to prevent a circular include
between skbuff.h and dst.h.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 include/net/dst.h    |  28 +++++++++++
 include/net/dstref.h | 111 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100644 include/net/dstref.h

diff --git a/include/net/dst.h b/include/net/dst.h
index f8aa1239b4db..d7169f067637 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -18,6 +18,7 @@
 #include <linux/refcount.h>
 #include <linux/rcuref.h>
 #include <net/neighbour.h>
+#include <net/dstref.h>
 #include <asm/processor.h>
 #include <linux/indirect_call_wrapper.h>
 
@@ -260,6 +261,33 @@ void dst_release(struct dst_entry *dst);
 
 void dst_release_immediate(struct dst_entry *dst);
 
+/**
+ * dstref_drop - drop the given dstref object.
+ * @dstref: the dstref object to drop.
+ *
+ * This drops the refcount on the dst iff the dstref object holds a reference to it.
+ */
+static inline void dstref_drop(dstref_t dstref)
+{
+	if (!dstref_is_noref(dstref))
+		dst_release(__dstref_dst(dstref));
+}
+
+/**
+ * dstref_clone - clones the given dstref object.
+ * @dstref: the dstref object to clone.
+ *
+ * Clones the dstref while preserving the ownership semantics of the input dstref.
+ *
+ * Return: a clone of the provided dstref object.
+ */
+static inline dstref_t dstref_clone(dstref_t dstref)
+{
+	if (!dstref_is_noref(dstref))
+		dst_clone(__dstref_dst(dstref));
+	return dstref;
+}
+
 static inline void refdst_drop(unsigned long refdst)
 {
 	if (!(refdst & SKB_DST_NOREF))
diff --git a/include/net/dstref.h b/include/net/dstref.h
new file mode 100644
index 000000000000..637079260c93
--- /dev/null
+++ b/include/net/dstref.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _NET_DSTREF_H
+#define _NET_DSTREF_H
+
+#include <linux/types.h>
+#include <linux/rcupdate.h>
+#include <linux/compiler.h>
+
+/**
+ * This is required since we can't include dst.h here, in order avoid circular includes between
+ * skbuff.h and dst.h.
+ */
+struct dst_entry;
+
+/**
+ * typedef dstref_t - a pointer to a dst which may or may not hold a reference to the dst.
+ */
+typedef unsigned long __bitwise dstref_t;
+
+/**
+ * This bit is used to specify whether or not the dstref object holds a reference to its dst_entry.
+ */
+#define DSTREF_DST_NOREF       1UL
+#define DSTREF_DST_PTRMASK     ~(DSTREF_DST_NOREF)
+
+/**
+ * An empty dstref object which does not point to any dst.
+ */
+#define DSTREF_EMPTY ((__force dstref_t)0UL)
+
+/**
+ * A noref variant of an empty dstref object which does not point to any dst.
+ */
+#define DSTREF_EMPTY_NOREF ((__force dstref_t)DSTREF_DST_NOREF)
+
+/**
+ * dst_to_dstref - create a dstref object which holds a reference to the dst.
+ * @dst: dst to convert.
+ *
+ * The provided dst can be NULL, in which case an empty dstref is returned.
+ *
+ * This function steals the reference on the provided dst, and does not take an extra reference on
+ * it.
+ *
+ * Return: dstref object which points to the given dst and holds a reference to it, or an empty
+ * dstref object if dst is NULL.
+ */
+static inline dstref_t dst_to_dstref(struct dst_entry *dst)
+{
+	return (__force dstref_t)dst;
+}
+
+/**
+ * dst_to_dstref_noref - create a dstref pointer which does not hold a reference to the dst.
+ * @dst: dst to convert.
+ *
+ * The provided dst can be NULL, in which case a noref empty dstref is returned.
+ *
+ * This function must be called within an RCU read-side critical section.
+ *
+ * Return: dstref object which points to the given dst and does not hold a reference to it, or a
+ * noref empty dstref object if dst is NULL.
+ */
+static inline dstref_t dst_to_dstref_noref(struct dst_entry *dst)
+{
+	WARN_ON(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
+	return (__force dstref_t)((unsigned long)dst | DSTREF_DST_NOREF);
+}
+
+/**
+ * Is the given dstref object a noref dstref, which doesn't hold a reference to the dst that it
+ * points to?
+ */
+static inline bool dstref_is_noref(dstref_t dstref)
+{
+	return (__force unsigned long)dstref & DSTREF_DST_NOREF;
+}
+
+/*
+ * __dstref_dst - get the dst that is pointed at by the given dstref object, without performing
+ * safety checks.
+ * @dstref: the dstref object to get the dst of.
+ *
+ * This function returns the dst without performing safety checks.
+ * Prefer using dstref_dst instead of using this function.
+ *
+ * Return: the dst object pointed at by the given dstref object.
+ */
+static inline struct dst_entry *__dstref_dst(dstref_t dstref)
+{
+	return (struct dst_entry *)((__force unsigned long)dstref & DSTREF_DST_PTRMASK);
+}
+
+/**
+ * dstref_dst - get the dst that is pointed at by the given dstref object.
+ * @dstref: the dstref object to get the dst of.
+ *
+ * If the dstref object is noref, this function must be called within an RCU read-side critical
+ * section.
+ *
+ * Return: the dst object pointed at by the given dstref object.
+ */
+static inline struct dst_entry *dstref_dst(dstref_t dstref)
+{
+	WARN_ON(dstref_is_noref(dstref) &&
+		!rcu_read_lock_held() &&
+		!rcu_read_lock_bh_held());
+	return __dstref_dst(dstref);
+}
+
+#endif /* _NET_DSTREF_H */
-- 
2.51.0


