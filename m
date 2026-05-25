Return-Path: <netdev+bounces-291451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEbrAFewFGrRPQcAu9opvQ
	(envelope-from <netdev+bounces-291451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 22:25:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 529A85CE577
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 22:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A8A73038C7F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364F92F7EF7;
	Mon, 25 May 2026 20:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="Dr3OyDs7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FB038F232
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740672; cv=none; b=h9aNXRfhdKH7fg3NVAz7SZV1AtfPtTBONa4a+ERhhhhYuZC3fx95lYAlK4RdWgB7eOwDgLML82oo5/IZZaWtL/1/plNZUYzpZWN0MdguKzZl1NOouSHawEKvboMoShoorXi8E0lp8daXcOnXhagcPowMpTrYgzevmDFjveT/bzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740672; c=relaxed/simple;
	bh=RyV70KG21x+U9Hjaa0H5yChUF7T9irNeR6mdloxKgHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InvNvFWmY/LTIp7UTCRSVgro+NF+jWXSzsVs3haW2hiOZAEmQBDww5uIEX3oI8J0j9SZ8AyShuY8DCT7imYtKory0U+MlKjAgsnJA0XlJ0Fo+PCuk/dIRNcpEzu4IApSKNci1W/cQrBsCtnFdxuu6qIoK/MiQrh0n5zBJlETdhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=Dr3OyDs7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4526a8170ceso4940730f8f.2
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 13:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1779740669; x=1780345469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IxYIky8RT6KvZ8TGdaQwxCoSJctGsAxBOVSzD0t66cA=;
        b=Dr3OyDs7CSx2TSFFE3ruheKJTtsieXQEAJj1AkYuu1rfrH+7xGM2uyB4ZDOJzq9yoi
         AehFrLcXpxGlYvSPvoNhNKVoL8FaIcRBshjI6DrC90pbuk5HzD71HVUXMIls+ckJPq17
         xyBgi+ybEtuFRoRRNatoWkKug82xzLrKQwKKKiXAOoF1m0Cm609MxTmXN2vEerclmb6G
         C7e+us1vgfzS1Sw+QRkGqm7sPP30Lo6O48+gFbXO3abMl515tKy69HUA3V4yvBN0qrOr
         0sqL2Bu4lXGplmZ7ohH5aXeGm3jksldHaO/0KO+eCjq46EJihdXQKfeapKosLVNwlPEw
         QsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779740669; x=1780345469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxYIky8RT6KvZ8TGdaQwxCoSJctGsAxBOVSzD0t66cA=;
        b=GH7NJqY7hADzrjNfS/YJ7XRtj7x/YNoHMJhxvMvkHuVT384aVm3vBjUQh5b7m+rt2F
         3mRTqOZpykK5WpI/Jd87IcduB6ZTf3WETtvznemWSnlT2RLACmzpjmjzI2hcmzm5swxW
         DDMcSkx4BRdokDevbxGHr00Kl+oYGKDY1LYeyoz2+3FI2FnC7AaMnBWgA+FnlXSv60Y6
         6YeG+Y3k9T0ejU9+UP8Ly4TLvC/uyYlqDxczpZ5lI4CUZd7jap8AYllfeZvf2Qz7lOzZ
         QOnTg6/0/tsOVSFOQZa0CpOAGPwVOh2hBIcahZhq4RxgpnF8novLovDIwLvEPs9WwG6x
         J3kA==
X-Forwarded-Encrypted: i=1; AFNElJ8nhCuceFumIU+Xm+qUDa0SaDpbhL4QYDhdQ8otUWNxEwmg72qgdThXX5V5PC+cqVDTvknxbMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ6Wmvwb0WJV3PrjZml8JLFFrg0N4dx8MJ0ORwTlxh+oP3zbkK
	qnR5+1r0CeYT1kdS33NZ9SgUjBD6pVwcFT+TUVrSQ3PLTvEv2RioDtaI7wFsfUvMiwrZSLed1py
	TMnE103mgQE8=
X-Gm-Gg: Acq92OHm671yH6sFPqQbMTnrdUICbfL3QDImU+vi3Z3d7MgkgeJxYjqCyoroKwGSuaQ
	+WmyL0D1biF0nKkndsmMUN7D28aho3KwH76s0F8BPdg6TKgEBcWvev7/c3xL/4QI1gu4xmKoqwb
	l17LC5SQpnqi15zTnXmxCAXPr7zxVZhPCG/m3fPhM6uA5LysB+5ppGATu+SBhtdeDlDtrZ7TV0E
	iSTg3hTcR8XsK9ISm6lrD7cXQ1ptESIzhZxZfkjfHl8KLGgeQVie3Wq5fHocZ9dnXAPOBwClE9F
	B9CtdFUY7jrEZdMd294xPNgudKVqNWkK1likBnAAylM0RHD+cNjeGSFlFU1rkCfOT4oNygETqgh
	lrUgbaGiHq6y8fSMGUnrxg6MltuXoDcAKmkL5qaDV1ZUMxpLWaEPILTm9ewxkSrnjfT4dSzpghW
	IfYuS9eXBjUSEhsxunyyU5kACBzlwKW6JUvCArcSDLh4Oeqcrxv3u6qARErZg/mBt6zDWn2VpfI
	RddJjGOxW8zzC4GsfUqj/rcXq8w4gBWZARiqiOGr3Ve
X-Received: by 2002:a05:6000:2c11:b0:45e:8547:f214 with SMTP id ffacd0b85a97d-45eb38b8b72mr28563604f8f.32.1779740668747;
        Mon, 25 May 2026 13:24:28 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d4ca0dsm29333426f8f.18.2026.05.25.13.24.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 May 2026 13:24:28 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: oe-linux-nfc@lists.linux.dev
Cc: david+nfc@ixit.cz,
	security@kernel.org,
	netdev@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH] nfc: llcp: fix integer underflow and missing bounds checks in TLV parsing
