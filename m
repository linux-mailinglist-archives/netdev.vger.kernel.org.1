Return-Path: <netdev+bounces-201453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05786AE97D5
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CB44A1DBA
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427B726D4C7;
	Thu, 26 Jun 2025 08:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="er1z2l0M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1304D25D543;
	Thu, 26 Jun 2025 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925624; cv=none; b=g+R2D0fCTBkH99cI5uo6lN8+DYwn9m04UNeRW3KJGb+ERTMAHqWsoGf9BZrcovc36R6Hf/TOo0yFQ3odrJVS+xt6mQiELycqGxRoaPyjitkAbYAqYOjYOLNBW0YNnsbWb84S9UsY5ZA5Be33h5/YFsgQNnddeLcCHA4o7re9J4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925624; c=relaxed/simple;
	bh=ogBoG80VZdRt95wsoC2snRc4eLHl6tjexBrTDr8vuXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDxibFa8xvZL7l8tX0YZ/gBZQ7VNpGDN2k20VuJQhLIIPxe8EV2WGiZlRz38pi6a1p2rZt4grUIg0Nj/TWDAK9o9PNiOvLwBpqfHfwSuE9Wd7AHEL6SM4iH0gM6UgNu6u5g5zwEA7oPzPnm/bLEdiSU7anMMpgZpJFzTJoEEqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=er1z2l0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9B4C4CEEB;
	Thu, 26 Jun 2025 08:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750925622;
	bh=ogBoG80VZdRt95wsoC2snRc4eLHl6tjexBrTDr8vuXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=er1z2l0MrZ4d3jZk0t0dDm2f1gJKc2hWYxYKiQznmv8kXVpLyR0Wu/CKqkm+DnPhu
	 Q3pR2Jnlb03I3FTaOoK3l0D7gMV7NIeiC0GRnrr1Cug3OEoHpY2Tx+5RcncBNYqJea
	 y4uYqpO5dHLBL56ZKSyFvzTGPcMCZFVkjaoeonjPF+K4YSOMMGAF5GvTScYszLUh5z
	 dIIQ+aIzY+7gk0Is60cH0m+MMMOmOIdBlWpFXu3PJFtCX3duKEcjvwrcev1W5qhinY
	 h37oOc7p373q7Uit03L8GuTIxKoJs2xwUFNSDNYTuG9PtOnSyqIqTTQJqIJwP+s6wA
	 KbEHsn1gl2y2A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uUhjT-00000004svz-1wGi;
	Thu, 26 Jun 2025 10:13:19 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Marco Elver" <elver@google.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Simon Horman <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v8 09/13] docs: netlink: remove obsolete .gitignore from unused directory
Date: Thu, 26 Jun 2025 10:13:05 +0200
Message-ID: <bb35026e2d806ca4abcfffdfbd46e4e6ea30859c.1750925410.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750925410.git.mchehab+huawei@kernel.org>
References: <cover.1750925410.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The previous code was generating source rst files
under Documentation/networking/netlink_spec/. With the
Sphinx YAML parser, this is now gone. So, stop ignoring
*.rst files inside netlink specs directory.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/networking/netlink_spec/.gitignore | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 Documentation/networking/netlink_spec/.gitignore

diff --git a/Documentation/networking/netlink_spec/.gitignore b/Documentation/networking/netlink_spec/.gitignore
deleted file mode 100644
index 30d85567b592..000000000000
--- a/Documentation/networking/netlink_spec/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-*.rst
-- 
2.49.0


