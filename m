Return-Path: <netdev+bounces-234614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6197C247A9
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C72189F459
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 10:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD9533890A;
	Fri, 31 Oct 2025 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfl4OOWI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85154335564
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906819; cv=none; b=cyQKyOxroAFuMx4nqjF8CAm8W9hhgfzJwOpzHn4C4mnJjMRlULEyUS5izc1CE//Vd1JbWcNV7MiayI4xnyLDqa5CbglTFjaQwgT0TGrxFQIHUsaa/+XDCzoC02W1eXq1Srht2SnyUE1PJ9vLdn+5qqY0HXl5OOUikJ9VEzgiJz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906819; c=relaxed/simple;
	bh=NqfgEExTDyu4ekyUV14Bk1tqKYqDa3c4eTax0NuMVKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sxHnAanE7Ht7WXxIfOLiH+RgKe+dyPeqmgqzuv7ovm43ekd6LsT0Ik3ICOuVAY0Jp/iQu9CHroeRtYq2A7N2u/OPJ0SiyDgD+9D/Mfaby7/pNaXkdeSNtjp3rL2uEJPDDvLOwQH85ammgJA5ZL78NAckTMDoqec/3MEng3dW73A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfl4OOWI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a26b9a936aso1605709b3a.0
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 03:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761906817; x=1762511617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mDafDPUtFXrtAlT9VtBP4rWIbi0j9HAnmrWp0z/kAxs=;
        b=lfl4OOWI7STOeS28Tzbc1CfVhN8q+QU+1/C1bnTPBoCVy7CR9ZR7JCLavPr0ya+iEc
         y2ssDhNVU4204IoZc8p+JaaytJtbml0eodaICoqWLbhda/8wohMAZ5ptjoylg7QY6Sxc
         ACyoY2oHOok72r3UGvEJcI2GQbuXk2ksTwPj8iDGUnMBesRbNNXGz6Ajat/TFGXxBg4n
         3kouiJZATmlruaPxb1fR9Y2P8QmFGwGFc0WNbpVd56G1rN324NPzNgcuizH+km+oIJav
         iDlBMu0hgEyafO65ScGJeEEAtOLOGdgN9xBBREoJEg7KC+Nl6gKMupFtq94LhVapYorb
         3f6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761906817; x=1762511617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDafDPUtFXrtAlT9VtBP4rWIbi0j9HAnmrWp0z/kAxs=;
        b=Mv0KL+es9L1jPWwgvxMfiLuiFnRyCkwcFhz/iv2FGrWLaV4nzD+Q+nApRqS/+kjktZ
         S37T5h4VcBmBzjhy8vp7rLCgziX/KvIgNsjWH48iwa0Vb55cOL0ut9aCiSqaT1Nk+XPm
         0TFIznNhQdzngWIfNn7YKAb7K1REcvUFQVpdancgC0E4WzX58dEaeOHJ5t0fXjvqkonz
         /F1VzjNvb0sbP7OME8cdJk7Gkt4hFqX/YGBVOAZIGwIhrEmVPE33Wlo5WUOUxN+tYWbS
         s+N6Ii57hL15qRdAbhBrqZRnK9L/dMH/nDckbfsN5Xn/QONnUZBTEVCaATO6aaE6HEsJ
         Qbrg==
X-Forwarded-Encrypted: i=1; AJvYcCX0VXX/maVtT5zoTfRYDThMOlX5I9LJXoTEo5s+guGhLqwNBWvuLh5UiFfrGSKUPlepovHNs3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YweU00Hi8FRmcGGCdMKfhS/0fugtVYm4New+z3/yBS5LhtkwKdx
	Q4AECaWR+1XbSMxlkMVUGeSgg9+aQZLTWuqcSXghcRG8TuZyHYGdIs/o
X-Gm-Gg: ASbGncus4Duiw7Z28nLjhJfBL15HxJs0ty44De5ePxbATP/jD+LPaeV9kM6QgALzYxi
	YZrejjufJIWPedvMpGnJlysBvdte1lAqNSbO4L4t+6sw3zVxD5KMRB7kkRRRcj+dWmGWDRM8uT7
	M9uOl+ZFwRMTSO+6S0Rab2wVdh88ZSmke9DvRxkKk7ovslzEz761FbYVhslepxetFN/e06RBFDU
	qHR9+tl7cQjUkPSnvJuDKKtqmG4TOpzuxnekPgRMSKp75oEAimQvk9qeKpBJtkaVyl2f1S7cT8T
	Mm0Ezb5xRw8o3HkgDg1qd8NxbCmqsDmpPIpf3TJoc7p0K/W0gqJ5httXOegGnjhAfLNPIqLdPnM
	IMf1A4MejdKTcZRxaPI+UpjfoJ2XBZv14E9YTusrG0NqRNiqCuYxn/dauBz4qMMLXn2r/yEE6/+
	/e09f7ZZyeOOJx1olZGuaiHMicr0dOxN+l2rulMfOVhz4KXUlE/axdfRXxMelqIQ==
