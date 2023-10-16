Return-Path: <netdev+bounces-41567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A447CB55D
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 23:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0CBCB20E2B
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 21:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0296381B0;
	Mon, 16 Oct 2023 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbBngGIZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A3737CA9
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 21:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5984C433C7;
	Mon, 16 Oct 2023 21:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697492380;
	bh=4gzug7NKJCMlF9uqYhZhGQUBdFYAs1xvnbnd9eTW8RI=;
	h=From:To:Cc:Subject:Date:From;
	b=HbBngGIZZazNU8q65Fweoirkzv1vdclRvy4pdl4HYWvheg8ds2l6fflEU4GXhEmg0
	 0vPKUt+AJehUJweWHEjlwu8cZPeGxzGrcI3edDDZTu82kEPSY6dx3W6pqm3n/heUgK
	 l1vq9qQypdVV1WTWE6y1k5eidpcaePaX+T6QS1JIKAs15pwXaoYYeFDmfaGpb8/Z0F
	 YPAMm2qqTr+rVQQrIMrmuwJs0ooAL51kt1JoT4Sp6MxpNNyadZCpabiJriZmk8wAcJ
	 At+hAGt7dfL8wT1B6vzQBAl4heR+08Ai6n9VtQ/vIaoWXhVbLcdIyEzDenqut8jNvs
	 uYdW6T4cBSU5g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Stanislav Fomichev <sdf@google.com>,
	donald.hunter@gmail.com
Subject: [PATCH net-next] tools: ynl: fix converting flags to names after recent cleanup
Date: Mon, 16 Oct 2023 14:39:37 -0700
Message-ID: <20231016213937.1820386-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I recently cleaned up specs to not specify enum-as-flags
when target enum is already defined as flags.
YNL Python library did not convert flags, unfortunately,
so this caused breakage for Stan and Willem.

Note that the nlspec.py abstraction already hides the differences
between flags and enums (value vs user_value), so the changes
are pretty trivial.

Fixes: 0629f22ec130 ("ynl: netdev: drop unnecessary enum-as-flags")
Reported-and-tested-by: Willem de Bruijn <willemb@google.com>
Reported-and-tested-by: Stanislav Fomichev <sdf@google.com>
Link: https://lore.kernel.org/all/ZS10NtQgd_BJZ3RU@google.com/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: sdf@google.com
---
 tools/net/ynl/lib/ynl.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index cc2930633f98..be479bd9dfc8 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -486,7 +486,7 @@ genl_family_name_to_id = None
 
     def _decode_enum(self, raw, attr_spec):
         enum = self.consts[attr_spec['enum']]
-        if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
+        if enum.type == 'flags' or attr_spec.get('enum-as-flags', False):
             i = 0
             value = set()
             while raw:
-- 
2.41.0


