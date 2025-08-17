Return-Path: <netdev+bounces-214376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCD7B2934C
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 15:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD041890146
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 13:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB8628A415;
	Sun, 17 Aug 2025 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5jzByhh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B9C28A40E;
	Sun, 17 Aug 2025 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755438008; cv=none; b=JT3UYIeaaIEL6cptjlxJp7nGPeM/aXXbveCFZLrCmmzGlVHStFI6FNHv6HPxgcl+2HJapfRd3e4TaoJ57c2uE/qJLb7y+elVuTxf/ttIQQuAAFvA0BgbvoxzPAJ5pkMQSPbX+pnNk41xEFrHiG9TKGFLiJ//V5PfFHF8uLXpoQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755438008; c=relaxed/simple;
	bh=vdRmvTWdoza3fNHMicOni1l4ECoiTcTwv2D+h8qGj0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uCjeqP2wFwr8zYQukWYxJCyXNnWahr6/NhkNoN/jXdtK1URP/Lcu41q4vtZyssx0nHUHf5whalExpjJ8nJIKn/L63Du/y37FfuObCsU3dZra+QcdpMY9uwxnSU6NziL1RTHmPE/p5B1D4eiPSuXCgIlxIUWAo/ex+2+Tpsl5iIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5jzByhh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b05a59fso23817905e9.1;
        Sun, 17 Aug 2025 06:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755438005; x=1756042805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F4ynnoi258CpFVnS4df600btHs5n7RjFR5qJiRm6JSA=;
        b=b5jzByhhSZqKssqhqIt4wcf0SqPx2eP3bzJ7vMrceihWI+4O1jkFg2Jl+CRU0mstqC
         AmRJ4Z5aOjfcYq3JikhByGQliyWAOaAJJN9oiua3yeBYry/h3W8WJfGum/98XMlfonHn
         B1c0JjeVh3XiJqX3ARsIqd+tjUk0lgHIQsOSxwGbWxTM43ODK5zB84ctGgtSoqcEtXc9
         jSxG4a3PE2HWZJgCb0NpBInVcGK/y/hoSAFpIrlVBanTqD7B7h6F0imJOmdqaPm+MCpA
         GH+E5A4ok8dg+OG2J8TaAQbuWPkoyq9qUysDkx4ZCpc0ED+1Ml/PId2wC0PUYvDcxFFc
         KjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755438005; x=1756042805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4ynnoi258CpFVnS4df600btHs5n7RjFR5qJiRm6JSA=;
        b=Bj9CiX9LtW3cQqOhCmItmK52asjYtp+IcrfbbefdtDoGPPIFaZQQLdFxSlAK54Hnv4
         licfH7eF/MP9boFDMGanrugNUhTLxlXqIJcAdHpJ/m/XAXt22ZtBYIMey30Y4glyhWK2
         2og8eCaJ2NGUomwHAfg8jFz4+Cr30oeMKU25Nn0vNKvCLt3VifbkD57ydArWEsrELngo
         dAOhNQvHtcQ3BY5djE72GKP91z96uKgd+aut1TZuMU22cgmd8LP0d69UrFR1+Mg2vWq/
         mErmTQXk0LgOd66iy/MO65xdFY/bZkmnSs6IIE1mpdnkOgRLY477/s02OgMZsV6xULcp
         zBIA==
X-Forwarded-Encrypted: i=1; AJvYcCUc3mKeSctAYenuYDm1YcOKL/CF6P6wLBa7BAEAgoDLcXZgQZbL27gcbS7MB6nWJBqjozZOeaLNIFpt0FY=@vger.kernel.org, AJvYcCXodg5wFIm9vLv0WklE31sk4T9JzdwzxXD/wCQAaoUPxvG0HhlAWhUY45eLR+HgHl1FIGmMIik4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs5vD+I9HY/qBMuVUgywQH9rVKv9Yh39qTH1UmuoPVzIJYvTio
	3LMHKMJsDahAesCKWliCNvxYuEdZIsi5dsoyrsWOJ4NTrvVnChZ0b+ke
X-Gm-Gg: ASbGncsV2OJHM9P6NfhAvxEEsUlDrFkCRPId0Uvy/n/euF7k1vHNgQzCFiIlelLJwTN
	tYf4g43BZQmwufZkdtxGRkyLoWfr8FhF31UZGMbWJjtivzR7HZizSr7A0AUnbwwA8QmvGrdofpN
	ik1fEjsiF75NXlh2T6m4m9EshH4lyHPzmlm7u82uXNakIneBJOvAWxHRv83Fo4lru0bUv1SMVZx
	uLGcfyXxkrxHqltXKn5DXDeI7BB3Ezo275ArVB5oiQxiqPIF35Xm8i6AN817vezpGf7+PTjcSXt
	cbiPTdFjba+ooDLlQ3YDw2glf8/+F3R2r4M90N4pG2YDlN65eeC/6ShqEb5dYyn1X1VZBDZEf7a
	GgqrtF7Qpf3T62gV3RGouMXbR2Vu8F380b7bbbvbyeAVW1hdifRovWHw=
X-Google-Smtp-Source: AGHT+IGTC/8/V/5KrXhKJiBPuLpWRayK6m1nNRY5wpWnVtMyfeEwCsf6Aru40L/82aBG4ePZnFgmLw==
X-Received: by 2002:a05:600c:1d09:b0:459:dd34:52fb with SMTP id 5b1f17b1804b1-45a267445c6mr49032545e9.12.1755438004982;
        Sun, 17 Aug 2025 06:40:04 -0700 (PDT)
Received: from localhost.localdomain ([2001:16a2:7c29:1800:5042:3654:78fa:c895])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45a22319780sm92101005e9.7.2025.08.17.06.40.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 17 Aug 2025 06:40:04 -0700 (PDT)
From: Osama Albahrani <osalbahr@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Osama Albahrani <osalbahr@gmail.com>
Subject: [PATCH] net: Fix broken link to cubic-paper.pdf
Date: Sun, 17 Aug 2025 16:39:45 +0300
Message-Id: <20250817133945.13728-1-osalbahr@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use first Wayback Machine snapshot

Signed-off-by: Osama Albahrani <osalbahr@gmail.com>
---
 net/ipv4/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 12850a277251..7f796c8cb765 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -499,7 +499,7 @@ config TCP_CONG_CUBIC
 	help
 	  This is version 2.0 of BIC-TCP which uses a cubic growth function
 	  among other techniques.
-	  See http://www.csc.ncsu.edu/faculty/rhee/export/bitcp/cubic-paper.pdf
+	  See https://web.archive.org/web/20060103185400/http://www.csc.ncsu.edu/faculty/rhee/export/bitcp/cubic-paper.pdf
 
 config TCP_CONG_WESTWOOD
 	tristate "TCP Westwood+"
-- 
2.39.5 (Apple Git-154)


