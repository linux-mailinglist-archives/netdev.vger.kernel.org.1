Return-Path: <netdev+bounces-304332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UEGrER9CR2qEUwAAu9opvQ
	(envelope-from <netdev+bounces-304332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:01:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 427796FE84E
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:01:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nD6UmefJ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304332-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304332-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F71D30151B7
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 05:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C691633A9F3;
	Fri,  3 Jul 2026 05:01:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EFB32E743
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 05:01:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783054872; cv=none; b=bi9cqMj6amh6MRMUs5g4zsPASzgImiquvnP86d579fV7lz7J85JAx6F5mxhb4CbL/+fmgDhPwag1cBwfOBFSDNIV87oqtabKFVHNN10c0KeqUygUVVUjhV63twK/OFQQcRTGSRO4rsNP3QFKdfGHtHiMUwWKyfLUS2lVxQEQn80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783054872; c=relaxed/simple;
	bh=lvsRQxYA/4Aj86xF+a0ZvMPMqRuKaUvNmA8BkrGGf8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l0uEmspaMkowUjGKoUTptnOx48IBVhzh7b3mmBG4VzhUgB1EnxpjwyrUksq0+2m+cZr2bM65XKCFsPd7QGJ+WTc8ILO7Ge8dNPXn3ZkyemmzmUHsR5jazfAaziwA3aCGQwE6vmEt+6XlSRrqUWZd5ZqYjV+/ZY5yWeKNSNN71TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nD6UmefJ; arc=none smtp.client-ip=209.85.219.43
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f2509d6becso1428506d6.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 22:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783054859; x=1783659659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXaOhXKFNzha/+UZgRF1nlZyqJvtz4uRe3j6zG6TsZY=;
        b=nD6UmefJX+ukBfZgrRQVNuIIKVu7R4jhETCefk0whkbHzLpJBA11/qkqfk6hrR/ZEp
         fn+1/olJv2LMlyXsrdeVB07lCSbZraxLVXUN9tEG9Tr6At2zt3X0wvpKcrmrWchdhCOC
         M+yR79V7uShAWj/PJ3EolzYDCx4Ylty5U7K6Awkb5ZtSmputLSY8ZMhFf07ZJBmwhHNA
         WwZgOAJ0oY0zrW1LzGpV+OLbJSNRBN7WpWQ2azlDnt89bgkQokQ48CNkGW3eZL+iRexI
         CWb+MoJYq11TxSKwITt3i4JF30Sg2/LWROqS1dks8enfp2rfQmvL7sPVzKxdcxFdgy4c
         tGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783054859; x=1783659659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXaOhXKFNzha/+UZgRF1nlZyqJvtz4uRe3j6zG6TsZY=;
        b=FIeDi5EM649oZ//MLjsf7HaHemF9Ho3azqfoo5w9tFJU03lR2dXSXZWlx5Z8QYdKns
         DuhCF0foU3EifnAyUQKslP10BWZciW6FPRfiBXIocPUVCbyV3z4DBxT8N4prE3Bph+Eb
         JkIhAtSiRB7fhC3qns9iA/gLnH9h4346049sMs3edo6TnJdLJq/pzXEAD5rdYnw70Sbf
         cJ9Ei3EK6IfKN8HKwnduttG5jPvvm/scdY4knaqt4l9zI0Xa4jBZyvtxyIn/jYFEZOp3
         yYIR/OjKR1foISKnj7Y6Os2zakXQzO4zH8Iwq0dY8767tc+dEqCr2xY6OMdBC61v+6sc
         stow==
X-Forwarded-Encrypted: i=1; AHgh+Roor+UZXSgttecl0qpD6qOU+VaXXABdLqRSnEpb6eIGak0/i4K6dwSMOuJv9cn0S6tEUSIY76E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hnvg9JwoczCS60csOme6goBvSqiLYpH/QLKefjCpf+ujph+U
	iGnYCkfeMV2FHFch1JVeS8W+IwMMIQwLdW+x+z8o6QPq/RtSrEX873wa
X-Gm-Gg: AfdE7cl7r2LWn8NOK6IfiuuA4x0sPv75W7SlP1kOUWDedo19zgNLVy7j0ittPpCRAWk
	eUYHNwcSdaEoXBttuVVy3snhePTmkeXsDxyiSIu13tDd2T+i9BOcBQENVsuKCTTZNNYh3t4IFU8
	g2ldRDgRwqjgEjleLb+knNDvKkzIVn3NhlHaq1rlGlGkQUt5wPQToV7B0r9Se2KZCswO+Kbsjp3
	onYx/uuTLVDfbm9sUNKNfxA5U0HCJFHwSrSfweg15gW4WBK7LLz1UhziTrZ6l1cvPFF9gi7N9Ey
	XxiQf9xzOEUYXvcNtm52vLW8gb72Kjf5hmsFHd5c3pjZcUOgWLaycG+hwh0qKaBJdO3vSYKROc5
	zB/BYPA7kSfJdRSwNMwWydoAf+eWfSwWzbBFj85rlL7yuYdA4t0NLzac8nXON7OYe47gsGPoZq4
	xcV7f6GPMrojjDpFH5sP/CMKwdwI9HJRoru5vLJEJfB8fFQdu0h1iJ+MrA3ByCE4n3gZiBug/Lu
	laRfVAzM0mX7tjfkDJBKSS8Bg==
X-Received: by 2002:a05:6214:588f:b0:8e9:f5de:d636 with SMTP id 6a1803df08f44-8f3c9cb3057mr119943406d6.55.1783054858547;
        Thu, 02 Jul 2026 22:00:58 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e27d54asm46420096d6.3.2026.07.02.22.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:00:57 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] idpf: Fix mailbox IRQ name leak on request failure
Date: Fri,  3 Jul 2026 01:00:53 -0400
Message-ID: <20260703050053.120851-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304332-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dbgh9129@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 427796FE84E

idpf_mb_intr_req_irq() allocates the mailbox IRQ name before calling
request_irq(). On success, the name is released later through
kfree(free_irq()), but request_irq() failure returns without freeing it.

Free the allocated name on the request_irq() failure path.

Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index cf966fe6c759..bb81e620c5c8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -139,7 +139,7 @@ static int idpf_mb_intr_req_irq(struct idpf_adapter *adapter)
 	if (err) {
 		dev_err(&adapter->pdev->dev,
 			"IRQ request for mailbox failed, error: %d\n", err);
-
+		kfree(name);
 		return err;
 	}
 
-- 
2.43.0


