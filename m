Return-Path: <netdev+bounces-68278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323868465EF
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 03:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE0D1F24E12
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 02:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACA18814;
	Fri,  2 Feb 2024 02:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4jGuH/n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49452BE5A
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 02:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841489; cv=none; b=MzHA71aEj/rG7YwSx46vWVDBq9wESm0K9K63n+y1Dd7xHcpahcnOXQEOBenM94mA/dXCd4cXDdttuAxSinkoVWmLpv7DoYOg+47sMxD+86yVqz188CG0OpNRzI9V4z9uzPt3VXV7ZIxOiP9E+Tgt9HkZqbdLARcXnlBj6FlI9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841489; c=relaxed/simple;
	bh=KDU5Sap9KmERo+IOTSOxwD/wM01vjxr94Mz5wDzVw8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acSzBx1USYaHNGLyGwErsEJYpgzJazwHZD+o+mLu9VKizqbVkl1DBM6YiSyGbwVBpIbKdMBIPJtqrQqc34/jQTiIp7Eecj4p1etxtc6KyQYmPDQp9+ncxtoREa+ZN6u8s8W1iBykBNZ18ny/t7cZbpyDICK3XosHSpBnOQSu+MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4jGuH/n; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d932f6ccfaso13112155ad.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 18:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706841487; x=1707446287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7f+YPdLV02rXa/1f3nKaHnsp07nRY0/vdqPS1EubdSo=;
        b=F4jGuH/nAiCYeuEN3cwd6JF3YIN9ZSyUGJsz26oBluP9GF5um5NSboxJqwbKbwWCCZ
         WIt6QwHuHS4+qRlJCH7k1I8FAF9zdQ8d1EhU8KxDqCgw7vXCqPMkT8TMt80XayvsJGf8
         ayq0SEI5h4yN173dGzkCKg8WD2LI7ps4ukCYRYWKzyoiwqoiXzwk1y8Lkmpwg4qw3A1k
         IRDI8psXQlj60Zl23uskLi5bXgJpP9tw2h8c5z7TddmJrOk/O+fDhU9fyucmns2R/vWh
         vILgMQE2A/u7ILUeCP/IejN5NYJKs3G75kFf1lRutuTI84oacLJHr13WgW2GCe4HhzSt
         gsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706841487; x=1707446287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7f+YPdLV02rXa/1f3nKaHnsp07nRY0/vdqPS1EubdSo=;
        b=s217sCEZ8CVGuwIdcBqay0o6/4Dn4uIJE+ySM1EoD3SUSclO33Rn8MsydrPUnCiaYm
         ZUCmjg09ZpUkhSqF7iBgILukiIsTLnIOKhl4cxqDD9lii9R7qvMCHWvs1FIB2Cfdc7bn
         CewFAJG9GodRJ6Yxczz90gg4GcZjnJCOyAGmuXNVXqjVhWhHKKWUsK8rgMwwaocmDQ+V
         HUL8IScLhLX4Rq8edWfwSnN0CS4qA8NpPDypgh2w21gnqOc5zJZj3oUIa9zZvm3N63IJ
         Uu06QGzb2jBd3HyZ4hBuyfG+A9Je3yF23zqyy1Q10zqGAwidhADaztHbb/V+8QA3CpFK
         TkbQ==
X-Gm-Message-State: AOJu0Yz31rLva1cxHttArkxnOBT0KTkHcYdear3AJRiGnud7ZCuN8o8q
	waX8WjEQP+JbYnz/5EqVe+nLu9CHzgf3a1y7w30VfU83WCFjzrejJFa92AMv88l7D0hs
X-Google-Smtp-Source: AGHT+IE60aE7iVtNs16/OTB6Oi5cYYl4Ls/oROOmgN/3m+JftJYc1+BE+6HL5g30nAvNOK7OSebgvQ==
X-Received: by 2002:a17:903:2b08:b0:1d9:63db:2bd7 with SMTP id mc8-20020a1709032b0800b001d963db2bd7mr2464077plb.61.1706841487115;
        Thu, 01 Feb 2024 18:38:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVQCXpwluYZWLhgSAVOEAI7WrRmfnyVaHlzzvx6zICR6OndgZS8OgCvPLIqVS4hhSaaKHqPahXiOqOLRcMu6XFTlJ4gT+8rqnbGcsJWel8NVP1uXJtIf/KtSwNi8bXjjy5aQrWUrXy+bYpdLPk7Tz0qeSpR5bYeZRWkxABYCXhW7bn3IXPzXcnrt3uBpuEK7Lmpnc5J/fmLssB7uTZ1mOkX/2KOI8Xa39rXwuTnU8/GedmJjPVUJlTfr7txzkajr8sJSg==
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ji19-20020a170903325300b001d944b3c5f1sm493256plb.178.2024.02.01.18.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 18:38:06 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 1/4] selftests/net/forwarding: add slowwait functions
Date: Fri,  2 Feb 2024 10:37:51 +0800
Message-ID: <20240202023754.932930-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202023754.932930-1-liuhangbin@gmail.com>
References: <20240202023754.932930-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add slowwait functions to wait for some operations that may need a long time
to finish. The busywait executes the cmd too fast, which is kind of wasting
cpu in this scenario. At the same time, if shell debugging is enabled with
`set -x`. the busywait will output too much logs.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index a7ecfc8cae98..db3688f52888 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -37,6 +37,32 @@ fi
 
 source "$net_forwarding_dir/../lib.sh"
 
+# timeout in seconds
+slowwait()
+{
+	local timeout=$1; shift
+
+	local start_time="$(date -u +%s)"
+	while true
+	do
+		local out
+		out=$("$@")
+		local ret=$?
+		if ((!ret)); then
+			echo -n "$out"
+			return 0
+		fi
+
+		local current_time="$(date -u +%s)"
+		if ((current_time - start_time > timeout)); then
+			echo -n "$out"
+			return 1
+		fi
+
+		sleep 0.1
+	done
+}
+
 ##############################################################################
 # Sanity checks
 
@@ -478,6 +504,15 @@ busywait_for_counter()
 	busywait "$timeout" until_counter_is ">= $((base + delta))" "$@"
 }
 
+slowwait_for_counter()
+{
+	local timeout=$1; shift
+	local delta=$1; shift
+
+	local base=$("$@")
+	slowwait "$timeout" until_counter_is ">= $((base + delta))" "$@"
+}
+
 setup_wait_dev()
 {
 	local dev=$1; shift
-- 
2.43.0


