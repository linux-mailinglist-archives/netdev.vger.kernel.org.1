Return-Path: <netdev+bounces-183578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8562A91135
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A67E190764B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C5E1DDA39;
	Thu, 17 Apr 2025 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hkUrl3Li"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924331AA1C9
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744853596; cv=none; b=SWYp6WQIHnSJZiyJZtISuMV+3Cvk1PeJK/Xq3/uNJV9phepnaGXHat3VHzw/Wtg08Cm8+gxAs2jiQR2NOCs8P2vBupXkzzrL+DBw16QxzIg/6z7ah2xRbt15GshUurU+NXgV24YZJSdaIqc+IurQwsuLjG6sbJdvULvi7iQY8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744853596; c=relaxed/simple;
	bh=HDQGG1Q34BlSkCWW84cNeWYaQgfA3isd36S41ZwwwX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tp2IZdqUfkY/1rp3t2qjFLvvp9xUouwpFfKXs8lFWrQvzAEKyf+TIVewYO1Kw1cJUKYCqJtqL0I2WjlcRbfn+E4zVgMDT/s0CC7DdosE6BTxxtaBzaEgOHGP3FKC406xhinIZtyApe8WcF0dkVljI+5s3HHVq1iwlG6v7ui+25k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hkUrl3Li; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-226185948ffso2893855ad.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 18:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744853593; x=1745458393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9lrbIvu6zRRiCj4HgSRrtBo19PyxJ2njnhqzeLily8=;
        b=hkUrl3LiEJHREHfPNkhc2sQgCARPtZWI8yljzopy2FWFpAPbqq4sKtNwsLZe5pvUE3
         9IT5cOffJqq0SXyWpZlcz1TX5BHxwDA0KtUXi24A2/sgRUsc2a+NGQYFDyb8aKySkiy7
         vILEHcsZod/awwSFn7Z8ixz0BG4KkSowIUvmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744853593; x=1745458393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9lrbIvu6zRRiCj4HgSRrtBo19PyxJ2njnhqzeLily8=;
        b=pA0ywbZExI4d03dJjzIZQZIafRsuJOysK+arfrck3Yp/98qTVmAb4jRj4W0Y21xJ6k
         flT0XEWMI6cW9yt+ZmnciXwzck/lLG6Qaom0tzMnUN1vvt0fXF/bRusHH4pjTYOMO8wi
         vaxUcdpCWWAc7juEW4M+S7ksDf6OeSFLpWepH56dGc1moZP8Chy11FczABNbvk8MkVOs
         9kFxThPnXtg9kf3dMrJ7pjrKLJUMJcIhtgiV0UkckOzHgXYcb4adjFW2UHX+CeAZ6L5m
         5k1F1KpUnRyB596cFKlgeSSRheY4F3kw9Ib1nlJQqz9kRGd7Av5LPzybJcYr95+fbQ2W
         CKrw==
X-Gm-Message-State: AOJu0YwtQ0nVLBparCrbZ0LFJ1gbTbEVrva0HXV9zyAwctGzsXxMlGgR
	gIf7+iWYHavqCS3zPnfDi23++tW2rmOO4DAHgFyO0fKP6AGZnAbNQ6BqbnvSavC/nPUW71D7yIQ
	tP3cv6KZEMFq9wo993xzDzvn3rxXwO1BeqkOrX/kd0aAYb81r2f9RHKkxqfJnOV5sa9UDajZnn2
	DHJE4MSC4FHC7gA+VtXeRWTvJAD+8vYDHC32Q=
X-Gm-Gg: ASbGnctclFE5UpsXLtP6o/Ab6JPEctvBSacTHIW3/vNFy5ch/nswiYdO0kvz10Nq+Qi
	i+W7t38VWgxJvHjcVNgLs/VsyEX9jPx2branbbgjQF3frSOopGmzP0owODvl2T9iAFXevY6/ANz
	JMMMZ8eqP93Noj11Oji8gsSL3ussIiBCU/yo9ge9mhh/PT1GaRCKQgbmbgc2U2tvUTjwwZlxpng
	dDfHrMg6shcshdldd5ZYo3MZjQr0bOL4PhyVQ/xU4x5VM7z7GY8fLPWiJVAkbF/S8RKvf0arBfL
	Y+8MT5BT6RXr4UYAUbsF70RSxATnK1HXEhAsNTlLPu0UL+O3
X-Google-Smtp-Source: AGHT+IGIfvnYetCCtpkkTem0fvDPcVdKvorATj17pj9pyflpstgaWD/lkjveVAKVWM6ThAFzVxniww==
X-Received: by 2002:a17:902:d4ce:b0:220:c63b:d93c with SMTP id d9443c01a7336-22c3598533cmr61830925ad.44.1744853593562;
        Wed, 16 Apr 2025 18:33:13 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef11c7sm21349505ad.37.2025.04.16.18.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 18:33:13 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Xiao Liang <shaw.leon@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2 3/4] selftests: net: Allow custom net ns paths
Date: Thu, 17 Apr 2025 01:32:41 +0000
Message-ID: <20250417013301.39228-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417013301.39228-1-jdamato@fastly.com>
References: <20250417013301.39228-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend NetNSEnter to allow custom paths in order to support, for
example, /proc/self/ns/net.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 tools/testing/selftests/net/lib/py/netns.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/netns.py b/tools/testing/selftests/net/lib/py/netns.py
index 8e9317044eef..8d5c26317cb0 100644
--- a/tools/testing/selftests/net/lib/py/netns.py
+++ b/tools/testing/selftests/net/lib/py/netns.py
@@ -35,8 +35,8 @@ class NetNS:
 
 
 class NetNSEnter:
-    def __init__(self, ns_name):
-        self.ns_path = f"/run/netns/{ns_name}"
+    def __init__(self, ns_name, ns_path="/run/netns/"):
+        self.ns_path = f"{ns_path}{ns_name}"
 
     def __enter__(self):
         self.saved = open("/proc/thread-self/ns/net")
-- 
2.43.0


