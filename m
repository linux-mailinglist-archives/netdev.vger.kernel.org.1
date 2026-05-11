Return-Path: <netdev+bounces-286829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPK1Lk5HAmqPpwEAu9opvQ
	(envelope-from <netdev+bounces-286829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:17:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2FC516335
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3093A305ECF6
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F324D2EF4;
	Mon, 11 May 2026 21:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKt73Ppn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4CA4D8D8E
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533974; cv=none; b=tufmtUEl7Q6jbEIIsLX6lXHZ3MLDH7yqqnZnfwqdcwgstKwZPYa6rm/4nlIs9HUYV5e8ak5gqv6p0qjJQp5R/th25o6ZY/7xrChQ0EG88BCSFbfTKg3zZamMWNVj1JYrGfzwZo+Ns282C1lPJxr+JSjm/0Hsari+13CrpK25/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533974; c=relaxed/simple;
	bh=Ml8+WIXJmSGrbqib0u5ulf7PiZ8NZS12P3rO01gEh/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dtn5wVNsg43b772nZeQt4go05REJMGf836t1qmJfXj/I+AGhVIILBFsAXJ6R4+nS++s5aCNDbm1mBG3e3eTAw2amXgAIQ+OHz5e+trHufubDztCThyYxLFZjtH7VHwGb3oScXpydvjv1I2KFq8giABf2KWkHz1/f1BIbkjk2CE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKt73Ppn; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7bf02533706so43607837b3.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 14:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778533972; x=1779138772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwF/HhmYwf5QBeLN9SEfEOEh9juP5SjaaFwH3isu8iY=;
        b=BKt73PpncZ0dVhQJNqKIj8j95R39VSikmdRMcpVd6wIimAgVysHkXCYnGsFIFeKks+
         CyHBeuY4U8UI8Nw2EHXSMd2GnVD760ZO1n1Xo6y4gy4t7rsAn+OT4pjknLKBxfHFAPq4
         NcaF8xAJJmR7YOY6sdvZ86Km2hsm6Fb/7OgY9WOcwaWrdL/3GoCCm4GbeqQtzhjFBC6X
         fPFJwGitV/AH1XC1BszVgQArX/ueT/bX0LPa5FnPfIjQJOaLCAZdtf9JXAkXLE5ky7WD
         5iDlnKTkcmkqh1M7rd7RgwbE37wSNR+nCOJ6tLfnCM0LfCQx3DA7P71vqOo3tI/FsVdo
         7fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778533972; x=1779138772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rwF/HhmYwf5QBeLN9SEfEOEh9juP5SjaaFwH3isu8iY=;
        b=tHztMorT8IYTejDlSvpZ3bdkfOfQjXcw6JFouZ5EO6lJJfI7nFLrp2bVwH/+34t9zP
         efGVWlme8E/W9eL4K0iX9bIwg7MsG+MgL95X+sTdGE1AyLWjQ8Xd7PC6Go+2VjmwKAnh
         R9fmofqxeL7uVvgg/8mXR0HPO5pZ4FNXYw56tCrgi80DwfdMR7utwm4xHeEkXw4E4y4K
         S7XAgrl4JdbcikP8Wr2PCFWA4PfKAa5LzpMv6X3q5pxlOqjPvwAOaM4SCz7eA3XDlWwk
         JgxIVvDApLUl0iEqkNb9fYQB3ba5lxfHNwAoV/bvHiyhkBRSwQ4Ljfh2KwX0cjpjGe0F
         rAZA==
X-Forwarded-Encrypted: i=1; AFNElJ/+w9ZjfZQBwh6nX8z3MceUpBjrPaMvXu/FRy34iJeMT9orbfk7VAXi7ZZDy8C+COIqhufS4q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Tj2fPUcLPUuy/eHrwX2I8giz5rFIIsYV5YMgCE2rV4+5C0uk
	sDov8vUrAi1TRDO1cuXdlB77TMrypzQCs2ePKcHzIyF1bikUnAjiKi8=
X-Gm-Gg: Acq92OEanlmtY8hDoh+g99jgMAaC8HXpQw4ptBVxJz75tel58FXtmecHfCDrZb2yjCE
	2V0tuZ7JZbndKxnBBus/n6csFpTrYa/LDzLZdWoS4hiFmDMkXMk4GnnZ7vQQ3yORlmbjR0sA7GT
	XRlvmQOBvdYC5bOlFNHP/u7fzlT7WTIJczJWSiaSzHGHDW+2icibAsp+FI8vp35oFXq+MTROR9r
	r/4ygx/7MilN8L4BjtJoPWE1uLljOFNSPVEY2zP6MM737moF4nCjqj7WoZ99Eo2xL+xO3l9DiPG
	BP9RTjA1jMXp7AyiahqGFEu+3bJoUKZatLyp5NwGOQ2NaY2wmhsdu5fQjrMbT5EaTIR2KZbN8Il
	0w+J6N9F1zz9NFFmm1exI+hgBg0WJcCww49ixVXDFekjXEHe5KiarYQBcD/5xFol+wRqt2QjkMQ
	OzQ73F83cJ6+tar2AIlv3AUBMzGo0uTpVTwGVbJM/ntLU87Q==
X-Received: by 2002:a05:690c:ed5:b0:7b8:5f91:65b8 with SMTP id 00721157ae682-7bdf5d99133mr270835987b3.9.1778533972346;
        Mon, 11 May 2026 14:12:52 -0700 (PDT)
Received: from alir-mac.sitimecorp.com ([12.1.37.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd976fd09asm114553617b3.41.2026.05.11.14.12.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 May 2026 14:12:51 -0700 (PDT)
From: Ali Rouhi <rouhi.ali@gmail.com>
X-Google-Original-From: Ali Rouhi <arouhi@sitime.com>
To: jiri@resnulli.us
Cc: vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	cjubran@nvidia.com,
	Oleg.Zadorozhnyi@devoxsoftware.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ali Rouhi <arouhi@sitime.com>
Subject: [PATCH net-next 1/3] dt-bindings: vendor-prefixes: add SiTime Corporation
Date: Mon, 11 May 2026 14:11:41 -0700
Message-Id: <20260511211143.19792-2-arouhi@sitime.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260511211143.19792-1-arouhi@sitime.com>
References: <20260511211143.19792-1-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1C2FC516335
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-286829-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rouhiali@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sitime.com:email,sitime.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add vendor prefix for SiTime Corporation, manufacturer of
programmable clock generators and MEMS oscillators.

Signed-off-by: Ali Rouhi <arouhi@sitime.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 28784d66ae7b..5e81b9bfa3d0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1527,6 +1527,8 @@ patternProperties:
     description: SiRF Technology, Inc.
   "^sis,.*":
     description: Silicon Integrated Systems Corp.
+  "^sitime,.*":
+    description: SiTime Corporation
   "^sitronix,.*":
     description: Sitronix Technology Corporation
   "^skov,.*":
-- 
2.43.0


