Return-Path: <netdev+bounces-233013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D045FC0AF68
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 18:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43018349BC0
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 17:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B93C23EAB4;
	Sun, 26 Oct 2025 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV0C/Lji"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CCD2222AA
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761500830; cv=none; b=FnESNoPbQeA9kwzQhXxNwIYnrrACs5XrTeIfRVdhUKIGlPatOEIGWQ5u01qc7nDkdMe8B08OpO9ZFpF4EZS8F3yVqfoZpdpF6hgpOoesiH7na/H3oZuFqfY7PaWUuQGxYauG6xcIt/dVzOiaV8kjJkZXgzJpJGTQbpxv7RmeVtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761500830; c=relaxed/simple;
	bh=a+5TfOJqZaa7uINUuLkBAnYsuEfoCPkWzUliS6FwM7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jvXv5RSh9hPEF70rXDgyw3w+7ZL8qrTCqosb4Yjtz+efe6rXikUpmIN27wblCijZaWxGZSSQmBHvFzRaVeJjbzXYx4BUxeBa8sc+4WCcaRydH/kcPds1f1nVckN/64hdeIz16hRQZ1tpujp+M2WkxoI5SXLXahlQQRaWHXxZbIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV0C/Lji; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b6ce696c18bso3530453a12.1
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 10:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761500827; x=1762105627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTlRnqQ5NYA26/eQEooThXZv5VwSOGxJEUEP1dj3fhY=;
        b=KV0C/LjiZP6gTyvZ+exzxXK9vCzPEreIHAyBr+17kfxupcEcFvP7xRof15hazqiaLU
         ZtIAGM0Op+fO24lNEMrNfbx/yo3MOqRhVbOqsB84YVZJeS4i7VcLlvrCF7qepThcxLhC
         jKBIMbsogONHJaY9qveUTIPplz1NTdOeXAXeSwziely8wVaN2rQCwZ5PRTRPIErEUaXf
         NmJ89+Aw7sOfhIGTQp11Cb+EOfcUOlCB9CthIAvs1jLR7k0LZHlrAM/O8WPZ9FZUIHjw
         L2MEV8sBkzeoEfPnvUwfjjB7ZVc7dj5Oe6LFkbdz6ZrfZZjgjkKGqZNSuHsXlUn7Foh3
         JHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761500827; x=1762105627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTlRnqQ5NYA26/eQEooThXZv5VwSOGxJEUEP1dj3fhY=;
        b=iQkpSVKmiaiKu1NF8rYjUGjF2iSuyYwsheaFo6HK+5zJKYKU8BPzgmCggiopDiU9B7
         bepEWYajWtc+nHc9K4yVG+EITP/cX+e/78TDGh76GcTLvirTqN5YvXKujR4jFzE6MYhm
         DI2FNxNJyiozrT/ArFgQXRlHnDNkAPjGKOWIyUx088Ccb0zqV9LsL2t0R8McBKWp4iLc
         yLTnosPe1POVjh7YteJluTU4g6776+3uhlIcu7CK26V0OLVOgv4bWNz+X82T7u2pSpJ1
         FjtVxEep3kE2pDj0UGZ9YIE1WColL2C92zszHi46l6NgKekk+CoF/jRIP5gTgyb/Z12k
         Xt8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXE8UYewEasgWXw+jTgmMLFLv3I++EtgNgdn72zOT8YoBXeOD7pDtPCeykY0mRiUW9aiOtuH2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWPeAgpQLTsbVr/vSWWYkatM84H5t8iH21Z6e6ru4qCeyCPtrA
	uZMCPKHoAVbKqsNRdwPO8G3gn0I7VfyfaR90dDFVOvfHqa9LFCRVhDjv
X-Gm-Gg: ASbGncvcymrJCm3UtYawmgXQvgDaPjpgifvugQN4BwWzpM0D3ENKn9xmMovKzXKP0Fm
	dV3u7buul/COz90vqggEwbqDPRBmlGrXtgiXTQtW14XXmn8EWlL2NsdWsOTbO9oFoEDltI/E7Gs
	b0yEFxHQUelUoXJwDUv163bllRYifM6loKRmhg2VL+PHgRexz6QuUTxHAfHzma+8Fklcn4Cs7g+
	mlMf+cD6EnRt/FQ4rytTR7rXoc+1CILpXir9x2s5+SnnaYL0tCQp6YRRFLRM4XJ8g3szBvc2KLL
	hRkdh4SESioARsX164cA8Ed9wBNfkU6DR94FDqS4oDWrC4oEroImBUTVUD3EK65O4xeybJUd85s
	ESjzOpC6F6wSItkAnr72BWRkjThab93gDEf6MYFTdgz1D+M/dTA5NDjVY/3EUuE1l1Hd4xvsWxl
	W7dW5Z5+qtPWlACxbTI0Ql6Am2A5vTDA==
X-Google-Smtp-Source: AGHT+IGwYCSe19Ty4P2Kg68LQK9vteTSxPeeGBo2iswWXXEumD1EpQASl9RMMGaFry0bwrT+Y8+yLw==
X-Received: by 2002:a17:903:41c6:b0:25d:37fc:32df with SMTP id d9443c01a7336-290cb65c914mr503829555ad.47.1761500827212;
        Sun, 26 Oct 2025 10:47:07 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09855sm55131445ad.30.2025.10.26.10.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 10:47:06 -0700 (PDT)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH] selftest: net: fix socklen_t type mismatch in sctp_collision test
Date: Sun, 26 Oct 2025 23:16:49 +0530
Message-ID: <20251026174649.276515-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Socket APIs like recvfrom(), accept(), and getsockname() expect socklen_t*
arg, but tests were using int variables. This causes -Wpointer-sign 
warnings on platforms where socklen_t is unsigned.

Change the variable type from int to socklen_t to resolve the warning and
ensure type safety across platforms.

warning fixed:

sctp_collision.c:62:70: warning: passing 'int *' to parameter of 
type 'socklen_t *' (aka 'unsigned int *') converts between pointers to 
integer types with different sign [-Wpointer-sign]
   62 |                 ret = recvfrom(sd, buf, sizeof(buf), 
									0, (struct sockaddr *)&daddr, &len);
      |                                                           ^~~~
/usr/include/sys/socket.h:165:27: note: passing argument to 
parameter '__addr_len' here
  165 |                          socklen_t *__restrict __addr_len);
      |                                                ^

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
 tools/testing/selftests/net/netfilter/sctp_collision.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netfilter/sctp_collision.c b/tools/testing/selftests/net/netfilter/sctp_collision.c
index 21bb1cfd8a85..91df996367e9 100644
--- a/tools/testing/selftests/net/netfilter/sctp_collision.c
+++ b/tools/testing/selftests/net/netfilter/sctp_collision.c
@@ -9,7 +9,8 @@
 int main(int argc, char *argv[])
 {
 	struct sockaddr_in saddr = {}, daddr = {};
-	int sd, ret, len = sizeof(daddr);
+	int sd, ret;
+	socklen_t len = sizeof(daddr);
 	struct timeval tv = {25, 0};
 	char buf[] = "hello";
 
-- 
2.51.0


