Return-Path: <netdev+bounces-294766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id daR+Gzo5IGozywAAu9opvQ
	(envelope-from <netdev+bounces-294766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:24:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD24638883
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:24:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=0sec.ai header.s=google header.b=qmHCz89Q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294766-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294766-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BD9D3102FF5
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2BF3A8FF6;
	Wed,  3 Jun 2026 14:14:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AE243D508
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 14:13:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496040; cv=none; b=PkUHnJWgvZe2RSQOqNpx2HLMh7WASvKSn8mOfbM9u10G231UnH08Le6PaEymJLEOwfWB5IOaw90EzYPzAbwc1GF8x22IPdYR32yRKYtWw+V5SpwdfBm1Lq9XmLc/a9qiF99QgM3XeK+jMwFzwKCkSP+9ralIAHtR5oLMYnS/kfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496040; c=relaxed/simple;
	bh=rltsMnPstES5O95K26OEKN7CoVBeKZdZbNkscQutuP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yzwu2Vyojo7rE3jqpbk2ZzgGL1qQrK0Q17hpzl2ICWGCwRKBQkwGHo5VqCkEGCmITE+g2ASocnjor74ZaPE6Y3x6vP6kvGRUiErmn2Qi27AVDhiuQofr7LUWzJPvaq8ZCMOPeZo4l3t+SvoTYgkYEOXLIohZNBze99rrUdUqFag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=qmHCz89Q; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b613a17bso10324775e9.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1780496038; x=1781100838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VjsRnZLZQ7estap9LmjUBhs1AGh/vTFeIsSLLUn4dTk=;
        b=qmHCz89Q+g/pg+3oeXfCXYnh9bdh5d186DzHO7wwxjQ8vDhT2wc9k72Xt3s5PXgDwy
         rzqrkTCJRVJyFY7bWcOHk909tFA3zAtIvQdOKwzILVrK8tRFbGYMo6thx0NUL4waolBi
         igzCtQbHuYWS88dxccZFYAvfJIdS5BHBsTWZItckPkA6z03lEWTHyUrOgdnaD4FTXGx0
         /cmV3RFGY2DC1Ed32py3H+IEB0UPqSfUzuOlzqwWG8KOlviKrkCJK0ZML4CSlajt7IN6
         K3m8eSfXHttSYbz6g8rQrNmhodoJqD7k/nkcsPERUDTGIu9CTOa7+DwXEsLnauGju5ps
         Ux1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780496038; x=1781100838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjsRnZLZQ7estap9LmjUBhs1AGh/vTFeIsSLLUn4dTk=;
        b=hi4FQYBraNMLb2nHcQYVEjDtwVKwnmuR4uHfALzb0g2uuUzhxfsuAaM3huVrEzEN/E
         AEXX9+fdvni+dUh+VX94o4rQjb9G30zRf8fb6unU52Q/yOmpWaMISq9ZoO4tdl2CV3Hc
         xnskPYDMzmw3g5w8e67CqcRCXAnuXBQJCpQof6voWqYhpV1cOekqC5jJjVlcspU2GoTH
         kh8dacGQ2K2y1LlJbgRJ/A/IGJU8OZBtRpg7bfdKszt+hZ9D+PlGmSHQP8y4rHR91UzJ
         IFFMM2ZJ/b3ECo7p95tw3pvWiyIo7C0jSX2xL/NuxX2lbEEDY+tuJyF8e3skVApPopx0
         gOng==
X-Forwarded-Encrypted: i=1; AFNElJ9m1yQad6ZQIxyLIddEGLjzQgjadaO6r9PT1PAzAxLpGdIZoE7YI09nF0WpQ3C/saKfjq5l1RI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylr9bFFOph+BO0iEGfdEfbR5L5x1xkD1HZeJKGakkpb3z5yJ89
	TII1P/PaL2KNtaG0EYZp7DeGGNyi5/32hZe43vdXUHb2DKENk7PyY+v80X4dWrzyW+6Q
X-Gm-Gg: Acq92OFqhwDSaFx8KktI9wJR4NYhaIzs4C6pD9hMN2hkzqS69npXj01AAT8tyGTD/Ul
	dL3oDzVJYkB1qiptaVQIRkel+96eSXrc4GDuZ2Y6RaKx8a2bW1Z1wIBFSRAy3YnZT+MZzPsDuaa
	Zi4PBqv/zITrcBvHp5jrTOErVfksYgiUozZaoJc4hNZ/oSdkBFZAiI1zQoRNx0pofGsL+aOXP0B
	m+AinT5h8dpiXL4s2r0fPY2iat0bsFh+mhH6Ogt/xQL2zE95bw9uCXhJLjW1I/7kiEWOdCKEgru
	pWxzsKA4bleDyY50vq7LN51QXUTWgwG1kVKwsw2o29WZF3oGI6xn+AoMGFNxkEk4YoaV0wC1Kyo
	EdhUD3SpEu/z7XMxI92dWS3sViTfqjOd4a2vjVkiQ3ryo8bvm/v0ACowc22I+JeN43blSh7FgKW
	ucEgA4vluRumKoabjMHJP3fGAb/CNI0icFec2A1YSiDjurALqSHj2Qj6Ifhc7jNQ+ibt5MYgnnj
	2EVgCCApeQ1vgg8r7Rd2Io3Qk0Nd5/a0Q4ukQBLkfsAFcCPwsE/+gxKdDfQmeJ/xQ==
X-Received: by 2002:a05:600c:1392:b0:490:a1a6:6f24 with SMTP id 5b1f17b1804b1-490b5eaad68mr59903695e9.15.1780496037716;
        Wed, 03 Jun 2026 07:13:57 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b6d16f0csm65358165e9.15.2026.06.03.07.13.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Jun 2026 07:13:57 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: David Heidelberg <david@ixit.cz>,
	oe-linux-nfc@lists.linux.dev
Cc: Aleksander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net v2] nfc: digital: clamp SENSF_RES length to the destination buffer
Date: Wed,  3 Jun 2026 16:13:55 +0200
Message-ID: <20260603141355.68156-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[0sec.ai:s=google];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294766-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:oe-linux-nfc@lists.linux.dev,m:aleksander.lobakin@intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:doruk@0sec.ai,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[0sec.ai:-];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0sec.ai:mid,0sec.ai:email,0sec.ai:from_mime,0sec.ai:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBD24638883

digital_in_recv_sensf_res() memcpy()s resp->len bytes from a remote
NFC-F device response into the NFC_SENSF_RES_MAXSIZE-byte target.sensf_res
field without an upper-bound check. A nearby malicious NFC-F device can
send an oversized SENSF_RES response to overflow the stack-local struct
nfc_target.

Clamp resp->len to NFC_SENSF_RES_MAXSIZE before the copy.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: 8c0695e4998d ("NFC Digital: Add NFC-F technology support")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2:
 - Clamp resp->len with min_t() before the copy (Alexander Lobakin).
 - Add Fixes: tag and Cc: stable (Alexander Lobakin).
 - Frame as a stack buffer overflow (saved-return overwrite not demonstrated).
 net/nfc/digital_technology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index ae63c5eb0..ae6487c10 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -778,6 +778,8 @@ static void digital_in_recv_sensf_res(struct nfc_digital_dev *ddev, void *arg,
 
 	sensf_res = (struct digital_sensf_res *)resp->data;
 
+	resp->len = min_t(unsigned int, resp->len, NFC_SENSF_RES_MAXSIZE);
+
 	memcpy(target.sensf_res, sensf_res, resp->len);
 	target.sensf_res_len = resp->len;
 
-- 
2.53.0


