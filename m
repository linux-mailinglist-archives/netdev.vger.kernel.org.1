Return-Path: <netdev+bounces-182479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C232CA88DA9
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C4A177C83
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17051F3BA4;
	Mon, 14 Apr 2025 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPFJFgCM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB30A1F3B8D
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665601; cv=none; b=cDd1CIzqbSM4W3cnOjemr4Nt20UCTCuXCG8o6b0fneuDAGkMPaALEL+bcJ5rVlEhtUkQGY0SodGC4iiNIzxUMEtO00PXGP1WX7RdcFOh+XlxazPCxR7pJgGqv+v8p36p9phV3I+aIdpGd2atbcJCbDvTNEx7mifPqdgBC9wytWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665601; c=relaxed/simple;
	bh=nZ2CgW2ofgP+ZXqesZ8y0Jtl4HesSUJ6ElUfLaRaLE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcswEFs+XxEF8UIcpteu5WIIYdPdglof+926PR5zaaRT2epx4jnxoar1Rg4e+LPKc9z9C1Yf+ql2NXkhucyZ3j7q4+ac4aYQ6UJVNcYVDomk9q89KpgKVLNEMybsGCB7WS6t9sKilNNo8LcH1MsNiKgWI8xOG29d2MZnqqe0hOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPFJFgCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D58C4CEEB;
	Mon, 14 Apr 2025 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744665601;
	bh=nZ2CgW2ofgP+ZXqesZ8y0Jtl4HesSUJ6ElUfLaRaLE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPFJFgCM02vzdkpMPQCNunrV5ss3Rk/4Gv1POepD7AYaCEMoPQhiHv3b+e7KTnMyb
	 Ga9N+5t1a8bFXcOn2Is9tkN0Zr6TsjxPkCX5taaxztsHIHlYxXIZKx+pk/EEcE6k11
	 VuaDci8HNHPQWWNI7w5jnM/x2vpHlfU42istl5hf1crb2Sg7ZKXSyDsPbIDrnRyXbz
	 AbcoVEzlvS/1Td1Pn6kIGRyj4epkudfeSI8WfKVcU43fkMmOLWLXpyVepqrk2fNM/p
	 jOiHHo+pWNZ9VksX6GZ9wQwsSmJ/rAciXx+Qt0hwVwxQbiWUQw3EX4EyGZu+S0ustM
	 XOc0T5apaCNOw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	daniel@iogearbox.net,
	sdf@fomichev.me,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 4/8] tools: ynl-gen: make sure we validate subtype of array-nest
Date: Mon, 14 Apr 2025 14:18:47 -0700
Message-ID: <20250414211851.602096-5-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414211851.602096-1-kuba@kernel.org>
References: <20250414211851.602096-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ArrayNest AKA indexed-array support currently skips inner type
validation. We count the attributes and then we parse them,
make sure we call validate, too. Otherwise buggy / unexpected
kernel response may lead to crashes.

Fixes: be5bea1cc0bf ("net: add basic C code generators for Netlink")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 2d856ccc88f4..30c0a34b2784 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -714,8 +714,11 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def _attr_get(self, ri, var):
         local_vars = ['const struct nlattr *attr2;']
         get_lines = [f'attr_{self.c_name} = attr;',
-                     'ynl_attr_for_each_nested(attr2, attr)',
-                     f'\t{var}->n_{self.c_name}++;']
+                     'ynl_attr_for_each_nested(attr2, attr) {',
+                     '\tif (ynl_attr_validate(yarg, attr2))',
+                     '\t\treturn YNL_PARSE_CB_ERROR;',
+                     f'\t{var}->n_{self.c_name}++;',
+                     '}']
         return get_lines, None, local_vars
 
 
-- 
2.49.0


