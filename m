Return-Path: <netdev+bounces-291606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALvvDpFoFWqyUwcAu9opvQ
	(envelope-from <netdev+bounces-291606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:32:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7BA5D35D7
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00A5C300D6A8
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0253D7A14;
	Tue, 26 May 2026 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="UuaW0gXm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C013A3B7741
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787878; cv=none; b=iN7RL8bqocBVAGtAHnxcYpfIL++XX9qVdLdp5eB/xwtgZV/AOrJQUWdmoSmOEpjmxqMkoVjph0nE8lpNx4xQ379D0XdiVixR6CFN25hQOAb0WzCCi9oAe6ldg4SzdUWlbBWAwUBo5z08l19SxLa8ipZ9SPyy09SqPlAV56HHpiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787878; c=relaxed/simple;
	bh=GaWyZI8GTHXd4nEu+St0loCud0SYnF3o0zqqQFGK9wM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUHWQTbtvEvnM7eLSGw7dpm6IJKBp/s3GzOxyfILFq7ioE038/PO6LOftOIRiotzgCg+meB/2Lmhz5eXh8tbzCmgAq3CZ8mn59isxildAnIM4VieN8+4ub2tYYJKVR5iaA39j198CfNu0LKvkr8ZhQf+RuIzoDu61r8ndErWjXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=UuaW0gXm; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d75312379so8698590f8f.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 02:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1779787875; x=1780392675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1TDvqAyFlVxKGtNUc9btTtlzkS1xwUoFgbr4epPWWGU=;
        b=UuaW0gXmjb28m8Cn/anbg1vyINH/UgnS1fIJXWSzJS9x2Kvlbbot4ZWlZfqwwqvgQk
         KhfgnATkwgvtTy5hdcFvSWrxZE3wGL/N9fqe4/AypMcBgZ2CJl4vXpTVA7VZViV4aNM3
         6H06tcczhmoslD0aJwoHHvXof0yQ3xKpRDxqn6CwRqzD8lEk7Qhj4WdVDxiXH2cPZKyG
         TcJp4SuzhnOLWAUGbca3FoG/D072lVCDUolFAzRmi8i5Xcu6XOX0qGihAYk+0xsCCx7/
         bS0AzQXqNFAT6VaYeM48RqJhqGSumjTXNPdIGsLz8AysWKHDA+XddUUFI9lMVEc+Z1vd
         QlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779787875; x=1780392675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TDvqAyFlVxKGtNUc9btTtlzkS1xwUoFgbr4epPWWGU=;
        b=UinQ7GyJqjDrVny2Cb41lBpfvqmJWqjlesQn0vBk0JQolDQ7/QH4vlI1wtK8tgJ0WF
         5Z+ubmtesYfS1nZspUhNuIP4DzXdjyjR6s5JPmPMw1Y3BYm14Ce70vcVWHw/dEKYbtue
         LDuqydNehwHSbq2uxWIRnzAvNmukf45wPAuMnSJ3r0qi6GvCBoEFHXDsijDNdh3SqOKV
         Y+V6MaF2U/T8kqNOE6pDvfu5Vdhwg36Znw/THStQblzNaWmNmfybGMcGtBIAZgoc1ruB
         g7ijCogF8bP9KDGr9qmoSba6UHZrisub0YsK6xAcWi07U6FVgtaOFEPHFoTd6x5pvLok
         3OKw==
X-Forwarded-Encrypted: i=1; AFNElJ+VYXDOIBH4CtBQXtVeApJs3ruvtGyoTPSVP9e/T/Z6zBjvAXDEmKhFIvbM5gG6/ZRk4nCfze8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx33BSbxigkFt/q3txH1okw3tJaDsdPmb3fR2/QtOxfIlqsCoT5
	jBZZB+l/01NZyp0ugZcJ8PxKeqpleb8Bm/j9aDfNb5+9XB0eOS+3HFaS1uzBtF9d9bUXhqmYky4
	NQHkKlmCstFw=
X-Gm-Gg: Acq92OFXsDvx/cFZY557687Oxzv6ummsENxfkOafvqkkcDFKuvz7X0Mdf5tL0148w6o
	Gx7UfLdlyPzlcIw4zA8yOFCGanNuzXW1SUhMyhVXiqVHwqj3vv1bPsZr+sbBXFnuhcw7a14gesO
	BcxCTOrbRowROdwONMpld1pxeFZpXKRftzC1OtEmKoe+90dE+KNBNB7K40CS6BxgVeNVhsYPfRM
	K6Z3Xq5m96BuMhfZYBmXa2RlEzTLAnzTsqFVRumFlpdetkfso/9KW8qpPZ+aBRCbvpKq71M9LOi
	UDWQdeJ0IFCM3rTHxjxOOYSboNICFHx5cOOmZQnsjgQxd6n3jvHCet/NH2ZC8lrFNqHnkV2fYoz
	kVV6QqNgzHy7erMl9Jezer/IUQjhXQ9l+ybJ9OeP2aZ8eNtRw4Or133Q+cDZ9Z1btDe1dirh3jq
	V53klYG4f3GzjzAoC/79ndipqro9wkdboxtSp7VeT8uSVddDzquSzPWLXM6GoQmn33A1zr83tmI
	S1kJgeJ4j6iWmGuzT2cn5cZCmA/eSPPLMAWnGt8H/y2eNWZ5KH1Suc=
X-Received: by 2002:a5d:5c89:0:b0:45e:8ad3:86a9 with SMTP id ffacd0b85a97d-45ea3138d38mr36473526f8f.8.1779787874838;
        Tue, 26 May 2026 02:31:14 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d70c51sm36450132f8f.36.2026.05.26.02.31.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 02:31:14 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: oe-linux-nfc@lists.linux.dev
Cc: security@kernel.org,
	netdev@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH] nfc: digital: clamp sensf_res memcpy to NFC_SENSF_RES_MAXSIZE
Date: Tue, 26 May 2026 11:31:12 +0200
Message-ID: <20260526093112.22614-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291606-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[0sec.ai:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9D7BA5D35D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

digital_in_recv_sensf_res() copies resp->len bytes from a remote
NFC-F device response into target.sensf_res without checking that
the length fits in the 18-byte destination buffer
(NFC_SENSF_RES_MAXSIZE).

A nearby malicious NFC-F device can send an oversized SENSF_RES
response to overflow the stack-local struct nfc_target, potentially
overwriting saved registers and the return address.

Fix by clamping the copy length to NFC_SENSF_RES_MAXSIZE.

Found by pwnkit (https://github.com/0sec-labs/pwnkit), an automated
kernel source review tool by 0sec (https://0sec.ai).

Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/nfc/digital_technology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -778,6 +778,8 @@ static void digital_in_recv_sensf_res(struct nfc_digital_dev *ddev,
 
 	sensf_res = resp->data;
+	if (resp->len > NFC_SENSF_RES_MAXSIZE)
+		resp->len = NFC_SENSF_RES_MAXSIZE;
 	memcpy(target.sensf_res, sensf_res, resp->len);

