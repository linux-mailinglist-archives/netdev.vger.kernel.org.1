Return-Path: <netdev+bounces-209363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE11B0F5BB
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 16:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2661C2070C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BDB2F5C4E;
	Wed, 23 Jul 2025 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WMftpDJB"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9A72F5C21
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281948; cv=none; b=Fvo+DYE6ciQ3xMZsS9sWfgBvnkcJz+o1zJSD7sijW4iNepsZELVHCKfJLvIq2xlGzc2zmE2Eeyfpk8hW8gkYd3nueaI2CaLKQXiXf/9ddSCvZYnqk898+P8Ri1TTRsuz/H9HHv0ZCzzOMz0yMTnzwGR6zeeaW50zmH3FfphiBYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281948; c=relaxed/simple;
	bh=+gKjXHPRgkTKm3DV3HfVoTWXN6QparpBZ6iqbq8bAb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiUId1uyemAXYWgMuU2Ljseej0Y6Mzz60/syNNHKuNyGiMKvSrqNb2h/6z4OrN/igQGWBsu/50957LIL/kiSaQv7NOXn+/tbMh4tWTEofX+fogdtga64lHeVgS2wNln0I1V8raS9xtB13qEvpwGbePTvcdyRKgoqZ3LTkEQU7Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WMftpDJB; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753281944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qGoOMSxIjm/wg8y86bh1uTm728mrp6p0cfHmIQtlIgk=;
	b=WMftpDJBURdp5mX48FF/7YGtX5hhIDRFCHq4z9bKPf911kp2xT7ScRFcHn48ydL4tFdMlO
	iZ25cCld5mcXK0J/IJUQ84zaf7zsp1fmUA/CkblSFkZhH4SlJHAly2oLCUc2UB5M5JJsFg
	KpBJ5vmFoENBrz11q3fwjtE0mK7FiHo=
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
Subject: [PATCH bpf-next v4 3/3] bpftool: Add bash completion for token argument
Date: Wed, 23 Jul 2025 22:44:42 +0800
Message-ID: <20250723144442.1427943-3-chen.dylane@linux.dev>
In-Reply-To: <20250723144442.1427943-1-chen.dylane@linux.dev>
References: <20250723144442.1427943-1-chen.dylane@linux.dev>
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


