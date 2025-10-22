Return-Path: <netdev+bounces-231826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5329DBFDD28
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7473AA7BF
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649AD34A3BC;
	Wed, 22 Oct 2025 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="OwWiHU69"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B208E2C11D6;
	Wed, 22 Oct 2025 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157641; cv=none; b=bPwpw+NPGHH5XPs0lqH6RwVP4kCrqnxAnW0TibWvzyaJvW7ZLvpbFthrI+Rg49lHG45x1v7Bas6O8KdUWb04GRQAaOa90zMGCYq9O4+aT5ziiWCS9wCbdEAebAgxpUpGG+pD91KiDXC8c6SYDOes/6QznJn4xhiszI9elng5AR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157641; c=relaxed/simple;
	bh=+ChjTVmw9jhdGA2e1SF3ZyvNwYO2Qd7xy8sXIk2YQnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kpbi6NnyT/JTrEpjBOWkseE9kFgVotAMwAVncMgV3lijXlDnfI7kKiq4v7EvC8n3ij/nQKM9HyabewXxXwFV7FUtGMXxtccESv7MUEW5Yo0HIRXqHltVb/cRHzr+YxebdXQU2P8MNM0FXTlXNr7f1wNoHTp8VtVBELBYL7wGcsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=OwWiHU69; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761157634;
	bh=+ChjTVmw9jhdGA2e1SF3ZyvNwYO2Qd7xy8sXIk2YQnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OwWiHU69h++3qUkwBsBv2HKnAO+dtyx279JrpCgBsmjS3edhF8w+ZSYiteWLx5/x6
	 4vDseB2NMVnvEq91gLa+NGr1o0mO/2gOMk3lwABbcYHeM81/9sm1b0c/O23S6LZdV2
	 T+KS6rdT5lTosE8eNUVEqsMtj+SIB4Os1tJ2N7BXKJLMS8KoqrVUVOmpi563C7n8gk
	 PumAIa114AIfDKG3ZXJzzWcb5iapAX6Z8e9YYYRP5oeW5ym7aIXB5ax9TNvdrIRCoJ
	 Y0e2ks8JekBPSZX7qEMDfLpxUTmRAog69MLmF2tiFcgyQwekEMlsMYabExxaP2EEUl
	 1767/vZd0vkhw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 7F08E600FF;
	Wed, 22 Oct 2025 18:27:14 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 99D4F20228C; Wed, 22 Oct 2025 18:27:09 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/7] tools: ynl: support ignore-index in indexed-array encoding
Date: Wed, 22 Oct 2025 18:26:56 +0000
Message-ID: <20251022182701.250897-4-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022182701.250897-1-ast@fiberby.net>
References: <20251022182701.250897-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When parsing indexed-array attributes to cli.py's --json, then
previously the index would always be set incrementally.

This patch adds support for setting arbitrary indexes, when
`ignore-index` is set to false or is unspecified.

When `ignore-index` is set to true, then it retains the current
input format, and it's alignment with the output from cli.py.

The below examples are fictive as `rates` is not used in requests.
The implementation have been tested with a newer version of the
previously posted wireguard spec[1].

When `rates` have `ignore-index` set to false (or unspecified):
  --json '{"rates":[ [0,{"rate":60}], [42,{"rate":90}] ]}'

When `rates` have `ignore-index` set to true:
  --json '{"rates":[ {"rate":60}, {"rate":90} ]}'

[1] https://lore.kernel.org/netdev/20250904-wg-ynl-rfc@fiberby.net/

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/pyynl/lib/ynl.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 14c7e51db6f5c..a284bc2ad3440 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -566,8 +566,9 @@ class YnlFamily(SpecFamily):
         elif attr['type'] == 'indexed-array' and attr['sub-type'] == 'nest':
             nl_type |= Netlink.NLA_F_NESTED
             sub_space = attr['nested-attributes']
+            ignore_idx = attr.get('ignore-index', False)
             attr_payload = self._encode_indexed_array(value, sub_space,
-                                                      search_attrs)
+                                                      search_attrs, ignore_idx)
         elif attr["type"] == 'flag':
             if not value:
                 # If value is absent or false then skip attribute creation.
@@ -635,9 +636,11 @@ class YnlFamily(SpecFamily):
                                            sub_attrs)
         return attr_payload
 
-    def _encode_indexed_array(self, vals, sub_space, search_attrs):
+    def _encode_indexed_array(self, vals, sub_space, search_attrs, ignore_idx):
         attr_payload = b''
         for i, val in enumerate(vals):
+            if not ignore_idx:
+                i, val = val[0], val[1]
             idx = i | Netlink.NLA_F_NESTED
             val_payload = self._add_nest_attrs(val, sub_space, search_attrs)
             attr_payload += self._add_attr_raw(idx, val_payload)
-- 
2.51.0


