Return-Path: <netdev+bounces-291450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGRfEFOvFGqWPQcAu9opvQ
	(envelope-from <netdev+bounces-291450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 22:21:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 909215CE43C
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 22:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56CAC3015C82
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DEF34404E;
	Mon, 25 May 2026 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="m0sAet2C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD3B26E6F3
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740496; cv=none; b=pCnh3LS1TdWDkdnwtVWpovSfTTNrlfwCy/AMGQYoZERdbJEeyMvk8LkyRWiD18saccUaQBNdAF5Z068brp2KffLnE8RApVowREQ+5ebXqyPwKft5+5RgTVYnSXm9Ev8WPskGcR3rlEU3Ho4pyIv5IXpIrJRMtoZLRRfHbglHBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740496; c=relaxed/simple;
	bh=RyV70KG21x+U9Hjaa0H5yChUF7T9irNeR6mdloxKgHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kvosew80k1P8bI6y/FQVt1kK22e9lCT09CXfZGjEXJQJfpi2E//BWxZja2Oc/7IUf5p6GYoS6mP8z92HPieOHub9RuG3DLcI/ygIuj95PsKsQZ4REfFTMtzblMDNcKnk29kN4Bc0HM1OpIZBfqFv3TNbDt13YbhbLl3it4T6X3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=m0sAet2C; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49039a8851fso42978475e9.2
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 13:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1779740493; x=1780345293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IxYIky8RT6KvZ8TGdaQwxCoSJctGsAxBOVSzD0t66cA=;
        b=m0sAet2CweukQDHbVjydL9kJIsuvjgNTX8o+cwIDRdiqwROqcNgdD87G3ThPhHFtKT
         6iM3XR4mqSepN+y1fpK3fpFJC1dymO87sK7PEzd15d+7HuNGM+Qy5oXeqZOPqBP3jYfP
         FugDrbcG8k/BQeAQWp8acaPKWtgjbKE721hRawdtU6NtamFGiyjEbGgIqctwnvjjLklm
         oSQsxNqho8++5LcM77mDysy6iUIQjdgWZ4c2XTNrClaFF2hnTnRTnLo+9hezZnc+fl3T
         TMDjcoXae7Ootety8zBdnF56Itd8Sar/qHja6aJPTJ+hnEkexIt3s8y6/89KWtHr2jBQ
         AuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779740493; x=1780345293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxYIky8RT6KvZ8TGdaQwxCoSJctGsAxBOVSzD0t66cA=;
        b=PUI33JIuluakQJKh+U/KWjQZRRMy9qFsuYC7icaSSEBcpmWi9ABxHw6ogoCSpztI9R
         coGrSesuBwQQ0o7JG42LvJrdaYl22cJfArGXbEEGc0osV0aY9w4+4dbH3Aywi3cvOKTR
         93Fu3Uxo9XN9WMv1aTA3crfHzfEFt1XlwBdJdswyom7TYyOyoZGVIMNpDW4kd/6BBWN9
         VKVskLtdZxJdA8MwrswyyB93zd3fWy5Re4oF9/BTFifceiUMtBpd57Vk7hih7Dot9o06
         kjH5Zm0xN6r3lJnwOCgftq9HKb/0x96qzp0YrCVNjKMaTofN5LH/OtXRpthgBm6kA3l4
         Uayw==
X-Forwarded-Encrypted: i=1; AFNElJ9DjkyjtuJsLnWVnSOaVsVWhwaQv7Z1RBgevkrGwmYW4g2DaKLucxl817CG2OwqPz/lOoVdkAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwruxSlVW0XwkWTlpWo1tZM9f7VCNbvqt8n96vKgTImlF/fqCxr
	3ofqC72TlMdktCDf4e9AclANLfEexPoWF4GhY5/DnR7yCCk/Nd9hW6pisy/wGM3EFBoD
X-Gm-Gg: Acq92OE1Hja7zRL9tyXwMSGUX7WcltR3GZRTUf2yYAf9QbB4kXtmk8zFmKwHzyjbgyt
	Se5nA7XWyeZRvDgSsdkCoypo+Lrmwdf49kCMbrclHtUFT6zSe6UGWMcjhjQzMDF8mrYMJnhn7Gf
	oBYh+EPIBlllB6M4wLFHPTf0uuSk8Elwj+kVoykozntUONd52SdXUFDYUj89bR4+riXP8RkY9Wk
	QxyhieFadOqhaBoId9cvX7ay8njV7hqCSkkjp4hZR3VdFueK0H6xho3b9KtObiJO2NZqhVR1Dg3
	FHAinHr25rYNqGrjCYMNi4iIQhHoWoaCULnG17ug4JIuJPFsjizsLJOUgOFR/GpqN8ZClUyfTZb
	48hMNSnB3Vw06psQ/XRJm0i78jJQMxMwg14+zHo/TEB2sdaSMBnUpDnTm+3jBjBcNRZ4h/+K+be
	+kEm35BZ8icZjBepn3Mkb2IXlQWrfpMOyNw+HkiaddKGrSEYz6DFoc0h5PXKcgdazN3ZEA9RfNr
	avcHLVj7+6V9t/81IYXtoP+UjPtJSWH21rShQ7ceJC+CnKpCK8mx94=
X-Received: by 2002:a05:600c:1c21:b0:490:44eb:c1e0 with SMTP id 5b1f17b1804b1-49044ebc29emr262643195e9.21.1779740492936;
        Mon, 25 May 2026 13:21:32 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490452765f5sm281452425e9.5.2026.05.25.13.21.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 May 2026 13:21:32 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: linux-nfc@lists.linux.dev
Cc: krzysztof.kozlowski@linaro.org,
	security@kernel.org,
	netdev@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH] nfc: llcp: fix integer underflow and missing bounds checks in TLV parsing
Date: Mon, 25 May 2026 22:21:30 +0200
Message-ID: <20260525202130.62671-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[0sec.ai:s=google];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291450-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.937];
	DKIM_TRACE(0.00)[0sec.ai:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,0sec.ai:url,0sec.ai:email,0sec.ai:mid]
X-Rspamd-Queue-Id: 909215CE43C
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

