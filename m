Return-Path: <netdev+bounces-223105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE007B57F6D
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD651703D5
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B268341AA9;
	Mon, 15 Sep 2025 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="qDvQ26vR"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CEE33EB09;
	Mon, 15 Sep 2025 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947673; cv=none; b=Im5x5Y/PcwnHZGwzjtF4qjyX3jymAU4uNW9AGJiw6FaOj7BeNZQiWkRc6HnwQxtBqG/MkPTBrA5/bj/5IVaYv84QjNj7imtdEz6VbJk+lYoAhGbfR3L+ECF1xZ7lFlSlGqw2AF1EE9EWoIEd79+qU6VmoMlSmxQs0/A4lM+MpDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947673; c=relaxed/simple;
	bh=B0xFRM28DmWIgrG1Q+a6XZkJNRKEo5x4SQ82oQgZwfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gf/cadaPyzljy6id84QCbIs4Xpfe2RCCpIJ+6P8shGhjJnrSDfdCLwb2hBqTcK3lCob28poRnfwlM3nYO0tA1t4rXIpyyylloEVHSF/3MvDPUJd/10/kQsWgWdwxibG2woOpQTDvyOusDfBuXyyqbpouRLZqlTPyZ5g8m8wM7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=qDvQ26vR; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757947661;
	bh=B0xFRM28DmWIgrG1Q+a6XZkJNRKEo5x4SQ82oQgZwfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qDvQ26vRLKp8i/bEPYw5f4D7LjdmgecCLOqtlqjFfF5l0wVHgFXa4uwnAWbqcqaTP
	 +1sw4c+O/AyHt9MnNr6E1JjFG/p8+c+zGiIiKIZHGWY+sce+BNYcJNcexivo4Pp6yW
	 kE5aQ7cVNg6+t5nykwb5JSo/GCy+PfB41cWY0jKLuc6B5TDHxLe326YyR9N3fhdSZz
	 ps4jyP/ox7fPio/XIgdcm8pdnAEXbEJoGXKQxRNRR0nFr21s6pU+7ESh9nCj9fTp6f
	 klVbOR8Z4CL6GcE10oKX95NjIFPPpAMcK5vzhMtmgegHofhCluz9vM6iyMlvDRaQMU
	 SuVsY3PW6r1nA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 044A56013A;
	Mon, 15 Sep 2025 14:47:41 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 139BB202FBF; Mon, 15 Sep 2025 14:43:06 +0000 (UTC)
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
	Sabrina Dubroca <sd@queasysnail.net>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 02/11] tools: ynl-gen: generate nested array policies
Date: Mon, 15 Sep 2025 14:42:47 +0000
Message-ID: <20250915144301.725949-3-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915144301.725949-1-ast@fiberby.net>
References: <20250915144301.725949-1-ast@fiberby.net>
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
index c8b15569ecc1..95a60fdaf14e 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -815,6 +815,11 @@ class TypeArrayNest(Type):
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


