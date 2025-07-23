Return-Path: <netdev+bounces-209192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E68B0E921
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 05:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FDF568500
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 03:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9DD24728C;
	Wed, 23 Jul 2025 03:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iawbTzfJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FDF246760
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 03:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753241532; cv=none; b=bKpbxS98BCrBpDM0IBH235L2k/JrpfU5dzPqFMgsvXDY7jMuPp9XtZ+HUGwHVyEVyvVe29y6rBJJ53JZrG6+2xXPc6LlpmV0ofbzEhpr78jH1xtaDshkUYe85pmXTG8/zTzk1j7Gf/fXa/NM7lXFnvEhVGgmskCeej6Y/2d+hlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753241532; c=relaxed/simple;
	bh=+gKjXHPRgkTKm3DV3HfVoTWXN6QparpBZ6iqbq8bAb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnzKYDvMxAP+mcPpFjP3NpbEuEnoh9+wu8g7e4WNQmcGk9Dlu/txviUqEK5RaVKhmYhIuE3tRtlFgbehKxHAqmxtAD6EhD0s7zbItKuKS2gbHXuEIfs/fkBYS9d8097SCNol8nEeGkrtsuFMJZe2cwQYmZ6tb2AnhGSi5Ge54C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iawbTzfJ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753241528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qGoOMSxIjm/wg8y86bh1uTm728mrp6p0cfHmIQtlIgk=;
	b=iawbTzfJXNOvG8TNlOxAtYFBC8qpjUep7XQoQ3UY3wWJn6bSiI5i0T03QbJPvZClC4TESo
	+ws+PHOB0jUN321uTz4wGK3gaRMVTgYgYnFlroISP/haLwxshTAZ+eJxStRi9Olew4Hmxp
	3J80mcC5fsvAUIgEYeknxMe2IIR8fxw=
From: Tao Chen <chen.dylane@linux.dev>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v3 3/3] bpftool: Add bash completion for token argument
Date: Wed, 23 Jul 2025 11:31:07 +0800
Message-ID: <20250723033107.1411154-3-chen.dylane@linux.dev>
In-Reply-To: <20250723033107.1411154-1-chen.dylane@linux.dev>
References: <20250723033107.1411154-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This commit updates the bash completion script with the
new token argument.
$ bpftool token
help  list  show

Reviewed-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/bpf/bpftool/bash-completion/bpftool | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index a759ba24471..527bb47ac46 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -1215,6 +1215,17 @@ _bpftool()
                     ;;
             esac
             ;;
+        token)
+            case $command in
+               show|list)
+                   return 0
+                   ;;
+               *)
+                   [[ $prev == $object ]] && \
+                       COMPREPLY=( $( compgen -W 'help show list' -- "$cur" ) )
+                   ;;
+            esac
+            ;;
     esac
 } &&
 complete -F _bpftool bpftool
-- 
2.48.1


