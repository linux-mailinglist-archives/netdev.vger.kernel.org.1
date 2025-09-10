Return-Path: <netdev+bounces-221886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF14B52476
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9DE5841ED
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 23:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AFF3128C9;
	Wed, 10 Sep 2025 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="aCrbd/pD"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE5130FC06;
	Wed, 10 Sep 2025 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545742; cv=none; b=GVrYBVExY+0qKIsflHxB34iUZYSY6ObFAnp+UllOzavs0umgX7g0GFNxsNlg/a4qmU3w0L2CAEaq1Zp/zciYevWQ0e7i1J88NVLpgQeA/+sdUWCWv0WvYnBQQI/p5pn1HMD0NDPC22maEqViYIUbwbW+K+X8DGtoQ4QPRIVQ2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545742; c=relaxed/simple;
	bh=KNcy1v4zfi/eZP7HpihPuqSy+gZFwWXsgS/ILoEcbXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pz3NqMs9aLaVjcmnQyS8qR7IulYC/szmUYRUR2bH1BzJjj6MEjylBbh8HkDSncU9tnv+pwcC25ru/LCt5KB7D6i8/w50a2a639HH+oq9TWGi0sWklZ78zEskhMYHgBB0B8I6ZsKAebh0ViiIbjrIuhh9XNEu+chU2MS7g5o/Wm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=aCrbd/pD; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757545730;
	bh=KNcy1v4zfi/eZP7HpihPuqSy+gZFwWXsgS/ILoEcbXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aCrbd/pDy5sdCqEDbrrk8TrMRDl8uwg5JTucd5QYqK6209lFjYSKFJRv4zEe3CyAb
	 EG6I46jSQEneIJdLDmzAaJd/zoQwViUkrV1v/TSZyHIm3WurPd8tc9GmaYLPFBSizB
	 +fT0OSl5aQCmXo0QqB+Vu5LZhPJJ35JrYSUXr0FtaQqxe8KNCYxRG4Y34KAdRZLRCh
	 CYP6cOrGh97EeYxz+4bBoFgUYWGV87F66Keue6JA2n7y/lstOwiH9xDxru6us8NTpV
	 yHf4rA6caFdsMDJVvaxxr+LXKZP97GyGXbshVaj/d+C0YHv4ampJYTKMi4lRxcfxwe
	 eTQ1kSxL/z2EA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 4C921600C4;
	Wed, 10 Sep 2025 23:08:50 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id D36E8202A89; Wed, 10 Sep 2025 23:08:42 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Sabrina Dubroca <sd@queasysnail.net>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 02/12] tools: ynl-gen: generate nested array policies
Date: Wed, 10 Sep 2025 23:08:24 +0000
Message-ID: <20250910230841.384545-3-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910230841.384545-1-ast@fiberby.net>
References: <20250910230841.384545-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds support for NLA_POLICY_NESTED_ARRAY() policies.

Example spec (from future wireguard.yaml):
-
  name: wgpeer
  attributes:
    -
      name: allowedips
      type: indexed-array
      sub-type: nest
      nested-attributes: wgallowedip

yields NLA_POLICY_NESTED_ARRAY(wireguard_wgallowedip_nl_policy).

This doesn't change any currently generated code, as it isn't
used in any specs currently used for generating code.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 1543d4911bf5..b7de7f6b1fc7 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -816,6 +816,11 @@ class TypeArrayNest(Type):
                     f'unsigned int n_{self.c_name}']
         return super().arg_member(ri)
 
+    def _attr_policy(self, policy):
+        if self.attr['sub-type'] == 'nest':
+            return f'NLA_POLICY_NESTED_ARRAY({self.nested_render_name}_nl_policy)'
+        return super()._attr_policy(policy)
+
     def _attr_typol(self):
         if self.attr['sub-type'] in scalars:
             return f'.type = YNL_PT_U{c_upper(self.sub_type[1:])}, '
-- 
2.51.0


