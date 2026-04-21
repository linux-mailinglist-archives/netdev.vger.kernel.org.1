Return-Path: <netdev+bounces-280049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLmGOy0752no5QEAu9opvQ
	(envelope-from <netdev+bounces-280049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:54:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 445574386E2
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C3853018AF1
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D03D1C84A2;
	Tue, 21 Apr 2026 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell-sw-com.20251104.gappssmtp.com header.i=@bell-sw-com.20251104.gappssmtp.com header.b="pMpt3wli"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8E638422F
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761543; cv=none; b=CxIvpFX7GNl3LqXtXeGQnDxeemAf7f3mDXIk4T1zsIZGW2FJQcQBGja+1HfWIqeI0esDdyFkLUh35XMfyD396hwKSNbDHBbrBazxAagBWdADPDgFpy20CwaXnJT+QAWoJoO9Vjl8Twm4xNtIs2QR5ECPZGLb9uMqSJJ05OjOYdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761543; c=relaxed/simple;
	bh=NlkOyYOYNr9TbhVPzvPSqj3i9x86hm9cTd4gj8wzY7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rSsUVLgfNQETO6BiouiA1za0bBvg7Y0neYkjBP7dYXnXTgR9KcmOiUjXNzidEoiP1n/Lh3palb2qv6hd2r4/GbAol1w68hMFnndrEmJBYIvTqU6tAnMTpiD2biObL2M1GSYCVSMVyDJ9NPxbIVBvf+T2QBVVPQiGqUOu/BJdaVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com; spf=pass smtp.mailfrom=bell-sw.com; dkim=pass (2048-bit key) header.d=bell-sw-com.20251104.gappssmtp.com header.i=@bell-sw-com.20251104.gappssmtp.com header.b=pMpt3wli; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell-sw.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43fe608cb92so2678698f8f.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20251104.gappssmtp.com; s=20251104; t=1776761539; x=1777366339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=96fAiGAXmzJgYomT1GQ8n650Kmpz3cdGMVUS3DtTjhs=;
        b=pMpt3wliTmtPCOvoXoFb1+l0qINLUZA8hWMooivJ63trJnHFIc+4V1y44H20vFOgta
         CPDbmL1ws/jrVdKa1gf6ULfkl4P9CEYnVbqsfq3JHVb8cVki3PZXg2JD07V3iOVSKK/V
         Q6wk615v6hZsnFCtVniVlDCn3Br9LWmLUG6zI6/N7IuUjgnrEzHXUEmIezfiDkykpVWK
         kTu47u3Bu9d4K2NaAoB6xJHMOyJty5RlHVBHc/jUMLYj9ogNvkH06KMy4u1w3oOz/iH5
         H+Nz7//JgbcTEG6bMr32D/+m1kvnOSo5i6diwRTJsBAZNu5F8YMYjrls5LQCISRE1R2e
         02PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761539; x=1777366339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96fAiGAXmzJgYomT1GQ8n650Kmpz3cdGMVUS3DtTjhs=;
        b=TycAZ9Af5XQ894tz/FOM53yjSHxl2y52yUcvBgEeQmhSSSQsgMkcXg+Hj11bwL6ElY
         Nhs2zhsr2VB4fr2/r1tFLehwbEG9xCSoaMxXe5CzFRH1ROTtHk7Dz+v2B2XUTW/NhHTh
         xo7ZtSeTePMbFjsOTSAH23/gqEOjnvcxY/AgIHsDUQOrfohkAF1CMoMOoPr3RXzUmJQA
         We5ehzHh4g1j7pbuYpG23tzac70nti5s/ffliCif9kE1cUHKyL+MrYEL68anYjQ+R4H8
         sXAw+lTN9fpJ/Gf1EC8qRHanjflTGLWoa6eW4FMk3UG74MY/me0eHUkHsZfQmtUj4Ae2
         dhhQ==
X-Gm-Message-State: AOJu0YxsqVyUEbTxNyiFq+KxQF8O27ois5YEeXd20Vka8TQEDhkSUrhj
	kaY5uUf0P6TswShkfvjum7xqnnhwOvOcPcEOaBGsQDtXCm81nEN/Fq4KmMzQRcwdJwTDQUgiMI9
	jhYqchA==
X-Gm-Gg: AeBDieudhG4dhWdAirjns1nw6BnHqf8GFrGINaZy2N2qieZVsYg6ghsoFUo+sJj8Q8b
	M7eDLPB8SrCAYuBKfOYVsfJEy7XmXmedT+Ob1fh1xD/9vtlaW9m6ZzkRbx79bNUGvSmBODLcIXh
	M2weAM71X8fzmTPB2YyVVDSoVRf/gAbUDsmOqSnazODjTi7Qs39sliPA1IEAgpfNsAFrSCkT+sg
	0qTOcaEHGbcphR15VyZ3FIr11Z3Tg+nfYHzy3GgeU5zWgI7Dcm54pGjpTdUsve9jM4vpwzquyrU
	sAVxNHoaj9PssgKhCGRUFfcKDC1wUhO+inoXSlwK/MVOhqWwkqwD037sNtPys0QEn9l+CrtkwYp
	SuNCegKngEDXCq+46Mw7jqZqVH5sm6vXecRin2DCcvhdinSTbDsdVKQuSzZz4s7d8mK+lC6ijYw
	OYMKU5c6wN3I8rqSJzXiQ2CK+pDD6QfcNNeMZmFou7GIS3cY4/
X-Received: by 2002:a05:600d:84ca:10b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-488fb796fabmr155181085e9.26.1776761539448;
        Tue, 21 Apr 2026 01:52:19 -0700 (PDT)
Received: from localhost.localdomain ([5.8.39.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1cfbf2sm365676825e9.15.2026.04.21.01.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:52:19 -0700 (PDT)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	oss-drivers@corigine.com,
	Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH net-next] nfp: fix swapped arguments in nfp_encode_basic_qdr() calls
Date: Tue, 21 Apr 2026 08:51:24 +0000
Message-Id: <20260421085124.147049-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bell-sw-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[bell-sw.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280049-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[aleksei.kodanev@bell-sw.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[bell-sw-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bell-sw.com:mid,bell-sw.com:email,bell-sw-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 445574386E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is a mismatch between the passed arguments and the actual
nfp_encode_basic_qdr() function parameters names:

  static int nfp_encode_basic_qdr(u64 addr, int dest_island, int cpp_tgt,
                                  int mode, bool addr40, int isld1,
                                  int isld0)
  {
      ...

But "dest_island" and "cpp_tgt" are swapped at every call-site.
For example:

  return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
                              mode, addr40, isld1, isld0);

As a result, nfp_encode_basic_qdr() receives "dest_island" as CPP target
type, which is always NFP_CPP_TARGET_QDR(2) for these calls, and "cpp_tgt"
as the destination island ID, which can accidentally match or be outside
the valid NFP_CPP_TARGET_* types (e.g. '-1' for any destination).

Detected using the static analysis tool - Svace.

Fixes: 4cb584e0ee7d ("nfp: add CPP access core")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c
index 79470f198a62..5c1edd143cee 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c
@@ -493,7 +493,7 @@ static int nfp_encode_basic(u64 *addr, int dest_island, int cpp_tgt,
 			 * the address but we can verify if the existing
 			 * contents will point to a valid island.
 			 */
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 						    mode, addr40, isld1, isld0);
 
 		iid_lsb = addr40 ? 34 : 26;
@@ -504,7 +504,7 @@ static int nfp_encode_basic(u64 *addr, int dest_island, int cpp_tgt,
 		return 0;
 	case 1:
 		if (cpp_tgt == NFP_CPP_TARGET_QDR && !addr40)
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 						    mode, addr40, isld1, isld0);
 
 		idx_lsb = addr40 ? 39 : 31;
@@ -530,7 +530,7 @@ static int nfp_encode_basic(u64 *addr, int dest_island, int cpp_tgt,
 			 * be set before hand and with them select an island.
 			 * So we need to confirm that it's at least plausible.
 			 */
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 						    mode, addr40, isld1, isld0);
 
 		/* Make sure we compare against isldN values
@@ -551,7 +551,7 @@ static int nfp_encode_basic(u64 *addr, int dest_island, int cpp_tgt,
 			 * iid<1> = addr<30> = channel<0>
 			 * channel<1> = addr<31> = Index
 			 */
-			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
+			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
 						    mode, addr40, isld1, isld0);
 
 		isld[0] &= ~3;
-- 
2.25.1


