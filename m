Return-Path: <netdev+bounces-185824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA5AA9BCFA
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65CD1BA0978
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E56B17A304;
	Fri, 25 Apr 2025 02:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xbbh9vnN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B77A17A2E0
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 02:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745549005; cv=none; b=GUr+3BsDZl5DEegl/sGzU9xQ7BgmYbP6wo7SL8hUFZt86F+OG/wApU0LEitlirw+hMlnYqWV2i8aY6uZ7z6eowjcTHkouPQBV86+ImSLB77lHYjthVRYKBAYCHcEKlFwUaPnq+7MVX8tzNG6xZw/QNoDPopcS3x2oDwo3f8IsSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745549005; c=relaxed/simple;
	bh=Dc9mdYut/vPsSeEazkYTJ4ciMvoLl49UVK/51/tHjXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fv0TfU4hRtXRMzpC0R8tcypRk39CIWlenIuRHpXjkdRRWsGX1kr12zcs2QIwD3r/B5XaAu9rhrMEln2RDNho/bIum06VkyPpe5wgJFkH/JJv/8P4moUVzp+d96EOieOZXQiR02WDBRGKvuFNyyF8TyobNmqzhrI36huW0Gjho9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xbbh9vnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF6CC4CEE3;
	Fri, 25 Apr 2025 02:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745549004;
	bh=Dc9mdYut/vPsSeEazkYTJ4ciMvoLl49UVK/51/tHjXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xbbh9vnN97Auj98+boTAZb9lMUi/UFj9QlAdrnZdgdX/3ebr22VWWo0GtTq7nz4uV
	 LJ6ihybsKUTC2JdWbXNESd0qVKUWz8gjxqx3cQd+to4e+MhBLb8ysd1hnZ5OAxqLwT
	 7Q03boZjysPI4A6/9JBEltNYL+2bG3LEsyIctQ1dK69LglAwZR85hW3wCyGuecAra6
	 9DvdNNN4H66u76knFtONQ6mwnIKjKvGmTzc7LI3MT7iY7tyNl6MP/H04W19LplapBR
	 uVg93V3x+IpqXmq081D5B70IuNDBnEdC3NRmJnlomM3tshe+glax0OfEpX9BJFc6Mt
	 TIiVGz7ofTFrQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 03/12] tools: ynl-gen: fill in missing empty attr lists
Date: Thu, 24 Apr 2025 19:43:02 -0700
Message-ID: <20250425024311.1589323-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425024311.1589323-1-kuba@kernel.org>
References: <20250425024311.1589323-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The C codegen refers to op attribute lists all over the place,
without checking if they are present, even tho attribute list
is technically an optional property. Add them automatically
at init if missing so that we don't have to make specs longer.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - use Jake's suggestion
v1: https://lore.kernel.org/20250424021207.1167791-4-kuba@kernel.org
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 90f7fe6b623b..898c41a7a81f 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -938,6 +938,14 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
 class Operation(SpecOperation):
     def __init__(self, family, yaml, req_value, rsp_value):
+        # Fill in missing operation properties (for fixed hdr-only msgs)
+        for mode in ['do', 'dump', 'event']:
+            for direction in ['request', 'reply']:
+                try:
+                    yaml[mode][direction].setdefault('attributes', [])
+                except KeyError:
+                    pass
+
         super().__init__(family, yaml, req_value, rsp_value)
 
         self.render_name = c_lower(family.ident_name + '_' + self.name)
-- 
2.49.0


