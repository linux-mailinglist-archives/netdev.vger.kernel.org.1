Return-Path: <netdev+bounces-287173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBWeMtEvA2qN1QEAu9opvQ
	(envelope-from <netdev+bounces-287173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:49:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C32A45219EB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C4B830EE05E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1B239061A;
	Tue, 12 May 2026 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V78pH50R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4C93905EB
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592693; cv=none; b=u1903VNU0/dU6zH5s07/F28siB5AerRz/GWyVvr/UhbzGr/+eSWxl6MyXLnb9ccIb9GusxwWS6yzvyQh/juCymlTT0laIdK0jf1rg1RRW1fH2cJrG1IJsbz9pBrAQG3EqrwORRFp3hFptuDbYe1ppQNlDGgkiqK1LbfJeG0eih0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592693; c=relaxed/simple;
	bh=R45r9yU7MMX7pT+++mCU8H39a39mlzYwFvuPyP+hqQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QBNTznpmFrvbTR8xb//cZSlU0jCoPR8Q9uH3R69cCP8Xz2fpy0V4DwcnGSWgeigsD7aYIM7You2bJk/B1Q7HTOFNzq6qWFktRPApH0X3QJzyknFjTDspQmAor0BiztubBBzEGYkh4K6AQsM/mgQlHV2Vbf4IOxC02iEIT3AJiZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V78pH50R; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba928852a5so36508935ad.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778592691; x=1779197491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QDYkhHfQmXQhrZX6ApB+iupAaO7l8zpahGGh7xZwSNQ=;
        b=V78pH50R1sM1uE0bPuqXiOmAzERQZq5XSzRjG5OI8SH/nhpM2aSgyNzMoL0/3nYwzL
         KAZraVLizlUAEbxVYf0fSGdiPbnM7B9R7qqQDyCfRx1o5H+Pf98at0LvKhsxRniJ9wVB
         VlACJJ1iBLpatNMrsmMCy90Jag78SwTEpmkdgTCXMyf7/ruei4PPiJUl8DAs3GXT2fJ/
         8IaQb8xK1eRVrrEJIqeihCvLJ1tZPs37PktGSy+PFweWe04TZefzr2ylc1CZ7YuBzRL0
         yi/o7he43lQyWQvI2FIYKckhgzxicPjLcwIV+W/QnmxbNAQqkd4TQxVHWiBMnT1hMJc3
         iwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778592691; x=1779197491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDYkhHfQmXQhrZX6ApB+iupAaO7l8zpahGGh7xZwSNQ=;
        b=L7heIBpxGTVfITIjWoVFycmjI64KU/t5VoQJ4vg+geBQkOlFd0wr24u5SMgekQgUFJ
         PJVn1OnI9JC7GZK+Yj+YQPGxTI9FeVnu6RQUgfztDOHqVjeeoGaVm1soj0zafBueJHQO
         8aWEQRN4TqoBI2mClGQ3wyB2qflDs2k8yxzyRjYcQHLg3mZ8x2Kaqq5mpZiMAvpSXgXr
         J1CNn0mGjHaAdikEFJGcadf7zn0WeXt9ZMSjlkzTsdhLSxpuzjfIZAdFaViayS14TYMp
         A/DQIinT79xEprzo5TbB3cF16VHHXee0kVSL6CIy8hG1PY+cX1AHYRI4bBjDhM0zFgZV
         urvg==
X-Gm-Message-State: AOJu0YxQxd2cbotQz5N6sGzaehEWmrYgj2K8mFVzKqCf8EKRbQWRIAvU
	Tjv8P3S067FwK1QCeTOjoT4kJZJjBljBrb99xRDSqwx2usOfO5JIDioBnlFxAGKf
X-Gm-Gg: Acq92OF+MTz7PQFJxtmeBoITr/OnA4Krhn2xXR9XcX0SHF2zadhn4KSVjA99h6J+5RF
	G2jxowJzcjF0kPYvVgGmQbxxGiRc/H9j6LIf5wSpl8I8y4bG6iFnfH/3s9KH12DUmQwGMviBkGD
	1xhQ5bJhjvJTBJyUa8vXllGY/pOAPQjvjnbRVKPWNB2/0EUkyGRAsJD74cloZdGV7CcYOSXbZRW
	8DHGC4NPu/dF3HnAQcVAeoSRH/oDGoYZ2jmOZo4PuAaq4m5BPjHXNAlNkShOnf9MN+X6c7u7pY5
	INVFjM34K1uU5S5r7DgFJfhFw3I3Yam1ImxaOtqAnYTwQyk0ubjM74IkaPNdfQ2T4+nSRfKjLiu
	vtwYgV57VA9zEnhAvgQuT3vRA2anV6G2nGPpqtY/3QS/zkkUB5XRuc13FzfyauUQS4531JAErBW
	ovAEIU1RMrBAQYzE0Dwnmt08J53KDRnPh3UxtqVK9BNf2DQmjgxIeZT4tDBL3Iew==
X-Received: by 2002:a17:903:1ac3:b0:2bd:7ca:e67d with SMTP id d9443c01a7336-2bd07caea66mr26778545ad.29.1778592691438;
        Tue, 12 May 2026 06:31:31 -0700 (PDT)
Received: from r912.lan.4v1.in ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2700dsm139967095ad.2.2026.05.12.06.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:31:30 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] Documentation: networking: ip-sysctl: fix typo in tcp_ecn_option
Date: Tue, 12 May 2026 19:01:25 +0530
Message-ID: <20260512133125.1772658-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C32A45219EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-287173-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

"regarless" should be "regardless".

Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 2e3a746fcc6d..4c6a35d07a08 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -489,7 +489,7 @@ tcp_ecn - INTEGER
 tcp_ecn_option - INTEGER
 	Control Accurate ECN (AccECN) option sending when AccECN has been
 	successfully negotiated during handshake. Send logic inhibits
-	sending AccECN options regarless of this setting when no AccECN
+	sending AccECN options regardless of this setting when no AccECN
 	option has been seen for the reverse direction.
 
 	Possible values are:
-- 
2.54.0


