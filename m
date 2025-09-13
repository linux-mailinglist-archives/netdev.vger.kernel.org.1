Return-Path: <netdev+bounces-222826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E671B563F9
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 02:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265D817D5E7
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 00:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44C22D6E71;
	Sat, 13 Sep 2025 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="QSKhL9yk"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F742D0C7D;
	Sat, 13 Sep 2025 23:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757807963; cv=none; b=oE7/KDTGZ5F2Ak4YJwp1efepZfDvyEFIMMLlyZ6QNEJ7bI1I7jpO03AxWwFLzMRhHc3ZkdIhfYbflcvL63IfCeKYyxvKt6W05y59/IOsVAq/CjGOgqReRuLcYJOVcB0w0KXs74/UazSBuhxwl88TzJw1Egtw2qh/CgpdaynRTFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757807963; c=relaxed/simple;
	bh=B0xFRM28DmWIgrG1Q+a6XZkJNRKEo5x4SQ82oQgZwfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaZ+DismM2Xofae2kdPvANeDdkcjBgK6k2jNhlt4U9TBEfayCgvSOJht1k+DQY73sALFZeIXgJMtfCiLuFiEAP7ya0cD57l+UVCGA7vkU8JxUhD/m2biNnnLD15nWY75WZ+yxMbEUjncj1ThHESw/Uiasxtoq2VYzQdvKakbSdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=QSKhL9yk; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757807953;
	bh=B0xFRM28DmWIgrG1Q+a6XZkJNRKEo5x4SQ82oQgZwfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSKhL9ykTFRBFfF5mgNjxtEiVKKeVGK9HZsKbk9t5Dr0vWXlfplegAyeEd5zORrm3
	 GvEBUJ3hLDDmQQNKtqSUfcfmgIk8BDV5Iz8+ckrj3MApj1/3BaWrhqPyepKoQsaTV5
	 fdwf/5xLgomrEIM7+P093dmJo1e6kLRgu21t5sFKJ+ym18TRyCV0s7+9MYFG0+G2aY
	 TWkmAENO4+6vk1gW/GQKASBjS9jYMPp42TWQXzwhmk+tutgEbNlSPRHP2jXFoCKEPv
	 9BBJ/WaPp9Msi2dWiomlYjycqpi/Sj7/KA6ShWvSMME5+1sC8NwhLJLw3mqf1fCnpW
	 r6dbnYM1EtJtA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 97E7D6013A;
	Sat, 13 Sep 2025 23:59:13 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 3BED6202DF2; Sat, 13 Sep 2025 23:58:57 +0000 (UTC)
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
Subject: [PATCH net-next v4 02/11] tools: ynl-gen: generate nested array policies
Date: Sat, 13 Sep 2025 23:58:23 +0000
Message-ID: <20250913235847.358851-3-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913235847.358851-1-ast@fiberby.net>
References: <20250913235847.358851-1-ast@fiberby.net>
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


