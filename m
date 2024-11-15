Return-Path: <netdev+bounces-145183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9089CD6C7
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 06:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF850B21AC1
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 05:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F9B17BB1A;
	Fri, 15 Nov 2024 05:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr9vx0s2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50315FD13
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 05:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650362; cv=none; b=I+/3y0CAK8v64N7B3bV0wChQPfz0TLButoOXn4MsEO17qY/LhF2yGoWPIo1+Bb86+lF5q1oDZPDXqrtPFy06EGrbOiqIljqHZHS9gOuCVg8KKKhaPji4qKw6/YCAZyvQMMD2RDzXlPfzKB/TFdTbjUwGOHroocCwGydx+wSbfsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650362; c=relaxed/simple;
	bh=0C5PTpLyscvzquQ7WTzD8KgRr74ihmZXwVDibh1tji8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FPypE2Kh2e62RMdEWa2ddHAynj4BSlpaSwoQebcFH2oOIuyccyoz1OUr54767ZDeVDe1R1oLRCl9KcbnihIoKqBWw1aSn2pi//7Yntf1fr/3enYDAlY6yZuA15GBu6RsL1jdoX80sHfg3k8hovH3idRkEmM0/9c8wVbqOYpcXm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr9vx0s2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E71C4CECF;
	Fri, 15 Nov 2024 05:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731650362;
	bh=0C5PTpLyscvzquQ7WTzD8KgRr74ihmZXwVDibh1tji8=;
	h=From:To:Cc:Subject:Date:From;
	b=Xr9vx0s2ppl6uM78/fBa+35FR6AYrLg2WNzGJM6+j56R8aAKBSFmgxKRpLwEz3eoG
	 XBdSit9UL7MkWhWI2GE8fS+1AQdcbm7u01BCyDGSjjMm+W+PBrMoaEkG5qsKcB4BH9
	 SY/TMt3saT0LrCX5GsoCTM9+lwVb4PWyEyiJAe+Z5l5JFmQtIR9HThlDXwSBTdEPB8
	 bEdcJ2Yqi6W04d9wvq81VU7+aUZsh578dq73F/W98boa6qC1Q5N8iP2NAIqcBhllzL
	 TSSQLVVtXD/PSmpkqohkbUE58ferZKwgxWPzIFpZw6OMozwko/7aiw/KqSpFpXSqHH
	 U9xCeYJB3yHvA==
From: Saeed Mahameed <saeed@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: David Ahern <dsahern@gmail.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH iproute2-next] bash-completion: devlink: fix port param name show completion
Date: Thu, 14 Nov 2024 21:58:48 -0800
Message-ID: <20241115055848.2979328-1-saeed@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Port param names are found with "devlink port param show", and not
"devlink param show", fix that.

Port dev name can be a netdev, so find the actual port dev before
querying "devlink port params show | jq '... [$dev] ...'",
since "devlink port params show" doesn't return the netdev name,
but the actual port dev name.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 bash-completion/devlink | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/bash-completion/devlink b/bash-completion/devlink
index 52dc82b3..ac5ea62c 100644
--- a/bash-completion/devlink
+++ b/bash-completion/devlink
@@ -43,6 +43,15 @@ _devlink_direct_complete()
             value=$(devlink -j dev param show 2>/dev/null \
                     | jq ".param[\"$dev\"][].name")
             ;;
+        port_param_name)
+            dev=${words[4]}
+            # dev could be a port or a netdev so find the port
+            portdev=$(devlink -j port show dev $dev 2>/dev/null \
+                    | jq '.port as $ports | $ports | keys[] as $keys | keys[0] ')
+
+            value=$(devlink -j port param show 2>/dev/null \
+                    | jq ".param[$portdev][].name")
+            ;;
         port)
             value=$(devlink -j port show 2>/dev/null \
                     | jq '.port as $ports | $ports | keys[] as $key
@@ -401,7 +410,7 @@ _devlink_port_param()
             return
             ;;
         6)
-            _devlink_direct_complete "param_name"
+            _devlink_direct_complete "port_param_name"
             return
             ;;
     esac
-- 
2.47.0


