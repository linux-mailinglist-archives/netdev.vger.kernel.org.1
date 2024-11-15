Return-Path: <netdev+bounces-145305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7729CEB20
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F30284DDE
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B601D47C6;
	Fri, 15 Nov 2024 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="f5zNzLcx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C8D1B6CEB
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683473; cv=none; b=P1d00u7XDDCBGGXuMXupmEAvFIjrtfioBw/MHH8ZOo42NTBAIrv4xU6s050Hul9uxXAcWS+XnKZtjjHGLdT56EiDfaIdrU1jncC0SIQI9YgB+Awvuc5J7lM2kWYjx/5nx4CiqKAe07NhAGSIwUHxqbHyA6ZJvAIaRKL4Ef+/VW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683473; c=relaxed/simple;
	bh=MvFejoejzjVXp0/ksQf4JK9iyOrw8/hsflq74VWZcag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RRBI13mMrAI1E7kmaLxeVqUKJu/+AEoH8COJ2jhcXt+TLZ07wGcTP3bL0k43uGIAT3vGjhkQMPG4TZku0+0zVGKsrguKqeb+k3g9WzjVVyKn5tJiWCqYIoY4boO9BYSvYD/DGkdjz9+M5kDjFzioFNIxqMT2MBwxwC1BoWec7sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=f5zNzLcx; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id BxyDtpboUgtkHBxyNtvR1x; Fri, 15 Nov 2024 16:11:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731683462;
	bh=yNQMf0U/atGQpXN0gCR8iiaEcZO1ItCYtrClXMZqPIk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=f5zNzLcxpWdz+8Yqcr+LDAtgIXOc+Vfh+OHuRl1vJKWsbJECxHCYzf6NbWUS3xdUK
	 SA/j/d3yqlRDfVdr4ZomSpI9TaD+r+WjORzQ3CiKzeLtWvHvXqSOf+vpPa6Sf5UeBq
	 T9lZ/kpnk5vyrKt64Y26WoBbnPxCl72c6dO3rJPrAc82ywZgp1NG+VmduDd29nqkBk
	 +hOzEV3dRwpWfrvuj71+bb4IrgxBRNO2R/yFSf+uV6+4oBCyEHOQDqpBP1ctCfhCjJ
	 c6CQ6XzinDe/abopO1xJLihX27mOL+UhrTt85TrByJf/xJ335MIXV6tK/2a4mux+nP
	 NXzqDTAgEGtDQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 15 Nov 2024 16:11:02 +0100
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH iproute2-next] add .editorconfig file for basic formatting
Date: Sat, 16 Nov 2024 00:08:27 +0900
Message-ID: <20241115151030.1198371-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2099; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=MvFejoejzjVXp0/ksQf4JK9iyOrw8/hsflq74VWZcag=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnmKWl7E3Z9fek984yRx5leb1VDA6N7UZfnrWN4xma9a HWmw+WUjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABOxOc3IMOvLc/dX8Ru/ODJa GTfs89mlvPH3fuuH8jVaO5dvbmLk5Wf4H72wJVxVeBuDWtw/rp+rOGt9vT95L3OJNzKsuhOvI/q JCQA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

EditorConfig is a specification to define the most basic code formatting
stuff, and it is supported by many editors and IDEs, either directly or
via plugins, including VSCode/VSCodium, Vim, emacs and more.

It allows to define formatting style related to indentation, charset,
end of lines and trailing whitespaces. It also allows to apply different
formats for different files based on wildcards, so for example it is
possible to apply different configurations to *.{c,h}, *.json or *.yaml.

In linux related projects, defining a .editorconfig might help people
that work on different projects with different indentation styles, so
they cannot define a global style. Now they will directly see the
correct indentation on every fresh clone of the project.

Add the .editorconfig file at the root of the iproute2 project. Only
configuration for the file types currently present are specified. The
automatic whitespace trimming option caused some issues in the Linux
kernel [1] and is thus not activated.

See https://editorconfig.org

[1] .editorconfig: remove trim_trailing_whitespace option
Link: https://git.kernel.org/torvalds/c/7da9dfdd5a3d

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
For reference, here is the .editorconfig of the kernel:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/.editorconfig
---
 .editorconfig | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 .editorconfig

diff --git a/.editorconfig b/.editorconfig
new file mode 100644
index 00000000..4cff39f1
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+
+root = true
+
+[{*.{c,h,sh},Makefile}]
+charset = utf-8
+end_of_line = lf
+insert_final_newline = true
+indent_style = tab
+indent_size = 8
+
+[*.json]
+charset = utf-8
+end_of_line = lf
+insert_final_newline = true
+indent_style = space
+indent_size = 4
+
+[*.yaml]
+charset = utf-8
+end_of_line = lf
+insert_final_newline = true
+indent_style = space
+indent_size = 2
-- 
2.45.2


