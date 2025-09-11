Return-Path: <netdev+bounces-222294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA76B53CDE
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8261D1CC68BA
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744152765DC;
	Thu, 11 Sep 2025 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Y28AXAcW"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8DD27280F;
	Thu, 11 Sep 2025 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621136; cv=none; b=DMdaDrkHvd5TvgkLFuE9/yIccMXE9DGNyT3AjnHNILAlHhj6jJPsZ2olJZdKBngOVrdBzvLsBspN3ZEMaBmOHmYGPVZ3N93+CFWMr2G/xaTsdQxUkQ5rMnW1PpwVWPhDfaFgFVOuWdzgXBY4ZJnUZ5GqZsboILnpNWiwkNlNTNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621136; c=relaxed/simple;
	bh=EZJrSC8HKLIZeYkZ/ou7/O3NW58W1W8t+y2LSY8Uu94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvvba3tiFlUA6Qf2PlSYG2qqJ3gn7iGa0hDvvH2R9PYnIcixILbe944NRXrjdags/5+61oBb6s/ZYZGZmrr/w5fZMqrddYkbRKO0o89WeWWT3DKDCpwKIRWy+OZDHp2u1gTd0ftNBAeYKHtTx5PDAAfc1HWC/bckwFQI2FnLws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Y28AXAcW; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757621127;
	bh=EZJrSC8HKLIZeYkZ/ou7/O3NW58W1W8t+y2LSY8Uu94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y28AXAcWOK0yjBdzFPOBC50xh4n1r+wrb2/oJAXRZwyuOi59jSS7LdMEuYu1E/83I
	 5AfGet3+UyfSYN/irQKNueBNfChybd+gtEMsNMDekxOk56bbL2IKxe74mPJ9c2eUVK
	 +vbCZcMKLeWUsKJ55M9Kt7FKH3CyOJumBP83HoLcS6F6gq8PzrgXZDYAg7D5y2gfP9
	 l4YcWN8v9jruY+AZQd+4AZDlpM60rO1AFXMtrPkO2nF9gVNHVocY+aG3H+y14ffM69
	 KPNEcTG9ODF6UwZZVYC/IXT0qvJeDt1HJoVkj3gsRl6J2fBGK5sv6AN01ClNKl5d6Q
	 JEJlVz7qV9X/w==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 2D5FD60139;
	Thu, 11 Sep 2025 20:05:27 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id EC9E920393F; Thu, 11 Sep 2025 20:05:20 +0000 (UTC)
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
Subject: [PATCH net-next v3 03/13] tools: ynl-gen: add sub-type check
Date: Thu, 11 Sep 2025 20:04:56 +0000
Message-ID: <20250911200508.79341-4-ast@fiberby.net>
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

Add a check to verify that the sub-type is "nest", and throw an
exception if no policy could be generated, as a guard to prevent
against generating a bad policy.

This is a trivial patch with no behavioural changes intended.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 95a60fdaf14e..3266af19edcd 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -825,8 +825,10 @@ class TypeArrayNest(Type):
             return f'.type = YNL_PT_U{c_upper(self.sub_type[1:])}, '
         elif self.attr['sub-type'] == 'binary' and 'exact-len' in self.checks:
             return f'.type = YNL_PT_BINARY, .len = {self.checks["exact-len"]}, '
-        else:
+        elif self.attr['sub-type'] == 'nest':
             return f'.type = YNL_PT_NEST, .nest = &{self.nested_render_name}_nest, '
+        else:
+            raise Exception(f"Typol for ArrayNest sub-type {self.attr['sub-type']} not supported, yet")
 
     def _attr_get(self, ri, var):
         local_vars = ['const struct nlattr *attr2;']
-- 
2.51.0


