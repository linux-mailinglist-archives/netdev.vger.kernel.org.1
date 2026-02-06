Return-Path: <netdev+bounces-257375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIpPAbE1hWlf+AMAu9opvQ
	(envelope-from <netdev+bounces-257375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 01:28:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D587F8A04
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 01:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7201C303428B
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 00:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C368207A20;
	Fri,  6 Feb 2026 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lYtpQLRi"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EBD205E25;
	Fri,  6 Feb 2026 00:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770337657; cv=none; b=aRthKYBxPGoTAHhgoUTRljvlHGUF86777b/DfWYACnKOTItwF5b79FA+3OfxmuMHWsEFVq7V9DByI52T14+S+AMfuYkeTlzJR17jfzPF+boa+Pu5M9RBZvFw50TGJ9WziqNp6+vRL/W5IHMrkqrXDO79K68AWT/N+FryxN7HpLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770337657; c=relaxed/simple;
	bh=1RARk+ZNBucupua7AOknp++jAAXf65IB9iVB1hXUpEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDhHZAn7eZZdLGTwYsbG5hB85qEuwJnFv/zVQOFyFGy1ulpWsVDIiwd0WdfL1o5eVf8dKZ8r+AapKByz4rfHZ7wBFtgBtZyrPwAqzAYeyM/ZIretmjC6cZZvhdqhwOpgBIFVBZM+aH38SpZv8yUR0TPahNAQhzmPyjCkYH5yP64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lYtpQLRi; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615JBT7b3292284;
	Thu, 5 Feb 2026 16:27:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=zWt8nkIjO0eKVZt1rqRs+WhnwVduqp4MDpiVTgTyz1E=; b=lYtpQLRiFFm1
	e7/ELFefKlhPqRhRORh239hXyj7CZszXX+9LA9nmXqvhoo87MDZVBMScjtNBA3Aq
	DvmJL9oOs5EI/R4nRB35uwz+5ADOauC01AOWV7UUHqulCY3lS5/PjvMSKodXTqTV
	cNS6EaTuzvc9ulGOdfckyUnRPB+99mA+Az+pIiqBoZpw9zdXBN+gg5/IhvxpIrD2
	spg6CJZavBBhHK7AbTzkNTVWR0zMu8o85Pa9x894o82TH2h1R0AiWKZb5rn2nnpk
	BQbwsPsNIYGyiaoeuLDug6ZZL+JtqaOxYxyu6WFqto1TqswzNuc2lFDAdovucSb2
	qtgAbIXxUA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c4x2spd6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Feb 2026 16:27:23 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1c::1b) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.35; Fri, 6 Feb
 2026 00:27:21 +0000
From: Vishwanath Seshagiri <vishs@meta.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S .
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei
	<dw@davidwei.uk>,
        Matteo Croce <technoboy85@gmail.com>,
        Ilias Apalodimas
	<ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>
Subject: [PATCH net-next v5 1/2] page_pool: add page_pool_frag_offset_add() helper
Date: Thu, 5 Feb 2026 16:27:14 -0800
Message-ID: <20260206002715.1885869-2-vishs@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206002715.1885869-1-vishs@meta.com>
References: <20260206002715.1885869-1-vishs@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YjZH3TCYAu4GQR4IyH0Gx9wr3UozoqWe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDAwMiBTYWx0ZWRfXw2AM5Nk23L6C
 coQ8dqF2Mf07vJVAlpeDHYcxQlduRREi5d7Wl13y6JkafyU9VAEUT67qo4iy+eCGxRvC3hS3Mxl
 j9CzNsIBAjZ/C28wUKA+KVVgn/9gg8qFhWxLOtec0EWUAzJxrqhd0qyJ0pYtCEm0r6t5VtmLC+d
 2/W3HbvzZpN/i6C4ozJEO5/n9j6Snxu3DkVdCgV+GSK3BSKg3tP9HO5ln2rW4C5I7kx/5YmrpfY
 mjvdtZBSTH+ymJwBFV7b+4nBSEmRx4OrJyE6maKd3Pl5gOn7RHlRXIMU28CiGVhmW0qoZPoSYv2
 kZkySvCjETl39Y4xRXSKLf3z/z00v4V9DfJNt1s9aeo15GocSf/ciQXRQpEc0RzpFJpWZ0PWed+
 duLRoO97mISYqy7y0ecn8pptGOnjuaOK6+96Cbz09//Jzxfdws76ST2FuVSxR0ZR4FOuu1Tnx/y
 qybG2c0mYdaRC2fn/9g==
X-Authority-Analysis: v=2.4 cv=aPz9aL9m c=1 sm=1 tr=0 ts=6985356b cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VabnemYjAAAA:8 a=rozs98Jf37xvrOoLKDoA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: YjZH3TCYAu4GQR4IyH0Gx9wr3UozoqWe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_06,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257375-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,meta.com:dkim,meta.com:mid]
X-Rspamd-Queue-Id: 6D587F8A04
X-Rspamd-Action: no action

Add a helper function to advance the fragment offset without performing
an allocation. This is needed by drivers that extend a buffer to consume
unused space at the end of a page fragment to avoid internal fragmentation.

When a driver uses page_pool_alloc_frag() and determines that the
remaining space in the page is too small for another buffer, it may
extend the current buffer to include that space. However, page_pool's
internal frag_offset is not aware of this extension, which could cause
the next allocation to overlap with the extended buffer.

page_pool_frag_offset_add() allows drivers to advance frag_offset to
match the actual consumed space.

Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
---
 include/net/page_pool/helpers.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 3247026e096a..14907c3badae 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -96,6 +96,26 @@ static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
 	return page_pool_alloc_pages(pool, gfp);
 }
 
+/**
+ * page_pool_frag_offset_add() - advance fragment offset without allocation
+ * @pool: pool to update
+ * @bytes: number of bytes to skip
+ *
+ * Advance the fragment offset by @bytes without performing an allocation.
+ * This is useful when a driver extends a buffer to consume unused space
+ * at the end of a page fragment (to avoid internal fragmentation), and
+ * needs to ensure the next allocation doesn't overlap.
+ *
+ * Must be called in the same context as page_pool_alloc_frag() to avoid
+ * racing with fragment allocations.
+ *
+ */
+static inline void page_pool_frag_offset_add(struct page_pool *pool,
+					     unsigned int bytes)
+{
+	pool->frag_offset += bytes;
+}
+
 /**
  * page_pool_dev_alloc_frag() - allocate a page fragment.
  * @pool: pool from which to allocate
-- 
2.47.3


