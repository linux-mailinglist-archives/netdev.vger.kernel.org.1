Return-Path: <netdev+bounces-206211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADF4B0224B
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3743C3BE737
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67E42DE717;
	Fri, 11 Jul 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH9HIzpk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023DB6ADD
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253510; cv=none; b=Hd0H/iZ42ibYN4vswoVx29t561pGO5DcG0PmHUqL0eB1r3Bp6rwvu2pOE5x6+ciMt9rwMzIlm2XWXijpPNBVQqVKoh+YjpFrW/DRWCLKHSwu6YYTIMUXSrNNWjtMEQ03r5WArMrayT9QpS80Ynllm1VyfmfIzXD8Gf1nonNIvCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253510; c=relaxed/simple;
	bh=cPWvq6RT2eFn97RyAfLvBOhhq8p1A2KBwMOqzjbgpFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gu+hesyRWN5fzMv0BF4LcI8uRwQlIMlHLD7Xt2tqV6kJsjZyelPLxdHzVwLoB8OJio6nh84Svp9iNTjZz+kgTi5XnkfGehL8awcDxdj7lbmBW7uParwF6xJzSERPsrS+Zdb0xGnJGfB5zC3x6OXbZW/FO65EmTcpUQI35yG6cPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH9HIzpk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so23790065e9.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 10:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752253507; x=1752858307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HNpFbEsippFwL61XSjneWd7VcxKDlDrEsM+gQYwU7+k=;
        b=lH9HIzpkGKSQ6wjkQRdWeK7ugK34naUUgU8jsZRHa9u5HYauzjiVluLJP8v5Yg5ea6
         KEogaj2aEnXOQoGmdkqYcNRhk9R5Z3w18gSRJVz2urXLaAQ8Hfw0pwHf5/kGZ7RdQ+7E
         BY8hPPvyg/zSqf9DE7fB67B6Wv+BFH8IVp2DZXJVEk+Xo5H+zjFxCaUS8Q937Ux190qZ
         GHXb2ukap3mqyA8nEI18DmguNI8nX6TInEq91wp+rnSBlvamKdlc4jQYgpbrTbaq4dlu
         ZPfvK5iODcJVByhXoXOC0jlHFFHin/6D87EKz8bYAXBKDGU3AGsWChDMniDmKiTW/tlZ
         7JcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752253507; x=1752858307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNpFbEsippFwL61XSjneWd7VcxKDlDrEsM+gQYwU7+k=;
        b=grodAxZHAuX+hs5vUhVExvUf+WZRufmVxJRGhFkvMPfkdE9uBPn+4ETki72UFN7rHE
         B3HESTa7iBU1/FQCJiBKhVNXoqCKjAj5JnoTFH3HveA9B4TZbHYbHep1dUkryD0EsGmF
         dgcP0Oq3mP09lW08ZhnVEJRzo1gK4UEP0dkzydtbh4lKMN1RcaoTnKZoy3PdUihgXev+
         Cbx7RPzB26FKWTsJWztXYJakxpNWnkiivkjTSftNMzM+VL7z/gIhYnsgeeLn3rvi0jP0
         vSAtLwvw4Lmt68lm1iIzMFIdTVmHJEy2unve/EqaRr2nZAcHDPSpUzYbUn72FjRsvuqj
         SAeA==
X-Gm-Message-State: AOJu0YzYUlQ50iV2hrhe3KNCEvhprCOLgudzPKDw60ozU/2R7jvdBafp
	SWz921oSCZ2uPFRr3WhgjMQA9zK43Nj5UaJBuxI6aaNVT8xeLCQePbuPC243gH3E
X-Gm-Gg: ASbGncvFECdh4BIW4/bLbDAM/aVaiu663/m/yCWEhb5mHcfweGoRfN9D56mLne47uZj
	nmiyFX5vab/6E0scU2pdXWDCRnjgUq5leWvl5CrO+kGQp2r3OQ8mfsqd1uPmhC0wAgfLbb6RJQr
	LEcHMCocyickxlsPdlzIz9gLFczlt2KAbcxVH546yriR785M8pU210FqrpjkLmnnqnledDU+Q+f
	H4MtK2Y90dIY8s8Llyo0MD0hbXZBQ8V9G7+hZbFL+EEJyylHvWcWafexYcV2rrXzPUH4drv4k3X
	GtdtKJB3Ni08tiNCRLSzTHSjmzGNrttoIGPhXwbBkqecHJ0Li7wvDBOE4UqFAq7zOLELcQvorA5
	YNix9Tv6T39IWimvWpBK8JdKhZX4sYuls1+mccEuI
X-Google-Smtp-Source: AGHT+IHPpJEKwxZOvT93fCrEcaI+8rgOJPp2Qtmk9/iXN7NTWe0ZLYEtawh+2Ogf5BQR4ydrpofmtA==
X-Received: by 2002:a05:600c:3155:b0:454:ab87:a0a0 with SMTP id 5b1f17b1804b1-454f4257f20mr42288695e9.17.1752253506583;
        Fri, 11 Jul 2025 10:05:06 -0700 (PDT)
Received: from imac.lan ([2a02:8010:60a0:0:4586:9b2f:cef2:6790])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e25e75sm4892247f8f.87.2025.07.11.10.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 10:05:06 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1] tools: ynl: process unknown for enum values
Date: Fri, 11 Jul 2025 18:04:56 +0100
Message-ID: <20250711170456.4336-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the process_unknown handing to enum values and flags.

Tested by removing entries from rt-link.yaml and rt-neigh.yaml:

./tools/net/ynl/pyynl/cli.py --family rt-link --dump getlink \
    --process-unknown --output-json | jq '.[0] | ."ifi-flags"'
[
  "up",
  "Unknown(6)",
  "loopback",
  "Unknown(16)"
]

./tools/net/ynl/pyynl/cli.py --family rt-neigh --dump getneigh \
    --process-unknown --output-json | jq '.[] | ."ndm-type"'
"unicast"
"Unknown(5)"
"Unknown(5)"
"unicast"
"Unknown(5)"
"unicast"
"broadcast"

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/lib/ynl.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 7529bce174ff..006b359294a4 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -618,6 +618,16 @@ class YnlFamily(SpecFamily):
         pad = b'\x00' * ((4 - len(attr_payload) % 4) % 4)
         return struct.pack('HH', len(attr_payload) + 4, nl_type) + attr_payload + pad
 
+    def _get_enum_or_unknown(self, enum, raw):
+        try:
+            name = enum.entries_by_val[raw].name
+        except KeyError as error:
+            if self.process_unknown:
+                name = f"Unknown({raw})"
+            else:
+                raise error
+        return name
+
     def _decode_enum(self, raw, attr_spec):
         enum = self.consts[attr_spec['enum']]
         if enum.type == 'flags' or attr_spec.get('enum-as-flags', False):
@@ -625,11 +635,11 @@ class YnlFamily(SpecFamily):
             value = set()
             while raw:
                 if raw & 1:
-                    value.add(enum.entries_by_val[i].name)
+                    value.add(self._get_enum_or_unknown(enum, i))
                 raw >>= 1
                 i += 1
         else:
-            value = enum.entries_by_val[raw].name
+            value = self._get_enum_or_unknown(enum, raw)
         return value
 
     def _decode_binary(self, attr, attr_spec):
-- 
2.50.0


