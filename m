Return-Path: <netdev+bounces-218780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B46B3E7E6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 16:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1973A387D
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 14:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42341341AA2;
	Mon,  1 Sep 2025 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="R6g1/hga"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B631B4F2C;
	Mon,  1 Sep 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738340; cv=none; b=iGOF/efoDMQ/JQZLqwZVJnB0+Jvbzr/GVz/tgjaW2stY6oiUbJ+ttKSs1oJIOqPi3wvHjKu6co0fA6RQ/ICeM4ZfIskq2qOu7HOMDM7A74yXs5AbhNLBzZeNAFOEnVdt1Ml+rB73Vwj/yCla+eKk2virWKp21++xS2hEUwoN/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738340; c=relaxed/simple;
	bh=APyzJaKTB6ST0FmLzhCiqv/pck8FVVt3+BQEdNx2Pcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HggNurqjDPfauYMYGqn5ojxAsHcCZj1aBjN8c8ojyyNvwlBx5fvwC1ZzMklF/v+Nrx+P8CCrUPmI8Cig3bKjI32PE31H0JOBFQNyTP+mh51o/sekLn28jBfKZ59zDvnuo2wX9F2e+tWQ29O5AHwiUycjAqJAi60870LqQ93FO/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=R6g1/hga; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1756738334;
	bh=APyzJaKTB6ST0FmLzhCiqv/pck8FVVt3+BQEdNx2Pcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6g1/hga27RqGOi1Hn35l6Z9Os5REV0aAX34b2TJmLJAy7sMy5DeyPgDzFMA/kVd4
	 MPI3/YGcwRc0xey3IsjZkPsOpNf74oc+YOXJxGmIPBWyafs4gfGYuVFuv6kzI+SrVs
	 3gkUmnSEf0rqQ37E5sQ+EAJLf7zi43bUqXNNtCwFXEKNzC5ukQsh0/pkRxwG416Y+X
	 9tpNoox0nHLEv7BU8dvHf3o8FHP1PB8mP0Un8ai9p21/pqBEJrIDIkCA/xFibG8Yfw
	 4g1MX/7RxhWyCu1OXj+Ji/V5p7LsAF9tdDdIiNi2+A63K0USYwacMwrVwVHSoTszBB
	 8ZzAt9O8aazBQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id D8E986000C;
	Mon,  1 Sep 2025 14:51:16 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id BFCD72022B0; Mon, 01 Sep 2025 14:50:56 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/4] tools: ynl-gen: fix nested array counting
Date: Mon,  1 Sep 2025 14:50:22 +0000
Message-ID: <20250901145034.525518-4-ast@fiberby.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250901145034.525518-1-ast@fiberby.net>
References: <20250901145034.525518-1-ast@fiberby.net>
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
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 52f955ed84a7f..fb7e03805a113 100755
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


