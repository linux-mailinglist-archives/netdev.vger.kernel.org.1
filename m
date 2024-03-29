Return-Path: <netdev+bounces-83431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DFE892417
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 20:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B521F22E1D
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 19:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9CD137765;
	Fri, 29 Mar 2024 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdbcJ4bQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BD5136E07
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740006; cv=none; b=gaxZ8o5a4nxVv3cQK09KrFwh7kzb8nFXkLldJOnjuLUWncFWKiJluY19VNOH5u+Ik8j+pKd60rHXdK5yiJ6cYUhCJ8R72zr4amQq7Y7MAugKyhhv88wxUoYpEjOsVyxps1abqAms+2oPwtwL0daOtzJsWmMtp0ocUzMzFFzv/CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740006; c=relaxed/simple;
	bh=FSP1oV2T/usULlM1VYDd08bWBIJsZLOi020rBF4z6Bw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QDCa4nBGRJJENVHImTPv+SX92Ac8sV/7ez/YCb4l+CkKcvlQMT8CPqWGr8CF/wgmHC5KBh5ufwnwUvkP8bE8yXOuCBnDzpVcrd9cR7WVIhZHSKRthldeBAjiBRgUrhlvzSZJyCWJFCIgXJnrpKsXafG0M14JGDU1IpBMEa+4NiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AdbcJ4bQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64f63d768so3909991276.2
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 12:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711740004; x=1712344804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EcI6g4FflKBTSfJKFEIW1tJynz7mTB9AleLJZXHTyLA=;
        b=AdbcJ4bQH0gqZlhr0WmKydY/gGFJ5IJBwSncVy5cbhKignhCun7QzKW99CTVCNI+qg
         sTRd3wegMfdO3o1EGbSAcnX/D52gL9lBPcB8On5hwkfuvvXzeTVpTljG5BLvMeSImJHk
         qwfn03aZx2/S5OVRYvblMPx1JuKKgcw9A0ZGbUi0rLQEtg6n4gCTEdxEJPO6QUM97ATO
         +92G7aGo2SS5nWgweMQ5kbak4gEVxDK9KhrYDkZtEzjBAwGPYnc71YDQebYJ4jXVdg2Q
         oG2zXnftogW4eTNIrCxyE8+ozwFpyicYPMX5S9Fn6uNjyzHXDGnWcb/p39ZRcg5oxMFW
         88ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711740004; x=1712344804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcI6g4FflKBTSfJKFEIW1tJynz7mTB9AleLJZXHTyLA=;
        b=fQHnHmeRCOA8jR+Ga6Lainpb2RXZ3GQmCSiAonM9IKdcJDuJpq5+9oIocw29D+S75Z
         1yoB3vNTQfRGVWtTdI1iuHlEJ8cx3XZo1uRXSyHc3l1Eq+7WRZBKxUPZSLvZwQUyY5nN
         pwJgoIqpvX4wH/iXEYU37YGqjlCyLnBGTiGE6Z81iGQFgvHhfqvPsDl5P3KK9ZveS6Fg
         rV2VjbnLOWwBVslyRqq/jD3dg9x+vbJEOTYkEqPvDjFxrmInK3W8vJLNY0gNpliKknyc
         iiW1LISw8xTz94kjCsTt4L9KyjXXdfV6wDoPpUbSJIY2zCsI56/FPN1Ut4S2p3nw6cJ7
         1nNA==
X-Forwarded-Encrypted: i=1; AJvYcCXmgjazQ2GqoT4J2jiLx0gf5P98KSF1VLLhYnEGMXiztbkZpKxKPHRVagnV4tNpCTOnA7pVZllRJs9JPl30/6E8+l6nH6d2
X-Gm-Message-State: AOJu0YwCz28eA04+5DBMg2q3gY9swmVrloy0YhwiMWQ0eJyhT7zHKCbT
	Gt+cy74gZ/dbueKMC9psbnKQQfA4yNOqfhOoKRVSu+rLs/4SMXW3TCgnjJgMHU8Cry0wffoJkA=
	=
X-Google-Smtp-Source: AGHT+IGH0KK9182UUL1GAJNaUHzbTv3CkROT6oxKGok86GWqAdDqq2cDBN1yFx4i1s+2vMk+0slVLQNbbA==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6902:2306:b0:dcc:50ca:e153 with SMTP id
 do6-20020a056902230600b00dcc50cae153mr932390ybb.7.1711740004528; Fri, 29 Mar
 2024 12:20:04 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:18:51 -0500
In-Reply-To: <20240329191907.1808635-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329191907.1808635-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329191907.1808635-7-jrife@google.com>
Subject: [PATCH v1 bpf-next 6/8] selftests/bpf: Add setup/cleanup subcommands
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add optional setup/cleanup subcommands to test_sock_addr.sh to allow
those phases to be driven externally by the sock_addr_kern test program.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 tools/testing/selftests/bpf/test_sock_addr.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sock_addr.sh b/tools/testing/selftests/bpf/test_sock_addr.sh
index 3b9fdb8094aa2..dc0dff612b0d2 100755
--- a/tools/testing/selftests/bpf/test_sock_addr.sh
+++ b/tools/testing/selftests/bpf/test_sock_addr.sh
@@ -55,4 +55,12 @@ TEST_IPv4="127.0.0.4/8"
 TEST_IPv6="::6/128"
 MAX_PING_TRIES=5
 
-main
+if [ $# = 0 ]; then
+	main
+elif [ $1 = "setup" ]; then
+	setup
+elif [ $1 = "cleanup" ]; then
+	cleanup
+else
+	echo "invalid option: $1"
+fi
-- 
2.44.0.478.gd926399ef9-goog


