Return-Path: <netdev+bounces-162288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DF9A2662B
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD05918861C6
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9508320F095;
	Mon,  3 Feb 2025 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlzCpimV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F59920F07D
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619712; cv=none; b=Lhn38XKluJdMt4i3BRoRhmlt8qX8yNePbqVyGbSUe/dp1LhRM9dKca4sfTOyO1Rkh4TGxL/dtE8XLSQ2Yyw4nS0KcUEk3cMz1y5tI7/Fe95Aqz5zbTTl9+rx9rUlDaOCpS+SEUrH/hWhYQQ02g0J2R3Flr2PqHAh+KQz4nfMpQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619712; c=relaxed/simple;
	bh=eoEmbzw+Y7QIYFZtTuixh0YPWmiDqiFw59p/ZqSoWV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VK/q54IasqWYKZmGJ8a6IZoOWHWN20XCnx8mh2rXDbzNy8yvrKP2JYZkiVNPtYjb7H91ZsDtIzPgELJmFhKd920OOycl4OtlD3UjyUef9k6Y8Mx3gzTlfdGt8jyupCpzlVTrixQod9nayTWy0EpnG45ZDFEa0BXmbqVaI6bAKZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlzCpimV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE253C4CED2;
	Mon,  3 Feb 2025 21:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738619712;
	bh=eoEmbzw+Y7QIYFZtTuixh0YPWmiDqiFw59p/ZqSoWV4=;
	h=From:To:Cc:Subject:Date:From;
	b=QlzCpimVvQ3zLu73+HaBb5WrBANzhmtmXTv3gK7DXL+MCGb9Yjg3BnpSrATNNxK2t
	 S/joxkSUUQFv14Rj7k0WHDSpgjaofbRW2ZQ49R+9WKbY8RLOYb4clsnaLUN+LP35fl
	 /CFkB9M2AQBAurKe5BEFqjEWnLJoRxMxKqs8ueXHgABnw62tSLu85B9V0hh31qjKzD
	 1SeKk+XKsAS7s83B4lJOMcQ5GCRPwuHPkuVevDNsRUHfOUsiyQgh53PG93PkRExu4C
	 ish/UHXZHV/5q4fStpKRjDDpnGUmlQP5OdqlSN2NgJTX4eU6TE4ZmUPICKxoWTTcS1
	 J7PsL50akfa6w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	cjubran@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next 1/2] tools: ynl-gen: don't output external constants
Date: Mon,  3 Feb 2025 13:55:09 -0800
Message-ID: <20250203215510.1288728-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A definition with a "header" property is an "external" definition
for C code, as in it is defined already in another C header file.
Other languages will need the exact value but C codegen should
not recreate it. So don't output those definitions in the uAPI
header.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: nicolas.dichtel@6wind.com
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index c2eabc90dce8..aa08b8b1463d 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -2549,6 +2549,9 @@ _C_KW = {
 
     defines = []
     for const in family['definitions']:
+        if const.get('header'):
+            continue
+
         if const['type'] != 'const':
             cw.writes_defines(defines)
             defines = []
-- 
2.48.1


