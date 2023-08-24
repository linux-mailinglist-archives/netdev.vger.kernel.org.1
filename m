Return-Path: <netdev+bounces-30168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA8A786440
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 02:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7722813A3
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 00:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664B619A;
	Thu, 24 Aug 2023 00:31:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45FB17D5
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 00:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD05C433CA;
	Thu, 24 Aug 2023 00:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692837064;
	bh=2tGGV7MvvdpEd7TlX1kvwAgLP2tN3pYgoYGJJg1JrE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sns/2tc1qixXUB1CKpjqCwsjaKbftnWZ9lfzlwtRySEXwurhjgQkcbJNMSs1Jc3Fj
	 sFGctsOAclKUX5y+qZZ8uP01qf7CNs9bgbDbEtY0gFxJKhxRHHcFqa9xGonxlSVkDy
	 nMhloO3ktczca0DMcYoG3K/8/sLscUAqTO1+bkoReGjjHNZGoa7VzuBoktyntQtRg2
	 +RDdxZghfL17QKzc84Wnacr1ZL1ksFqGVl4tl/+sPbS3TcwH3Y/3OEBeE0je5Nd6DN
	 RX+JYNB0GIHMxBrgSffCXvkA0n793P8AC3znlnq1QBmyfkMC2YBO12LFpMoYQEhyOI
	 ourexY5RAIjaA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/5] tools: ynl: allow passing binary data
Date: Wed, 23 Aug 2023 17:30:52 -0700
Message-ID: <20230824003056.1436637-2-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824003056.1436637-1-kuba@kernel.org>
References: <20230824003056.1436637-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent changes made us assume that input for binary data is in hex.
When using YNL as a Python library it's possible to pass in raw bytes.
Bring the ability to do that back.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 6951bcc7efdc..fa4f1c28efc5 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -410,7 +410,12 @@ genl_family_name_to_id = None
         elif attr["type"] == 'string':
             attr_payload = str(value).encode('ascii') + b'\x00'
         elif attr["type"] == 'binary':
-            attr_payload = bytes.fromhex(value)
+            if isinstance(value, bytes):
+                attr_payload = value
+            elif isinstance(value, str):
+                attr_payload = bytes.fromhex(value)
+            else:
+                raise Exception(f'Unknown type for binary attribute, value: {value}')
         elif attr['type'] in NlAttr.type_formats:
             format = NlAttr.get_format(attr['type'], attr.byte_order)
             attr_payload = format.pack(int(value))
-- 
2.41.0


