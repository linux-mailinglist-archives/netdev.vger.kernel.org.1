Return-Path: <netdev+bounces-207310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D381EB06A44
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF0F563D92
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E08E2AD14;
	Wed, 16 Jul 2025 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd4lEZoO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0D929CE1
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624256; cv=none; b=lJd8z2q68dhLLG3qWX2pQ47j6HmFIbP7EiWqGPoIJ+wyaSTzr+myEztLnrh7hlwkRgxk1uSpG9dbYutGQ9YZP+7Rp6aDi75ZZSWhG9SwWV6eUf14p2BYTJ4FAsjSpgVcv11yOHDK1cP1YuolmolD8i3Am3o1+UArS0ICYtjVDcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624256; c=relaxed/simple;
	bh=DETITJm/NYF3hcFTJsoyG7Gf6nbMVY0X9JzyWHSF6tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4SBe/EI/zDiJtbxFIMMXTe33EsmGjlesuzpjCpB2Ph1RqTqhCE+1WIWlIYge87EE07T2Iy3ZixvQ1WsC4EFKr2+akZDjhn9F6eD46Jf2KJ9pPSu0C1uj2UEcYMfkY6DnyRjAlX2u+a3lpzv63MKMv1uW0jP1GINgxkH+zY1/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd4lEZoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42F1C4CEF9;
	Wed, 16 Jul 2025 00:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752624256;
	bh=DETITJm/NYF3hcFTJsoyG7Gf6nbMVY0X9JzyWHSF6tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qd4lEZoO33hwg0pGs33pXGaszvCZHGeMny2K1qyMR6K7p8ruYSCFDNODxagEhgLbB
	 E4zgejoZ+tB0YlB8TOolDx+Nh4r82d3tuTR4Z/WROkuKRczkK8zAVq4/Udf0pHTfrG
	 tmrKN0guU7GSpSuPf81J5pUMxpzZIuArAIWbTYA7BMC1hr7XHKtsRpFIqHsgE2dasu
	 WSPrVBNaCrLirAQCEkKt+/B8rCnd4td/sBR+dRRzPsXkUiAlqixqE2wI804xc0WZr5
	 ZF2XuPMKSouc0r55QRr7qHmHwQI7oetGfdZbOJo5f5UFiQsrhEyrcLeh+yhytMU6Fz
	 Iy6cFSr/6zCxQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	jdamato@fastly.com,
	andrew@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 03/11] tools: ynl: support packing binary arrays of scalars
Date: Tue, 15 Jul 2025 17:03:23 -0700
Message-ID: <20250716000331.1378807-4-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716000331.1378807-1-kuba@kernel.org>
References: <20250716000331.1378807-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We support decoding a binary type with a scalar subtype already,
add support for sending such arrays to the kernel. While at it
also support using "None" to indicate that the binary attribute
should be empty. I couldn't decide whether empty binary should
be [] or None, but there should be no harm in supporting both.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
---
 tools/net/ynl/pyynl/lib/ynl.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 006b359294a4..8244a5f440b2 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -575,7 +575,9 @@ genl_family_name_to_id = None
         elif attr["type"] == 'string':
             attr_payload = str(value).encode('ascii') + b'\x00'
         elif attr["type"] == 'binary':
-            if isinstance(value, bytes):
+            if value is None:
+                attr_payload = b''
+            elif isinstance(value, bytes):
                 attr_payload = value
             elif isinstance(value, str):
                 if attr.display_hint:
@@ -584,6 +586,9 @@ genl_family_name_to_id = None
                     attr_payload = bytes.fromhex(value)
             elif isinstance(value, dict) and attr.struct_name:
                 attr_payload = self._encode_struct(attr.struct_name, value)
+            elif isinstance(value, list) and attr.sub_type in NlAttr.type_formats:
+                format = NlAttr.get_format(attr.sub_type)
+                attr_payload = b''.join([format.pack(x) for x in value])
             else:
                 raise Exception(f'Unknown type for binary attribute, value: {value}')
         elif attr['type'] in NlAttr.type_formats or attr.is_auto_scalar:
-- 
2.50.1


