Return-Path: <netdev+bounces-240108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 560ABC709C9
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 6AB412B239
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9741736C0CE;
	Wed, 19 Nov 2025 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="b2LkSz3B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10697.protonmail.ch (mail-10697.protonmail.ch [79.135.106.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5BC33E341
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 18:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763576177; cv=none; b=YU4JQLZ3m4U/CyQkAX6U2PTPuE1A/r7i1WzZELioAITZiQdOlCB1clqHGhisBKZTPa+5W7fmTOJiVVA3pbsOR8YGLhGvsOB2zH2gv8fB6jzmS7GNw7lZS+beEmtKRwEJrKOX04lA0j2cwCCVgvsAkoCALZDW06YbfdSaXqF9VAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763576177; c=relaxed/simple;
	bh=PCeJMFFzHYkGfYmGLzet/MuBMWWz18PimT2HoP0j9uQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tO6EFnLkEzCMbOb9qrWLm0R04u99OwWFt+ztLK3Yqdcuyinzfn4m3/gP8GRSM2AFEiQmF6dwrJqLubtgJALf4dU2Cv9T1FKpj0+1VGs8K31314qlvlI5doMlT5xJNzk++4wqSRZDahictF3XVlbsGMHb+8OoBsDZ9+VZ7w7spHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=b2LkSz3B; arc=none smtp.client-ip=79.135.106.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1763576153; x=1763835353;
	bh=nX24P09ZMgIQfFBCK8UIbPGF+gIsNfQYQgBbTLpmDZM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=b2LkSz3BiTlnGAfGaZ5qeyCucrXllzShG1mbLB/zR8ufFXJS1Q/ogiQL+uFOeOx/k
	 PxaQxJmMEXK4cku13SbZpimatj05ugCUeR+JkG9j1T+6CJ6IMDSywPnahxoN4w+Pjt
	 o71wlRNpwoK3F6q7BQvcatIZKjZOCeCbufGWWG1rILrwI7R6F+bW5W1C2sepZXgaU0
	 TA3xi44isUb1xFQoTg1OIh4e4LdJRcHnuoK5TrAyyDwrw1CofS+IXost0kq3u5vioX
	 6lpVwGbHsZOBZ1eqNi4H3EQvnChP7Vcwl0rumUwRQ6PcO6iVOEXlh9DI44eTHjuDxC
	 mEzmuEXh4RyeA==
Date: Wed, 19 Nov 2025 18:15:48 +0000
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: "Remy D. Farley" <one-d-wide@protonmail.com>
Subject: [PATCH v4 1/2] doc/netlink: Add max check to netlink-raw specification
Message-ID: <41b6345fb3b5c493daae63fd2a7447fd8142ffa9.1763574466.git.one-d-wide@protonmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: fe86f2c6bc321486f26510f4879c3bb1644dc0ba
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Suggested-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>
---
 Documentation/netlink/netlink-raw.yaml | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink=
/netlink-raw.yaml
index 0166a7e4a..dd98dda55 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -19,6 +19,12 @@ $defs:
     type: [ string, integer ]
     pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
+  len-or-limit:
+    # literal int, const name, or limit based on fixed-width type
+    # e.g. u8-min, u16-max, etc.
+    type: [ string, integer ]
+    pattern: ^[0-9A-Za-z_-]+$
+    minimum: 0
=20
 # Schema for specs
 title: Protocol
@@ -270,7 +276,10 @@ properties:
                     type: string
                   min:
                     description: Min value for an integer attribute.
-                    type: integer
+                    $ref: '#/$defs/len-or-limit'
+                  max:
+                    description: Max value for an integer attribute.
+                    $ref: '#/$defs/len-or-limit'
                   min-len:
                     description: Min length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
--=20
2.50.1



