Return-Path: <netdev+bounces-219229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B69AB40984
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 17:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00EFF7B06D9
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DFE32C336;
	Tue,  2 Sep 2025 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="ALc4rqaH"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2DC31CA71;
	Tue,  2 Sep 2025 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828025; cv=none; b=XFDRft4TMREv68DNCgKvm/UkzbcGurOFQrETLz6OSDZ95xkWNFc12+CLrF/jGkKzxm0I0w94n6bhTq+AVd4UiTNQOQcscgrA+HSPUV/L5g71SHjGwuA/VG4L6SDXQq9Zr4wyLYloorEwJkRHA29qgCYilSTy9YM3LWjqr5kwLRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828025; c=relaxed/simple;
	bh=TPnFZUBGeSXm8HCq9Hzlib3MMWZuwcxYMJUCusHWaC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrTJB18bzeQebgkjdoYaL6FOFNQ7JO5SsGy50o+bTMZ7AuXJ4dWulN8Mw5pB0IUeWMWiKvZjzSz3bjVd/yZKqcEJjXNx8O0QM7QI7IK2vWgt/tqn6nXcl7YTLVQga653EQpxXV1XiriZJyETNKb+9kaWBMpiZDuuxsLLEcB3gCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=ALc4rqaH; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1756828014;
	bh=TPnFZUBGeSXm8HCq9Hzlib3MMWZuwcxYMJUCusHWaC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ALc4rqaHiJoiZM9QbljX3AgIEKkb8XknReBjOAzaEnEkRwQDFIxVNB7XS4I8S87yS
	 oBZg+SDdT+IT6yDKYsul7Swa2AFZcRieYsdGeX300gJsBhql/Uzus3+XJj68jCqCCb
	 B6YUCI2P3l05aWtFixnBqagfcIF4hQgYH4bKf1ZBkbJxBfmU5UxSTzt39Aa2SCsq3L
	 u+8FjPfhGNkE24bdqXUs/FmDUcC55hPIr6g+dqX8/bjKKy1ntZ/lWDUtzBcEhkKmId
	 ZU9XXN54sZ5MD2FXTYGIUSwSluhAp5V0Qaqq0/5sKy4+i92yn1dGujmEEd0Y3ohE+D
	 Wma8mxlkFloog==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 452E560128;
	Tue,  2 Sep 2025 15:46:53 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 70314202271; Tue, 02 Sep 2025 15:46:43 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/3] tools: ynl-gen: use macro for binary min-len check
Date: Tue,  2 Sep 2025 15:46:36 +0000
Message-ID: <20250902154640.759815-3-ast@fiberby.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902154640.759815-1-ast@fiberby.net>
References: <20250902154640.759815-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch changes the generated min-len check for binary
attributes to use the NLA_POLICY_MIN_LEN() macro, thereby the
generated code supports strict policy validation.

With this change TypeBinary will always generate a NLA_BINARY
attribute policy.

This doesn't change any currently generated code, as it isn't
used in any specs currently used for generating code.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index ef032e17fec44..52f955ed84a7f 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -556,7 +556,7 @@ class TypeBinary(Type):
         elif 'exact-len' in self.checks:
             mem = 'NLA_POLICY_EXACT_LEN(' + self.get_limit_str('exact-len') + ')'
         elif 'min-len' in self.checks:
-            mem = '{ .len = ' + self.get_limit_str('min-len') + ', }'
+            mem = 'NLA_POLICY_MIN_LEN(' + self.get_limit_str('min-len') + ')'
         elif 'max-len' in self.checks:
             mem = 'NLA_POLICY_MAX_LEN(' + self.get_limit_str('max-len') + ')'
 
-- 
2.50.1


