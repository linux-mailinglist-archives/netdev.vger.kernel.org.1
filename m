Return-Path: <netdev+bounces-238900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26978C60C36
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 23:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3EA94E191A
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 22:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650C022D4D3;
	Sat, 15 Nov 2025 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcKuAsfn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1082F85B
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763247311; cv=none; b=RAtzNNSrj2A3sWs8/Uw9vjBPBQKcTnJXQArhXvo8zUWEJrgHJ77Ympkdau9Nm0JaQl0pdXHQ5RvuL2VCRlHuGg/peKSD7HyDEYIvfSXj65TevVei35pOyzfxjX3UqWh7fW5PoPZd4w3qyR9hKKkUZ+PVbcTsgQ7rXl8KTfCYW4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763247311; c=relaxed/simple;
	bh=p92btLxIom9PyQWbZWiVz/x1m65/cALdsrcHTsyJnCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UrzGlwb5tTqe+elzwO6Z4wTiWE33Yn8JcDsKEd2TgPpWrtAufx7SZuR+QoRYBX15h9m5w987GIXFGMXISPBKRm9rF/W5Wjo/JKZhaZbSREKaw7+2IdXvYNVFL8IlaHq5Un13mnlzoMFbfWYIAfLORJVISzo3bFABGgcxz1RYWo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcKuAsfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923D0C4CEF8;
	Sat, 15 Nov 2025 22:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763247311;
	bh=p92btLxIom9PyQWbZWiVz/x1m65/cALdsrcHTsyJnCA=;
	h=From:To:Cc:Subject:Date:From;
	b=RcKuAsfn1meMPBCxKJOsi7hN+73yBJBMJfhVH8+CNolPgK2WJXLtPthFK4FJwMGeH
	 QwDycidstfeQIf4NPxNIDlJmcv2ad00TBG4WpI5qXIdve79gJB43kKbv7HQKhDyUAl
	 DOSNm/ROMfVnJJex8Fe4zk4AnT97K01h2J+N4RTnvBSPmzaRUyLyCw22S6wgnKnULP
	 XnKbxVNNJaBwxLqAAFUrTNRQ8LHuFTkdkes9Km1irzsuaovGtlWh080UPwsj1nl4b5
	 E4UkbcX2ZXjm43yhaMQNBwoR2zo2pBj8cdRSX8V6OmgHHqbQ0l8CzOHYDQCSnvVePv
	 mv4/I4uQt4dNg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	sdf@fomichev.me
Subject: [PATCH net-next] tools: ynltool: remove -lmnl from link flags
Date: Sat, 15 Nov 2025 14:55:08 -0800
Message-ID: <20251115225508.1000072-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The libmnl dependency has been removed from libynl back in
commit 73395b43819b ("tools: ynl: remove the libmnl dependency")
Remove it from the ynltool Makefile.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: sdf@fomichev.me
---
 tools/net/ynl/ynltool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynltool/Makefile b/tools/net/ynl/ynltool/Makefile
index 5edaa0f93237..f5b1de32daa5 100644
--- a/tools/net/ynl/ynltool/Makefile
+++ b/tools/net/ynl/ynltool/Makefile
@@ -31,7 +31,7 @@ Q = @
 
 $(YNLTOOL): ../libynl.a $(OBJS)
 	$(Q)echo -e "\tLINK $@"
-	$(Q)$(CC) $(CFLAGS) -o $@ $(OBJS) ../libynl.a -lmnl -lm
+	$(Q)$(CC) $(CFLAGS) -o $@ $(OBJS) ../libynl.a -lm
 
 %.o: %.c ../libynl.a
 	$(Q)echo -e "\tCC $@"
-- 
2.51.1