X-Google-Smtp-Source: AGHT+IHM+XH6eYdXCIOjYkytbzv5MHIYUe/eXJH+/42z00FS0SYBENmMb3ab4XvaXsNiLMYWd7icvg==
X-Received: by 2002:a05:6a00:951a:b0:781:171c:54cf with SMTP id d2e1a72fcca58-7a777760e07mr3641417b3a.1.1761906816801;
        Fri, 31 Oct 2025 03:33:36 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db678f67sm1701530b3a.57.2025.10.31.03.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:33:36 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH net-next v3] xsk: add indirect call for xsk_destruct_skb
Date: Fri, 31 Oct 2025 18:33:28 +0800
Message-Id: <20251031103328.95468-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since Eric proposed an idea about adding indirect call wrappers for
UDP and managed to see a huge improvement[1], the same situation can
also be applied in xsk scenario.

This patch adds an indirect call for xsk and helps current copy mode
improve the performance by around 1% stably which was observed with
IXGBE at 10Gb/sec loaded. If the throughput grows, the positive effect
will be magnified. I applied this patch on top of batch xmit series[2],
and was able to see <5% improvement from our internal application
which is a little bit unstable though.

Use INDIRECT wrappers to keep xsk_destruct_skb static as it used to
be when the mitigation config is off.

Be aware of the freeing path that can be very hot since the frequency
can reach around 2,000,000 times per second with the xdpsock test.

[1]: https://lore.kernel.org/netdev/20251006193103.2684156-2-edumazet@google.com/
[2]: https://lore.kernel.org/all/20251021131209.41491-1-kerneljasonxing@gmail.com/

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v3
Link: https://lore.kernel.org/all/20251026145824.81675-1-kerneljasonxing@gmail.com/
1. revise the commit message (Paolo)

v2
Link: https://lore.kernel.org/all/20251023085843.25619-1-kerneljasonxing@gmail.com/
1. use INDIRECT helpers (Alexander)
---
 include/net/xdp_sock.h | 7 +++++++
 net/core/skbuff.c      | 8 +++++---
 net/xdp/xsk.c          | 3 ++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index ce587a225661..23e8861e8b25 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -125,6 +125,7 @@ struct xsk_tx_metadata_ops {
 int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
 int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
 void __xsk_map_flush(struct list_head *flush_list);
+INDIRECT_CALLABLE_DECLARE(void xsk_destruct_skb(struct sk_buff *));
 
 /**
  *  xsk_tx_metadata_to_compl - Save enough relevant metadata information
@@ -218,6 +219,12 @@ static inline void __xsk_map_flush(struct list_head *flush_list)
 {
 }
 
+#ifdef CONFIG_MITIGATION_RETPOLINE
+static inline void xsk_destruct_skb(struct sk_buff *skb)
+{
+}
+#endif
+
 static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *meta,
 					    struct xsk_tx_metadata_compl *compl)
 {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5b4bc8b1c7d5..00ea38248bd6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -81,6 +81,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/psp/types.h>
 #include <net/dropreason.h>
+#include <net/xdp_sock.h>
 
 #include <linux/uaccess.h>
 #include <trace/events/skb.h>
@@ -1140,12 +1141,13 @@ void skb_release_head_state(struct sk_buff *skb)
 	if (skb->destructor) {
 		DEBUG_NET_WARN_ON_ONCE(in_hardirq());
 #ifdef CONFIG_INET
-		INDIRECT_CALL_3(skb->destructor,
+		INDIRECT_CALL_4(skb->destructor,
 				tcp_wfree, __sock_wfree, sock_wfree,
+				xsk_destruct_skb,
 				skb);
 #else
-		INDIRECT_CALL_1(skb->destructor,
-				sock_wfree,
+		INDIRECT_CALL_2(skb->destructor,
+				sock_wfree, xsk_destruct_skb,
 				skb);
 
 #endif
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7b0c68a70888..9451b090db16 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -605,7 +605,8 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
 	return XSKCB(skb)->num_descs;
 }
 
-static void xsk_destruct_skb(struct sk_buff *skb)
+INDIRECT_CALLABLE_SCOPE
+void xsk_destruct_skb(struct sk_buff *skb)
 {
 	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
 
-- 
2.41.3


