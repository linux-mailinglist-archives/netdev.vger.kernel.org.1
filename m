Return-Path: <netdev+bounces-241019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34478C7DA51
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 01:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A0CC352097
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 00:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F235E1FE44B;
	Sun, 23 Nov 2025 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="G2mN6bKt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3F11E98E6
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763859076; cv=none; b=kc/NJuGkZQUrozaju9yh52AWVlL133NUoV7wc3tnqjMJywUTJU9TCJar+McyWAeeC5Inbx0E8yae3lr+yz4UrzippNgfDN6jtq1ShOq2AkQA+dQtNJOSQTgqwnfqj/1DL23qB6pU4vAbmRKOrVi5+uhpRzwyI86kxCDjcjTAR18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763859076; c=relaxed/simple;
	bh=qrY8Tpl5TTW7dSmUTEJCOauiNplWpMukObVmshUbFkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwUNNHxyF0947reWZ3wmLuEvgKZXx+17iSLXlepbwjzOFr1XqLsBDk5xADQNrFNIp0q5hyc8UXVaaqBaxCjJiB9kEDpkDTVHFrfgVNeOXn2Hv+Wgwkbx9FlaQ9k2dwkH0oHzGN+nmFShxTLppuIjdix0/GcDLjEIAnhs3mE7EKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=G2mN6bKt; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-44fe903c1d6so402004b6e.0
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 16:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763859074; x=1764463874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0hWO0J0upvPj7bzue6l+qEj4jI2xK1SceHxrggYaoI=;
        b=G2mN6bKtItewsJhNXOtEx76wv4XGVtnTB9JTK7meQMmxGxFmbJXyBXmCNWNMYZKkkI
         ERt3S2oQUwpRyQ3gjg1lLGA25ttgAOAltUzOv/G5NQRHcdQJq/EeOLaa8MYzZ60dNh17
         bu+qbI1dW+1C1SO4XBHuSPXYw/0tuNyUDEcdnmu10TniXH7CNS6FF9gmlGb6gWDArn/4
         zQ05Tt0Np1AoNwSLlABo8lRTiG9LSfig/08bp/a3R7Tg9HtC29IpgjdFdNsS0dvBxmA+
         SJy2bQxl7M09sJS+BpyAwmuHBYygW2pPtA9imnzqHH19pJf8P/CRuwEPeR3/azhlIAUK
         0lIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763859074; x=1764463874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b0hWO0J0upvPj7bzue6l+qEj4jI2xK1SceHxrggYaoI=;
        b=nDNSKcHIMQgFkzZb0D1+uy0BmKm9QQA+HJPZnzXfKTJzgGWL04UwWAhsokJPt/3f8K
         /3HWsQvbwsy+hNtdERa0+DreRDAHdL9xSFU4/3s+es3rN49Sdsf3ktk5v4gs4n38HuV8
         QVBFbrVzXvH1gcYd2latG6ZyGTtA/nqQsD5ebKhCocrccaoWuSIrZuUypMk1kAyfuAhT
         QASsd+PGiyynTdluPwGVcMeDiZfpdnNqZj0wMiu3aD7Vxb+5PgwhsBNRKQK/SjnE2/lM
         X9etOTbDA01xV3qjKULi5xlI6Lvjouk09HiUNPCMKDM6TUUYd9kUpg2gfIoC6EhRXdbo
         ExFg==
X-Gm-Message-State: AOJu0YyMEs0SvWCPyZa6rVsrQXvK24dq3UW9GBGyNvW/ZUsGNB0vRH6j
	/nsE2lAmQobCYSm8n00s6watUFvd5rewA8wGGcQTC0GcMkdh/6SmeMDNuj0DgZSuu1jrBAX0NAB
	9VQ+C
X-Gm-Gg: ASbGncsvniZyB12DJ1JdLNMkKRFRMBn4BYi1Vd9PHbilU+FtFgaCRuxabyxtYMp6iY2
	xx6j5AOWsxOgaceUH7nD/pcZA3u9ouWmZQxrSDUMKOaRKEwtKy+LFX39coyoyGS4kjCQGQb12kR
	8fzLE5DqusxQb1y9HzcrlRqoZ4IY/7/A0vFFCkhqlv36rxFsT/stU6678AYRtVJEF8+0WEd+2Er
	ZH3vz2hIxToX4MnwFkwdVFa14lAjp7VdtqhR4LFm7SdxPqUFI+P/2zzHmqXCwxwShGVeseDjNZk
	ZvU+RSrsgJ77OvTOLd4H3UMtOdXUBK31GGn9eF0qDJusSnCFGsYNsvyj/iF2Q8qgoE/JG8lSYDn
	d2+qH5B39GvSu3aftwoMMjPKpdSrpo1CWWL3TsiGuSesGAfi0VK/522d6CicXAqWSphdLA502Pq
	upQkgs8epXjtg2zcRkjBR8pM/JNIcwFzscT6UmhCyfIYGV9+qpxDSoF9o8Mjndug==
X-Google-Smtp-Source: AGHT+IGvCxEuPPh9T5QKv0d3f0mZk06vAEtoy8sCJX3/kdsavcasfr5b5JhPtreej2NC6f5HJ+jQ8g==
X-Received: by 2002:a05:6808:6509:b0:450:760b:cc9e with SMTP id 5614622812f47-451159ca965mr2417161b6e.27.1763859074395;
        Sat, 22 Nov 2025 16:51:14 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:2::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-450ffe67840sm2748002b6e.8.2025.11.22.16.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 16:51:14 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next v2 3/5] selftests/net: add LOCAL_PREFIX_V{4,6} env to HW selftests
Date: Sat, 22 Nov 2025 16:51:06 -0800
Message-ID: <20251123005108.3694230-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251123005108.3694230-1-dw@davidwei.uk>
References: <20251123005108.3694230-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expect netkit container datapath selftests to have a publicly routable
IP prefix to assign to netkit in a container, such that packets will
land on eth0. The bpf skb forward program will then forward such packets
from the host netns to the container netns.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/drivers/net/README.rst    | 7 +++++++
 tools/testing/selftests/drivers/net/lib/py/env.py | 1 +
 2 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index eb838ae94844..b94e81c2e030 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -62,6 +62,13 @@ LOCAL_V4, LOCAL_V6, REMOTE_V4, REMOTE_V6
 
 Local and remote endpoint IP addresses.
 
+LOCAL_PREFIX_V4, LOCAL_PREFIX_V6
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Local IP prefix/subnet which can be used to allocate extra IP addresses (for
+network name spaces behind macvlan, veth, netkit devices). DUT must be
+reachable using these addresses from the endpoint.
+
 REMOTE_TYPE
 ~~~~~~~~~~~
 
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 8b644fd84ff2..4004d1a3c82e 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -196,6 +196,7 @@ class NetDrvEpEnv(NetDrvEnvBase):
     def _check_env(self):
         vars_needed = [
             ["LOCAL_V4", "LOCAL_V6"],
+            ["LOCAL_PREFIX_V4", "LOCAL_PREFIX_V6"],
             ["REMOTE_V4", "REMOTE_V6"],
             ["REMOTE_TYPE"],
             ["REMOTE_ARGS"]
-- 
2.47.3


