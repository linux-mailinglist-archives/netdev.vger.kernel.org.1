Return-Path: <netdev+bounces-253103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCTKNackdWnZBAEAu9opvQ
	(envelope-from <netdev+bounces-253103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 20:59:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 493867ECA6
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 20:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BBA33029274
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 19:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EC0241114;
	Sat, 24 Jan 2026 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="1yJxobAY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC8D259C92
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769284718; cv=none; b=Z+aycjTEHZGoVmmPDKsiOb0JbgCSpzNZZ+70Bbj7aKRlyp2caC0CUjzCAb5srIJAXmJP476fFLuRq7CNi1R06/QCo7fqM94Mj+o6NVjuZLv2ijvkBZyXrXgx5kmkZKJkfnpN26cI4k2IW8vyAnIvhFG3KmDl3E49Xai++yw0T0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769284718; c=relaxed/simple;
	bh=UEUyixXsksaes461qeojX8CH8Hm/xLERO1wV8L3TOzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaaxtwCgHlndms7Z9T6/VuFwp7CB+/lC9m5naIVcQ9rbebOvw0fz5uGKJ89wEC+L93lNf0UffvNK59OkT5QE6i6upVdEaT2nNb0LqrkP06O358a3Pq8+iWfry9cklNTM2qpgoTFJFFNUiBzGREMnT9CnUDGbcFo2BPxvOw5ISZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=1yJxobAY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4801d98cf39so24208645e9.1
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 11:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769284715; x=1769889515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVk3/h+ZYVTXc92sAdNZ2O1XJ1rq2CAFCQHcjy7oFJc=;
        b=1yJxobAYmhGzmpNJBR51ZK3YgIDsj9NIy8xWsi8+23fS9PyZEEl5ZYJ2yD4VT7gec2
         a4A1qBXTaCUAofB17jMz7/uQIK5UivQL/kdHtNIXW8/JxqXJZemHuBtCl6pODYpVOXRY
         DTJiLvh+vP/LafzgcRo4Oh1kNn3lorz/7xLerf85AeLhiIxuxaeh68byrm+LnNTrydGf
         5ZZrngdR/mmywesLJnl2hNdVCx5yY1dNRxiTm1jID701qIXU6tLG8I0xRp6kid6DjJu+
         8SDE9kiDys9omBya20wqCz6JZCgKiFjg/mhlobLKPLllDYNsoMmsDPtqkMzvgciqJ8G7
         NjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769284715; x=1769889515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eVk3/h+ZYVTXc92sAdNZ2O1XJ1rq2CAFCQHcjy7oFJc=;
        b=LPe8X/vVz9M/YRNU/yOt6TzJULHLI+pLUkbP/I05nSKdvtvVcZntZxPY4jQ5vK87Bx
         fRTUKBziT5lazEUpArPSREwmUt/UnbkSreNWp1HZZ6dywDZlSHhsfaQ4eq1Xa5PAjbG5
         JyF+UuABSmPIoVQDenwMOBidNv3o+6J+Bxg2ZDBzt0M6yYO6xsG11MCebOuT6+HQglqn
         uhLS8nhdM/jVNRWb5hxL+doLyJ1RA5a0kwx7F66cCsYLzV2DFZDWgJ9IaffXC7GvfDnu
         gmXszqDq8ywEXOBsbfOilRV6jyLkIIoFMJmu45PuVq/hiV0SM+1qjXaxprD3KMAGSex0
         zBMA==
X-Gm-Message-State: AOJu0Yy+WoTLGPUTnHJMicNi4Jzfa9yQtQRAQQRJvLRi86kVkHA+h1g8
	YvyFbS1WJVKHdwYICbqQ80pRY8H37uk0tXLR9NlVkOzEdtqWl+rsUxJqZvG9BEqxjsoEX+lWRaF
	ZYezI
X-Gm-Gg: AZuq6aJvPpjFlUEdJXurC01Qqus747R9ELOibIlY5jERtjjyZPo3y1f3dvMCVPQzvLa
	+u6b2NI2tC4EO0d6I9Xp5pzC95yddJQkFUNKh1UIaK03F3DP19LaqXAd04JqwXk3HwPkPQ0mQyF
	vagPrcXnodwA1XghgEqsPAsxMFt5ZlqQGUcVIb7aqbmmfg+hyhYLG78n+FxGklXZXuEBWc70yxl
	cJcbJgil3QrzkIfnrviCBv6W4/VMrHxY+ts1UTeVQGyBfkeH8Pcy5XDwFBeVa8S2N2BqYrapCzm
	ivr7tEtwlIZp0q8yVK9KS6lGzWoJhGeNXZmF4xK6I7ZZspvOsQgtASZYV+zBeU5rYzGv1gIsPoP
	n56r94MQfXOiKZtimm8Pnaf/jSq3YyRXKACL0hXj5M9z0+zc+ok6Le44wBv6RF4G6GIf4Z7qEEQ
	ft5joZOXu4CTmdlwBfgg5aLxH/55TIWTsIHIRbbrAJ2Qw4bx26dU3AKlhDZV+U
X-Received: by 2002:a05:600c:1490:b0:475:dd9a:f791 with SMTP id 5b1f17b1804b1-4804db89fd2mr72501135e9.28.1769284715005;
        Sat, 24 Jan 2026 11:58:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d85cff5sm144573525e9.7.2026.01.24.11.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 11:58:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 4/7] netshaper: fix grammar and style issues in man page
