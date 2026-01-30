Return-Path: <netdev+bounces-255127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBPPAFqdfGn2NwIAu9opvQ
	(envelope-from <netdev+bounces-255127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:00:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD52EBA4C1
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F2E0300FB78
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D30136E475;
	Fri, 30 Jan 2026 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsgYbH5C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0104C36C0BB
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769774398; cv=none; b=onGlfu2Qv1Jpgqgg4ytCgLI8qIuGjkZmMKCYgRgZphocBSaqkAu853bafOODF5TFt9DhUA4zSlql/2OWr+I1M3ikLD77iy2W59HmpyUSuLdwPLzrhATlzQHcE/JTD4mrr652glyZQ6tw5eDBa2v7UlbH04nJoOJdq52VsC2v+KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769774398; c=relaxed/simple;
	bh=S7/1JmqRyqlonm8+ljS+PK0L7DKml37Zy1l0I9r/eEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zl2sZrzzA3kNu6dAJ42uGFIWTntp3pl5TWWGBI4+5fRwA6gFWkqKKb9RxGx3vptMKGYXJ5RbI5n0PHLQlfQ8MBZnP96hRt5LTT6ZnGCoWLafZVKzG2j0lznCIM/oW7uitxWVhnSSsr5OQKQFD/Jo+V71U5dF+9Xn4ZdLQmG4fQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsgYbH5C; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b6b0500e06so3074768eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 03:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769774395; x=1770379195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q7ihQ9DOdwkh13XOnXi+IMjMF9wwJSt0xTF2SLR36Pc=;
        b=IsgYbH5CQYLBGVZ1Z09Qku9cnYuSPmUVS2bjb/r3vEMt+Z5nCe4TDRvw9sGmgrhmai
         Ai6DNJ7sGbIHp0GmAajq13hHNmxRVpowvD6yh6genQvt0r7P5A446kzpFS4MglG522Gn
         1Dz9nGxKSK34DGFhZFNlw0BfGERKwWjDQchsnl4C/MUz3aQs277rCftNPBi0G38DBSHz
         wGCGWtG+qLo4XJmlhm7HoyvaTI2ZMpngALxiW02w1IaZauxwxj8MZAHQu2WkmshDtWU+
         63PadI1WOEV87lj2QJsmDd/ewas5W7Kod7VbDmd8wH78Dwzj2OEAzNCJikAUqLTe4vyv
         ErAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769774395; x=1770379195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7ihQ9DOdwkh13XOnXi+IMjMF9wwJSt0xTF2SLR36Pc=;
        b=pGOmAm0SLyLwMABEswZINsW9zH9Y/aJxzTsvGiXGks5M1qVJ2XJT6joivb3CzT+vtv
         Qqvtl9x3xm38m9ENdlJN17vxQytAJwmS2cBvqmsydX+dmfgUIXaYJSCqQ/MMz8B6buf+
         kSrByFT/KqfkeWl9kJzqAJHYsGH20592AZglKLyhF65exL4pbwX3rdn8O1oAukzmDPP0
         3nQ74WKsI/xfrQxmvTRWxRFxdPBPsrqkU1KMVE3Lr6pG48KP/caBLfomkmoAU5pMn384
         LdXdGZlzzLWx0i9Cv6wNvAkaZS+C5u2/13/jqRW9/woiVX/CSH9PySn9ywkm+0g6gVRZ
         rW1Q==
X-Gm-Message-State: AOJu0Yxs4CFlfB62FkV2cBNa8om4w470bGH02Y6st6/062q2hZZWcn4l
	wS9KnlRTwyPe79J0p68Q7dLkGOee71yYQZJvmb48uvAjpRXXqR8yfnbnkDJzq4L0
X-Gm-Gg: AZuq6aKAo0CYk1jcYRd4BNidfgFlJXaJr6Fw2emJJGO/NK5/bIuydijUwV2JFlAgs6i
	OBUZdFLR1YrZFSUaSFLYvHg6qBrGc0A5+hElsDIHLtBQX0v1Dl13qpVGmvsBYewpocb6nbnciP4
	RWHrHCKHcyAylojSU6/RjBR+RspCqTax22tapaiPj8OcpwRKYFkc6zyvQfauYsAegOhsanmm5Z6
	FP8xqmtFfT5YA0k91q9irbiP/xkyBxD2Ph01TkEkdby+MAtPBSMH1YdSA/sCU11NWUbPlTlLDYe
	ZSooFKO4FtWEFlQaTtTenf5xOZrFyuIoFruycl5ydGsOrThJ/liWwmW9SgMEDT9gTmcGPIPXDq4
	OodYpgEqOKJLiwhAoYiKYcXfKjX9KIEO0COm38hUOBmTkk54UgFu0N+dZ/W4TZe0i+CwkDgKXed
	G492YfYuRgB6X6rV8NdUynCBv04a93Q/opaV8+DoKa117Tfy22N0JhEno9Mpj08kAMPvc/AZMlL
	BM5KQN7ZYzkFbVN/5gHFvssYX3yHHD2bcZuYoMnJh3yvb+IWDoDNCmJA/O3J6SrWa0R+YSj+Wrt
	v8gU
X-Received: by 2002:a05:7300:7306:b0:2b0:514a:a8cf with SMTP id 5a478bee46e88-2b7c8663e2dmr1358850eec.17.1769774395075;
        Fri, 30 Jan 2026 03:59:55 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a14bb02csm10505069eec.0.2026.01.30.03.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 03:59:54 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH net-next] net: usb: sr9700: remove unused CRC32 dependency
Date: Fri, 30 Jan 2026 03:59:37 -0800
Message-ID: <20260130115945.49875-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de,armlinux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255127-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD52EBA4C1
X-Rspamd-Action: no action

The previous patch to remove code for the nonexistent multicast filter
removed all code that relies on CRC32, but overlooked the Kconfig
dependency. Remove it.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index d050adfe860a..52a5c0922c79 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -319,7 +319,6 @@ config USB_NET_DM9601
 config USB_NET_SR9700
 	tristate "CoreChip-sz SR9700 based USB 1.1 10/100 ethernet devices"
 	depends on USB_USBNET
-	select CRC32
 	help
 	  This option adds support for CoreChip-sz SR9700 based USB 1.1
 	  10/100 Ethernet adapters.
-- 
2.43.0


