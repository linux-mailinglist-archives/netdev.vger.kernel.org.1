Return-Path: <netdev+bounces-261075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GHNHFFmn2lRagQAu9opvQ
	(envelope-from <netdev+bounces-261075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:14:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EFF19DB96
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C46DC303FAD0
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 21:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3677C30CDB6;
	Wed, 25 Feb 2026 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="rt4qkx8h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D1427A927
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053883; cv=none; b=aFn5qZ/XttOSf4l0l+7vnUj09jEkOY0F5g9dfEmeOmcSQy+NwKCQCD+PQ9L/EE5LTNr5fY8Ojs1PR29Nx6c8EKu227MvbS2qAJm4EVtuFJZphmgSM5gzIOfrtqT6+wPZa97DBFwMYp+WRp4pmdJLAhrNXAzTacROVXjfIEr2oUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053883; c=relaxed/simple;
	bh=5yCS2ENyGebYWm4QR6WtcX3t1/V4wC3uAWzvrnxV/zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PnhHNbgbU8SzIzmyEKQtx3qf26LdaG+CsjOEC+FojyhC6K1E182KZbUHDlGErUqsIhhrQFeEjwT3eZKqBJhCbeBYGObehVu10z1VDZczGyjtpDkdNMfXuc30JtOa3AUYijw5IYnDtLOE40b3/G6X3MXeG9X6uk5JeeoCDOkeS68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=rt4qkx8h; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b4520f6b32so143188eec.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772053881; x=1772658681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BNmTXCq2fTVbuDc5LvGj3dl9DEC7Kg0+x8gfaozwtk8=;
        b=rt4qkx8hRtX109bztZ9Ssuc4lE/dVSGg9I97Nh+l/XPVA/e7Rs8rDpGlaFU33ctTNo
         1Rr0ExiCsN5AwrGaUlRklqVXGTFCV5XTUlBWsZJxW/KORCKj6no1Dk3yLuwxj10Pi9i/
         dxbpNhTX7AVFQOkDA4DwZJY1bk3yIAjwYMlA0G4r+budYLgwfCPV/w7+9HwcZwRxmwGe
         k2eoCxFcOybpPkjDWvY0hbOpJrE6zCH5YXhYGrLSWT/u79fx+MT7rnL9XMERrO8Uvu5d
         aJdsnN9xM/vSbg4+TJADpi1gZYAOH8aQrJJM/m8h6XNMaNR/gF7l879uvJ8XwFuQZMMC
         kGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772053881; x=1772658681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNmTXCq2fTVbuDc5LvGj3dl9DEC7Kg0+x8gfaozwtk8=;
        b=fsNvZ9FU4lsbDEoskpi4DC6mTsH4zDbpIp+mKj0ieeOb8ojHgaW/UaL7hZgrBcsbYC
         A98lRx59YCSPOk7u+sodOPq2C39AaXDmQibFOwsYa7HvZlv+w+OJuSURgiR5iFL9k1vA
         xHrc/sACFc5yqHNNqcHSX8t5D4BqhN/l982GMtJcSI0/UqaHdoH+NRZD2wWTfxvyBN3F
         uGQfQJGA8SvPdYKMcuyBNu/yo4SsI9/elZHu3mT7YE1X1yVndBeuU8ZeZBmI/nyaleI6
         0/hno2gDSCCtQ4XtgvRGL77nj5fMxNZJLw+Z+Ai9jAoedOpoh2HeWIX9bELkihpWxtiz
         7n4g==
X-Gm-Message-State: AOJu0Yyw8SU3PFa6L1h65FrdCF2X8vd1TmaVZpQcfinrRYJEYRyZAlId
	OhTGQYvojL4ILiX98IacOTe0ytJ/rHZcCJTneB3zEu4tiyOK9L3cbsBqNJWdUyjCcng9BIYpWWZ
	9zsrbFfg=
X-Gm-Gg: ATEYQzywipU6AIshj9RUfbhHh/tL1vXgblu/EVedkZL4uiTDRmEC5CVeZZdHeIAiluL
	pS1Gi+F3s/FTI8pBAc9u246jzLSaRxNGdFnb2L7pgP7yO4HxZrCK5yE17CXHYg035n/lOI7cF1M
	eFuBzHzDu+BQ6TUmIb8UFuLQ2LBL6+CIq4X2Knazl2C6YnNNFe1tyV7jbotE48kJ7X48tG1UnK2
	P5sZ/fzmbFPun6kbNgZ3wO3o3/oBjfjapXlXnpzn6CSVJixnyqzrqxdLOYTCbV+azzPiqCTdto5
	aAA5bmgkWezcRowoEaW3i5p3W3CO4P7Lf/ebgTLb6OzHOYM6c2UFkfw+caMMhWCG+4CVG7Vaipm
	lHLDQ87rdtOG/xB3tzugyBuINxqBQliJsT2b7mHjvs6C2LQKnhi/mqkJj4ED+sP46Nl48au3u2S
	oxa25t1H2UKd9cA29yNs88Mg3CJtWYV9l/LElyYCDlA/ADJupZrD0cYdNA49aObg==
X-Received: by 2002:a05:693c:3002:b0:2ba:7b63:3f4f with SMTP id 5a478bee46e88-2bd7b9f1ddemr6683017eec.15.1772053880596;
        Wed, 25 Feb 2026 13:11:20 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1bce276sm171898eec.3.2026.02.25.13.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 13:11:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] ss: suppress netlink errors for unsupported protocols
Date: Wed, 25 Feb 2026 13:10:25 -0800
Message-ID: <20260225211118.314008-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261075-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2EFF19DB96
X-Rspamd-Action: no action

Error messages from sock_diag were only suppressed for extended
protocols (> 255).  Protocols like SCTP and DCCP also get EINVAL
when their kernel modules are not loaded.  Remove the conditional
so all protocols suppress the error.

This fixes the problem where:
  $ ss >/dev/null
RTNETLINK answers: Invalid argument

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index b3566f6b..7520003a 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -4120,13 +4120,13 @@ static int inet_show_netlink(struct filter *f, FILE *dump_fp, int protocol)
 	if (preferred_family == PF_INET6)
 		family = PF_INET6;
 
-	/* extended protocol will use INET_DIAG_REQ_PROTOCOL,
-	 * not supported by older kernels. On such kernel
-	 * rtnl_dump will bail with rtnl_dump_error().
-	 * Suppress the error to avoid confusing the user
+	/* Suppress netlink errors. Older kernels do not support extended
+	 * protocol requests using INET_DIAG_REQ_PROTOCOL, and some protocols
+	 * may not be available in the running kernel (e.g. SCTP, DCCP).
+	 * In both cases the kernel returns EINVAL which would cause
+	 * rtnl_dump_error() to print a confusing "RTNETLINK answers" error.
 	 */
-	if (protocol > 255)
-		rth.flags |= RTNL_HANDLE_F_SUPPRESS_NLERR;
+	rth.flags |= RTNL_HANDLE_F_SUPPRESS_NLERR;
 
 again:
 	if ((err = sockdiag_send(family, rth.fd, protocol, f)))
-- 
2.51.0