Date: Sat, 24 Jan 2026 11:49:28 -0800
Message-ID: <20260124195824.221305-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260124195824.221305-1-stephen@networkplumber.org>
References: <20260124195824.221305-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253103-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:mid,networkplumber.org:email,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 493867ECA6
X-Rspamd-Action: no action

This patch addresses grammatical errors and style inconsistencies in
the netshaper man page documentation.

Changes:
  - Improve clarity of set command description by restructuring
    awkward parenthetical about id parameter
  - Fix punctuation consistency in scope list formatting
  - Capitalize "ID" in example heading for proper title case
  - Add missing article "the" in color option description (3 instances)
  - Make example descriptions consistent by using present tense
    third person ("Displays", "Removes") to match Example 1

No functional changes. All technical content remains accurate.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/netshaper.8 | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/man/man8/netshaper.8 b/man/man8/netshaper.8
index b9fdc0d3..f5fe36cc 100644
--- a/man/man8/netshaper.8
+++ b/man/man8/netshaper.8
@@ -77,9 +77,9 @@ parameter is required.
 .B netshaper set
 - Create or update a shaper configuration
 
-Creates or updates a shaper with the specified parameters. All parameters except
+Creates or updates a shaper with the specified parameters. The
 .I id
-(for netdev scope) are required.
+parameter is optional for netdev scope but required for all other scopes.
 
 .SS
 .B netshaper show
@@ -109,7 +109,8 @@ Defines the shaper handle consisting of:
 .BI scope " HANDLE_SCOPE"
 The shaper scope, which can be:
 .BR netdev " (device-level shaper), "
-.BR queue " (queue-level shaper), or "
+.BR queue " (queue-level shaper), "
+or
 .BR node " (scheduling node shaper)."
 
 .TP
@@ -139,11 +140,11 @@ utility and exit.
 
 .TP
 .BR \-c [ color "] = {" always " | " auto " | " never }
-Configure color output. If parameter is omitted or
+Configure color output. If the parameter is omitted or
 .BR always ,
-color output is enabled regardless of stdout state. If parameter is
+color output is enabled regardless of stdout state. If the parameter is
 .BR auto ,
-stdout is checked to be a terminal before enabling color output. If parameter is
+stdout is checked to be a terminal before enabling color output. If the parameter is
 .BR never ,
 color output is disabled. If specified multiple times, the last one takes
 precedence.
@@ -155,7 +156,7 @@ Display usage information and exit.
 .SH EXAMPLES
 
 .TP
-.B Example 1: Create a device-level shaper (id optional)
+.B Example 1: Create a device-level shaper (ID optional)
 .nf
 # netshaper set dev foo handle scope netdev bw-max 10gbit
 .fi
@@ -170,7 +171,7 @@ bandwidth to 10 gigabits per second.
 # netshaper show dev foo handle scope netdev
 .fi
 .RS
-Display the current shaper configuration for the specified device and handle.
+Displays the current shaper configuration for the specified device and handle.
 .RE
 
 .TP
@@ -179,7 +180,7 @@ Display the current shaper configuration for the specified device and handle.
 # netshaper delete dev eth0 handle scope netdev
 .fi
 .RS
-Remove the specified shaper configuration.
+Removes the specified shaper configuration.
 .RE
 
 .SH NOTES
-- 
2.51.0


