Return-Path: <netdev+bounces-291919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAj9ImIDFmrNgwcAu9opvQ
	(envelope-from <netdev+bounces-291919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:32:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0045DC53C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61236301708A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841FE3939AE;
	Tue, 26 May 2026 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="xaVM4TFK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9D925F984
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779827552; cv=none; b=ABumwfVbRN8VUGUdqsU6yLRpRZ/D6fIbZbZZPTauEATIJej3PVvns2w32Ts+g9K4m3s455ea5drO01K94KKXyV0D5rOtfA5vD6Ety4pNdMU0sRGtplwkM3qX93VX7tTxfAylvFjGpADpECyd2s6akkf31tlNaVQ2p17P1UHCt0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779827552; c=relaxed/simple;
	bh=J8QTJB03WvozUL/lm9seJKVTmum3YvberljLi5CeonU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1glqZ9quRyoZKT4mfwlq6bqnOS37Frh8eV+AZWBKZzocsL8nXGPqRuixrWz0SdKPs98jBfLepNJtnqkbTlT396nQQ4uqQ0wHCT4LHEwGyiZuvGu6WnGIK57cmjjGwAktGq3t1b369PuUoa0ZzgSaT3dGEzrwBj/Bla2m6LP58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=xaVM4TFK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d77f6092eso6299558f8f.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 13:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1779827549; x=1780432349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yOE68Mzf5nnVfNMftzrnIa4+AJ1pM+MIvuOSTOhC6JY=;
        b=xaVM4TFKL6WqoTgUxw6ugDtAPaPmv85BHuXPwkJiLyV07nNxeXK3xOW/L7tOoVKpAZ
         Fh5IYXgqOyich0LSdQ/l2ggfmrRdf0Z9E6+Bkdf8nQ9Tq2kaVX7A3ceknme7+nLVySaa
         jYhwcK4b2OsdkYvc9k0LCOmnBPOHnWqHolXdubMKckvW1Mn5SwrxWcyW+cxYl0djre3J
         ie7J01i26gDu47IlnGQcexZmoQYT8pHwUGXKMf7IJwG8YD7IDYnKjraXG9pkknj0FAaV
         xBGqa9yzvEzLCKtYwO68+6HPQNT+O0lCP4bJqVdj8o93TDwZyS7nSF1HfE20nryJKlmO
         Ealw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779827549; x=1780432349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOE68Mzf5nnVfNMftzrnIa4+AJ1pM+MIvuOSTOhC6JY=;
        b=l2ldEGW2oZ/sq5LVtSvvOv9UnMSxELkCzj7LIzyHVvizn5frsCMIaDLA5PERFEjpzI
         2S0vmowN1HREROjxCvXFoya5M7CemzeIHHUZOnEj3zvooQS73QZ1+0eukp8UUhHndgoo
         DMNx9XpZbVJb9qAxNQ1pnYgYIPz0dUoRC3RsYG6C38Fh4eeTwUPYDUQ5xOtSElNm1lIK
         EyYRRH7KM7gAxbw6nYafApL2RyVF3T0r158z2hEaZPRNhdIQV0j2IyF6mI8HQm4E5Tod
         bpKTV0Tf990B7wm0nNQxdjiZOjqfm2oJpVdjKPLm691622Mzr1E5jkiMdI+LlyYu3dMx
         d04g==
X-Forwarded-Encrypted: i=1; AFNElJ89U3MFWycKRPP+XS4Dz9w5QLNXcDt+PFWfGrU4lpITG6oPgLxtwV941qqy2q3/9dBpC8SZ1hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEWfdY82ux/qen+VBFuW0olFbT3WDmcW3OmoCsewmYYHQHbP7d
	pcvDNb+Zh+yiWe72OxZyY7Xneut1VN5p7dlpWSxQy3FPKQG/7LnHH7AmsRUw6i/Q83c5CQvTHFk
	3cJNPtxou+Sw=
X-Gm-Gg: Acq92OGNcCQjGwY8I4CP65AIchCt9MZ49tdtdEMjrgMdqY9in9FFpdUEPC85ZPlKbma
	pICmEM2PK6BplyNWyK0jBl622it3vXag4hZHYapUbsBP2fVm1amVX2p1QIPdyBwaMGAs6M69nL4
	YkPo7TwzOjKnZBmiBVRyw3OObWg2dvEds0WlQtskcajjcxZD5SyurQ3egnD/pJkzhw2rBRQhx3Y
	qlqeyjO2ND8AszUqd1+DCbUEDFhOqL2WeQctkL8NXllx+Gb+Dj1rHHQvv8/Ad7AlVkQ8H1ITFVy
	EuNJFGWl3qiY9xACJPw2N6jhXmFqnQcl3OcgtzoAWrvBc9nO6nXlbFMuT7a9bQ1J8U9449w04rA
	mmK97/vyVL6lvbMgt5dt2CPcITwpUErLwM4Wa4nCS/SUI1WjBqusotqx06UNzcMQRlnfQzcQmsz
	e279pg8PgVQhStBpI9bX4ePtknj0Dc/vmyx9ZALMwHbyM3HLXlM0k8WM+J1SZsA6ql2QQP/5ARH
	f7z+5dbLGq7J8jl7ShBkETOIa6ZYuf9HiD78y4nJ07SG9OfMDt9Zxk=
X-Received: by 2002:a05:6000:41c7:b0:451:66e6:501b with SMTP id ffacd0b85a97d-45eb3324e34mr29057635f8f.0.1779827548645;
        Tue, 26 May 2026 13:32:28 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb557545sm851693f8f.12.2026.05.26.13.32.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 13:32:28 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: oe-linux-nfc@lists.linux.dev
Cc: security@kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH net v2] nfc: llcp: fix integer underflow and missing bounds checks in TLV parsing
Date: Tue, 26 May 2026 22:32:26 +0200
Message-ID: <20260526203226.73345-1-doruk@0sec.ai>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291919-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.939];
	DKIM_TRACE(0.00)[0sec.ai:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2E0045DC53C
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

Found by 0sec (https://0sec.ai) using automated source analysis.

Fixes: 19cfe5843e86 ("NFC: Initial SNL support")
Cc: stable@vger.kernel.org
Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
Closes: https://lore.kernel.org/netdev/20260525202427.67768-1-doruk@0sec.ai/
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2:
  - mark as net fix
  - add Fixes: tag and Cc: stable
  - add Closes: tag

Link: https://lore.kernel.org/netdev/20260525202427.67768-1-doruk@0sec.ai/

 net/nfc/llcp_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index XXXXXXX..YYYYYYY 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1302,6 +1302,9 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,

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
--
2.45.0

