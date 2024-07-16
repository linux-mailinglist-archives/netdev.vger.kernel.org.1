Return-Path: <netdev+bounces-111723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D69932498
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F329D1C220DD
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 11:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55FE197543;
	Tue, 16 Jul 2024 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gA8nyVSJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC73D1CFBE
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128049; cv=none; b=ty/F57Uk5K5HGaYdVa/v0HhweEW8WjD0teGZf9zA2bDaSRuQUEuuJBe8+Er0DN58BFgyiiUc9F5cKWxUhGxNAovlJB0ze5d3gLQv3//TwG8TVJEcM5HND2RGjtFrXUcl10sTyRuBxJNtg0cVbwvgF0fTC8sOqFIHYvBYxgrvSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128049; c=relaxed/simple;
	bh=ksg9S2Lx7KorDm/hrBtFt0KGof42WCBKh1f7g5GEq6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AtTwaLT5AnKlx4ayFFOPteXHe27O6GXxEmF21MVeEZz4qpbF5XwSqYSS3GqcSxydNsXFg1uF/NKGBoBOlmOST9vLcW9f2qkPoL5auImA6D886OhwgPwOpKGMxUpmG57SLct16pyNxGWeGYAN7ubJYJ+gXBEq5TGhVANVDN4Nhqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gA8nyVSJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721128046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hvvnj1XLuLsMaLUuoqgaQm4hXgNbSPKG0xi9JLjL1II=;
	b=gA8nyVSJDAbYr1Hzda7iFqcl5H0f8veQHJQNnnw4wZ7/xmjSk/rBQDlpMfBkPdxrJ8F9DF
	cjrpkTo7pETlhLuc7xwnpq8QDk8ZTmuWA1QJbk9kZyvb11j7ehPN51BAaTXk41avItvj80
	Vqo3JME3STwnuGCxwfbCLPm4KHHs3Uk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-njBfylUNN9GjlMHzilKnrg-1; Tue,
 16 Jul 2024 07:07:23 -0400
X-MC-Unique: njBfylUNN9GjlMHzilKnrg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 657B01955BF2;
	Tue, 16 Jul 2024 11:07:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.70])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACA591955D47;
	Tue, 16 Jul 2024 11:07:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net] wifi: ath12k: fix build vs old compiler
Date: Tue, 16 Jul 2024 13:06:39 +0200
Message-ID: <3175f87d7227e395b330fd88fb840c1645084ea7.1721127979.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

gcc 11.4.1-3 warns about memcpy() with overlapping pointers:

drivers/net/wireless/ath/ath12k/wow.c: In function ‘ath12k_wow_convert_8023_to_80211.constprop’:
./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ accessing 18446744073709551611 or more bytes at offsets 0 and 0 overlaps 9223372036854775799 bytes at offset -9223372036854775804 [-Werror=restrict]
  114 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
./include/linux/fortify-string.h:637:9: note: in expansion of macro ‘__underlying_memcpy’
  637 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
./include/linux/fortify-string.h:682:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  682 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/ath/ath12k/wow.c:190:25: note: in expansion of macro ‘memcpy’
  190 |                         memcpy(pat, eth_pat, eth_pat_len);
      |                         ^~~~~~
./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ accessing 18446744073709551605 or more bytes at offsets 0 and 0 overlaps 9223372036854775787 bytes at offset -9223372036854775798 [-Werror=restrict]
  114 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
./include/linux/fortify-string.h:637:9: note: in expansion of macro ‘__underlying_memcpy’
  637 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
./include/linux/fortify-string.h:682:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  682 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
drivers/net/wireless/ath/ath12k/wow.c:232:25: note: in expansion of macro ‘memcpy’
  232 |                         memcpy(pat, eth_pat, eth_pat_len);
      |                         ^~~~~~

The sum of size_t operands can overflow SIZE_MAX, triggering the
warning.
Address the issue using the suitable helper.

Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Only built tested. Sending directly to net to reduce the RTT, but no
objections to go through the WiFi tree first
---
 drivers/net/wireless/ath/ath12k/wow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index c5cba825a84a..bead19db2c9a 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -186,7 +186,7 @@ ath12k_wow_convert_8023_to_80211(struct ath12k *ar,
 	if (eth_pkt_ofs < ETH_ALEN) {
 		pkt_ofs = eth_pkt_ofs + a1_ofs;
 
-		if (eth_pkt_ofs + eth_pat_len < ETH_ALEN) {
+		if (size_add(eth_pkt_ofs, eth_pat_len) < ETH_ALEN) {
 			memcpy(pat, eth_pat, eth_pat_len);
 			memcpy(bytemask, eth_bytemask, eth_pat_len);
 
@@ -228,7 +228,7 @@ ath12k_wow_convert_8023_to_80211(struct ath12k *ar,
 	} else if (eth_pkt_ofs < prot_ofs) {
 		pkt_ofs = eth_pkt_ofs - ETH_ALEN + a3_ofs;
 
-		if (eth_pkt_ofs + eth_pat_len < prot_ofs) {
+		if (size_add(eth_pkt_ofs, eth_pat_len) < prot_ofs) {
 			memcpy(pat, eth_pat, eth_pat_len);
 			memcpy(bytemask, eth_bytemask, eth_pat_len);
 
-- 
2.45.2


