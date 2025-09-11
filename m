Return-Path: <netdev+bounces-222298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C46ACB53CE5
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5931CC59E3
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6205827A10D;
	Thu, 11 Sep 2025 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="NJVWSvkt"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3A3274B5A;
	Thu, 11 Sep 2025 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621137; cv=none; b=kFC7WAtML1D1lMGEFWUK+yzAr86ovBqJNSZ+zG9DsVB+VLzrPhRadJ26xGhStX47enpr8c2c7RrWfXqGjM3R3MNZfGJGlMF6G0VRMyac+ZRMNCI7FohRWG8otcsXfP2H8NVNQMz6SN1g0aVb3usvbkeJcugjeLdHVTXOIRqXsE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621137; c=relaxed/simple;
	bh=B0xFRM28DmWIgrG1Q+a6XZkJNRKEo5x4SQ82oQgZwfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gySwPrJaVaFdVpJuVELLEbgVNZQceaqE2xC09jk361qYkuOWhpdwHabRkFmBM9Q+qn4sEISl14R0s/Vlg+TeZ/v2FRXqvjck82y5IWE66Pw4mn4IFOD1v12U4tvy+6prUq4cgOHkvoa4JMlztdYL6aUrLGXdt50qVTtVpZKlWLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=NJVWSvkt; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757621127;
	bh=B0xFRM28DmWIgrG1Q+a6XZkJNRKEo5x4SQ82oQgZwfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJVWSvktbBPJ4GVMV4hCwrMnoeJ0HehiBFmmPCyj7OR4+NS45L5wdp1OTWcgfbo6J
	 MQxqF49AA+Yb+MQ9Y3jDeE/EuNkN2MlA+SGtxSr/AdS5D145VXt2q30iJirSuBx7jm
	 SMYCqCnD8Ki/NaplmZutVlRSc3JI6wrePf0kWROSGNlpgSQfvlYJEyRexPeR5EV2bD
	 9BX7biFn8C1PqBiO0S/bdFu8iraU15EI661XondqvaP3+PWC8pxcBqzYqdxMl0P6Dx
	 kHvmdQOYGrv+ajmoYwjV+aJVZ7VvIFF/lqFw98rEiJ1ydcfAMIMk6A4nFHUcCyaCDJ
	 fIwbJBfQ0/zlw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 423646013E;
	Thu, 11 Sep 2025 20:05:27 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id E2394202FBF; Thu, 11 Sep 2025 20:05:20 +0000 (UTC)
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
Subject: [PATCH net-next v3 02/13] tools: ynl-gen: generate nested array policies
Date: Thu, 11 Sep 2025 20:04:55 +0000
Message-ID: <20250911200508.79341-3-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911200508.79341-1-ast@fiberby.net>
References: <20250911200508.79341-1-ast@fiberby.net>
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


