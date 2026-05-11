Return-Path: <netdev+bounces-286414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKQCN6YvAWqIRgEAu9opvQ
	(envelope-from <netdev+bounces-286414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 03:23:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BA9506F81
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 03:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C06B03007649
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 01:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBCC1DF75A;
	Mon, 11 May 2026 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqgwMEBQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFC81DDC37
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778462626; cv=none; b=nL3Y+ljofB9v6+hTIL/mCNRVG3FT6IlEmv8kEPGg3JTOUt6aOdRyKXs4Cc1uMl0n/B+QycGEmE7m7oUt9kYdNlbnZF6UfTav8l2v5Ua7wko3O9J9j9p0F9NCF1kodJJwPVlnu1cG2KOq1MDjDiXdQqBDMZbwiCL5v3GMtvKX2JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778462626; c=relaxed/simple;
	bh=F2VAvkBERCp+mGQYkIyDNbcE8I2lyyVVTjGzQDEs9NM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KTaP9yq3hWi77BiWBEhUS8ErI9pqT7VcVSGgkwhjvY7GTbQYEsUZN7/6OfnfKe566lv6/R7h0ufyOrT4IV5fKYgnt+oSxaS2lMnHbrGfbCX9nnKBjNzooTx1SjEf4HVD9/XpPKRRPYU/66+fLJh2bgN/XsnoQ9cFtkmLnQaxA48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqgwMEBQ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so42933746d6.1
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 18:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778462624; x=1779067424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ksVibuwz2IAQRfSoImGTM6Qj0T4lExJhGMRdV2BLg70=;
        b=kqgwMEBQaHuzmYGgs/bNRwuWuyGRvcghKOX9HpEo7/bMqOLmSiQjyA4DhtF0jgN+Ib
         xFlqAgs/C1uX1Rmi/VnX+cXYWhbhs/S5reILTpBlcLPYypFxUdjPlU7vSUIi42cxwspB
         ByG9B9QWN/0dI0TILF1vJWK00HkvcHnhPjP5dvGM2Bc1Qj1Jlk+GAH5KuTOlC0/RQpMX
         a7bJL6KZv6lHdUTl9TLBxU/4er6CxnzmDKiuTbAx7NkETgKfN1+ZHnt65Pm6prmJT7yN
         pLtbJsGUU33LK3mO6YZnBXJuiuB2A9L97MIjHumHdS92AR9intlNxtYxPuGyS3O643IB
         TfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778462624; x=1779067424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksVibuwz2IAQRfSoImGTM6Qj0T4lExJhGMRdV2BLg70=;
        b=OQ3lCRacKSUiULpJhcXNqkB3I6mW0q7ntcXQ+wJ1NeQAiRkYOX8Ac7LLBWvw7F2hC2
         tQ8VzhBU1zleqcCgHSHIGzbtDvfRP9S22C5JOSkhwPcv7cJLFDbTm8RP2Gebo7FNMVuN
         izEpKxYgykqVScbK57nhoX5Po7OPLF5kKGdiOMdUlV++txcYdRR94gcmOy2t/7X2QIbq
         tjBbpzYG9Ckt82dDfix7ztUXJtxi8nlzrhUcK7WAybnH6hAN6AizrLI6NlKz6aW4sr6F
         FZx23V88NDXVNVjvsXabAu0sh4l+q9174gJRXzeFod3+lg9oE+pDRte5ihLn3x4mYr3R
         tUJQ==
X-Gm-Message-State: AOJu0Yy3S09j+TCzkZWiTnJ7MLw3y+adnTPWzWJlmSu6disTuZOPWOTz
	4G73RZS6giql4Amcomrl2JXfRTCffevfbCeSLR1aBnh3FRIXXpAGwKyJn0Mh0RVh
X-Gm-Gg: Acq92OHhngSKs0GFjirWLORLbirAcWlOtHbBZp7zaXaRQC2g4vdgVnEJSEu1hEHEUq3
	J/h+9hLdmBHCDLN8td8hU4Thk8Ku/24cUkIpldnlgVoKcHzwWJi0+cEc4S9sbvI0Xb9MWZARWUI
	2jf4nYiRix5j65VB09I0L4UZI2eO2afQ9UzV7wK4F2ts5MwMMqyBMADlsrxK7MGVh01uMjbORw6
	SeUqLcEmYCn4rvfT3INjDEolsXDd983PbVunBsz1NU2gdqTKLOfsOeHaqTBo6UOhl3ePQVbl7Er
	EYtu5K30u4gDF5XfsIARpfBeXPa9TaMengpXZAy1s1Dr1vpwHKwvW8JUwBECTl39rPsmN0SHVFD
	dvS4HWneZ02Op+WtvKyQeLehzdq09tb9X3JQUUbVuvuwrjzLDI7SwXX7RaTVi+cdwildYO+vOx9
	Q1lnvJTxT5fuPdYU7ujteR9NXx+Rgs1LiyQIMgMlONnP2sqDA45Wk1H+b9awTKhQ9KzHP4I5Fru
	A8V3oJCKU8/I9MvDgGMxFMn8tVU4dBEYvL2hM9TkqnbVSBo0AA1YBl+FMxIhKRtdx5bhO3eFg==
X-Received: by 2002:a05:6214:519d:b0:8b8:88a0:1061 with SMTP id 6a1803df08f44-8bf9c88f220mr169565176d6.36.1778462623671;
        Sun, 10 May 2026 18:23:43 -0700 (PDT)
Received: from localhost.localdomain ([2600:4040:a749:9d00:3cd4:e915:884f:f88b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53ca982a1sm328874036d6.38.2026.05.10.18.23.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 10 May 2026 18:23:43 -0700 (PDT)
From: William Gonzalez <gonzalez.williamalexander1@gmail.com>
To: netdev@vger.kernel.org
Cc: William Gonzalez <gonzalez.williamalexander1@gmail.com>
Subject: [PATCH] bridge: vlan: reject reserved VLAN ID 4095
Date: Sun, 10 May 2026 21:23:39 -0400
Message-Id: <20260511012339.71569-1-gonzalez.williamalexander1@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 60BA9506F81
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286414-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gonzalezwilliamalexander1@gmail.com,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The bridge vlan parser currently rejects VLAN IDs greater than or
equal to 4096, which still allows VLAN ID 4095. VLAN ID 4095 is
reserved and should not be accepted as a configurable VLAN ID.

Tighten userspace validation to accept only VLAN IDs in the range
1..4094.

Signed-off-by: William Gonzalez <gonzalez.williamalexander1@gmail.com>
---
 bridge/vlan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bridge/vlan.c b/bridge/vlan.c
index 27d31ba8..09c01153 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -224,8 +224,8 @@ static int vlan_modify(int cmd, int argc, char **argv)
 		return -1;
 	}
 
-	if (vid >= 4096) {
-		fprintf(stderr, "Invalid VLAN ID \"%hu\"\n", vid);
+	if (vid < 1 || vid > 4094) {
+		fprintf(stderr, "Invalid VLAN ID \"%d\"\n", vid);
 		return -1;
 	}
 
-- 
2.39.3 (Apple Git-145)


