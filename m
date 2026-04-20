Return-Path: <netdev+bounces-279725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKKOBloS5mmnrAEAu9opvQ
	(envelope-from <netdev+bounces-279725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:47:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9E242A0A5
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 13:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49D23304F30F
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 11:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE94B39E162;
	Mon, 20 Apr 2026 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8pZ1/um"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA45139E190
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685568; cv=none; b=iKh0IRS3Tfy3kR+uXkNhWceOXTbcI81weNig5k9Rpr1cd44bBOdfWHXR80Gs4+V5n6QnzKSyTEClbR1PRVLBqaZkriwwhdy2nnfgZKy/nbSQqJ9rqvjpE+e/I6WU88EHh9m9bQB6QfVUwtc8J+x3C7FycBykZUHVcihiTi2ie1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685568; c=relaxed/simple;
	bh=e0AJAUNOmNDd6/YhHvW3gryjlpU5u5Opr7QfNUASCWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQvV5J01Xq++YkYzdzcHREm0xJy7sMOHVx839CJbdn77ZR1n8OVaX9bvA1CI9lpjBTWvliaeEs1w7vGyHPiTb8+H17/Gx6puukkZqNPWGhCQBJuiAKIGIS1tCs9fo7SZGKItCs1aNgR9hGElhBBjA7MqbluwaVj2hnZrJQs5+aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8pZ1/um; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso1869309b3a.2
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 04:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776685563; x=1777290363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9QQ2J1q7j/KIwNXKtt8cG0N80aWhIRJXk717uRg6Vhg=;
        b=P8pZ1/umD/WldT+HMUn15g6iMXiLOUNWhP+2FA7mDoS207yeBRUqGairgx1Ot8ylqu
         /+k/3MnxT3kVjwX2cftuTkuwJcM5onuk3/7g04AykAFQggBhg27ftp8ytTZz7UKoczaU
         8OoGAehv0oRgu7sOetgfCgVobUcqrohSdOYH4S5HcAgUOXAEkKqa21WFJSL+BZtVSpNb
         OBRK28mX8dFyqsfigbWxnGynwnaJ9fR+yWnaTNTjcctpf64Flis+Ma0RPPJ5yqR7xpU9
         TFuu07SUnontNZeJ9VoNWBHrfAjVvrIkhqhyWmmZl+0rqrbekkR01/Y75aOIWm4Guy8X
         Ihiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776685563; x=1777290363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QQ2J1q7j/KIwNXKtt8cG0N80aWhIRJXk717uRg6Vhg=;
        b=YjO0AeQU5bPG8Xwd86Ppein//N529i7g/1ZZqBaVrwqc2CGLIPq+BP1qvW1/Iwcnru
         Wec6dczxZjGkE/U2Si2vi5G7XnJvRy351AZhTJr7WhQnK29udiTuWyHfBWdiKaQ23z83
         xNrOAlNdOmRIFKbUbcaRJwfo7550w04sVgra4gIV9VqXIvFwmLd3NIa85c1dyXHIaGVS
         jHdOGeafRLFldeIPSc5424RK8gaCrX4Tue4KwHN+iT5QdCBQnUVj1zU9ZBy3DntdZMgm
         svaLEK1B7bj5Ryhs2WgSPpFDhyxAiQb1ARBpxJDTStQG8BmfqtKCgMVC9NJ97VBo3obp
         07/w==
X-Gm-Message-State: AOJu0Ywz7jgf6vrECZdKOJdLk5dEOJ705tTJsdPeNKguzjfhwq0eHlC4
	igOGobPacVXIop/R78RGFrfKvUn8xCLoTkbSnpbH9asIvPEpDh9QXaAhP1zYO7jF
X-Gm-Gg: AeBDies9l2wwYthhky7KKMRZz5BBeS0c4rHW6J9X5Pc8nOGMQIb0yjTYFlAmRswSmS6
	EldjZSzxarvvk0pjXM/qVsZGk/VB/uRQWUqM2Co0YXVDEDxU7qDYDDLc2Z1DZ5GmyapXl/uHkX8
	5O64rjZmjaL1M2eMZM1KoDpCEPljyC7m6h6zrjLQqTEmekvJmLanG/O4kZpsxdf1dvyt4glH17u
	MUnVagdmXKO7qJ/DilsS9MGMkqbJBOcVpavb+GU/ewvUEUyDRlkdRGQRna0/x9351wCYwzDSCbw
	YCQ4KnN6/VfdZfGTw0NE0TY0xMj4eC6mrCNu9tu3wHlOpNFB6DwNeHEZ9XjvliUK2W2tWek4FJP
	JcIjuqVPtnwLSxR3q+TlmDhd7lTRNXf5oYBjn4X1PoBeQBXylCI0TYWzqa9F8gZ5YB9lGhA38yM
	bnB9/M09DDi7ZGmXur9nWHhwSYm0x1awMB6srCHCH8Q6ArXg==
X-Received: by 2002:a05:6a00:4b54:b0:82f:6e39:d90f with SMTP id d2e1a72fcca58-82f8c93d102mr13145150b3a.39.1776685562678;
        Mon, 20 Apr 2026 04:46:02 -0700 (PDT)
Received: from localhost ([220.247.131.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe68ebsm11598567b3a.47.2026.04.20.04.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 04:46:02 -0700 (PDT)
From: Ariful Islam Shoikot <islamarifulshoikat@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ariful Islam Shoikot <islamarifulshoikat@gmail.com>
Subject: [PATCH] docs: maintainer-netdev: fix typo in "targeting"
Date: Mon, 20 Apr 2026 17:45:53 +0600
Message-ID: <20260420114554.1026-1-islamarifulshoikat@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279725-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[islamarifulshoikat@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F9E242A0A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix spelling mistake "targgeting" -> "targeting" in
maintainer-netdev.rst

No functional change.

Signed-off-by: Ariful Islam Shoikot <islamarifulshoikat@gmail.com>
---
 Documentation/process/maintainer-netdev.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index bda93b459a05..ec7b9aa2877f 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -528,7 +528,7 @@ The exact rules a driver must follow to acquire the ``Supported`` status:
    status will be withdrawn.
 
 5. Test failures due to bugs either in the driver or the test itself,
-   or lack of support for the feature the test is targgeting are
+   or lack of support for the feature the test is targeting are
    *not* a basis for losing the ``Supported`` status.
 
 netdev CI will maintain an official page of supported devices, listing their
-- 
2.43.0