Date: Mon, 25 May 2026 22:24:27 +0200
Message-ID: <20260525202427.67768-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[0sec.ai:s=google];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291451-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:-];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,nfc];
	NEURAL_HAM(-0.00)[-0.295];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,0sec.ai:url,0sec.ai:email,0sec.ai:mid]
X-Rspamd-Queue-Id: 529A85CE577
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Multiple out-of-bounds read vulnerabilities exist in the NFC LLCP TLV
parsers:

1. In nfc_llcp_recv_snl(), when an SDREQ TLV has length == 0,
   service_name_len = length - 1 underflows to SIZE_MAX (size_t is
   unsigned). The subsequent strncmp() and nfc_llcp_sock_from_sn()
   calls then read unbounded kernel heap memory.

2. All LLCP TLV parsing loops (nfc_llcp_recv_snl, nfc_llcp_connect_sn,
   nfc_llcp_parse_gb_tlv, nfc_llcp_parse_connection_tlv) read tlv[0]
   and tlv[1] without first verifying that at least 2 bytes remain in
   the buffer.

A nearby malicious NFC device can trigger these without authentication --
LLCP link activation happens automatically after NFC-DEP.

Fix by adding a minimum length check before the subtraction in the
SDREQ case, and adding bounds validation at the top of each TLV loop
iteration.

Found by pwnkit (https://github.com/0sec-labs/pwnkit), an automated
kernel source review tool by 0sec (https://0sec.ai).

Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/nfc/llcp_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index XXXXXXX..YYYYYYY 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1300,6 +1300,9 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 
 	while (offset < tlv_len) {
+		if (offset + 2 > tlv_len)
+			break;
+
 		type = tlv[0];
 		length = tlv[1];
 
@@ -1307,6 +1310,9 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 		switch (type) {
 		case LLCP_TLV_SDREQ:
+			if (length < 1)
+				break;
+
 			tid = tlv[2];
 			service_name = (char *) &tlv[3];
 			service_name_len = length - 1;

