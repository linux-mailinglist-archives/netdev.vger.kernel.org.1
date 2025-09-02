Return-Path: <netdev+bounces-219236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BADB40A07
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 18:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 500C97AF069
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8AA3376A6;
	Tue,  2 Sep 2025 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="n/wVb3+G"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B06335BC6;
	Tue,  2 Sep 2025 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828815; cv=none; b=WRl7Uk9B3RVjV+nOajz5c2NfHTUlSL+W1+louGQ0TmW35B/PGklJFQy1ob2Uf305blb1YSQJsNcxhiAUpcEI1oHgU/pyXOU0NL1bW+XQejcPbMgI/GA+xO6MWWZiujVmfNNUmOe9GbL58fATq+L3J4KqrPvGRUMYd/+WIxJZI+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828815; c=relaxed/simple;
	bh=s/QmkNRVYIQSW99Vd3rmTSJ5sH/frS9SL+lIZlDel2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s4FOLdVxhz+eoCNzYvrkw5OYu6AtLsupO11r+NQ5EQyCZFP468NIMk7XQuK+usvOcpuJX4cV75mpW5wbHNWqEIclELdGUJNAemniA2xJD5DaTnhqkXcTS6MwF9kY09NPTJkzYeLr9XVz7L2QvQLq0Yd+5CgWh9TmjCxX5p0NhbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=n/wVb3+G; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1756828809;
	bh=s/QmkNRVYIQSW99Vd3rmTSJ5sH/frS9SL+lIZlDel2o=;
	h=From:To:Cc:Subject:Date:From;
	b=n/wVb3+G2KMlsL4Ta7CUWiPwQQC/2YGbmLbdJVfa0cvToixgCRDqYvaPqY3eeZ1BH
	 Dd0h3Y4q5n1Qc3CcHpeZMULZw/iU0naSd+wUZPGfgK68yLfOqQzR+KFI7NZ1ZaWvbu
	 9aKFKI8h+zFpixDtCOn/UD07G4TD6aPRSeGNMEkll3gqyO+TzNP8wjs2v7nROUQRVg
	 YPcxJhiYCATTqqV0cpVENp1iV1KAiSEhru4TxDQbvHkz7NCqIaAdlI6gNKGuswMOYD
	 jKwenE6iPRBJKHdyro+0Z3Lc2Y+vwdhWTLi//h0d8iiNQ98Y3qSOAsFfdhdJ/A17MB
	 EXJTpiEN8QzJQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id A93846000C;
	Tue,  2 Sep 2025 16:00:09 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 038142021C5; Tue, 02 Sep 2025 16:00:02 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] tools: ynl-gen: fix nested array counting
Date: Tue,  2 Sep 2025 15:59:59 +0000
Message-ID: <20250902160001.760953-1-ast@fiberby.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The blamed commit introduced the concept of split attribute
counting, and later allocating an array to hold them, however
TypeArrayNest wasn't updated to use the new counting variable.

Abbreviated example from tools/net/ynl/generated/nl80211-user.c:
nl80211_if_combination_attributes_parse(...):
  unsigned int n_limits = 0;
  [...]
  ynl_attr_for_each(attr, nlh, yarg->ys->family->hdr_len)
	if (type == NL80211_IFACE_COMB_LIMITS)
		ynl_attr_for_each_nested(attr2, attr)
			dst->_count.limits++;
  if (n_limits) {
	dst->_count.limits = n_limits;
	/* allocate and parse attributes */
  }

In the above example n_limits is guaranteed to always be 0,
hence the conditional is unsatisfiable and is optimized out.

This patch changes the attribute counting to use n_limits++ in the
attribute counting loop in the above example.

Fixes: 58da455b31ba ("tools: ynl-gen: improve unwind on parsing errors")
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
  - Re-send as standalone patch.
  - Add Reviewed-By from Jakub, thanks!
v1: https://lore.kernel.org/netdev/20250901145034.525518-4-ast@fiberby.net/

 tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index ef032e17fec44..eb295756c3bf7 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -830,7 +830,7 @@ class TypeArrayNest(Type):
                      'ynl_attr_for_each_nested(attr2, attr) {',
                      '\tif (ynl_attr_validate(yarg, attr2))',
                      '\t\treturn YNL_PARSE_CB_ERROR;',
-                     f'\t{var}->_count.{self.c_name}++;',
+                     f'\tn_{self.c_name}++;',
                      '}']
         return get_lines, None, local_vars
 
-- 
2.50.1


